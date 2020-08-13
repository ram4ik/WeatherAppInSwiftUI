//
//  URL+Extensions.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import Foundation

extension URL {
    
    static func urlForWeather() -> URL? {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=Larnaca&appid=APIKEY") else { return nil}
        
        return url
    }
}
