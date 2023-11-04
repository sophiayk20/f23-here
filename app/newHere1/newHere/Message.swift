//
//  Message.swift
//  newHere
//
//  Created by Eric Wang on 10/28/23.
//

import Foundation
import CoreLocation

class Message {
    var id: String
    var user_id: String
    var location: CLLocation
    var author: String
    var messageStr: String
    
    init(id:String, location:CLLocation, author: String, messageStr: String) {
        self.id = id
        self.user_id = "653d51478ff5b3c9ace45c26"
        self.location = location
        self.author = author
        self.messageStr = messageStr
    }
    
    func displayMessage() -> String {
        return "Author: \(author)\n\(location.coordinate.latitude.description), \(location.coordinate.longitude.description), \n\(messageStr)"
    }
}
