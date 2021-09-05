//
//  TodayViewModelConstructor.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/6/21.
//

import Foundation

class TodayViewModelConstructor{
    public static func construct(from item: WeatherData) -> TodayViewModel {
        return TodayViewModel(city: item.name,
                              countryCode: item.sys.country,
                              iconName: item.weather.first!.icon,
                              temperature: item.main.temp,
                              mainDescription: item.weather.first!.main,
                              cloudiness: item.clouds.all,
                              humidity: item.main.humidity,
                              pressure: item.main.pressure,
                              windSpeed: item.wind.speed,
                              windDirection: item.wind.deg)
        }
}
