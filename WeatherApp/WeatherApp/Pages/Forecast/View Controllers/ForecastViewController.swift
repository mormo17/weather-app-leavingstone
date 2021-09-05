//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    var forecast = [ForecastViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addCity(city: "Tbilisi")
        setUp()
        
    }
    
    func setUp(){
        initTableView()
    }
    
    func initTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        registerTableView()
    }
    
    func registerTableView(){
        tableView.register(ForecastHeader.nib(), forCellReuseIdentifier: ForecastHeader.identifier)
        tableView.register(ForecastDescription.nib(), forCellReuseIdentifier: ForecastDescription.identifier)
    }
    
    func addCity(city: String){
        decodeCityWeatherInfo(city: city) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let weatherForecast):
                    for item in weatherForecast.list{
                        print("SINGLE ITEM")
                        print(item)
                        let viewModel = ForecastViewModelConstructor.construct(from: item)
                        self.forecast.append(viewModel)
                    }
                    
                    self.tableView.reloadData()
                
                case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func decodeCityWeatherInfo(city: String, completion: @escaping (Result<WeatherForecast, Error>) -> ()) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric")!
        print("URL")
        print(url)
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let result = try decoder.decode(WeatherForecast.self, from: data)
                    completion(.success(result))
                } catch{
                    completion(.failure(error))
                }
            }
        })
        task.resume()
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row % 5 == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: ForecastHeader.identifier, for: indexPath)
            if let tableViewCell = cell as? ForecastHeader{
                if forecast.count > indexPath.row {
                    print(forecast[indexPath.row].getDescription)
                    let viewModel = forecast[indexPath.row]
                    tableViewCell.configure(with: viewModel)
                }
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: ForecastDescription.identifier, for: indexPath)
            if let tableViewCell = cell as? ForecastDescription{
                if forecast.count > indexPath.row {
                    print(forecast[indexPath.row].getDescription)
                    let viewModel = forecast[indexPath.row]
                    tableViewCell.configure(with: viewModel)
                }
            }
        }
        
        
        return cell
    }
}

