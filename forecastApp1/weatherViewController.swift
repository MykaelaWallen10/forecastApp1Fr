//
//  weatherViewController.swift
//  forecastApp1
//
//  Created by MYKAELA WALLEN on 1/28/24.
//

struct FrList : Codable{
    var list : [List]
}

struct List : Codable{
    var main : Main
    var weather : [Weather]
}

struct Main : Codable{
    var feels_like : Double
    var humidity : Int
    var temp : Double
    var temp_max : Double
    var temp_min : Double
}

struct Weather : Codable{
    var description : String
}

import UIKit

class weatherViewController: UIViewController {
    
    
    var incoming : Int!
    
    @IBOutlet weak var feelslikeLabel: UILabel!
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var maxTemplabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(incoming!)
        

        weatherStuff()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        

    }
        
        func weatherStuff(){
            //creating an object of the URL session class to make an API call
            let session = URLSession.shared
            
            //creating URL for API call (NEED API KEY and then replace things in curly brace w API key )
            let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=42.24&lon=-88.31&units=imperial&appid=4409b09751fe9dcbbb01ce7292629520")
            //completion handlers are functions that automatically get called in the function of this
            print("data")
           
            
            //actually making an api call and creating data in the completion handler
                   //completion handlers are functions that automatically get called in the function of this
                   //completion handler : happens on a diff thread, could take time to get data
            let dataTask = session.dataTask(with: weatherURL!) { (data: Data?, response:URLResponse?, error:Error?) in
                print("completion handler")
                if let e = error {
                    print("\(e)")
                }
                
                else{
                    
                    //if there is data
                    if let d = data{
                        print("found data")
                        
                        //convert data to scon OBJect
                        if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary{
                            print("\(jsonObj)")
                
                            
     // saying try to make it a String and if you can title is no longer optiional
         //step 2 JSONDecoder() builds a new object of the class using the provided innit, .decode() is a fuction in the JSONDecoder class
     //first parameter in decode() is the name of the struct/class that you want to decode it to
      //overall creating an object of JSONDecoder and then calling the function for that new object

                            if let weatherObj = try? JSONDecoder().decode(FrList.self, from: d){
                                print("created array")
                                
                                
                               
                             
                                    self.incoming = self.incoming * 8
                                
                               
                                print(weatherObj.list[self.incoming].weather.description)
                               
                                print(self.incoming!)
                                
                                DispatchQueue.main.async {
                                    self.feelslikeLabel.text = "\(weatherObj.list[self.incoming].main.feels_like)"
                                    self.tempLabel.text = "\(weatherObj.list[self.incoming].main.temp)"
                                    self.humidityLabel.text = "\(weatherObj.list[self.incoming].main.humidity)"
                                    self.maxTemplabel.text = "\(weatherObj.list[self.incoming].main.temp_max)"
                                    self.minTempLabel.text = "\(weatherObj.list[self.incoming].main.temp_min)"


                                }
                               

                                }
                           
             
                            
                           
                            else{
                                print("couldnt find search")
                            }
                            

                            
                        }
                        else{
                            print("cant converst JSon to object")
                        }
                    }
                    else{
                        print("cant find data!")
                    }
                }
            }
                    
                
            
            
            dataTask.resume()
            
            

        }
       
    
    
    
 

}
