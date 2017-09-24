//
//  WebServices+CurrentWeather.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 22/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit
import Alamofire

extension WebServices {

    @discardableResult internal func weatherDataAPI(successBlock: SuccessBlock?,
                                        failureBlock: FailureBlock?) -> DataRequest? {

        var path = "https://api.openweathermap.org/data/2.5/group?id=1277333,1275004,1264527,1275339,1261481&appid=484b8383944306ecf824464a2a61505c&units=metric"

        return manager.request(path, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let weatherDictionary = value as! [String:Any]
                    if let dataArray = weatherDictionary["list"] as? [[String:Any]] {
                        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
                        persistentContainer.performBackgroundTask { (context) in
                            dataArray.forEach { dictionary in
                                CityWeather.entityObject(fromDictionary: dictionary, context: context)
                            }

                            if context.hasChanges {
                                do {
                                    try context.save()
                                } catch {
                                    fatalError("Failure to save context: \(error)")
                                }
                            }

                            DispatchQueue.main.async {
                                if let successBlock = successBlock {
                                    successBlock(dataArray as AnyObject)
                                }
                            }
                        }
                    } else if let successBlock = successBlock {
                        successBlock(nil)
                    }
                case .failure(let error):
                    var errorDictionary: [String : Any]? = nil

                    defer {
                        let waError = WAError(dictionary: errorDictionary, error: error)
                        if let failureBlock = failureBlock {
                            failureBlock(waError)
                        }
                    }

                    guard let data = response.data else { return }

                    do {
                        errorDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                    } catch (let error) {
                        print("JSON Error: \(error)")
                    }
                }
        }
    }
}
