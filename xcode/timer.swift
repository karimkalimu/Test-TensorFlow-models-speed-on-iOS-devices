//
//  timer.swift
//  Test_tflie_models_speed
//
//  Created by Karim Ali on 3.3.23..
//

import Foundation

class Timer {
    ///  measure durations with 0.0001 sec (0.1 millisec) accuracy
    var startTime = DispatchTime.now().uptimeNanoseconds
    
    func reset(){
        startTime = DispatchTime.now().uptimeNanoseconds
    }

    func getDuration() -> Double {
        let duration = Double(DispatchTime.now().uptimeNanoseconds - startTime)/1_000_000_000
        return Double(round(10000 * duration) / 10000)
    }
    
    func getDurationAndReset() -> Double {
        let duration = getDuration()
        reset()
        return duration
    }
    
}
