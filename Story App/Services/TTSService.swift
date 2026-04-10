import Foundation
import AVFoundation
import Observation

@Observable
final class TTSService: NSObject {
    static let shared = TTSService()

    private let synthesizer = AVSpeechSynthesizer()
    private var delegate: TTSDelegate?

    var isPlaying: Bool = false
    var currentWordRange: NSRange = NSRange(location: 0, length: 0)
    var currentParagraphIndex: Int = 0

    private var paragraphs: [String] = []
    var paragraphIndex: Int = 0

    override private init() {
        super.init()
        let d = TTSDelegate(owner: self)
        self.delegate = d
        synthesizer.delegate = d
        configureAudioSession()
    }

    private func configureAudioSession() {
#if os(iOS)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
#endif
    }

    func speak(paragraphs: [String], language: AppLanguage, speed: Float, startAt: Int = 0) {
        stop()
        self.paragraphs = paragraphs
        self.paragraphIndex = startAt
        speakNext(language: language, speed: speed)
    }

    func pause() {
        synthesizer.pauseSpeaking(at: .word)
        isPlaying = false
    }

    func resume() {
        synthesizer.continueSpeaking()
        isPlaying = true
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isPlaying = false
        currentWordRange = NSRange(location: 0, length: 0)
        currentParagraphIndex = 0
    }

    func togglePlayPause(paragraphs: [String], language: AppLanguage, speed: Float) {
        if synthesizer.isSpeaking {
            if synthesizer.isPaused { resume() } else { pause() }
        } else {
            speak(paragraphs: paragraphs, language: language, speed: speed, startAt: paragraphIndex)
        }
    }

    func speakNext(language: AppLanguage, speed: Float) {
        guard paragraphIndex < paragraphs.count else {
            isPlaying = false
            return
        }
        currentParagraphIndex = paragraphIndex
        let utterance = AVSpeechUtterance(string: paragraphs[paragraphIndex])
        utterance.voice = AVSpeechSynthesisVoice(language: language.ttsCode)
        utterance.rate = max(AVSpeechUtteranceMinimumSpeechRate,
                             min(AVSpeechUtteranceMaximumSpeechRate, speed))
        utterance.pitchMultiplier = 1.1
        utterance.postUtteranceDelay = 0.4
        synthesizer.speak(utterance)
        isPlaying = true
    }
}

// Separate delegate class to avoid @Observable + NSObject conflict
final class TTSDelegate: NSObject, AVSpeechSynthesizerDelegate {
    weak var owner: TTSService?
    init(owner: TTSService) { self.owner = owner }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.owner?.currentWordRange = characterRange }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            guard let svc = self.owner else { return }
            svc.paragraphIndex += 1
            let lang = AppSettings.shared.language
            let speed = AppSettings.shared.readingSpeed
            svc.speakNext(language: lang, speed: speed)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.owner?.isPlaying = false }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.owner?.isPlaying = true }
    }
}
