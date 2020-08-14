//
//  Double+Extensions.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 14.08.2020.
//

import Foundation

extension Double {
    
    func toFahrenheit() -> Double {
        
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        let convertedTemperate = temperature.converted(to: .fahrenheit)
        return convertedTemperate.value
    }
    
    func toCelsius() -> Double {
        
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        let convertedTemperate = temperature.converted(to: .celsius)
        return convertedTemperate.value
    }
}
