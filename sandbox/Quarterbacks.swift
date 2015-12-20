//
//  Quarterbacks.swift
//  Testing
//
//  Created by J. Brant Carson on 11/12/15.
//  Copyright © 2015 J. Brant Carson. All rights reserved.
//

import Foundation

protocol QuarterbacksDataSource:class {
    func player_stats(sender:NSDictionary)->NSDictionary?
//    func verifyData(newData:AnyObject) -> Dfs_player
}

// MARK OPERATOR

func + <K,V>(left:Dictionary<K,V>,right:Dictionary<K,V>) -> Dictionary<K,V> {
    
    var map = Dictionary<K,V>()
    for (k,v) in left {
        map[k] = v
    }
    for (k,v) in right {
        map[k] = v
    }
    
    return map
}

// MARK: - dfs_Player

class Dfs_player {
    var playerStats = [String:AnyObject]() // dictionary
    var projectePoints = [String:AnyObject]() // dictionary
    var ceilingAndConsistency = [String:AnyObject]() // dictionary
    var advanceStats = [String:AnyObject]() // dictionary
    var defensiveStats = [String:AnyObject]() // dictionary
    var allStats = [[String:AnyObject]]()
    func big() -> [String:AnyObject] {
        return playerStats + projectePoints + advanceStats + defensiveStats
    }
    var newDefStats:[String:AnyObject] {
        get {
            return defensiveStats
        }
        set(newStat) {
            defensiveStats = newStat
        }
    }
    
 func getAllStats() -> [[String:AnyObject]] {
            allStats.append(playerStats)
            allStats.append(projectePoints)
            allStats.append(advanceStats)
            allStats.append(defensiveStats)
        return allStats
    }
    
  
}


// MARK: - Quarterbacks

class Quarterbacks {
    var playerStats = [String:AnyObject]() // dictionary
    var defensiveStats = [String:AnyObject]() // dictionary
    var projectePoints = [String:AnyObject]() // dictionary
    var ceilingAndConsistency = [String:AnyObject]() // dictionary
    var advanceStats = [String:AnyObject]() // dictionary
//  var advanceStats = [String:AnyObject]() // dictionary
    var somePlayer:Dfs_player
    var updatedStats = [[String:AnyObject]]() // Array
    var thisWeeksQBs = [AnyObject]() // Array
    var weeklyDefensiveStats = [[String:AnyObject]]() // Array
    var weeklyProjectedPoints = [[String:AnyObject]]() // Array
    var weeklyadvanceStats = [[String:AnyObject]]() // Array
    var ceilingAndConsistencyStats = [[String:AnyObject]]() // Array
    init() {
        var pl:[String:AnyObject]
        weak var dataSource:QuarterbacksDataSource?
        somePlayer = Dfs_player()
        getQBdataFile()
        getDefense_vs_qb()
        getProjectedPoints()
        getAdvanceStats()
        consistencyAndCeiling()
//        updated_stats()
//        consistencyAndCeiling()
//         addDefensiveStats1()
//        thisWeeksQuarterBacks()
    }
    func getQBdataFile(){
        let dataFile="/Users/brcarson/DRAFT_KINGS/qb_week14b.csv"
        if let data = NSData(contentsOfURL:NSURL.init(fileURLWithPath:dataFile)!) {
            if let content = NSString(data: data, encoding: NSUTF8StringEncoding) {
                for player in content.componentsSeparatedByString("\n"){
                    if player as NSString == "" {
                        break
                    }
                    var temp:[AnyObject] = []
                    for stats in player.componentsSeparatedByString(","){
                        if stats as NSString == "" {
                            break
                        }
                        temp.append(stats)
                    }
                    playerStats["player_name"] = temp[0]
                    var name = playerStats["player_name"] as String
                    var tempSalary = "\(temp[1])"
                    playerStats["player_salary"] = tempSalary
                    playerStats["player_opp"] = temp[2]
                    playerStats["player_gamesPlayed"] = temp[3]
                    playerStats["player_passingYards"] = temp[4]
                    playerStats["player_passindTDs"] = temp[5]
                    playerStats["player_rushingYards"] = temp[6]
                    playerStats["player_rushingTDs"] = temp[7]
                    playerStats["player_Receptions"] = temp[8]
                    playerStats["player_targeted"] = temp[9]
                    playerStats["player_recievingYards"] = temp[10]
                    playerStats["player_recievingTD's"] = temp[11]
                    
                    if temp.count == 13 {
                    playerStats["player_FPTS"] = temp[12]
                    }
                    
                    print("\(name)\n")
                    thisWeeksQBs.append(playerStats)
                
                }
                            }
        }
    }
    func getDefense_vs_qb() {
        let defenseAgainstQbDataFile  = "/Users/brcarson/DRAFT_KINGS/Defense_qb_w14.csv"
        if let defenseDataFile =  NSData(contentsOfURL:NSURL.init(fileURLWithPath:defenseAgainstQbDataFile)!) {
            if let defenseContent = NSString(data: defenseDataFile, encoding: NSUTF8StringEncoding) {
                for defense in defenseContent.componentsSeparatedByString("\n"){
                    if defense as NSString == "" {
                        break
                    }
                    var temp:[AnyObject] = []
                    for stats in defense.componentsSeparatedByString(","){
                        if stats as NSString == "" {
                            break
                        }
                        temp.append(stats)
                    }
                    defensiveStats["defense"] = temp[0]
                    defensiveStats["gamesPlayed"]  = temp[1]
                    defensiveStats["passing_yards_allowed"]  = temp[2]
                    defensiveStats["passing_td_allowed"]  = temp[3]
                    defensiveStats["rushing_td_allowed"]  = temp[5]
                    defensiveStats["rushing_yards_allowed"]  = temp[4]
                    defensiveStats["receptions"]  = temp[5]
                    defensiveStats["red_zone_atempts_allowed"]  = temp[6]
                    defensiveStats["red_zone_targets_allowed"]  = temp[7]
                    defensiveStats["targets_allowed"]  = temp[8]
                    defensiveStats["recieving_yard"]  = temp[9]
                    defensiveStats["recieving_tds"]  = temp[11]
                    defensiveStats["fpts_allowed"]  = temp[12]
                    weeklyDefensiveStats.append(defensiveStats)

                }
                
            }
            
        }
        print("getDefense_vs_qb\n")
    }
    func getProjectedPoints(){
    let d = ["Player","Position","Date","Salary","Projected Points","Pt/$/K"]
    let projectedPointsDataFile  = "/Users/brcarson/Downloads/Projected Points_W13.csv"
    if let ppDataFile =  NSData(contentsOfURL:NSURL.init(fileURLWithPath:projectedPointsDataFile)!) {
        if let ppContent = NSString(data: ppDataFile, encoding: NSUTF8StringEncoding) {
            for qbprojectedPoints in ppContent.componentsSeparatedByString("\n") {
                if qbprojectedPoints as NSString == "" {
                    break
                }
                var temp:[AnyObject] = []
                for stats in qbprojectedPoints.componentsSeparatedByString(","){
                    if stats as NSString == "" {
                        break
                    }
                    if stats as NSString == "opp" {
                        break
                    }
                    temp.append(stats)
                }
                    projectePoints["player"] = temp[0]
                    projectePoints["Salary"] = temp[3]
                    projectePoints["Projected Points"] = temp[4]
                    projectePoints["Pt/$/K"] = temp[5]
                    weeklyProjectedPoints.append(projectePoints)
            }
            
        }
       }
    print("projected points\n")

}
    func getAdvanceStats(){
        let headers = ["Player","Team","GP","RzPa","RzRu","Comp%","Pa20+","Ru20+","Snap/G","FP/Snap"]
        let advanceStatsDataFilePath  = "/Users/brcarson/Downloads/qb_advance stats_w13.csv"
        if let advanceStatsDataFile =  NSData(contentsOfURL:NSURL.init(fileURLWithPath:advanceStatsDataFilePath)!) {
            if let advanceStatsContent = NSString(data: advanceStatsDataFile, encoding: NSUTF8StringEncoding) {
                for advance_stats in advanceStatsContent.componentsSeparatedByString("\n") {
                    if   advance_stats as NSString == "" {
                        break
                    }
                    var temp:[AnyObject] = []
                    for stats in advance_stats.componentsSeparatedByString(","){
                        if stats as NSString == "" {
                            break
                        }
                        if stats as NSString == "opp" {
                            break
                        }
                        temp.append(stats)
                    }
                    advanceStats["player"] = temp[0]
                    advanceStats["Team"] = temp[3]
                    advanceStats["GP"] = temp[4]
                    advanceStats["RzPa"] = temp[5]
                    advanceStats["RzRu"] = temp[5]
                    advanceStats["Comp%"] = temp[5]
                    advanceStats["Pa20+"] = temp[5]
                    advanceStats["Snap/G"] = temp[5]
                    advanceStats["FP/Snap"] = temp[5]
                   
                    weeklyadvanceStats.append(advanceStats)
                }


            }
        }

    }
//    func addDefensiveStats1()-> [dfs_player] {
//        var index = 0
//        for def in weeklyDefensiveStats  {
//            var def_temp = def["defense"] as? NSString
//            if def_temp == "Team" {
//                continue
//            }
//            var player:dfs_player
//            for (index,player) in  enumerate(thisWeeksQBs) {
//                
//                var playerName = player.playerStats["player_name"] as? NSString
//                var temp = player.playerStats["player_opp"] as? NSString
//                if temp == "Opp" {
//                    continue
//                }
//                if def_temp == "Player" {
//                    continue
//                }
//                if temp == def_temp {
////                    print("\(dude)\n")
//               
//                    let keyes = def.keys
//                    for (key,value) in def {
//                       
////
//                        
//                    }
////                    thisWeeksQBs.insert(player, atIndex:index)
//                    continue
//                } else {
//               
//                }
//                
//             continue
//        }
//          continue
//        }
//       return thisWeeksQBs
//    }
    func consistencyAndCeiling(){
        let d = ["Player","Salary","GP","FPPG","FPMAX","FPMIN","Floor","Ceil","%2x","%3x","%4x","%5x","%6x"]
        let consistencyAndCeilingDataFilePath  = "/Users/brcarson/DRAFT_KINGS/Consistancy_W13.csv"
        if let ccDataFile =  NSData(contentsOfURL:NSURL.init(fileURLWithPath:consistencyAndCeilingDataFilePath)!) {
            if let ccContent = NSString(data: ccDataFile, encoding: NSUTF8StringEncoding) {
                for cc  in ccContent.componentsSeparatedByString("\n") {
                    if cc as NSString == "" {
                        break
                    }
                    var temp:[AnyObject] = []
                    for stats in cc.componentsSeparatedByString(","){
                        if stats as NSString == "" {
                            break
                        }
                        if stats as NSString == "opp" {
                            break
                        }
                        temp.append(stats)
                    }
                    ceilingAndConsistency["Player"] = temp[0]
                    ceilingAndConsistency["Salary"] = temp[2]
                    ceilingAndConsistency["GP"] = temp[3]
                    ceilingAndConsistency["FPPG"] = temp[4]
                    ceilingAndConsistency["FPMAX"] = temp[5]
                    ceilingAndConsistency["FPMIN"] = temp[6]
                    ceilingAndConsistency["Floor"] = temp[7]
                    ceilingAndConsistency["Ceil"] = temp[8]
                    ceilingAndConsistency["%2x"] = temp[9]
                    ceilingAndConsistency["%3x"] = temp[10]
                    ceilingAndConsistency["%4x"] = temp[11]
                    ceilingAndConsistency["%6x"] = temp[12]
                    ceilingAndConsistencyStats.append(ceilingAndConsistency)
                }
            }
        }
    }
    func thisWeeksQuarterBacks() -> [AnyObject] {
        return thisWeeksQBs
    }
    
    
    
    
    func createPlayerStats(player:[String:AnyObject], withThesesStats:Quarterbacks) -> Dfs_player{
        var opp = player["player_opp"] as String
        var playerName = player["player_name"] as String
        let playerWithStats = Dfs_player()
        playerWithStats.playerStats = player
        for defStat in withThesesStats.weeklyDefensiveStats {
           var OppDefStats = defStat["defense"] as String
            if opp == OppDefStats {
                print("found\n")
                playerWithStats.defensiveStats = defStat
            }
        }
        for pp in withThesesStats.weeklyProjectedPoints {
            if playerName == pp["player"] as String {
                print("found!!\n\n")
                playerWithStats.projectePoints = pp
           }
        }
        for cc in withThesesStats.ceilingAndConsistencyStats {
            if playerName == cc["Player"] as String {
                print("found!!!\n\n\n")
                playerWithStats.ceilingAndConsistency = cc
            }
        }
        for advStats in withThesesStats.weeklyadvanceStats {
            if playerName == advStats["player"] as String {
                print("found%%%%%\n\n\n")
                playerWithStats.advanceStats = advStats
            }
        }
        return playerWithStats
    }
    
    func updated_stats() -> Dfs_player  {
        var player = Dfs_player()
        for wdf in weeklyDefensiveStats {
            var def_temp = wdf["defense"] as? NSString
            if def_temp == "Team" {
                continue
            }
            var twqb:[String:AnyObject]
            for twqb in  thisWeeksQBs {
                
                    var playerName = twqb["player"] as? NSString
                    var temp = twqb["player_opp"] as? NSString
                    if temp == "Opp" {
                        continue
                    }
                    if def_temp == "Player" {
                        continue
                    }
                    if temp == def_temp {

                }
            }
        }
        // Project Points
        for wpp in weeklyProjectedPoints {
            var projectedPointsTemp = wpp["player"] as? String
            for pl in thisWeeksQBs {
                var player_name = playerStats["player_name"] as? NSString
                if projectedPointsTemp == player_name {
                                    }
            }
        }
        // Advance Stats
        for advStats in weeklyProjectedPoints {
            var advStatsTemp = advStats["player"] as String
            for plyer in thisWeeksQBs {
                var pname = playerStats["player_name"] as String
                if advStatsTemp  == pname   {
                    let advStatKeys = advStats.keys.array
                    for K in advStatKeys {
                        advanceStats[K] = advStats[K]
                    }
                }

            }
        }
        return player
    }
    
    
    func quarterbacks() -> [String]{
        var playerNames:[String] = []
        var dfs:[AnyObject]
        for dfs in thisWeeksQBs {
           var nn = dfs["player_name"] as String
          playerNames.append(nn)
        }
    return playerNames
    }
    func salaries() -> [String] {
       var salarys:[String] = []
       var dfs:[AnyObject]
        for dfs in thisWeeksQBs {
            if var playerSalary = dfs["player_salary"] as? String {
                salarys.append(playerSalary)
            }
        }
        return salarys
    }
    
            
//            
//            
//        }
//
//    }


                        
                    
                    
                
            
        
  
    
//    func PlayerName() -> String {
//        return playerStats["player_name"] as String
//    }
//    
//    func PlayerSalary()-> NSNumber {
//        return playerStats["player_salary"] as NSNumber
//    }
//   

  



}

// MARK: -



