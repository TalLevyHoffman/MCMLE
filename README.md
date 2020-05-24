# MCMLE
Matlab Code for Rank Recovery From Limited &amp; Partial Pairwise Comparisons

# Abstract
*MCMLE* is a matrix completion based MLE estimator for the solution of the well-known
rank aggregation problem from **finite & partial** pairwise comparisons.

The problem is formulated as the recovery of the rank and latent prefernce score
of each object in a series of **N** objects. The prefernce scores of objects **i** and **j** 
determins the probability of a comparison between them to favour one or the other.
The input information is **partial** as only a subset of the objects are compared.

# Code
All the code required to run *MCMLE* is in the *MCMLE* folder.

<a href="https://www.codecogs.com/eqnedit.php?latex=\newline\text{we&space;define&space;}&space;y_{i/j}^{(l)}&space;\text{&space;as&space;equal&space;to&space;1&space;if&space;object&space;}&space;i&space;\text{&space;win&space;over&space;}&space;j&space;\text{&space;in&space;the&space;}&space;l^{th}&space;\text{&space;match&space;and&space;0&space;otherwise,&space;the&space;matrix&space;element:&space;}&space;\newline&space;pMat(i,j)=\frac{1}{L_{ij}}\sum_{l=1}^{L_{ij}}y_{i/j}^{(l)}&space;\text{,&space;}&space;\newline&space;\text{where&space;}&space;L_{ij}&space;\text{&space;Indicates&space;the&space;number&space;of&space;comparisons&space;between&space;}&space;i&space;\text{&space;and&space;}&space;j&space;\text{.}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\newline\text{we&space;define&space;}&space;y_{i/j}^{(l)}&space;\text{&space;as&space;equal&space;to&space;1&space;if&space;object&space;}&space;i&space;\text{&space;win&space;over&space;}&space;j&space;\text{&space;in&space;the&space;}&space;l^{th}&space;\text{&space;match&space;and&space;0&space;otherwise,&space;the&space;matrix&space;element:&space;}&space;\newline&space;pMat(i,j)=\frac{1}{L_{ij}}\sum_{l=1}^{L_{ij}}y_{i/j}^{(l)}&space;\text{,&space;}&space;\newline&space;\text{where&space;}&space;L_{ij}&space;\text{&space;Indicates&space;the&space;number&space;of&space;comparisons&space;between&space;}&space;i&space;\text{&space;and&space;}&space;j&space;\text{.}" title="\newline\text{we define } y_{i/j}^{(l)} \text{ as equal to 1 if object } i \text{ win over } j \text{ in the } l^{th} \text{ match and 0 otherwise, the matrix element: } \newline pMat(i,j)=\frac{1}{L_{ij}}\sum_{l=1}^{L_{ij}}y_{i/j}^{(l)} \text{, } \newline \text{where } L_{ij} \text{ Indicates the number of comparisons between } i \text{ and } j \text{.}" /></a>

*Input arguments*
* pMat  : Matrix of the observed win probabilities
* W     : Matrix where the (i,j) elemnt is 1 if the pair (i,j) is compared and 0 otherwise. 
* p     : The observation probability calculated as the ratio of compared pairs from all pairs.
* eps   : The accuracy required for the preference score estimation
* L     : Matrix of the number of comparisons between each compared pair.
* RMax  : The maximal ratio between two prefernce scores, if set to (-1) it is estimated.
* Qi    : A constant the sets the level of truncation of extreme results (scores very close to 0 or 1).

# Test
A test code is provided on a dataset of ground temperature readings in the US.
Run test.m from the *Weather Simulation* folder after adding the *MCMLE* and *Weather Simulation* folders to the path.

