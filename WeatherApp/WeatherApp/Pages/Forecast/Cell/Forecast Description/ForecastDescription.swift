//
//  ForecastDescription.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastDescription: UITableViewCell {
    static let identifier = "ForecastDescription"
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with model: ForecastViewModel){
        setUpIcon(iconName: model.getIconName)
        setUpTime(timeToSet: model.getTime)
        setUpDescription(descriptionToSet: model.getDescription)
        setUpTemperature(temperatureToSet: model.getTemperature)
    }
    
    private func setUpIcon(iconName: String){
//        let url = URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")!
//        downloadImage(from: url)
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
    
    private func setUpTime(timeToSet: String){
        timeLabel.text = timeToSet
    }
    
    private func setUpDescription(descriptionToSet: String){
        descriptionLabel.text = descriptionToSet
    }
    
    private func setUpTemperature(temperatureToSet: String){
        temperatureLabel.text = temperatureToSet
    }
    
}
