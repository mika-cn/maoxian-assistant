
## 简介 {#intro}

为了更方便 MaoXian Web Clipper 用户在对网页进行 “裁剪” 之前执行一些操作，我们把「MaoXian 助手」集成到扩展中。该项目用于收集和分享各个用户编写的 “Plan”。

> **注：** MaoXian Web Clipper 已经支持记住选区功能，如果你只是懒的每次都点选，则记住选区功能会很适合你，推荐你前往扩展的设置页面开启试试。如果你想更好地控制你要裁剪的内容，或者遇到一些难搞的网页，那么请往下看 :)

## 项目地址 {#project-home}

* [传送门](https://github.com/mika-cn/maoxian-assistant)

## 背景 {#background}

由于 MaoXian Web Clipper 裁剪网页的时候，裁剪的是当前状态下的网页，并且不会保存任何脚本文件（即 javascript）。 这意味着在一些情况下，我们需要对网页进行一些操作后，才能获得一个较好的裁剪结果。比如： 一篇文章里的图片显示的都是缩略图，而你想保存的是原图；或者是你不想保存选区内的按钮、评论等无关内容；又或者是网页上的某些区域是可折叠的，需要在裁剪前把它们都展开。开发「MaoXian 助手」就是为了解决这些较常见的问题。

在集成「MaoXian 助手」之后，MaoXian Web Clipper 的裁剪流程也完整了起来。

```
准备 --> 选择 --> 裁剪 --> 存储
```

如上的四个步骤中，「MaoXian 助手」主要用于「准备」阶段，也涉及到「选择」阶段（不过不多）。它的工作方式有点像「广告屏蔽扩展」，需要针对不同的网站，编写不同的操作（在「MaoXian 助手里」我们称其为 Plan）。这也意味着它解决问题的多少取决于我们适配的网站的多少。


## 三种不同的 Plan {#three-type-of-plan}

**全局 Plan**

「全局 Plan」 是由你自己编写的。它会应用到所有的网页上，如果某个操作具备普遍性，则可以加入到「全局 Plan」里。

**自定义 Plan**

「自定义 Plan」也是由你自己编写的，它会应用到某一类网页上。此种为最常见的，一般都会对某个网站的某类网页进行裁剪。比如对某个博客的文章进行裁剪，因为同类网页的结构一般都相同，需要对其的操作也相同，所以可以通过编写此种 Plan 对其进行统一处理。

**公开的 Plan**

为了减少用户重复编写「自定义 Plan」的工作。MaoXian 支持你将自己编写的 「自定义 Plan」分享出来，成为 「公开的 Plan」。这样所有用户都会受益。 此种 Plan，可以通过下方的订阅地址获取到。


## 订阅「公开的 Plan」 {#public-subscriptions}

将下方的订阅地址复制到：_MaoXian 扩展 &gt; 设置页面 &gt; 助手_ 页面的订阅框中。

**订阅地址**

```shell
# 默认网站列表（全球性）
https://mika-cn.github.io/maoxian-web-clipper/assistant/plans/default/index.json

# 华人网站列表
https://mika-cn.github.io/maoxian-web-clipper/assistant/plans/zh/index.json

```


## 参与进来 {#get-involved}

「MaoXian 助手」的功能强大于否取决于我们适配的网站的多少。这需要的不仅仅是开发者，更是每一个使用者的无私分享精神，于此，我们欢迎各位用户参与进来，只有这般，该助手才能发挥其真正的能力。

如果你不会编程，你可以在项目 [issue 页面](https://github.com/mika-cn/maoxian-assistant/issues) 提交适配请求(提供需要适配的网址)，或者回馈某个网站适配不正确的信息，以便其他人进行跟进。

如果你会编程（只需要懂一点 CSS，了解 JSON 格式就行），那么恭喜你，你完全有能力编写 Plan，并分享给其他人，具体查看下一节。




## 如何编写 Plan {#how-to-write-a-plan}

### 流程 {#workflow}

1. 请到 MaoXian Web Clipper 的设置页面，启用「MaoXian 助手」
2. 使用任何编辑器编写 Plan， 再把其复制到 「MaoXian 助手」设置里的**自定义 Plan **里。
3. 刷新目标网页，点击「裁剪」验证编写的动作有没有产生预期效果。

### Plan 的结构解释 {#plan-structure}


| 参数名 | 类型 | 是否必填 | 备注 |
| -------- | -------- | -------- | -------- |
| name        | 字符串 | 必填 | 起标识作用，可随便填写，一般可以直接填写网站名         |
| pattern     | 字符串、元组 | 必填 | 匹配的模式，只有网址和模式匹配，该 plan 才会被应用           |
| excludePattern | 字符串、元组 | 选填 | 用于充当 pattern 的黑名单 |
| version     | 整型 | 必填 | 用于描述最后更新时间，格式为年月日，如：20190721 |
| contributors | 元组  | 选填 | 用于描述 plan 的作者和贡献者 |
| disabled    | 波尔值 | 选填 | 用于表示 plan 的禁用状态 |
| actions     | 元组   | 必填 | 用于描述要执行的动作 |
| tags        | 元组   | 选填 | 用于标注网站属性，使这些 plan 更好管理 |
| comment     | 字符串 | 选填 | 备注 |


### pattern 参数的使用 {#arg-pattern}

pattern 参数描述了该 Plan 会应用到哪一类网址上，如果网站有多个域名且很难用匹配符进行匹配，则可以提供多个 Pattern。

例如：

```json
{
  ...
  "pattern": [
    "https://a.com/article/*",
    "https://abcdefg.onion/article/*"
  ]
}
```

如果 pattern 所匹配的网址中有几个特殊项，则可以用 excludePattern 参数剔除。



目前支持的匹配符如下：

* 数字匹配符：`$d`
* 单星匹配符：`*`
* 双星匹配符：`**`


----------


**数字匹配符**

专门用于匹配数字，常用于匹配网址路径中的数字部分，只能完整匹配，无法作为前缀或者后缀去使用。

用例：

| 模式 | 网址 | 匹配 | 备注 |
| -------- | -------- | -------- | -------- |
| `https://example.org/post/$d/$d/$d/$d` | https://example.org/post/2019/07/21/003 | 能 |其中前三个 `$d` 分别匹配到 年，月，日。最后一个 `$d` 匹配到文章 ID，注意网址中的这四个部分全是数字。|
| `https://example.org/article-$d` | https://example.org/article-001 | 否 | 无法匹配到 `001` 因为这不是完整匹配 |


若要匹配部分，如匹配开头或结尾，则需要使用单星匹配符。


----------


**单星匹配符**

常用于匹配开头或结尾，相当于匹配零个或多个字符，也可匹配网址路径中的一个目录，但无法匹配多个目录。

用例：

| 模式 | 网址 | 匹配 | 备注 |
| -------- | -------- | -------- | -------- |
| `http*://example.org` | http://example.org | 是 | 匹配到零个字符 |
| `http*://example.org` | https://example.org | 是 | 匹配到 `s` |
| `https://*.example.org` | https://www.example.org | 是 | 匹配开头的子域名 `www` |
| `https://*.example.org` | https://foo.bar.example.org | 是 | 匹配开头的子域名 `foo.bar` |
| `https://a.org/*/index.html` | https://a.org/blog/index.html | 是 | 匹配到路径中的目录 `blog` |
| `https://a.org/*/index.html` | https://a.org/blog/jake/index.html | 否 | 无法匹配目录分隔符 `/`，即无法匹配多个目录 |


----------


**双星匹配符**

一般使用双星匹配符，来匹配零个或零个以上的目录。

用例：

| 模式 | 网址 | 匹配 | 备注 |
| -------- | -------- | -------- | -------- |
| `https://a.org/blog/**/*/*/*/*/*.html` | https://a.org/blog/javascript/2017/01/05/awesome-article.html | 是 | 中间用了四个 `*` 号来匹配分类和年月日，前面的 `**` 匹配可能存在的子分类 |
| `https://example.org/blog/**/*/$d/$d/$d/*.html` | https://a.org/blog/javascript/2017/01/05/awesome-article.html | 是 | 用了更严格的数字匹配符 |
| `https://example.org/blog/` | https://a.org/blog/javascript/2017/01/05/awesome-article.html | 是 | 注意：最后面的 `/`，匹配以该模式打头的网址，极宽松的模式 |

可以看到，对于同一个网址，可以使用不同的模式去匹配，严格程度不同，根据需求去选择即可。


----------


**匹配网址的查询参数部分（较少使用）**

一般匹配，只是匹配网址的查询参数能满足 Pattern 的参数部分。网址的参数数量可以多，顺序也可以不一致。

用例：

| 模式 | 网址 | 匹配 | 备注 |
| -------- | -------- | -------- | -------- |
| `https://a.org/page?id=*` | https://a.org/page?id=123 | 是 | 匹配到参数值 `123` |
| `https://a.org/page?id=*` | https://a.org/page?type=news&id=123 | 是 | 匹配到参数值`123`，即使有多个查询参数 |
| `https://a.org/page?type=news` | https://a.org/page?type=news&id=123 | 是 | 匹配到`type=news`，即使有多个查询参数 |


严格匹配， 表示网址的查询参数必须和 Pattern 的参数部分严格一致，数量不能多，不能少，但顺序可以不一致。 严格匹配需要在 Pattern 的参数部分的最前方加上 "!"。

用例：

| 模式 | 网址 | 匹配 | 备注 |
| -------- | -------- | -------- | -------- |
| `https://a.org/page?!foo=111&bar=222` | https://a.org/page?foo=111&bar=222 | 是 | 完美匹配 |
| `https://a.org/page?!foo=111&bar=222` | https://a.org/page?bar=222&foo=111 | 是 | 即使顺序不同也匹配 |
| `https://a.org/page?!foo=111&bar=222` | https://a.org/page?foo=111 | 否 | 查询参数的数量少了 `bar`
| `https://a.org/page?!foo=111&bar=222` | https://a.org/page?foo=111&bar=222&baz=333 | 否 | 查询参数的数量多了 `baz` |



### excludePattern 参数的使用 {#arg-excludePattern}

该参数用于作为 pattern 参数的黑名单，也可提供多个。用法请参考 [pattern 参数](#arg-pattern)

### disabled 参数的使用 {#arg-disabled}

disabled 参数用于表明该 plan 是否已禁用了。常用于「全局 plan」，或者是禁用某个「公开 plan」。比如你订阅的公开的 plan 列表里，有一个 plan 你不想使用。则可以把那个 plan 复制进 「自定义 plan」列表里，然后把它设为 `"disabled": true` ，就会把它禁用掉。

### actions 参数的使用 {#arg-actions}

actions 参数用于描述要执行的动作，结构如下


```json
{
  "name"
  "pattern": "https://example.org/post/*/*.html",
  "actions": [
    {"hide": ".ad"},
    {"hide": ".comment", "tag": "md-only"},
    {"pick": "article"}
  ]
}
```

上面这个 Plan，定义了三个 action，可以看出 action 的结构为 `{$actionName: $actionValue, [tag]}`。

tag 标注了这个 action 的使用条件。目前支持的选项有：

| 名字 | 效果 |
| -------- | -------- |
| disabled  | 禁用该 action |
| html-only | 只在存储格式为 html 时，才应用 |
| md-only   | 只在存储格式为 md 时，才应用 |


用于修改网页状态的动作如下：

| 动作名字 | 类型 | 备注 |
| -------- | -------- | -------- |
| show        | 选择器 | 用于显示隐藏的「块状节点」，可提供多个选择器，详情请看下文   |
| hide        | 选择器 | 用于选择「要剔除的节点」，可提供多个选择器，详情请看下文     |
| hideSibling | 选择器 | 用于选择「要剔除的节点」，可提供多个选择器，详情请看下文     |
| hideExcept  | 元组   | 用于选择「要剔除的节点」，选择方式为反选，详情请看下文       |
| chAttr      | 对象   | 用于修改节点的属性值，提供了多种修改属性的方式，详情请看下文 |


MaoXian 相关的动作如下：

| 参数名 | 类型 | 备注 |
| -------- | -------- | -------- |
| formula | 对象 | 用于标注公式 |
| pick 或 select | 选择器 | 用于选择「要裁剪的节点」，可提供多个选择器，详情请看下文 |
| confirm     | 选择器 | 用于选择「要裁剪的节点」，并确认，可提供多个选择器，详情请看下文 |
| clip        | 选择器 | 用于选择「要裁剪的节点」，并立即开始裁剪，可提供多个选择器，详情请看下文 |
| form        | 对象   | 用于预设置表单的输入值，详情见下文 |
| config      | 对象   | 用于重写某些配置项，详情见下文 |

#### 选择器 {#selector}


**选择器的格式**

选择器有两种：CSS 选择器 和 xPath 选择器。是一个字符串，格式为 `$type||$q` 。

| 变量 | 说明 | 值 |
| -------- | -------- | -------- |
| $type | 选择器的类型 | C 代表 CSS, X 代表 xPath |
| $q | 选择器 | CSS 选择器 或 xPath 选择器 |

其中 `$type||` 部分可省略，省略后的部分表示的是 CSS 选择器，大部分情况下我们都会用 CSS 选择器，除非一些很难用 CSS 选择器表示的，才会使用到 xPath 选择器。


下面我们来看一个例子（注： 本页面给出的例子都是 JSON 格式）

```json
{
  "name": "example.org",
  "version": 20190831,
  "pattern": "https://www.example.org/article/*",
  "actions": [
    {"hide": [
      "div.status-bar",
      "div.comment",
      "X||//span[text()='更多请关注']"
    ]},
    {"pick": "article"}
  ]
}
```

* hide 填入的是多个选择器，即给出的是一个 选择器的元组（数组）。最后一个选择器是 xPath 选择器，`X||` 部分不能省略。
* pick 填入的是一个选择器，此选择器是 CSS 选择器。其完整形式为 `C||article`，我们给出的是省略了 `C||` 后的部分。

#### show 动作的使用 {#action-show}

show 动作是用于显示「隐藏的块状节点」的，属性的值也是选择器（可填写多个），show 比较特殊，它**只可用于块状节点（即display 的值为 block）**。它会将节点的 display 样式设置成 block 来让这个节点显示出来. 它相对于后文会提到的 chAttr 动作比较简单，如果要操作的节点都为块状节点，则使用 show 会比较方便，否则，请考虑使用 chAttr 动作（具体查看 chAttr 的例4）

#### hide 动作的使用 {#action-hide}

hide 动作是用来剔除你不想裁剪的节点的，所有选择器找到的节点都会被隐藏掉（MaoXian 不会裁剪隐藏的节点）。

#### hideSibling 动作的使用 {#action-hideSibling}

hideSibling 动作是用来剔除你不想裁剪的节点的，它比 hide 动作特殊的地方在于， 所有选择器找到的节点必须具有一个特征：找到的节点在父节点的子节点中有且只有一个。找到的节点的兄弟姊妹节点都会被隐藏掉。 （MaoXian 不会裁剪隐藏的节点）。

#### hideExcept 动作的使用 {#action-hideExcept}

hideExcept 动作是使用「反选」的方式来选择要剔除的节点。它的值是一个 Object。有两个必须指定的属性：`inside` 和 `except`

* inside 属性的类型为选择器，用于指定该动作的作用范围。
* except 属性的类型为选择器，可提供多个选择器，用于指定要保留的节点。

假如有一个网页，它有如下结构：

```html
<div class="post">
  <div class="xxxxx">广告内容</div>
  <div class="post-header"><h1>文章标题</h1></div>
  <div class="post-content">文章内容</div>
  <div class="xxxxx">更多推荐</div>
</div>
```
且其中的「广告内容」和「更多推荐」的 class 属性的值是随机生成的，其位置随机出现。这个时候可以通过 hideExcept 参数来反选它们，如：

```json
{
  ...
  "actions": [
    {"hideExcept": {"inside": ".post", "except": [".post-header", ".post-content"]}}
  ]
}
```

该 Plan 会把 ".post" 选中到的节点内部的子节点进行隐藏，除了 ".post-header" 和 ".post-content" 指定的节点。（MaoXian 不会裁剪隐藏的节点）。



#### chAttr 动作的使用 {#action-chAttr}

chAttr 动作可以用来改变元素的属性的值。其值为一个 Object。

其中 pick 参数为必填，用于找到要操作的元素。而修改动作相关的其他参数，则比较特殊，支持两种结构。


如下：

当只需要对一个属性做修改，则用下面结构（注：所有参数位于同一级）：

```json
{
  ...
  "actions": [
    {
      "chAttr": {"pick": "_", "attr": "_", "type": "_", ...}
    }
  ]
}
```

当需要对多个属性做修改，则使用下面结构（注：和修改动作相关的参数，被 action 这个参数包住）：

```json
{
  ...
  "actions": [
    {
      "chAttr": {"pick": "_", "action": [ {"attr": "_", "type": "_", ...} ]}
    }
  ]
}
```



下面我们用一些常见的例子来说明 chAttr 的用法。

------------------------------

**例1.1**： 假设有一个网页，显示的是低质量的图，这些图的 `src` 属性是一个有规律的地址，比如： https://www.example.org/images/awesome-pic-small.jpg  ，而某些操作后，可能就变为 https://www.example.org/images/awesome-pic-big.jpg 。我们希望裁剪的是后者，而非前者，可以用下面这个 Plan 来实现：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": "img",
      "attr": "src",
      "type": "replace.last-match",
      "subStr": "small",
      "newStr": "big"
    }
  }]
}
```

上面 Plan 中的 chAttr 值的各个参数解读如下：

* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* type 的值为 **replace.last-match** ，表示要将**找到的节点的属性值的某个部分**，进行替换操作，只会替换最后一个匹配。
* subStr 的值为**要替换掉的那部分**，我们填入的是 small。
* newStr 的值是替换项，也就是说我们用 newStr 的值 big，替换 subStr 的值 small。


还有一种和这个类似的修改动作，它的 type 为 **replace.all** ，作用是替换所有找到的匹配，较少使用。 **replace.all** 也支持有多个替换项（即：`subStr` 和 `newStr` 都可以是数组）。替换规则为：如果 `newStr` 有和 `subStr` 对应的项，则使用对应的项，否则使用 `newStr` 的第一项。


例如： subStr 为 `["xm", "xxm"]`，newStr 为 `["xl", "xxl"]` 两个值一一对应，则会使用对应项。即 xm 会由 xl 替换， xxm 会由 xxl 替换。


例如： subStr 为 `["xm", "xxm"]`，newStr 为 `["xxl"]` ，其中 xxm 没有对应的替换值，则会使用第一项。即 xxm 也会由 xxl 替换。


**专门用于修改 URL 的修改动作**

比如上方的例1.1，也可以用下方的 Plan 来实现：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": "img",
      "attr": "src",
      "type": "url.file.set-name-suffix",
      "sep": "-",
      "suffix": "big",
      "whiteList": ["small", "big"]
    }
  }]
}
```

这个修改动作，会对 src 属性指定的 url 的文件名部分，设置后缀（在扩展名前面）。其中：

* sep 必填，表示分隔符，包含分隔符的文件名，会进行替换，不包含时进行添加。
* suffix 必填，要设置的后缀。
* whiteList 选填（但强烈建议填写），为后缀的可选值，该项表示：当文件名有这些后缀时，替换为 suffix 参数提供的值。若不填，则不判断直接替换。



如果要移除文件名后缀，则使用下方 Plan ：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "type": "url.file.rm-name-suffix",
      "attr": "src",
      "pick": "img",
      "sep": "-",
      "whiteList": ["small", "md"]
    }
  }]
}
```

参数比前一个 Plan 少了 suffix。其中：

* sep 必填，表示分隔符，包含分隔符的文件名，才删除后缀，不包含时，不删除后缀。
* whiteList 选填（但强烈建议填写），为后缀的可选值，该项表示：当文件名有这些后缀时，删除这些后缀。若不填，则不判断直接删除后缀。


**例1.2**：有些网站会在文件的扩展名后面加上后缀来区分不同的文件质量。如：


```html
<img src="assets/name.jpg!sm">
```


则可使用下方 Plan 进行设置：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": "img",
      "attr": "src",
      "type": "url.file.set-ext-suffix",
      "sep": "!",
      "suffix": "lg"
    }
  }]
}
```

若要移除，则使用：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": "img",
      "attr": "src",
      "type": "url.file.rm-ext-suffix",
      "sep": "!"
    }
  }]
}
```

注意： MaoXian 助手对于扩展名后缀的操作很粗暴。须确保 url 文件名中含有的分隔符确实为扩展名和后缀的分隔符，不然会出问题。


**例1.3**：有些网站还会把版本信息放在 url 的查询参数中，如：

```html
<img src="http://a.org/name.jpg?size=sm&from=google">
```

遇到这种，可使用下方 Plan：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "type": "url.search.edit",
      "pick": "img",
      "attr": "src",
      "change": {"size": "lg"},
      "delete": ["from"]
    }
  }]
}
```

其中：

* change 为要设置的参数。
* delete 为要移除的参数名。

上面这个 plan 应用后， src 属性的值为： "http://a.org/name.jpg?size=lg"

------------------------------



**例2**： 假设有一个网页，显示的是低质量的图，它的高质量图片地址，放在了 img 标签的另一个属性上。图片的 html 如下：

```html
<img src="/image/pic-abc.jpg" hq-src="/image/pic-bdf.jpg" />
```
我们要裁剪的是 hq-src 指定的那张图片，使用下面这个 Plan 实现：


```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": "img",
      "attr": "src",
      "type": "assign.from.self-attr",
      "tAttr": "hq-src"
    }
  }]
}
```
* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* type 为 **assign.from.self-attr** ，它表明我们要用**找到节点的另一个属性的值**，来重写 attr 指定的属性。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用 hq-src 属性重写 src 属性。



------------------------------


**例3.1**： 假设有一个网页，显示的是低质量的图，并且这些图片本身是一个链接，可以通过点击图片查看原图， 图片的 html 如下：

```html
<a href="/image/awesome-pic-bdf.jpg" >
  <img src="/image/pic-abc.jpg" />
</a>
```
我们要裁剪的是 a 标签 href 指定的那张图片，使用下面这个 Plan 实现：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": "img",
      "attr": "src",
      "type": "assign.from.parent-attr",
      "tAttr": "href"
    }
  }]
}
```

* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是图片的 src 属性。
* type 为 **assign.from.parent-attr** ，它表明我们要用找到节点的 **父节点** 的一个属性的值，来重写 attr 指定的属性。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用父节点的 href 属性重写图片的 src 属性。




**例3.2**: 假如和 例3.1 类似，但是原图的链接不在父节点，而是在祖先节点，HTML 如下：

```html
<a href="/image/awesome-pic-bdf.jpg" >
  <div class="wrapper">
    <img src="/image/pic-abc.jpg" />
  <div>
</a>
```

我们要裁剪的是 a 标签 href 指定的那张图片，使用下面这个 Plan 实现：

```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": "img",
      "attr": "src",
      "type": "assign.from.ancestor-attr",
      "tElem": ["a"],
      "tAttr": "href"
    }
  }]
}
```

* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是图片的 src 属性。
* type 为 **assign.from.ancestor-attr** ，它表明我们要用找到节点的 **祖先节点** 的一个属性的值，来重写 attr 指定的属性。
* tElem 的值为目标元素（target element）的选择器，此例子中，我们选中了 a 标签。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用祖先节点的 href 属性重写图片的 src 属性。


**注意**  tElem 的值比较特殊，如下：

* 必须是一个选择器元祖（数组），而且选择器的个数为 1 ~ 2 个。
* 选择器只能是 CSS 选择器。
* 第一个选择器用于匹配祖先节点
* 第二个选择器用于选择祖先节点的内部节点，只有当第一个选择器无法确定目标节点时，才需要提供。（极少使用到）


还有一种 和 **assign.from.ancestor-attr** 相似的类型为： **assign.from.ancestor.child-attr** ， 此种类型也需要提供 tElem ，且需要提供两个选择器。拿到的目标节点为祖先节点的后代节点。



------------------------------


**例4**： 除了上面这几种动作, chAttr 还对 class 属性的修改做了支持。请看下方 Plan:

```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": ".section",
      "attr": "class",
      "type": "split2list.remove",
      "value": "folded",
      "sep": " "
    }
  }]
}
```

* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有包含类名为 section 的标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 class 属性。
* type 为 **split2list.remove** ，它表明我们要用操作的属性具有的值比较特殊，可以通过某个分隔符分成多个部分，该类型表明要移除其中一部分。
* value 为要移除的那部分，可移除多个值（如：`"value": ["a", "b", "c"]`）
* sep 为分隔符

还有一种修改动作, 跟该例子类似，它的类型为 **split2list.add**，该类型表明要往属性里面添加一项。

一般可以使用这两种动作，对网页折叠部分进行控制，使其达到我们想要的状态。这种方式不像上文的 show 参数那样粗暴地对 display 进行操控。


------------------------------


**例5**： 这种可能不常见，即直接修改属性的值


```json
{
  ...
  "actions": [{

    "chAttr": {
      "pick": ".formula",
      "attr": "type",
      "type": "assign.from.value",
      "value": "image/svg",
    }
  }]
}
```

上面的例子会把 “type” 属性的值设置为 “image/svg”。

#### formula 动作的使用 {#action-formula}

该动作用于创建一个叫做 `<mx-inline-formula>` 或 `<mx-block-formula>` 的标签来标记公式，并把原标签标记为忽略。

例如：

某个网页渲染数学公式的时候，为了兼容所有浏览器，使用了图片的形式，同时又保存其 Latex 公式，如下：

```html
<img src="formula.png" data-formula="x^2+y^2">
```

我们在裁剪成 Markdown 格式时，完全没有必要保存这个图片，只需要保存这个 `data-formula` 属性的公式即可。

使用下方 Plan：

```json
{
  ...
  "actions": [
    {
      "formula": {"pick": "img", "attr": "data-formula"},
      "tag": "md-only"
    }
  ]
}
```

* pick 的值为选择器，此例选中了所有 `<img>` 元素
* attr 包含数学公式的属性名。

若该 `<img>` 标签是『块状公式』（独占一行）， 应用该 Plan 后的 HTML 如下：

```HTML
<mx-block-formula value="x^2+y^2"></mx-block-formula>
<img src="formula.png" data-formula="x^2+y^2" data-mx-ignore="1">
```

若该 `<img>` 标签是『行内公式』（和其他文字在同一行）， 应用该 Plan 后的 HTML 如下：

```HTML
<mx-inline-formula value="x^2+y^2"></mx-inline-formula>
<img src="formula.png" data-formula="x^2+y^2" data-mx-ignore="1">
```

可以看到原来的 `<img>` 标签被标记了 `data-mx-ignore` 属性，标记后 MaoXian 会忽略该标签。

在没有 `block` 参数的时候，formula 动作会自动根据选中元素的样式，决定是『块状公式』还是『行内公式』。
你也可以通过 `block` 参数直接指定。

比如下方 plan 直接指定了『块状公式』

```json
{
  ...
  "actions": [
    {
      "formula": {"pick": "img", "attr": "data-formula", block: true},
      "tag": "md-only"
    }
  ]
}
```



#### pick 或 select 动作的使用 {#action-pick}

该动作选中要裁剪的节点。找到第一个匹配的节点就停止查找，如果你填写了多个选择器，则会按照选择器的顺序依次查找，也是找到第一个即停止。

**注：该动作在『全局 Plan 』中无效**

#### confirm 动作的使用 {#action-confirm}

该动作选中要裁剪的节点，并进行确认，执行完，会到填写表单那一步。找到第一个匹配的节点就停止查找，如果你填写了多个选择器，则会按照选择器的顺序依次查找，也是找到第一个即停止。

**注：该动作在『全局 Plan 』中无效**

#### clip 动作的使用 {#action-clip}

该动作选中要裁剪的节点，并立即自动进行裁剪。找到第一个匹配的节点就停止查找，如果你填写了多个选择器，则会按照选择器的顺序依次查找，也是找到第一个即停止。

**注：该动作在『全局 Plan 』中无效**


#### form 动作的使用 {#action-form}

用于预设置表单的输入值，MaoXian 会在显示表单的时候，自动帮你输入这些预设的值，都为选填。

**注：该动作在『全局 Plan 』中无效**

详情如下：

| 名字     | 类型     | 说明     | 默认值   |
| -------- | -------- | -------- | -------- |
| title    | 选择器   | 用于选中包含标题的元素 | 无 |
| category | 字符串   | 对应表单的目录（多级目录用 `/` 隔开） | 取决于你的设置（见扩展设置页面） |
| tagstr   | 字符串   | 对应表单的标签（多个标签用 `,` 或 `空格` 隔开)  | 无  |

**主要应用场景：**

* 通过设置 title 来解决网页标题和内容标题不一致的问题（MaoXian 默认会使用网页的标题作为表单的标题输入值）。
* 通过设置 category 来为不同的网站的网页设置不同的默认分类。
* 通过设置 tagstr 来为不同的网站的网页，打上不同的默认标签。

例子：

请注意 `title` 的值是一个选择器，此例选中 `main h1` 对应的标题来作为『保存表单』的标题。

```json
{
  ...
  "actions": [{

    "form": {
      "title": "main h1",
      "category": "news/read-later",
      "tagstr": "international,freedom-news"
    }
  }]
}
```

#### config 动作的使用 {#action-config}

重写某些配置项，并且重写的这个动作只在这个 Plan 的作用范围内有效。

**注：该动作在『全局 Plan 』中无效**

当前允许重写的配置项如下，所有可配置项均为选填。注： 其中的默认值指的是 MaoXian 扩展提供的默认值，该值只作为参考，实际上使用的是你自己配置页面上的值。

##### 存储相关 {#config-storage}

可在扩展的 `扩展 > 设置页面 > 存储设置` 一节找到可使用的变量及其说明。


| 名字               | 说明                     | 类型     | 默认值                     |
| --------           | --------                 | -------- | --------                   |
| clippingHandler    | 处理程序                 | String   | Browser                    |
| saveFormat         | 保存格式                 | String   | html                       |
| rootFolder         | 根目录                   | String   | mx-wc                      |
| defaultCategory    | 默认分类                 | String   | default                    |
| clippingFolderName | 裁剪目录                 | String   | $YYYY-$MM-$DD-$TIME-INTSEC |
| mainFileFolder     | 主文件的存储目录         | String   | $CLIPPING-PATH             |
| mainFileName       | 主文件的文件名           | String   | index.$FORMAT              |
| saveInfoFile       | 是否保存元信息文件       | Boolean  | true                       |
| infoFileFolder     | 元信息文件的存储目录     | String   | $CLIPPING-PATH             |
| infoFileName       | 元信息文件的文件名       | String   | index.json                 |
| saveTitleFile      | 是否保存标题文件         | Boolean  | true                       |
| titleFileFolder    | 标题文件的存储目录       | String   | $CLIPPINT-PATH             |
| titleFileName      | 标题文件的文件名         | String   | a-title_$TITLE             |
| frameFileFolder    | 内嵌的网页文件的存储目录 | String   | $CLIPPING-PATH/frames      |
| frameFileName      | 内嵌的网页文件的文件名   | String   | $TIME-INTSEC-$MD5URL.frame.html |
| assetFolder        | 资源文件的存储目录       | String   | $CLIPPING-PATH/assets      |
| assetFileName      | 资源文件的文件名         | String   | $TIME-INTSEC-$MD5URL$EXT   |


**备注**：

* clippingHandler （处理程序）的可选值为 `Browser`（浏览器下载功能） 和 `NativeApp` （本地程序）
* saveFormat （保存格式）的可选值为 `html` 或 `md`
* saveInfoFile（是否保存元信息文件） 设置为 `false` 后，MaoXian 便不会保存裁剪历史。



##### Markdown 文档相关 {#config-markdown}

请参考 `扩展 > 设置 > Markdown` 的说明文字进行配置。


| 名字                           | 说明               | 类型     | 默认值            | 可选值                    |
| --------                       | --------           | -------- | --------          | --------                  |
| markdownTemplate               | Markdown 模板      | String   | `\n{{content}}\n` |                           |
| markdownOptionHeadingStyle     | 标题格式           | String   | `atx`             | `setext` 或 `atx`         |
| markdownOptionHr               | 水平分割线         | String   | `* * *`           | `* * *` 或 `- - -` 等等   |
| markdownOptionBulletListMarker | 子弹列表的行头符   | String   | `*`               | `*`，`+` 或 `-`           |
| markdownOptionCodeBlockStyle   | 代码块格式         | String   | `fenced`          | `indented` 或 `fenced`    |
| markdownOptionFence            | 代码块分隔符       | String   | <code>```</code>  | <code>```</code> 或 `~~~` |
| markdownOptionEmDelimiter      | 强调（斜体）分隔符 | String   | `_`               | `_` 或 `*`                |
| markdownOptionStrongDelimiter  | 加重（粗体）分隔符 | String   | `**`              | `**` 或 `__`              |
| markdownOptionLinkStyle        | 链接格式           | String   | `inlined`         | `inlined` 或 `referenced` |
| markdownOptionFormulaBlockWrapper | 块状公式的格式  | String   | `padSameLine`     | `sameLine`, `padSameLIne`, `multipleLine` 或 `mathCodeBlock` |


**备注**：

* markdownOptionHr （水平分割线）可填写的值很灵活，具体查看这里 [Thematic break](https://spec.commonmark.org/0.27/#thematic-breaks)



##### HTML 文档相关 {#config-html}

请参考 `扩展 > 设置 > HTML` 的说明文字进行配置。



| 名字 | 说明 | 类型 | 默认值 | 可选值 |
| -------- | -------- | -------- | -------- | -------- |
| htmlSaveClippingInformation | 追加裁剪信息到内容尾部 | Boolean | `false` | `false`、 `true` |
| htmlCustomBodyBgCssEnabled | 允许自定义 body 标签的 CSS 背景颜色 | Boolean | `false` | `false`、 `true` |
| htmlCustomBodyBgCssValue | body 标签的 CSS 背景颜色 | String | `#000000` | 查看 background-color (CSS) |
| htmlCompressCss | 压缩样式（CSS） |  Boolean | `false` | `false`、`true` |
| htmlCaptureImage | 图片 | String | `saveAll` | `saveAll`、`saveCurrent` |
| htmlCaptureAudio | 声音 | String | `remove` | `saveAll` 、`saveCurrent`、 `remove` |
| htmlCaptureVideo | 影片 | String | `remove` |  `saveAll`、 `saveCurrent`、 `remove` |
| htmlCaptureApplet | Applets | String | `remove` | `saveAll`、 `remove` |
| htmlCaptureEmbed | Embeds | String | `saveImage` | `saveAll`、 `saveImage`、 `remove`、 `filter` |
| htmlCaptureObject | Objects | String | `saveImage` | `saveAll`、 `saveImage`、 `remove`、 `filter` |
| htmlCaptureIcon | 网站图标 | String | `remove` | `saveAll`、 `saveFavicon`、 `remove` |
| htmlCaptureCssRules | 样式规则 | String | `saveUserd` | `saveAll`、 `saveUserd` |
| htmlCaptureWebFont | Web 字体 | String | `remove` | `saveAll`、 `remove`、 `filterList` |
| htmlCaptureCssImage | 样式图片 | String | `remove` | `saveAll`、 `remove` |
| htmlEmbedFilter | Embeds 过滤器 | String | `<images>` | - |
| htmlObjectFilter | Objects 过滤器 | String | `<images>` | - |
| htmlWebFontFilterList | Web 字体过滤器组 | String | `woff2|woff|otf|ttf` | - |


##### Web 请求相关 {#config-web-request}

请参考 `扩展 > 设置 > 高级设置` 的说明文字进行配置。


| 名字 | 说明 | 类型 | 默认值 | 可选值 |
| -------- | -------- | -------- | -------- | -------- |
| requestTimeout | 超时（秒） | Integer | 300 | 5 ~ 86400 |
| requestMaxTries | 最大尝试次数 | Integer | 3 | 大于1的整数 |
| requestReferrerPolicy | Referrer 请求头 | String | `originWhenCrossOrigin` | `noReferrer`、 `origin`、 `originWhenCrossOrigin`、 `unsafeUrl` |



### tags 参数的使用 {#arg-tags}

虽然 Plan 的 tags 属性是非必须的，但还是建议你为 Plan 打上标签，以便后期，我们能更好地管理他们。

## 贡献 Plan {#contribution}

所有的 Plan 都存储在 `plans` 的子目录下，不同的子目录代表不同频道，每个频道最终都将生成一个订阅地址。请将你写的 Plan 以数组的形式单独存为一个文件，如： `plans/zh/zhihu.json`。每个网站建一个文件。

最终所有的 Plan 会在 `build.rb` 这个脚本的渲染下，变成可订阅的形式。

你可以通过下方几种方式把 plan 分享出来：

* 通过 Github 建 Pull Request 的形式。
* 通过 Github 建 issue。（把 plan 贴上即可）
* 通过发邮件给开发者（i.mika[AT]tutanota.com），直接发送内容或者发送 patch。


## 最后 {#last-word}

如果你对「毛线助手」有什么看法或建议，请[告诉我们](https://github.com/mika-cn/maoxian-assistant/issues)。

[首页](../index-zh-CN.html)

