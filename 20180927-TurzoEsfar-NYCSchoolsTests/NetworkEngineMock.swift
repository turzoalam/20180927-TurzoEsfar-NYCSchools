//
//  NetworkEngineMock.swift
//  20180927-TurzoEsfar-NYCSchoolsTests
//
//  Created by @mit on 28/09/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//

import XCTest
@testable import _0180927_TurzoEsfar_NYCSchools


class NetworkEngineMock: NetworkEngine {
    typealias Handler = NetworkEngine.Handler
    
    var requestedURL: URL?
    func performRequest(for url: URL, completionHandler: @escaping Handler) {
        requestedURL = url
        let data = "Hello world".data(using: .utf8)
        completionHandler(data, nil, nil)
    }
}
