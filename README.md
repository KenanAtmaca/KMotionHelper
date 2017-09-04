# KMotionHelper
İOS CoreMotion Helper Class

#### Use

```Swift
      var helper = KMotionHelper.shared
```

##### Sensor Actions

```Swift
      helper.accelerometer { (acceloremeter) in
            // Actions
        }
        
        helper.gyro { (gyro) in
            // Actions
        }
        
        helper.magnetometer { (magnometer) in
            // Actions
        }
        
        helper.motion { (motion) in
            // Actions
        }
```

##### Pedometer & Activity

```Swift
       helper.startPedometer { (pedo) in
            self.pedoLabel.text = "\(pedo.numberOfSteps)"
        }
        
        helper.startActivity { (acc) in
            if acc.stationary {
                self.view.backgroundColor = UIColor.lightGray
            } else if acc.walking {
                self.view.backgroundColor = UIColor.green
            }
        }
```

##### Helpful functions

```Swift
     scale(data:Double) -> CGFloat
     rotation(data: CMRotationRate) -> Double
     degree(radian:Double) -> Double
     magnitude(from attitude: CMAttitude) -> Double
```

