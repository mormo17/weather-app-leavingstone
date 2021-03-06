//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit
import CoreLocation

class TodayViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var todayViewModel: TodayViewModel? = nil
    private static var currentCityLabel = ""
    private static var currentCity = ""
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.isHidden = false
        loader.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpLocation()
    }
    
    func setUpLocation(){
        if (!TodayViewController.currentCityLabel.isEmpty){ return }
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        let weatherDesc = todayViewModel?.getShareText
        let activityVC = UIActivityViewController(activityItems: [weatherDesc as Any], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, TodayViewController.currentCityLabel == "" {
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(locations.first!, completionHandler: { (placemarks, error) -> Void in
                    let placemark = placemarks?[0]
                    if let city = placemark?.locality{
                        TodayViewController.currentCityLabel = city
                            DispatchQueue.main.async {
                                self.addCity(city: city.replacingOccurrences(of: Constants.SPACE, with: Constants.SPACE_URL_ENCODING))
                            }
                        
                        self.loader.stopAnimating()
                    }
                })
                locationManager.stopUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error:", error)
        }
    
    func addCity(city: String) {
        decodeCityWeatherInfo(city: city) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let weatherData):
                    self.todayViewModel = TodayViewModelConstructor.construct(from: weatherData)
                    self.setUp()
                    self.loader.stopAnimating()
                    self.topView.isHidden = true
                    
                
                case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func decodeCityWeatherInfo(city: String, completion: @escaping (Result<WeatherData, Error>) -> ()) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constants.apiKey)&units=metric")
        let request = URLRequest(url: url!)
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
        setUpIcon(iconName: todayViewModel?.getIconName ?? Constants.DEFAULT_IMAGE_NAME)
        setUpCityLabel()
        setUpMainDescription()
        setUpCloudiness()
        setUpHumidity()
        setUpPressure()
        setUpWindSpeed()
        setUpWindDirection()
    }
    
    private func setUpCityLabel(){
        TodayViewController.currentCity = todayViewModel!.getCity
        TodayViewController.currentCityLabel = todayViewModel!.getCityLabel
        cityLabel.text = TodayViewController.currentCityLabel
         
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
    
    public static func getCurrentCity() -> String { return currentCity.replacingOccurrences(of: Constants.SPACE, with: Constants.SPACE_URL_ENCODING) }
    
    public static func getCurrentCityLabel() -> String { return currentCityLabel }
    
    private func setUpIcon(iconName: String){
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        weatherIcon.image = UIImage(data: data!)
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.weatherIcon.image = UIImage(data: data)
            }
        }
    }
    
}
