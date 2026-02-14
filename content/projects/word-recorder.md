---
title: "极简单词记录本"
date: 2026-02-14T16:00:00+08:00
draft: false
---

这是一个简单的单词记录本应用，数据存储在您的浏览器本地。

<!-- 使用 rawhtml 短代码插入原始 HTML/JS 代码 -->
{{< rawhtml >}}
<style>
    /* 将原有样式稍微调整以适应博客布局 */
    .word-recorder-container {
        /* max-width: 800px;  已经由博客主题控制宽度，不需要额外限制 */
        margin: 0 auto;
        /* padding: 20px; */
        /* background-color: #f5f5f5; 博客已有背景，这里不需要 */
    }
    
    .recorder-box {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        border: 1px solid #eee; /* 增加边框适应暗色主题 */
    }
    
    .recorder-input-area {
        display: flex;
        gap: 10px;
        margin-bottom: 30px;
    }
    
    .recorder-input {
        flex: 1;
        padding: 12px 15px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
        color: #333; /* 确保文字颜色可见 */
    }
    
    .recorder-btn {
        padding: 12px 25px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s;
    }
    
    .recorder-btn:hover {
        background-color: #45a049;
    }
    
    .word-list {
        margin-top: 20px;
    }
    
    .word-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px;
        border-bottom: 1px solid #eee;
        background-color: #f9f9f9;
        margin-bottom: 10px;
        border-radius: 4px;
        color: #333; /* 确保文字颜色可见 */
    }
    
    /* 适配暗色模式（如果主题支持） */
    @media (prefers-color-scheme: dark) {
        .word-item {
            background-color: #333;
            color: #fff;
            border-bottom: 1px solid #444;
        }
        .recorder-box {
            background-color: #222;
             border: 1px solid #444;
        }
    }

    .word-item .word {
        font-weight: bold;
        font-size: 18px;
        /* color: #2c3e50; */
    }
    
    .word-item .meaning {
        /* color: #666; */
        font-size: 16px;
        max-width: 60%;
    }
    
    .word-item .delete-btn {
        background-color: #ff4444;
        padding: 6px 12px;
        font-size: 14px;
        color: white;
        border: none;
    }
    
    .word-item .delete-btn:hover {
        background-color: #cc0000;
    }
    
    @media (max-width: 600px) {
        .recorder-input-area {
            flex-direction: column;
        }
        
        .word-item {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }
        
        .word-item .meaning {
            max-width: 100%;
        }
        
        .word-item .delete-btn {
            align-self: flex-end;
        }
    }
</style>

<div class="word-recorder-container">
    <div class="recorder-box">
        <!-- 输入区域 -->
        <div class="recorder-input-area">
            <input type="text" id="wordInput" class="recorder-input" placeholder="请输入单词">
            <input type="text" id="meaningInput" class="recorder-input" placeholder="请输入释义">
            <button id="addBtn" class="recorder-btn">添加</button>
        </div>
        
        <!-- 单词列表展示区域 -->
        <div class="word-list" id="wordList"></div>
    </div>
</div>

<script>
    (function(){
        // 使用闭包防止变量污染全局
        // 获取DOM元素
        const wordInput = document.getElementById('wordInput');
        const meaningInput = document.getElementById('meaningInput');
        const addBtn = document.getElementById('addBtn');
        const wordList = document.getElementById('wordList');

        // 初始化：从本地存储加载单词列表
        let words = JSON.parse(localStorage.getItem('wordRecords')) || [];
        
        // 渲染单词列表
        function renderWords() {
            wordList.innerHTML = '';
            
            // 遍历所有单词，创建展示项
            words.forEach((item, index) => {
                const wordItem = document.createElement('div');
                wordItem.className = 'word-item';
                
                wordItem.innerHTML = `
                    <span class="word">${item.word}</span>
                    <span class="meaning">${item.meaning}</span>
                    <button class="delete-btn" data-index="${index}">删除</button>
                `;
                
                wordList.appendChild(wordItem);
            });
            
            // 为删除按钮绑定事件
            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const index = parseInt(this.getAttribute('data-index'));
                    deleteWord(index);
                });
            });
        }

        // 添加单词
        function addWord() {
            const word = wordInput.value.trim();
            const meaning = meaningInput.value.trim();
            
            // 简单验证：不能为空
            if (!word || !meaning) {
                alert('单词和释义都不能为空！');
                return;
            }
            
            // 添加到数组
            words.push({ word, meaning });
            
            // 保存到本地存储
            localStorage.setItem('wordRecords', JSON.stringify(words));
            
            // 重新渲染列表
            renderWords();
            
            // 清空输入框
            wordInput.value = '';
            meaningInput.value = '';
            
            // 聚焦到单词输入框
            wordInput.focus();
        }

        // 删除单词
        function deleteWord(index) {
            if (confirm('确定要删除这个单词吗？')) {
                // 删除对应索引的单词
                words.splice(index, 1);
                
                // 更新本地存储
                localStorage.setItem('wordRecords', JSON.stringify(words));
                
                // 重新渲染列表
                renderWords();
            }
        }

        // 绑定添加按钮点击事件
        addBtn.addEventListener('click', addWord);
        
        // 支持按回车键添加
        // 注意：这里需要更具体的绑定，防止影响页面其他部分
        const handleEnter = function(e) {
            if (e.key === 'Enter' && (document.activeElement === wordInput || document.activeElement === meaningInput)) {
                addWord();
            }
        };
        document.addEventListener('keypress', handleEnter);

        // 渲染列表
        renderWords();
    })();
</script>
{{< /rawhtml >}}
