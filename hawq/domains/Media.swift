//
//  Media.swift
//  hawq
//
//  Created by Anthony Shewnarain on 3/13/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import Foundation

class Media: Codable {

    var mediaID: String
    var creationDate = Date()
    var mediaData: Data
    var mediaDescription: String?
    var mediaName: String?
    var mediaType: MediaType
    
    init(mediaID: String, mediaData: Data, mediaType: MediaType) {
        self.mediaID = mediaID
        self.mediaData = mediaData
        self.mediaType = mediaType
    }
    
    enum CodingKeys: String, CodingKey {
        case mediaID
        case creationDate
        case mediaData
        case mediaDescription
        case mediaName
        case mediaType
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mediaID, forKey: .mediaID)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(mediaData, forKey: .mediaData)
        try container.encodeIfPresent(mediaDescription, forKey: .mediaDescription)
        try container.encodeIfPresent(mediaName, forKey: .mediaName)
        try container.encode(mediaType.rawValue, forKey: .mediaType)
        
    }
    //EvaluationStatus(rawValue: try values.decode(String.self, forKey: .status))!
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mediaID = try values.decode(String.self, forKey: .mediaID)
        creationDate = try values.decode(Date.self, forKey: .creationDate)
        mediaData = try values.decode(Data.self, forKey: .mediaData)
        mediaDescription = try values.decodeIfPresent(String.self, forKey: .mediaDescription)
        mediaName = try values.decodeIfPresent(String.self, forKey: .mediaName)
        mediaType = MediaType(rawValue: try values.decode(String.self, forKey: .mediaType))!
    }
}
