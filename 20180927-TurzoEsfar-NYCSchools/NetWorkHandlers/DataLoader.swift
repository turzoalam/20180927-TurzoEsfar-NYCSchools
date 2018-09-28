//
//  WebService.swift
//  20180927-TurzoEsfar-NYCSchools
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//

import Foundation
typealias completionHandlerResult = (Result) -> ()

//protocol required for network webservice calls and unit test
protocol NetworkEngine {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    func performRequest(for url: URL, completionHandler: @escaping Handler)
}

enum Result {
    case data(Data)
    case error(Error)
}

extension URLSession: NetworkEngine {
    typealias Handler = NetworkEngine.Handler
    
    func performRequest(for url: URL, completionHandler: @escaping Handler) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
}

//Class dataloader is used for downloading and parsing data
class DataLoader {
    
    private let engine: NetworkEngine
    
    init(engine: NetworkEngine = URLSession.shared) {
        self.engine = engine
    }
 
    //function to network call and set data on Result enum
    private func loadData(from url: URL, completionHandler: @escaping completionHandlerResult) {
        
        engine.performRequest(for: url) { (data, response, error) in
            if let error = error {
                completionHandler(.error(error))
            }
            if let data = data {
                completionHandler(.data(data))
            }
        }
    }
    
    //download and parse data for NYC schools
   func loadNYCSchoolData(from url: URL, completionHandler: @escaping ([NYcSchoolModel], Error?)-> Void) {
    
    self.loadData(from: url) { (result) in
        
        switch result {
        case .data(let data):
            do{
                let jsonData = try JSONDecoder().decode([NYcSchoolModel].self, from: data)
                completionHandler(jsonData, nil)
            }catch{
                print("Error Parsing")
            }
            
        case .error(let error):
            completionHandler([], error)
        }
    }
    }
    
    //download data and parse for NYC schools SAT data
    func loadNYCSATData(from url: URL, completionHandler: @escaping ([NYCSchoolSATModel], Error?)-> Void) {
        self.loadData(from: url) { (result) in
            
            switch result {
            case .data(let data):
                do{
                    let jsonData = try JSONDecoder().decode([NYCSchoolSATModel].self, from: data)
                    completionHandler(jsonData, nil)
                }catch{
                    print("Error Parsing")
                }
            case .error(let error):
                completionHandler([], error)
            }
        }
    }
}
