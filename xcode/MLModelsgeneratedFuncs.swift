//
//  MLModelsgeneratedFuncs.swift
//  Test_tflie_models_speed
//
//  Created by Karim Ali on 3.3.23..
//

import Foundation
import CoreML







func runConv2D_filters_128_kernel_3_layers_6_NTimes(input: MLMultiArray, n_rounds: Int = 10, ignoreFirst: Bool=true, mlConfig: MLModelConfiguration) -> String{
    
    var invokingDurations = [] as [Double]
    var firtInvokeDuration = 0.0
    var initDuration = 0.0
    let timer = Timer()
    var _sum = Float(0.0)
    
    do{
        /// Initialize model
        timer.reset()
        let mlModel = try Conv2D_filters_128_kernel_3_layers_6_(configuration: mlConfig)
        initDuration = timer.getDurationAndReset()
        
        /// Run same input n times
        for i in 0..<n_rounds{
            timer.reset()
            let output = try mlModel.prediction(input_1: input).Identity
            if i==0 {
                firtInvokeDuration=timer.getDuration()
                if ignoreFirst {
                    continue
                }
            }
            invokingDurations.append(timer.getDuration())
            _sum = sumMultiArray(array:output)
        }
    }catch {
        print("runCoreMLModelNTimes error", error)
    }
  
    let invokeAvgDuration = invokingDurations.avg()
    let invokeStdDuration = invokingDurations.std()
    
    return "Conv2D_filters_128_kernel_3_layers_6_, \(invokeAvgDuration), \(invokeStdDuration), \(firtInvokeDuration), \(initDuration), \(_sum)"
        
}




func runConv2D_filters_36_kernel_12_layers_3_NTimes(input: MLMultiArray, n_rounds: Int = 10, ignoreFirst: Bool=true, mlConfig: MLModelConfiguration) -> String{
    
    var invokingDurations = [] as [Double]
    var firtInvokeDuration = 0.0
    var initDuration = 0.0
    let timer = Timer()
    var _sum = Float(0.0)
    
    do{
        /// Initialize model
        timer.reset()
        let mlModel = try Conv2D_filters_36_kernel_12_layers_3_(configuration: mlConfig)
        initDuration = timer.getDurationAndReset()
        
        /// Run same input n times
        for i in 0..<n_rounds{
            timer.reset()
            let output = try mlModel.prediction(input_1: input).Identity
            if i==0 {
                firtInvokeDuration=timer.getDuration()
                if ignoreFirst {
                    continue
                }
            }
            invokingDurations.append(timer.getDuration())
            _sum = sumMultiArray(array:output)
        }
    }catch {
        print("runCoreMLModelNTimes error", error)
    }
  
    let invokeAvgDuration = invokingDurations.avg()
    let invokeStdDuration = invokingDurations.std()
    
    return "Conv2D_filters_36_kernel_12_layers_3_, \(invokeAvgDuration), \(invokeStdDuration), \(firtInvokeDuration), \(initDuration), \(_sum)"
        
}




func runTransformer_embedDim_512_nHeads_6_ffn_1024_keyDim_64_layers_8_deLayers_8_NTimes(input: MLMultiArray, n_rounds: Int = 10, ignoreFirst: Bool=true, mlConfig: MLModelConfiguration) -> String{
    
    var invokingDurations = [] as [Double]
    var firtInvokeDuration = 0.0
    var initDuration = 0.0
    let timer = Timer()
    var _sum = Float(0.0)
    
    do{
        /// Initialize model
        timer.reset()
        let mlModel = try Transformer_embedDim_512_nHeads_6_ffn_1024_keyDim_64_layers_8_deLayers_8_(configuration: mlConfig)
        initDuration = timer.getDurationAndReset()
        
        /// Run same input n times
        for i in 0..<n_rounds{
            timer.reset()
            let output = try mlModel.prediction(input_1: input).Identity
            if i==0 {
                firtInvokeDuration=timer.getDuration()
                if ignoreFirst {
                    continue
                }
            }
            invokingDurations.append(timer.getDuration())
            _sum = sumMultiArray(array:output)
        }
    }catch {
        print("runCoreMLModelNTimes error", error)
    }
  
    let invokeAvgDuration = invokingDurations.avg()
    let invokeStdDuration = invokingDurations.std()
    
    return "Transformer_embedDim_512_nHeads_6_ffn_1024_keyDim_64_layers_8_deLayers_8_, \(invokeAvgDuration), \(invokeStdDuration), \(firtInvokeDuration), \(initDuration), \(_sum)"
        
}




func runDenseModel_units_128_layers_6_NTimes(input: MLMultiArray, n_rounds: Int = 10, ignoreFirst: Bool=true, mlConfig: MLModelConfiguration) -> String{
    
    var invokingDurations = [] as [Double]
    var firtInvokeDuration = 0.0
    var initDuration = 0.0
    let timer = Timer()
    var _sum = Float(0.0)
    
    do{
        /// Initialize model
        timer.reset()
        let mlModel = try DenseModel_units_128_layers_6_(configuration: mlConfig)
        initDuration = timer.getDurationAndReset()
        
        /// Run same input n times
        for i in 0..<n_rounds{
            timer.reset()
            let output = try mlModel.prediction(input_1: input).Identity
            if i==0 {
                firtInvokeDuration=timer.getDuration()
                if ignoreFirst {
                    continue
                }
            }
            invokingDurations.append(timer.getDuration())
            _sum = sumMultiArray(array:output)
        }
    }catch {
        print("runCoreMLModelNTimes error", error)
    }
  
    let invokeAvgDuration = invokingDurations.avg()
    let invokeStdDuration = invokingDurations.std()
    
    return "DenseModel_units_128_layers_6_, \(invokeAvgDuration), \(invokeStdDuration), \(firtInvokeDuration), \(initDuration), \(_sum)"
        
}




func runDenseModel_units_256_layers_3_NTimes(input: MLMultiArray, n_rounds: Int = 10, ignoreFirst: Bool=true, mlConfig: MLModelConfiguration) -> String{
    
    var invokingDurations = [] as [Double]
    var firtInvokeDuration = 0.0
    var initDuration = 0.0
    let timer = Timer()
    var _sum = Float(0.0)
    
    do{
        /// Initialize model
        timer.reset()
        let mlModel = try DenseModel_units_256_layers_3_(configuration: mlConfig)
        initDuration = timer.getDurationAndReset()
        
        /// Run same input n times
        for i in 0..<n_rounds{
            timer.reset()
            let output = try mlModel.prediction(input_1: input).Identity
            if i==0 {
                firtInvokeDuration=timer.getDuration()
                if ignoreFirst {
                    continue
                }
            }
            invokingDurations.append(timer.getDuration())
            _sum = sumMultiArray(array:output)
        }
    }catch {
        print("runCoreMLModelNTimes error", error)
    }
  
    let invokeAvgDuration = invokingDurations.avg()
    let invokeStdDuration = invokingDurations.std()
    
    return "DenseModel_units_256_layers_3_, \(invokeAvgDuration), \(invokeStdDuration), \(firtInvokeDuration), \(initDuration), \(_sum)"
        
}




func runMelSpecTF_4096_1023_NTimes(input: MLMultiArray, n_rounds: Int = 10, ignoreFirst: Bool=true, mlConfig: MLModelConfiguration) -> String{
    
    var invokingDurations = [] as [Double]
    var firtInvokeDuration = 0.0
    var initDuration = 0.0
    let timer = Timer()
    var _sum = Float(0.0)
    
    do{
        /// Initialize model
        timer.reset()
        let mlModel = try MelSpecTF_4096_1023_(configuration: mlConfig)
        initDuration = timer.getDurationAndReset()
        
        /// Run same input n times
        for i in 0..<n_rounds{
            timer.reset()
            let output = try mlModel.prediction(input_1: input).Identity
            if i==0 {
                firtInvokeDuration=timer.getDuration()
                if ignoreFirst {
                    continue
                }
            }
            invokingDurations.append(timer.getDuration())
            _sum = sumMultiArray(array:output)
        }
    }catch {
        print("runCoreMLModelNTimes error", error)
    }
  
    let invokeAvgDuration = invokingDurations.avg()
    let invokeStdDuration = invokingDurations.std()
    
    return "MelSpecTF_4096_1023_, \(invokeAvgDuration), \(invokeStdDuration), \(firtInvokeDuration), \(initDuration), \(_sum)"
        
}


