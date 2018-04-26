import SceneKit

/**
 Class representation of a Layer. May be used to represent a Planet's internal structure.
 
 - name: A string contaning the Layer's name.
 - color: A UIColor representing the color of the layer, characterized by the chemical elements that are contained in it.
 
 */
public class Layer {
    public let name:String
    public let color:UIColor

    public init(named: String, coloredWith: UIColor) {
        self.name = named
        self.color = coloredWith
    }
}

/**
 Class representation of a celestial body.
 
 - name: A string containing the celestial body's name.
 - size: A CGFloat representing the size of the celestial body.
 - rotation: A CGFloat representing the celestial body's rotation speed.
 - layers: A list of layers that compose the internal structure of the celestial body.
 */
public class CelestialBody {
    public let name:String
    public let size:CGFloat
    public let rotation:CGFloat
    public var layers:[Layer]
    
    public init(named: String) {
        self.name = named
        switch self.name {
        case "mercury":
            self.size = 0.2
            self.rotation = 0.8
            self.layers = [Layer(named: "Core", coloredWith: UIColor(red:0.96, green:0.76, blue:0.15, alpha:1.0)),
                           Layer(named: "Mantle", coloredWith: UIColor(red:0.84, green:0.29, blue:0.11, alpha:1.0)),
                           Layer(named: "Crust", coloredWith: UIColor(red:0.47, green:0.56, blue:0.62, alpha:1.0))]
        case "venus":
            self.size = 0.4
            self.rotation = 0.45
            self.layers = [Layer(named: "Core", coloredWith: UIColor(red:1.00, green:1.00, blue:0.44, alpha:1.0)),
                           Layer(named: "Mantle", coloredWith: UIColor(red:0.99, green:0.67, blue:0.29, alpha:1.0)),
                           Layer(named: "Crust", coloredWith: UIColor(red:0.91, green:0.29, blue:0.00, alpha:1.0))]
        case "earth":
            self.size = 0.5
            self.rotation = 0.6
            self.layers = [Layer(named: "Inner Core", coloredWith: UIColor(red:1.00, green:1.00, blue:0.80, alpha:1.0)),
                           Layer(named: "Outer Core", coloredWith: UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0)),
                           Layer(named: "Mantle", coloredWith: UIColor(red:1.00, green:0.40, blue:0.20, alpha:1.0)),
                           Layer(named: "Crust", coloredWith: UIColor(red:0.60, green:0.40, blue:0.20, alpha:1.0))]
        case "mars":
            self.size = 0.4
            self.rotation = 0.4
            self.layers = [Layer(named: "Core", coloredWith: UIColor(red:0.83, green:0.27, blue:0.08, alpha:1.0)),
                           Layer(named: "Mantle", coloredWith: UIColor(red:0.48, green:0.46, blue:0.36, alpha:1.0)),
                           Layer(named: "Crust", coloredWith: UIColor(red:0.80, green:0.56, blue:0.29, alpha:1.0))]
        case "jupiter", "saturn":
            if self.name == "jupiter" { self.size = 0.9; self.rotation = 0.65 }
            else { self.size = 0.7; self.rotation = 0.1 }
            self.layers = [Layer(named: "Core", coloredWith: UIColor(red:0.35, green:0.22, blue:0.02, alpha:1.0)),
                           Layer(named: "Metallic hydrogen", coloredWith: UIColor(red:0.32, green:0.33, blue:0.42, alpha:1.0)),
                           Layer(named: "Molecular hydrogen", coloredWith: UIColor(red:0.56, green:0.56, blue:0.56, alpha:1.0))]
        case "uranus", "neptune":
            if self.name == "uranus" { self.size = 0.5; self.rotation = 0.2 }
            else { self.size = 0.4; self.rotation = 0.4 }
            self.layers = [Layer(named: "Core", coloredWith: UIColor(red:0.35, green:0.22, blue:0.02, alpha:1.0)),
                           Layer(named: "Mantle", coloredWith: UIColor(red:0.65, green:0.64, blue:0.78, alpha:1.0)),
                           Layer(named: "Crust", coloredWith: UIColor(red:0.54, green:0.59, blue:0.90, alpha:1.0))]
        default:
            self.size = 0
            self.rotation = 0
            self.layers = []
        }
    }
}

/**
 Class representation of a ring system. May be used to depict the orbit of a Planet or any ring system that is contained in it.
 
 - withRadius: A CGFloat representing the Ring's radius.
 - andVelocity: A CGFloat representing the Ring's rotation speed.
 */
public class Ring {
    public let withRadius:CGFloat
    public let andVelocity:CGFloat

    public init(withRadius: Double, andVelocity: Double) {
        self.withRadius = CGFloat(withRadius)
        self.andVelocity = CGFloat(andVelocity)
    }
}

/**
 Class representation of a coordinate system. May be used to determine the position of geometric elements of a Planetary system.
 
 - orbitDistances: A list of floating points representing the distance between the ring objects in a Planetary system.
 - velocities: A list of floating points representing the rotation speed for all rings in the Planetary system.
 */
public class CoordinateSystem {
    public let orbitDistances:[Double]
    public let velocities:[Double]
    
    public init(ofSystemNamed: String) {
        switch ofSystemNamed {
        case "Solar system":
            self.orbitDistances = [3.0, 4.2, 6.0, 8.0, 10.0, 12.0, 14.0, 16.0]
            self.velocities = [0.6, 0.4, 0.25, 0.2, 0.45, 0.35, 0.25, 0.2]
        default:
            self.orbitDistances = []
            self.velocities = []
        }
    }
}

/**
 Class representation of a planetary system. May be used to depict a group of planets, rings, coordinates and other celestial objects that orbit around a star or a star system.
 
 - name: A string representing the name of the Planetary System.
 - planets: A list of strings representing the name of the planets that are contanined in it.
 - planetNodes: A dictionary mapping each node object created for a planet to it's Planet object representation.
 - coordinates: A CoordinateSystem object representing the geometric positional values for the Planetary system.
 */
public class PlanetarySystem {
    public let name:String
    public let planets:[String]
    public var planetNodes:[SCNNode:CelestialBody] = [:]
    private let coordinates:CoordinateSystem
    
    public init(named: String, withPlanets:[String], systemScene: SCNScene) {
        self.name = named
        self.planets = withPlanets
        self.coordinates = CoordinateSystem(ofSystemNamed: self.name)
        
        for i in 0..<planets.count {
            let planet = CelestialBody(named: self.planets[i])
            let ring = Ring(withRadius: coordinates.orbitDistances[i], andVelocity: coordinates.velocities[i])
            
            // Add nodes
            let ringNode = self.addRing(withRadius: ring.withRadius, ofColor: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.4), toScene: systemScene)
            let planetNode = self.addPlanet(named: planet.name, withSize: planet.size, andDistance: ring.withRadius, toRing: ringNode)
            self.planetNodes[planetNode] = planet
            
            // Running rotation animation
            ringNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: ring.andVelocity, z: 0, duration: 1)))
            planetNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: planet.rotation, z: 0, duration: 1)))
            
            // Running continuos up-and-down animation
            let moveRing = SCNAction.moveBy(x: 0, y: 0.6, z: 0, duration: 4)
            let movePlanet = SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 4)

            let sequenceRing = SCNAction.sequence([moveRing, moveRing.reversed()])
            let sequencePlanet = SCNAction.sequence([movePlanet, movePlanet.reversed()])
            
            ringNode.runAction(SCNAction.repeatForever(sequenceRing))
            planetNode.runAction(SCNAction.repeatForever(sequencePlanet))
            
            if planet.name == "earth" {
                // Add Moon to Earth
                let moonRingNode = self.addRing(withRadius: 0.7, ofColor: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 0.4), toPlanet: planetNode)
                let _ = self.addPlanet(named: "moon", withSize: 0.2, andDistance: 0.7, toRing: moonRingNode)
                moonRingNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 3.2, z: 0, duration: 1)))
            } else if planet.name == "saturn" {
                // Add Saturn's ring
                let _ = self.addRing(withRadius: 0.9, ofColor: UIColor(red:0.94, green:0.85, blue:0.67, alpha:1.0), toPlanet: planetNode)
            }
        }
        
        let sunNode = self.addStar(named: "sun", withSize: 2.0, toScene: systemScene)
        sunNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.2, z: 0, duration: 1)))
    }
    
    private func addRing(withRadius: CGFloat, ofColor: UIColor, toScene: SCNScene) -> SCNNode {
        let ringGeo = SCNTorus(ringRadius: withRadius, pipeRadius: 0.03)
        let ringNode = SCNNode(geometry: ringGeo)
        ringGeo.firstMaterial?.diffuse.contents = ofColor
        toScene.rootNode.addChildNode(ringNode)
        return ringNode
    }

    private func addRing(withRadius: CGFloat, ofColor: UIColor, toPlanet: SCNNode) -> SCNNode {
        let ringGeo = SCNTorus(ringRadius: withRadius, pipeRadius: 0.05)
        let ringNode = SCNNode(geometry: ringGeo)
        ringGeo.firstMaterial?.diffuse.contents = ofColor
        toPlanet.addChildNode(ringNode)
        return ringNode
    }
    
    private func addPlanet(named: String, withSize: CGFloat, andDistance: CGFloat, toRing: SCNNode) -> SCNNode {
        let planetGeo = SCNSphere(radius: withSize)
        let planetNode = SCNNode(geometry: planetGeo)
        toRing.addChildNode(planetNode)
        planetNode.position = SCNVector3(x: Float(andDistance), y: 0, z: 0)
        planetGeo.firstMaterial?.diffuse.contents = UIImage(named: "Textures/" + named + ".jpg")
        return planetNode
    }
    
    private func addStar(named: String, withSize: CGFloat, toScene: SCNScene) -> SCNNode {
        let planetGeo = SCNSphere(radius: withSize)
        let planetNode = SCNNode(geometry: planetGeo)
        toScene.rootNode.addChildNode(planetNode)
        planetNode.position = SCNVector3(x: 0, y: 0, z: 0)
        planetGeo.firstMaterial?.diffuse.contents = UIImage(named: "Textures/" + named + ".jpg")
        return planetNode
    }
}
