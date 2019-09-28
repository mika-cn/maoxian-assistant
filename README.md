
# 毛线助手

为了更方便 MaoXian Web Clipper 用户在对网页进行 “裁剪” 之前执行一些操作，我们把「MaoXian 助手」集成到扩展中。该项目用于收集和分享各个用户编写的 “Plan”。

## 背景

由于 MaoXian Web Clipper 裁剪网页的时候，裁剪的是当前状态下的网页，并且不会保存任何脚本文件（即 javascript）。 这意味着在一些情况下，我们需要对网页进行一些操作后，才能获得一个较好的裁剪结果。比如： 一篇文章里的图片显示的都是缩略图，而你想保存的是原图；或者是你不想保存选区内的按钮、评论等无关内容；又或者是网页上的某些区域是可折叠的，需要在裁剪前把它们都展开。「MaoXian 助手」就是为了解决这些较常见的问题。

在集成「MaoXian 助手」之后，MaoXian Web Clipper 的裁剪流程也完整了起来。

```
准备 --> 选择 --> 裁剪 --> 存储
```

如上的四个步骤中，「MaoXian 助手」主要用于「准备」阶段，也涉及到「选择」阶段（不过不多）。它的工作方式有点像「广告屏蔽扩展」，需要针对不同的网站，编写不同的操作（在「MaoXian 助手里」我们称其为 plan）。这也意味着它解决问题的多少取决于我们适配的网站的多少。

## 参与进来

如上一小节所述，「MaoXian 助手」的功能强大于否取决于我们适配的网站的多少。这需要的不仅仅是开发者，更是每一个使用者的无私分享精神，于此，我们欢迎各位 MaoXian 用户参与进来，只有这般，该助手才能发挥其真正的能力。

如果你不会编程，你可以在项目 [issue 页面](https://github.com/mika-cn/maoxian-assistant/issues) 提交适配请求(提供需要适配的网址)，或者回馈某个网站适配不正确的信息，以便其他人进行跟进。

如果你会编程（只需要懂一点 CSS 就行），那么恭喜你，你完全有能力编写 Plan，并分享给其他人，具体查看下一节。

## 如何编写 Plan

### 流程

1. 请到 MaoXian Web Clipper 的设置页面，启用「MaoXian 助手」
2. 使用任何编辑器编写 Plan， 再把其复制到 「MaoXian 助手」设置里的自定义 Plan 里。
3. 刷新目标网页，点击「裁剪」验证编写的动作有没有产生预期效果。

### Plan 的结构解释


| 参数名 | 类型 | 是否必填 | 备注 |
| -------- | -------- | -------- | -------- |
| name | 字符串 | 必填 | 起标识作用，直接填写域名即可 |
| pattern | 字符串 | 必填 | 匹配的模式，只有网址和模式匹配，该 plan 才会被应用。|
| pick | 选择器 | 必填 | 用于选择「要裁剪的元素」，可提供多个选择器，更详细请看下方 |
| hide | 选择器 | 可选 | 用于选择「要剔除的元素」，可提供多个选择器，更详细请看下方|

上方表格给出的是常用的几个参数。更多参数说明会在后文给出。

#### Pattern 参数的使用

Pattern 参数描述了该 Plan 会应用到哪一类网址上，目前支持 `*` 和 `**`。 `*` 号不会匹配路径分隔符 `/`，`**` 可匹配零个或零个以上的目录。

假设我们要匹配的网址为 `https://example.org/blog/javascript/2017/01/05/awesome-article.html` ，里面 /blog 为固定不变的部分，/javascript 为文章分类（不知道有没有子分类），后面是年月日，最后是文章名。可以用 `https://example.org/blog/**/*/*/*/*/*.html`这个 Pattern 来匹配。 中间用了四个 `*` 号来匹配分类和年月日，前面的 `**` 匹配可能存在的子分类。

当然，上面这个例子也可以使用 `https://example.org/blog` 作为 Pattern ，来直接匹配以该模式打头的网址，不同的 Pattern，严格程度不同，根据需求给出 Pattern 即可。


#### 选择器

选择器有两种：CSS 选择器 和 xPath 选择器。是一个字符串，结构为 `$type||$q` 。

| 变量 | 说明 | 值 |
| -------- | -------- | -------- |
| $type | 选择器的类型 | C 代表 CSS, X 代表 xPath |
| $q | 选择器 | CSS 选择器 或 xPath 选择器 |

其中 `$type||` 部分可省略，省略后的部分表示的是 CSS 选择器，大部分情况下我们都会用 CSS 选择器，除非一些很难用 CSS 选择器表示的，才会使用到 xPath 选择器。

不同参数的选择器的查找范围不一样，如下：

* **pick 参数** 选择器的查找范围为**整个文档**，找到第一个匹配元素就停止查找，如果你填写了多个选择器，则会按照选择器的顺序依次查找。

* **hide 参数** 选择器的查找范围为**要裁剪元素的内部**，所有选择器找到的元素都会被剔除掉。

下面我们来看一个例子

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

#### show 参数的使用

show 参数是用于显示隐藏的块状元素的，属性的值也是选择器（可填写多个），show 比较特殊，它**只可用于块状元素（即display 的值为 block）**。它会将元素的 display 样式设置成 block 来让这个元素显示出来. 它相对于后文会提到的 chAttr 参数比较简单，如果要操作的元素都为块状元素，则使用 show 会比较方便，否则，请考虑使用 chAttr 参数（具体查看 chAttr 的例4）

#### chAttr 参数的使用

chAttr 参数可以用来改变标签的某个属性的值。chAttr 是一个可选项，只有在需要的时候，才需要提供。 chAttr 的值为一个 $action 的数组，$action 是一个 Object。Object 的常用参数有三个 `type`, `pick`, `attr`。不同的 `type` 会跟不同的的参数。下面我们用例子来说明 chAttr 的用法。

---------------------------

1. 假设有一个网页，显示的是低质量的图，这些图的 `src` 属性是一个有规律的地址，比如： `https://www.example.org/images/awesome-pic-small.jpg`  ，而某些操作后，可能就变为 `https://www.example.org/images/awesome-pic-big.jpg` 。我们希望裁剪的是后者，而非前者，可以用下面这个 Plan 来实现：

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
  ]
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


---------------------------

2. 假设有一个网页，显示的是低质量的图，它的高质量图片地址，放在了 img 标签的另一个属性上。图片的 html 如下：

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
  ]
}
```
* type 为 **self.attr** ，它表明我们要用**找到元素的另一个属性的值**，来重写 attr 指定的属性。
* pick 的类型为选择器，用来选中要操作的元素，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用 hq-src 属性重写 src 属性。

---------------------------

3. 假设有一个网页，显示的是低质量的图，并且这些图片本身是一个链接，可以通过点击图片查看原图， 图片的 html 如下：

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
  ]
}
```

* type 为 **parent.attr** ，它表明我们要用找到元素的**父元素**的一个属性的值，来重写 attr 指定的属性。
* pick 的类型为选择器，用来选中要操作的元素，我们选中了所有 img 标签。
* attr 的值为要操作的属性名字，此例中，我们选择的是 src 属性。
* tAttr 的值为目标属性（target attribute）的名字， 此例中，我们用父元素的 href 属性重写 src 属性。

---------------------------

4. 除了上面这几种 $action, chAttr 还对 class 属性的修改做了支持。请看下方 Plan:

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
  ]
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
  ]
}
```

一般可以使用这两种 $action ，对网页折叠部分进行控制，使其达到我们想要的状态。这种方式不像上文的 show 参数那样粗暴地对 display 进行操控，但是我们建议在能使用 show 的情况下，还是使用 show，简单一些。


## 贡献 Plan

所有的 plan 都存储在 `plans` 目录下，比如 `plans/default/plans.yaml` 里面存储的是默认的 plan 信息，而 `plans/zh/plans.yaml` 存储的是中文网站相关的 plan 信息。最终所有的 `plans.yaml` 会在 `build.rb` 这个脚本的渲染下，变成 JSON 的格式。

我们倾向于使用 YAML 来维护所有的 Plan，这样会整个文件看起来更清晰, 并且可以加上一些注释。如果你没用过 YAML 这种格式也没有关系。系统有个 `json2yaml.rb` 脚本，专门可以用来把 JSON 格式转换为 YAML 格式。

使用方式如下(把你写的 json 文本复制到 tmp/myplans.json ):

```shell
./json2yaml.rb tmp/myplans.json > tmp/myplans.yaml
```

再把 tmp/myplans.yaml 里面的 Plan 复制到对应的 plans.yaml （比如： plans/zh/plans.yaml ），提个 PR （pull request）就完成了。


### plans.yaml 的结构解释

```yaml
# name 为我们为该 plan 列表取的一个名字，只能使用字母和中划线 "-" 和 下划线 "_"
name: 'default'

# version 为版本信息，我们使用年月日作为版本，在每次发布之前才需要修改它
version: '20190101'

# description 为描述信息
description: 'default plans'

# plans 为我们维护的 plan 集合，是一个元祖（数组）
# 上一节，提到的复制，即复制到 plans 下面即可。
plans:
  - ...
```
