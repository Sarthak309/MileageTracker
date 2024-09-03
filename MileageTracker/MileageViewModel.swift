//
//  MileageViewModel.swift
//  MileageTracker
//
//  Created by Sarthak Agrawal on 03/09/24.
//

import Foundation
import SwiftUI

enum MileageCompare: Codable{
    case more
    case equal
    case less
    
    var color: UIColor{
        switch self{
        case .more:
            return UIColor.systemGreen
        case .less:
            return UIColor.systemRed
        case .equal:
            return UIColor.white
        }
    }
}

class MileageViewModel: ObservableObject {
    @AppStorage("mileageEntries") private var mileageData: Data?

    @Published var entries: [MileageEntry] = []
    @Published var currentKilometers: String = ""
    @Published var currentPetrol: String = ""
    @Published var selectedDate: Date = Date()
    
    private var prevMileage: Double = 0.0

    init() {
        loadEntries()
    }

    func addEntry() {
        guard let kilometers = Double(currentKilometers),
              let petrolLiters = Double(currentPetrol) else {
            return
        }
        
        let mileage: Double?
        var comparison: MileageCompare = .equal
        if !entries.isEmpty {
            let lastEntry = entries.last!
            let distanceCovered = kilometers - lastEntry.kilometers
            mileage = distanceCovered / petrolLiters
            
            if let previousMileage = lastEntry.mileageData.mileage {
                if mileage! > previousMileage {
                    comparison = .more
                } else if mileage! < previousMileage {
                    comparison = .less
                } else {
                    comparison = .equal
                }
            }
        } else {
            mileage = nil
            comparison = .more
        }
        
        let newEntry = MileageEntry(
            kilometers: kilometers,
            petrolLiters: petrolLiters,
            date: selectedDate,
            mileageData: MileageData(mileage: mileage,
                                     mileageComparisonFromPrevMileage: comparison)
        )
        
        entries.append(newEntry)
        saveEntries()
        // Clear input fields
        currentKilometers = ""
        currentPetrol = ""
    }
    private func saveEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            mileageData = encoded
        }
    }
    func deleteEntry(_ entry: MileageEntry) {
        entries.removeAll { $0.id == entry.id }
        saveEntries()
    }

    private func loadEntries() {
        if let mileageData = mileageData,
           let savedEntries = try? JSONDecoder().decode([MileageEntry].self, from: mileageData) {
            entries = savedEntries
        }
    }
}
