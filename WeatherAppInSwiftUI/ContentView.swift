//
//  ContentView.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        Text("\(self.weatherVM.temperature)")
            .padding()
            
            .onAppear() {
                self.weatherVM.fetchWeather()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
