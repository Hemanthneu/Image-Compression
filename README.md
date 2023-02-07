# Image-Compression
Image compression by PCA and K-means
Synopsis :
The objective of image compression is to reduce the memory size to be as small as possible while maintaining the similarity with the original image. 
Our original image contains thousands of colours which are usually ignored by the human visual system and hence can be termed as irrelevant redundancy. We will utilize K-Means clustering algorithm to reduce the number of colours so that it only needs to store certain numbers of RGB values only. Thus, it will reduce the image size and make it more efficient in the storage. 
PCA is one of the unsupervised learning techniques used for dimensionality reduction. To reduce the data dimension, we only keep a certain number of principal components to explain the original data and ignore the rest. We will utilize PCA to reduce the image size by selecting a certain number of principal components to be used so that it only stores the important pixels of the original image, thus making it more efficient in the storage. 
By using both K-means and PCA simultaneously image compression can be improved.
