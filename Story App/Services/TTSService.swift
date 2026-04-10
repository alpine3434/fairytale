import Foundation
import AVFoundation
import Combine

class TTSService: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    static let shared = TTSService()

    private let synthesizer = AVSpeechSynthesizer()

    @Published var isPlaying: Bool = false
    @Published var currentWordRange: NSRange = NSRange(location: 0, length: 0)
    @Published var currentParagraphIndex: Int = 0
    @Published var currentText: String = ""

    private var paragraphs: [String] = []
    private var paragraphIndex: Int = 0
    var onFinish: (() -> Void)?

    override private init() {
        super.init()
        synthesizer.delegate = self
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio,
                                                            options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
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
        currentParagraphIndex = 0
    }

    func togglePlayPause(paragraphs: [String], language: AppLanguage, speed: Float) {
        if synthesizer.isSpeaking {
            if synthesizer.isPaused {
                resume()
            } else {
                pause()
            }
        } else {
            speak(paragraphs: paragraphs, language: language, speed: speed, startAt: paragraphIndex)
        }
    }

    private func speakNext(language: AppLanguage, speed: Float) {
        guard paragraphIndex < paragraphs.count else {
            isPlaying = false
            onFinish?()
            return
        }
        let text = paragraphs[paragraphIndex]
        currentText = text
        currentParagraphIndex = paragraphIndex

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language.ttsCode)
        utterance.rate = max(AVSpeechUtteranceMinimumSpeechRate,
                             min(AVSpeechUtteranceMaximumSpeechRate, speed))
        utterance.pitchMultiplier = 1.1
        utterance.postUtteranceDelay = 0.4
        synthesizer.speak(utterance)
        isPlaying = true
    }

    // MARK: - Delegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.currentWordRange = characterRange }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.paragraphIndex += 1
            let lang = AppSettings.shared.language
            let speed = AppSettings.shared.readingSpeed
            self.speakNext(language: lang, speed: speed)
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didPause utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.isPlaying = false }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           didContinue utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.isPlaying = true }
    }
}
