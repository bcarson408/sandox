//
//  PositionsTableViewController.swift
//  sandbox
//
//  Created by Brant Carson on 11/18/15.
//  Copyright (c) 2015 Brant Carson. All rights reserved.
//

import UIKit

class PositionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let dfs_positions = ["Quarterback","RunningBack","Wide Reciever","Tight End","Flex","Defense"]
    let data=[]
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dfs_positions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("position_cell", forIndexPath: indexPath) as UITableViewCell
       
        // Configure the cell...
        cell.textLabel?.text = dfs_positions[indexPath.row]
        cell.detailTextLabel?.text = ""
        return cell
    }

   override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "DFS Positions"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "quarterbacks_segue":
                    let cell = sender as UITableViewCell
                    if let indexPath = tableView.indexPathForCell(cell)
                    {
                        switch indexPath.row {
                        case 0:
                            let seguedToMVC = segue.destinationViewController as UITableViewController
                         default: break
                        }
                    }
                default: break
            }
           
            }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let cell = sender as UITableViewCell
//        if let indexPath = tableView.indexPathForCell(cell){
//                switch indexPath.row {
//                    case 0:
//                        if let identifier = segue.identifier {
//                            switch identifier {
//                            case "quarterbacks_segue":
//                                let seguedToMVC = segue.destinationViewController as UITableViewController
//                            default: break
//                            }
//                        }
//                    case 1:break
//                    
//                    default: break
//                }
//        }
//        
//    }

   



}

