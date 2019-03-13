//
//  NetworkError.swift
//  LiquidFishInterview
//
//  Created by Garrett Votaw on 3/13/19.
//  Copyright © 2019 Garrett Votaw. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case responseFailed = "Response Failed"
    case invalidData = "Invalid Data"
    case dataNotFound = "Data Not Found"
}
