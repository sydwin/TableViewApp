//
//  ViewController.swift
//  TableStory
//
//  Created by masscomm on 3/17/25.
//

import UIKit
import MapKit

//array objects of our data.
let data = [
    Item(name: "Saigon Arts Matcha Cafe", neighborhood: "Matcha Cold Foam", desc: "Love matcha the way it comes but want to switch it up? Indulge in the creamy, velvety texture of cold foam paired with the earthy richness of matcha. This drink is best served cold, as hot matcha may melt the cold foam and ultimately diminish its purpose. Tip: use different flavors to alter the cold foam.", lat: 29.7604, long: -95.3698, imageName: "coldfoam.jpg"),
    Item(name: "Matcha Cafe Maiko", neighborhood: "Matcha Ice Cream", desc: "Beat the heat with this icy, vibrant green treat. A frozen matcha can be altered to one's liking in many ways outside of the recipe linked below. A personal favorite is topping matcha ice cream with condensed milk. Fruit is also a great addition! Whether made to have an ice cream or slushie texture, a forzen matcha is cool, refreshing, and packed with energy.", lat: 30.313960, long: -97.7431, imageName: "frozen.jpg"),
    Item(name: "Magick Matcha", neighborhood: "Strawberry Matcha", desc: "Strawberries and matcha are great on their own, but together? Now we're talking! Strawberry puree on the bottom and top of an iced matcha latte is a great way to add some color and flavor to your matcha. Don't have fresh strawberries? Strawberry syrup can be a good substitute too! Enjoy a burst of fruity flavor with a hint of zen.", lat: 30.2672, long: -97.7431, imageName: "strawberry.jpg"),
    Item(name: "Coffee Fellow", neighborhood: "Chai Matcha Latte", desc: "Ever find yourself deciding between a spicy or sweet tooth? This chai-matcha is the best of both worlds! Customize the ratio to your liking, a personal recommendation is a 50/50 ratio, but you do you! A harmonious blend of spicy chai and earthy matcha. This latte is a warm, comforting hug in a mug, perfect for chilly mornings. ", lat: 29.7604, long: -95.3698, imageName: "chai.jpg"),
    Item(name: "Bites by Bianca", neighborhood: "Hyde Park", desc: "These matcha brownies are a matcha lover's dream! A personal favorite is combining mini white and milk chocolate chips to the batter, as well as an extra scoop of matcha powder and vanilla extract. Chewy, fudgy, and infused with the vibrant flavor of green tea. Simply the perfect sweet treat!", lat: 32.7555, long: -97.3308, imageName: "brownie.jpg")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
 {

    @IBOutlet weak var theTable: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      
      //Add image references
                  let image = UIImage(named: item.imageName)
                  cell?.imageView?.image = image
                  cell?.imageView?.layer.cornerRadius = 10
                  cell?.imageView?.layer.borderWidth = 5
                  cell?.imageView?.layer.borderColor = UIColor.white.cgColor
                  
      
      return cell!
  }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
         
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        theTable.delegate = self
        theTable.dataSource = self
        //add this code in viewDidLoad function in the original ViewController, below the self statements

           //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

             
    }


}

