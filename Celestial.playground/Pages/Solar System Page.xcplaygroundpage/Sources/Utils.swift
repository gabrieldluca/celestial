import UIKit
import SceneKit

/**
 Creates a quote-formatted label with zero alpha for Animation purposes.
 
 - Parameter text: A string representing the text of the desired quote.
 - Parameter toView: The view to add the quote to.
 - Parameter color: The color of the quote.
 - Parameter frame: A frame containing the coordinates and the dimensions for the quote.
 
 - returns: UILabel
 */
public func addLabel(text: String, toView: UIView, color: UIColor, frame: CGRect) -> UILabel {
    let quote = UILabel()
    quote.text = text
    quote.textColor = color
    quote.frame = frame
    quote.alpha = 0
    quote.font = UIFont(name: "HelveticaNeue-Thin", size: CGFloat(25.0))
    toView.addSubview(quote)
    return quote
}

/**
 Defines text and coordinates to a label.
 
 - Parameter label: The label to add the parameters to.
 - Parameter text: A string representing the text of the label.
 - Parameter x: Position of the x coordinate.
 - Parameter y: Position of the y coordinate.
 
 - returns: UILabel
 */
public func setLabel(label: UILabel, text: String, x: Int, y: Int) -> UILabel {
    label.text = text
    label.frame = CGRect(x: x, y: y, width: 300, height: 300)
    return label
}

/**
 Creates a bezier path from pair (405, 400) to the desired point.
 
 - Parameter point: A CGPoint containing the x and y coordinates.
 
 - returns: CGPath
 */
public func setLine(point: CGPoint) -> CGPath {
    let bezier = UIBezierPath()
    bezier.move(to: CGPoint(x: 405, y: 400))
    bezier.addLine(to: point)
    return bezier.cgPath
}

/**
 Places a camera in the respective scene.
 
 - Parameter toScene: The desired scene object to place the camera to.
 
 - returns: SCNNode
 */
public func placeCamera(toScene: SCNScene) -> SCNNode {
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    toScene.rootNode.addChildNode(cameraNode)
    cameraNode.position = SCNVector3(x: 4, y: 0, z: 30)
    return cameraNode
}

/**
 Add an omni light to the respective scene.
 
 - Parameter toScene: The desired scene object to add the light to.
 */
public func addLight(toScene: SCNScene) {
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light!.type = .omni
    lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
    toScene.rootNode.addChildNode(lightNode)
}

/**
 Add a dark-gray ambient light to the respective scene.
 
 - Parameter toScene: The desired scene object to add the ambient light to.
 */
public func addAmbientLight(toScene: SCNScene) {
    let ambientLightNode = SCNNode()
    ambientLightNode.light = SCNLight()
    ambientLightNode.light!.type = .ambient
    ambientLightNode.light!.color = UIColor.darkGray
    toScene.rootNode.addChildNode(ambientLightNode)
}
