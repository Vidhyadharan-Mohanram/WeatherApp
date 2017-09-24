//
//  WeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 23/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit
import Kingfisher

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet fileprivate var detailedView: UIView!

    @IBOutlet fileprivate var detailedCityLabel: UILabel!
    @IBOutlet fileprivate var detailedDateLabel: UILabel!
    @IBOutlet fileprivate var detailedTempLabel: UILabel!
    @IBOutlet fileprivate var detailedMainLabel: UILabel!
    @IBOutlet fileprivate var detailedMainImageView: UIImageView!
    @IBOutlet fileprivate var detailedMinMaxTempLabel: UILabel!
    @IBOutlet fileprivate var detailedHumidityLabel: UILabel!

    @IBOutlet fileprivate var summaryView: UIView!
    @IBOutlet fileprivate var summaryCityLabel: UILabel!
    @IBOutlet fileprivate var summaryMainImageView: UIImageView!
    @IBOutlet fileprivate var summaryMinMaxTempLabel: UILabel!

    override internal var isSelected: Bool {
        didSet {
            if oldValue == false, isSelected == true {
                showDetailedView()
            } else if oldValue == true, isSelected == false {
                showSummaryView()
            }
        }
    }

    internal var cityWeather: CityWeather? {
        didSet {
            configureCell()
        }
    }

    private func showDetailedView() {
        UIView.animate(withDuration: 0.33, animations: {
            self.summaryView.alpha = 0.0
        }) { (completed) in
            self.summaryView.isHidden = true
        }
    }

    private func showSummaryView() {
        summaryView.isHidden = false
        summaryView.alpha = 0.0
        UIView.animate(withDuration: 0.33, animations: {
            self.summaryView.alpha = 1.0
        })
    }

    private func configureCell() {
        guard let weatherData = cityWeather, let weather = Array(weatherData.weather).last else { return }
        summaryCityLabel.text = weatherData.name
        detailedCityLabel.text = summaryCityLabel.text

        detailedDateLabel.text = Date().dateString()

        detailedTempLabel.text = "\(weatherData.main.temp)º"

        detailedMainLabel.text = weather.main
        
        summaryMinMaxTempLabel.text = "\(weatherData.main.tempMax)º / \(weatherData.main.tempMin)º"
        detailedMinMaxTempLabel.text = summaryMinMaxTempLabel.text

        detailedHumidityLabel.text = "\(weatherData.main.humidity)%"

//        http://openweathermap.org/weather-conditions
//      Since there are a lot of weather conditions and not a lot of images to use, the following code downloads images from the openweather server
//        let urlString = WebServices.shared.baseWeatherIconURL.replacingOccurrences(of: "{iconID}", with: weather.icon)
//        let imageURL = URL(string: urlString)
//        summaryMainImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "cloud 1")) { (image, _, _, _) in
//            summaryMainImageView.image = image
//            detailedMainImageView.image = image
//        }

        switch weather.id {
        case 200...299: // Thunderstorm
            summaryMainImageView.image = #imageLiteral(resourceName: "cloud 1")
        case 300...399: // Drizzle
            fallthrough
        case 500...599: // Rain
            summaryMainImageView.image = #imageLiteral(resourceName: "rainy")
        case 600...699: // Snow
            summaryMainImageView.image = #imageLiteral(resourceName: "cloud 1")
        case 700...799: // Atmosphere
            summaryMainImageView.image = #imageLiteral(resourceName: "cloud2")
        case 800: // Clear
            summaryMainImageView.image = #imageLiteral(resourceName: "cloud2")
        case 801...899: // Clouds
            summaryMainImageView.image = #imageLiteral(resourceName: "cloud2")
        case 900...909: // Extreme
            fallthrough
        case 910...999: // Additional
            fallthrough
        default:
            summaryMainImageView.image = #imageLiteral(resourceName: "cloud 1")
        }
        detailedMainImageView.image = summaryMainImageView.image

    }
    
}
