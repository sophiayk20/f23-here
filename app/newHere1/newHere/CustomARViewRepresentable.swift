//
//  CustomARViewRepresentable.swift
//  new_here
//
//  Created by TRACY LI on 2023/10/28.
//
//  Description:
//  This Swift file defines a SwiftUI UIViewRepresentable for integrating ARKit functionality.
//  It allows for rendering AR content, such as 3D bubbles with messages, in the 'new_here' application.
//

import SwiftUI
import ARKit

struct CustomARViewRepresentable: UIViewRepresentable {
    // Environment objects for message and fetched messages states
    @EnvironmentObject var messageState: MessageState
    @EnvironmentObject var fetchedMessagesState: FetchedMessagesState
    
    // Create the ARSCNView and configure it
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()
        sceneView.delegate = context.coordinator
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        print("user id: \(userId)")
        
        // Fetch and render user's messages
        getUserMessages(userId: userId) {
            result in
            switch result {
            case .success(let response):
                print("Messages fetched successfully: \(response)")
                var convertedMessages:[Message] = []
                for m in response {
                    do {
                        let convertedMessage = try Message(id: m._id,
                                                           user_id: userId,
                                                           location: m.location.toCLLocation(),
                                                           messageStr: m.text)
                        convertedMessages.append(convertedMessage)
                    }
                    catch {
                        // Handle the error
                        print("Error: \(error)")
                    }
                }
                
                fetchedMessagesState.fetchedMessages = convertedMessages
                renderBubbleNodeHistory(to: sceneView, messages: convertedMessages)
                
            case .failure(let error):
                print("Error getting messages: \(error.localizedDescription)")
            }
        }
        
        return sceneView
    }
    
    // Update the AR view when a new message is available
    func updateUIView (_ uiView: ARSCNView, context: Context) {
        if let messageToPlant = messageState.currentMessage {
            plantBubbleNode(to: uiView, message: messageToPlant)
            messageState.currentMessage = nil
        }
        
    }
    
    // Create a coordinator for handling ARSCNViewDelegate methods
    func makeCoordinator() -> Coordinator {
            Coordinator(self)
    }
        
    class Coordinator: NSObject, ARSCNViewDelegate {
        var parent: CustomARViewRepresentable
        
        init(_ parent: CustomARViewRepresentable) {
            self.parent = parent
        }
    }
    
    // Plant a bubble node with a message at a specific position
    func plantBubbleNode(to sceneView: ARSCNView, message: Message) {
        // Set the position based on the provided position
        if let frame = sceneView.session.currentFrame {
            let transform = frame.camera.transform

            // Get the camera's forward direction (z-axis)
            let forwardDirection = SCNVector3(-transform.columns.2.x, -transform.columns.2.y, -transform.columns.2.z)

            // Calculate the position 2 meters in front of the camera
            let shifted_position = SCNVector3(
                transform.columns.3.x + forwardDirection.x * 0.5,
                transform.columns.3.y + forwardDirection.y * 0.5,
                transform.columns.3.z + forwardDirection.z * 0.5
            )
            
            newBubbleNode(to: sceneView, message: message, position: shifted_position)
        }
    }
    
    // Render a history of bubble nodes with messages at random positions
    func renderBubbleNodeHistory(to sceneView: ARSCNView, messages: [Message]) {
        // Create a random number generator
        var randomNumberGenerator = SystemRandomNumberGenerator()

        // Define the range of random positions for x, y, and z coordinates
        let xRange: ClosedRange<Float> = -3.0...3.0  // Represents a 10-meter width (-5m to +5m)
        let yRange: ClosedRange<Float> = -1.0...2.0   // Represents a height range above the ground (0m to +2m)
        let zRange: ClosedRange<Float> = -3.0...3.0  // Represents a 10-meter depth (-5m to +5m)

        for message in messages {
            // Generate random positions
            let randomX = Float.random(in: xRange, using: &randomNumberGenerator)
            let randomY = Float.random(in: yRange, using: &randomNumberGenerator)
            let randomZ = Float.random(in: zRange, using: &randomNumberGenerator)

            // Create an SCNVector3 using the random positions
            let randomPosition = SCNVector3(randomX, randomY, randomZ)
            
            newBubbleNode(to: sceneView, message: message, position: randomPosition)
        }
    }
    
    // Create a new bubble node with a message at a specified position
    func newBubbleNode(to sceneView: ARSCNView, message:Message, position:SCNVector3) {
        let bubble = SCNSphere(radius: 0.05)
        bubble.firstMaterial?.diffuse.contents = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        
        let bubbleNode = SCNNode(geometry: bubble)
        
        // Create an SCNText geometry for the first text
        let textGeometry1 = SCNText(string: message.id, extrusionDepth: 0.001)
        textGeometry1.firstMaterial?.diffuse.contents = UIColor.black
        let textNode1 = SCNNode(geometry: textGeometry1)
        
        // Position the first textNode inside the bubble
        textNode1.position = SCNVector3(-0.05, 0, -0.05) // Adjust the position inside the bubble
        textNode1.scale = SCNVector3(0.001, 0.001, 0.001)

        // Create an SCNText geometry for the second text
        let textGeometry2 = SCNText(string: message.messageStr, extrusionDepth: 0.001)
        textGeometry2.firstMaterial?.diffuse.contents = UIColor.black
        let textNode2 = SCNNode(geometry: textGeometry2)

        // Position the second textNode inside the bubble, stacked on top of the first
        textNode2.position = SCNVector3(-0.05, 0, 0.05) // Adjust the vertical position inside the bubble
        textNode2.scale = SCNVector3(0.001, 0.001, 0.001)

        // Add both text nodes as children of the bubbleNode
        bubbleNode.addChildNode(textNode1)
        bubbleNode.addChildNode(textNode2)

        print("\(message.id), \(message.messageStr)")
        // Set the node's position to the calculated position 2 meters in front of the camera
        bubbleNode.position = position
        sceneView.scene.rootNode.addChildNode(bubbleNode)
    }
}
