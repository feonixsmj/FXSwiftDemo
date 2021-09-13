//
//  FirstViewController.swift
//  FXSwiftDemo
//
//  Created by FeoniX on 2019/4/16.
//  Copyright © 2019 FX. All rights reserved.
//

import UIKit

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

class Solution {
    public var node1: ListNode?
    public var node2: ListNode?
    
    func createListNode() -> Void {
        var curr : ListNode?
        
        for i in [1,3,5,7] {
            let node:ListNode = ListNode.init(i)
            if node1 == nil {
                node1 = node
            } else {
                curr?.next = node
            }
            curr = node
        }
        
        var curr2 : ListNode?
        
        for i in [2,4,6,8] {
            let node:ListNode = ListNode.init(i)
            if node2 == nil {
                node2 = node
            } else {
                curr2?.next = node
            }
            curr2 = node
        }
    }
    
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil {
            return l2
        } else if l2 == nil {
            return l1
        } else if l1!.val < l2!.val{
            l1?.next = mergeTwoLists(l1?.next, l2)
            return l1;
        } else {
            l2?.next = mergeTwoLists(l2?.next, l1)
            return l2
        }
        
    }
    
}



class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("hello,swift");
        
        let optionalName: String? = "John Appleseed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        print(greeting);
        
        
        let nickName: String? = nil
        let fullName: String = "John"
        let informalGreeting = "Hi \(nickName ?? fullName)";
        
        print(informalGreeting);
        
        print(greet("bob", day: "Tuesday"))
        
        
        let result = calculate(scores: [5,3,100,2,1])
        
        print("\(result.min),\(result.max),\(result.sum)")
        
//        Fifteen()
//        majorityElement([3,2,3])
        
//        let s:Solution = Solution.init()
//        s.createListNode()
//        let rList:ListNode? = s.mergeTwoLists(s.node1, s.node2)
//        print(rList)
        
//        search([5,7,7,8,8,10], 8)
//        0.00001
//        2147483647
//        let i  = myPow(0.00001, 2147483647)
//        print("N 次方，\(i)");
        
//        minArray([1])
//        minArray2([3,1,1])
        
//        isValid("([)]")
//        verifyPostorder([4, 8, 6, 12, 16, 14, 10])
        
//        lengthOfLongestSubstring("pwwkew")
        findRepeatNumber([2, 3, 1, 0, 2, 5, 3])
        
//        findRepeatNumber2([2,1,8,8,3,4,5,6,7])
        
//        bookMethod([2,1,8,8,3,4,5,6,7])
        
        spiralOrder([[1,2,3],[4,5,6]])
    }
    
    func greet(_ person:String, day:String) -> String {
        return "hello \(person), today is \(day)."
    }
    
    func calculate(scores :[Int]) -> (min:Int,max:Int,sum:Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min{
                min = score
            }
            sum = score + sum;
        }
        
        return (min,max,sum)

    }
    
    /// 嵌套函数
    ///
    /// - Returns:
    func Fifteen() -> Int {
        var y = 10
        func add() {
            y += 5
        }
        add()
        return y
    }
    
    func majorityElement(_ nums: [Int]) -> Int {
        
        var dict = [Int:Int]()
        var maxNumber :Int = 0
        var majority:Int = 0
        
        for i in 0..<nums.count {
            let key = nums[i]
            
            if dict.keys.contains(key) {
                dict[key]! += 1
                if maxNumber < dict[key]! {
                    maxNumber = dict[key]!
                    majority = key;
                }
            } else {
                dict[key] = 1
            }
        }
        return majority
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
//    226. 翻转二叉树
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        
        if root == nil {
            return nil
        }
        let left : TreeNode? = invertTree(root?.left)
        let right : TreeNode? = invertTree(root?.right)
        
        root?.left = right
        root?.right = left
        return root;
    }
    

// 反转链表，头插法
    func reverse(_ head: ListNode?) -> ListNode?{
        var head = head
        var newListNode:ListNode? = nil

        while head != nil {
            let tem = head?.next

            head?.next = newListNode
            newListNode = head
            head = tem
        }
        return newListNode
    }
//    19. 删除链表的倒数第N个节点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var newListNode:ListNode? = reverse(head)
        var node:ListNode? = newListNode
        for i in 1...n {
            if n == 1 {
                newListNode = newListNode?.next
                break;
            } else if i + 1 == n {
                node?.next = node?.next?.next
            }
            node = node?.next
        }
        return reverse(newListNode)
    }
    
    
//    剑指 Offer 22. 链表中倒数第k个节点
    
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
    //剑指 Offer 53 - I. 在排序数组中查找数字 I 统计一个数字在排序数组中出现的次数。
    
//    输入: nums = [5,7,7,8,8,10], target = 8
//    输出: 2
//
//    输入: nums = [5,7,7,8,8,10], target = 6
//    输出: 0
//
//    限制：
//
//    0 <= 数组长度 <= 50000
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        
        var i = 0, j = nums.count - 1, left, right: Int
        
        while i <= j {
            let mid = (i + j) >> 1
            // 中间数小于等于 目标值，则在右边的区间找。[mid+1 , j]
            if nums[mid] <= target {
                i = mid + 1
            } else {
                // 在左边区间找。[i, mid -1]
                j = mid - 1
            }
        }
        // 跳出循环，设置右边界
        right = i
        // 区间内没有目标值，退出
        if j >= 0 && nums[j] != target {
            return 0
        }
        
        // 重置 i = 0
        i = 0
        
        // 找左边界
        while i <= j {
            let mid = (i + j) >> 1
            if nums[mid] < target {
                i = mid + 1
            } else {
                // 大于等于目标值，左移右侧坐标
                j = mid - 1
            }
        }
        // 跳出循环
        left = j
        return right - left - 1
    }
    
    
//    50. Pow(x, n) 难度中等
//    实现 pow(x, n) ，即计算 x 的 n 次幂函数。
//
//    输入: 2.00000, 10
//    输出: 1024.00000
//    示例 2:
//
//    输入: 2.10000, 3
//    输出: 9.26100
//    示例 3:
//
//    输入: 2.00000, -2
//    输出: 0.25000
//    解释: 2-2 = 1/22 = 1/4 = 0.25

//    -100.0 < x < 100.0
//    n 是 32 位有符号整数，其数值范围是 [−231, 231 − 1] 。
    
    func realPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        
        if n == 1 {
            return x
        }
        
        let mid = realPow(x, n >> 1)
        
        if n&1 == 1{
            // 奇数
            return x * mid * mid
        } else {
            return mid * mid
        }
    }
    
    func myPow(_ x: Double, _ n: Int) -> Double {
        
        if csIsEqual(x,0.0) && n == 0 {
            return 0.0
        }
        
        var realN = n
        
        if realN < 0 {
            realN = -n
        }
        
        if n < 0 {
            return 1 / realPow(x, realN)
        } else {
            return realPow(x, realN)
        }
    }
    
    func csIsEqual(_ x: Double, _ y: Double) -> Bool {
        if x - y >= -0.0000001 &&
        x - y <= 0.0000001 {
            return true
        } else {
            return false
        }
    }
    
    // 精简版
    func jjmyPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        
        if n < 0 {
            return 1 / jjmyPow(x,-n)
        }
        
        let mid = jjmyPow(x, n >> 1)
        
        if n & 1 == 1 {
            // 奇数
            return x * mid * mid
        } else {
            return mid * mid
        }
    }
    
//    153. 寻找旋转排序数组中的最小值 难度 中等
//    假设按照升序排序的数组在预先未知的某个点上进行了旋转。
//    ( 例如，数组 [0,1,2,4,5,6,7] 可能变为 [4,5,6,7,0,1,2] )。
//    请找出其中最小的元素。
//    你可以假设数组中不存在重复元素。
//    输入: [3,4,5,1,2]     输入: [4,5,6,7,0,1,2]
//    输出: 1               输出: 0
    
    func findMin(_ nums: [Int]) -> Int {
        
        var i = 0, j = nums.count - 1
        var mid = i
        
        while nums[i] > nums[j] {
            
            if j - i == 1 {
                mid = j
                break
            }
            
            mid = (i + j) >> 1
            
            if nums[mid] > nums[i] {
                i = mid
            } else if nums[mid] < nums[j]{
                j = mid
            }
        }
        
        return nums[mid]
    }
    
    // 包含重复数字的情况 [2,2,2,0,1] [3,1,1] [1,1,1,0,1] [1]
    func minArray(_ nums: [Int]) -> Int {
        
        var i = 0, j = nums.count - 1
        var mid = i
        
        while nums[i] >= nums[j] {
            
            if j - i == 1 {
                mid = j
                break
            }
            
            mid = (i + j) >> 1
            
            if nums[mid] == nums[i] && nums[i] == nums[j] {
                return findCFMin(nums, i, j)
            } else if nums[mid] >= nums[i] {
                i = mid
            } else if nums[mid] <= nums[j]{
                j = mid
            }
        }
        
        return nums[mid]
    }
    
    func findCFMin(_ nums: [Int], _ index1: Int, _ index2: Int) -> Int{
        var result = nums[index1]
        
        for i in index1...index2 {
            
            if nums[i] < result {
                result = nums[i]
            }
        }
        
        return result
    }
    
    //包含重复 ，更精简的版本
//    int i = 0, j = numbers.size() - 1;
//    while (i < j) {
//        int m = (i + j) / 2;
//        if (numbers[m] > numbers[j]) i = m + 1;
//        else if (numbers[m] < numbers[j]) j = m;
//        else {
//            int x = i;
//            for(int k = i + 1; k < j; k++) {
//                if(numbers[k] < numbers[x]) x = k;
//            }
//            return numbers[x];
//        }
//    }
//    return numbers[i];
    
    func minArray2(_ nums: [Int]) -> Int {
        
        var i = 0, j = nums.count - 1
        var mid = i
        
        while i < j {
            mid = (i + j) >> 1
            if nums[mid] > nums[j] {
                i = mid + 1
            } else if nums[mid] < nums[j] {
                j = mid
            } else {
                var result = nums[i]
                for index in i...j {
                    if nums[index] < result {
                        result = nums[index]
                    }
                }
                return result
            }
        }
        return nums[i]
    }

// MARK: - 129. 求根到叶子节点数字之和
    func sumNumbers(_ root: TreeNode?) -> Int {
        
        return funSum(root, preSum: 0)
    }
    
    func funSum(_ root: TreeNode?, preSum: Int) -> Int {
        
        if root == nil {
            return 0
        }
        let sum :Int = preSum * 10 + root!.val
        // 遍历到叶子结点，左右孩子都为空，结束此次路径上的递归遍历
        if root?.left == nil && root?.right == nil {
            return sum
        }
        
        return funSum(root?.left, preSum: sum) + funSum(root?.right, preSum: sum)
        
    }
// MARK: -  剑指 Offer 55 - I. 二叉树的深度
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        let leftInt = maxDepth(root?.left)
        let rightInt = maxDepth(root?.right)
        
        if leftInt >= rightInt {
            return leftInt + 1
        } else {
            return rightInt + 1
        }
    }
// MARK: -   剑指 Offer 55 - II. 平衡二叉树
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        let leftInt = maxDepth(root?.left)
        let rightInt = maxDepth(root?.right)
        let diff = leftInt - rightInt
        
        if diff > 1 || diff < -1 {
            return false
        }
        
        return isBalanced(root?.left) && isBalanced(root?.right)
    }
// MARK: -     剑指 Offer 55 - II. 平衡二叉树 效率高的解法，不需要重复遍历
    func isBalanced2(_ root: TreeNode?) -> Bool {
//        isBalanced2(root, deepInt: 0)
        return help(root) >= 0
    }
    
    func help(_ root: TreeNode?) -> Int {
        
        if root == nil {
            return 0
        }
        
        let leftHeight = help(root?.left)
        let rightHeight = help(root?.right)
        
        if abs(leftHeight - rightHeight) > 1 || leftHeight == -1 ||
            rightHeight == -1{
            return -1
        } else {
            return max(leftHeight, rightHeight) + 1
        }
    }
    
    func isBalanced2(_ root: TreeNode?, deepInt: Int) -> Bool {
        var deepInt = deepInt
        
        if root == nil  {
            deepInt = 0
            return true
        }
        
        let leftInt: Int = 0, rightInt: Int = 0
        if isBalanced2(root?.left, deepInt: leftInt) && isBalanced2(root?.right, deepInt: rightInt) {
            let diff = leftInt - rightInt
            
            if diff >= -1 && diff <= 1 {
                deepInt = 1 + (leftInt > rightInt ? leftInt : rightInt)
                return true
            }
        }
        return false
         
    }
// MARK: -  剑指 Offer 56 - I. 数组中数字出现的次数 一个整型数组 nums 里除两个数字之外，其他数字都出现了两次。请写程序找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。
    func singleNumbers(_ nums: [Int]) -> [Int] {
        
        var res = 0
        for num in nums {
            res = res ^ num
        }
        
        let bit1Index = findeFirstBitIs1(res)
        
        var left = 0
        var right = 0
        
        // 分2个数组
        for num in nums {
            if isBit1(num, index: bit1Index) {
                left ^= num
            } else {
                right ^= num
            }
        }
        
        return [left,right]
    }
    
    //找到第一次二进制中的1
    func findeFirstBitIs1(_ num: Int) -> Int {
        var num = num
        var index = 0
        
        while (num & 1) == 0 {
            num = num >> 1
            index = index + 1
        }
        return index
    }
    // 判断右移的位数是不是1
    func isBit1(_ num: Int, index: Int) -> Bool {
        var num = num
        num = num >> index
        return (num & 1) == 1
    }
    
    
    func singleNumbers2(_ nums: [Int]) -> [Int] {
        
        var res = 0
        for num in nums {
            res ^= num
        }
        
        var mark = 1
        
        while mark & res == 0 {
            mark = mark << 1
        }
        
        var a = 0, b = 0
        for num in nums {
            if num & mark == 0 {
                 a ^= num
             } else {
                 b ^= num
             }
        }

        return [a,b]
    }
    
// MARK: -   剑指 Offer 25. 合并两个排序的链表
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        if l1 == nil {
            return l2
        }
        
        if l2 == nil {
            return l1
        }
        
        var tem: ListNode? = nil
        
        if l1!.val > l2!.val {
            tem = l2!
            tem!.next = mergeTwoLists(l1, l2?.next)
        } else {
            tem = l1!
            tem!.next = mergeTwoLists(l1?.next, l2)
        }
        return tem
    }
       /*
       2.两数相加
       给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。

       如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。

       您可以假设除了数字 0 之外，这两个数都不会以 0 开头。

    */
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil && l2 == nil {
            return nil
        } else if l1 == nil && l2 != nil {
            return l2
        } else if l2 == nil && l1 != nil {
            return l1
        }
        
        var l1 = l1, l2 = l2
        
        var res: ListNode? = nil
        var temRes: ListNode? = res
        var temNum = 0
        
        while l1 != nil && l2 != nil {
            var value = l1!.val + l2!.val + temNum
            
            if value >= 10{
                temNum = 1
                value = value % 10
            } else {
                temNum = 0
            }
            let node: ListNode = ListNode.init(value)
            
            if res == nil {
                res = node
                temRes = res
            } else {
                res?.next = node
                res = res?.next
            }
            l1 = l1?.next
            l2 = l2?.next
        }
        
        if l1 == nil && l2 != nil {
            
            while l2 != nil {
                var value = l2!.val + temNum
                 
                 if value >= 10{
                     temNum = 1
                     value = value % 10
                 } else {
                     temNum = 0
                 }
                let node: ListNode = ListNode.init(value)
                res?.next = node
                res = res?.next
                
                l2 = l2?.next
            }
        } else if (l1 != nil && l2 == nil) {
            while l1 != nil {
                var value = l1!.val + temNum
                 
                 if value >= 10{
                     temNum = 1
                     value = value % 10
                 } else {
                     temNum = 0
                 }
                let node: ListNode = ListNode.init(value)
                res?.next = node
                res = res?.next
                
                l1 = l1?.next
            }
        }
        
        if temNum == 1 {
            let node: ListNode = ListNode.init(1)
            res?.next = node
        }
        
        return temRes
    }
    
    //20. 有效的括号. 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
    /*
    func isValid(_ s: String) -> Bool {
        
        var dict :Dictionary = [Character : Int]()
        
        for char in s {
            if String(char) == "(" ||
                String(char) == "{" ||
                String(char) == "[" {
                
                if dict.keys.contains(char) {
                    let value = dict[char]! + 1
                    dict[char] = value
                } else {
                    dict[char] = 1
                }
            } else {
                var key = ""
                
                if String(char) == ")" {
                    key = "("
                } else if String(char) == "}"{
                    key = "{"
                } else if String(char) == "]"{
                    key = "["
                }
                
                if dict.keys.contains(Character(key)) {
                    let value = dict[Character(key)]! - 1
                    if value < 0 {
                        return false
                    }
                } else {
                    return false
                }
    
            }
        }
        
        return true
    }
 */
    
    func isValid(_ s: String) -> Bool {
        
        let dict2 :Dictionary = [")" : "(", "}" : "{", "]" : "["]
        
        var stack :Array = [String]()
        
        for char in s {
            if String(char) == "(" ||
                String(char) == "{" ||
                String(char) == "[" {
                
                stack.append(String(char))
            } else {
                if stack.count < 1 {
                    return false
                }
                
                let value: String = dict2[String(char)]!
                if value == stack.last {
                    stack.removeLast()
                } else {
                    return false
                }
            }
        }
        
        return stack.count == 0
    }
// MARK: -  剑指 Offer 34. 二叉树中和为某一值的路径 输入一棵二叉树和一个整数，打印出二叉树中节点值的和为输入整数的所有路径。从树的根节点开始往下一直到叶节点所经过的节点形成一条路径
    
    var resAry:[[Int]] = []
    var tmpAry: [Int] = []
    
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        pathSumHelp(root, sum)
        
        return resAry
    }
    
    func pathSumHelp(_ root: TreeNode?, _ targetNum: Int) {
        
        if root == nil {
            return
        }
        
        tmpAry.append(root!.val)
        let leftNum = targetNum - root!.val
        
        if leftNum == 0 && root?.left == nil && root?.right == nil {
            resAry.append(tmpAry)
        }
        
        pathSumHelp(root?.left, leftNum)
        pathSumHelp(root?.right, leftNum)
        
        tmpAry.removeLast()
    }
// 9,
// 输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历结果。如果是则返回 true，否则返回 false。假设输入的数组的任意两个数字都互不相同。
    //[1,2,5,10,6,9,4,3]
    func verifyPostorder(_ postorder: [Int]) -> Bool {
                
        if postorder.count <= 1 {
            return true
        }
        
        var left: Int = -1
        for num in postorder {
            left += 1
            if num > postorder.last! {
                break
            }
        }
        
        for right in left..<postorder.count {
            if postorder[right] < postorder.last!{
                return false
            }
        }
        
        var leftAvailable: Bool = true
        
        if left - 1 >= 0 {
            leftAvailable = verifyPostorder(Array(postorder[...(left - 1)]))
        }

        var rightAvailable: Bool = true
        
        if left == 0 {
            if postorder.count - 1 > 0 {
               rightAvailable = verifyPostorder(Array(postorder[left..<postorder.count-1]))
            }
        } else {
            rightAvailable = verifyPostorder(Array(postorder[left...]))
        }
            
        return leftAvailable && rightAvailable
    }
    
// MARK: -  剑指 Offer 15. 二进制中1的个数
    func hammingWeight(_ n: Int) -> Int {
        var n = n
        var count = 0
        while n != 0 {
            count = count + 1
            n = (n - 1)&n
        }
        return count
    }
// MARK: - 349. 两个数组的交集 给定两个数组，编写一个函数来计算它们的交集
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var res: Array = [Int]()
        
        for num in nums2 {
            if nums1.contains(num) && !res.contains(num) {
                res.append(num)
            }
        }
        return res
    }
    
    func intersection2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        return Array(Set(nums1).intersection(Set(nums2)))
    }
    
    var resMaxPArr: Array = [Int]()
    
    func maxProduct(_ root: TreeNode?) -> Int {
        let sum = maxProductHelp(root)
        
        var maxNum: Int = 0
        for num in resMaxPArr {
            maxNum = max(maxNum, num * (sum - num))
        }
        return maxNum % 1000000007
    }
    
    func maxProductHelp(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        let left: Int = maxProductHelp(root?.left)
        let right: Int = maxProductHelp(root?.right)
        
        let sum = left + right + root!.val
        resMaxPArr.append(sum)
        return sum
     }
    
// MARK: - 剑指 Offer 57. 和为s的两个数字 输入一个递增排序的数组和一个数字s，在数组中查找两个数，使得它们的和正好是s。如果有多对数字的和等于s，则输出任意一对即可。
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        
        var start = 0
        var end = nums.count - 1
        var resArray = [Int]()
        
        while end > start {
            let sum = nums[start] + nums[end]
            
            if sum > target {
                end = end - 1
            } else if sum < target {
                start += 1
            } else {
                resArray.append(nums[start])
                resArray.append(nums[end])
                break;
            }
        }
    
        return resArray
    }
// MARK: - 23. 合并K个升序链表
// 给你一个链表数组，每个链表都已经按升序排列。请你将所有链表合并到一个升序链表中，返回合并后的链表。
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        return mergeKListsHelp(lists, start: 0, end: lists.count - 1)
    }
    
    func mergeKListsHelp(_ lists: [ListNode?], start: Int, end: Int) -> ListNode? {
        if lists.count == 0 {
            return nil
        }
        if start == end {
            return lists[start]
        }
        
        let mid = start + (end - start) / 2
        
        let left: ListNode? = mergeKListsHelp(lists, start: start, end: mid)
        
        let right: ListNode? = mergeKListsHelp(lists, start: mid + 1, end: end)
        
        return mergeTwoList(left, right);
    }
    
    func mergeTwoList(_ list1: ListNode?,_ list2: ListNode?) -> ListNode? {
        
        if list1 == nil {
            return list2
        }
        
        if list2 == nil {
            return list1
        }
        
        var head: ListNode? = nil
        if list1!.val < list2!.val {
            head = list1
            head?.next = mergeTwoList(list1?.next, list2)
        } else {
            head = list2
            head?.next = mergeTwoList(list1, list2?.next)
        }
        return head
    }
    
// MARK: - 剑指 Offer 10- I. 斐波那契数列
//    写一个函数，输入 n ，求斐波那契（Fibonacci）数列的第 n 项。斐波那契数列的定义如下：
//    F(0) = 0,   F(1) = 1
//F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
//    func fib(_ n: Int) -> Int {
//        return fibHelp(n)
//    }
//
//    func fibHelp(_ n: Int) -> Int {
//        if n == 0 {
//            return 0
//        }
//        if n == 1 {
//            return 1
//        }
//        return fib(n - 1) % 1000000007 + fib(n - 2) % 1000000007
//    }
        func fib(_ n: Int) -> Int {
            var n = n
            if n == 0 {
                return 0
            }
            if n == 1 {
                return 1
            }
            var a = 0, b = 1,sum = 0
            //首次循环 既是 F(2) = F(1) + f(0)
            //第二次循环 既是 f(3) = f(2) + f(1)
            while n >= 2 {
                sum = (a + b) % 1000000007 //题目要求取模
                a = b // a进位 ，F(0) ->f(1)
                b = sum // b进位 ，F(1) ->f(2)
                n -= 1
            }
            return sum
        }
    
    func fib2(_ n: Int) -> Int {
        // 动态规划
        if n <= 0 {
            return 0
        }
        var sum: Array = Array(repeating: 0, count: max(2, n+1))
        sum[0] = 0
        sum[1] = 1
        
        if n >= 2 {
            for i in 2...n {
                sum[i] = (sum[i-1] + sum[i-2]) % 1000000007
            }
        }

        return sum[n]
    }
// MARK: -   剑指 Offer 10- II. 青蛙跳台阶问题
    //一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。

//    答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

    func numWays(_ n: Int) -> Int {
        if n == 0 {
            return 1
        }
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }
        
        var a = 1,b = 2,sum = 0
        var n = n
        
        while n >= 3 {
            sum = (a + b) % 1000000007
            a = b
            b = sum
            n -= 1
        }
        return sum
    }
// MARK: -  3. 无重复字符的最长子串 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
    func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.count <= 1 {
            return s.count
        }
        var tem :Array = [Character]()
        var maxcount = 0
        var hasRepeat: Bool = false
        
        for char in s {
            if tem.contains(char) {
                maxcount = max(maxcount, tem.count)
                let temp = tem.split(separator: char, maxSplits: 1, omittingEmptySubsequences: false)
            
                tem = Array(temp[1].count > 0 ? temp[1] : [])
                tem.append(char)
                hasRepeat = true
            } else {
                tem.append(char)
            }
        }
        maxcount = max(maxcount, tem.count)
        return hasRepeat ? maxcount : tem.count
    }
// MARK: -   剑指 Offer 27. 二叉树的镜像 请完成一个函数，输入一个二叉树，该函数输出它的镜像。
    func mirrorTree(_ root: TreeNode?) -> TreeNode? {
        
        if root == nil {
            return nil
        }
        
        let left = mirrorTree(root?.left)
        let right = mirrorTree(root?.right)
        
        root?.right = left
        root?.left = right
        
        return root
    }
// MARK: -  剑指 Offer 03. 数组中重复的数字
    func findRepeatNumber(_ nums: [Int]) -> Int {
        var dict = [Int : Int]()
        
        for num in nums {
            if dict[num] != nil {
                dict[num]! += 1
            } else {
                dict[num] = 1
            }
        }
        
        for (key, value) in dict {
            if value > 1 {
                return key
            }
        }
        return 0
    }
    
    func findRepeatNumber2(_ nums: [Int]) -> Int {
        var nums = nums
        
        for i in 0..<nums.count {
            if nums[i] == i {
                continue
            }
            if nums[nums[i]] == nums[i] {
                return nums[i]
            }
            nums.swapAt(i, nums[i])
        }
        
        return -1
    }
    
    func bookMethod(_ nums: [Int]) -> Int {
        var nums = nums
        for i in 0..<nums.count {
            while i != nums[i] {
                if nums[i] == nums[nums[i]] {
                    return nums[i]
                }
                nums.swapAt(i, nums[i])
            }
            
        }
        return -1
    }
    
// MARK: - 102. 二叉树的层序遍历 给你一个二叉树，请你返回其按 层序遍历 得到的节点值。 （即逐层地，从左到右访问所有节点）
    // 队列解法 层次遍历
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var res: Array = [[Int]]()
        // 队列
        var nodesQueue: [TreeNode?] = [TreeNode?]()
        nodesQueue.append(root)
        
        while nodesQueue.count > 0 {
            let n = nodesQueue.count //记录本层 节点数量
            var numArr: Array = [Int]()
            
            for _ in 0..<n { //遍历这层数量的次数，就知道一层结束了
                let node: TreeNode? = nodesQueue[0]
                nodesQueue.removeFirst() //不断的pop 队首
                
                numArr.append(node!.val)
                if node?.left != nil {
                    nodesQueue.append(node?.left)
                }
                if node?.right != nil {
                    nodesQueue.append(node?.right)
                }
            }
            res.append(numArr)
        }
        return res
    }
    
    //递归
    var levels = [Array<Int>]()

    func levelOrder2(_ root: TreeNode?) -> [[Int]] {
        
        if root == nil {
            return levels
        }
       helper(root!, 0)
        return levels
    }
    
    func helper(_ node: TreeNode, _ level: Int)  {
        if levels.count == level{ //一层满了，开辟下一层空间
            levels.append([Int]())
        }

        levels[level].append(node.val) // 前序遍历 append到对应的层数的数组

        if node.left != nil {
            helper(node.left!, level + 1)
        }
        if node.right != nil {
            helper(node.right!, level + 1)
        }
        
    }
    
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        var res :Array = [[Int]]()
        var leaveQueue :Array = [TreeNode?]()
        leaveQueue.append(root)
        
        while leaveQueue.count > 0 {
            let n = leaveQueue.count
            var temArr: Array = [Int]()
            
            if res.count & 1 == 0 {
                // 偶数 正读正写
                for _ in 0..<n {
                    let node: TreeNode = leaveQueue[0]!
                    leaveQueue.removeFirst()

                    temArr.append(node.val)
                    if node.left != nil {
                        leaveQueue.append(node.left)
                    }
                    
                    if node.right != nil {
                        leaveQueue.append(node.right)
                    }
                }
            } else {
                // 奇数，反读反写，（插入）
                for _ in 0..<n {
                    if let last = leaveQueue.last {
                        let node: TreeNode = last!
                        leaveQueue.removeLast()
                        
                        temArr.append(node.val)
                        if node.right != nil {
                            leaveQueue.insert(node.right, at: 0)
                        }
                        if node.left != nil {
                            leaveQueue.insert(node.left, at: 0)
                        }
                    }
                }
            }
            res.append(temArr)
        }
        
        return res
    }
    
// MARK: -  101. 对称二叉树 给定一个二叉树，检查它是否是镜像对称的。
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil || (root?.left == nil && root?.right == nil) {
            return true
        }
        var queue = [TreeNode?]()
        queue.append(root?.left)
        queue.append(root?.right)
        
        while queue.count > 0 {
            let node1 = queue.removeFirst()
            let node2 = queue.removeFirst()
            
            if node1 == nil && node2 == nil {
                continue
            }
            
            if node1 == nil || node2 == nil {
                return false
            }
            // 都存在
            if node1!.val != node2!.val {
                return false
            }
            
            // 把node1 的左孩子，node2 的右孩子加入队列
            queue.append(node1?.left)
            queue.append(node2?.right)
            
            queue.append(node1?.right)
            queue.append(node2?.left)
        }
        // 都没有return false 的情况
        return true
    }
// MARK: -   位运算 136. 只出现一次的数字 给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
    func singleNumber(_ nums: [Int]) -> Int {
        var res: Int = 0
        for num in nums {
            res ^= num  // 相同元素异或自己为0，最终剩下的就是唯一不重复元素
        }
        
        for i in 0..<nums.count {
            res = res ^ nums[i]
        }
        return res;
    }
    
// MARK: - 位运算 461. 汉明距离 两个整数之间的汉明距离指的是这两个数字对应二进制位不同的位置的数目。

//    给出两个整数 x 和 y，计算它们之间的汉明距离。
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        // 异或完，转换为求 二进制1的个数
        var m = x ^ y
        // 题干都是正数
        var res = 0
        
        while m > 0 {
            m = m & (m - 1)
            res += 1
        }
        return res
    }
    // MARK: - 剑指 Offer 04. 二维数组中的查找 2维数组查找
    func findNumberIn2DArray(_ matrix: [[Int]], _ target: Int) -> Bool {
        // 有几行
        let rows = matrix.count
        if rows == 0 {
            return false
        }
        // 一行有几个，就是有几列
        let columns = matrix.first!.count
        
        // 从右上角开始比对
        var row = 0
        var column = columns - 1
        
        while row <= rows - 1 && column >= 0 {
            let value = matrix[row][column]
            
            if value == target {
                return true
            } else if value < target {
                row += 1
            } else {
                column -= 1
            }
        }
        
        return false
     }
    // 字符串替换
//    func replaceSpace(_ s: String) -> String {
//        if s.count == 0 {
//            return ""
//        }
//        var blankCount = 0
//
//        for char in s {
//            if String(char) == " " {
//                blankCount += 1
//            }
//        }
//    }
    
    var nodesArr: Array = [Int]()
    
    func reversePrint(_ head: ListNode?) -> [Int] {
        
//        reversePrintHelper(head) 递归
        // 循环
        var head = head
        var temArr: Array = [Int]()
        while head != nil {
            temArr.append(head!.val)
            head = head?.next
        }
        
        for (_,value) in temArr.enumerated().reversed() {
            nodesArr.append(value)
        }
        //
        return nodesArr
    }
    
    func reversePrintHelper(_ head: ListNode?) {
        if head == nil {
            return
        }
        reversePrintHelper(head?.next)
        nodesArr.append(head!.val)
    }
    
// MARK: - 剑指 Offer 07. 重建二叉树
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        
        return buildTreeHelper(preorder, preStart: 0, preEnd: preorder.count - 1, inorder, inStart: 0, inEnd: inorder.count - 1)
    }
    
    func buildTreeHelper(_ preorder: [Int], preStart: Int, preEnd: Int,_ inorder: [Int], inStart: Int, inEnd: Int) -> TreeNode? {
        
        if preStart > preEnd || inStart > inEnd {
            return nil
        }
        
        // 前序遍历的第一个节点 是根节点
        let root: TreeNode = TreeNode.init(preorder[preStart])
        
        var index: Int = 0
        
        for i in inStart..<inEnd {
            if inorder[i] == preorder[preStart]{
                index = i
                break
            }
        }
        
        root.left = buildTreeHelper(preorder, preStart: preStart + 1, preEnd:preStart + index - inStart ,
                                    inorder, inStart: inStart, inEnd: index - 1)
        root.right = buildTreeHelper(preorder, preStart: index - inStart + preStart + 1, preEnd: preEnd,
                                     inorder, inStart: index + 1, inEnd: inEnd)
        
        return root

//        if preStart > preEnd || inStart > inEnd {
//            return nil
//        }
//        let root: TreeNode = TreeNode.init(preorder[preStart])
//
//        var index = 0
//        for i in inStart...inEnd {
//            if inorder[i] == preorder[preStart] {
//                index = i
//                break
//            }
//        }
//
//        root.left = buildTreeHelper(preorder, preStart: preStart + 1, preEnd: index - inStart + preStart,
//                                    inorder, inStart: inStart, inEnd: index - 1)
//        root.right = buildTreeHelper(preorder, preStart:index - inStart + preStart + 1, preEnd: preEnd,
//                                     inorder, inStart: index + 1, inEnd: inEnd)
        
//        return root
    }
    
    
    //用两个栈实现一个队列。队列的声明如下，请实现它的两个函数 appendTail 和 deleteHead ，分别完成在队列尾部插入整数和在队列头部删除整数的功能。(若队列中没有元素，deleteHead 操作返回 -1 )示例 1：输入：["CQueue","appendTail","deleteHead","deleteHead"][[],[3],[],[]]输出：[null,null,3,-1]示例 2：输入：["CQueue","deleteHead","appendTail","appendTail","deleteHead","deleteHead"]
            //  [[],[],[5],[2],[],[]]    输出：[null,-1,null,null,5,2]

    class CQueue {
        var stack1: Array = [Int]()
        var stack2: Array = [Int]()
        init() {

        }
        
        func appendTail(_ value: Int) {
            stack1.append(value)
        }
        
        func deleteHead() -> Int {
            if stack2.isEmpty {
                while !stack1.isEmpty {
                    stack2.append(stack1.popLast()!)
                }
            }
            return stack2.popLast() ?? -1
        }
    }
    
// MARK: -  剑指 Offer 26. 树的子结构
    func isSubStructure(_ A: TreeNode?, _ B: TreeNode?) -> Bool {
        var result: Bool = false
        
        if A != nil && B != nil {
            if A!.val == B!.val {
                // 有相同的根节点
                result = doesTress1HasTree2(a: A, b: B)
            }
            if !result {
                result = isSubStructure(A!.left, B)
            }
            if !result {
                result = isSubStructure(A!.right, B)
            }
        }
        
        return result
    }
    
    func doesTress1HasTree2(a: TreeNode?, b: TreeNode?) -> Bool {
        if b == nil {
            return true
        }
        if a == nil {
            return false
        }
        
        if a!.val != b!.val {
            return false
        }
        
        return doesTress1HasTree2(a: a!.left, b: b!.left) && doesTress1HasTree2(a: a!.right, b: b!.right)
    }
    
    
// MARK: -  剑指 Offer 32 - I. 从上到下打印二叉树
    func levelOrder3(_ root: TreeNode?) -> [Int] {
        if root == nil {
            return []
        }
        var resArr: Array = [Int]()
        
        var queue: Array = [TreeNode?]()
        queue.append(root)
        
        while queue.count > 0 {
            let pNode: TreeNode! = queue.removeFirst()
            resArr.append(pNode!.val)
            
            if pNode.left != nil {
                queue.append(pNode.left)
            }
            if pNode.right != nil {
                queue.append(pNode.right)
            }
        }
        return resArr
    }
    
// MARK: -  剑指 Offer 32 - II. 从上到下打印二叉树 II
    var lorderResArr: Array = [[Int]]()
    
    func levelOrder32(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        
        var queue: Array = [TreeNode?]()
        queue.append(root)
        
        while queue.count > 0 {
            var nums: Array = [Int]()
            let count = queue.count
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
            lorderResArr.append(nums)
        }
        
        return lorderResArr
    }
    
// MARK: -   剑指 Offer 21. 调整数组顺序使奇数位于偶数前面
    func exchange(_ nums: [Int]) -> [Int] {
        var left = 0, right = nums.count - 1, nums = nums
        
        while left < right {
            if left < right && nums[left] & 1 == 1{
                left += 1
            }
            if left < right && nums[right] & 1 == 0 {
                right -= 1
            }
            // left 指向偶数 right 指向奇数 交换位置
            
            if left < right {
                nums.swapAt(left, right)
            }
        }
        
        return nums
    }
    
// MARK: -  剑指 Offer 32 - III. 从上到下打印二叉树 III 请实现一个函数按照之字形顺序打印二叉树，即第一行按照从左到右的顺序打印，第二层按照从右到左的顺序打印，第三行再按照从左到右的顺序打印，其他行以此类推。
    func levelOrder6(_ root: TreeNode?) -> [[Int]] {
        if root == nil {
            return []
        }
        
        var res: Array = [[Int]]()
        var queue: Array = [TreeNode?]()
        queue.append(root)
        
        while queue.count > 0 {
            let count = queue.count
            var nums: Array = [Int]()
            
            if res.count & 1 == 0 {
                
                for _ in 0..<count {
                    // 偶数正读正写
                    let node: TreeNode = queue.removeFirst()!
                    nums.append(node.val)
                    
                    if node.left != nil {
                        queue.append(node.left)
                    }
                    
                    if node.right != nil{
                        queue.append(node.right)
                    }
                }

            } else {
                for _ in 0..<count {
                    // 奇数 反读反写
                    let node: TreeNode = queue.removeLast()!
                    nums.append(node.val)
                    
                    if node.right != nil {
                        queue.insert(node.right, at: 0)
                    }
                    if node.left != nil {
                        queue.insert(node.left, at: 0)
                    }
                }
            }
            res.append(nums)
        }
        
        return res
    }
    
// MARK: -  剑指 Offer 29. 顺时针打印矩阵
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.count == 0 {
            return []
        }
        var res: Array = [Int]()
        let rows = matrix.count, ques = matrix.first!.count
        var count = 0// 第几圈
        
        while rows > 2*count && ques > 2*count {
            let maxY = ques - count - 1
            let maxX = rows - count - 1
            
            for y in count...maxY {
                res.append(matrix[count][y])
            }
            
            if count < maxX {
                for x in (count + 1)...maxX {
                    res.append(matrix[x][maxY])
                }
            }
            
            if count < maxY && count < maxX {
                var temY = maxY - 1
                while temY >= count {
                    res.append(matrix[maxX][temY])
                    temY -= 1
                }
            }
            
            if count < maxX - 1 && count < maxY {
                var temX = maxX - 1
                while temX >= count + 1 {
                    res.append(matrix[temX][count])
                    temX -= 1
                }
                
            }
            
            count += 1
        }
        return res
    }
    
    func climbStairs(_ n: Int) -> Int {
        
        var a: Array = Array.init(repeating: -1, count: max(2, n+1))
        a[0] = 1
        a[1] = 1
        
        if n >= 2 {
            for i in 2...n {
                a[i] = a[i-1] + a[i-2]
            }
        }
        return a[n]
    }
    
// MARK: -  动态规划
    //120. 三角形最小路径和
    var memo: Array = [[Int]]()
    
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        let count = triangle.count
        memo = [[Int]](repeating: [Int](repeating: -1, count: count), count: count)
        
        return dfsminimumTotal(triangle, 0, 0)
    }
    
    func dfsminimumTotal(_ triangle: [[Int]], _ i: Int, _ j: Int) -> Int {
        if i == triangle.count {
            return 0
        }
        
        if memo[i][j] == -1{
            memo[i][j] = min(dfsminimumTotal(triangle, i+1, j), dfsminimumTotal(triangle, i + 1, j + 1)) + triangle[i][j]
        }
        
        return memo[i][j]
    }
    

    class Solution {
      func minimumTotal(_ triangle: [[Int]]) -> Int {
        var mem: [Int] = Array(repeating: 0, count: triangle.last!.count)
        for x in (0..<triangle.count).reversed() {
          for y in 0..<triangle[x].count {
            if x == triangle.count - 1 {
              mem[y] = triangle[x][y]
            } else {
              mem[y] = min(mem[y], mem[y + 1]) + triangle[x][y]
            }
          }
        }
        return mem[0]
      }
    }
    
    //343. 整数拆分
//    给定一个正整数 n，将其拆分为至少两个正整数的和，并使这些整数的乘积最大化。 返回你可以获得的最大乘积。
    var memoA: Array = [Int]()
    func integerBreak(_ n: Int) -> Int {
        memoA = Array(repeating: -1, count: n + 1)
        return dfsIntegerBreak(n)
    }
    
    func dfsIntegerBreak(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        //记忆化搜索
        if memoA[n] == -1 {
            var res = 0
            // 重叠子问题， 最优子结构。 求得 最优（n- 1，n-2,....1）最优解，就能获得分割n的最优解
            for i in 1...n-1 {
                res = max(res, i * dfsIntegerBreak(n - i), i * (n-i))
            }
            memoA[n] = res
        }
        return memoA[n]
    }
    
    // 自底向上，动态规划
    var memoB: Array = [Int]()
    func integerBreak2(_ n: Int) -> Int {
        //题干n>=2
        memoB = Array(repeating: -1, count: n + 1)
        memoB[1] = 1;
        // 遍历求出 memoB[i] 的分割最大值，便可以求出memoB[n]的最大值
        for i in 2...n {
            // 把 i 进行分割 1...(i-1)
            for j in 1...(i-1) {
                memoB[i] = max(memoB[i], j * (i-j), j * memoB[i-j])
            }
        }
        return memoB[n]
    }
//    198. 打家劫舍
    var memoc = [Int]()
    
    func rob(_ nums: [Int]) -> Int {
        //记忆化搜索
        memoc = Array(repeating: -1, count: nums.count)
        return tryRob(nums, 0)
    }
    //考虑偷取 [index....n-1]号房子
    func tryRob(_ nums: [Int], _ index: Int) -> Int {
        //记忆化搜索
        let n = nums.count
        if index >= n {
            return 0
        }

        if memoc[index] != -1 {
            return memoc[index]
        }
        var res = -1

        for i in index...(n-1) {
            res = max(res, nums[i] + tryRob(nums, i + 2))
        }
        memoc[index] = res;

        return res
    }
    
    
    func rob2(_ nums: [Int]) -> Int {
        
        // 动态规划
        let n = nums.count
        if n == 0 {
            return 0
        }
        if n == 1 {
            return nums[0]
        }
        var memod = Array(repeating: 0, count: nums.count)
        memod[n-1] = nums[n-1]

        for i in (0...(n-2)).reversed() {
            for j in i...n-1 {
                memod[i] = max(memod[i], nums[j] + (j+2 < n ? memod[j+2] : 0))
            }
        }

        return memod[0]
    }
    
//    213. 打家劫舍 II
    func rob3(_ nums: [Int]) -> Int {
        // 不取第一间房子的 和取第一间房子的值比较
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        memoc = Array(repeating: -1, count: nums.count-1)
        let res = tryRob(Array(nums[1...]), 0)
        memoc = Array(repeating: -1, count: nums.count-1)
        return max(res, tryRob(Array(nums[...(nums.count-2)]), 0))
    }
    
    
    //0-1 背包问题
    // 重量、 价值、 容量，求在容量内，放入背包物品的最大值
    var memoP = [[Int]]()
    
    func package(_ w:[Int], _ v:[Int], _ c:Int) -> Int {
        let n = w.count
        
        memoP = Array(repeating: Array(repeating: -1, count: c+1), count: n)
        
        return packageHelper(w, v, n - 1, c)
    }
    // 考虑将 n 个物品放入 容量为c 的背包，返回最大值
    func packageHelper(_ w:[Int], _ v:[Int], _ index:Int ,_ c:Int) -> Int {
        if c <= 0 || index < 0 {
            return 0
        }
        
        if memoP[index][c] != -1 {
            return memoP[index][c]
        }
        var res = packageHelper(w, v, index - 1, c)
        if w[index] <= c {
            res = max(res, packageHelper(w, v, index - 1, c -  w[index]))
        }
        
        memoP[index][c] = res
        return res
    }
    

// 198 213 337
// 最长上升子序列 300
// 120 64  343 455 435 39 40 216 78 90 401 200 130 417
}

