import SceneKit
import AVFoundation

public class MainController:UIViewController {
    private let scene:SCNScene = SCNScene()
    private let sceneView:SCNView = SCNView()
    private var solarSystem:PlanetarySystem?
    private var infoWindow:UIImageView = UIImageView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let scene = self.scene
        let sceneView = self.sceneView
        sceneView.scene = scene
        
        // Configuring scene
        let camera = placeCamera(toScene: scene)
        camera.position.y += 10.0
        camera.eulerAngles.x -= 0.225
        camera.position.z += 7.0
        camera.position.x += 1.0
        addLight(toScene: scene)
        addAmbientLight(toScene: scene)
        
        // Configure background
        sceneView.frame = CGRect(x:0, y:0, width:1000, height:800)
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = UIColor.black
        let stars = SCNParticleSystem(named: "Particles/StarParticles.scnp", inDirectory: nil)
        if let particles = stars {
            camera.addParticleSystem(particles)
        }
            
        // Add solar system
        self.solarSystem = PlanetarySystem(named: "Solar system", withPlanets: ["mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"], systemScene: scene)
        
        // Add recognizer for tap gesture to each Planet
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        sceneView.addGestureRecognizer(tapGesture)
        
        // Add info button
        let infoButton = UIButton(frame: CGRect(x: 675, y: 50, width: 50, height: 50))
        infoButton.setBackgroundImage(UIImage(named: "Icons/info-button.png"), for: .normal)
        infoButton.addTarget(self, action: #selector(self.showInfo), for: UIControlEvents.touchUpInside)
        sceneView.addSubview(infoButton)
        
        // Add info text
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 610, height: 350))
        infoLabel.text = "Textures: www.solarsystemscope.com\nBackground music: Nicolai Heidlas (Pulsar)\nSound effects: drzhnn"
        infoLabel.font = UIFont(name: infoLabel.font.fontName, size: CGFloat(20.0))
        infoLabel.numberOfLines = 4
        
        // Add info window
        self.infoWindow = UIImageView(image: UIImage(named: "Icons/popup-window.png"))
        self.infoWindow.frame = CGRect(x: 70, y: 175, width: 640.0, height: 400.0)
        self.infoWindow.alpha = 0
        self.infoWindow.addSubview(infoLabel)
        sceneView.addSubview(self.infoWindow)
        
        self.view = sceneView
    }
    
    @objc private func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        let location = gestureRecognize.location(in: self.sceneView)
        let results = sceneView.hitTest(location, options: [:])
        if results.count > 0 {
            let result = results[0].node
            let viewController = PlanetStructure()
            viewController.preferredContentSize = CGSize(width:1000, height:800)
            if let solarSystem = self.solarSystem {
                if let planet = solarSystem.planetNodes[result] {
                    viewController.ofPlanet = planet
                    self.present(viewController, animated: true)
                }
            }
        }
    }
    
    @objc private func showInfo() {
        if self.infoWindow.alpha == 0 {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                self.infoWindow.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 1.5, animations: { () -> Void in
                self.infoWindow.alpha = 0
            })
        }
    }
}
