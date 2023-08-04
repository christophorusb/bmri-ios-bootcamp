//
//  CountryFlagProvider.swift
//  Excercise_Day3
//
//  Created by laptop MCO on 02/08/23.
//

import Foundation

class CountryFlagProvider {
    static let shared: CountryFlagProvider = CountryFlagProvider() //singleton
    private init() { }
    
    func loadData() -> [CountryFlagModel] {
        let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "country-flag", withExtension: "json") else {
            fatalError("Failed to locate data.json in app bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load data.json from app bundle")
        }
        
        do{
            let countryFlagModel = try decoder.decode([CountryFlagModel].self, from: data)
            return countryFlagModel
        }catch {
            print("Failed to decode JSON from data.json: \(error)")
            return []
        }
    }
}
