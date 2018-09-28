//
//  NYCSchoolSATModel.swift
//  20180927-TurzoEsfar-NYCSchools
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//
//codeable Model Class for SAT Score
import Foundation
struct NYCSchoolSATModel {
    var dbn:String
    var num_of_sat_test_takers:String
    var sat_critical_reading_avg_score:String
    var sat_math_avg_score:String
    var sat_writing_avg_score:String
    var school_name:String

    enum Codingkeys:String,CodingKey{
        case dbn = "dbn"
        case num_of_sat_test_takers = "num_of_sat_test_takers"
        case sat_critical_reading_avg_score = "sat_critical_reading_avg_score"
        case sat_math_avg_score = "sat_math_avg_score"
        case sat_writing_avg_score = "sat_writing_avg_score"
        case school_name = "school_name"
    }
}

//decoding data based on keys when data is present
extension NYCSchoolSATModel:Decodable{
    init(from decoder: Decoder) throws {
        let resultVals = try decoder.container(keyedBy: Codingkeys.self)
        dbn = try resultVals.decodeIfPresent(String.self, forKey: .dbn) ?? ""
        num_of_sat_test_takers = try resultVals.decodeIfPresent(String.self, forKey: .num_of_sat_test_takers) ?? ""
        sat_critical_reading_avg_score = try resultVals.decodeIfPresent(String.self, forKey: .sat_critical_reading_avg_score) ?? ""
        sat_math_avg_score = try resultVals.decodeIfPresent(String.self, forKey: .sat_math_avg_score) ?? ""
        sat_writing_avg_score = try resultVals.decodeIfPresent(String.self, forKey: .sat_writing_avg_score) ?? ""
        school_name = try resultVals.decodeIfPresent(String.self, forKey: .school_name) ?? ""
    }
}
