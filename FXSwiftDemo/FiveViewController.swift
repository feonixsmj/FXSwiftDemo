//
//  FiveViewController.swift
//  FXSwiftDemo
//
//  Created by FeoniX on 2022/5/1.
//  Copyright © 2022 FX. All rights reserved.
//  7 8 9 10 11

import Foundation
import UIKit

class FiveViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view: UIView = UIView.init(frame: CGRect(x: 10, y: 60, width: 320, height: 44))
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        
//        let array = [1,2,3,4,5]
//        var muArray = [0,0,0]
//        muArray.append(contentsOf: array)
//        print(muArray)
        
//        bubbleSort([6,5,4,3,2,1])
        
        solve("99", "1")
    }
    
    // MARK: -冒泡排序
    func bubbleSort(_ array: [Int]) {
        var array = array
        var i = array.count - 1
        while i > 0 {
            var j = 0
            while j < i {
                let left = array[j]
                let right = array[j + 1]
                if left > right {
                    (array[j], array[j + 1]) = (array[j + 1], array[j])
                }
                j += 1
            }
            i -= 1
        }
        print(array)
    }
    
    func quickSort ( _ arr: [Int]) -> [Int] {
        // write code here
        if arr.count <= 1 {
            return arr
        }
        let pivot = arr.first!
        
        var smallArr = [Int]()
        var biggerArr = [Int]()
        
        for num in arr[1...] {
            if num < pivot {
                smallArr.append(num)
            } else {
                biggerArr.append(num)
            }
        }
        
        var result = [Int]()
        result.append(contentsOf: quickSort(smallArr))
        result.append(pivot)
        result.append(contentsOf: quickSort(biggerArr))
        
        return result
    }
    

    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(){
            self.val = 0
            self.next = nil
        }
        public init(_ val: Int){
            self.val = val
            self.next = nil
        }
        public init(_ val: Int, _ next: ListNode?){
            self.val = val
            self.next = next
        }
    }


    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let dummyNode: ListNode? = ListNode.init()
        dummyNode?.next = head
        
        var tem: ListNode? = dummyNode
        while tem?.next != nil {
            if tem?.next!.val == val{
                tem?.next = tem?.next?.next
            } else {
                tem = tem?.next
            }
        }
        
        return dummyNode?.next
    }
    
    func reverseList(_ head: ListNode?) -> ListNode? {
        var newNode: ListNode? = nil
        var cur = head
       
        while cur != nil {
            let tem = cur?.next
            cur?.next = newNode
            newNode = cur
            cur = tem
        }
        return newNode
    }
    
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummyNode: ListNode? = ListNode.init(0,head)
        var cur = dummyNode
        
        while cur?.next != nil && cur?.next?.next != nil {
            let tem = cur?.next?.next?.next
            let node1 = cur?.next
            let node2 = cur?.next?.next
            
            cur?.next = node2
            node2?.next = node1
            node1?.next = tem
            
            cur = cur?.next?.next
        }
        
        return dummyNode?.next
    }
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummyNode: ListNode? = ListNode.init(0, head)
        var head = head
        for _ in 0..<n-1 {
            head = head?.next
        }
        var cur = dummyNode
        while head?.next != nil {
            head = head?.next
            cur = cur?.next
        }
        
        cur?.next = cur?.next?.next
        
        return dummyNode?.next
    }
    
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var nodeA = headA, nodeB = headB, lengthA = 0, lengthB = 0
        while nodeA != nil{
            nodeA = nodeA?.next
            lengthA += 1
        }
        
        while nodeB != nil{
            nodeB = nodeB?.next
            lengthB += 1
        }
        
        nodeA = headA
        nodeB = headB
        
        if lengthB > lengthA {
            swap(&nodeA, &nodeB)
            swap(&lengthA, &lengthB)
        }
        
        let diff = lengthA - lengthB
        for _ in 0..<diff{
            nodeA = nodeA?.next
        }
        
        while nodeA != nil {
            if nodeA === nodeB{
                return nodeA
            } else {
                nodeA = nodeA?.next
                nodeB = nodeB?.next
            }
        }
        
        return nil
    }
    
    func detectCycle(_ head: ListNode?) -> ListNode? {
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
            
            if slow === fast {
                var node1 = head
                var node2 = fast
                
                while !(node1 === node2) {
                    node1 = node1?.next
                    node2 = node2?.next
                }
                return node1
            }
        }
        
        return nil
    }
    
    
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {return false}
        
        var record = [Int](repeating: 0, count: 26)
        let aUVlaue = "a".unicodeScalars.first!.value
        
        for code in s.unicodeScalars {
            record[Int(code.value - aUVlaue)] += 1
        }
        
        for code in t.unicodeScalars {
            record[Int(code.value - aUVlaue)] -= 1
        }
        
        for num in record {
            if num != 0 {return false}
        }
        
        return true
    }
    //12
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        return Array(Set(nums1).intersection(Set(nums2)))
    }
    //13
    
    // MARK: -134.加油站 begin
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var minValue = Int.max, minIndex = 0
        var remainder = 0
        for i in 0..<gas.count {
            remainder += gas[i] - cost[i]
            if remainder < minValue {
                minValue = remainder
                minIndex = i
            }
        }
        
        return remainder < 0 ? -1 : (minIndex + 1)%gas.count
        
    }
    
    // MARK: -202. 快乐数 //15
    
    func getHappyNum(_ num: Int) -> Int {
        var sum = 0, num = num
        while num > 0 {
            let tem: Int = num % 10
            sum += tem * tem
            num /= 10
        }
        return sum
    }
    
    func isHappy(_ n: Int) -> Bool {
        var resultSet = Set<Int>()
        var num = n
        while true{
            num = self.getHappyNum(num)
            if num == 1 {
                return true
            }
            
            if resultSet.contains(num){
                return false
            }
            
            resultSet.insert(num)
        }
        
    }
    
    // 1. 两数之和 16
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        
        for i in 0..<nums.count {
            if let index = dict[target-nums[i]] {
                return [index, i]
            } else {
                dict[nums[i]] = i
            }
        }
        return []
    }
    
    //454. 四数相加 II 17
    func fourSumCount(_ nums1: [Int], _ nums2: [Int], _ nums3: [Int], _ nums4: [Int]) -> Int {
        var dict = [Int: Int]()
        for a in nums1{
            for b in nums2 {
                dict[a+b] = dict[a+b,default: 0] + 1
            }
        }
        
        var result = 0
        
        for c in nums3 {
            for d in nums4 {
                if let value = dict[-(c+d)] {
                    result += value
                }
            }
        }
        
        return result
    }
    
    //383. 赎金信 18
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var array = [Int](repeating: 0, count: 26)
        let code = "a".unicodeScalars.first!.value
        
        for char in magazine.unicodeScalars{
            array[Int(char.value-code)] += 1
        }
        
        for char in ransomNote.unicodeScalars{
            let key = Int(char.value-code)
            array[key] -= 1
            if array[key] < 0 {return false}
        }
        
        return true
    }
    
    //15. 三数之和 19
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let nums = nums.sorted()
        
        for i in 0..<nums.count {
            if nums[i] > 0 { return result }
            if i > 0 && nums[i] == nums[i - 1] {continue}
            
            var left = i + 1, right = nums.count - 1
            
            // 因为不能重复使用同一个元素，所以边界>
            while right > left {
                let sum = nums[i] + nums[left] + nums[right]
                
                if sum > 0 {
                    right -= 1
                    while right > left && nums[right] == nums[right + 1] {
                        right -= 1
                    }
                } else if sum < 0 {
                    left += 1
                    while right > left && nums[left] == nums[left - 1] {
                        left += 1
                    }
                } else {
                    result.append([nums[i],nums[left],nums[right]])
                    while right > left && nums[right] == nums[right - 1] {
                        right -= 1
                    }
                    while right > left && nums[left] == nums[left + 1] {
                        left += 1
                    }
                    left += 1
                    right -= 1
                }
            }
        }
        
        return result
    }
    
    //18. 四数之和 20
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var nums = nums.sorted(), result = [[Int]]()
        for k in 0..<nums.count {
            if k > 0 && nums[k] == nums[k-1] {continue}
            
            var i = k + 1
            
            while i < nums.count {
                if i > k + 1 && nums[i] == nums[i-1] { i += 1;continue}
                
                var left = i + 1, right = nums.count - 1
                while right > left {
                    let sum = nums[k] + nums[i] + nums[left] + nums[right]
                    
                    if sum > target {
                        right -= 1
                    } else if sum < target{
                        left += 1
                    } else {
                        result.append([nums[k],nums[i],nums[left],nums[right]])
                        while right > left && nums[right] == nums[right - 1]{
                            right -= 1
                        }
                        
                        while right > left && nums[left] == nums[left + 1]{
                            left += 1
                        }
                        
                        left += 1; right -= 1
                    }
                }
                i += 1
            }
        }
        
        return result
    }
    
    //344. 反转字符串 21
    func reverseString(_ s: inout [Character]) {
        var i = 0,j = s.count - 1
        
        while i < j {
            (s[i], s[j]) = (s[j], s[i])
            i += 1; j -= 1
        }
    }
    
    func reverseString2(_ s: inout [Character]) {
        
        for i in 0..<s.count / 2 {
            s.swapAt(i, s.count - 1 - i)
        }
    }
    
    // MARK: -541. 反转字符串 II 22
    func reverseStr(_ s: String, _ k: Int) -> String {
        var s = Array(s)
        for i in stride(from: 0, to: s.count, by: 2*k){
            var left = i
            var right = min(left + k - 1 , s.count - 1)
            
            while right > left {
                s.swapAt(left, right)
                left += 1
                right -= 1
            }
        }
        return String(s)
    }
    //23
    func replaceSpace(_ s: String) -> String {
        var s = Array(s), count = 0
        for char in s {
            if char  == " "{
                count += 1
            }
        }
        
        var left = s.count - 1
        var right = s.count - 1 + 2*count
        
        for _ in 0..<count*2 {
            s.append(" ")
        }
        
        while left >= 0 {
            if s[left] == " " {
                s[right] = "0"
                s[right - 1] = "2"
                s[right - 2] = "%"
                
                left -= 1
                right -= 3
            } else {
                s[right] = s[left]
                left -= 1; right -= 1
            }
        }
        
        return String(s)
        
    }
//    lrlose umgh 24
    func reverseLeftWords(_ s: String, _ n: Int) -> String {
        var s = Array(s)
        for i in 0..<n/2{
            s.swapAt(i, n-i-1)
        }
        let left = n, right = s.count - 1, count = (right - left + 1) / 2
        for i in 0..<count {
            s.swapAt(left+i, right-i)
        }
        
        for i in 0..<s.count/2 {
            s.swapAt(i, s.count-i-1)
        }
        return String(s)
    }
    
    // 25
    class MyQueue {
        var stack1 = [Int]()
        var stack2 = [Int]()
        
        init() {

        }
        
        func push(_ x: Int) {
            self.stack1.append(x)
        }
        
        func pop() -> Int {
            if self.stack2.isEmpty {
                while !self.stack1.isEmpty{
                    self.stack2.append(self.stack1.popLast()!)
                }
            }

            return self.stack2.popLast() ?? -1
        }
        
        func peek() -> Int {
            let num = self.pop()
            self.stack2.append(num)
            return num
        }
        
        func empty() -> Bool {
            return self.stack1.isEmpty && self.stack2.isEmpty
        }
    }
    
    //26  225. 用队列实现栈
    class MyStack {
        var queue = [Int]()
        init() {

        }
        
        func push(_ x: Int) {
            self.queue.append(x)
        }
        
        func pop() -> Int {
            if self.queue.isEmpty {
                return -1
            }
            for _ in 1..<self.queue.count {
                self.queue.append(self.queue.removeFirst())
            }
            return self.queue.removeFirst()
        }
        
        func top() -> Int {
            let top = self.pop()
            self.queue.append(top)
            return top
        }
        
        func empty() -> Bool {
            return self.queue.isEmpty
        }
    }
    // 27  20. 有效的括号
    func isValid(_ s: String) -> Bool {
        let chars1 = ["(","[","{"]
        let dict = ["]" : "[", "}": "{", ")" : "("]
        let s = Array(s)
        var tempArray = [String]()
        
        for c in s {
            if chars1.contains(String(c)) {
                tempArray.append(String(c))
            } else {
                if tempArray.isEmpty {
                    return false
                }
                
                if dict[String(c)] == tempArray.last! {
                    tempArray.removeLast()
                } else {
                    return false
                }
            }
        }
        
        return tempArray.isEmpty
    }
    
    
    // 28 1047. 删除字符串中的所有相邻重复项
    func removeDuplicates(_ s: String) -> String {
        let strArray = Array(s)
        var result = [Character]()
        
        for str in strArray {
            if result.isEmpty || str != result.last! {
                result.append(str)
            } else {
                result.removeLast()
            }
        }
        
        return String(result)
    }
    
    //29
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        
        for str in tokens {
            if str == "+" || str == "-" || str == "*" || str == "/" {
                let num1 = stack.popLast()!
                let num2 = stack.popLast()!
                switch str {
                case "+":
                    stack.append(num2 + num1)
                case "-":
                    stack.append(num2 - num1)
                case "*":
                    stack.append(num2 * num1)
                case "/":
                    stack.append(num2 / num1)
                default: break
                }
            } else {
                stack.append(Int(str)!)
            }
        }
        
        return stack.first!
    }
    
    // MARK: 77. 组合
    var path77 = [Int]()
    var result77 = [[Int]]()
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        combineHelp(n, k, 1)
        return result77
    }
    
    func combineHelp(_ n: Int, _ k: Int, _ startIndex: Int)  {
        if path77.count == k{
            result77.append(path77)
            return
        }
        
        var i = startIndex
        while i <= (n - (k - path77.count) + 1) {
            path77.append(i)
            combineHelp(n, k, i + 1)
            path77.removeLast()
            
            i += 1
        }
    }
    
    
    // MARK: - 39. 组合总和
    var result39 = [[Int]]()
    var path39 = [Int]()
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        
        combinationSumHelp(candidates.sorted(), target, 0, 0)
        return result39
    }
    
    func combinationSumHelp(_ candidates: [Int], _ target: Int, _ startIndex: Int, _ sum :Int){
        var sum = sum
        if sum == target {
            result39.append(path39)
            return
        }
        for i in startIndex..<candidates.count {
            let num = candidates[i]
            if sum + num > target {
                return
            }
            sum += num
            path39.append(num)
            combinationSumHelp(candidates, target, i, sum)
            sum -= num
            path39.removeLast()
        }
        
    }
    
    // MARK: 46. 全排列
    func permute(_ nums: [Int]) -> [[Int]] {
        var used = [Bool](repeating: false, count: nums.count)
        var path = [Int]()
        var result = [[Int]]()
        
        func backtracking() {
            if path.count == nums.count {
                result.append(path)
                return
            }
            
            for i in 0..<nums.count {
                if used[i] { continue }
                used[i] = true
                path.append(nums[i]
                )
                backtracking()
                used[i] = false
                path.removeLast()
             }
        }
        
        backtracking()
        return result
    }
    
    // MARK: - 牛客 NC1 大数加法
    func solve ( _ s: String,  _ t: String) -> String {
        // write code here
        var a = Array(s)
        var b = Array(t)
        var length1 = a.count,  length2 = b.count
        if length1 < length2 {
            (a,b) = (b,a)
            (length1, length2) = (length2, length1)
        }
        
        var i = length1 - 1, j = length2 - 1, k = length1 + 1
        var result = [Int](repeating: 0, count: k)
        var tem = 0
        while i >= 0 {
            
            let value1 = Int(String(a[i]))!
            var sum = value1 + tem
            if j >= 0 {
                let value2 = Int(String(b[j]))!
                sum = value1 + value2 + tem
            }
            if sum > 9 {
                sum = sum % 10
                tem = 1
            } else {
                tem = 0
            }
            result[k-1] = sum
            
            i -= 1; j -= 1; k -= 1
        }
        
        if tem > 0 {
            result[0] = 1
        } else {
            result.removeFirst()
        }
        
        return String(result.flatMap{String($0)})
        
    }
    
    // MARK: - 牛客 NC33 合并两个排序的链表
    func Merge ( _ pHead1: ListNode?,  _ pHead2: ListNode?) -> ListNode? {
        // write code here
        if pHead1 == nil {
            return pHead2
        }
        if pHead2 == nil {
            return pHead1
        }
        
        var head: ListNode? = nil
        if pHead1!.val > pHead2!.val {
            head = pHead2
            head?.next = Merge(pHead1, pHead2?.next)
        } else {
            head = pHead1
            head?.next = Merge(pHead1?.next, pHead2)
        }
        
        return head
    }
    
    // MARK: 牛客 NC68 跳台阶
    func jumpFloor ( _ number: Int) -> Int {
        // write code here
        // fn = fn-1 + fn-2  f1 = 1 f2 = 2  f3 = 3
        var n = number
        
        if n == 0 { return 1 }
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        
        var a = 1,b = 2, sum = 0
        
        while n > 2 {
            sum = a + b
            a = b
            b = sum
            n -= 1
        }
        
        return sum
    }
    
    class MyLinkedList{
        
        class ListNode {
            var val: Int?
            var next: ListNode?
           
            init(_ val: Int?){
                self.val = val
                self.next = nil
            }
            
            init(_ val: Int, _ next: ListNode?) {
                self.val = val
                self.next = next
            }
        }
        
        private var size: Int! = 0
        private var dummy: ListNode?
        
        init(){
            self.size = 0
            self.dummy = ListNode.init(0)
        }
        
        func get(_ index: Int) -> Int {
            if (0..<self.size).contains(index) == false {return -1}
            var tem = self.dummy?.next
            for _ in 0..<index {
                tem = tem?.next
            }
            return tem?.val ?? -1
        }
        
        func addAtHead(_ val: Int){
            let tem = self.dummy?.next
            self.dummy?.next = ListNode.init(val, tem)
            self.size += 1
        }
        
        func addAtTail(_ val: Int){
            let tail = ListNode.init(val)
            var tem = self.dummy
            while tem?.next != nil {
                tem = tem?.next
            }
            tem?.next = tail
            self.size += 1
        }
        
        func addAtIndex(_ index: Int, _ val: Int){
            if index < 0 {
                self.addAtHead(val)
            } else if index > self.size {
                return
            } else if index == self.size {
                self.addAtTail(val)
            } else {
                var cur = self.dummy
                for _ in 0..<index {
                    cur = cur?.next
                }
                let tem = cur?.next
                cur?.next = ListNode.init(val, tem)
                
                self.size += 1
            }
        }
        
        func deleteAtIndex(_ index: Int){
            if (0..<self.size).contains(index) {
                var cur = self.dummy
                for _ in 0..<index {
                    cur = cur?.next
                }
                cur?.next = cur?.next?.next
                self.size -= 1
            }
        }
    }
    
}
