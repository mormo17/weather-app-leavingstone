//
//  TodayViewModel.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import Foundation

struct TodayViewModel{
    private let city: String
    private let countryCode: String
    private let iconName: String
    private let temperature: Double
    private let mainDescription: String
    private let cloudiness: Int
    private let humidity: Int
    private let pressure: Int
    private let windSpeed: Int
    private let windDirection: Double
    
    
    init(
        city: String,
        countryCode: String,
        iconName: String,
        temperature: Double,
        mainDescription: String,
        cloudiness: Double,
        humidity: Double,
        pressure: Int,
        windSpeed: Double,
        windDirection: Double
    ){
        self.city = city
        self.countryCode = countryCode
        self.iconName = iconName
        self.temperature = temperature
        self.mainDescription = mainDescription
        self.cloudiness = Int(cloudiness)
        self.humidity = Int(humidity)
        self.pressure = pressure
        self.windSpeed = Int(windSpeed)
        self.windDirection = windDirection
    }
    
    var getIconName: String { return iconName}
    
    var getCityLabel: String { return city + ", " + countryCode }
    
    var getMainDescription: String { return "\(temperature)° | " + mainDescription }
    
    var getCloudiness: String { return "\(cloudiness)%" }
    
    var getHumidity: String { return "\(humidity) mm" }
    
    var getPressure: String { return "\(pressure) hPa" }
    
    var getWindSpeed: String { return "\(windSpeed) km/h" }
    
    var getWindDirection: String { return convertWindDegToWindDir(windDeg: windDirection) }
    
    func convertWindDegToWindDir(windDeg: Double) -> String{
        let windDirections = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW", "N"]
        let dir = windDeg/22.5 + 1
        var res = ""
        if (dir >= 0 && dir <= 16){
            res = windDirections[Int(dir)]
        }
        
        return res
    }
    
}
