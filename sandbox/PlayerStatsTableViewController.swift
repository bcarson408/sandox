//
//  PlayerStatsTableViewController.swift
//  sandbox
//
//  Created by Brant Carson on 11/20/15.
//  Copyright (c) 2015 Brant Carson. All rights reserved.
//

import UIKit

class PlayerStatsTableViewController: UITableViewController,QuarterbacksDataSource {

    var delegate:QuarterbacksDataSource?
    var dataSource:Quarterbacks?
    var player:[String:AnyObject]?
    var dfs:Dfs_player?
    
 
    
//    func verifyData(newData:AnyObject) -> Dfs_player {
//        var result:Dfs_player
//        if dataSource != nil  {
//            result = newData as Dfs_player
//        } else {
//            result = newData as Dfs_player
//        }
//        return result
//    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
            self.clearsSelectionOnViewWillAppear = true
            self.navigationItem.rightBarButtonItem = self.editButtonItem()
            var myData = dataSource
            var dfs = myData?.createPlayerStats(player!, withThesesStats: myData!)
       
      
        // Uncomment the following line to preserve selection between presentations
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var count:Int
        switch section {
        case 0:
            count = 12
        case 1:
            count = 4
        case 2:
            count = 4
        case 3:
            count = 12
        case 4:
            count = 9
        default:
            count = 6
        }
        
       return count    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionLabel:String
        
        
        switch section {
        case 0:
            sectionLabel = "Player Stats"
            break
        case 1:
            sectionLabel = "Projected Points"
            break
        case 2:
            sectionLabel = "Player Stats2"
            break
        case 3:
            sectionLabel = "Player Stats3"
            break
        default:
            sectionLabel = "Player Stats"
            break
        }
        
        return sectionLabel 
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("stats_cell", forIndexPath: indexPath) as UITableViewCell
        var keys = [String]()
        var values = [String]()
        var myData = dataSource
        var dfs = myData?.createPlayerStats(player!, withThesesStats: myData!)

        
        
        switch indexPath.section {
        case 0:
//            sectionKeys = dfs?.playerStats.keys.array
//            sectionValues = dfs?.playerStats.values.array
            for st in dfs?.playerStats.keys.array as Array! {
                cell.textLabel?.text = dfs?.playerStats.keys.array[indexPath.row]
                cell.detailTextLabel?.text = dfs?.playerStats.values.array[indexPath.row] as? String
               
            }
            case 1:
                for x in dfs?.projectePoints.keys.array as Array! {
                cell.textLabel?.text = dfs?.projectePoints.keys.array[indexPath.row]
                cell.detailTextLabel?.text = dfs?.projectePoints.values.array[indexPath.row] as? String
            }
                   default:
       cell.textLabel?.text = " "
            //            cell.detailTextLabel?.text  = myData.keys.array[indexPath.row]
        }
        
         return cell
    }

       
        
    


 
    func player_stats(sender: NSDictionary) -> NSDictionary? {
        
        return sender
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "player_stats_segue":
                let cell = sender as UITableViewCell
                if let indexPath = tableView.indexPathForCell(cell)
                {
                    let seguedToMVC = segue.destinationViewController as QuarterbacksTableViewController
                }
            default: break
            }
        }

    }
    
}
