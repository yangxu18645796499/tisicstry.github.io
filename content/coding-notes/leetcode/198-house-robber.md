---
title: "198. 打家劫舍"
weight: 198
---
## problem 198
你是一个专业的小偷，计划偷窃沿街的房屋。每间房内都藏有一定的现金，影响你偷窃的唯一制约因素就是相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警。

给定一个代表每个房屋存放金额的非负整数数组，计算你 不触动警报装置的情况下 ，一夜之内能够偷窃到的最高金额。

示例 1：

输入：[1,2,3,1]
输出：4
解释：偷窃 1 号房屋 (金额 = 1) ，然后偷窃 3 号房屋 (金额 = 3)。
     偷窃到的最高金额 = 1 + 3 = 4 。
示例 2：

输入：[2,7,9,3,1]
输出：12
解释：偷窃 1 号房屋 (金额 = 2), 偷窃 3 号房屋 (金额 = 9)，接着偷窃 5 号房屋 (金额 = 1)。
     偷窃到的最高金额 = 2 + 9 + 1 = 12 。
 

提示：

1 <= nums.length <= 100
0 <= nums[i] <= 400

## qwen ans
进阶挑战：空间优化 (O(1) Space)
刚才的解法你应该开了一个 vector<int> dp，空间复杂度是 O(N)。
但其实 dp[i] 只依赖 dp[i-1] 和 dp[i-2]，咱能不能只用几个变量把空间压到 O(1)？
```cpp
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int rob(vector<int>& nums) {
    if (nums.empty()) return 0;
    if (nums.size() == 1) return nums[0];

    // 用两个变量滚动记录，代替 dp 数组
    int prev2 = 0;          // 相当于 dp[i-2]
    int prev1 = nums[0];    // 相当于 dp[i-1]

    for (size_t i = 1; i < nums.size(); ++i) {
        // 当前最大值 = max(不偷当前家，偷当前家)
        int cur = max(prev1, prev2 + nums[i]);
        prev2 = prev1;      // 滚动更新
        prev1 = cur;
    }

    return prev1;
}

int main() {
    vector<int> nums = {2, 7, 9, 3, 1};
    cout << rob(nums) << endl; // 输出 12
    return 0;
}
```