import UIKit
import PlaygroundSupport
import AVFoundation

public class IntroController:UIViewController {
    private var storyCount:Int = 0
    private let story:[String] = ["The solar system consists of all the celestial bodies that lies within the gravitational pull of our sun.", "Every celestial body that moves around it in an elliptical orbit is considered a planet.", "You might be familiarized with many aspects of these planets, such as mass, size and mean temperature.", "However, in a structural scope, these planets are layered by many spherical shells. It's your mission to find out how they differ internally.", "Try to find a planet and click on it. Some actions you may perform include pinching in, pinching out, rotating and moving."]
    private var storytellingLabel:UILabel = UILabel()
    private var soundEffectPlayer:AVAudioPlayer = AVAudioPlayer()
    private var exploreButton:UIButton = UIButton()
    private var nextButton:UIButton = UIButton()
    
    override public func loadView() {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 1000, height: 800))
        self.view = view

        do {
            let soundEffectPath = Bundle.main.path(forResource: "Music/confirmation", ofType: "mp3")
            try self.soundEffectPlayer = AVAudioPlayer(contentsOf:
                NSURL(fileURLWithPath: soundEffectPath!) as URL)
        } catch {
            // ERROR
            print("Couldn't find sound effect file.")
        }
        self.soundEffectPlayer.prepareToPlay()
        
        // Celestial logo
        let circularLogo = UIImageView(image: UIImage(named: "Icons/intro-logo.png"))
        circularLogo.frame = CGRect(x: 375.0, y: 375.0, width: 50.0, height: 50.0)
        view.addSubview(circularLogo)
        
        // Small blue rectangle
        let rectangle = UIView(frame: CGRect(x: 388, y: 390, width: 25.0, height: 25.0))
        rectangle.layer.cornerRadius = 7.0
        rectangle.backgroundColor = UIColor(red:0.52, green:0.93, blue:0.93, alpha:1.0)
        view.addSubview(rectangle)
        
        // Steve Jobs inspirational quote
        let firstQuote = addLabel(text: "❝ The only way to do great work", toView: view,
                                  color: UIColor.white, frame: CGRect(x: 230, y: 300, width: 350.0, height: 55.0))
        let secondQuote = addLabel(text: "is to love what you do. ❞", toView: view,
                                   color: UIColor.white, frame: CGRect(x: 230, y: 330, width: 255.0, height: 55.0))
        let quoteAttribution = addLabel(text: "— Steve Jobs —", toView: view,
                                        color: UIColor.white, frame: CGRect(x: 310, y: 400, width: 255.0, height: 55.0))
        
        // Create text
        storytellingLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 610, height: 350))
        self.storytellingLabel.text = self.story[self.storyCount]
        self.storytellingLabel.font = UIFont(name: storytellingLabel.font.fontName, size: CGFloat(20.0))
        self.storytellingLabel.numberOfLines = 3
        
        // Create popup window
        let popupWindow = UIImageView(image: UIImage(named: "Icons/popup-window.png"))
        popupWindow.frame = CGRect(x: 70, y: 175, width: 640.0, height: 400.0)
        popupWindow.alpha = 0
        popupWindow.addSubview(storytellingLabel)
        view.addSubview(popupWindow)
        
        // Create next button
        self.nextButton = UIButton(frame: CGRect(x: 70, y: 175, width: 640, height: 400))
        self.nextButton.setBackgroundImage(UIImage(named: "Icons/next-button.png"), for: .normal)
        self.nextButton.alpha = 0
        view.addSubview(self.nextButton)
        
        // Create explore button
        self.exploreButton = UIButton(frame: CGRect(x: 307.5, y: 630, width: 180, height: 90))
        self.exploreButton.setTitle("Explore", for: .normal)
        self.exploreButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: CGFloat(45.0))
        self.exploreButton.setTitleColor(UIColor.white, for: .normal)
        self.exploreButton.layer.borderWidth = 2.5
        self.exploreButton.layer.borderColor = UIColor.white.cgColor
        self.exploreButton.alpha = 0
        view.addSubview(self.exploreButton)
        
        // Animation chaining
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            circularLogo.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            rectangle.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) {
            UIView.animate(withDuration: 2.0, animations: { () -> Void in
                circularLogo.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            UIView.animate(withDuration: 2.0, animations: { () -> Void in
                rectangle.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.75) {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                firstQuote.alpha = 1
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                secondQuote.alpha = 1
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.75) {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                quoteAttribution.alpha = 1
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 11.5) {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                firstQuote.alpha = 0
                secondQuote.alpha = 0
                quoteAttribution.alpha = 0
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.25) {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                popupWindow.alpha = 1
                self.nextButton.alpha = 1
                self.nextButton.addTarget(self, action: #selector(self.continueStory), for: UIControlEvents.touchUpInside)
            })
        }
    }
    
    @objc func continueStory() {
        self.soundEffectPlayer.play()
        if self.storyCount + 1 >= self.story.count - 1 {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                self.nextButton.alpha = 0
                self.exploreButton.alpha = 1
                self.exploreButton.addTarget(self, action: #selector(self.explore), for: UIControlEvents.touchUpInside)
            })
        }
        self.storyCount += 1
        self.storytellingLabel.text = self.story[self.storyCount]
    }
    
    @objc func explore() {
        let viewController = MainController()
        viewController.preferredContentSize = CGSize(width:1000, height:800)
        self.present(viewController, animated: true)
    }
}
