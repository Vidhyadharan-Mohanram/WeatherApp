//
//	Weather.swift
//
//	Create by Vidhyadharan Mohanram on 22/9/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import CoreData

class Weather : NSManagedObject{

	@NSManaged var cityWeather : CityWeather!
	@NSManaged var descriptionField : String!
	@NSManaged var icon : String!
	@NSManaged var id : Int
	@NSManaged var main : String!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    internal convenience init(fromDictionary dictionary: [String:Any], context: NSManagedObjectContext)	{
        let entity = NSEntityDescription.entity(forEntityName:"Weather", in: context)!
		self.init(entity: entity, insertInto: context)
		if let cityWeatherData = dictionary["cityWeather"] as? [String:Any]{
			cityWeather = CityWeather(fromDictionary: cityWeatherData, context:context)
		}
		if let descriptionFieldValue = dictionary["description"] as? String{
			descriptionField = descriptionFieldValue
		}
		if let iconValue = dictionary["icon"] as? String{
			icon = iconValue
		}
		if let idValue = dictionary["id"] as? Int{
			id = idValue
		}
		if let mainValue = dictionary["main"] as? String{
			main = mainValue
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
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if icon != nil{
			dictionary["icon"] = icon
		}
		dictionary["id"] = id
		if main != nil{
			dictionary["main"] = main
		}
		return dictionary
	}

}
