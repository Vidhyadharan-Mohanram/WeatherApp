//
//	Main.swift
//
//	Create by Vidhyadharan Mohanram on 22/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Main : NSManagedObject{

	@NSManaged var cityWeather : CityWeather!
	@NSManaged var humidity : Int
	@NSManaged var temp : Float
	@NSManaged var tempMax : Int
	@NSManaged var tempMin : Int

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    internal convenience init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName:"Main", in: context)!
		self.init(entity: entity, insertInto: context)
		if let cityWeatherData = dictionary["cityWeather"] as? [String:Any]{
			cityWeather = CityWeather(fromDictionary: cityWeatherData, context:context)
		}
		if let humidityValue = dictionary["humidity"] as? Int{
			humidity = humidityValue
		}
		if let tempValue = dictionary["temp"] as? Float{
			temp = tempValue
		}
		if let tempMaxValue = dictionary["temp_max"] as? Int{
			tempMax = tempMaxValue
		}
		if let tempMinValue = dictionary["temp_min"] as? Int{
			tempMin = tempMinValue
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	internal func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cityWeather != nil{
			dictionary["cityWeather"] = cityWeather.toDictionary()
		}
		dictionary["humidity"] = humidity
		dictionary["temp"] = temp
		dictionary["temp_max"] = tempMax
		dictionary["temp_min"] = tempMin
		return dictionary
	}

}
