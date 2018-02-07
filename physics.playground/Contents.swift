//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport
import SpriteKit

let nibFile = NSNib.Name(rawValue:"MyView")
var topLevelObjects : NSArray?


Bundle.main.loadNibNamed(nibFile, owner:nil, topLevelObjects: &topLevelObjects)
let views = (topLevelObjects as! Array<Any>).filter { $0 is NSView }


// Present the view in Playground
PlaygroundPage.current.liveView = views[0] as! NSView

func random(_ min: CGFloat,_ max: CGFloat) -> CGFloat
{
    return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF)) * (max - min) + min
}

func delay(seconds: Double, completion:@escaping ()->())
{
    let popTime = DispatchTime.now() +
        Double(Int64(Double(NSEC_PER_SEC) * seconds)) /
        Double(NSEC_PER_SEC)
    
    DispatchQueue.global(qos:
        DispatchQoS.QoSClass.default).asyncAfter(deadline: popTime)
        {
            completion()
    }
}

random(3, 20)

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 400, height: 320))
sceneView.showsFPS = true;
sceneView.showsPhysics = false;

let scene = SKScene(size: CGSize(width: 400, height: 320))
scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)


let square = SKSpriteNode(imageNamed: "square")
square.position = CGPoint(x: scene.size.width * 0.25, y: scene.size.height * 0.50)
square.physicsBody = SKPhysicsBody(rectangleOf: square.frame.size)
scene.addChild(square)


let circle = SKSpriteNode(imageNamed: "circle")
circle.position = CGPoint(x: scene.size.width * 0.50, y: scene.size.height * 0.50)
circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width / 2)
scene.addChild(circle)


let triangle = SKSpriteNode(imageNamed: "triangle")
triangle.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.50)

var trianglePath = CGMutablePath()
trianglePath.move(to: CGPoint(x: -triangle.size.width / 2, y: -triangle.size.height / 2))
trianglePath.addLine(to: CGPoint(x: triangle.size.width / 2, y: -triangle.size.height / 2))
trianglePath.addLine(to: CGPoint(x: 0, y: triangle.size.height / 2))
trianglePath.addLine(to: CGPoint(x: -triangle.size.width / 2, y: -triangle.size.height / 2))
scene.addChild(triangle)


let l = SKSpriteNode(imageNamed: "L")
l.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.75)
l.physicsBody = SKPhysicsBody(texture: l.texture!, size: l.size)
scene.addChild(l)

delay(seconds: 5.0, completion: {
    scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
})


func spawnSand() {
    let sand: SKSpriteNode = SKSpriteNode(imageNamed: "sand")
    sand.position = CGPoint(x: random(0, scene.size.width), y: scene.size.height - sand.size.height)
    sand.physicsBody = SKPhysicsBody(circleOfRadius: sand.size.width / 2)
    sand.name = "sand"
    sand.physicsBody!.restitution = 1.0
    sand.physicsBody!.density = 20.0
    
    scene.addChild(sand)
}

func shake() {
    scene.enumerateChildNodes(withName: "sand"){
        node, _ in
        node.physicsBody!.applyImpulse(CGVector(dx: 0, dy: random(20, 40)))
    }
    scene.enumerateChildNodes(withName: "shape") {
        node, _ in
        node.physicsBody!.applyImpulse(CGVector(dx: random(20, 60), dy: random(20, 60)))
    }
    
    delay(seconds: 3, completion: shake)
}

delay(seconds: 2.0, completion: {
    scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    scene.run(
        SKAction.repeat(
            SKAction.sequence([SKAction.run(spawnSand), SKAction.wait(forDuration: 0.1)]), count: 100))
    
    delay(seconds: 5, completion: shake)
})

sceneView.presentScene(scene)
PlaygroundPage.current.liveView = sceneView
