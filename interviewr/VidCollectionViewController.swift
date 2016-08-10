//
//  VidCollectionViewController.swift
//  interviewr
//
//  Created by Jackie Ennis on 8/9/16.
//  Copyright © 2016 Jackie Ennis. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

private let reuseIdentifier = "Default"

class VidCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        print(VideoRecorderViewController.interviewTitlesArray)
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let outputFileURL = VideoRecorderViewController.allRecordingsArray[indexPath.row]
        print(outputFileURL)
        print("I'm selected!")
        performSegueWithIdentifier("playVideolol", sender: outputFileURL)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playVideolol" {
            let videoPlayerViewController = segue.destinationViewController as! AVPlayerViewController
            let videoFileURL = sender as! NSURL
            //let cell1 = sender as! VidCollectionViewCell
            print("cassie is a terrible person \(videoFileURL)")
            videoPlayerViewController.player = AVPlayer(URL: videoFileURL)
        }
    
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let numberOfItemsInSection = VideoRecorderViewController.interviewTitlesArray.count
        return numberOfItemsInSection
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VidCollectionViewCell
        cell.label.text = VideoRecorderViewController.interviewTitlesArray[indexPath.row]
        print(VideoRecorderViewController.interviewTitlesArray.count)
        //cell.videoURL = VideoRecorderViewController.allRecordingsArray[indexPath.row]
        print("\(cell.label.text)")
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
