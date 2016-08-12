//
//  QuestionListTableViewController.swift
//  interviewr
//
//  Created by Jackie Ennis on 8/3/16.
//  Copyright © 2016 Jackie Ennis. All rights reserved.
//

import UIKit

class QuestionListTableViewController: UITableViewController, UITabBarControllerDelegate {
    
    //mutable array of interview questions
    var interviewQuestions = ["Tell me a little bit about yourself.", "How did you hear about the position?", "What do you know about the company?", "Why do you want this job?", "Why should we hire you?", "What is your greatest professional achievement?", "What do you consider to be your weaknesses?", "What is your greatest professional achievement?", "Tell me about a challenge or conflict you've faced at work, and how you dealt with it.", "Where do you see yourself in five years?", "What's your dream job?", "What's a time you exercised leadership?", "How would your boss and co-workers describe you?", "How do you deal with pressure or stressful situations?", "Do you have any questions for us?"]
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! QuestionTableViewCell
        // Configure the cell...
        cell.questionLabel.text = interviewQuestions[indexPath.row]
        return cell
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        self.navigationItem.title = "Interview Questions"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tabBarController?.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
        let selectedIndex = tabBarController.viewControllers?.indexOf(viewController)
        
        if selectedIndex == 1 {
            //print("This is the video tab")
            return true
        } else if selectedIndex == 0 {
            print("This is the first tab")
            return true
        } else if selectedIndex == 0 {
            print("This is the album tab")
            return true
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return interviewQuestions.count
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        let itemToMove:String = interviewQuestions[fromIndexPath.row]
        interviewQuestions.removeAtIndex(fromIndexPath.row)
        interviewQuestions.insert(itemToMove, atIndex: toIndexPath.row)
        
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            interviewQuestions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
