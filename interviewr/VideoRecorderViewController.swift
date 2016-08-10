//
//  VideoRecorderViewController.swift
//  interviewr
//
//  Created by Jackie Ennis on 8/3/16.
//  Copyright © 2016 Jackie Ennis. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoRecorderViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    @IBOutlet weak var cameraButton: UIButton!
    
    static var allRecordingsArray = [NSURL]()
    static var interviewTitlesArray = [String]()
    
    let captureSession = AVCaptureSession()
    var currentDevice: AVCaptureDevice?
    var videoFileOutput: AVCaptureMovieFileOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var isRecording = false
    var videoCount = 0
    //Create the alert controller for video title prompt
    var titleAlert = UIAlertController(title: "Give this recording a name.", message: "Which interview is this for?", preferredStyle: .Alert)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Preset the session for taking photo in full resolution
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        // Get the available devices that is capable of taking video
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as!
            [AVCaptureDevice]
       
        // Get the front-facing camera for taking videos
        for device in devices {
            if device.position == AVCaptureDevicePosition.Front {
                currentDevice = device
            }
        }
        let captureDeviceInput: AVCaptureDeviceInput
        do {
            captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
        } catch {
            print(error)
            return
        }
        
        // Configure the session with the output for capturing video
        videoFileOutput = AVCaptureMovieFileOutput()
        
        // Configure the session with the input and the output devices
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(videoFileOutput)
        
        // Provide a camera preview
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        // Add and configure the text field
        titleAlert.addTextFieldWithConfigurationHandler({
            (textField) -> Void in
            let todaysDate = self.getDate()
            textField.text = "\(todaysDate)"
        })
        //  Grab the value from the text field, and print it when the user clicks OK.
        titleAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = self.titleAlert.textFields![0] as UITextField
            VideoRecorderViewController.interviewTitlesArray.append(textField.text!)
            print("Text field: \(textField.text)")
            self.goToCollectionView()
        }))
    
    }
    
    override func viewDidAppear(animated: Bool) {
        // Provide a camera preview
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        // Bring the camera button to front
        view.bringSubviewToFront(cameraButton)
        captureSession.startRunning()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func capture(sender: AnyObject) {
        if !isRecording {
            isRecording = true
            UIView.animateWithDuration(0.5, delay: 0.0, options: [.Repeat,
                .Autoreverse, .AllowUserInteraction], animations: { () -> Void in
                    self.cameraButton.transform = CGAffineTransformMakeScale(0.5, 0.5)
                }, completion: nil)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            let outputPath = "\(documentsPath)/output\(self.videoCount).mov"
            videoCount = videoCount + 1
            let outputFileURL = NSURL(fileURLWithPath: outputPath)
            VideoRecorderViewController.allRecordingsArray.append(outputFileURL)
            print("Output file path: \(outputFileURL)")
            videoFileOutput?.startRecordingToOutputFileURL(outputFileURL, recordingDelegate: self)
        } else {
            isRecording = false
            
            UIView.animateWithDuration(0.5, delay: 1.0, options: [], animations: {
                () -> Void in
                self.cameraButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }, completion: nil)
            cameraButton.layer.removeAllAnimations()
            videoFileOutput?.stopRecording()
        }
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!,
                       didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections
        connections: [AnyObject]!, error: NSError!) {
        if error != nil {
            print(error)
            return
        }
        //Present the alert.
        self.presentViewController(titleAlert, animated: true, completion: nil)
    }
    
    // override func reForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //}
    
    @IBAction func unwindToCamera(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func goToCollectionView() {
        
        tabBarController?.selectedIndex = 2
    }
    
    func getDate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        
        let date = NSDate()
        
        // US English Locale (en_US)
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        let dateString = dateFormatter.stringFromDate(date) // Jan 2, 2001
        return dateString
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


