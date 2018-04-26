import SceneKit

public class PlanetStructure:UIViewController {
    private let scene:SCNScene = SCNScene()
    public let scnView:SCNView = SCNView()
    public var ofPlanet:CelestialBody = CelestialBody(named: "")
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let scene = self.scene
        let sceneView = self.scnView
        sceneView.scene = scene
        
        // Configuring scene
        let _ = placeCamera(toScene: scene)
        addLight(toScene: scene)
        addAmbientLight(toScene: scene)
        
        // Configure background
        sceneView.allowsCameraControl = true
        sceneView.frame = CGRect(x:0, y:0, width:1000, height:800)
        sceneView.backgroundColor = UIColor.black
        
        let intervals:[Double] = [1.5, 3.0, 4.5, 6.0]
        let xValues:[Int] = [400, 400, 400, 400]
        let yValues:[Int] = [140, 120, 100, 80]
        let radiusList:[Float] = [3.0, 5.0, 6.0, 7.0]
        
        // Create back button
        let backButton = UIButton(frame: CGRect(x: 307.5, y: 630, width: 180, height: 90))
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: CGFloat(45.0))
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.layer.borderWidth = 1.5
        backButton.layer.borderColor = UIColor.white.cgColor
        backButton.alpha = 0
        backButton.addTarget(self, action: #selector(self.back), for: UIControlEvents.touchUpInside)
        sceneView.addSubview(backButton)

        // Create UILabel for layer name
        var layerName = UILabel()
        layerName.textColor = UIColor.white
        layerName.font = UIFont(name: "HelveticaNeue-Thin", size: CGFloat(20.0))
        layerName = setLabel(label: layerName, text: self.ofPlanet.layers[0].name, x: 200, y: 200)
        layerName.textAlignment = .center
        sceneView.addSubview(layerName)
        
        // Create CAShapeLayer for straight line
        let straightLine = CAShapeLayer()
        straightLine.path = setLine(point: CGPoint(x: layerName.center.x, y: layerName.center.y + 20))
        straightLine.strokeColor = UIColor.white.cgColor
        straightLine.lineWidth = 2.0
        sceneView.layer.addSublayer(straightLine)
        
        // Displaying first layer
        var planetGeo = SCNSphere(radius: 1)
        var planetNode = SCNNode(geometry: planetGeo)
        planetGeo.firstMaterial?.diffuse.contents = ofPlanet.layers[0].color
        scene.rootNode.addChildNode(planetNode)
        
        // Displaying remaining layers
        for i in 1..<self.ofPlanet.layers.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + intervals[i]) {
                layerName = setLabel(label: layerName, text: self.ofPlanet.layers[i].name, x: xValues[i], y: yValues[i])
                straightLine.path = setLine(point: CGPoint(x: layerName.center.x, y: layerName.center.y + 20))
                sceneView.layer.addSublayer(straightLine)
                
                planetGeo = SCNSphere(radius: CGFloat(radiusList[i]))
                planetNode = SCNNode(geometry: planetGeo)
                planetGeo.firstMaterial?.diffuse.contents = self.ofPlanet.layers[i].color
                scene.rootNode.addChildNode(planetNode)
            }
        }
        
        // Displaying final layer
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            planetGeo = SCNSphere(radius: 7.5)
            planetNode = SCNNode(geometry: planetGeo)
            planetGeo.firstMaterial?.diffuse.contents = UIImage(named: "Textures/\(self.ofPlanet.name).jpg")
            scene.rootNode.addChildNode(planetNode)
            
            // Resetting label layer properties
            layerName.text = ""
            straightLine.lineWidth = 0.0

            // Adding label with Planet's name
            var planetName = UILabel()
            planetName = setLabel(label: planetName, text: self.ofPlanet.name.capitalized, x: 255, y: -75)
            planetName.font = UIFont(name: "HelveticaNeue-Thin", size: CGFloat(50.0))
            planetName.textColor = UIColor.white
            planetName.textAlignment = .center
            sceneView.addSubview(planetName)
            
            planetNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.75, z: 0, duration: 1)))
            
            // Showing up back button
            backButton.alpha = 1
        }
        
        self.view = scnView
    }
    
    @objc private func back() {
        self.dismiss(animated: true, completion: nil)
    }
}
