/*:
 # Celestial
 ![Playground Icon](Icons/intro-logo.png width="200" height="200")
 
 This is a quick overview of **Celestial** — an interactive Swift playground for exploring the Solar system and Planetary structures. You may build and interact with it in the latest release of XCode. The list of modules and frameworks I've used include:
 
 * **SceneKit:** Creation of 3D nodes and objects.
 * **UIKit:** Fade-in, fade-out, rotate and scale effects in the introduction screen.
 * **AVFoundation:** Background music and sound effects.
 */

// Gabriel D'Luca
import SceneKit
import PlaygroundSupport
import AVFoundation

var player:AVAudioPlayer = AVAudioPlayer()
do {
    let audioPath = Bundle.main.path(forResource: "Music/pulsar", ofType: "mp3")
    try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
} catch {
    // ERROR
    print("Couldn't find background music file.")
}

player.prepareToPlay()
player.play()

let viewController = IntroController()
viewController.preferredContentSize = CGSize(width:1000, height:800)
PlaygroundPage.current.liveView = viewController
