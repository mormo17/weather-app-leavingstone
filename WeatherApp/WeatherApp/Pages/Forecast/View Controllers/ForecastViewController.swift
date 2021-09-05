//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var forecast = [ForecastCellModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addCity(city: "Tbilisi")
        setUp()
        
    }
    
    func setUp(){
        initTableView()
    }
    
    func initTableView(){
        tableView.isHidden = true
        loader.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        registerTableView()
    }
    
    func registerTableView(){
        tableView.register(ForecastHeader.nib(), forHeaderFooterViewReuseIdentifier: ForecastHeader.identifier)
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
                        if self.forecast.last == nil || viewModel.isNewDay{
                            let weekDay = viewModel.getWeekDay
                            let headerModel = ForecastHeaderModel(weekDay: weekDay)
                            let sectionToAdd = ForecastCellModel(headerModel: headerModel, rowModels: [])
                            self.forecast.append(sectionToAdd)
                        }
                        
                        self.forecast[self.forecast.count-1].rowModels.append(viewModel)
                    }
                    self.tableView.isHidden = false
                    self.loader.stopAnimating()
                    self.loader.isHidden = true
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecast.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast[section].rowModels.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: ForecastDescription.identifier, for: indexPath)
        if let tableViewCell = cell as? ForecastDescription{
            let viewModel = forecast[indexPath.section].rowModels[indexPath.row]
            tableViewCell.configure(with: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ForecastHeader.identifier)
        if let forecastHeader = header as? ForecastHeader{
            forecastHeader.configure(with: forecast[section].headerModel)
            return forecastHeader
        }
        return nil
    }
}

