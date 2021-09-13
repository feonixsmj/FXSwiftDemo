import UIKit

var str = "Hello, playground"

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

//函数指针
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    //返回一个函数
    return addOne
}
var ss = makeIncrementer()
ss(7)

//函数作为参数
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

//------------------------------------------
func aaa(list : [Int], condition: (Int) -> Bool) -> Bool{
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func less(number: Int) -> Bool {
    return number < 5
}

var nums = [20,10,4,5,6]

aaa(list: nums, condition: less)
//------------------------------------------
let vc : UIViewController;

//两数之和
/*
给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

示例:

给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
 */
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    
    var index = 0
    var dict = [Int:Int]()
    for value in nums {

        if (dict.keys.contains(target-value)) {
            let index1 = dict[target-value]
            
            return [index1!, index];
        }
        dict[value] = index
        index += 1
    }
    return [1,2]
}

print(INT_MAX)
twoSum([3,2,4], 6)

func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    
    var i = 0
    for j in 1..<nums.count {
        if nums[j] != nums[i] {
            i += 1
            nums[i] = nums[j]
        }
    }
    return i + 1
}

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
}

func list(_ numberArr: [Int]) -> Int{
    
    var numberArr = numberArr
    
    numberArr .removeFirst()
    

    if let first = numberArr.first {
        print(first)
    }
    
//    let hello : String?
//    print(hello)
    
    
    return numberArr.first!
}

list([1,2,3,4])


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


func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
    if t1 == nil {
        return t2
    }
    if t2 == nil {
        return t1
    }
    
    t1!.val += t2!.val
    t1!.left = mergeTrees(t1!.left, t2!.left)
    t1!.right = mergeTrees(t1!.right, t2!.right)
    return t1;
}

//有序数组 递归创建一个 二分搜索树

//func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode?

func generate(arr: [Int], start: Int, end: Int) -> TreeNode? {
    if start > end {
        return nil
    }
    
    let mid = (start + end) / 2
    let head: TreeNode = TreeNode.init(arr[mid])
    head.left = generate(arr: arr, start: start, end: mid-1)
    head.right = generate(arr: arr, start: mid+1, end: end)
    
    return head;
}

let tree: TreeNode? = generate(arr: [1,2,3,4,5,6,7], start: 0, end: 6)
print(tree!)

// 169
func majorityElement(_ nums: [Int]) -> Int {
    
    if nums.count == 1 {
        return nums[0]
    }
    
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

majorityElement([3,2,3])

/*
class Solution {
    public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        if (l1 == null) {
            return l2;
        }
        else if (l2 == null) {
            return l1;
        }
        else if (l1.val < l2.val) {
            l1.next = mergeTwoLists(l1.next, l2);
            return l1;
        }
        else {
            l2.next = mergeTwoLists(l1, l2.next);
            return l2;
        }

    }
}
*/


//21. 合并两个有序链表
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

let s:Solution = Solution.init()

s.mergeTwoLists(s.node1, s.node2)
s.createListNode()

/* 1221
在一个「平衡字符串」中，'L' 和 'R' 字符的数量是相同的。
给出一个平衡字符串 s，请你将它分割成尽可能多的平衡字符串。
返回可以通过分割得到的平衡字符串的最大数量。

示例 1：
输入：s = "RLRRLLRLRL"
输出：4
解释：s 可以分割为 "RL", "RRLL", "RL", "RL", 每个子字符串中都包含相同数量的 'L' 和 'R'。
示例 2：

输入：s = "RLLLLRRRLR"
输出：3
解释：s 可以分割为 "RL", "LLLRRR", "LR", 每个子字符串中都包含相同数量的 'L' 和 'R'。
示例 3：

输入：s = "LLLLRRRR"
输出：1
解释：s 只能保持原样 "LLLLRRRR".
 

提示：

1 <= s.length <= 1000
s[i] = 'L' 或 'R'
分割得到的每个字符串都必须是平衡字符串。
通过次数25,740提交次数32,722

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/split-a-string-in-balanced-strings
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


func balancedStringSplit(_ s: String) -> Int {
    
    var count: Int = 0
    var num: Int = 0
    
    for char in s {
        if char == "L" {
            num += 1
        } else if(char == "R"){
            num -= 1
        }
        
        if num == 0 {
            count += 1
        }
    }
    return count;
}

balancedStringSplit("RLLLLRRRLR")







