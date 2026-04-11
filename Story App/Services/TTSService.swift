import Foundation
import AVFoundation
import Observation

@Observable
final class TTSService: NSObject {
    static let shared = TTSService()

    // Observable properties (UI'ın takip ettiği)
    var isPlaying: Bool = false
    var currentWordRange: NSRange = NSRange(location: 0, length: 0)
    var currentParagraphIndex: Int = 0

    // Observation'dan gizlenecek internal state
    @ObservationIgnored private let synthesizer = AVSpeechSynthesizer()
    @ObservationIgnored private var ttsDelegate: TTSDelegate?
    @ObservationIgnored var paragraphs: [String] = []
    @ObservationIgnored var paragraphIndex: Int = 0

    override private init() {
        super.init()
        let d = TTSDelegate(owner: self)
        self.ttsDelegate = d
        synthesizer.delegate = d
    }

    // MARK: - Public API
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
    }

    func togglePlayPause(paragraphs: [String], language: AppLanguage, speed: Float) {
        if synthesizer.isSpeaking {
            if synthesizer.isPaused { resume() } else { pause() }
        } else {
            // Eğer hiç başlamadıysa baştan, devam ediyorsa kaldığı yerden
            let startAt = self.paragraphs.isEmpty ? 0 : paragraphIndex
            speak(paragraphs: paragraphs, language: language, speed: speed, startAt: startAt)
        }
    }

    func speakNext(language: AppLanguage, speed: Float) {
        guard paragraphIndex < paragraphs.count else {
            isPlaying = false
            return
        }
        currentParagraphIndex = paragraphIndex

        let utterance = AVSpeechUtterance(string: paragraphs[paragraphIndex])

        // Sesi bul, yoksa default kullan
        if let voice = AVSpeechSynthesisVoice(language: language.ttsCode) {
            utterance.voice = voice
        }
        utterance.rate = max(AVSpeechUtteranceMinimumSpeechRate,
                             min(AVSpeechUtteranceMaximumSpeechRate, speed))
        utterance.pitchMultiplier = 1.1
        utterance.postUtteranceDelay = 0.3

        synthesizer.speak(utterance)
        isPlaying = true
    }
}

// MARK: - Delegate (NSObject'ten ayrı tutuldu)
final class TTSDelegate: NSObject, AVSpeechSynthesizerDelegate {
    weak var owner: TTSService?

    init(owner: TTSService) { self.owner = owner }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.owner?.currentWordRange = characterRange
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            guard let svc = self.owner else { return }
            svc.paragraphIndex += 1
            let lang = AppSettings.shared.language
            let speed = AppSettings.shared.readingSpeed
            svc.speakNext(language: lang, speed: speed)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didPause utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.owner?.isPlaying = false }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didContinue utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.owner?.isPlaying = true }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.owner?.isPlaying = false }
    }
}
