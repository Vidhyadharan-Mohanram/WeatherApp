//
//  DateExtension.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 23/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import Foundation

extension Date {

    func dateString() -> String {
        let template = "EEEEdMMMM"

        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: NSLocale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: self) // ex: Sunday, Mar 5

    }
}
