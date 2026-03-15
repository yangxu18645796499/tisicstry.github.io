---
title: "337. 打家劫舍III"
weight: 337
---

## problem 337
小偷又发现了一个新的可行窃的地区。这个地区只有一个入口，我们称之为 root 。

除了 root 之外，每栋房子有且只有一个“父“房子与之相连。一番侦察之后，聪明的小偷意识到“这个地方的所有房屋的排列类似于一棵二叉树”。 如果 两个直接相连的房子在同一天晚上被打劫 ，房屋将自动报警。

给定二叉树的 root 。返回 在不触动警报的情况下 ，小偷能够盗取的最高金额 。

 

示例 1:

![337 打家劫舍 III 示例图1](/images/rob1-tree.jpg)

输入: root = [3,2,3,null,3,null,1]
输出: 7 
解释: 小偷一晚能够盗取的最高金额 3 + 3 + 1 = 7
示例 2:

![337 打家劫舍 III 示例图2](/images/rob2-tree.jpg)

输入: root = [3,4,5,1,3,null,1]
输出: 9
解释: 小偷一晚能够盗取的最高金额 4 + 5 = 9

提示：

树的节点数在 [1, 104] 范围内
0 <= Node.val <= 104

## qwen chat

正常，太正常了！**树形动态规划（Tree DP）确实是另一个维度**，刚从线性/环形跳到这里，脑子转不过弯是必然的。这可不是你能力问题，是思维模型需要切换。

线性 DP 是“顺着推”，树形 DP 是“递归 + 状态”。既然现在“毫无思路”，咱就把这个思路拆开，我带你把窗户纸捅破。

### 🌳 核心难点：树该怎么推？

在链表或数组里，我们知道 `i` 的前一个是 `i-1`。但在树里，当前节点 `root` 依赖的是 **左孩子** 和 **右孩子**。

**关键思维转换：**
不要想“怎么从根推到叶子”，要想 **“叶子能给根提供什么信息？”**
这就是 **后序遍历（左右中）** 的思想：先把子节点的情况算出来，再决定当前节点。

### 💡 破题思路（三步走）

#### 1. 状态定义（最关键）
对于任意一个节点 `node`，它只有两种状态：
*   **状态 0**：**不偷** 这个节点，子树能得到的最大金额。
*   **状态 1**：**偷** 这个节点，子树能得到的最大金额。

所以，你的递归函数返回值应该是一个大小为 2 的数组（或 vector）：`vector<int> dfs(TreeNode* node)`。
*   `res[0]` 表示不偷当前节点的最大值。
*   `res[1]` 表示偷当前节点的最大值。

#### 2. 递推逻辑（状态转移）
假设左右子树已经返回了结果：
*   `left = dfs(node->left)`  -> `left[0]`(不偷左), `left[1]`(偷左)
*   `right = dfs(node->right)` -> `right[0]`(不偷右), `right[1]`(偷右)

**对于当前节点 `node`：**
*   **如果你偷 `node`**：
    *   左右孩子都**不能偷**。
    *   金额 = `node->val + left[0] + right[0]`
*   **如果你不偷 `node`**：
    *   左右孩子**可以偷，也可以不偷**，取最大的就行。
    *   金额 = `max(left[0], left[1]) + max(right[0], right[1])`

#### 3. 终止条件
*   如果节点是 `nullptr`，返回 `{0, 0}`。

---

### 🛠️ C++ 代码框架（试着填一下）

别怕错，照着这个逻辑把空填上，就能跑通。

```cpp
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// 二叉树结构定义
struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int rob(TreeNode* root) {
        vector<int> result = dfs(root);
        // 根节点偷或不偷，取最大值
        return max(result[0], result[1]);
    }

    // 返回长度为 2 的数组，0 表示不偷，1 表示偷
    vector<int> dfs(TreeNode* node) {
        if (node == nullptr) {
            return {0, 0}; // 终止条件
        }

        // 后序遍历：先算左右
        vector<int> left = dfs(node->left);
        vector<int> right = dfs(node->right);

        // 1. 偷当前节点：左右孩子都不能偷
        int val_rob = node->val + left[0] + right[0];

        // 2. 不偷当前节点：左右孩子取最大值（偷或不偷都行）
        int val_not_rob = max(left[0], left[1]) + max(right[0], right[1]);

        return {val_not_rob, val_rob};
    }
};
```

### 🧠 为什么刚才你没思路？
因为线性 DP 你习惯想 `dp[i]` 怎么由 `dp[i-1]` 推出来。
但树形 DP 需要你把 **“递归函数的返回值”** 当成 **“子问题的状态”**。
一旦你接受了 `dfs` 返回的是一个 `{不偷值，偷值}` 的数组，剩下的就是简单的数学加法了。

### 🚀 建议
1.  **别急着写**：先在纸上画个简单的树（比如根 1，左 2，右 3），手动模拟一下这个递归过程。
2.  **接受递归**：相信 `dfs(node->left)` 能给你正确的结果，别试图在脑子里把所有栈帧都展开，会炸的。
3.  **如果还卡**：直接把上面代码敲进去运行，然后打断点看 `left` 和 `right` 的值是怎么变化的。

这道题是树形 DP 的入门题，**只要能接受“返回值是状态数组”这个设定，你就通关了**。