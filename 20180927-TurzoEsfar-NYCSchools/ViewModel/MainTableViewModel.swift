//
//  MainTableViewModel.swift
//  20180927-TurzoEsfar-NYCSchools
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//

import Foundation
import UIKit

//Viewmodel to communicate with Viewcontroller
class MainTableViewModel {

    var dataSourceArray:[NYcSchoolModel] = []
    
    //provide NYC school data to viewcontrller
    func getNYCSchoolData(completionHandler:@escaping (Bool)-> Void){
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/97mf-9njv.json")else{
            return
        }
        DataLoader().loadNYCSchoolData(from: url) { (result, error) in
            if let _ = error {
                completionHandler(true)
            }
            self.dataSourceArray = result
            completionHandler(false)
        }
    }

    //decide table row side color
    func decideColor(indexval:Int) -> UIColor{
        if (indexval%3 == 0){
            return UIColor.blue
        }else if (indexval%3 == 1){
            return UIColor.orange
        }else if (indexval%3 == 2){
            return UIColor.purple
        }
        else{
            return UIColor.black
        }
    }
    
}
