//
//  MileageEntry.swift
//  MileageTracker
//
//  Created by Sarthak Agrawal on 03/09/24.
//

import SwiftUI

struct MileageEntry: Identifiable, Codable {
    var id = UUID()
    var kilometers: Double
    var petrolLiters: Double
    var date: Date
    var mileageData: MileageData
}

struct MileageData: Codable{
    var mileage: Double?
    var mileageComparisonFromPrevMileage: MileageCompare
}
