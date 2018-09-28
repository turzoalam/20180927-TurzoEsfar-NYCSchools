//
//  NycSchoolModel.swift
//  20180927-TurzoEsfar-NYCSchools
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//
//codeable Model Class for Schools
import Foundation

struct NYcSchoolModel {
    var school_name:String
    var location:String
    var total_students:String
    var website:String
    var school_email:String
    var city:String
    var dbn: String
    var phone_number:String
    var neighborhood:String
    
    enum Codingkeys:String,CodingKey{
        case school_name = "school_name"
        case location = "location"
        case total_students = "total_students"
        case website = "website"
        case school_email = "school_email"
        case city = "city"
        case dbn = "dbn"
        case phone_number = "phone_number"
        case neighborhood = "neighborhood"
    }
}

//decoding data based on keys when data is present
extension NYcSchoolModel:Decodable{
    init(from decoder: Decoder) throws {
        let resultVals = try decoder.container(keyedBy: Codingkeys.self)
        school_name = try resultVals.decodeIfPresent(String.self, forKey: .school_name) ?? ""
        location = try resultVals.decodeIfPresent(String.self, forKey: .location) ?? ""
        total_students = try resultVals.decodeIfPresent(String.self, forKey: .total_students) ?? ""
        website = try resultVals.decodeIfPresent(String.self, forKey: .website) ?? ""
        school_email = try resultVals.decodeIfPresent(String.self, forKey: .school_email) ?? ""
        city = try resultVals.decodeIfPresent(String.self, forKey: .city) ?? ""
        dbn = try resultVals.decodeIfPresent(String.self, forKey: .dbn) ?? ""
        phone_number = try resultVals.decodeIfPresent(String.self, forKey: .phone_number) ?? ""
        neighborhood = try resultVals.decodeIfPresent(String.self, forKey: .neighborhood) ?? ""
    }
}
