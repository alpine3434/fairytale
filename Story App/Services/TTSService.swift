import Foundation
import AVFoundation
import Observation

// NSObject'ten AYRI - sadece delegate
private final class SpeechDelegate: NSObject, AVSpeechSynthesizerDelegate {
    var onWordRange: ((NSRange) -> Void)?
    var onFinish: (() -> Void)?
    var onPause: (() -> Void)?
    var onResume: (() -> Void)?

    func speechSynthesizer(_ s: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString r: NSRange,
                           utterance: AVSpeechUtterance) {
        DispatchQueue.main.async { self.onWordRange?(r) }
    }
    func speechSynthesizer(_ s: AVSpeechSynthesizer, didFinish u: AVSpeechUtterance) {
        DispatchQueue.main.async { self.onFinish?() }
    }
    func speechSynthesizer(_ s: AVSpeechSynthesizer, didPause u: AVSpeechUtterance) {
        DispatchQueue.main.async { self.onPause?() }
    }
    func speechSynthesizer(_ s: AVSpeechSynthesizer, didContinue u: AVSpeechUtterance) {
        DispatchQueue.main.async { self.onResume?() }
    }
    func speechSynthesizer(_ s: AVSpeechSynthesizer, didCancel u: AVSpeechUtterance) {
        DispatchQueue.main.async { self.onPause?() }
    }
}

// @Observable ile NSObject OLMADAN
@Observable
final class TTSService {
    static let shared = TTSService()

    var isPlaying = false
    var currentWordRange = NSRange(location: 0, length: 0)
    var currentParagraphIndex = 0

    @ObservationIgnored private let engine = AVSpeechSynthesizer()
    @ObservationIgnored private let delegate = SpeechDelegate()
    @ObservationIgnored private var queue: [String] = []
    @ObservationIgnored private var queueIndex = 0
    @ObservationIgnored private var currentLanguage: AppLanguage = .turkish
    @ObservationIgnored private var currentSpeed: Float = 0.45

    private init() {
        engine.delegate = delegate

        delegate.onWordRange = { [weak self] range in
            self?.currentWordRange = range
        }
        delegate.onFinish = { [weak self] in
            guard let self else { return }
            self.queueIndex += 1
            self.speakCurrent()
        }
        delegate.onPause  = { [weak self] in self?.isPlaying = false }
        delegate.onResume = { [weak self] in self?.isPlaying = true }

#if os(iOS)
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
        try? AVAudioSession.sharedInstance().setActive(true)
#endif
    }

    // MARK: - Public API

    func play(paragraphs: [String], language: AppLanguage, speed: Float, from index: Int = 0) {
        stop()
        queue = paragraphs
        queueIndex = index
        currentLanguage = language
        currentSpeed = speed
        speakCurrent()
    }

    func togglePlay(paragraphs: [String], language: AppLanguage, speed: Float, currentPage: Int) {
        if engine.isSpeaking {
            if engine.isPaused {
                engine.continueSpeaking()
                isPlaying = true
            } else {
                engine.pauseSpeaking(at: .word)
                isPlaying = false
            }
        } else {
            // Yeni paragraf veya devam
            let startIdx = queue.isEmpty ? currentPage : max(currentPage, queueIndex)
            play(paragraphs: paragraphs, language: language, speed: speed, from: startIdx)
        }
    }

    func stop() {
        engine.stopSpeaking(at: .immediate)
        isPlaying = false
        currentWordRange = NSRange(location: 0, length: 0)
        queue = []
        queueIndex = 0
    }

    func updateSpeed(_ speed: Float) {
        currentSpeed = speed
    }

    // MARK: - Internal

    private func speakCurrent() {
        guard queueIndex < queue.count else {
            isPlaying = false
            return
        }

        currentParagraphIndex = queueIndex
        let text = queue[queueIndex]

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: currentLanguage.ttsCode)
            ?? AVSpeechSynthesisVoice(language: "tr-TR")
        utterance.rate = min(max(currentSpeed, AVSpeechUtteranceMinimumSpeechRate),
                             AVSpeechUtteranceMaximumSpeechRate)
        utterance.pitchMultiplier = 1.05
        utterance.postUtteranceDelay = 0.35

        engine.speak(utterance)
        isPlaying = true
    }
}
