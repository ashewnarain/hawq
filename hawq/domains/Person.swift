//
//  Person.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/25/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Person: Codable {
    let id: String
    var fullName: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    
    init(id: String, firstName: String, lastName: String, email: String, phone: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }
    
    init(fullName: String) {
        self.id = UUID().uuidString
        self.fullName = fullName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName
        case firstName
        case lastName
        case email
        case phone
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(fullName, forKey: .fullName)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(phone, forKey: .phone)
        
    }
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
    }
}
