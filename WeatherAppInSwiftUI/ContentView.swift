//
//  ContentView.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var weatherVM = WeatherViewModel()
    @State private var city: String = ""
    @AppStorage("APIKEY") var apiKey: String = ""
    
    var body: some View {
        VStack {
            TextField("Search", text: $city, onEditingChanged: {_ in }) {
                self.weatherVM.fetchWeather(city: self.city, apiKey: self.apiKey)
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Your API Key", text: $apiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            Text("\(self.weatherVM.temperature)")
            Text(weatherVM.message)
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
