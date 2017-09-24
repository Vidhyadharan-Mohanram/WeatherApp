//
//  Webservices.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 22/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit
import Alamofire
import Reachability

class WebServices: NSObject {

    internal let baseWeatherIconURL = "https://openweathermap.org/img/w/{iconID}.png"

    public typealias SuccessBlock = ((_ data: AnyObject?) -> Void)
    public typealias FailureBlock = ((_ error: WAError?) -> Void)

    internal let reachability = Reachability(hostname: "www.google.com")

    internal var manager: SessionManager!

    override init() {
    }

    @objc public static let shared: WebServices = {
        let instance = WebServices()
        instance.setUpReachability()
        instance.manager = SessionManager()

        let adapterAndRetrier = AFRetrier()
        instance.manager.adapter = adapterAndRetrier
        instance.manager.retrier = adapterAndRetrier

        instance.manager?.session.configuration.requestCachePolicy = .reloadIgnoringCacheData

        return instance
    }()
}

//  MARK: Reachability

extension WebServices {
    fileprivate func setUpReachability() {
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to init reachability")
        }
    }
}
