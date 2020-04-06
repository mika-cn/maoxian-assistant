
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

## 开始使用 {#public-subscriptions}

你可以在 **扩展设置页面 > 毛线助手** 页面启用该功能， 自己编写 Plan 或者订阅公开的 Plan。

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
2. 使用任何编辑器编写 Plan， 再把其复制到 「MaoXian 助手」设置里的自定义 Plan 里。
3. 刷新目标网页，点击「裁剪」验证编写的动作有没有产生预期效果。

### Plan 的结构解释


| 参数名 | 类型 | 是否必填 | 备注 |
| -------- | -------- | -------- | -------- |
| name | 字符串 | 必填 | 起标识作用，直接填写域名即可 |
| pattern | 字符串 | 必填 | 匹配的模式，只有网址和模式匹配，该 plan 才会被应用。|
| pick | 选择器 | 必填 | 用于选择「要裁剪的元素」，可提供多个选择器，详情请看下文 |
| hide | 选择器 | 选填 | 用于选择「要剔除的元素」，可提供多个选择器，详情请看下文 |
| show | 选择器 | 选填 | 用于显示隐藏的「块状元素」，可提供多个选择器，详情请看下文 |
| chAttr | 元组 | 选填 | 用于修改元素的属性值，提供了多种修改属性的方式，详情请看下文 |
| tags | 元祖   | 选填 | 用于编注网站属性，使这些 plan 更好管理 |


### Pattern 参数的使用

Pattern 参数描述了该 Plan 会应用到哪一类网址上。

目前支持的匹配符有 "*" 和 "**"。

**星匹配符**

* 匹配开头

比如：匹配子域名，`*.example.org` 可匹配任何以 "example.org" 结尾的域名，例如： www.example.org，foo.bar.example.org。

* 匹配结尾

比如：匹配网址协议，`http*` 即可以匹配到 http 也可以匹配到 https。

* 匹配整个部分，常用于匹配网址路径的一个目录。

比如：使用 `https://example.org/*/index.html`，可以匹配到 https://example.org/blog/index.html。但是无法匹配到 https://example.org/blog/jack/index.html，因为 "*" 号不匹配目录分隔符 "/"。

**双星匹配符**

一般使用双星匹配符，来匹配零个或零个以上的目录。

假如我们要匹配的网址为 https://example.org/blog/javascript/2017/01/05/awesome-article.html ，里面 /blog 为固定不变的部分，/javascript 为文章分类（不知道有没有子分类），后面是年月日，最后是文章名。

可以用 `https://example.org/blog/**/*/*/*/*/*.html`这个 Pattern 来匹配。 中间用了四个 "*" 号来匹配分类和年月日，前面的 "**" 匹配可能存在的子分类。

上面这个例子也可以使用 `https://example.org/blog` 作为 Pattern ，来直接匹配以该模式打头的网址，不同的 Pattern，严格程度不同，根据需求给出 Pattern 即可。


### 选择器

选择器有两种：CSS 选择器 和 xPath 选择器。是一个字符串，结构为 `$type||$q` 。

| 变量 | 说明 | 值 |
| -------- | -------- | -------- |
| $type | 选择器的类型 | C 代表 CSS, X 代表 xPath |
| $q | 选择器 | CSS 选择器 或 xPath 选择器 |

其中 `$type||` 部分可省略，省略后的部分表示的是 CSS 选择器，大部分情况下我们都会用 CSS 选择器，除非一些很难用 CSS 选择器表示的，才会使用到 xPath 选择器。

不同参数的选择器的查找范围不一样，如下：

* **pick 参数** 选择器的查找范围为**整个文档**，找到第一个匹配元素就停止查找，如果你填写了多个选择器，则会按照选择器的顺序依次查找。

* **hide 参数** 选择器的查找范围为**要裁剪元素的内部**，所有选择器找到的元素都会被隐藏掉（MaoXian 不会裁剪隐藏的元素）。

下面我们来看一个例子（注： 本页面给出的例子都是 JSON 格式）

```json
{
  "name": "example.org",
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

### show 参数的使用

show 参数是用于显示「隐藏的块状元素」的，属性的值也是选择器（可填写多个），show 比较特殊，它**只可用于块状元素（即display 的值为 block）**。它会将元素的 display 样式设置成 block 来让这个元素显示出来. 它相对于后文会提到的 chAttr 参数比较简单，如果要操作的元素都为块状元素，则使用 show 会比较方便，否则，请考虑使用 chAttr 参数（具体查看 chAttr 的例4）

### chAttr 参数的使用

chAttr 参数可以用来改变标签的某个属性的值。chAttr 是一个可选项，只有在需要的时候，才需要提供。 chAttr 的值为一个 $action 的数组，$action 是一个 Object。$action 的常用参数有三个 `type`, `pick` 和 `attr`。不同的 `type` 会跟不同的的参数。下面我们用例子来说明 chAttr 的用法。

**例1**： 假设有一个网页，显示的是低质量的图，这些图的 `src` 属性是一个有规律的地址，比如： https://www.example.org/images/awesome-pic-small.jpg  ，而某些操作后，可能就变为 https://www.example.org/images/awesome-pic-big.jpg 。我们希望裁剪的是后者，而非前者，可以用下面这个 Plan 来实现：

```json
{
  "name": "example.org",
  "pattern": "https://www.example.org/post/*",
  "pick": "article",
  "hide": "div.comment",
  "chAttr": [
    {
      "type": "self.replace",
      "pick": "img",
      "attr": "src",
      "subStr": "small",
      "newStr": "big"
    }
  ],
  "tags": ["IT", "blog"]
}
```

上面 Plan 中的 chAttr 参数的值是一个数组，里面包含了一个 $action，它的各个属性解读如下：

* type 的值为 **self.replace** ，表示这个 $action 是将**找到的元素的属性值的某个部分**，进行替换操作。
* pick 的类型为选择器，用来选中要操作的元素，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* subStr 的值为**要替换掉的那部分**，我们填入的是 small。
* newStr 的值是替换项，也就是说我们用 newStr 的值 big，替换 subStr 的值 small。

我们这里说的替换操作，不会替换所有找到的 subStr，而是只替换最后一个。

**注意: $action 的 pick 参数的查找范围为「要裁剪元素的内部」**，在此例子中，查找范围是第一个 article 元素的内部。



------------------------------



**例2**： 假设有一个网页，显示的是低质量的图，它的高质量图片地址，放在了 img 标签的另一个属性上。图片的 html 如下：

```html
<img src="/image/pic-abc.jpg" hq-src="/image/pic-bdf.jpg" />
```
我们要裁剪的是 hq-src 指定的那张图片，使用下面这个 Plan 实现：


```json
{
  "name": "example.org",
  "pattern": "https://www.example.org/post/*",
  "pick": "div.post-content",
  "hide": [
    "div.comment",
    "div.status-bar",
  ],
  "chAttr": [
    {
      "type": "self.attr",
      "pick": "img",
      "attr": "src",
      "tAttr": "hq-src"
    }
  ],
  "tags": ["IT", "blog"]
}
```
* type 为 **self.attr** ，它表明我们要用**找到元素的另一个属性的值**，来重写 attr 指定的属性。
* pick 的类型为选择器，用来选中要操作的元素，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用 hq-src 属性重写 src 属性。



------------------------------


**例3**： 假设有一个网页，显示的是低质量的图，并且这些图片本身是一个链接，可以通过点击图片查看原图， 图片的 html 如下：

```html
<a href="/image/awesome-pic-bdf.jpg" >
  <img src="/image/pic-abc.jpg" />
</a>
```
我们要裁剪的是 a 标签 href 指定的那张图片，使用下面这个 Plan 实现：

```json
{
  "name": "example.org",
  "pattern": "https://www.example.org/post/*",
  "pick": "div.post",
  "hide": [
    "div.comment",
    "div.status-bar"
  ],
  "chAttr": [
    {
      "type": "parent.attr",
      "pick": "img",
      "attr": "src",
      "tAttr": "href"
    }
  ],
  "tags": ["IT", "blog"]
}
```

* type 为 **parent.attr** ，它表明我们要用找到元素的**父元素**的一个属性的值，来重写 attr 指定的属性。
* pick 的类型为选择器，用来选中要操作的元素，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用父元素的 href 属性重写 src 属性。


------------------------------


**例4**： 除了上面这几种 $action, chAttr 还对 class 属性的修改做了支持。请看下方 Plan:

```json
{
  "name": "example.org",
  "pattern": "https://www.example.org/post/*",
  "pick": "article",
  "hide": "div.comment",
  "chAttr": [
    {
      "type": "self.remove",
      "pick": ".section",
      "attr": "class",
      "value": "folded",
      "sep": " "
    }
  ],
  "tags": ["IT", "blog"]
}
```

* type 为 **self.remove** ，它表明我们要用操作的属性具有的值比较特殊，可以通过某个分隔符分成多个部分，该类型表明要移除其中一部分。
* pick 的类型为选择器，用来选中要操作的元素，我们选中了所有包含类名为 section 的标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 class 属性。此项可不填，默认为 class。
* value 为要移除的那部分。
* sep 为分隔符，此项可不填，默认为空格

还有一种 $action, 跟该例子类似，它的类型为 **self.add**，该值表明要往属性里面添加一项。

该 Plan 出于演示的目的，列出了所有的参数，若忽略可不填的参数，可简化为：

```json
{
  "name": "example.org",
  "pattern": "https://www.example.org/post/*",
  "pick": "article",
  "hide": "div.comment",
  "chAttr": [
    {
      "type": "self.remove",
      "pick": ".section",
      "value": "folded"
    }
  ],
  "tags": ["IT", "blog"]
}
```

一般可以使用这两种 $action ，对网页折叠部分进行控制，使其达到我们想要的状态。这种方式不像上文的 show 参数那样粗暴地对 display 进行操控。

### tags 参数的使用

虽然 Plan 的 tags 属性是非必须的，但还是建议你为 Plan 打上标签，以便后期，我们能更好地管理他们。

### frame 参数（极少用到）

frame 参数有两个可选值，`top` 和 `child`，默认为 `top`。`top` 表明该 Plan 会应用到最上方的 frame，也就是地址栏对应的网页本身，而 `child` 则表明该 Plan 会应用到某个 `<iframe>` 或 `<frame>` 中，并且 `pick` 属性会被忽略，也就是说 `hide`，`show`，`chAttr` 属性的作用范围是 document，而不是原来的 `pick` 选中的那个元素。

## 贡献 Plan

所有的 plan 都存储在 `plans` 目录下，比如 `plans/default/plans.json` 里面存储的是默认的 plan 信息，而 `plans/zh/plans.json` 存储的是中文网站相关的 plan 信息。最终所有的 `plans.json` 会在 `build.rb` 这个脚本的渲染下，变成可订阅的形式。


你可以通过下方几种方式把 plan 分享出来：

* 通过 Github 建 Pull Request 的形式。（把你编写的 plan 复制到对应的 plans.json 文件即可）
* 通过 Github 建 issue。（把 plan 贴上即可）
* 通过发邮件给开发者（i.mika[AT]tutanota.com），直接发送内容或者发送 patch。

### plans.json 的字段解释

* name 为我们取的一个名字，只能使用字母和中划线 `-` 和 下划线 `_`
* version 为版本信息，我们使用年月日作为版本，在每次发布之前才需要修改它
* description 为描述信息
* plans 为我们维护的 plan 集合，是一个元祖（数组），上一节，提到的复制，即复制到 plans 下面即可。

## 最后

如果你对「毛线助手」有什么看法或建议，请[告诉我们](https://github.com/mika-cn/maoxian-assistant/issues)。
