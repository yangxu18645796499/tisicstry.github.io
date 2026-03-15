---
title: "3. 无重复字符的最长字串"
weight: 3
---
## problem 3
给定一个字符串 s ，请你找出其中不含有重复字符的 最长 子串 的长度。

 

示例 1:

输入: s = "abcabcbb"
输出: 3 
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。注意 "bca" 和 "cab" 也是正确答案。
示例 2:

输入: s = "bbbbb"
输出: 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
示例 3:

输入: s = "pwwkew"
输出: 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。
 

提示：

0 <= s.length <= 5 * 104
s 由英文字母、数字、符号和空格组成

## qwen answer

```cpp
#include <string>
#include <unordered_set>
#include <algorithm>
using namespace std;

class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        if (s.empty()) return 0;
        
        unordered_set<char> window; // 用集合存储当前窗口的字符，查找 O(1)
        int left = 0;
        int max_len = 0;
        
        for (int right = 0; right < s.size(); ++right) {
            // 如果右指针字符已在窗口中，不断移动左指针直到移除该字符
            while (window.count(s[right])) {
                window.erase(s[left]);
                left++;
            }
            // 将新字符加入窗口
            window.insert(s[right]);
            // 更新最大长度
            max_len = max(max_len, right - left + 1);
        }
        
        return max_len;
    }
};
```