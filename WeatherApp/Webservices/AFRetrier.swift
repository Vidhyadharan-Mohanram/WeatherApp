//
//  AFRetrier.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 22/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit
import Alamofire

class AFRetrier: RequestAdapter, RequestRetrier {
    private let maxRetryCount: UInt = 2

    internal func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
//        var urlRequest = urlRequest
//        if let accessToken = accessToken {
//            urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//        }

        return urlRequest
    }

    internal func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        print("error code \(String(describing: error._code))")
        if error._code == NSURLErrorTimedOut || error._code == -1005 {
            completion(false, 0.0)
            return
        }

        print("status code \(String(describing: request.response?.statusCode))")
        if let statusCode = request.response?.statusCode, (statusCode == 400 || statusCode == 500) {
            completion(false, 0.0)
            return
        }

        if request.retryCount < maxRetryCount {
            completion(true, 0.0)
        } else {
            completion(false, 0.0)
        }
    }
}
