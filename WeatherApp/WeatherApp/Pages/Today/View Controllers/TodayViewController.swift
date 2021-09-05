//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    private var todayViewModel: TodayViewModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        addCity(city: "Tbilisi")
    }
    
    func addCity(city: String) {
        decodeCityWeatherInfo(city: city) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let weatherData):
                    print("-- City Added: \(weatherData.name)")
                    print(weatherData)
                    self.todayViewModel = TodayViewModelConstructor.construct(from: weatherData)
                    self.setUp()
                
                case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func decodeCityWeatherInfo(city: String, completion: @escaping (Result<WeatherData, Error>) -> ()) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric")!
        print("url\(url)")
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(WeatherData.self, from: data)
                    completion(.success(result))
                } catch{
                    completion(.failure(error))
                }
            }
        })
        task.resume()
    }
    
    private func setUp(){
        setUpIcon(iconName: todayViewModel?.getIconName ?? "sun")
        setUpCityLabel()
        setUpMainDescription()
        setUpCloudiness()
        setUpHumidity()
        setUpPressure()
        setUpWindSpeed()
        setUpWindDirection()
    }
    
    private func setUpCityLabel(){
        cityLabel.text = todayViewModel?.getCityLabel
    }
    
    private func setUpMainDescription(){
        mainDescription.text = todayViewModel?.getMainDescription
    }
    
    private func setUpCloudiness(){
        cloudinessLabel.text = todayViewModel?.getCloudiness
    }
    
    private func setUpHumidity(){
        humidityLabel.text = todayViewModel?.getHumidity
    }
    
    private func setUpPressure(){
        pressureLabel.text = todayViewModel?.getPressure
    }
    
    private func setUpWindSpeed(){
        windSpeedLabel.text = todayViewModel?.getWindSpeed
    }
    
    private func setUpWindDirection(){
        windDirectionLabel.text = todayViewModel?.getWindDirection
    }
    
    private func setUpIcon(iconName: String){
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        weatherIcon.image = UIImage(data: data!)
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.weatherIcon.image = UIImage(data: data)
            }
        }
    }
    
}
