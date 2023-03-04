# Test-TensorFlow-models-speed-on-iOS-devices



## iPhone 14
### 6 invokes each model(after first invoke)
|                               Model name                                |CoreML-CPU|CoreML-CPU&GPU|CoreML-All|CoreML-CPU&NeuralEngine|Tflite-CPU|Tflite-GPU|
|-------------------------------------------------------------------------|----------|--------------|----------|-----------------------|----------|----------|
|DenseModel_units_256_layers_3_                                           |0.1/<0.1  |0.2/<0.1      |0.3/<0.1  |0.3/0.1                |0.1/<0.1  |NaN       |
|MelSpecTF_4096_1023_                                                     |8.6/0.1   |9.1/0.3       |8.6/0.1   |8.6/0.1                |19.5/1.1  |-/-       |
|Conv2D_filters_36_kernel_12_layers_3_                                    |4.7/0.2   |12.3/2.3      |1.2/0.1   |1.2/0.2                |79.1/0.7  |15.3/3.4  |
|Transformer_embedDim_512_nHeads_6_ffn_1024_keyDim_64_layers_8_deLayers_8_|13.3/1.8  |165.3/2.9     |2.6/0.2   |2.5/0.2                |18.0/0.8  |-/-       |
|Conv2D_filters_128_kernel_3_layers_6_                                    |9.6/2.9   |12.5/3.1      |1.6/0.2   |1.4/0.1                |88.2/0.7  |17.8/4.0  |
|DenseModel_units_128_layers_6_                                           |0.1/<0.1  |0.3/0.1       |0.3/0.1   |0.4/0.1                |0.1/<0.1  |nan       |












