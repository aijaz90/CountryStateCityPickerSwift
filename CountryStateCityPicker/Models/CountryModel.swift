//
//  CountryModel.swift
//  CountryStateCityPicker
//
//  Created by Aijaz Ali on 8/12/21.
//

import Foundation

public struct CountryModel: Equatable {
    public let name: String
    public let id: String

    public static func == (lhs: CountryModel, rhs: CountryModel) -> Bool {
        return lhs.id == rhs.id
    }

    public static func != (lhs: CountryModel, rhs: CountryModel) -> Bool {
        return lhs.id != rhs.id
    }
}

public struct StateModel: Equatable {
    public let name: String
    public let id: String
    public let countryId: String

    public static func == (lhs: StateModel, rhs: StateModel) -> Bool {
        return lhs.id == rhs.id
    }
    public static func != (lhs: StateModel, rhs: StateModel) -> Bool {
        return lhs.id != rhs.id
    }
}

public struct CityModel: Equatable {
    public let name: String
    public let id: String
    public let stateId: String

    public static func == (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.id == rhs.id
    }
    public static func != (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.id != rhs.id
    }
}
