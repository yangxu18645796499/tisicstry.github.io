---
title: "213. 打家劫舍II"
weight: 213
---

## problem 213
你是一个专业的小偷，计划偷窃沿街的房屋，每间房内都藏有一定的现金。这个地方所有的房屋都 围成一圈 ，这意味着第一个房屋和最后一个房屋是紧挨着的。同时，相邻的房屋装有相互连通的防盗系统，如果两间相邻的房屋在同一晚上被小偷闯入，系统会自动报警 。

给定一个代表每个房屋存放金额的非负整数数组，计算你 在不触动警报装置的情况下 ，今晚能够偷窃到的最高金额。

 

示例 1：

输入：nums = [2,3,2]
输出：3
解释：你不能先偷窃 1 号房屋（金额 = 2），然后偷窃 3 号房屋（金额 = 2）, 因为他们是相邻的。
示例 2：

输入：nums = [1,2,3,1]
输出：4
解释：你可以先偷窃 1 号房屋（金额 = 1），然后偷窃 3 号房屋（金额 = 3）。
     偷窃到的最高金额 = 1 + 3 = 4 。
示例 3：

输入：nums = [1,2,3]
输出：3
 

提示：

1 <= nums.length <= 100
0 <= nums[i] <= 1000

## my ans

核心逻辑：**去掉头算一次，去掉尾算一次，取最大**
```cpp
class Solution {
public:
    int rob(vector<int>& nums) {
        if(nums.size()==1){
            return nums[0];
        }
        if(nums.size()==2){
            return max(nums[1],nums[0]);
        }
        int a=0,b=0;
        int a1=0,b1=0;
        a=nums[0];
        b=nums[nums.size()-1];
        nums.erase(nums.end()-1);
        b1=rob1(nums);
        nums.push_back(b);
        nums.erase(nums.begin());
        a1=rob1(nums);
        return max(a1,b1);
    }
    int rob1(vector<int>& nums) {
        
        int dp[3]={0}; //3是个数
        dp[0]=nums[0];
        if(nums.size()==1){
            return dp[0];
        }
        dp[1]=max(nums[0],nums[1]);
        if(nums.size()==2){
            return dp[1];
        }
        for(int i=2;i<nums.size();i++){
            dp[2]=max(dp[1],dp[0]+nums[i]);
            dp[0]=dp[1];
            dp[1]=dp[2];
        }
        return dp[2];
    }
};
```