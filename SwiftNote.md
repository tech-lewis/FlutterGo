# Swift 5 学习笔记



## 第一节课 Swift历史介绍

- Swift5 与OC当前的区别和优势

- Swift可以使用协议编程 函数式编程 面向对象编程 但OC只有OOP 而且需要借助ReactiveCocoa实现

- Swift是类型安全的语言，代码中要清晰明确的类型.代码在编译时就会做类型的静态检查，并且会报错显示

- 比OC更安全 能够在开发的时候尽可能早的发现和修正错误，然而OC的编译器只会抱怨出现一些warning

- Swift中enum和结构体 tuple都是值类型 而且功能都增强了??具体增强了哪些？有没有引用计数器

- Swift中的Int Double Float String Array Dictionary其实都是用结构体来实现的 也是值类型的

- 但是OC中NSNumber NSString字符串和集合类型的对象都是指针 使用引用传递的

- Swift中的enum增强了 可以用Int Double Float 还有字符串，更强的是可以有属性和方法，支持泛型和协议扩展等等

- Objective-C中的枚举值就弱很多

- Swift 2.0之后 OC也包括了Generics的支持 但是范型的约束也只是停留在Xcode编译Warning的基础阶段

- Swift 从开发发布的时候就支持了范型 也支持泛型的类型约束等新特性? 类型约束如何使用呢

- 协议与扩展更强大Swift中的协议加强了 和extension generics 关联类型？配合可以实现面向协议编程

- 面向协议编程大大提高代码的灵活性 同时Swift中的protocol还可以用于值的类型 可以用到枚举 structure？？怎么用

- Objective-C中的协议不够灵活不够好? 缺乏强约束？<strong> 默认是require！！！</strong>

- Objective-C中protocol默认是必须实现的 如果不使用optional代价就大 但是使用optional会带来很多问题?crash？

- 函数和闭包在Swift中是一等公民 可以直接定义函数类型的变量 可以作为其他参数传也可以返回某个func

- 而Objective-C中函数还是次等 并且需要selector来包装或block来模拟Swift中的效果

  

  ```swift
  swift 特点总结
  1 编程范式更多
  2 类型安全  静态语言
  3 值类型的增强 集合使用STL中的什么map使用拷贝后改写的特点？
  4 枚举类型的增强
  5 Generics泛型的支持
  6 协议与扩展的增强
  7 函数与闭包的增强
  8 函数式编程
  ```

  

   

版本的一些注意点

- Xcode 10.2才支持Swift 5.0版本 需要更新系统到Mojave 10.4.3
- Xcode 9.2版本使用的Swift是4.0.3
- 要学习最新版本的新特性啊，最低使用Mojave 回去就更新这个系统 买一个U盘来安装
- MBP15inch好像是Mojave 安装一个低版本Xcode 10.2 而且还带有Application Loader
- 2015年11月-12期间开源 经历15个小版本更新到5.0.1
- 闭包的使用方法 还有闭包内的next是什么东西



```swift
Swift 1.0 在暑假的时候发布Release 随后Firefox开始使用Swift开发新浏览器项目
Swift 2.0 包括的NSError类型的强化 错误处理更强了
Swift 2.2 更新了新功能 包括了Guard和协议的扩展支持

Swift 3.0 更新了sequence序列的新功能 如何使用内联序列化函数呢? 定义了两个内联的function
  关于first和next的使用 它们可以返回无限的序列吗 懒加载的形式传递给block闭包的好处是什么
	更面向对象的GCD 与Core Graphics 更简化的API
	移除很多类的NS前缀的 如Data Bundle URL等等
	新加入两个权限控制的关键字fileprivate和open
	open > public > fileprivate > private
	移除了很多2.2准备废弃的运算符 如++ -- 让swift的代码更清晰
	fileprivate为了解决类扩展中的作用域问题???
  但是fileprivate在Swift 4和5中还会使用吗

Swift 4.0 在Xcode 9的时候发布使用，兼容iOS 11系统
extension中已经可以访问private修饰的属性了
类型和协议的组合类型是什么东西 查百度
Associate Type可以附加where约束语句?
新的KeyPath语法是什么？ 使用\能提高性能吗
下标现在支持范型了，取出的元素可以指定 不用使用AnyObject转化了
Swift4中的字符串增强了什么功能? 对比学习JS中9种API处理集合类型

operant操作性
```



## Swift5 新特性与疑问查询资料

```swift
ABI 更加稳定，使用Xcode 10.2或更新的版本与iOS 12.2+ 软件包中不需要Swift的runtime 那些庞大的framework了？
定义了与Python 或 Ruby脚本互相操作动态可调用类型 JavascriptCore也可以操作JS脚本
标准库当中新加入了Result类型是干什么的?
Raw String的作用又是做什么的
学习更多Instrument的使用 并了解结构图struct和class的区别 并不能使用引用计数吗
还有swift的新的关键字 guard和defer的深入了解?



```



## 第二节课 Swift新工具

- LLVM高性能模块化
- Swift 包括很多命令行工具 swiftc 可转化AST SIL 和LLVM IR 以及Assembly Language
- 最强的是类脚本的命令行工具 简称 REPL（读 Eval Printloop?）  图像化环境Playground Xcode6.1才有的
- REPL会默认生成变量接收值 并且语法会报错 在命令行中显示出来 还可以在REPL中写func函数 添加断点
- REPL常用快捷键  退出:quit 帮助菜单:help 光标移动行首Ctr+A 行尾Ctr+E  Tab可以做代码的补齐
- 使用Playground工具发布于2014年6月 在2016年发布了iPad版本的Playgrounds
- Playground 更强大的特性是Live View来编写UI import UIKit
- show result quickLook可以预览全貌 PlaygroundPage.current.liveView = nav 简单快捷





<hr>

## Swift 基础

- swift基础数据类型的使用

- let 和 var定义和声明  不能修改let修饰的常量值

- OC中用宏定义来模拟let的使用 或const修饰  在类当中使用property的readonly来修饰限定只读属性(伪的)

- var text1, text2, text3, text4, text5, text6, text7: String 这样添加多个变量的类型标注

- 可以使用表情作为变量或者常量名 let 1ab = "abc"数字开头的常量名会报错 a不是一个有效的数字

- print 可以使用字符串插值 比OC的更简单和明

  

## Swift 中的可选类型: 使用标准库实现的一个语言特性的典型例子

- OC的nil是无类型的指针 而且集合不能放nil。不方便的

- optional是有类型的 OC当中nil我不能判断类型而且运行期间所有对象都可能为nil 必须先进行空值的判断再进行操作

- OC中的nil只能使用到对象当中 但是其他地方还需要查集合中的元素，但是没找到还要判断NSNotFound这样特殊值

- 引入可选 是为了Swift中中表示值的缺失或找不到

  

  ```swift
  // Int Double也可以定义可选类型
  // 可选类型是没有办法直接使用的
  面试问过的问题
  // if判断  可选绑定 隐式展开解包 还有guard可以实现 4种方式吧！
  隐式的展开常用在初始化类当中 开始就要确定这个常变量是有值的
  
  
  可选链调用方法得到的值如果不为nil空的话还是需要解包才能使用的
  
  ```

  

  

  

## Swift中可选类型的实现

- 使用的是范型<Wrapper>的一个枚举 在标准库当中定义的
- 这个枚举定义了两个类型 none和some类型
- Optional.some包装有实际的值
- 问号和感叹号其实是Optional<TYPE名>的语法糖
- var unsafelyUnwrapped属性的实际作用是啥 只定义了get用来获得实际的值值
- var str? = "abc"  str.unsafelyUnwrapped.count是不会报错误的



## swift字符串的使用

- isEmpty
- """开头和末尾都有3个引号显示多行字符串 这样类似markdown的code框输入原始格式那么的方便
- \可以让代码换行但是字符串不换行的
- Swift中特殊字符的处理\0 \t \n \r \" \'  \u{1-18位的一个数字}表示unicode符号
- ![屏幕快照 2020-07-29 下午8.40.35](/Users/Mark/Documents/img/屏幕快照 2020-07-29 下午8.40.35.png)







## Swift5 新特性 Raw String

- 中文翻译过来叫做 扩展字符串分隔符
- Swift 一开始就有许多的字符串操作方法 但是最开始因为不会使用String.Index就转为使用NS String的API
- Swift中有String和Substring 这里的子串和OC中的概念有很大的不同点
- OC中substring相关的API得到的还是NSString类型的字符串
- Swift中的Substring可以转化为String类型的 而且还可以使用String很大API
- 苹果设计Substring的目的是性能考虑的 Substring与原始字符串共用内存空间。重用原字符串的内存
- 除非你需要修改原始字符串或者Substring中的内容，否则都不需要进行拷贝内存中的值的操作的 提高了性能
- 另外Substring转化为String时 Substring占用的内存会单独拷贝出来 因为转的String是值类型的
- String和Substring都是遵守String Protocol协议的，都能很方便的兼容所有接收String Protocol值的API函数
- 在日常开放工作当中尽量使用String Protocol这个类型的参数定义。这样就能很方便的兼容Substring类型的参数











## Swift常用的运算符

- Swift =赋值操作之后是没有返回值的 只有==才有bool返回值 这样避免了C语言中的一些代码错误
- 加减乘除与取模%运算符是可以检查值是否有溢出的 避免你的操作比存储类型允许的范围更大/更小的情况
- 赋值给某个tuple类型的 就能像JS中解构一样的赋值 拆分的赋值给每一个变量的
- Swift中的所有运算符是不允许值的溢出的
- a%b运算符 当b为负数的时候还是当正的来处理  也就是说a%- b 等价于a%b  负号会被忽略掉。
- 如果a%b 当a是负数会保留下负号的
- !!!减号放在数字的前面 表示负数不要用空格 后面的数字要紧跟在负号之后
- 复习区间运算符  1..<1 返回的是一个空区间
- Swift中的区间是可作用在Comparable类型当中的 返回的是闭区间或者半闭区间 什么是Comparable协议??
- 复习位运算的相关算法的使用

>  区间运算符 OC是没有的 这也是Swift当中的重点知识 要好好使用哦
>
> 闭区间运算符  2半开半闭区间  3单侧区间 需要复习下
>
> 字符串索引的区间复习复习
>
> 字符串的区间和比较要复习

## 位运算符的相关使用

```swift

func countOf1Bite(num: UInt)-> UInt {
    var count: UInt = 0
    var temp = num
    while temp != 0 {
//        if temp&1 != 0 {
//            count += 1
//        }
        count += temp&1
        temp = temp >> 1
    }
    
    return count
}


func countOf1BiteAdvance(num: UInt)-> UInt {
    var count: UInt = 0
    var temp = num
    while temp != 0 {
        
        count += 1
        temp = temp & (temp - 1)  // 优化思路跳过0这些位
    }
    return count
}
countOf1Bite(num: 0x11) //16进制数的一个特点 代表10进制的16 也代表二进制的一个1 具体是高位的?!
countOf1BiteAdvance(num: 11)
// 位运算的基本使用

print(0x111)


func isPowerOfTwo(num: UInt) -> Bool {
    return (num & (num-1)) == 0
}

isPowerOfTwo(num: 512)

复习Swift位运算符的使用和两个实例教程

```



Swift中运算符的优先级与结合性与其他编程语言没有什么区别

运算符的结合性：在运算符优先级相同的情况下 它们是如何运算的 是从左到右的

开发中 为了不让代码混乱 记得在很长的表达式当中加入小括号让表达式易读

在开发中多个逻辑运算符&& ||结合在一起时要使用小括号分隔 这样更易读

Swift当中的逻辑表达式 && || 是左相关的结果



## 等价运算符的重载

- swift为下面自定义类型提等价运算合成的实现
- 1- 只拥有遵循Equatable协议的 存储属性的structure
- 2- 只拥有遵循Equatable协议的  关联类型的枚举
- 3- 没有关联类型的枚举

关联类型的枚举是怎么写法的？

Swift当中可以重载运算符的实现之外 还可以自定义运算符的

```swift
// 让自己翻倍的运算 自定义运算符
prefix operator +++
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D)-> Vector2D {
        vector += vector
        return vector
    }
}

⚠️注意中缀运算符的优先级和结合性的特点 要定义的时候注意设定预设或设置结合性与优先级
infix
AddtionPrecedence  加法运算符的结合性
MultiplicationPrecedence的优先级结合性设置
MyPrecedence需要写在优先级group当中
precendenceGroup{包括了两个key  associativity,   lowerThan:AddtionPrecedence}写法baidu

swift for in 循环
let numberOfLegs = ["spider": 8,  "ant": 6, "cat": 4]
for tup im numberOfLegs {tup.0  tup.1取出键值对的}
tup.0 等价于tup.key
tup.1 等价于tup.value

查看Swift写的UI Tabbar那个框架
```





重点学习Swift中的 Switch语句 语法和功能比OC要强大的很多的

- switch里匹配的case 还可以使用where子句设置约束
- 不能像C语言那样写的随意 没有隐式贯穿 要写出来fallthrough
- 区间匹配和元祖Tuple匹配 还可以进行值的绑定 注意作用域的使用范围
- 复合匹配多个条件的逻辑或情况 复合匹配要注意值绑定的点



## 关于Guard关键字

- 官方文档介绍的是Early Exit 及早的推出
- 黄金大道 快乐的大道的编程风格，重要业务的逻辑不要写在if嵌套里面的
- API的检查方法
- 业务逻辑尽量写在if的外面的



## Swift中模式和模式匹配

- 第一类: 通配符模式 标识符模式 值绑定的模式 与元祖模式 可以加入where子句的约束
- 第二类: 枚举用例模式/ 可选模式/ 表达式模式/ 类型转换模式

```swift
// 模式 模式匹配这两点 文档确定为这是语言规范的一部分
例如tuple就是 类似解构赋值那样的模式匹配了
swift中模式匹分为两大类 第一种结解构简单的变量值 第二种匹配叫做全模式匹配-是可能失败的

枚举用例模式是什么 后面学？

```



## Swift当中集合类型

- 数组的初始化有字面量的方法
- 字符串还有两种初始化器的方式
  - [类型名]（）
  - Array<类型>（）
- 始化器带上参数的方式Array(repeating: "Z", count: 5) 可以通过第一个参数类型推断出
- decoder方式序列化一个数组
- 使用ForEach遍历数组的时候不要使用break或continue 无法使用的
- 如果想跳过那么可以使用for in语法来遍历数组
- String的startIndex和endIndex他们是一个结构体和Array中的不一样的
- 工作开发中常用的是for in和FOR enumerated的方法解包tuple得到index和value
- 查看API cations(where的用法)

```swift
Array常用的API
// 返回一个bool值来代表是否包含
1. contains()
2. contains(where) 

// allSatisfy: 是否全部复合条件再返回一个bool
allSatisfy

//查找某一个符合条件的值 返回这个值的optional或者nil
1. first
2. last
3. first(where: {$0 条件表达式})
4. last(where: {$0 条件表达式})

// 返回一个可选的小标数值Int?
1. firstIndex(of)
2. lastIndex(of)

// 返回一个可选的小标数值Int?
1. firstIndex(where)
2. lastIndex(where)

// min max返回一个最小 最大的可选的值 也可能返回nil
min 和Max在自定义类型的比较有min(where 闭包)  max(where)
array.min{a,b in a.0<b.0}
array.max{a,b in a.0<b.0}


// 添加和删除原始 和OC中NSMutableArray类似的
append:
append(contentsOf:)

// 插入元素的API
insert(value at:index)
insert(contentsOf at:index) //在指定的位置插入都个元素

注意字符串是一种Collection
字符串的每一个元素的类型是Character
我们可以把字符串转为[Character]类型的数组
然后操作这个[Character]的insert或者append等

// remove相关的API 都有返回值的
remove(at:)
removeFirst
removeLast 如果为空数组的话 他会报错 而pop不会报错
popFirst 移除并返回数组的第一个元素 optional。如果是一个空数组的情况 pop就会返回一个nil值的

removeFirst方法没有参数是移除单个元素
removeFirst方法是有参数是移除单个元素是对多个元素进行操作


// 其他操作多个元素相关的API
removeSubrange()
removeAll移除数组的所有元素
removeAll(keepingCapacity：true)  //不需要反复扩容 在移除清空后继续插入使用这个API更好的性能

```



## Array Slice

arraySlice的作用其实就是获取数组中的字数组 方便我们对数组继续操作?

```swift
数组切片的操作相关API
Array Slice和原数组是共享内存的 当改变切片的时候它会写时拷贝出来形成单独的内存
ArraySlice和Array拥有基本完全类似的API方法

// 如何得到一个ArraySlice<>
dropFirst(:) // 移除原来数组前指定个数的元素得到一个ArraySlice  如果不指定参数就去掉第一个
dropLast(:)  // 移除原来数组后面指定个数的元素得到一个ArraySlice 如果不指定参数就去掉最后一个  
drop(:) 可以传入一个条件的 // 特别注意这个drop是从第一个不符合条件开始移除 但是如果碰到符合的就会避免后面不符合判断条件的被drop掉⚠️

非常方便集合的处理和过滤条件


// 通过prefix方法得到ArraySlice
let array = [5, 2, 10, 1, 0, 100, 46, 99]
let s1 = array.prefix(4) // 得到前4个
let s2 = array.prefix(upTo: 4) //得到第3个下标为止的前4个数组元素组成的Slice
let s3 = array.prefix(through: 4) //包含索引值为4的值
print(array.prefix{$0 < 10})  // 通过闭包传入一个条件 到不符合条件的元素终止

// 使用Suffix  ArraySlice的获取
// 第四种方法得到ArraySlice的方法是通过Range得到

以后开发要兼容Array和ArraySlice两种类型参数都可以接受兼容的
```

ArraySlice的转换为Array类型的方法

> 不能直接赋值给数组变量 需要转为 Array(Slice)
>
> ArraySlice与原来的Array相互独立 添加或删除不会影响到对方的内容
>
> let array: Array<> =  Array(Slice) //利用初始化器来转化为Array类型的



## Swift中Array元素的随机化

```swift
shuffle()方法 在原数组打乱元素 //原地打乱
使用场景 音乐的随机播放功能 可以使用shuffle API来实现这个功能哦
shuffled()是可以作用在let常量或者变量上的 返回值是一个乱序的结果
因为shuffled()方法它不会改变原来的数组的内容

// 数组的逆序操作
reverse()在原来数组上将数组逆序 原地逆序
reversed() 返回原来数组的逆序 集合表示。这个方法不会分配新的内存空间。可以遍历 迭代器会用逆序方式返回
它只是返回了一个集合的表示 是抽象的返回的ReverseCollection<Array<>> 不会分配新内存，共用原来数组的空间



// 数组的分组操作 partition(by belongsInSecondPartition:   包括一个闭包)
let array = [5, 2, 10, 1, 0, 100, 46, 99]
var partitionTest = array

// 它是一个临界点 keyIndex和它之后下标的所有元素集是符合闭包中的条件的
let keyIndex = partitionTest.partition(by: {$0>30})
print(partitionTest[0..<keyIndex])
print(partitionTest[keyIndex...])

partition{闭包的内容} 返回一个index
前半部分返回不符合条件的集合
后半部分返回符合条件的集合
// 注意 这个方法是不是稳定的 它的顺序和原顺序会有所不同
排序算法的稳定性是什么概念 复习复习？

// swap交换数组当中的两个内容
swapAt(: :) 交换他们当中的值
```



## Array的排序

```swift
sort方法 原地排序的 只作用在数组变量当中// 这个排序方法 算法也不稳定的，当数组中多个相等值排序好不能保证原顺序
sorted()方法 返回一个排好序的数组，不改变方法调用者的内容的

array.swapAt(array.startIndex,  array.endIndex-1)
```





字符串的拼接操作

- joined()  类似NSArray拼接成字符串
- joined(separator: ) 类似NSArray拼接成字符串并在每个字符串间加入分隔符的
- joined() 还可以拼接数组里的所有元素为一个更大的Sequence
- joined(separator: ) 利用分隔符拼接数组里的所有元素为一个更大的Sequence

```c
// 研究源代码的时候 要学会看调用链

把顶层的设计画出来 结构理解清楚再去学代码的实现
  Array 首先是一个Sequence
  Array又是一个Collection
  Array的也是一个RangeReplaceableCollection
  
  Sequence协议里有一个Iterator的associatedtype
  
//  associatedtype？的作用是什么啊
  
  IteratorProtocol中也有associatedtype Element
  //mutating关键字是什么作用啊
```



## Set的基础

```swift
// hashable写法在swift 5版本中有改变的
但是Swift 5之前没有hasher这写法吗
hash(into: ) 的写法是什么意思

for-in循环的是无序的
// 常用的API
count
isEmpty
insert(_:)
update(with:)
filter{$0.age>18} //
removeFirst() //Set本身是无序的 但是移除的第一个是Hash序列的第一个
remove(:) //利用Hash找到匹配的元素 并且返回被删除的那个元素
removeAll()

//集合操作的常用API有
交集：intersection
并集：union
差集：symetricDifference //用并集-交集得到的结果
补集：substrating 相当于a-b的结果


// 常用的判断方法
isSuperset(of:)
isSubset(of:)
isStrictSubset(of:) isStrictSuperset(of:) // 是真子集  真超集 
isDisJoint  用来判断两个set是否有共有的元素 ⚠️没有公共元素才会返回true的

复习递归算法的实现思路！！！
两种方法实现Set查所有子集的算法
```



总结

复习Set的算法与底层实现的源码研究

2 学习字典的常用操作

3 理解字典底层的实现 Hashtable

开始Swift函数的学习
