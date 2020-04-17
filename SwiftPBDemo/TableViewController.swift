//
//  TableViewController.swift
//  SwiftPBDemo
//
//  Created by XW on 2020/4/9.
//  Copyright © 2020 XW. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let arr = ["AA","BB","CC","DD"]
    let tableviewArr = [ProtobufViewController.self,AlamofilreViewController.self,WebsocketViewController.self, EDSocketViewController.self, EDSocketViewController2.self]
    
    let cellID = "cellID"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        preparUI()
    }

    func preparUI() -> Void {
        navigationItem.title = "TableViewController"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableviewArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID);
        if (cell == nil) {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellID)
        }

        // Configure the cell...
//        cell?.backgroundColor = UIColor.green
        cell?.textLabel?.text = tableviewArr[indexPath.row].description()

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(tableviewArr[indexPath.row].init(), animated: true)
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

}
