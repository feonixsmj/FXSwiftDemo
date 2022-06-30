
//
//  FourViewController.swift
//  FXSwiftDemo
//
//  Created by smj on 2021/9/23.
//  Copyright © 2021 FX. All rights reserved.
//

import UIKit

class FourViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    // MARK: 146. LRU 缓存机制
    class LRUCache {
        var dict:[Int:Int] = [:]
        var queue = [[Int:Int]]()
        var count = 0
        init(_ capacity: Int) {
            self.count = capacity
        }
        
        func get(_ key: Int) -> Int {
            var i = 0
            for dict in self.queue {
                if let val = dict[key]{
                    self.queue.remove(at: i)
                    self.queue.append(dict)
                    return val
                }
                i += 1
            }
            return -1
        }
        
        func put(_ key: Int, _ value: Int) {
            var i = 0
            // 更新旧值
            for dict in self.queue {
                if dict[key] != nil {
                    self.queue.remove(at: i)
                    break
                }
                i += 1
            }
            if self.queue.count >= self.count {
                self.queue.removeFirst()
            }
            self.queue.append([key:value])
        }
    }
    
    // MARK: 146. LRU 缓存机制
    class LRUCache2 {
        var dict = [Int:MyNode]()
        var head: MyNode!
        var tail: MyNode!
        var count = 0
        
        init(_ capacity: Int) {
            self.count = capacity
            self.head = MyNode.init()
            self.tail = MyNode.init()
            self.head.next = self.tail
            self.tail.pre = self.head
        }
        
        func get(_ key: Int) -> Int {
            guard let node = dict[key] else {
                return -1
            }
            removeNode(node)
            addToLast(node)
            return node.value
        }
        
        func put(_ key: Int, _ value: Int) {
            let node = dict[key]
            if node == nil {
                if dict.count == self.count {
                    // 删除一个
                    let node = dict.removeValue(forKey: head.next!.key)
                    removeNode(node!)
                }
                let newNode = MyNode.init(key, value)
                dict[key] = newNode
                addToLast(newNode)
            } else {
                // 更新
                removeNode(node!)
                node!.value = value
                addToLast(node!)
            }
        }
        
        func removeNode(_ node: MyNode){
            node.pre?.next = node.next
            node.next?.pre = node.pre
        }
        
        func addToLast(_ node: MyNode)  {
            node.next = self.tail
            node.pre = self.tail.pre
            self.tail.pre?.next = node
            self.tail.pre = node
        }
    }
    class MyNode {
        //双向链表
        var pre: MyNode?
        var next: MyNode?
        var key: Int = 0
        var value: Int = 0
        
        init() {
            
        }
        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    // MARK: 338. 比特位计数
    func countBits(_ n: Int) -> [Int] {
        var arr = [Int]()
        for i in 0...n {
            arr.append(countBitsHelp(i))
        }
        return arr
    }
    
    func countBitsHelp(_ num:Int) -> Int {
        var count  = 0
        var num = num
        
        while num != 0 {
            num = (num - 1) & num
            count += 1
        }
        return count
    }
    
    //MARK: 1047. 删除字符串中的所有相邻重复项
    func removeDuplicates(_ s: String) -> String {
        var stack = [Character]()
        for char in s{
            if stack.isEmpty{
                stack.append(char)
            } else {
                if char != stack.last!{
                    stack.append(char)
                } else{
                    stack.removeLast()
                }
            }
        }
        return String(stack)
    }
    
    //MARK: 150. 逆波兰表达式求值
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        for str in tokens {
            if str == "+" || str == "-" || str == "*" || str == "/"{
                let num1 = stack.popLast() ?? 0
                let num2 = stack.popLast() ?? 0
                
                switch str {
                case "+": stack.append(num2 + num1)
                case "-": stack.append(num2 - num1)
                case "*": stack.append(num2 * num1)
                case "/": stack.append(num2 / num1)
                default: break
                }
            } else {
                stack.append(Int(str)!)
            }
        }
        return stack.popLast() ?? 0
    }
    
    // MARK: 242. 有效的字母异位词
    //    func isAnagram(_ s: String, _ t: String) -> Bool {
    //        if s.count != t.count {
    //            return false
    //        }
    //        var result: UInt8 = 0
    //
    //        for i in 0..<s.count {
    //            let a: UInt8 = isAnagramHelp(String(s[s.index(s.startIndex, offsetBy: i)]))
    //            let b: UInt8 = isAnagramHelp(String(t[t.index(t.startIndex, offsetBy: i)]))
    //
    //            result ^= a^b
    //        }
    //        return result == 0
    //    }
    //
    //    func isAnagramHelp(_ str: String) -> UInt8 {
    //        var uCode: UInt8 = 0
    //        for code in str.utf8{
    //            uCode = code
    //        }
    //        return uCode
    //    }
    
    
    // MARK: 数组------------------------------
    
    // MARK: 27. 移除元素
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var slowIndex = 0
        for fast in 0..<nums.count {
            if nums[fast] != val {
                nums[slowIndex] = nums[fast]
                slowIndex += 1
            }
        }
        
        return slowIndex
    }
    
    // MARK: 704. 二分查找
    func search(_ nums: [Int], _ target: Int) -> Int {
        var right = nums.count - 1
        var left = 0
        while right >= left {
            let mid = left + (right - left) / 2
            if nums[mid] < target {
                left = mid + 1
            } else if nums[mid] > target {
                right = mid - 1
            } else {
                return mid
            }
        }
        
        return -1
    }
    
    // MARK: 977. 有序数组的平方
    func sortedSquares(_ nums: [Int]) -> [Int] {
        var result = [Int](repeatElement(0, count: nums.count))
        var k = nums.count - 1, left = 0, right = nums.count - 1
        
        while right >= left {
            let rightValue = nums[right] * nums[right]
            let leftValue = nums[left] * nums[left]
            if  rightValue >= leftValue {
                result[k] = rightValue
                right -= 1
            } else {
                result[k] = leftValue
                left += 1
            }
            k -= 1
        }
        
        return result
    }
    
    // MARK: 209.长度最小的子数组
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var i = 0, sum = 0, length = 0, result = Int.max
        for j in 0..<nums.count {
            sum += nums[j]
            while sum >= target {
                length = j - i + 1
                sum -= nums[i]
                i += 1
                result = min(result, length)
            }
        }
        if result == Int.max {
            return 0
        }
        return result
    }
    
    // MARK: 203. 移除链表元素 easy
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let dummyNode: ListNode? = ListNode.init(0, head)
        var cur = dummyNode
        while cur?.next != nil {
            if cur?.next?.val == val {
                cur?.next = cur?.next?.next
            } else {
                cur = cur?.next
            }
        }
        return dummyNode?.next
    }
    
    // MARK: 206. 反转链表
    func reverseList(_ head: ListNode?) -> ListNode? {
        var head = head
        var newList: ListNode? = ListNode.init()
        
        while head != nil {
            let temp = head?.next
            head?.next = newList
            newList = head
            head = temp
        }
        return newList
    }
    
    // MARK: 24. 两两交换链表中的节点
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummyHead = ListNode.init(-1, head)
        var cur = dummyHead
        
        while cur.next != nil && cur.next?.next != nil {
            let node1 = cur.next
            let node2 = cur.next?.next
            
            cur.next = node2
            node1?.next = node2?.next
            node2?.next = node1
            
            cur = node1!
        }
        return dummyHead.next
        
    }
    
    // MARK: 19. 删除链表的倒数第 N 个结点
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummyNode: ListNode? = ListNode.init(-1, head)
        var slow: ListNode? = dummyNode
        
        var fast: ListNode? = head
        
        for _ in 0...n-1 {
            fast = fast?.next
            if fast == nil {
                return nil
            }
        }
        
        while fast?.next != nil {
            fast = fast?.next
            slow = slow?.next
        }
        
        slow?.next = slow?.next?.next
        
        return dummyNode?.next
    }
    
    
    
    // MARK: 哈希表----------------------------
    // MARK: 454. 四数相加 II med
    func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        
        var dict = [Int:Int]()
        var sum = 0
        for i in 0..<nums1.count {
            for j in 0..<nums2.count {
                sum = nums1[i] + nums2[j]
                dict[sum] = (dict[sum] ?? 0) + 1
            }
        }
        
        var res = 0
        for i in 0..<nums3.count {
            for j in 0..<nums4.count {
                sum = nums3[i] + nums4[j]
                let other = 0 - sum
                if dict.keys.contains(other){
                    res += dict[other]!
                }
            }
        }
        
        return res
    }
    
    // MARK: 15. 三数之和 med
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var arr = nums.sorted()
        
        for i in 0..<arr.count{
            if arr[i] > 0{
                continue
            }
            if i > 0 && arr[i] == arr[i-1]{
                continue
            }
            var left = i + 1
            var right = arr.count - 1
            
            while right > left{
                let sum = arr[i] + arr[left] + arr[right]
                if sum > 0{
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    // 找到了
                    result.append([arr[i],arr[left],arr[right]])
                    while (right > left) && arr[right] == arr[right-1]{
                        right -= 1
                    }
                    while (right > left) && arr[left] == arr[left+1]{
                        left += 1
                    }
                    right -= 1
                    left += 1
                }
            }
            
        }
        return result
    }
    // MARK: 字符串-------------------------------------
    // MARK: 541. 反转字符串 II easy
    func reverseStr(_ s: String, _ k: Int) -> String {
        var ch = Array(s)
        
        for i in stride(from: 0, to: ch.count, by: 2*k){
            var left = i
            var right = min(s.count-1, i+k-1)
            while right > left {
                (ch[left],ch[right]) = (ch[right],ch[left])
                right -= 1
                left += 1
            }
        }
        return String(ch)
    }
    
    
    // MARK: 回溯----------------------------------
    // MARK: 131. 分割回文串
    var result4 = [[String]]()
    var path4 = [String]()
    func partition(_ s: String) -> [[String]] {
        partitionHelp(s, s.startIndex)
        return result4
    }
    
    func partitionHelp(_ s: String, _ startIndex: String.Index)  {
        if startIndex >= s.endIndex {
            result4.append(path4)
            return
        }
        
        var i = startIndex
        while i < s.endIndex {
            if isPartition(s, startIndex, i){
                let str = String(s[startIndex...i])
                path4.append(str)
                partitionHelp(s, s.index(after: i))
                path4.removeLast()
            }
            i = s.index(after: i)
        }
    }
    
    func isPartition(_ s: String, _ start: String.Index, _ end: String.Index) -> Bool {
        var start = start
        var end = end
        while end > start {
            if s[end] != s[start]{
                return false
            }
            start = s.index(after: start)
            end = s.index(before: end)
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
    
    func restoreIpAddressesHelp(_ s: String, _ startIndex: String.Index){
        if path5.count == 4 {
            result5.append(path5.joined(separator: "."))
            return
        }
        
        var i = startIndex
        while i < s.endIndex {
            if path5.count == 3 {
                let str = String(s[startIndex..<s.endIndex])
                if isIPValid(str){
                    path5.append(str)
                    result5.append(path5.joined(separator: "."))
                    path5.removeLast()
                }
                return
            }
            
            let str = String(s[startIndex...i])
            if isIPValid(str){
                path5.append(str)
                restoreIpAddressesHelp(s, s.index(after: i))
                path5.removeLast()
            }
            i = s.index(after: i)
        }
        
    }
    
    func isIPValid(_ ip: String) -> Bool {
        if ip.count == 0 || ip.count > 3 {
            return false
        }
        if ip.count > 1 && String(ip[ip.startIndex]) == "0"{
            return false
        }
        
        var sum = 0
        for char in ip{
            sum = sum*10 + Int(String(char))!
        }
        
        if sum > 255 {
            return false
        }
        
        return true
    }
    
    // MARK: 78. 子集
    var result6 = [[Int]]()
    var path6 = [Int]()
    
    func subsets(_ nums: [Int]) -> [[Int]] {
        subsetsHelp(nums, 0)
        return result6
    }
    
    func subsetsHelp(_ nums: [Int] , _ startIndex: Int) {
        result6.append(path6)
        if path6.count >= nums.count {
            return
        }
        
        for i in startIndex..<nums.count {
            path6.append(nums[i])
            subsetsHelp(nums, i+1)
            path6.removeLast()
        }
    }
    
    // MARK: 90. 子集 II 给你一个整数数组 nums ，其中可能包含重复元素，请你返回该数组所有可能的子集（幂集）。
    //    解集 不能 包含重复的子集。返回的解集中，子集可以按 任意顺序 排列。
    var result7 = [[Int]]()
    var path7 = [Int]()
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        let used = [Int](repeating: 0, count: nums.count)
        subsetsWithDupHelp(nums.sorted(), used, 0)
        return result7
    }
    
    func subsetsWithDupHelp(_ nums: [Int], _ used: [Int], _ startIndex: Int) {
        result7.append(path7)
        if path7.count >= nums.count {
            return
        }
        var used = used
        for i in startIndex..<nums.count {
            if i > 0 && nums[i] == nums[i-1] && used[i-1] == 0 {
                continue
            }
            path7.append(nums[i])
            used[i] = 1
            subsetsWithDupHelp(nums, used, i+1)
            path7.removeLast()
            used[i] = 0
        }
    }
}

//MARK:栈和队列
//MARK:232. 用栈实现队列
class MyQueue {
    var stack1 = [Int]()
    var stack2 = [Int]()
    
    init() {
        
    }
    
    func push(_ x: Int) {
        stack1.append(x)
    }
    
    func pop() -> Int {
        if stack2.isEmpty {
            while !stack1.isEmpty{
                stack2.append(stack1.popLast()!)
            }
        }
        return stack2.popLast() ?? -1
    }
    
    func peek() -> Int {
        if stack2.isEmpty {
            while !stack1.isEmpty{
                stack2.append(stack1.popLast()!)
            }
        }
        return stack2.last ?? -1
    }
    
    func empty() -> Bool {
        return stack1.isEmpty && stack2.isEmpty
    }
}

class MinStack {
    var stack: [(Int,Int)] = []
    
    init() {
        
    }
    
    func push(_ val: Int) {
        if stack.isEmpty {
            stack.append((val,val))
        } else {
            stack.append((val,min(val, getMin())))
        }
    }
    
    func pop() {
        stack.removeLast()
    }
    
    func top() -> Int {
        return stack.last?.0 ?? 0
    }
    
    func getMin() -> Int {
        return stack.last?.1 ?? 0
    }
    
}


class StackMode {
    public class MyQueue{
        var queue = [Int]()
        
        func pop(_ val: Int)  {
            if !self.queue.isEmpty && self.front() == val {
                self.queue.removeFirst()
            }
        }
        
        func push(_ val: Int)  {
            while !self.queue.isEmpty && val > self.queue.last! {
                self.queue.removeLast()
            }
            self.queue.append(val)
        }
        
        func front() -> Int {
            return self.queue.first!
        }
        
    }
    
    // 定义一个双向链表的底层结构
    public class MyNode {
        var head: MyNode?
        var tail: MyNode?
        var next: MyNode?
        var pre: MyNode?
        var value: Int
        
        init() {
            self.value = 0
        }
        
        func push(_ val: Int)  {
            let node: MyNode? = MyNode()
            node?.value = val
            
            while !self.isEmpty() && val > self.lastValue() {
                self.removeLast()
            }
            // 添加
            if self.head == nil {
                self.head = node
                self.tail = node
                self.next = nil
                self.pre = nil
            } else {
                node?.pre = self.tail
                self.tail?.next = node
                self.tail = node
            }
        }
        
        func pop(_ val :Int) {
            if !self.isEmpty() && val == self.head!.value{
                self.removeFirst()
            }
        }
        
        func isEmpty() -> Bool {
            return self.head == nil
        }
        
        func lastValue() -> Int {
            return self.tail!.value
        }
        
        func front() -> Int {
            return self.head!.value
        }
        
        func removeFirst() {
            if self.head != nil {
                let tem = self.head?.next
                self.head?.next = nil
                tem?.pre = nil
                self.head = tem
            }
        }
        
        func removeLast() {
            if self.tail != nil {
                if self.tail!.pre != nil {
                    let tem = self.tail?.pre
                    tem!.next = nil
                    self.tail?.pre = nil
                    self.tail = tem
                } else {
                    self.tail = nil
                    self.head = nil
                }
            }
        }
    }
    
    //MARK: 239. 滑动窗口最大值
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        var result = [Int]()
        let queue: MyNode = MyNode()
        
        for i in 0..<k{
            queue.push(nums[i])
        }
        
        result.append(queue.front())
        
        for i in k..<nums.count {
            queue.pop(nums[i-k])
            queue.push(nums[i])
            result.append(queue.front())
        }
        return result
    }
}

//MARK: -TOPK问题 ----------------------------------
//MARK: 剑指 Offer 40. 最小的k个数
func getLeastNumbers(_ arr: [Int], _ k: Int) -> [Int] {
    if arr.isEmpty || k == 0 {
        return []
    }
    
    var arr = arr
    getLeastNumbersHelp(&arr, 0, arr.count - 1, k)
    return Array(arr[..<k])
}

func getLeastNumbersHelp(_ arr: inout [Int], _ left: Int, _ right: Int, _ k: Int) {
    let index = quickSort(&arr, left, right)
    
    if index == k - 1 {
        return
    } else if index > k - 1 {
        getLeastNumbersHelp(&arr, left, index - 1, k)
    } else {
        getLeastNumbersHelp(&arr, index + 1, right, k)
    }
}

func quickSort(_ arr: inout [Int], _ left: Int, _ right: Int) -> Int {
    let tem = arr[left]
    
    var i = left, j = right
    
    while i != j {
        while arr[j] >= tem && j > i {
            j -= 1
        }
        
        while arr[i] <= tem && j > i {
            i += 1
        }
        
        if j > i {
            arr.swapAt(i, j)
        }
    }
    
    arr[left] = arr[i]
    arr[i] = tem
    
    return i
}


//MARK: -单调栈
//MARK: 739. 每日温度
func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
    if temperatures.count == 0 {
        return []
    }
    var result = [Int](repeating: 0, count: temperatures.count)
    var stack = [Int]()
    stack.append(0)
    
    for i in 1..<temperatures.count{
        if temperatures[i] <= temperatures[stack.last!]{
            stack.append(i)
        } else {
            while !stack.isEmpty && temperatures[i] > temperatures[stack.last!]{
                let diff = i - stack.last!
                result[stack.last!] = diff
                stack.removeLast()
            }
            stack.append(i)
        }
    }
    return result
}

// MARK: 496. 下一个更大元素 I
func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    if nums2.count == 0 {
        return []
    }
    var dict = [Int:Int]()
    for i in 0..<nums1.count{
        dict[nums1[i]] = i
    }
    
    var result = [Int](repeating: -1, count: nums1.count)
    var stack = [Int]()
    stack.append(0)
    
    for i in 1..<nums2.count {
        if nums2[i] <= nums2[stack.last!]{
            stack.append(i)
        } else {
            while !stack.isEmpty && nums2[i] > nums2[stack.last!]{
                let key = nums2[stack.last!]
                if dict.keys.contains(key){
                    result[dict[key]!] = nums2[i]
                }
                stack.removeLast()
            }
            stack.append(i)
        }
    }
    
    return result
}

// MARK: 503. 下一个更大元素 II
func nextGreaterElements(_ nums: [Int]) -> [Int] {
    if nums.count == 0 {
        return []
    }
    var result = [Int](repeating: -1, count: nums.count)
    var stack = [0]
    let count = nums.count
    for i in 1..<count*2 {
        if nums[i%count] <= nums[stack.last!] {
            stack.append(i%count)
        } else {
            while !stack.isEmpty && nums[i%count] > nums[stack.last!] {
                result[stack.last!] = nums[i%count]
                stack.removeLast()
            }
            stack.append(i%count)
        }
    }
    return result
}

// MARK: 42. 接雨水
func trap(_ height: [Int]) -> Int {
    if height.count <= 2 {
        return 0
    }
    var sum = 0
    var stack = [Int]()
    stack.append(0)
    
    for i in 1..<height.count {
        
        if height[i] < height[stack.last!] {
            stack.append(i)
        } else if height[i] == height[stack.last!]{
            stack.removeLast()
            stack.append(i)
        } else {
            
            while !stack.isEmpty && height[i] > height[stack.last!] {
                let mid = stack.removeLast()
                if !stack.isEmpty {
                    let height = min(height[i], height[stack.last!]) - height[mid]
                    let width = i - stack.last! - 1
                    sum = sum + height*width
                }
            }
            stack.append(i)
        }
    }
    return sum
    
}

// MARK: 84. 柱状图中最大的矩形
func largestRectangleArea(_ heights: [Int]) -> Int {
    if heights.count == 0 {
        return 0
    }
    var heights = heights
    heights.insert(0, at: 0)
    heights.append(0)
    
    var result = 0
    var stack = [0]
    
    for i in 1..<heights.count {
        let cur = heights[i]
        if cur > heights[stack.last!] {
            stack.append(i)
        } else if cur == heights[stack.last!] {
            stack.removeLast()
            stack.append(i)
        } else {
            while cur < heights[stack.last!] {
                let mid = stack.removeLast()
                let left = stack.last!
                let w = i - left - 1
                let h = heights[mid]
                result = max(result, w*h)
            }
            stack.append(i)
        }
    }
    return result
}



var path = [Int]()
var result = [[Int]]()
func combine(_ n: Int, _ k: Int) -> [[Int]] {
    combineHelp(n, k, 1)
    return result
}

func combineHelp(_ n: Int, _ k: Int, _ startIndex: Int) {
    if path.count == k {
        result.append(path)
        return
    }
    
    for i in startIndex...n {
        if i > (n - (k-path.count) + 1){
            break
        }
        path.append(i)
        combineHelp(n, k, i + 1)
        path.removeLast()
    }
}

var path2 = [Int]()
var result2 = [[Int]]()

func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
    combinationSum3Help(k, n, 0, 1)
    return result2
}

func combinationSum3Help(_ k: Int, _ n: Int, _ sum: Int, _ startIndex: Int) {
    
    if path2.count == k {
        if sum == n {
            result2.append(path2)
        }
        return
    }
    
    var i = startIndex
    var sum = sum
    while i <= 9 - (k - path2.count) + 1 {
        if (sum + i) > n {
            return
        }
        path2.append(i)
        sum += i
        
        combinationSum3Help(k, n, sum, i+1)
        path2.removeLast()
        sum -= i
        
        i += 1
    }
}

