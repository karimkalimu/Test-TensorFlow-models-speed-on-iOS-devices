# Test-TensorFlow-models-speed-on-iOS-devices



### Create MlModels with swift code to run on xcode
<a href="https://github.com/karimkalimu/Test-TensorFlow-models-speed-on-iOS-devices/blob/main/colab/Create%20Tflite_MLModels(xcode)%20Models%20.ipynb" target="_blank" >
  <img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab" />
</a>



### Note: 6 invokes(first invoke not included)

## iPhone 14
|                               Model name                                |CoreML-CPU|CoreML-CPU&GPU|CoreML-All|CoreML-CPU&NeuralEngine|Tflite-CPU|Tflite-GPU|
|-------------------------------------------------------------------------|----------|--------------|----------|-----------------------|----------|----------|
|DenseModel_units_256_layers_3_                                           |0.1/<0.1  |0.2/<0.1      |0.3/<0.1  |0.3/0.1                |0.1/<0.1  |NaN       |
|MelSpecTF_4096_1023_                                                     |8.6/0.1   |9.1/0.3       |8.6/0.1   |8.6/0.1                |19.5/1.1  |-/-       |
|Conv2D_filters_36_kernel_12_layers_3_                                    |4.7/0.2   |12.3/2.3      |1.2/0.1   |1.2/0.2                |79.1/0.7  |15.3/3.4  |
|Transformer_embedDim_512_nHeads_6_ffn_1024_keyDim_64_layers_8_deLayers_8_|13.3/1.8  |165.3/2.9     |2.6/0.2   |2.5/0.2                |18.0/0.8  |-/-       |
|Conv2D_filters_128_kernel_3_layers_6_                                    |9.6/2.9   |12.5/3.1      |1.6/0.2   |1.4/0.1                |88.2/0.7  |17.8/4.0  |
|DenseModel_units_128_layers_6_                                           |0.1/<0.1  |0.3/0.1       |0.3/0.1   |0.4/0.1                |0.1/<0.1  |nan       |


## iPhone 13 Pro Max
|                               Model name                                |CoreML-CPU|CoreML-CPU&GPU|CoreML-All|CoreML-CPU&NeuralEngine|Tflite-CPU|Tflite-GPU|
|-------------------------------------------------------------------------|----------|--------------|----------|-----------------------|----------|----------|
|MelSpecTF_4096_1023_                                                     |9.6/1.9   |9.1/0.1       |8.8/<0.1  |8.8/0.1                |19.4/1.2  |-/-       |
|Transformer_embedDim_512_nHeads_6_ffn_1024_keyDim_64_layers_8_deLayers_8_|16.1/6.8  |170.4/5.5     |2.5/0.2   |2.7/0.2                |17.7/0.7  |-/-       |
|DenseModel_units_128_layers_6_                                           |0.1/0.1   |0.3/<0.1      |0.3/<0.1  |0.3/<0.1               |0.1/<0.1  |NaN       |
|Conv2D_filters_36_kernel_12_layers_3_                                    |4.8/0.2   |11.3/3.6      |1.1/0.1   |1.1/0.1                |80.2/1.9  |10.6/2.3  |
|Conv2D_filters_128_kernel_3_layers_6_                                    |8.8/1.0   |9.5/1.5       |1.5/0.1   |1.5/0.1                |89.1/1.8  |15.5/1.9  |
|DenseModel_units_256_layers_3_                                           |0.1/<0.1  |0.2/<0.1      |0.3/<0.1  |0.3/0.1                |0.1/<0.1  |NaN       |

<img src="https://github.com/karimkalimu/Test-TensorFlow-models-speed-on-iOS-devices/blob/main/assets/A.png" width="200" height="400"> <img src="https://github.com/karimkalimu/Test-TensorFlow-models-speed-on-iOS-devices/blob/main/assets/B.png" width="200" height="400">








This project is licensed under the MIT License. You can find the full text of the license in the `LICENSE` file.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/karimkalimu/Test-TensorFlow-models-speed-on-iOS-devices/blob/main/LICENSE)






