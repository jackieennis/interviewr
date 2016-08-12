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
    
    //declare global array variables to be edited
    static var allRecordingsArray = [NSURL]()
    static var interviewTitlesArray = [String]()
    
    //declare variables to enable video and audio capture
    let captureSession = AVCaptureSession()
    var videoDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
    //declare variable to store video
    var videoFileOutput: AVCaptureMovieFileOutput?
    //declare variable for camera preview screen
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    //boolean checks whether camera is recording
    var isRecording = false
    //store video count to change file path for each new saved video
    var videoCount = 0
    
    //camera buttons
    var buttonImageDefault: UIImage = UIImage(named: "whiteButton-1")!
    var buttonImageRecording: UIImage = UIImage(named: "redButton-1")!
    
    //creates alert controller for video title prompt
    var titleAlert = UIAlertController(title: "Give this recording a name.", message: "Which interview is this for? (ex. Google 11/2016)", preferredStyle: .Alert)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //preset the session for taking photo in full resolution
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        //get the available devices that are capable of taking video
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as!
            [AVCaptureDevice]
       
        //get the front-facing camera for taking videos
        for device in devices {
            if device.position == AVCaptureDevicePosition.Front {
                videoDevice = device
            }
        }
        
        //set grabbed videoDevice and audioDevice as AV inputs
        let videoInput = try! AVCaptureDeviceInput(device: videoDevice)
        captureSession.addInput(videoInput)
        let audioInput = try! AVCaptureDeviceInput(device: audioDevice) as AVCaptureInput
        captureSession.addInput(audioInput)
        
        //configure the session with the output for capturing video
        videoFileOutput = AVCaptureMovieFileOutput()
        
        //adds videoFileOutput as output for storing recorded results of captureSession
        captureSession.addOutput(videoFileOutput)
        
        //creates camera preview from this captureSession
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        //add and configure the text field of alert
        titleAlert.addTextFieldWithConfigurationHandler({
            (textField) -> Void in
            let todaysDate = self.getDate()
            textField.text = "\(todaysDate)"
        })
        
        //grab the value from the text field to add it to the array of interviewTitles then pushes to collectionViewController once user hits OK
        titleAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = self.titleAlert.textFields![0] as UITextField
            VideoRecorderViewController.interviewTitlesArray.append(textField.text!)
            print("Text field: \(textField.text!)")
            dump(VideoRecorderViewController.interviewTitlesArray)
            self.goToCollectionView()
        }))
    }

    
    override func viewDidAppear(animated: Bool) {
        //adds cameraPreviewLayer to sublayer of view (must be in viewDidAppear to prevent lag when loading view
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        
        //brings the camera button to front
        view.bringSubviewToFront(cameraButton)
        
        //begins camera capture session
        captureSession.startRunning()
    }
    
    //method called once camera button is pressed to start recording video
    @IBAction func capture(sender: AnyObject) {
        //checks state of recording to either begin or end recording
        if !isRecording {
            //sets to opposite recording state
            isRecording = true
            
            //show red recording button
            self.cameraButton.setImage(buttonImageRecording, forState: .Normal)
            
            //creates new NSURL path for file output to save video
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
            let outputPath = "\(documentsPath)/output\(self.videoCount).mov"
            videoCount = videoCount + 1
            let outputFileURL = NSURL(fileURLWithPath: outputPath)
            
            //adds outputFileURL to array of video URLs
            VideoRecorderViewController.allRecordingsArray.append(outputFileURL)
            dump(interviewr.VideoRecorderViewController.allRecordingsArray)
            
            //begins recording
            videoFileOutput?.startRecordingToOutputFileURL(outputFileURL, recordingDelegate: self)
            
        } else {
            //sets to opposite recording state
            isRecording = false
            
            //back to normal camera button
            self.cameraButton.setImage(buttonImageDefault, forState: .Normal)
            
            //stops recording
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
        
        //present the alert controller to set interviewTitle
        self.presentViewController(titleAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToCamera(segue:UIStoryboardSegue) {
    }
    
    
    @IBAction func goToCollectionView() {
        tabBarController?.selectedIndex = 2
    }
    
    
    func getDate() -> String {
        //formats date to mm/dd/yyyy
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        
        //sets todays date
        let date = NSDate()
        let dateString = dateFormatter.stringFromDate(date)
        return dateString
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    //}
}


