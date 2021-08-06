//
//  CountryTableViewController.swift
//  CountriesOfTheWorld
//
//  Created by David McMeekin on 17/2/21.
//

import UIKit

class CountryTableViewController: UITableViewController {
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    var countries: [Country] = [
        Country(flag: "🇦🇺", name: "Australia", region: "Oceania", population: "24.13m"),
        Country(flag: "🇳🇿", name: "New Zealand", region: "Oceania", population: "4.69m"),
        Country(flag: "🇨🇦", name: "Canada", region: "North America", population: "36.3m"),
        Country(flag: "🇳🇴", name: "Norway", region: "Scandinavia", population: "3.8m"),
        Country(flag: "🇸🇧", name: "Solomon Islands", region: "Micronesia", population: "611k"),
        Country(flag: "🇮🇳", name: "India", region: "South Asia", population: "1.324b"),
        Country(flag: "🇨🇳", name: "China", region: "East Asia", population: "1.379b"),
        Country(flag: "🇬🇲", name: "Gambia", region: "West Africa", population: "2.039m"),
        Country(flag: "🇨🇱", name: "Chile", region: "South America", population: "17.91m"),
        Country(flag: "🇨🇴", name: "Colombia", region: "South America", population: "48.65m"),
        Country(flag: "🇩🇪", name: "Germany", region: "Europe", population: "82.67m"),
        Country(flag: "🇬🇹", name: "Guatemala", region: "Central America", population: "16.58m"),
        Country(flag: "🇬🇾", name: "Guyana", region: "South America", population: "773k"),
        Country(flag: "🇦🇪", name: "United Arab Emirates", region: "Western Asia", population: "9.4m"),
        Country(flag: "🇦🇱", name: "Albania", region: "Balkan Peninsula", population: "2.873m"),
        Country(flag: "🇪🇹", name: "Ethiopia", region: "Horn of Africa", population: "105m"),
        Country(flag: "🇦🇪", name: "Greece", region: "South Eastern Europe", population: "10.77m"),
        Country(flag: "🇰🇬", name: "Kyrgyzstan", region: "Central Asia", population: "6.2m")
    ]
 
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return countries.count
        }
        else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryTableViewCell

        let country = countries[indexPath.row]
        cell.update(with: country)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let country = countries[indexPath.row]
//        print("\(country.flag) \(indexPath)")
//    }
//    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            countries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()

//            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
   

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedCountry = countries.remove(at: fromIndexPath.row)
        countries.insert(movedCountry, at: to.row)
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func unwindToFlagTableView(segue : UIStoryboardSegue){
        guard segue.identifier == "saveUnwind",
            let sourceViewControlller = segue.source as? AddEditFlagTableViewController,
            let flag = sourceViewControlller.flag else {return}
        if let seletectedIndexPath = tableView.indexPathForSelectedRow{
            countries[seletectedIndexPath.row] = flag
            tableView.reloadData()
        }
        else
        {
            let newIndexPath = IndexPath(row: countries.count, section: 0)
            countries.append(flag)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditFlag"{
            let indexPath = tableView.indexPathForSelectedRow!
            let flag = countries[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditFlageTableViewController = navController.topViewController as! AddEditFlagTableViewController
            addEditFlageTableViewController.flag = flag
        }
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     
}
