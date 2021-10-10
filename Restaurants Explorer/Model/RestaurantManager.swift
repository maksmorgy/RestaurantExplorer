import Foundation

protocol RestaurantManagerDelegate {
    func didUpdateValue(_ restaurantManager: RestaurantManager, restaurant: [RestaurantModel?])
    func didFailWithError(error: Error)
}

class RestaurantManager {
    
    let restaurantURL = "https://api.foursquare.com/v2/venues/search?ll=39.7524669,-85.0032014&client_id=X5LKNHORQNIUXATZW0IZNBOCEQ4LU0G2Z2W4HQSHJSZ1FH0L&client_secret=DXZFNCHES4PP4W4FVED11315UIU4IZTETYNH1LRCWGAD1OUS&v=20210901"
    
    var delegate: RestaurantManagerDelegate?
    
    
    func makeRequest(category: String, city: String) {
        var request = String()
        if (category != "") && (city != "")  {
            request = "\(restaurantURL)&query=\(category)&near=\(city)"
            
        } else if city == "" && category != "" {
            request = "\(restaurantURL)&query=\(category)"
        } else if city != "" && category == "" {
            request = "\(restaurantURL)&near=\(city)"
        } else {
            request = "\(restaurantURL)&query=restaurant"
        }
        performRequest(urlString: request)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
           
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    return
                }
                if let safeData = data {
                    //print("The JSON response is \(json: safeData)")
                    let restaurant = self.parseJSON(restData: safeData)
                    self.delegate?.didUpdateValue(self, restaurant: restaurant)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(restData: Data) -> [RestaurantModel?] {
        let decoder = JSONDecoder()
        print("restData :\(restData)")
        
        do {
            let decodedData = try decoder.decode(RestaurantData.self, from: restData)
            guard decodedData.meta?.code! != 400 else {
                return [nil]
            }
            var restaurant = [RestaurantModel]()
            let count = (decodedData.response?.venues?.count)! - 1
            //print(decodedData.response?.venues?[0].name)
            for i in 0...count {
                    let name = (decodedData.response?.venues?[i].name) ?? "No information"
                    let adress = (decodedData.response?.venues?[i].location?.formattedAddress?[0]) ?? "No information"
                    let city = (decodedData.response?.venues?[i].location?.city) ?? "No information"
                    let code = (decodedData.meta?.code)!
                    let res = RestaurantModel(name: name, adress: adress, city: city, code: code)
                    restaurant.append(res)
            }
                return restaurant
            
            
            
            
        } catch  {
            assertionFailure("ERROR: \(error)")
            print("error4")
            return [nil]
        }
        
    }
}


extension String.StringInterpolation {
    mutating func appendInterpolation(json JSONData: Data) {
        guard
            let JSONObject = try? JSONSerialization.jsonObject(with: JSONData, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: JSONObject, options: .prettyPrinted) else {
            appendInterpolation("Invalid JSON data")
            return
        }
        appendInterpolation("\n\(String(decoding: jsonData, as: UTF8.self))")
    }
}


