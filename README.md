# KMotionHelper
İOS CoreMotion Helper Class

![alt tag](https://user-images.githubusercontent.com/16580898/30037988-f3d1cff4-91c8-11e7-8971-9401e2b8d16b.png)

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

- [X] info.plist select Privacy settings motion usage.

