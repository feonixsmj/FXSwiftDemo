//
//  ThirdViewController.swift
//  FXSwiftDemo
//
//  Created by 140013 on 2020/12/3.
//  Copyright © 2020 FX. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
   public class ListNode {
       public var val: Int
       public var next: ListNode?
       public init() { self.val = 0; self.next = nil; }
       public init(_ val: Int) { self.val = val; self.next = nil; }
       public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
   }
    
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        // 2刷
        if root == nil {
            return []
        }
        
        var res: Array = [[Int]]()
        var queue: Array = [TreeNode?]()
        queue.append(root)
        
        while queue.count > 0 {
            let count: Int = queue.count
            var nums: Array = [Int]()
            
            for _ in 0..<count {
                let node: TreeNode = queue.removeFirst()!
                nums.append(node.val)
                
                if node.left != nil {
                    queue.append(node.left)
                }
                if node.right != nil {
                    queue.append(node.right)
                }
            }
            res.append(nums)
        }
        
        return res
    }
    
    //JZOf 30. 包含min函数的栈
    class MinStack {
        
        private var nStack: [Int]
        private var minStack: [Int]
        
        init() {
            nStack = [Int]()
            minStack = [Int]()
        }
        
        func push(_ x: Int) {
            nStack.append(x)
            if let min = minStack.last {
                if min >= x {
                    minStack.append(x)
                }
            } else {
                minStack.append(x)
            }
        }
        
        func pop() {
            if nStack.count == 0 {
                return
            }
            
            let num = nStack.removeLast()
            if num == minStack.last {
                minStack.removeLast()
            }
        }
        
        func top() -> Int {
            return nStack.last ?? 0
        }
        
        func min() -> Int {
            return minStack.last ?? 0
        }
        
    }
    
    
    
    // MARK: - 两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict: [Int:Int] = [:]
        
        for index in 0..<nums.count {
            let nowValue = nums[index]
            let dif = target - nowValue
            if let exitValue = dict[dif] {
                return [exitValue, index]
            }
            dict[nowValue] = index
        }

        return []
    }
    
    //    '('，')'，'{'，'}'，'['，']'
    // MARK: 20. 有效的括号
    func isValid(_ s: String) -> Bool {
        let dict = ["(":")","{":"}","[":"]"]
        var stack: [String] = []
        
        for char in s {
            let str = String(char)
            
            if [String](dict.keys).contains(str) {
                stack.append(str)
            }
            
            if [String](dict.values).contains(str) {
                
                if let lastValue = stack.last {
                    
                    if dict[lastValue] == str {
                        stack.removeLast()
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
        }
        if !stack.isEmpty {
            return false
        }
        return true
    }
        
    // MARK:70. 爬楼梯
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        
        if n == 2 {
            return 2
        }
        
        var a = 1, b = 2, sum = 0
        //首次循环 既是 F(3) = F(2) + f(1)
        for _ in 2..<n {
            sum = a + b
            a = b
            b = sum
        }
        return sum
    }

    // MARK: - 21. 合并两个有序链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        }
        if l2 == nil {
            return l1
        }
        
        var temp: ListNode? = nil
        
        if l1!.val > l2!.val {
            temp = l2
            temp?.next = mergeTwoLists(l1, l2?.next)
        } else {
            temp = l1
            temp?.next = mergeTwoLists(l1?.next, l2)
        }
        return temp;
        
    }
    // MARK: - 206. 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        var head = head
        var newList: ListNode? = nil
        while head != nil {
            let temp = head?.next
            head?.next = newList
            newList = head
            head = temp
        }
        return newList
        
    }

    // MARK: 226. 翻转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        let left = invertTree(root?.left)
        let right = invertTree(root?.right)
        
        root?.left = right
        root?.right = left
        
        return root
    }
    // MARK: 104. 二叉树的最大深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        let left = maxDepth(root?.left)
        let right = maxDepth(root?.right)
        
        if left >= right {
            return left + 1
        } else {
            return right + 1
        }
    }
    // MARK:101. 对称二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        
        if root == nil || (root?.left == nil && root?.right == nil) {
            return true
        }
        
        var queue = [TreeNode?]()
        queue.append(root?.left)
        queue.append(root?.right)
        
        while queue.count > 0
        {
            let node1 = queue.removeFirst()
            let node2 = queue.removeFirst()
            
            if node1 == nil && node2 == nil {
                continue
            }
            
            if node1 == nil || node2 == nil {
                return false
            }
            
            // 都存在
            if node1?.val != node2?.val {
                return false
            }
            
            queue.append(node1?.left)
            queue.append(node2?.right)
            
            queue.append(node1?.right)
            queue.append(node2?.left)
        }
        
        return true
    }
    
    /*
    func isSymmetric(_ root: TreeNode?) -> Bool {
        var queue = [TreeNode?]()
        if let r = root {
            queue.append(r)
            while !queue.isEmpty {
                let c = queue.count
                for i in 0..<queue.count {
                    let t = queue[i]
                    if t?.val != queue[c-i-1]?.val {
                        return false
                    }
                    if t?.val != nil {
                        queue.append(t?.left)
                        queue.append(t?.right)
                    }
                }
                queue.removeFirst(c)
            }
        }
        return true
    }
 */
    
}
