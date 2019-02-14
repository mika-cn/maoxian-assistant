
# 毛线助手

为了更方便 MaoXian Web Clipper 用户在对网页进行 “裁剪” 之前执行一些操作，我们把「MaoXian 助手」集成到扩展中。该项目用于收集和分享各个用户编写的 “Plan”。

> **注：** MaoXian Web Clipper 已经支持记住选区功能，如果你只是懒的每次都点选，则记住选区功能会很适合你，推荐你前往扩展的设置页面开启试试。如果你想更好地控制你要裁剪的内容，或者遇到一些难搞的网页，那么请往下看 :)

## 项目地址

* [传送门](https://github.com/mika-cn/maoxian-assistant)

## 背景

由于 MaoXian Web Clipper 裁剪网页的时候，裁剪的是当前状态下的网页，并且不会保存任何脚本文件（即 javascript）。 这意味着在一些情况下，我们需要对网页进行一些操作后，才能获得一个较好的裁剪结果。比如： 一篇文章里的图片显示的都是缩略图，而你想保存的是原图；或者是你不想保存选区内的按钮、评论等无关内容；又或者是网页上的某些区域是可折叠的，需要在裁剪前把它们都展开。开发「MaoXian 助手」就是为了解决这些较常见的问题。

在集成「MaoXian 助手」之后，MaoXian Web Clipper 的裁剪流程也完整了起来。

```
准备 --> 选择 --> 裁剪 --> 存储
```

如上的四个步骤中，「MaoXian 助手」主要用于「准备」阶段，也涉及到「选择」阶段（不过不多）。它的工作方式有点像「广告屏蔽扩展」，需要针对不同的网站，编写不同的操作（在「MaoXian 助手里」我们称其为 Plan）。这也意味着它解决问题的多少取决于我们适配的网站的多少。


## 三种不同的 Plan

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


## 参与进来

「MaoXian 助手」的功能强大于否取决于我们适配的网站的多少。这需要的不仅仅是开发者，更是每一个使用者的无私分享精神，于此，我们欢迎各位用户参与进来，只有这般，该助手才能发挥其真正的能力。

如果你不会编程，你可以在项目 [issue 页面](https://github.com/mika-cn/maoxian-assistant/issues) 提交适配请求(提供需要适配的网址)，或者回馈某个网站适配不正确的信息，以便其他人进行跟进。

如果你会编程（只需要懂一点 CSS，了解 JSON 格式就行），那么恭喜你，你完全有能力编写 Plan，并分享给其他人，具体查看下一节。




## 如何编写 Plan {#how-to-write-a-plan}

### 流程

1. 请到 MaoXian Web Clipper 的设置页面，启用「MaoXian 助手」
2. 使用任何编辑器编写 Plan， 再把其复制到 「MaoXian 助手」设置里的**自定义 Plan **里。
3. 刷新目标网页，点击「裁剪」验证编写的动作有没有产生预期效果。

### Plan 的结构解释


| 参数名 | 类型 | 是否必填 | 备注 |
| -------- | -------- | -------- | -------- |
| name        | 字符串 | 必填 | 起标识作用，可随便填写，一般可以直接填写网站名         |
| pattern     | 字符串 | 必填 | 匹配的模式，只有网址和模式匹配，该 plan 才会被应用           |
| excludePattern | 字符串 | 选填 | 用于充当 pattern 的黑名单 |
| version     | 整型 | 必填 | 用于描述最后更新时间，格式为年月日，如：20190721 |
| contributors | 元组  | 选填 | 用于描述 plan 的作者和贡献者 |
| disabled    | 波尔值 | 选填 | 用于表示 plan 的禁用状态 |
| pick        | 选择器 | 选填 | 用于选择「要裁剪的节点」，可提供多个选择器，详情请看下文     |
| hide        | 选择器 | 选填 | 用于选择「要剔除的节点」，可提供多个选择器，详情请看下文     |
| hideSibling | 选择器 | 选填 | 用于选择「要剔除的节点」，可提供多个选择器，详情请看下文     |
| hideExcept  | 元组   | 选填 | 用于选择「要剔除的节点」，选择方式为反选，详情请看下文       |
| show        | 选择器 | 选填 | 用于显示隐藏的「块状节点」，可提供多个选择器，详情请看下文   |
| chAttr      | 元组   | 选填 | 用于修改节点的属性值，提供了多种修改属性的方式，详情请看下文 |
| form        | 对象   | 选填 | 用于预设置表单的输入值，详情见下文 |
| config      | 对象   | 选填 | 用于重写某些配置项，详情见下文 |
| tags        | 元祖   | 选填 | 用于标注网站属性，使这些 plan 更好管理 |
| comment     | 字符串 | 选填 | 备注 |


### Pattern 参数的使用

Pattern 参数描述了该 Plan 会应用到哪一类网址上，如果网站有多个域名且很难用匹配符进行匹配，则可以提供多个 Pattern，例如：`["https://a.com/article/*", "https://abcdefg.onion/article/*"]`。

目前支持的匹配符有数字匹配符 "`$d`" 和 星匹配符 "`*`" 和 "`**`"。

**数字匹配符**

数字匹配符专门用于匹配数字，常用于匹配网址路径中的数字部分。

比如： 使用 `https://example.org/post/$d/$d/$d/$d` 可以匹配到 https://example.org/post/2019/07/21/003 。其中前三个 `$d` 分别匹配到 年，月，日。最后一个 `$d` 匹配到文章 ID，注意网址中的这四个部分全是数字。

数字匹配符只能完整匹配，无法作为前缀或者后缀去使用。

比如： 使用 `https://example.org/article-$d` 是无法匹配到 https://example.org/article-001 的。

如果要匹配前缀和后缀，则需要使用星匹配符。


**星匹配符**

* 匹配开头

比如：匹配子域名，`*.example.org` 可匹配任何以 "example.org" 结尾的域名，例如： www.example.org，foo.bar.example.org。

* 匹配结尾

比如：匹配网址协议，`http*` 即可以匹配到 http 也可以匹配到 https。

* 匹配整个部分，常用于匹配网址路径的一个目录。

比如：使用 `https://example.org/*/index.html`，可以匹配到 https://example.org/blog/index.html 。但是无法匹配到 https://example.org/blog/jack/index.html ，因为 "*" 号不匹配目录分隔符 "/"。

**双星匹配符**

一般使用双星匹配符，来匹配零个或零个以上的目录。

假如我们要匹配的网址为 https://example.org/blog/javascript/2017/01/05/awesome-article.html ，里面 /blog 为固定不变的部分，/javascript 为文章分类（不知道有没有子分类），后面是年月日，最后是文章名。

可以用 `https://example.org/blog/**/*/*/*/*/*.html`这个 Pattern 来匹配。 中间用了四个 "*" 号来匹配分类和年月日，前面的 "**" 匹配可能存在的子分类。也可以用 `https://example.org/blog/**/*/$d/$d/$d/*.html` 来进行匹配。

上面这个例子也可以使用 `https://example.org/blog/` （注意：最后面的 "/"） 作为 Pattern ，来直接匹配以该模式打头的网址，不同的 Pattern，严格程度不同，根据需求给出 Pattern 即可。


**匹配网址的查询参数部分（较少使用）**

* 一般匹配

一般匹配只是匹配网址的查询参数能满足 Pattern 的参数部分。网址的参数数量可以多，顺序也可以不一致。


例如：使用 `https://a.org/page?id=*` 这个 Pattern，可以匹配到 https://a.org/page?id=123 ，也可以匹配到 https://a.org/page?type=news&id=456 。当然了，你也可以进一步匹配参数值，如： `https://a.org/page?type=news` 这个 Pattern 。

* 严格匹配

严格匹配表示网址的查询参数必须和 Pattern 的参数部分严格一致，数量不能多，不能少，但顺序可以不一致。 严格匹配需要在 Pattern 的参数部分的最前方加上 "!"。

例如：使用 `https://a.org/page?!foo=111&bar=222` 这个 Pattern，只能匹配到 https://a.org/page?foo=111&bar=222 和 https://a.org/page?foo=222&bar=111 。但不能匹配到 https://a.org/page?foo=111 或 https://a.org/page?foo=111&bar=222&baz=333。

### disabled 参数的使用

disabled 参数用于表明该 plan 是否已禁用了。常用于「全局 plan」，或者是禁用某个「公开 plan」。比如你订阅的公开的 plan 列表里，有一个 plan 你不想使用。则可以把那个 plan 复制进 「自定义 plan」列表里，然后把它设为 `"disabled": true` ，就会把它禁用掉。


### 选择器


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
  "pick": "article",
  "hide": [
    "div.status-bar",
    "div.comment",
    "X||//span[text()='更多请关注']"
  ]
}
```

* pick 填入的是一个选择器，此选择器是 CSS 选择器。其完整形式为 `C||article`，我们给出的是省略了 `C||` 后的部分。
* hide 填入的是多个选择器，即给出的是一个 选择器的元组（数组）。最后一个选择器是 xPath 选择器，`X||` 部分不能省略。

### pick 参数的使用

pick 参数用于选中要裁剪的节点。找到第一个匹配的节点就停止查找，如果你填写了多个选择器，则会按照选择器的顺序依次查找，也是找到第一个即停止。注意： 「全局 Plan」会忽略该参数。

### hide 参数的使用

hide 参数是用来剔除你不想裁剪的节点的，所有选择器找到的节点都会被隐藏掉（MaoXian 不会裁剪隐藏的节点）。

### hideSibling 参数的使用

hideSibling 参数是用来剔除你不想裁剪的节点的，它比 hide 参数特殊的地方在于， 所有选择器找到的节点必须具有一个特征：找到的节点在父节点的子节点中有且只有一个。找到的节点的兄弟姊妹节点都会被隐藏掉。 （MaoXian 不会裁剪隐藏的节点）。

### hideExcept 参数的使用

hideExcept 参数是使用「反选」的方式来选择要剔除的节点。它的值是一个 $action 的元组，$action 是一个 Object。$action 有两个必须指定的属性：`inside` 和 `except`

* inside 属性的类型为选择器，用于指定该 $action 作用的范围。
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
  "hideExcept": [
    {"inside": ".post", "except": [".post-header", ".post-content"]}
  ]
}
```

该 Plan 会把 ".post" 选中到的节点内部的子节点进行隐藏，除了 ".post-header" 和 ".post-content" 指定的节点。（MaoXian 不会裁剪隐藏的节点）。


### show 参数的使用

show 参数是用于显示「隐藏的块状节点」的，属性的值也是选择器（可填写多个），show 比较特殊，它**只可用于块状节点（即display 的值为 block）**。它会将节点的 display 样式设置成 block 来让这个节点显示出来. 它相对于后文会提到的 chAttr 参数比较简单，如果要操作的节点都为块状节点，则使用 show 会比较方便，否则，请考虑使用 chAttr 参数（具体查看 chAttr 的例4）

### chAttr 参数的使用

chAttr 参数可以用来改变标签的某个属性的值。chAttr 是一个可选项，只有在需要的时候，才需要提供。 chAttr 的值为一个 $action 的元组，$action 是一个 Object。$action 的常用参数有三个 `type`, `pick` 和 `attr`。不同的 `type` 会跟不同的的参数。下面我们用一些常见的例子来说明 chAttr 的用法。

------------------------------

**例1.1**： 假设有一个网页，显示的是低质量的图，这些图的 `src` 属性是一个有规律的地址，比如： https://www.example.org/images/awesome-pic-small.jpg  ，而某些操作后，可能就变为 https://www.example.org/images/awesome-pic-big.jpg 。我们希望裁剪的是后者，而非前者，可以用下面这个 Plan 来实现：

```json
{
  ...
  "chAttr": [
    {
      "type": "replace.last-match",
      "pick": "img",
      "attr": "src",
      "subStr": "small",
      "newStr": "big"
    }
  ]
}
```

上面 Plan 中的 chAttr 参数的值是一个数组，里面包含了一个 $action，它的各个属性解读如下：

* type 的值为 **replace.last-match** ，表示这个 $action 是将**找到的节点的属性值的某个部分**，进行替换操作，只会替换最后一个匹配。
* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* subStr 的值为**要替换掉的那部分**，我们填入的是 small。
* newStr 的值是替换项，也就是说我们用 newStr 的值 big，替换 subStr 的值 small。


还有一种和这个类似的 $action，它的 type 为 **replace.all** ，作用是替换所有找到的匹配，较少使用。 **replace.all** 也支持有多个替换项（即：`subStr` 和 `newStr` 都可以是数组）。替换规则为：如果 `newStr` 有和 `subStr` 对应的项，则使用对应的项，否则使用 `newStr` 的第一项。


例如： subStr 为 `["xm", "xxm"]`，newStr 为 `["xl", "xxl"]` 两个值一一对应，则会使用对应项。即 xm 会由 xl 替换， xxm 会由 xxl 替换。


例如： subStr 为 `["xm", "xxm"]`，newStr 为 `["xxl"]` ，其中 xxm 没有对应的替换值，则会使用第一项。即 xxm 也会由 xxl 替换。


**专门用于修改 URL 的 $action**

比如上方的例1.1，也可以用下方的 Plan 来实现：

```json
{
  ...
  "chAttr": [
    {
      "type": "url.file.set-name-suffix",
      "pick": "img",
      "attr": "src",
      "sep": "-",
      "suffix": "big",
      "whiteList": ["small", "big"]
    }
  ]
}
```

这个 $action 会对 src 属性指定的 url 的文件名部分，设置后缀（在扩展名前面）。其中：

* sep 必填，表示分隔符，包含分隔符的文件名，会进行替换，不包含时进行添加。
* suffix 必填，要设置的后缀。
* whiteList 选填（但强烈建议填写），为后缀的可选值，该项表示：当文件名有这些后缀时，替换为 suffix 参数提供的值。若不填，则不判断直接替换。



如果要移除文件名后缀，则使用下方 Plan ：

```json
{
  ...
  "chAttr": [
    {
      "type": "url.file.rm-name-suffix",
      "pick": "img",
      "attr": "src",
      "sep": "-",
      "whiteList": ["small", "md"]
    }
  ]
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
  "chAttr": [
    {
      "type": "url.file.set-ext-suffix",
      "pick": "img",
      "attr": "src",
      "sep": "!",
      "suffix": "lg"
    }
  ]
}
```

若要移除，则使用：

```json
{
  ...
  "chAttr": [
    {
      "type": "url.file.rm-ext-suffix",
      "pick": "img",
      "attr": "src",
      "sep": "!"
    }
  ]
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
  "chAttr": [
    {
      "type": "url.search.edit",
      "pick": "img",
      "attr": "src",
      "change": {"size": "lg"},
      "delete": ["from"]
    }
  ]
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
  "chAttr": [
    {
      "type": "assign.from.self-attr",
      "pick": "img",
      "attr": "src",
      "tAttr": "hq-src"
    }
  ]
}
```
* type 为 **assign.from.self-attr** ，它表明我们要用**找到节点的另一个属性的值**，来重写 attr 指定的属性。
* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
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
  "chAttr": [
    {
      "type": "assign.from.parent-attr",
      "pick": "img",
      "attr": "src",
      "tAttr": "href"
    }
  ]
}
```

* type 为 **assign.from.parent-attr** ，它表明我们要用找到节点的 **父节点** 的一个属性的值，来重写 attr 指定的属性。
* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是图片的 src 属性。
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
  "chAttr": [
    {
      "type": "assign.from.ancestor-attr",
      "pick": "img",
      "attr": "src",
      "tElem": ["a"],
      "tAttr": "href"
    }
  ]
}
```

* type 为 **assign.from.ancestor-attr** ，它表明我们要用找到节点的 **祖先节点** 的一个属性的值，来重写 attr 指定的属性。
* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是图片的 src 属性。
* tElem 的值为目标元素（target element）的选择器，此例子中，我们选中了 a 标签。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用祖先节点的 href 属性重写图片的 src 属性。


**注意**  tElem 的值比较特殊，如下：

* 必须是一个选择器元祖（数组），而且选择器的个数为 1 ~ 2 个。
* 选择器只能是 CSS 选择器。
* 第一个选择器用于匹配祖先节点
* 第二个选择器用于选择祖先节点的内部节点，只有当第一个选择器无法确定目标节点时，才需要提供。（极少使用到）


还有一种 和 **assign.from.ancestor-attr** 相似的类型为： **assign.from.ancestor.child-attr** ， 此种类型也需要提供 tElem ，且需要提供两个选择器。拿到的目标节点为祖先节点的后代节点。



------------------------------


**例4**： 除了上面这几种 $action, chAttr 还对 class 属性的修改做了支持。请看下方 Plan:

```json
{
  ...
  "chAttr": [
    {
      "type": "split2list.remove",
      "pick": ".section",
      "attr": "class",
      "value": "folded",
      "sep": " "
    }
  ]
}
```

* type 为 **split2list.remove** ，它表明我们要用操作的属性具有的值比较特殊，可以通过某个分隔符分成多个部分，该类型表明要移除其中一部分。
* pick 的类型为选择器，用来选中要操作的节点，我们选中了所有包含类名为 section 的标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 class 属性。
* value 为要移除的那部分，可移除多个值（如：`"value": ["a", "b", "c"]`）
* sep 为分隔符

还有一种 $action, 跟该例子类似，它的类型为 **split2list.add**，该类型表明要往属性里面添加一项。

一般可以使用这两种 $action ，对网页折叠部分进行控制，使其达到我们想要的状态。这种方式不像上文的 show 参数那样粗暴地对 display 进行操控。


------------------------------


**例5**： 这种可能不常见，即直接修改属性的值


```json
{
  ...
  "chAttr": [
    {
      "type": "assign.from.value",
      "pick": ".formula",
      "attr": "type",
      "value": "image/svg",
    }
  ]
}
```

上面的例子会把 “type” 属性的值设置为 “image/svg”。


### form 参数的使用

用于预设置表单的输入值，MaoXian 会在显示表单的时候，自动帮你输入这些预设的值。四项都为选填，详情如下：

| 名字     | 类型     | 说明     | 默认值   |
| -------- | -------- | -------- | -------- |
| format   | 字符串   | 存储格式，只能为 `html` 或 `md` | 取决于你的设置（见扩展设置页面） |
| title    | 选择器   | 用于选中包含标题的元素 | 无 |
| category | 字符串   | 对应表单的目录（多级目录用 `/` 隔开） | 取决于你的设置（见扩展设置页面） |
| tagstr   | 字符串   | 对应表单的标签（多个标签用 `,` 或 `空格` 隔开)  | 无  |


注意 title 的类型为选择器。MaoXian 默认会使用网页的标题作为表单的标题输入值，但是有些网页的标题和其内容的标题并不一样，所以提供该项来选择合适的标题。

### config 参数的使用

重写某些配置项，并且重写的结果只在本次裁剪有效。

当前允许重写的配置项如下。注： 其中的默认值指的是 MaoXian 扩展提供的默认值，该值只作为参考，实际上使用的是你自己配置页面上的值。

| 名字               | 说明                     | 类型     | 默认值                     | 备注 |
| --------           | --------                 | -------- | --------                   | -------- |
| rootFolder         | 根目录                   | String   | mx-wc                      | - |
| defaultCategory    | 默认分类                 | String   | default                    | - |
| clippingFolderName | 裁剪目录                 | String   | $YYYY-$MM-$DD-$TIME-INTSEC | - |
| mainFileFolder     | 主文件的存储目录         | String   | $CLIPPING-PATH             | - |
| mainFileName       | 主文件的文件名           | String   | index.$FORMAT              | - |
| saveInfoFile       | 是否保存元信息文件       | Boolean  | true                       | 设置为`false` 后，MaoXian 便不会保存裁剪历史 |
| infoFileFolder     | 元信息文件的存储目录     | String   | $CLIPPING-PATH             | - |
| infoFileName       | 元信息文件的文件名       | String   | index.json                 | - |
| saveTitleFile      | 是否保存标题文件         | Boolean  | true                       | - |
| titleFileFolder    | 标题文件的存储目录       | String   | $CLIPPINT-PATH             | - |
| titleFileName      | 标题文件的文件名         | String   | a-title_$TITLE             | - |
| frameFileFolder    | 内嵌的网页文件的存储目录 | String   | $CLIPPING-PATH/frames      | - |
| assetFolder        | 资源文件的存储目录       | String   | $CLIPPING-PATH/assets      | - |


### tags 参数的使用

虽然 Plan 的 tags 属性是非必须的，但还是建议你为 Plan 打上标签，以便后期，我们能更好地管理他们。

## 贡献 Plan

所有的 Plan 都存储在 `plans` 的子目录下，不同的子目录代表不同频道，每个频道最终都将生成一个订阅地址。请将你写的 Plan 以数组的形式单独存为一个文件，如： `plans/zh/zhihu.json`。每个网站建一个文件。

最终所有的 Plan 会在 `build.rb` 这个脚本的渲染下，变成可订阅的形式。

你可以通过下方几种方式把 plan 分享出来：

* 通过 Github 建 Pull Request 的形式。
* 通过 Github 建 issue。（把 plan 贴上即可）
* 通过发邮件给开发者（i.mika[AT]tutanota.com），直接发送内容或者发送 patch。


## 最后

如果你对「毛线助手」有什么看法或建议，请[告诉我们](https://github.com/mika-cn/maoxian-assistant/issues)。

