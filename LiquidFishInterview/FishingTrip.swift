//
//  FishingTrip.swift
//  LiquidFishInterview
//
//  Created by Garrett Votaw on 3/13/19.
//  Copyright © 2019 Garrett Votaw. All rights reserved.
//

import Foundation

typealias Fish = String

enum Month: String {
    case January
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
}

struct FishingTrip {
    let date: String
    var formattedDate: Month {
        get {
            let splitString = date.split(separator: "T")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let newDate = dateFormatter.date(from: String(splitString[0]))
            dateFormatter.dateFormat = "MMMM"
            return Month.init(rawValue: dateFormatter.string(from: newDate!))!
        }
    }
    let fishCaught: [Fish]
    
    enum CodingKeys: String, CodingKey {
        case date
        case fishCaught = "fish_caught"
    }
}

extension FishingTrip: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.fishCaught = try container.decode([Fish].self, forKey: .fishCaught)
    }
}


struct FishCount {
    let name: String
    let count: Int
}
