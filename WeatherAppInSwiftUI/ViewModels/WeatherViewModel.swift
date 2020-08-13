//
//  WeatherViewModel.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published private var weather: Weather?
    @Published var message: String = ""
    
    var temperature: Double {
        guard let temp = weather?.temp else {
            return 0.0
        }
        return temp
    }
    
    func fetchWeather(city: String, apiKey: String) {
        
        guard let city = city.escape() else {
            fatalError("URL is invalid!")
        }
        
        WeatherService().getWeather(city: city, apiKey: apiKey) { result in
            switch result {
            
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.weather = weather
                    }

                case .failure(_ ):
                    DispatchQueue.main.async {
                        self.message = "Unable to find the weather"
                        self.weather = nil
                    } 
            }
        }
    }
}
