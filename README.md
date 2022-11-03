# Augmented-Pattern
Image augmentation tool for creating new realizations and their labels using Matlab

This repository can be used to generate new realizations of the images with patterns, especially porous or composite material. In addition, if you have a label map or mask that distinguish specific elements or parts in the images, that map can be reconstructed accordingly. Here, I have provided a few examples through Demo codes. If you are using this code please cite this paper: <br>
Arash Rabbani, Masoud Babaei, Masoumeh Gharib, Automated segmentation and morphological characterization of placental histology images based on a single labeled image, arXiv https://arxiv.org/abs/2210.03566, (2022). ([Link](https://arxiv.org/abs/2210.03566))


## Demo 1
Use this code to see a set of reconstructed images and their labeles. This is useful when you need to augment a dataset of images and labels for machine learning purposes. Here are some sample results for reconstruction of a placental tissue as well as a porous carbonate rock:
<br>
<br>
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/img/Reconstructed_1.jpg)
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/img/Reconstructed_2.jpg)

## Demo 2
Use this code to generate a short animated gif file of the reconstruction process. 
### Porous carbonate rock example
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Data/Input2.png)
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Carbonate.gif)



### Porous Sandstone example
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Data/Input3.png)
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Sandstone.gif)



### Placental tissue
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Data/Input.png)
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Placental%20Tissue.gif)



## Demo 3
Use this code to generate a set reconstructed images and their corresponded labels and save them on the Output directory. 
<br>
<br>
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/output.png)


## How to use
For running each of demo files, you need to set some input paramters: 
- Input raw image as matrix
- Input mask or label as a matrix of 0 and 1
- Grid size ratio as an integer larger than 2, pereferably below 20 for computational efficiency. larger the ratio, smaller the tiles will be.
- Show or not? the last input takes the value of 1 (to show the reuslts) or 0 to hide them. 

Outputs of the "AugmentPattern" function are: 
- Reconstructed image
- Reconstructed mask/label

Note: if you don't have labels you can pass a matrix of zeros, the code will still work. 


## Raw image sources
- Sandstone image: Gilbert Scott, Kejian Wu, Yingfang Zhou. Multi-scale Image-Based Pore Space Characterisation and Pore Network Generation: Case Study of a North Sea Sandstone Reservoir. Springer Link. 2019. 
- Carbonate image: Tom Bultreys, Luc Van Hoorebeke, Veerle Cnudde. Multi-scale, micro-computed tomography-based pore network models to simulate drainage in heterogeneous rocks. Advances in Water Resources. 2015
