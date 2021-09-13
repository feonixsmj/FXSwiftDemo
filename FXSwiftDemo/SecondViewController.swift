//
//  SecondViewController.swift
//  FXSwiftDemo
//
//  Created by FeoniX on 2019/4/16.
//  Copyright © 2019 FX. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    let letterDict: Dictionary = [
        "0":" ",
        "1":"",
        "2":"abc",
        "3":"def",
        "4":"ghi",
        "5":"jkl",
        "6":"mno",
        "7":"pqrs",
        "8":"tuv",
        "9":"wxyz",
    ]
    
    var resArr: Array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        找出 数字234 所能代表的字母全排列
//        letterCombinations(digists: "234")
//        print(resArr)
        
        // 找出字符串 “abc”的全排列
        permutation("aac")
        // 集合去重
        print(Array(Set(resPArr)))
        print(resPArr);
    }
    
    func findCombination(digists: String, index: Int,res: String) {
        if index == digists.count {
            resArr.append(res)
            return
        }
        
        // 一系列转换，拿到letterDict 的key
        let offet = digists.index(digists.startIndex, offsetBy: index)
        let char: Character = digists[offet]
        let digistsIndex = Int((String(char) as NSString).integerValue)
        
        let letters: String = letterDict[String(char)]!
        if digistsIndex >= 0 && digistsIndex <= 9 && digistsIndex != 1{
            
            for lChar in letters {
                
                findCombination(digists: digists, index: index + 1, res: res + String(lChar))
            }
        }
    }
    
    func letterCombinations(digists: String) {
        
        findCombination(digists: digists, index: 0, res:"")
    }

    static func allArrangementAlgorithm(text: String) -> [String] {
    var allPermutation:[String] = []
        
    guard text.count == 1 else {
        
        for n in 0..<text.count {
            let singleString: String = (text as NSString).substring(with: NSRange(location: n, length: 1))
            let deleteSingleString: NSMutableString = NSMutableString.init(string: text)
            deleteSingleString.deleteCharacters(in: NSRange(location: n, length: 1))
            let sub:[String] = allArrangementAlgorithm(text: deleteSingleString as String)
            for (_, value) in sub.enumerated() {
                let strOfCombine = (singleString as String)+value
                allPermutation.append(strOfCombine)
            }
        }
        return allPermutation
    }
        
    allPermutation.append(text)
    return allPermutation
    }
    
//    class Solution {
//        List<String> res = new LinkedList<>();
//        char[] c;
//        public String[] permutation(String s) {
//            c = s.toCharArray();
//            dfs(0);
//            return res.toArray(new String[res.size()]);
//        }
//        void dfs(int x) {
//            if(x == c.length - 1) {
//                res.add(String.valueOf(c)); // 添加排列方案
//                return;
//            }
//            HashSet<Character> set = new HashSet<>();
//            for(int i = x; i < c.length; i++) {
//                if(set.contains(c[i])) continue; // 重复，因此剪枝
//                set.add(c[i]);
//                swap(i, x); // 交换，将 c[i] 固定在第 x 位
//                dfs(x + 1); // 开启固定第 x + 1 位字符
//                swap(i, x); // 恢复交换
//            }
//        }
//        void swap(int a, int b) {
//            char tmp = c[a];
//            c[a] = c[b];
//            c[b] = tmp;
//        }
//    }
//    剑指 Offer 38. 字符串的排列 输入一个字符串，打印出该字符串中字符的所有排列。
    //输入：s = "abc"
//    输出：["abc","acb","bac","bca","cab","cba"]
    var resPArr: Array = [String]()
    
    func permutation(_ s: String) -> [String] {
        
        permutationHelp(s, beginIndex: 0)
        
        return Array(Set(resPArr))
    }
    
    func permutationHelp(_ s: String , beginIndex: Int) {
        var s = s
        
        if beginIndex == s.count {
            resPArr.append(s)
            return
        }
        
        for i in beginIndex..<s.count {
            s = swapCharacters(input: s, index1: beginIndex, index2: i)
            permutationHelp(s, beginIndex: beginIndex + 1)
            s = swapCharacters(input: s, index1: beginIndex, index2: i)
        }
    }
    
    func swapCharacters(input: String, index1: Int, index2: Int) -> String {
        var characters = Array(input)
        characters.swapAt(index1, index2)

        return String(characters)
    }
    
    var permuteResArr = [[Int]]()
        
    //46. 全排列 给定一个 没有重复 数字的序列，返回其所有可能的全排列。
    func permute(_ nums: [Int]) -> [[Int]] {
        permuteHelp(nums, index: 0)
        return permuteResArr
    }
    
    func permuteHelp(_ nums: [Int], index: Int) {
        var nums = nums
        if index == nums.count {
            permuteResArr.append(nums)
        }
        for x in index..<nums.count {
            nums.swapAt(x, index)
            permuteHelp(nums, index: index + 1)
            nums.swapAt(x, index)
        }
    }
//    剑指 Offer 18. 删除链表的节点
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        var head = head
        var pHead = head
        
        while pHead != nil {
            if pHead!.val == val {
                head = head?.next
                break
            } else if pHead!.next?.val == val {
                pHead!.next = pHead!.next?.next
            }
            pHead = pHead?.next
        }
        
        return head
    }
    
    
    var res2: Array = [String]()
    
    func letterCombinations2(_ digits: String) -> [String] {
        if digits.count == 0 {
            return []
        }
        findLetter(digits, 0, "")
        return res2
    }
    
    func findLetter(_ digits: String, _ index: Int, _ resStr: String) {
        if index == digits.count {
            res2.append(resStr)
            return
        }
        
        let offset = digits.index(digits.startIndex, offsetBy: index)
        let c :Character = digits[offset]
        let letters: String = letterDict[String(c)]!
        
        for char in letters {
            findLetter(digits, index + 1, resStr + String(char))
        }
    }
    
    

     public class TreeNode {
         public var val: Int
         public var left: TreeNode?
         public var right: TreeNode?
         public init() { self.val = 0; self.left = nil; self.right = nil; }
         public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
         public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
             self.val = val
             self.left = left
             self.right = right
         }
     }
     
    var res = [Int]()
    
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        inorderHelper(root)
        return res
    }
    
    func inorderHelper(_ root: TreeNode?){
        if root != nil {
            inorderHelper(root?.left)
            res.append(root!.val)
            inorderHelper(root?.right)
        }
    }
    
}

