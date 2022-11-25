//
//  Camera Service.swift
//  AV Camera
//
//  Created by Okhunjon Mamajonov on 2022/11/26.
//

import Foundation
import AVFoundation

class CameraService{
    var session: AVCaptureSession?
    var delegate: AVCapturePhotoCaptureDelegate?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping (Error?)-> ()){
        self.delegate = delegate
    checkPermission(completion: completion)
    }
    private func checkPermission(completion: @escaping (Error?)-> ()){
        switch AVCaptureDevice.authorizationStatus(for: .video){
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {return}
                DispatchQueue.main.async {
                    self?.setUpCamera(completion: completion)
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera(completion: completion)
        @unknown default:
          break
        }
    }
    private func setUpCamera(completion: @escaping (Error?)-> ()){
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video){
            do{
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                session.startRunning()
                self.session = session
            } catch {
                completion(error)
            }
        }
    }
    func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()){
        output.capturePhoto(with: settings, delegate: delegate!)
    }
}

