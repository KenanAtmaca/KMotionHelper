//
//  KMotionHelper
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//
//

import UIKit
import CoreMotion


class KMotionHelper {

    static var shared = KMotionHelper()
    
    private let manager = CMMotionManager()
    private let pedometer = CMPedometer()
    private let activity = CMMotionActivityManager()
    
    var updateInterval:TimeInterval?
    
    
    func motion(completion: @escaping (_ data:CMDeviceMotion)->()) {
        
        manager.deviceMotionUpdateInterval = updateInterval ?? 0.1
        
        if manager.isDeviceMotionAvailable {
            
            manager.startDeviceMotionUpdates(to: .main, withHandler: { (data, error) in
              
                guard error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                     completion(data!)
                }
        
            })
        }
    }
    
    func gyro(completion: @escaping (_ data:CMGyroData)->()) {
        
        manager.gyroUpdateInterval = updateInterval ?? 0.1
        
        if manager.isGyroAvailable {
            
            manager.startGyroUpdates(to: .main, withHandler: { (data, error) in
                
                guard error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(data!)
                }
                
            })
        }
    }
    
    func accelerometer(completion: @escaping (_ data:CMAccelerometerData)->()) {
        
        manager.accelerometerUpdateInterval = updateInterval ?? 0.1
        
        if manager.isAccelerometerAvailable {
            
          manager.startAccelerometerUpdates(to: .main, withHandler: { (data, error) in
            
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                completion(data!)
            }
            
          })
        }
    }
    
    func magnetometer(completion: @escaping (_ data:CMMagnetometerData)->()) {
        
        manager.magnetometerUpdateInterval = updateInterval ?? 0.1
        
        if manager.isMagnetometerAvailable {
            
            manager.startMagnetometerUpdates(to: .main, withHandler: { (data, error) in
                
                guard error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(data!)
                }
                
            })
        }
    }
    
    func startActivity(completion: @escaping (_ data:CMMotionActivity)->()) {
        
        if CMMotionActivityManager.isActivityAvailable() {
            
              activity.startActivityUpdates(to: .main, withHandler: { (data) in
                
                guard data != nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(data!)
                }
                
            })
        }
    }
    
    func startPedometer(completion: @escaping (_ data:CMPedometerData)->()) {
        
        if CMPedometer.isStepCountingAvailable() {
            
            pedometer.startUpdates(from: Date(), withHandler: { (data, error) in
                
                if error != nil {
                    return
                }
                
                DispatchQueue.main.async {
                    completion(data!)
                }
                
            })
        }
    }
   
    func stop() {
        
        manager.stopGyroUpdates()
        manager.stopDeviceMotionUpdates()
        manager.stopAccelerometerUpdates()
        manager.stopMagnetometerUpdates()
        
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
        
        activity.stopActivityUpdates()
    }
    
}//

extension KMotionHelper {
    
    func scale(data:Double) -> CGFloat {
        return CGFloat(abs(data * 0.01 + 1))
    }
    
    func rotation(data: CMRotationRate) -> Double {
        return atan2(data.x, data.y) - Double.pi
    }
    
    func degree(radian:Double) -> Double {
        return 180 / Double.pi * radian
    }
    
    func magnitude(from attitude: CMAttitude) -> Double {
        return sqrt(pow(attitude.roll, 2) + pow(attitude.yaw, 2) + pow(attitude.pitch, 2))
    }
    
}
