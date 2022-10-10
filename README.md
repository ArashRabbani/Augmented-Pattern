# Augmented-Pattern
Image augmentation tool for creating new realizations and their labels
This repository can be used to generate new realizations of the images with patterns, especially porous or composite material. In addition, if you have a label map or mask that distinguish specific elements or parts in the images, that map can be reconstructed accordingly. Here, I have provided a few examples through Demo codes. If you are using this code please cite this paper: 
Arash Rabbani, Masoud Babaei, Masoumeh Gharib, Automated segmentation and morphological characterization of placental histology images based on a single labeled image, arXiv https://arxiv.org/abs/2210.03566, (2022). ([Link](https://arxiv.org/abs/2210.03566))


## Demo 1
Use this code to see a set of reconstructed images and their labeles. This is useful when you need to augment a dataset of images and labels for machine learning purposes. Here are some sample results for reconstruction of a placental tissue:
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/img/Reconstructed_1.jpg)



### Porous carbonate rock example
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Data/Input2.png)
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Carbonate.gif)



### Porous Sandstone example
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Data/Input3.png)
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Sandstone.gif)



### Placental tissue
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Data/Input.png)
![Alt text](https://github.com/ArashRabbani/Augmented-Pattern/blob/main/Placental%20Tissue.gif)



## Demo 1


## Raw image sources
- Sandstone image: Gilbert Scott, Kejian Wu, Yingfang Zhou. Multi-scale Image-Based Pore Space Characterisation and Pore Network Generation: Case Study of a North Sea Sandstone Reservoir. Springer Link. 2019. 
- Carbonate image: Tom Bultreys, Luc Van Hoorebeke, Veerle Cnudde. Multi-scale, micro-computed tomography-based pore network models to simulate drainage in heterogeneous rocks. Advances in Water Resources. 2015
