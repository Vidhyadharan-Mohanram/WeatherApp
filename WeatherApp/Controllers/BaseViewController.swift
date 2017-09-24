//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 22/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WebServices.shared.reachability?.whenReachable = { _ in
            self.networkIsAvailable()
//            self.hideNoNetworkConnectionMessage()
        }

        WebServices.shared.reachability?.whenUnreachable = { _ in
            self.networkIsDown()
//            self.displayNoNetworkConnectionMessage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BaseViewController {

    @objc internal dynamic func networkIsAvailable() {

    }

    @objc internal dynamic func networkIsDown() {

    }
}
