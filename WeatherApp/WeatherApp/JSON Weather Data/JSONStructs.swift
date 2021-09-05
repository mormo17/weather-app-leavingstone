//
//  JSONStructs.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import Foundation


let apiKey = "6a463f616a7571d98cd2bed1c28af128"

struct Weather: Codable{
    let main: String
    let description: String
    let icon: String
    
    init(){
        self.main = ""
        self.description = ""
        self.icon = ""
    }
}

struct Main: Codable{
    let humidity: Double
    let temp: Double
    let pressure: Int
    
    init(){
        self.humidity = 0.0
        self.temp = 0.0
        self.pressure = 0
    }
}

struct Wind: Codable{
    let speed: Double
    let deg: Double
    
    init(){
        self.speed = 0.0
        self.deg = 0.0
    }
}

struct Clouds: Codable{
    let all: Double
    
    init(){
        self.all = 0
    }
}

struct Sys: Codable{
    let country: String
    
    init(){
        self.country = ""
    }
}

struct WeatherData: Codable{
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let name: String
    
    init() {
        self.weather = []
        self.main = Main()
        self.wind = Wind()
        self.clouds = Clouds()
        self.sys = Sys()
        self.name = ""
    }
}

struct WeatherForecastData: Codable{
    let dt: Int64
    let weather: [Weather]
    let main: Main
    let dt_txt: String
    
    init() {
        self.dt = 0
        self.weather = []
        self.main = Main()
        self.dt_txt = ""
    }
    
}

struct WeatherForecast: Codable{
    let list: [WeatherForecastData]
    
    init(){
        self.list = []
    }
}

