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
    
     public class Node {
        public var val: Int
        public var children: [Node]
        public init(_ val: Int) {
            self.val = val
            self.children = []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        combine(4, 2)
//        restoreIpAddresses("25525511135")
//        combinationSum2([10,1,2,7,6,1,5], 8)
        
//        findSubsequences([4,6,7,7])
//        uniquePathsWithObstacles([[1,0]])
        
//        longestCommonSubsequence("abcde", "ace")
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
            let tem = head?.next
            head?.next = newList
            newList = head
            head = tem
        }
        return newList
        
        
        
        
        
        
        
//        var head = head
//        var newList: ListNode? = nil
//        while head != nil {
//            let temp = head?.next
//            head?.next = newList
//            newList = head
//            head = temp
//        }
//        return newList
        
    }
    

    
    
    // MARK: - 链表

    
    // MARK: 24 两两交换链表中的节点
    func swapPairs(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        let dummyHead: ListNode? = ListNode.init(-1, head)
        var temp: ListNode? = dummyHead
        
        while temp?.next != nil && temp?.next?.next != nil {
            let node1 = temp?.next
            let node2 = temp?.next?.next
            
            temp?.next = node2
            node1?.next = node2?.next
            node2?.next = node1
            temp = node1
        }
        
        return dummyHead?.next
        
    }
    // MARK: 剑指 Offer 22. 链表中倒数第k个节点
    
    func getKthFromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        if k <= 0 || head == nil{
            return nil
        }
        
        var frontP: ListNode? = head
        var behindP: ListNode ;
        
        for _ in 1..<k {
            if frontP?.next == nil {
                return nil
            }
            frontP = frontP?.next
        }
        behindP = head!
        
        while frontP?.next != nil {
            frontP = frontP?.next
            behindP = behindP.next!
        }
        
        return behindP;
    }
    // MARK: 19. 删除链表的倒数第 N 个结点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        if head == nil || n <= 0{
            return nil
        }
        // 创建一个哑结点，便于让slowNode 比fastNode慢一步，方便找到要删除结点的前驱结点
        let dummyNode: ListNode? = ListNode.init(-1, head)
        var fastNode = head
        var slowNode = dummyNode
        
        for _ in 0..<(n - 1){
            if fastNode?.next == nil {
                return nil
            } else {
                fastNode = fastNode?.next
            }
        }
        
        while fastNode?.next != nil {
            fastNode = fastNode?.next
            slowNode = slowNode?.next
        }
        // deleate
        slowNode?.next = slowNode?.next?.next
        // 重要！返回的是dummyNode.next而不是head . 输入时[1] 1 head 会RA
        return dummyNode?.next
        
    }
    // MARK: 141. 环形链表
    func hasCycle(_ head: ListNode?) -> Bool {
        var fast = head
        var slow = head
        
        while fast != nil && fast?.next != nil{
            fast = fast?.next?.next
            slow = slow?.next
            if fast === slow {
                return true
            }
        }
        
        return false
    }
    
    // MARK: 142. 环形链表 II
    func detectCycle2(_ head: ListNode?) -> ListNode? {
        var fast = head
        var slow = head
        
        while fast != nil && fast?.next != nil {
            fast = fast?.next?.next
            slow = slow?.next
            
            if fast === slow {
                //相遇
                var index1 = fast
                var index2 = head
                while index1 !== index2{
                    index1 = index1?.next
                    index2 = index2?.next
                }
                return index2
            }
        }
        return nil
    }
    // MARK: 160. 相交链表
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var lenA = 0, lenB = 0
        var curA: ListNode? = headA
        var curB: ListNode? = headB
        
        while curA != nil {
            curA = curA?.next
            lenA += 1
        }
        
        while curB != nil {
            curB = curB?.next
            lenB += 1
        }
        curA = headA
        curB = headB
        
        if lenB > lenA {
            swap(&lenA, &lenB)
            swap(&curA, &curB)
        }
        
        var gap = lenA - lenB
        while gap > 0 {
            curA = curA?.next
            gap -= 1
        }
        
        while curA != nil {
            if curA === curB {
                return curA
            }
            curA = curA?.next
            curB = curB?.next
        }
        return nil
    }
    // MARK: 287. 寻找重复数  环形链表2 解法
    func findDuplicate(_ nums: [Int]) -> Int {
        var slow = 0, fast = 0
        slow = nums[slow] //走一步
        fast = nums[nums[fast]] //走两步
        while slow != fast {
            slow = nums[slow] //走一步
            fast = nums[nums[fast]] //走两步
        }
        // 找到环
        var result = 0
        while result != fast{
            result = nums[result]
            fast = nums[fast]
        }
        
        return result
    }
    
    // MARK: - 二叉树
    // MARK: 144. 二叉树的前序遍历
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        // 迭代
        if root == nil {
            return []
        }
        var stack: [TreeNode?] = [TreeNode?]()
        stack.append(root)
        var result = [Int]()
        while !stack.isEmpty {
            let rootTree: TreeNode? = stack.popLast()!
            result.append(rootTree!.val)
            if rootTree?.right != nil {
                stack.append(rootTree?.right)
            }
            if rootTree?.left != nil {
                stack.append(rootTree?.left)
            }
        }
        // 中左右
        return result
    }
    
    // 递归
    var preResult = [Int]()
    func preorderTraversal2(_ root: TreeNode?) -> [Int] {
        self.preorder(root)
        return preResult
    }
    func preorder(_ root: TreeNode?) {
        if root == nil {return}
        preResult.append(root!.val)
        preorder(root!.left)
        preorder(root!.right)
    }
    
    // MARK: 94. 二叉树的中序遍历
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack: [TreeNode?] = [TreeNode?]()
        var result = [Int]()
        var cur = root
        
        while cur != nil || !stack.isEmpty {
            if cur != nil {
                stack.append(cur)
                cur = cur?.left
            } else {
                if let node = stack.popLast(){
                    result.append(node!.val)
                    cur = node?.right
                }
            }
        }
        //左中右
        return result
    }
    
    // 递归
    func inorderTraversal2(_ root: TreeNode?) -> [Int] {
        var result = [Int]()
        inorder(root, &result)
        return result
    }
    
    func inorder(_ root: TreeNode?, _ result: inout [Int]) {
        if root == nil { return }
        inorder(root!.left, &result)
        result.append(root!.val)
        inorder(root!.right, &result)
    }
    
    func inorderTraversal3(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        var stack = [TreeNode?](), result = [Int]()
        var cur = root
        
        while cur != nil || !stack.isEmpty {
            if cur != nil {
                stack.append(cur)
                cur = cur?.left
            } else {
                let node = stack.popLast()!
                result.append(node!.val)
                cur = node?.right
            }
        }
        return result
    }
    
    // MARK: 145. 二叉树的后序遍历
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        // 左右中 迭代
        if root == nil {
            return []
        }
        var result = [Int]()
        var stack = [TreeNode?]()
        stack.append(root)
        
        while !stack.isEmpty {
            let node = stack.popLast()!
            result.append(node!.val)
            if node?.left != nil {
                stack.append(node?.left)
            }
            if node?.right != nil{
                stack.append(node?.right)
            }
        }
        // 中右左 ——》 左右中
        return result.reversed()
    }
    
    // MARK: 102. 二叉树的层序遍历
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil { return [] }
        var result = [[Int]]()
        var queue = [TreeNode?]()
        queue.append(root);
        
        while !queue.isEmpty {
            let count = queue.count
            var array = [Int]()
            
            for _ in 0..<count {
                let node = queue.removeFirst()!
                array.append(node.val)
                if node.left != nil {
                    queue.append(node.left)
                }
                
                if node.right != nil { queue.append(node.right)}
            }
            result.append(array)
        }
        
        return result
    }
    // MARK: 107. 二叉树的层序遍历 II 给你二叉树的根节点 root ，返回其节点值 自底向上的层序遍历 。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）
    func levelOrderBottom(_ root: TreeNode?) -> [[Int]] {
        return levelOrder(root).reversed()
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

    // MARK: 559. N 叉树的最大深度
    func maxDepth3(_ root: Node?) -> Int {
        if root == nil {
            return 0
        }
        
        var deep = 0
        for i in 0..<root!.children.count {
            deep = max(deep, maxDepth3(root!.children[i]))
        }
        
        return deep + 1
    }
    //MARK: 111. 二叉树的最小深度
    func minDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var queue = [TreeNode?]()
        queue.append(root)
        
        var deep: Int! = 0
        while queue.count > 0 {
            deep += 1
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                
                if node?.left == nil && node?.right == nil {
                    return deep
                }
                if node?.left != nil{
                    queue.append(node?.left)
                }
                if node?.right != nil{
                    queue.append(node?.right)
                }
            }
        }
        
        return deep
    }
    // MARK:101. 对称二叉树
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil { return true }
        
        var queue = [TreeNode?]()
        queue.append(root?.left)
        queue.append(root?.right)
        
        while !queue.isEmpty {
            let left = queue.removeFirst()
            let right = queue.removeFirst()
            if left == nil && right == nil {
                continue
            }
            
            if left == nil || right == nil || left?.val != right?.val {
                return false
            }
            queue.append(left?.left)
            queue.append(right?.right)
            queue.append(left?.right)
            queue.append(right?.left)
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
    
    // MARK:222. 完全二叉树的节点个数
    func countNodes(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var left = root.left
        var right = root.right
        
        var leftHeight = 0
        var rightHeight = 0
        
        while left != nil {
            left = left!.left
            leftHeight += 1
        }
        
        while right != nil {
            right = right!.right
            rightHeight += 1
        }
        
        if leftHeight == rightHeight {
            // 是完全二叉树 2的n次方 -1
            return (2 << leftHeight) - 1
        }
        // 往上进1
        return countNodes(root.left) + countNodes(root.right) + 1
    }
    
    
    func countNodes2(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        var leftHeight = 0, rightHeight = 0
        
        var left = root
        while left != nil {
            left = left?.left
            leftHeight += 1
        }
        
        var right = root
        while right != nil {
            right = right?.right
            rightHeight += 1
        }
        
        if  leftHeight == rightHeight {
            return 2 << leftHeight - 1
        } else {
            return countNodes2(root?.left) + countNodes2(root?.right) + 1
        }
    }
    
    // MARK: 110. 平衡二叉树
    func isBalanced(_ root: TreeNode?) -> Bool {
        return getTreeDepth(root) != -1
    }
    
    func getTreeDepth(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let left = getTreeDepth(root.left)
        if left == -1 { return -1}
        
        let right = getTreeDepth(root.right)
        if right == -1 { return -1}
        
        if abs(left - right) > 1 {
            return -1
        } else {
            return max(left, right) + 1
        }
    }
    
    
    
    
    func isBalanced2(_ root: TreeNode?) -> Bool {
        return isBalanced2Help(root) != -1
    }
    
    func isBalanced2Help(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        let left = isBalanced2Help(root.left)
        if left == -1 { return -1 }
        
        let right = isBalanced2Help(root.right)
        if right == -1 { return -1 }
        
        if abs(left - right) > 1 {
            return -1
        } else {
            return max(left, right) + 1
        }

    }
    
    
    // MARK: 257. 二叉树的所有路径
    var path257 = [String]()
    var result257 = [String]()
    
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        binaryTreePathsHelp(root)
        return result257
    }
    
    func binaryTreePathsHelp(_ root: TreeNode?)  {
        guard let root = root else {
            return
        }
        path257.append(String(root.val))
        
        if root.left == nil && root.right == nil {
            // 到达了叶子结点
            let str = path257.joined(separator: "->")
            result257.append(str)
            return
        }
        if root.left != nil {
            binaryTreePathsHelp(root.left)
            path257.removeLast()
        }
        if root.right != nil {
            binaryTreePathsHelp(root.right)
            path257.removeLast()
        }
    }
    
    // MARK: 404. 左叶子之和
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        let left = sumOfLeftLeaves(root?.left)
        let right = sumOfLeftLeaves(root?.right)
        
        var mid = 0
    
        if root?.left != nil && root?.left?.left == nil &&
            root?.left?.right == nil{
            mid = root!.left!.val
        }
        return left + right + mid
    }
    
    var sum404 = 0
    func sumOfLeftLeaves2(_ root: TreeNode?) -> Int {
        sumOfLeftLeaves2Help(root)
        return sum404
    }
    
    func sumOfLeftLeaves2Help(_ root: TreeNode?) {
        if root == nil {
            return
        }
        
        sumOfLeftLeaves2Help(root?.left)
        sumOfLeftLeaves2Help(root?.right)
        
        var mid = 0
    
        if root?.left != nil && root?.left?.left == nil &&
            root?.left?.right == nil{
            mid = root!.left!.val
            sum404 += mid
        }
    }
    
    // MARK: 112. 路径总和
    var sum112 = 0
    var result112 = false
    func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        if root == nil {
            return false
        }
        hasPathSumHelp(root, targetSum)
        return result112
    }
    
    func hasPathSumHelp(_ root: TreeNode?, _ targetSum: Int) {
        sum112 += root!.val
        
        if root != nil && root?.left == nil && root?.right == nil{
            if sum112 == targetSum {
                result112 = true
            }
            return
        }
        
        if let left = root?.left {
            hasPathSumHelp(left, targetSum)
            sum112 -= left.val
        }
        
        if let right = root?.right {
            hasPathSumHelp(right, targetSum)
            sum112 -= right.val
        }
        
    }

    
    // MARK: 113. 路径总和 II
    var sum113 = 0
    var result113 = [[Int]]()
    var path113 = [Int]()
    
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        if root == nil {
            return []
        }
        pathSumHelp(root, targetSum)
        return result113
    }
    
    func pathSumHelp(_ root: TreeNode?, _ targetSum: Int) {
        sum113 += root!.val
        path113.append(root!.val)
        
        if root != nil && root?.left == nil && root?.right == nil{
            if sum113 == targetSum {
                result113.append(path113)
            }
            return
        }
        
        if let left = root?.left {
            pathSumHelp(left, targetSum)
            sum113 -= left.val
            path113.removeLast()
        }
        
        if let right = root?.right {
            pathSumHelp(right, targetSum)
            sum113 -= right.val
            path113.removeLast()
        }
        
    }
    
    // MARK: 重建二叉树 106. 从中序与后序遍历序列构造二叉树
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        if inorder.count == 0 || postorder.count == 0 {
            return nil
        }
        
        return buildTreeHelp(inorder,postorder)
    }
    
    func buildTreeHelp(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        if postorder.count == 0 {
            return nil
        }
        
        let root = TreeNode.init(postorder.last!)
        if postorder.count == 1 {
            return root
        }
        
        var index = 0
        for i in 0..<inorder.count {
            if root.val == inorder[i]{
                index = i
                break
            }
        }
        
        // 找到后序数组尾项在中序数组中的位置，即为二叉树的根节点
        let inorderLeftArr = [Int](inorder[0..<index])
        let inorderRightArr = [Int](inorder[(index+1)...])
        
        // 后序尾节点已经使用，移除
        var postorder = postorder
        postorder.removeLast()
        
        // 后序数组左右个数和中序数组切割后的个数相同
        root.left = buildTreeHelp(inorderLeftArr, [Int](postorder[0..<inorderLeftArr.count]))
        root.right = buildTreeHelp(inorderRightArr, [Int](postorder[inorderLeftArr.count...]))
        
        return root
    }
    
     // MARK: 重建二叉树 105. 从前序与中序遍历序列构造二叉树
    func buildTree2(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if inorder.count == 0 || preorder.count == 0 {
            return nil
        }
        
        return buildTree2Help(inorder,preorder)
    }
    
    func buildTree2Help(_ inorder: [Int], _ preorder: [Int]) -> TreeNode? {
        if preorder.count == 0 {
            return nil
        }
        
        let root = TreeNode.init(preorder.first!)
        if preorder.count == 1 {
            return root
        }
        
        var index = 0
        for i in 0..<inorder.count {
            if root.val == inorder[i]{
                index = i
                break
            }
        }
        
        // 找到后序数组尾项在中序数组中的位置，即为二叉树的根节点
        let inorderLeftArr = [Int](inorder[0..<index])
        let inorderRightArr = [Int](inorder[(index+1)...])
        
        // 后序尾节点已经使用，移除
        var preorder = preorder
        preorder.removeFirst()
        
        // 后序数组左右个数和中序数组切割后的个数相同
        root.left = buildTree2Help(inorderLeftArr, [Int](preorder[0..<inorderLeftArr.count]))
        root.right = buildTree2Help(inorderRightArr, [Int](preorder[inorderLeftArr.count...]))
        
        return root
    }
    
    // MARK: 654. 最大二叉树
    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 {
            return nil
        }
        
        if nums.count == 1 {
            return TreeNode.init(nums[0])
        }
        
        var maxValue = nums[0]
        var maxIndex = 0
        for i in 1..<nums.count {
            if nums[i] > maxValue {
                maxValue = nums[i]
                maxIndex = i
            }
        }
        
        let root = TreeNode.init(nums[maxIndex])
        root.left = constructMaximumBinaryTree([Int](nums[0..<maxIndex]))
        root.right = constructMaximumBinaryTree([Int](nums[(maxIndex+1)...]))
        
        return root
    }
    
    // MARK: 617. 合并二叉树
    func mergeTrees(_ root1: TreeNode?, _ root2: TreeNode?) -> TreeNode? {
        if root1 == nil {
            return root2
        }
        if root2 == nil {
            return root1
        }
        
        let root = TreeNode.init(0)
        root.val = root1!.val + root2!.val
        
        root.left = mergeTrees(root1?.left, root2?.left)
        root.right = mergeTrees(root1?.right, root2?.right)
        
        return root
    }
    
    // MARK: 700. 二叉搜索树中的搜索
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else {
            return nil
        }
        if root.val == val  {
            return root
        }
        if root.left != nil && root.val > val{
            return searchBST(root.left, val)
        }
        
        if root.right != nil && root.val < val{
            return searchBST(root.right, val)
        }
        return nil
    }
    
    // MARK: 98. 验证二叉搜索树
    var preValue: Int? = nil
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        let left: Bool = isValidBST(root!.left)
        if preValue != nil && preValue! >= root!.val {
            return false
        }
        preValue = root!.val
        let right: Bool = isValidBST(root!.right)
        return left && right
    }
    
    // MARK: 530. 二叉搜索树的最小绝对差
    var minValue: Int = INTPTR_MAX
    var preNode: TreeNode? = nil
    
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        getMinimumDifferenceHelp(root)
        return minValue
    }
    
    func getMinimumDifferenceHelp(_ root: TreeNode?) {
        if root == nil {
            return
        }
        getMinimumDifferenceHelp(root?.left)
        if let pre = preNode {
            minValue = min(minValue, root!.val - pre.val)
        }
        preNode = root
        getMinimumDifferenceHelp(root?.right)
    }
    
    // MARK: 501. 二叉搜索树中的众数
//    func findMode(_ root: TreeNode?) -> [Int] {
//
//    }
    
    // MARK: 236. 二叉树的最近公共祖先
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil || root === p || root === q{
            return root
        }
        
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        
        if left != nil && right != nil {
            return root
        }
        
        if left != nil {
            return left
        } else {
            return right
        }
    }
    
    // MARK: 235. 二叉搜索树的最近公共祖先
    func lowestCommonAncestor2(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil {
            return root
        }
        
        if root!.val > p!.val && root!.val > q!.val {
            let left: TreeNode? = lowestCommonAncestor2(root?.left, p, q)
            if left != nil{
                return left
            }
        }
        
        if root!.val < p!.val && root!.val < q!.val {
            let right: TreeNode? = lowestCommonAncestor2(root?.right, p, q)
            if right != nil{
                return right
            }
        }
        return root
    }
    
    func lowestCommonAncestor3(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        var root = root
        while root != nil {
            if root!.val > p!.val && root!.val > q!.val {
                root = root?.left
            } else if root!.val < p!.val && root!.val < q!.val {
                root = root?.right
            } else {
                return root
            }
        }
        
        return root
    }
    
    // MARK: 701. 二叉搜索树中的插入操作
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        if root == nil {
            return TreeNode.init(val)
        }
        
        if root!.val > val {
            root?.left = insertIntoBST(root?.left, val)
        }
        
        if root!.val < val {
            root?.right = insertIntoBST(root?.right, val)
        }
        
        return root
    }
    
    func insertIntoBST2(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        if root == nil {
            return TreeNode.init(val)
        }
        var cur = root
        var parent: TreeNode? = nil
        
        while cur != nil {
            parent = cur
            if cur!.val > val {
                cur = cur?.left
            } else {
                cur = cur?.right
            }
        }
        
        if parent!.val > val {
            parent?.left = TreeNode.init(val)
        } else {
            parent?.right = TreeNode.init(val)
        }
        
        return root
    }
    
    // MARK: 102. 二叉树的层序遍历  BFS
    func levelOrder2(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var result: Array = [[Int]]()
        
        var queue: Array = [TreeNode?]()
        queue.append(root)
        
        while queue.count > 0 {
            let count = queue.count
            var numbers: Array = [Int]()
            for _ in 0..<count {
                let treeNode = queue.removeFirst()
                numbers.append(treeNode!.val)
                
                if treeNode?.left != nil {
                    queue.append(treeNode?.left)
                }
                
                if treeNode?.right != nil {
                    queue.append(treeNode?.right)
                }
            }
            result.append(numbers)
        }
        
        return result
    }
    
    // MARK: 199. 二叉树的右视图 BFS
    func rightSideView(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        var result = [Int]()
        var queue = [TreeNode]()
        queue.append(root!)
        
        while !queue.isEmpty {
            // 记录最右边的元素
            result.append(queue.last!.val)
            
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                if node.left != nil {
                    queue.append(node.left!)
                }
                if node.right != nil {
                    queue.append(node.right!)
                }
            }
        }
        return result
    }
    // MARK: 637. 二叉树的层平均值 BFS
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        if root == nil {
            return []
        }
        var result = [Double]()
        var queue = [TreeNode]()
        queue.append(root!)
        
        while !queue.isEmpty {
            var nums = [Int]();
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                nums.append(node.val)
                
                if node.left != nil {
                    queue.append(node.left!)
                }
                if node.right != nil {
                    queue.append(node.right!)
                }
            }
            let sum = nums.reduce(0, {$0+$1})
            result.append(Double(sum) / Double(count))
        }
        return result
    }
    
    
     
      public class Node2 {
          public var val: Int
          public var children: [Node2]
          public init(_ val: Int) {
              self.val = val
              self.children = []
          }
      }
     
    // MARK: 429. N 叉树的层序遍历 给定一个 N 叉树，返回其节点值的层序遍历。（即从左到右，逐层遍历）。BFS
    func levelOrder666(_ root: Node2?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var result = [[Int]]()
        var queue = [Node2]()
        queue.append(root)
        
        while !queue.isEmpty {
            var nums = [Int]();
            let count = queue.count
            for _ in 0..<count {
                let node = queue.removeFirst()
                nums.append(node.val)
                
                for childrenNode in node.children {
                    queue.append(childrenNode)
                }
            }
            result.append(nums)
        }
        return result

    }
    
    public class Node3 {
        public var val: Int
        public var left: Node3?
        public var right: Node3?
        public var next: Node3?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
            self.next = nil
        }
    }
   
  // MARK: 116. 填充每个节点的下一个右侧节点指针 BFS
    func connect(_ root: Node3?) -> Node3? {
        guard let root = root else { return nil }
        var queue = [Node3?]()
        queue.append(root)
        
        while !queue.isEmpty {
            let count = queue.count
            var nodes = [Node3?]()
            for _ in 0..<count {
                let node = queue.removeFirst()
                nodes.append(node)

                if node?.left != nil {
                    queue.append(node?.left)
                }
                if node?.right != nil {
                    queue.append(node?.right)
                }
            }
            
            for i in 0..<nodes.count {
                if i > 0 {
                    let node1 = nodes[i-1]
                    let node2 = nodes[i]
                    node1?.next = node2
                }
            }
        }
        return root
    }
    
    
    // MARK: 513. 找树左下角的值 BFS
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }
        
        var result = 0
        var queue = [TreeNode?]()
        queue.append(root)
        
        while queue.count > 0 {
            let size = queue.count
            for i in 0..<size {
                let node = queue.removeFirst()
                if i == 0 { result = node!.val }
                
                if let left = node?.left {
                    queue.append(left)
                }
                if let right = node?.right {
                    queue.append(right)
                }
            }
        }
        return result
    }
    
    // MARK: 515. 在每个树行中找最大值 BFS
    func largestValues(_ root: TreeNode?) -> [Int] {
        guard let root = root else {
            return []
        }
        
        var result = [Int]()
        var queue = [root]
        
        while queue.count > 0 {
            let count = queue.count
            var maxValue = Int.min
            for _ in 0..<count {
                let node = queue.removeFirst()
                maxValue = max(maxValue, node.val)
                if let left = node.left{
                    queue.append(left)
                }
                
                if let right = node.right{
                    queue.append(right)
                }
            }
            result.append(maxValue)
        }
        return result
    }
    
    // MARK: 543. 二叉树的直径
    var maxV = 0
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        if root == nil || (root?.left == nil && root?.right == nil){
            return 0
        }

        deepth(root)
        return maxV
    }
    
    func deepth(_ root: TreeNode?) -> Int {
        if root == nil{
            return 0
        }
        
        let left = deepth(root?.left)
        let right = deepth(root?.right)
        maxV = max(maxV, left + right)
        return max(left, right) + 1
    }
    
    // MARK: 108. 将有序数组转换为二叉搜索树
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 {
            return nil
        }
        return sortedHelp(nums, 0, nums.count - 1)
    }
    
    func sortedHelp(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left > right {
            return nil
        }
        
        let mid = left + (right - left)/2
        let root: TreeNode? = TreeNode.init(nums[mid])
        root?.left = sortedHelp(nums, left, mid - 1)
        root?.right = sortedHelp(nums, mid + 1, right)
        
        return root
    }
    
    // MARK: 538. 把二叉搜索树转换为累加树
    var preValue2: Int = 0
    
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        convertBSTHelp(root)
        return root
    }
    
    func convertBSTHelp(_ root: TreeNode?) {
        if root == nil {
            return
        }
        convertBSTHelp(root?.right)
        root?.val += preValue2
        preValue2 = root!.val
        convertBSTHelp(root?.left)
    }
    
    // MARK: - 双指针
    //MARK: 392. 判断子序列
    func isSubsequence2(_ s: String, _ t: String) -> Bool {
        
        var i = 0, j = 0
        var sArr = Array(s)
        var tArr = Array(t)
        
        while i<sArr.count && j<tArr.count{
            if sArr[i] == tArr[j]{
                i += 1
            }
            j += 1
        }
        if i == s.count {
            return true
        }
        return false
    }
    
    // MARK: - 回溯算法
    // MARK: 77. 组合
    var result1 = [[Int]]()
    var path1 = [Int]()
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        combineHelp(n, k, 1)
        return result1
    }
    
    func combineHelp(_ n: Int, _ k: Int, _ startIndex: Int) {
        if path1.count == k {
            result1.append(path1)
            return
        }
        for i in startIndex..<n+1 {
            path1.append(i)
            combineHelp(n, k, i+1)
            path1.removeLast()
        }
    }
    // 剪枝操作
    func combineHelp2(_ n: Int, _ k: Int, _ startIndex: Int) {
        if path1.count == k {
            result1.append(path1)
            return
        }
        var i = startIndex
        while i <= n - (k - path1.count) + 1 {
            path1.append(i)
            combineHelp2(n, k, i+1)
            path1.removeLast()
            i += 1
        }
    }
    
    // MARK: 40. 组合总和 II
//    给定一个数组 candidates 和一个目标数 target ，找出 candidates 中所有可以使数字和为 target 的组合。
//
//    candidates 中的每个数字在每个组合中只能使用一次。
//
//    注意：解集不能包含重复的组合。   （（数组中有重复元素））
    var result2 = [[Int]]()
    var path2 = [Int]()
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        let used: Array = Array.init(repeating: 0, count: candidates.count)
        
        combinationSum2Help(candidates.sorted(), target, 0, 0, used)
        return result2
    }
    
    func combinationSum2Help(_ candidates: [Int], _ target: Int,_ startIndex: Int, _ sum:Int, _ used: [Int]) {
        
        if sum == target {
            result2.append(path2)
            return
        }
        
        var i = startIndex
        var sum = sum
        var used = used
        while i < candidates.count {
            let num = candidates[i]
            if sum + num > target{
                return
            }
            
            if i > 0 && num == candidates[i-1] && used[i-1] == 0 {
                i += 1
                continue
            }
            
            sum += num
            path2.append(num)
            used[i] = 1
            
            combinationSum2Help(candidates, target, i + 1, sum, used)
            
            sum -= num
            path2.removeLast()
            used[i] = 0
            
            i += 1
        }
    }
    
    
    // MARK: 216. 组合总和 III 找出所有相加之和为 n 的 k 个数的组合。组合中只允许含有 1 - 9 的正整数，并且每种组合中不存在重复的数字。
    var result3 = [[Int]]()
    var path3 = [Int]()
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        combinationSum3Help(k, n, 1, 0)
        return result3
    }
    
    func combinationSum3Help(_ k: Int, _ n: Int, _ startIndex: Int, _ sum: Int) {
        if path3.count == k {
            if sum == n {
                result3.append(path3)
            }
            return
        }
        
        var i = startIndex
        var sum = sum
        
        while i <= 9 {
            sum += i
            if sum > n {
                return
            }
            path3.append(i)
            combinationSum3Help(k, n, i + 1, sum)
            sum -= i
            path3.removeLast()
            i += 1
        }
    }
    
    // MARK: 39. 组合总和
    var result = [[Int]]()
    var path = [Int]()
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        combinationSumHelp(candidates, target, 0, 0)
        return result
    }
    
    func combinationSumHelp(_ candidates: [Int], _ target: Int, _ startIndex: Int, _ sum :Int){
        
        if sum > target {
            return
        }
        
        if sum == target {
            result.append(path)
            return
        }
        var sum = sum
        
        for i in startIndex..<candidates.count {
            let num = candidates[i]
            sum += num
//            if sum > target {
//                return
//            }
            path.append(num)
            combinationSumHelp(candidates, target, i, sum)
            sum -= num
            path.removeLast()
        }
        
    }
    
    var resultS = [String]()
    var s :String = String()
    var lettersArr: [[Character]] = [
        [], // 0
        [], // 1
        ["a","b","c"],// 2
        ["d","e","f"],// 3
        ["g","h","i"],// 4
        ["j","k","l"],// 5
        ["m","n","o"],// 6
        ["p","q","r","s"], // 7
        ["t","u","v"],// 8
        ["w","x","y","z"] // 9
    ]
    
    // MARK: 17. 电话号码的字母组合
    func letterCombinations(_ digits: String) -> [String] {
        if digits.count == 0 {
            return []
        }
        letterCombinationsHelp(Array(digits), 0)
        return resultS
    }
    
    func letterCombinationsHelp(_ digits: [Character], _ startIndex: Int) {
        if s.count == digits.count {
            resultS.append(s)
            return
        }
        let index = Int(String(digits[startIndex]))
        let letters = lettersArr[index!]
        
        for i in 0..<letters.count {
            s += String(letters[i])
            letterCombinationsHelp(digits, startIndex+1)
            s.removeLast()
        }
    }
    
    // MARK: 131. 分割回文串
    var result4 = [[String]]()
    var path4 = [String]()
    func partition(_ s: String) -> [[String]] {
        partitionHelp(s, s.startIndex)
        return result4
    }
    
    func partitionHelp(_ s: String, _ startIndex: String.Index) {
        if startIndex >= s.endIndex{
            result4.append(path4)
            return
        }
        
        var i = startIndex
        while i < s.endIndex {
            
            if isPalindrome(s, startIndex, endIndex: i){
                let subString = s[startIndex...i]
                path4.append(String(subString))
                partitionHelp(s, s.index(after: i))
                path4.removeLast()
                i = s.index(after: i)
            } else {
                i = s.index(after: i)
                continue
            }
        }
        
    }
    
    //判断是否是回文
    func isPalindrome(_ s: String, _ startIndex: String.Index, endIndex: String.Index) -> Bool {
        var startIndex = startIndex
        var endIndex = endIndex
        while endIndex > startIndex {
            if s[startIndex] != s[endIndex] {
                return false
            }
            endIndex = s.index(before: endIndex)
            startIndex = s.index(after: startIndex)
        }
        
        return true
    }
    
    // MARK: 93. 复原 IP 地址
    var result5 = [String]()
    var path5 = [String]()
    func restoreIpAddresses(_ s: String) -> [String] {
        restoreIpAddressesHelp(s, s.startIndex)
        return result5
    }
    
    func restoreIpAddressesHelp(_ s: String, _ startIndex: String.Index) {
        if path5.count == 4 {
            result5.append(path5.joined(separator: "."))
            return
        }
        
        var i = startIndex
        while i < s.endIndex {
            if path5.count == 3{
                // 已经存了3个 合法IP，只需要判断剩下的字符是否合法.相当于剪枝
                let subString = s[startIndex..<s.endIndex]
                let IPAddressStr = String(subString)
                
                if isValid5(IPAddressStr){
                    path5.append(IPAddressStr)
                    result5.append(path5.joined(separator: "."))
                    path5.removeLast()
                }
                return
            }
            
            let subString = s[startIndex...i]
            let IPAddressStr = String(subString)
            
            if isValid5(IPAddressStr){
                path5.append(IPAddressStr)
                restoreIpAddressesHelp(s, s.index(after: i))
                path5.removeLast()
            }

            i = s.index(after: i)
        }
        
    }
    
    func isValid5(_ s: String ) -> Bool {
        if s.count == 0 || s.count > 3 {
            return false
        }
        
        // 0 开头的数字不合法。除了只有一位数0以外
        if s.count > 1 && String(s[s.startIndex]) == "0"{
            return false
        }

        var num = 0
        for char in s {
            num = num * 10 + Int(String(char))!
        }

        if num > 255 {
            return false
        }

        
//        if Int(s)! > 255 {
//            return false
//        }
        return true
    }
    
    // MARK: 78. 子集
    func subsets(_ nums: [Int]) -> [[Int]] {
        subsetsHelp(nums,0)
        return result
    }
    
    func subsetsHelp(_ nums: [Int], _ startIndex: Int)  {
        result.append(path)
        let count = nums.count
        if startIndex >= count {
            return
        }
        
        var i = startIndex
        while i < count {
            path.append(nums[i])
            subsetsHelp(nums, i + 1)
            path.removeLast()
            i += 1
        }
    }
    
    // MARK: 90. 子集 II  （需要去重）
    var result6 = [[Int]]()
    var path6 = [Int]()
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        let used = Array.init(repeating: 0, count: nums.count)
        subsetsWithDupHelp(nums.sorted(), 0, used)
        return result6
    }
    
    func subsetsWithDupHelp(_ nums: [Int], _ startIndex: Int, _ used: [Int])  {
        result6.append(path6)
        
        var i = startIndex
        var used = used
        
        while i < nums.count {
            if i > 0 && nums[i] == nums[i-1] && used[i-1] == 0{
                i += 1
                continue
            }
            path6.append(nums[i])
            used[i] = 1
            
            subsetsWithDupHelp(nums, i + 1, used)
            
            path6.removeLast()
            used[i] = 0
            i += 1
        }
    }
    // MARK: 491. 递增子序列
    func findSubsequences(_ nums: [Int]) -> [[Int]] {
        
        findSubsequencesHelp(nums, 0)
        return result6
    }
    
    func findSubsequencesHelp(_ nums: [Int], _ startIndex: Int) {
        if path6.count > 1 {
            result6.append(path6)
//            return 注意这里不要return，要去树上的节点
        }
        var arr = [Int]()
        
        for i in startIndex..<nums.count {
            if ((path6.count != 0 && nums[i] < path6.last!) ||
                arr.contains(nums[i]) ){
                continue
            }
            arr.append(nums[i])
            
            path6.append(nums[i])
            findSubsequencesHelp(nums, i + 1)
            path6.removeLast()
        }
    
    }
    
    // MARK: 46. 全排列
    func permute(_ nums: [Int]) -> [[Int]] {
        let used = Array.init(repeating: 0, count: nums.count)
        permuteHelp(nums, used)
        return result6
    }
    
    func permuteHelp(_ nums: [Int], _ used:[Int]) {
        if path6.count == nums.count {
            result6.append(path6)
            return
        }
        var used = used
        for i in 0..<nums.count {
            if used[i] == 1 {
                continue
            }
            path6.append(nums[i])
            used[i] = 1
            permuteHelp(nums, used)
            path6.removeLast()
            used[i] = 0
        }
    }
    // MARK: 47. 全排列 II
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        let used = Array.init(repeating: 0, count: nums.count)
        permuteUniqueHelp(nums.sorted(), used)
        return result6
    }
    
    func permuteUniqueHelp(_ nums: [Int], _ used:[Int]) {
        if path6.count == nums.count {
            result6.append(path6)
            return
        }
        var used = used
        for i in 0..<nums.count {
            if i > 0 && nums[i] == nums[i-1] && used[i-1] == 0{
                continue
            }
            if used[i] == 1 {
                continue
            }
            path6.append(nums[i])
            used[i] = 1
            permuteUniqueHelp(nums, used)
            path6.removeLast()
            used[i] = 0
        }
    }
    
    // MARK: - 贪心算法
    // MARK: 455. 分发饼干
    
    func findContentChildren(_ g: [Int], _ s: [Int]) -> Int {
        var result = 0
        var g = g.sorted()
        var s = s.sorted()
        
        var i = s.count - 1
        var j = g.count - 1
        
        while j >= 0 {
            if i >= 0 && s[i] >= g[j] {
                result += 1
                i -= 1
            }
            j -= 1
        }
        
        return result
    }
    
    //MARK: 121. 买卖股票的最佳时机
    func maxProfit(_ prices: [Int]) -> Int {
        var low = Int.max
        var result = 0
        // 贪心，找左边的最小值，找右边的最大利润
        for num in prices {
            low = min(low, num)
            result = max(result, num - low)
        }
        return result
    }
    
    //MARK: 674. 最长连续递增序列
    func findLengthOfLCIS2(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        
        var result = 1
        var count = 1
        for i in 0..<nums.count-1 {
            if nums[i+1] > nums[i]{
                count += 1
            } else {
                count = 1
            }
            result = max(result, count)
        }
        
        return result
    }
    
    //MARK: 135. 分发糖果
    func candy(_ ratings: [Int]) -> Int {
        if ratings.count <= 1 {
            return ratings.count
        }
        
        var candyArr = [Int](repeating: 1, count: ratings.count)
        for i in 1..<ratings.count {
            if ratings[i] > ratings[i-1] {
                candyArr[i] = candyArr[i-1] + 1
            }
        }
        
        var j = ratings.count - 2
        while j >= 0 {
            if ratings[j] > ratings[j+1] {
                candyArr[j] = max(candyArr[j], candyArr[j+1] + 1)
            }
            j -= 1
        }
        
        var sum = 0
        for num in candyArr {
            sum += num
        }
        return sum
    }
    
    // MARK: - 动态规划
    // 0-1 背包
    func beibao01(){
        let weight = [2,3,4]
        let value = [15,20,35]
        let capacity: Int = 10
        
        var dp = [[Int]](repeating:[Int](repeating: 0, count: capacity+1), count: weight.count)
        
        for j in weight[0]..<capacity{
            dp[0][j] = value[0]
        }
        
        for i in 1..<weight.count {
            for j in 0...capacity {
                if j < weight[i]{
                    dp[i][j] = dp[i-1][j]
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i-1][j-weight[i]] + value[i])
                }
            }
        }
        
        let maxValue = dp[weight.count - 1][capacity]
    }
    
    func beibao01_2(){
        let weight = [2,3,4]
        let value = [15,20,35]
        let capacity: Int = 10
        
        var dp = [Int](repeating: 0, count: capacity + 1)
        
        for i in 0..<weight.count {
            var j = capacity
            while j >= weight[i]{
                dp[j] = max(dp[j], dp[j-weight[i]] + value[i])
                j -= 1
            }
        }
        let maxValue = dp[capacity]
    }
    
    func beibaowanquan(){
        let weight = [2,3,4]
        let value = [15,20,35]
        let capacity: Int = 10
        
        var dp = [Int](repeating: 0, count: capacity+1)
        
        // 先遍历物品 再遍历背包
        for i in 0..<weight.count {
            var j = weight[i]
            while j<=capacity {
                dp[j] = max(dp[j], dp[j-weight[i]] + value[i])
                j += 1
            }
        }
        
        // 先背包，再物品
        for j in 0...capacity {
            for i in 0..<weight.count {
                if j >= weight[i] {
                    dp[j] = max(dp[j], dp[j-weight[i]] + value[i])
                }
            }
        }
        
        let maxValue = dp[capacity]
    }
    
    
    // MARK: 62. 不同路径
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 1, count: n), count: m)
        
        for i in 1..<m {
            
            for j in 1..<n{
                dp[i][j] = dp[i-1][j] + dp[i][j-1]
            }
        }
        return dp[m-1][n-1]
    }
    // MARK: 63. 不同路径 II
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        
        if m == 0 || n == 0{
            return 0
        }
        var dp = [[Int]](repeating: [Int](repeatElement(0, count: n)), count: m)
        for i in 0..<m {
            if obstacleGrid[i][0] == 1 {
                break
            }
            dp[i][0] = 1
        }
        for j in 0..<n {
            if obstacleGrid[0][j] == 1 {
                break
            }
            dp[0][j] = 1
        }
        
        for i in 1..<m {
            for j in 1..<n {
                if obstacleGrid[i][j] != 1{
                    dp[i][j] = dp[i-1][j] + dp[i][j-1]
                }
            }
        }
        return dp[m-1][n-1]
    }
    //MARK: 343. 整数拆分
    func integerBreak(_ n: Int) -> Int {
        if n < 1{
            return 0
        }

        var dp: Array = [Int](repeating: 0, count: n+1)
        dp[1] = 1
        dp[2] = 1
        if n >= 3{
            for i in 3...n {
                for j in 1...i-1 {
                    dp[i] = max(dp[i], max(j*(i-j), j*dp[i-j]))
                }
            }
        }

        return dp[n]
    }
    
    
    func integerBreak2(_ n: Int) -> Int {
        // 题干n>=2
        var dp = [Int](repeating: 0, count: n+1)
        dp[2] = 1
        if n > 2 {
            for i in 3...n {
                for j in 1..<i-1 {
                    dp[i] = max(dp[i], j*(i-j), j*dp[i-j])
                }
            }
        }
        return dp[n]
    }
    //MARK: 96. 不同的二叉搜索树
    func numTrees(_ n: Int) -> Int {
        var dp = [Int](repeating: 0, count: n+1)
        dp[0] = 1
        if n > 0 {
            for i in 1...n {
                for j in 1...i {
                    dp[i] += dp[j-1]*dp[i-j]
                }
            }
        }

        return dp[n]
    }
    
    //MARK: 416. 分割等和子集
    func canPartition(_ nums: [Int]) -> Bool {
        
        var sum = 0
        for item in nums {
            sum += item
        }
        
        if sum % 2 == 1 {
            return false
        }
        
        let target = sum / 2
        var dp = [Int](repeating: 0, count: target+1)
        
        for i in 1..<nums.count {
            var j = target
            while j >= nums[i]{
                dp[j] = max(dp[j], dp[j-nums[i]] + nums[i])
                j -= 1
            }
        }
        
        if dp[target] == target {
            return true
        }
        return false
    }
    
    func canPartition2(_ nums: [Int]) -> Bool {
        var sum = 0
        for item in nums {
            sum += item
        }
        
        if sum & 1 == 1 {
            return false
        }
        
        let target = sum / 2
        var dp = [Int](repeating: 0, count: target+1)
        for i in 0..<nums.count {
            var j = target
            while j >= nums[i] {
                dp[j] = max(dp[j], dp[j-nums[i]] + nums[i])
                j -= 1
            }
        }
        
        return dp[target] == target
    }
    
    // MARK: 1049. 最后一块石头的重量 II
    func lastStoneWeightII(_ stones: [Int]) -> Int {
        var sum = 0
        for num in stones {
            sum += num
        }
        let target = sum / 2
        var dp = [Int](repeating: 0, count: target + 1)
        
        for i in 0..<stones.count {
            var j = target
            while j >= stones[i] {
                dp[j] = max(dp[j], dp[j-stones[i]] + stones[i])
                j -= 1
            }
        }
        
        return sum - dp[target] - dp[target]
    }
    
     //MARK: 494. 目标和
    func findTargetSumWays(_ nums: [Int], _ target: Int) -> Int {
        var sum = 0
        for num in nums {
            sum += num
        }
        
        if abs(target) > sum {
            return 0
        }
        let findSum = (target + sum)/2
        if (target + sum)%2 == 1{
            return 0
        }
        
        var dp = [Int](repeating: 0, count: findSum + 1)
        dp[0] = 1
        
        for num  in nums {
            var j = findSum
            while j >= num {
                dp[j] += dp[j-num]
                j -= 1
            }
        }
        
        return dp[findSum]
    }
    
    //MARK: 518. 零钱兑换 II
    
    func change2(_ amount:Int, _ coins:[Int]) -> Int {
        var dp = [Int](repeating: 0, count: coins.count)
        dp[0] = 1
        
        for i in 1..<coins.count {
            var j = coins[i]
            while j <= amount {
                dp[j] += dp[j-coins[i]]
                j += 1
            }
        }
        
        return dp[amount]
    }
    
    
    
    
    func change3(_ amount:Int, _ coins:[Int]) -> Int {
        var dp = [Int](repeating: 0 , count: amount + 1)
        dp[0] = 1
        
        for num in coins {
            var j = num
            while j <= amount {
                dp[j] += dp[j-num]
                j += 1
            }
        }
        return dp[amount]
    }

//    int change(int amount, vector<int>& coins) {
//    vector<int> dp(amount + 1, 0);
//    dp[0] = 1;
//    for (int i = 0; i < coins.size(); i++) { // 遍历物品
//      for (int j = coins[i]; j <= amount; j++) { // 遍历背包
//          dp[j] += dp[j - coins[i]];
//       }
//    }
//       return dp[amount];
//    }
    
    //MARK: 322. 零钱兑换
//    int coinChange(vector<int>& coins, int amount) {
//        vector<int> dp(amount + 1, INT_MAX);
//        dp[0] = 0;
//        for (int i = 0; i < coins.size(); i++) {
//            for (int j = coins[i]; j <= amount; j++) {
//                if (dp[j-coins[i]] == INT_MAX) {
//                continue;
//            }
//            dp[j] = min(dp[j], dp[j-coins[i]]+1);
//            }
//        }
//
//        if (dp[amount] == INT_MAX) {
//            return -1;
//        }
//        return dp[amount];
//    }
    
    //MARK: 377. 组合总和 Ⅳ
    //给你一个由 不同 整数组成的数组 nums ，和一个目标整数 target 。请你从 nums 中找出并返回总和为 target 的元素组合的个数。
    //题目数据保证答案符合 32 位整数范围。
//    int combinationSum4(vector<int>& nums, int target) {
//    vector<int> dp(target + 1, 0);
//    dp[0] = 1;
//    for (int j = 0; j <= target; j ++) {
//
//    for (int i = 0; i < nums.size(); i++) {
//    if (j >= nums[i] && dp[j] < INT_MAX - dp[j - nums[i]] ) {
//      dp[j] += dp[j - nums[i]];
//    }
//    }
//    }
//    return dp[target];
//    }
    
    
    
    //MARK: 377. 组合总和 Ⅳ
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        
        var dp = [Int](repeating: 0, count: target + 1)
        dp[0] = 1
        for j in 0...target {
            for i in 0..<nums.count{
                if j >= nums[i] && dp[j] < Int.max - dp[j-nums[i]]{
                    dp[j] += dp[j-nums[i]]
                }
            }
        }
        
        return dp[target]
    }
    
    //MARK: 279. 完全平方数
    func numSquares(_ n: Int) -> Int {
        var dp = [Int](repeating:Int.max, count: n + 1)
        dp[0] = 0
        var i = 1
        while i*i <= n {
            var j = i*i
            while j <= n {
                dp[j] = min(dp[j], dp[j - i*i] + 1)
                j += 1
            }
            i += 1
        }
        return dp[n]
    }
    
     //MARK: 198. 打家劫舍
    func rob(_ nums: [Int]) -> Int {
        var dp = [Int](repeating: 0, count: nums.count)
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        
        if nums.count >= 3 {
            for i in 2..<nums.count {
                dp[i] = max(dp[i-2]+nums[i], dp[i-1])
            }
        }
        
        return dp[nums.count - 1]
    }
    
    //MARK: 213. 打家劫舍 II
    func rob2(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        let s1 = [Int](nums[0...(nums.count-2)])
        let s2 = [Int](nums[1...nums.count-1])
        
        let res1 = rob2Help(s1)
        let res2 = rob2Help(s2)
        
        return max(res1, res2)
    }
    
    func rob2Help(_ nums: [Int]) -> Int {
        if nums.count == 1 {
            return nums[0]
        }
        
        var dp = [Int](repeating: 0, count: nums.count)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        
        if nums.count >= 3 {
            for i in 2..<nums.count {
                dp[i] = max(dp[i-1], dp[i-2]+nums[i])
            }
        }
        return dp[nums.count-1]
    }
    
    //MARK: 337. 打家劫舍 III
    func rob3(_ root: TreeNode?) -> Int {
        let res = rob3Help(root)
        return max(res[0], res[1])
    }
    
    func rob3Help(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return [0,0]
        }
        
        let left = rob3Help(root?.left)
        let right = rob3Help(root?.right)
        
        // 偷cur，不可以偷左右
        let val1 = root!.val + left[0] + right[0]
        // 不偷cur ,可以偷左右子树
        let val2 = max(left[0], left[1]) + max(right[0], right[1])
        
        return [val2,val1]
    }
    //MARK: 474. 一和零
    func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n+1), count: m+1)
        
        for str in strs {
            var zeroNum = 0 ,oneNume = 0
            for char in str{
                if String(char) == "0" {
                    zeroNum += 1
                } else {
                    oneNume += 1
                }
            }
            
            var i = m
            while i >= zeroNum {
                var j = n
                while j >= oneNume {
                    dp[i][j] = max(dp[i][j], dp[i-zeroNum][j-oneNume] + 1)
                    j -= 1
                }
                i -= 1
            }
            
        }
        return dp[m][n]
    }
    
    //MARK: 300. 最长递增子序列
    func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        var result = 0
        var dp = [Int](repeating: 1, count: nums.count)
        
        for i in 1..<nums.count {
            for j in 0..<i {
                if nums[i] > nums[j] {
                    dp[i] = max(dp[i], dp[j] + 1)
                }
            }
            result = max(result, dp[i])
        }
        return result
    }
    
    //MARK: 674. 最长连续递增序列
    func findLengthOfLCIS(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count
        }
        var dp = [Int](repeating: 1, count: nums.count)
        var result = 0
        for i in 0..<nums.count-1 {
            if nums[i+1] > nums[i] {
                dp[i+1] = dp[i] + 1
            }
            result = max(result, dp[i+1])
        }
        return result
    }
    
    //MARK: 718. 最长重复子数组
    func findLength(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: nums2.count+1), count: nums1.count + 1)
        
        var result = 0
        for i in 1...nums1.count {
            for j in 1...nums2.count {
                if nums1[i-1] == nums2[j-1] {
                    dp[i][j] = dp[i-1][j-1] + 1
                }
                result = max(result, dp[i][j])
            }
        }
        return result
    }
    
    //MARK: 1143. 最长公共子序列
//    1035. 不相交的线
    func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: text2.count+1), count: text1.count+1)
        let arr1 = Array(text1)
        let arr2 = Array(text2)
        for i in 1...arr1.count {
            for j in 1...arr2.count {
                if arr1[i-1] == arr2[j-1] {
                    dp[i][j] = dp[i-1][j-1] + 1
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
            }
        }
        return dp[arr1.count][arr2.count]
    }
    
    func maxUncrossedLines(_ nums1: [Int], _ nums2: [Int]) -> Int {
        var dp = [[Int]](repeating: [Int](repeating: 0, count: nums2.count+1), count: nums1.count+1)

        for i in 1...nums1.count {
            for j in 1...nums2.count {
                if nums1[i-1] == nums2[j-1] {
                    dp[i][j] = dp[i-1][j-1] + 1
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
            }
        }
        return dp[nums1.count][nums2.count]
    }
    
    //MARK: 53. 最大子序和
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        var result = nums[0]
        var dp = [Int](repeating: 0, count: nums.count)
        dp[0] = nums[0]
        
        if nums.count > 1 {
            for i in 1..<nums.count {
                dp[i] = max(dp[i-1] + nums[i], nums[i])
                result = max(result, dp[i])
            }
        }
        return result
    }
    
    //MARK: 392. 判断子序列
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        
        var sArr = Array(s)
        var tArr = Array(t)
        
        var dp = [[Int]](repeating: [Int](repeating: 0, count: t.count+1), count: s.count+1)
        
        if s.count>1 && t.count>1 {
            for i in 1...sArr.count {
                for j in 1...tArr.count{
                    if sArr[i-1] == tArr[j-1]{
                        dp[i][j] = dp[i-1][j-1] + 1
                    } else {
                        dp[i][j] = dp[i][j-1]
                    }
                }
            }
        }
        
        if dp[sArr.count][tArr.count] == s.count {
            return true
        }
        return false
    }
}
