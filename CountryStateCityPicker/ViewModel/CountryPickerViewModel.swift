//
//  CountryPickerViewModel.swift
//  CountryStateCityPicker
//
//  Created by Aijaz Ali on 8/21/21.
//

import Foundation

class CountryPickerViewModel {

    var countryId = ""
    var stateId = ""

    public lazy var countries: [CountryModel] = {
        var countries = [CountryModel]()
        guard let jsonPath = Bundle.main.url(forResource: .countryJsonName, withExtension: .json),
              let jsonData = try? Data(contentsOf: jsonPath) else {
            return countries
        }
        if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonData,
                                                                options: JSONSerialization
                                                                    .ReadingOptions.allowFragments)) as? Array<Any> {

            for jsonObject in jsonObjects {
                guard let countryObj = jsonObject as? Dictionary<String, Any> else {
                    continue
                }
                guard let name = countryObj["name"] as? String,
                      let id = countryObj["id"] as? String else {
                    continue
                }
                let country = CountryModel(name: name, id: id)
                countries.append(country)
            }
        }
        return countries
    }()

    public lazy var states: [StateModel] = {
        var states = [StateModel]()
        guard let jsonPath = Bundle.main.url(forResource: .stateJsonName, withExtension: .json),
              let jsonData = try? Data(contentsOf: jsonPath) else {
            return states
        }
        if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonData,
                                                                options: JSONSerialization
                                                                    .ReadingOptions.allowFragments)) as? Array<Any> {

            for jsonObject in jsonObjects {
                guard let stateObj = jsonObject as? Dictionary<String, Any> else {
                    continue
                }
                guard let name = stateObj["name"] as? String,
                      let id = stateObj["id"] as? String,
                      let countryId = stateObj["country_id"] as? String else {
                    continue
                }
                let state = StateModel(name: name, id: id, countryId: countryId)
                states.append(state)
            }
        }
       states = states.filter({ $0.countryId == countryId })
        return states
    }()

    public lazy var cities: [CityModel] = {
        var cities = [CityModel]()
        guard let jsonPath = Bundle.main.url(forResource: .cityJsonName, withExtension: .json),
              let jsonData = try? Data(contentsOf: jsonPath) else {
            return cities
        }
        if let jsonObjects = (try? JSONSerialization.jsonObject(with: jsonData,
                                                                options: JSONSerialization
                                                                    .ReadingOptions.allowFragments)) as? Array<Any> { 

            for jsonObject in jsonObjects {
                guard let cityObj = jsonObject as? Dictionary<String, Any> else {
                    continue
                }
                guard let name = cityObj["name"] as? String,
                      let id = cityObj["id"] as? String,
                      let stateId = cityObj["state_id"] as? String else {
                    continue
                }
                let state = CityModel(name: name, id: id, stateId: stateId)
                cities.append(state)
            }
        }
        cities = cities.filter({ $0.stateId == stateId })
        return cities
    }()

}
