//
//  SplashViewController.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 23/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit
import CoreData

class SplashViewController: BaseViewController {
    fileprivate let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer

    @IBOutlet fileprivate var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.checkForWeatherData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func checkForWeatherData() {
        if CityWeather.isEmpty {
            getWeatherData()
        } else {
            performSegue(withIdentifier: "Show Weather Data", sender: nil)
        }
    }
}

//  MARK: API Calls
extension SplashViewController {
    fileprivate func getWeatherData() {
        WebServices.shared.weatherDataAPI(successBlock: { (data) in
            self.performSegue(withIdentifier: "Show Weather Data", sender: nil)
        }) { (errorObject) in
            if let error = errorObject {
                if error.errorType == .noInternetError {
                    self.statusLabel.text = "No Internet Connection"
                    return
                }
            }
            self.statusLabel.text = "Unable to get data"
        }
    }
}

//  MARK: Reachability
extension SplashViewController {
    internal override func networkIsAvailable() {
        super.networkIsAvailable()

        guard CityWeather.isEmpty else { return }
        getWeatherData()
    }
}
