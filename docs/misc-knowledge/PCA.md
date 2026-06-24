---
title: "PCA"
---

PCA（Principal Component Analysis，主成分分析）是一种常用的无监督学习算法，主要用于数据降维和特征提取。

### 核心数学与逻辑原理

PCA 的核心思想是通过线性变换将原始数据转换为一组各维度线性无关的表示，可用于提取数据的主要特征分量。其数学本质是寻找数据方差最大的方向作为主成分。

1.  **数据中心化 (Centering)**
    为了消除量纲影响并简化计算，首先将数据的每个特征维度减去其均值，使数据的均值为零。
    设原始数据矩阵为 $X \in \mathbb{R}^{n \times d}$，其中 $n$ 为样本数，$d$ 为特征数。
    中心化后的数据 $X_{centered}$ 为：
    $$ X_{centered} = X - \mu $$
    其中 $\mu$ 是各特征的均值向量。

2.  **协方差矩阵 (Covariance Matrix)**
    计算中心化数据的协方差矩阵，用于衡量特征之间的相关性。
    $$ \Sigma = \frac{1}{n-1} X_{centered}^T X_{centered} $$
    $\Sigma \in \mathbb{R}^{d \times d}$ 是对称矩阵。

3.  **特征值分解 (Eigenvalue Decomposition)**
    对协方差矩阵 $\Sigma$ 进行特征值分解，得到特征值 $\lambda$ 和对应的特征向量 $v$。
    $$ \Sigma v = \lambda v $$
    特征值 $\lambda$ 表示数据在对应特征向量方向上的方差大小。特征值越大，说明数据在该方向上的分布越分散，包含的信息量越多。

4.  **选择主成分与投影 (Projection)**
    将特征值从大到小排序，选择前 $k$ 个最大的特征值对应的特征向量，组成投影矩阵 $W \in \mathbb{R}^{d \times k}$。
    最后将中心化数据投影到新的子空间，得到降维后的数据 $Y$。
    $$ Y = X_{centered} W $$

### C++ 代码实现 (基于 Eigen 库)

```cpp
#include <Eigen/Dense>
#include <iostream>
#include <vector>

using namespace std;
using namespace Eigen;

MatrixXd perform_pca(const MatrixXd& X, int k) {
    int n = X.rows();
    int d = X.cols();

    RowVectorXd mean = X.colwise().mean();
    MatrixXd X_centered = X.rowwise() - mean;

    MatrixXd cov = (X_centered.transpose() * X_centered) / (n - 1);

    SelfAdjointEigenSolver<MatrixXd> es(cov);
    MatrixXd eigenvectors = es.eigenvectors();
    VectorXd eigenvalues = es.eigenvalues();

    std::vector<std::pair<double, int>> eigen_pairs;
    for (int i = 0; i < d; ++i) {
        eigen_pairs.push_back({eigenvalues(i), i});
    }
    sort(eigen_pairs.begin(), eigen_pairs.end(), [](const auto& a, const auto& b) {
        return a.first > b.first;
    });

    MatrixXd W(d, k);
    for (int i = 0; i < k; ++i) {
        W.col(i) = eigenvectors.col(eigen_pairs[i].second);
    }

    return X_centered * W;
}

int main() {
    MatrixXd X(5, 3);
    X << 1, 2, 3,
         4, 5, 6,
         7, 8, 9,
         10, 11, 12,
         13, 14, 15;

    int k = 2;
    MatrixXd Y = perform_pca(X, k);

    cout << "Reduced Data:" << endl;
    cout << Y << endl;

    return 0;
}
```
