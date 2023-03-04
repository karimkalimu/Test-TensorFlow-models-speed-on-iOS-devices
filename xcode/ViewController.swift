//
//  ViewController.swift
//  Test_tflie_models_speed
//
//  Created by Karim Ali on 2.3.23..
//

import UIKit
import TensorFlowLite
import CoreML

class ViewController: UIViewController {

    
    @IBOutlet weak var LogView: UITextView!
    
    var options = CoreMLDelegate.Options()
    let timer = Timer()
    var inputConv = try! MLMultiArray(shape: [ 1 , 10 , 512, 3], dataType: .float32)
    var input = try! MLMultiArray(shape: [ 1 , 10 , 512], dataType: .float32)
    var inputMel = try! MLMultiArray(shape: [ 1 , 16383], dataType: .float32)
    let modelName = UIDevice.modelName
    var lines = ["Model name, invoke, invokeStd, firstInvoke, init, outputSum, computeUnits"]


    override func viewDidLoad() {
        super.viewDidLoad()
        options.enabledDevices = .all
        options.coreMLVersion=3
        inputConv = fillMultiArrayDefault(array: inputConv, defaultValue: 1.0)
        input = fillMultiArrayDefault(array: input, defaultValue: 1.0)
        inputMel = fillMultiArrayDefault(array: inputMel, defaultValue: 1.0)
        lines[0] += "-\(modelName)"
        LogView.allowsEditingTextAttributes=true
        
        LogView.text! = "Logger:\n\n"
    }

    
    @IBAction func RunTestButtonClicked(_ sender: Any) {
        
        LogView.text += "Start\n"
        LogView.setNeedsDisplay()
        LogView.isScrollEnabled=true
        LogView.text! += "TestButtonClicked\n"
        TestButtonClicked()
        let modelPath = Bundle.main.path(forResource: "MelSpecTF_4096_1023_", ofType: "tflite")
//        let metalDelegate = MetalDelegate()
//        options.maxDelegatedPartitions=1
//        options.minNodesPerPartition=1
        print("\n DONE \n")
        let coreMLDelegate = CoreMLDelegate(options: options)
        print("\n DONE 2\n")
        do {
            let interpreter = try Interpreter(modelPath: modelPath!)//, delegates: [coreMLDelegate!]
            print("\n DONE 3\n")
            try interpreter.allocateTensors()
            let inputTensor = try interpreter.input(at: 0)
            let inputShape = inputTensor.shape
            var inputLen=1
            for dim in inputShape.dimensions{
                inputLen = inputLen * dim
            }
            let Input = [Float](repeating: Float(1.0), count: inputLen)
            let InputData = Data(bytes: Input, count: inputLen * MemoryLayout<Float>.stride)
            let loadingTime = DispatchTime.now().uptimeNanoseconds

            try interpreter.copy(InputData, toInputAt: 0)
            
            try interpreter.invoke()
            let outputTensor = try interpreter.output(at: 0)
            let outputShape = outputTensor.shape
            
            let outputMel = outputTensor.data.toArray(type: Float32.self)
            let processTime = DispatchTime.now().uptimeNanoseconds
            print("DONE")
            print(outputMel.reduce(0, + )/Float32(outputMel.count))
            print("Process time \(Double(processTime - loadingTime)/1_000_000_000)")
            
        } catch {
           print("Catch level 1: ", error)
       }

        
        let dontRunExperiment = false
        if dontRunExperiment{
            return
        }
        do {
            
            let fileManager = FileManager.default
            let modelUrl = Bundle.main.url(forResource: "MelSpecTF_4096_1023_", withExtension: "tflite")
            let dir = fileManager.enumerator(at:modelUrl!.deletingLastPathComponent(), includingPropertiesForKeys: nil)!

            for case let f as URL in dir {
                if(f.path.contains(".tflite")){
                    let temp = f.path.components(separatedBy: "/")
                    let name = temp[temp.count-1].components(separatedBy: ".")[0]
                    print("\n\n\n \(name) kkk \n\n\n")
                    
                    let modelDurationsStr = runModelNTimes(modelPath:f.path)
                    lines.append("\(name)\(modelDurationsStr) Tflite-CPU" )
                    LogView.text! += modelDurationsStr + "\n"
                    print("\n\(name) \(modelDurationsStr)")
  
                    if(name.contains("Dense") || name.contains("Conv2D")){
                        
                        print("Gpu")
                        let modelDurationsStr = runModelNTimes(modelPath:f.path, useMetalDelegate: true)
                        LogView.text! += modelDurationsStr + "\n"

                        lines.append("\(name)\(modelDurationsStr) Tflite-GPU" )
           
                    }
             
//                    print("CoreML")
//                    modelDurations = runModelNTimes(modelPath:f.path, useCoreMLDelegate: true)
//                    lines.append("CoreML-\(temp[temp.count-1]), \(modelDurations.0), \(modelDurations.1), \(modelDurations.2)" )

                    
                }
            }
            let shareResultFile=true
            if shareResultFile{
                let outputFileUrl = writeTempFile(lines:lines)
                let sharedObjects:[AnyObject] = [outputFileUrl as AnyObject]
                let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
                
                lines = []
            }


            
            
        } catch {
            print("Experiment error", error)
        }

    }
    
     func RunCoreMLButtonClocked(_ sender: Any) {
        /*
         do{
             print("Start")
             let mlConfig = MLModelConfiguration()
             print("mlConfig.computeUnits \(mlConfig.computeUnits)")
             mlConfig.computeUnits = .cpuAndNeuralEngine

             let mlModel = try DenseModel_units_512_layers_12_(configuration: mlConfig)
 //            let mlModel = try Conv_Deep_Filters(configuration: mlConfig)
 //            let input = try! MLMultiArray(shape: [ 1, 48, 48, 3], dataType: .float32)
             let input = try! MLMultiArray(shape: [ 1 , 10 , 512], dataType: .float32)
             print(input.shape)
             let output = try mlModel.prediction(input_1: input).Identity
             var sum = 0.0
             
             for i in 0..<Int(truncating: input.shape[1]){
                 if(output[i].doubleValue==Double.infinity){
                     continue
                 }
                 sum = sum + output[i].doubleValue
             }
             print(sum)
             sum = 0.0
             let a = DispatchTime.now().uptimeNanoseconds

             let output2 = try mlModel.prediction(input_1: input).Identity
 //            let output2 = try mlModel.prediction(conv2d_104_input: input).Identity
             let b = DispatchTime.now().uptimeNanoseconds
             for i in 0..<Int(truncating: input.shape[1]){
                 if(output2[i].doubleValue==Double.infinity){
                     continue
                 }
                 sum = sum + output[i].doubleValue
             }
             print(sum)
             print("Process time \(Double(b - a)/1_000_000_000)")

             print(type(of:output))
         }catch{print(error)}
         */

    }
    
     func TestButtonClicked() {
        print("TestButtonClicked            START")

        do{
            let mlConfig = MLModelConfiguration()
            let mlConfigOptions = [MLComputeUnits.cpuOnly, MLComputeUnits.cpuAndGPU, MLComputeUnits.all, MLComputeUnits.cpuAndNeuralEngine]
            mlConfig.computeUnits = mlConfigOptions[0]
            var computeUnitsNames = [", MLComputeUnits.cpuOnly",", MLComputeUnits.cpuAndGPU",", MLComputeUnits.all", ", MLComputeUnits.cpuAndNeuralEngine"]

//            let mlModel = try DenseModel_units_512_layers_12_(configuration: mlConfig)

//            let mlModel = try Conv_Deep_Filters(configuration: mlConfig)
            
//            let output = try mlModel.prediction(input_1: input).Identity
//
//            print("input sum \(sumMultiArray(array:input))")
//            print("outputArr sum \(sumMultiArray(array:output))")
            timer.reset()

//            let output2 = try mlModel.prediction(input_1: input).Identity
//            print("output2 sum \(sumMultiArray(array:output2))")

//            let output2 = try mlModel.prediction(conv2d_104_input: input).Identity
//            print("Process time: \(timer.getDurationAndReset())")
            
            let n_rounds = 6
            var modelDurations = ""
            
            for i in 0..<mlConfigOptions.count{
                
                // inputConv    input        inputMel
                let computeUnitsName = computeUnitsNames[i]
                LogView.text! += computeUnitsName + "\n"

                mlConfig.computeUnits = mlConfigOptions[i]
                print(computeUnitsName)
                
                modelDurations = runConv2D_filters_128_kernel_3_layers_6_NTimes(input: inputConv, n_rounds: n_rounds, mlConfig:mlConfig)
                lines.append(modelDurations+computeUnitsName)



                modelDurations = runConv2D_filters_36_kernel_12_layers_3_NTimes(input: inputConv, n_rounds: n_rounds, mlConfig:mlConfig)
                lines.append(modelDurations+computeUnitsName)



                modelDurations = runTransformer_embedDim_512_nHeads_6_ffn_1024_keyDim_64_layers_8_deLayers_8_NTimes(input: input, n_rounds: n_rounds, mlConfig:mlConfig)
                lines.append(modelDurations+computeUnitsName)



                modelDurations = runDenseModel_units_128_layers_6_NTimes(input: input, n_rounds: n_rounds, mlConfig:mlConfig)
                lines.append(modelDurations+computeUnitsName)



                modelDurations = runDenseModel_units_256_layers_3_NTimes(input: input, n_rounds: n_rounds, mlConfig:mlConfig)
                lines.append(modelDurations+computeUnitsName)



                modelDurations = runMelSpecTF_4096_1023_NTimes(input: inputMel, n_rounds: n_rounds, mlConfig:mlConfig)
                lines.append(modelDurations+computeUnitsName)

                
            }
            
                  
        }catch{print(error)}
        
        print(lines)
    }// TestButtonClicked
    
}


func runModelNTimes(modelPath: String,
                    ignoreFirst: Bool = true,
                    n_rounds: Int = 10,
                    useMetalDelegate: Bool = false,
                    useCoreMLDelegate: Bool = false
) -> String {
    var setInputDurations = [] as [Double]
    var invokingDurations = [] as [Double]
    var getOutputDurations = [] as [Double]
    var firtInvokeDuration = 0.0
    var initDuration = 0.0
    do{
        //Initialize model
        var  delegates = [] as [Delegate]
        if useMetalDelegate{
            delegates.append(MetalDelegate())
        }else if useCoreMLDelegate{
            var options = CoreMLDelegate.Options()
            options.coreMLVersion=3
            options.enabledDevices = .all
            delegates.append(CoreMLDelegate(options: options)!)
        }
                
        let startTime = DispatchTime.now().uptimeNanoseconds
        let interpreter = try Interpreter(modelPath: modelPath, delegates:delegates)
        try interpreter.allocateTensors()
        let inputTensor = try interpreter.input(at: 0)
        let inputShape = inputTensor.shape
        print(inputShape)
        var inputLen=1
        for dim in inputShape.dimensions{
            inputLen = inputLen * dim
        }
        let loadTime = DispatchTime.now().uptimeNanoseconds
        initDuration = Double(loadTime - startTime)/1_000_000_000
//        print("initTime \(initDuration)")

        let dumpInput = [Float](repeating: Float(1.0), count: inputLen)
        
        let inputData = Data(bytes: dumpInput, count: inputLen * MemoryLayout<Float>.stride)
        for i in 0..<n_rounds{
            let runModelDurations = runModel(interpreter: interpreter, inputData: inputData)
            if runModelDurations.1==0.0{
                continue
                // throw "something wrong"
            }
            if i==0 {
                firtInvokeDuration=runModelDurations.1
                if ignoreFirst {
                    continue
                }
            }
            setInputDurations.append(runModelDurations.0)
            invokingDurations.append(runModelDurations.1)
            getOutputDurations.append(runModelDurations.2)
        }
        
        
//        print("Input : \(setInputDurations.reduce(0, + )/Double(setInputDurations.count))")
//        print("Invoke: \(invokingDurations.reduce(0, + )/Double(invokingDurations.count))")
//        print("Output: \(getOutputDurations.reduce(0, + )/Double(getOutputDurations.count))")

    }catch {
        print("runModelNTimes error", error)
    }
    
    
    let invokeAvgDuration = invokingDurations.avg()
    let invokeStdDuration = invokingDurations.std()
    
    firtInvokeDuration = Double(round(10000 * firtInvokeDuration) / 10000)
    initDuration = Double(round(10000 * initDuration) / 10000)
    
    // ["Model name, invoke, invokeStd, firstInvoke, init, computeUnits"]
    return ", \(invokeAvgDuration), \(invokeStdDuration), \(firtInvokeDuration), \(initDuration), ,"
}




func runModel(interpreter: Interpreter, inputData: Data) -> (Double, Double, Double){
    do{
        let setTimeTic = DispatchTime.now().uptimeNanoseconds
        // set input
        try interpreter.copy(inputData, toInputAt: 0)
        let setTimeToc = DispatchTime.now().uptimeNanoseconds
        // run model
        try interpreter.invoke()
        let invokeTime = DispatchTime.now().uptimeNanoseconds
        // get output and sum all the values(fetching time)
        let outputTensor = try interpreter.output(at: 0)
        let outputArr = outputTensor.data.toArray(type: Float32.self)
        let outputSum = outputArr.reduce(0, + )/Float32(outputArr.count)
        let getOutputTime = DispatchTime.now().uptimeNanoseconds
//        print("outputSum: \(outputSum)")

        // calculate durations
        let setInputDuration = Double(setTimeToc - setTimeTic)/1_000_000_000
        let invokeDuration  = Double(invokeTime - setTimeToc)/1_000_000_000
        let getOutputDuration  = Double(getOutputTime - invokeTime)/1_000_000_000

        return (setInputDuration, invokeDuration, getOutputDuration )
        
    }catch{
        print("runModel error", error)
        return (0.0, 0.0, 0.0)
    }
    
}


func writeTempFile(lines: [String]) -> URL {
    let url = FileManager.default.temporaryDirectory
        .appendingPathComponent(UUID().uuidString)
        .appendingPathExtension("txt")
    let string = lines
        .map({
            "\($0)"
        })
        .joined(separator: "\n")
    
    print(string)
    try? string.write(to: url, atomically: true, encoding: .utf8)
    return url
}
