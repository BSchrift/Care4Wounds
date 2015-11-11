//
//  CameraVC.swift
//  Care4Wounds
//
//  Created by David Furman on 11/9/15.
//  Copyright © 2015 UCI App Jam Team 5. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var wound : Wound!
    
    var captureDevice : AVCaptureDevice?
    var captureSession : AVCaptureSession?
    var stillImageOutput : AVCaptureStillImageOutput?
    var previewLayer : AVCaptureVideoPreviewLayer?
    var image : UIImage?
    @IBOutlet var cameraView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var scanImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scanImageButton.enabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Handle situations in which the app may not have been given permission to use the camera.
        /*
        let authorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch authorizationStatus {
        case .NotDetermined:
        // permission dialog not yet presented, request authorization
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo,
        completionHandler: { (granted:Bool) -> Void in
        if granted {
        // go ahead
        }
        else {
        // user denied, nothing much to do
        }
        })
        case .Authorized:
        // go ahead
        case .Denied, .Restricted:
        // the user explicitly denied camera usage or is not allowed to access the camera devices
        }
        */
        
        previewLayer?.frame = cameraView.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var error : NSError?
        var input: AVCaptureDeviceInput!
        do {
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if (error == nil && captureSession?.canAddInput(input) != nil){
            
            captureSession?.addInput(input)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
            
            if (captureSession?.canAddOutput(stillImageOutput) != nil){
                captureSession?.addOutput(stillImageOutput)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                previewLayer!.frame = cameraView.bounds
                // fills the whole view with the preview of the camera
                previewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
                previewLayer!.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                cameraView.layer.addSublayer(previewLayer!)
                captureSession?.startRunning()
            }
        }
        
        cancelButton.hidden = true
    }
    @IBOutlet var tempImageView: UIImageView!
    
    func focusTo(value : Float) {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            } catch {
                print("Error")
            }
        }
    }
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch : UITouch = touches.first! as UITouch!
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let anyTouch : UITouch = touches.first! as UITouch!
        let touchPercent = anyTouch.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    func didPressTakePhoto(){
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let dataProvider  = CGDataProviderCreateWithCFData(imageData)
                    let cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    self.image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    self.tempImageView.image = self.image
                    self.tempImageView.hidden = false
                }
            })
        }
    }
    
    func toggleCameraState(takingPhotos : Bool) {
        cameraButton.hidden = !takingPhotos
        tempImageView.hidden = takingPhotos
        cancelButton.hidden = takingPhotos
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        toggleCameraState(true)
    }
    
    @IBAction func photoButtonPressed(sender: UIButton) {
        didPressTakeAnother()
    }
    
    @IBAction func scanImageButtonPressed(sender: AnyObject) {
        let photoAnalysisVC = PhotoAnalysisVC(nibName: "PhotoAnalysisVC", bundle: nil)
        photoAnalysisVC.wound = wound
        photoAnalysisVC.image = self.image
        navigationController!.pushViewController(photoAnalysisVC, animated: true);
    }
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother(){
        if didTakePhoto == true{
            tempImageView.hidden = true
            didTakePhoto = false
        }
        else {
            captureSession?.startRunning()
            didTakePhoto = true
            toggleCameraState(false)
            didPressTakePhoto()
        }
    }
    
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    didPressTakeAnother()
    }
    */
}