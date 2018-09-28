//
//  DetailsViewModel.swift
//  20180927-TurzoEsfar-NYCSchools
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//

import Foundation

//Viewmodel to communicate with DetailsViewController
class DetailsViewModel {
    
    var satData:NYCSchoolSATModel!
    
    //provide NYC school SAT data to DetailViewController
    func getDetailsSATViewData(dbn:String, completionHandler:@escaping (NYCSchoolSATModel?, Error?)-> Void) {
        
        var desiredResult:NYCSchoolSATModel?
        
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/734v-jeq5.json") else {
            return
        }
        
        DataLoader().loadNYCSATData(from: url) { (result, error) in
            if let error = error {
                completionHandler(desiredResult, error)
            }
            let filteredObj = result.filter({$0.dbn == dbn})
            if filteredObj.count == 1 {
                desiredResult = filteredObj.first
            }
            completionHandler(desiredResult,error)
        }
    }
}
