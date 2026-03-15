---
title: "438. 找到字符串中所有异位词"
weight: 438
---

## problem 438
给定两个字符串 s 和 p，找到 s 中所有 p 的 异位词 的子串，返回这些子串的起始索引。不考虑答案输出的顺序。

 

示例 1:

输入: s = "cbaebabacd", p = "abc"
输出: [0,6]
解释:
起始索引等于 0 的子串是 "cba", 它是 "abc" 的异位词。
起始索引等于 6 的子串是 "bac", 它是 "abc" 的异位词。
 示例 2:

输入: s = "abab", p = "ab"
输出: [0,1,2]
解释:
起始索引等于 0 的子串是 "ab", 它是 "ab" 的异位词。
起始索引等于 1 的子串是 "ba", 它是 "ab" 的异位词。
起始索引等于 2 的子串是 "ab", 它是 "ab" 的异位词。
 

提示:

1 <= s.length, p.length <= 3 * 104
s 和 p 仅包含小写字母
## qwen answer
```cpp
#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        vector<int> ans;
        int n = s.size(), m = p.size();
        if (n < m) return ans;
        vector<int> cnt(26, 0);
        for (char c : p) cnt[c - 'a']++;
        for (int i = 0; i < n; ++i) {
            cnt[s[i] - 'a']--;
            if (i >= m) cnt[s[i - m] - 'a']++;
            if (i >= m - 1) {
                bool match = true;
                for (int j = 0; j < 26; ++j) {
                    if (cnt[j] != 0) {
                        match = false;
                        break;
                    }
                }
                if (match) ans.push_back(i - m + 1);
            }
        }
        return ans;
    }
};
```