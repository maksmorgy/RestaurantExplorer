

import UIKit

class TableViewController: UITableViewController,  RestaurantManagerDelegate {
    
    var restaurantManager = RestaurantManager()
    var identifier = "ReusableCell"
    var mas = [RestaurantModel]()
    var masDetail = [RestaurantModel]()
    var conditionCity = String()
    var conditionCategory = String()
        
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantManager.delegate = self
        tableView.dataSource = self
        restaurantManager.makeRequest(category: conditionCategory, city: conditionCity)}
                                                                                                        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
                             
    @IBAction func buttonAction(_ sender: UIButton) {
        
        let inPath = IndexPath.init(row: 0, section: 0)
        let cell = tableView.cellForRow(at: inPath) as! StaticTableViewCell
        if let text = cell.cityTextField.text {
            conditionCity = text
            //restaurantManager.fetchRestaurant(cityStr: conditionCity)
            restaurantManager.makeRequest(category: conditionCategory, city: conditionCity)
        }
        cell.cityTextField.text = ""
  
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        var str: String
        //print(segmentControl.selectedSegmentIndex)
        switch segmentControl.selectedSegmentIndex {
        case 0:
            str = "restaurant"
        case 1:
            str = "cafe"
        case 2:
            str = "sushi"
        case 3:
            str = "pub"
        case 4:
            str = "pizza"
        default:
            str = "restaurant"
        }
        conditionCategory = str
        restaurantManager.makeRequest(category: conditionCategory, city: conditionCity)
        
        
    }
    
    
    
    func didUpdateValue(_ restaurantManager: RestaurantManager, restaurant: [RestaurantModel?]) {
        print(restaurant[0]?.code)
        if restaurant[0]?.code == nil {
    
        } else {
        mas.removeAll()
            for i in 0...restaurant.count - 1 {
                self.mas.append(restaurant[i]!)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    }
    
    func didFailWithError(error: Error) {
        print("error")
    }
    

    // MARK: - extension TableViewController: UITableViewDelegate, UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StaticCell", for: indexPath) as! StaticTableViewCell
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseIdentifire", for: indexPath) as! TableViewCell
            let restaurant = mas[indexPath.row]
            cell.nameLabel.text = restaurant.name
            cell.adressLabel.text = "City: \(restaurant.city) adress: \(restaurant.adress)"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
           return 50
        } else {
           return 100
            
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
        self.masDetail = [mas[indexPath.row]]
        performSegue(withIdentifier: "DetailSegue", sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let vc = segue.destination as! DetailViewController
            vc.mas = self.masDetail
        }
    }

    
}








    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


