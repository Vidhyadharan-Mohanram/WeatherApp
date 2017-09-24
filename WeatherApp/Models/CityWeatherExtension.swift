//
//  CityWeatherExtension.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 22/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit
import CoreData

extension CityWeather {

    internal static var isEmpty: Bool {
        do {
            let entityName = String(describing: CityWeather.self)
            let fetchRequest = NSFetchRequest<CityWeather>(entityName: entityName)

            let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
            let context = persistentContainer.viewContext
            let count  = try context.count(for: fetchRequest)
            return count == 0 ? true : false
        } catch {
            return true
        }
    }

    @discardableResult internal class func entityObject(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext) -> CityWeather? {
        let entityName = String(describing: CityWeather.self)
        let fetchRequest = NSFetchRequest<CityWeather>(entityName: entityName)
        let cityId = dictionary["id"] as! Int
        
        fetchRequest.predicate = NSPredicate(format: "id == %d", cityId)

        if let cityWeather = try! (context.fetch(fetchRequest)).last {
            cityWeather.reset()
            cityWeather.update(fromDictionary: dictionary, context: context)
            return cityWeather
        } else {
            return CityWeather(fromDictionary: dictionary, context: context)
        }
    }

    private func reset() {
        main = nil
        name = nil

        for weatherElement in weather {
            self.managedObjectContext?.delete(weatherElement)
        }
    }

}
