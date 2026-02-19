+++
date = '2026-02-18T20:30:42+08:00'
draft = false
title = 'Leetcode_1'
+++
# 1.两数之和

## 原题
给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

你可以假设每种输入只会对应一个答案，并且你不能使用两次相同的元素。

你可以按任意顺序返回答案。

示例 1：

输入：nums = [2,7,11,15], target = 9
输出：[0,1]
解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
示例 2：

输入：nums = [3,2,4], target = 6
输出：[1,2]
示例 3：

输入：nums = [3,3], target = 6
输出：[0,1]

提示：

2 <= nums.length <= 104
-109 <= nums[i] <= 109
-109 <= target <= 109
只会存在一个有效答案

## 最优解
```java
class Solution {
	public int[] twoSum(int[] nums, int target) {
		Map<Integer,Integer> hash = new HashMap<>();
        for(int i=0;i<nums.length;i++){
            hash.put(nums[i],i);
        }
        for(int i=0;i<nums.length;i++){
            if(hash.containsKey(target-nums[i])&&hash.get(target-nums[i])!=i){
                return new int[] {i,hash.get(target-nums[i])};
            }
        }
		return null;
	}
}
```

## inspiration
利用hash函数的一一对应的特性，一步找到对应的target-nums[i];
遍历，O(n)。