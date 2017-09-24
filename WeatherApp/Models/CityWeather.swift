//
//	CityWeather.swift
//
//	Create by Vidhyadharan Mohanram on 22/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class CityWeather : NSManagedObject{

    @NSManaged var id : Int
	@NSManaged var main : Main!
	@NSManaged var name : String!
	@NSManaged var weather : Set<Weather>!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    internal convenience init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entityName = String(describing: CityWeather.self)
        let entity = NSEntityDescription.entity(forEntityName:entityName, in: context)!
		self.init(entity: entity, insertInto: context)
        update(fromDictionary: dictionary, context: context)
	}

    internal func update(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext) {
        if let idValue = dictionary["id"] as? Int{
            id = idValue
        }
        if let mainData = dictionary["main"] as? [String:Any]{
            main = Main(fromDictionary: mainData, context:context)
        }
        if let nameValue = dictionary["name"] as? String{
            name = nameValue
        }
        if let weatherArray = dictionary["weather"] as? [[String:Any]]{
            var weatherSet = Set<Weather>()
            for dic in weatherArray{
                let value = Weather(fromDictionary: dic, context:context)
                weatherSet.insert(value)
            }
            weather = weatherSet
        }
    }

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	internal func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		dictionary["id"] = id
		if main != nil{
			dictionary["main"] = main.toDictionary()
		}
		if name != nil{
			dictionary["name"] = name
		}
		if weather != nil{
			var dictionaryElements = [[String:Any]]()
			for weatherElement in weather {
                dictionaryElements.append(weatherElement.toDictionary())
			}
			dictionary["weather"] = dictionaryElements
		}
		return dictionary
	}

}
