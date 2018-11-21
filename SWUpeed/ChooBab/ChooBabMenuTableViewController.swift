//
//  MenuTableViewController.swift
//  SWUpeed
//
//  Created by dm12 on 2018. 1. 11..
//  Copyright © 2018년 Yeajin Kwon. All rights reserved.
//

import UIKit

class ChooBabMenuTableViewController: UITableViewController {

    var menu : [String: String] = ["치3":"(날치알 + 김치볶음 + 참치마요)" , "곱츄":"(곱창 + 김치)" , "양념갈비":"(돼지고기 + 양념갈비소스)"
                                    ,"참치마요":"(참치 + 스위트콘 + 마요소스)", "새우햄김치볶음":"(새우가루 + 햄 + 김치볶음 + 참치마요)" ]
    var chooseMenu: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath)
        
        let menuTitle = Array(menu.keys)[indexPath.row]
        let menuDetail = Array(menu.values)[indexPath.row]
        
        cell.textLabel?.text = menuTitle
        cell.detailTextLabel?.text = menuDetail

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToOrder"{
            let dest = segue.destination as! ChooBabOrderViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)!
            dest.menuName = Array(menu.keys)[indexPath.row]
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
