//
//  GameScene.swift
//  OrangeTree
//
//  Created by Marissa Vang on 1/28/20.
//  Copyright © 2020 Marissa Vang. All rights reserved.
//

import SpriteKit

var orangeTree: SKSpriteNode!
var orange: Orange?
var touchStart: CGPoint = .zero
var shapeNode = SKShapeNode()

class GameScene: SKScene {

    override func didMove(to view: SKView) {
      // Connect Game Objects
        orangeTree = childNode(withName: "tree") as? SKSpriteNode
      // Configure shapeNode
//        shapeNode.lineWidth = 20
//        shapeNode.lineCap = .round
//        shapeNode.strokeColor = UIColor(white: 1, alpha: 0.3)
//        addChild(shapeNode)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the location of the touch on the screen
        let touch = touches.first!
        let location = touch.location(in: self)

        // Check if the touch was on the Orange Tree
        if atPoint(location).name == "tree" {
          // Create the orange and add it to the scene at the touch location
          orange = Orange()
          orange?.physicsBody?.isDynamic = false
          orange?.position = location
          addChild(orange!)
        
        // Store the location of the touch
        touchStart = location
        
        // Give the orange an impulse to make it fly!
        let vector = CGVector(dx: 100, dy: 0)
          orange?.physicsBody?.applyImpulse(vector)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      // Get the location of the touch
      let touch = touches.first!
      let location = touch.location(in: self)

      // Update the position of the Orange to the current location
      orange?.position = location
    
      // Draw the firing vector
      let path = UIBezierPath()
      path.move(to: touchStart)
      path.addLine(to: location)
      shapeNode.path = path.cgPath
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      // Get the location of where the touch ended
      let touch = touches.first!
      let location = touch.location(in: self)

      // Get the difference between the start and end point as a vector
      let dx = touchStart.x - location.x
      let dy = touchStart.y - location.y
      let vector = CGVector(dx: dx, dy: dy)

      // Set the Orange dynamic again and apply the vector as an impulse
      orange?.physicsBody?.isDynamic = true
      orange?.physicsBody?.applyImpulse(vector)
        
      // Remove the path from shapeNode
      shapeNode.path = nil
    }
}
