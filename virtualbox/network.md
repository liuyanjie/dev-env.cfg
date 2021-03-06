# VirtualBox虚拟机网络设置

* https://www.douban.com/group/topic/15558388/
* http://www.jb51.net/article/98575.htm
* http://www.jb51.net/article/95770.htm
* http://www.cnblogs.com/dongzhuangdian/p/5105844.html
* http://www.cnblogs.com/javaminer/p/3575282.html

## 网络接入模式

1. NAT(Network Address Translation) 网络地址转换模式
2. Bridged Adapter 桥接模式
3. Internal 内部网络模式
4. Host-only Adapter 主机模式

https://www.jianshu.com/p/0537b056790b

### 第一种 NAT模式

NAT模式是最简单的实现虚拟机上网的方式，你可以这样理解：Vhost访问网络的所有数据都是由主机提供的，vhost并不真实存在于网络中，主机与网络中的任何机器都不能查看和访问到Vhost的存在。

虚拟机网络：

* 虚拟机与主机：只能单向访问，虚拟机可以通过网络访问到主机，主机无法通过网络访问到虚拟机。
* 虚拟机与网络中其他主机的： 只能单向访问，虚拟机可以访问到网络中其他主机，其他主机不能通过网络访问到虚拟机。
* 虚拟机与虚拟机之间的： 相互不能访问，虚拟机与虚拟机各自完全独立，相互间无法通过网络访问彼此。

```
IP      :10.0.2.15
Gateway :10.0.2.2
DNS     :10.0.2.3
```

一台虚拟机的多个网卡可以被设定使用 NAT
第一个网卡连接了到专用网 10.0.2.0
第二个网卡连接到专用网络 10.0.3.0

默认得到的客户端IP:10.0.2.15，Gateway:10.0.2.2，DNS:10.0.2.3，可以手动参考这个进行修改。

方案特点：

* 笔记本已插网线时： 虚拟机可以访问主机，虚拟机可以访问互联网，在做了端口映射后（最后有说明），主机可以访问虚拟机上的服务（如数据库）。
* 笔记本没插网线时： 主机的“本地连接”有红叉的，虚拟机可以访问主机，虚拟机不可以访问互联网，在做了端口映射后，主机可以访问虚拟机上的服务（如数据库）。

特点：

1、如果主机可以上网，虚拟机可以上网
2、虚拟机之间不能ping通
3、虚拟机可以ping通主机（此时ping虚拟机的网关，即是ping主机）
4、主机不能ping通虚拟机

应用场景：虚拟机只要求可以上网，无其它特殊要求，满足最一般需求

配置方法：

连接方式 选择 网络地址转换（NAT）
高级-控制芯片 选择 PCnet-FAST III
高级-混杂模式 拒绝
高级-接入网线 √
（虚拟机ip自动获取）

ip样式：

ip 10.0.2.15
网关 10.0.2.2

注意此处的网关在不同虚拟机中可能是同一个值，但是这归属于不同的NAT Engine，因此实际上各个虚拟机用的不是同一个网关

原理：虚拟机的请求传递给NAT Engine，由它来利用主机进行对外的网络访问，返回的数据包再由NAT Engine给虚拟机。

#### 端口映射

将虚拟机某端口映射到主机某端口，可以使主机和外部机器访问虚拟机提供的服务哦~~

命令如下：

```sh
vboxmanage setextradata <VM name> "VBoxInternal/Devices/pcnet/0/LUN#0/Config/<rule name>/Protocol" TCP
vboxmanage setextradata <VM name> "VBoxInternal/Devices/pcnet/0/LUN#0/Config/<rule name>/GuestPort" 80
vboxmanage setextradata <VM name> "VBoxInternal/Devices/pcnet/0/LUN#0/Config/<rule name>/HostPort" 8000
```

### 第二种 Bridged Adapter模式

网桥模式是我最喜欢的用的一种模式，同时，模拟度也是相当完美。
你可以这样理解，它是通过主机网卡，架设了一条桥，直接连入到网络中了。
因此，它使得虚拟机能被分配到一个网络中独立的IP，所有网络功能完全和在网络中的真实机器一样。

与主机共享主机网卡，相当于主机所在网络上真是的主机一样，IP地址也与主机在相同的网段。

虚拟机网络：

* 虚拟机与主机：可以相互访问，因为虚拟机在真实网络段中有独立IP，主机与虚拟机处于同一网络段中，彼此可以通过各自IP相互访问。
* 虚拟机于网络中其他主机： 可以相互访问，同样因为虚拟机在真实网络段中有独立IP，虚拟机与所有网络其他主机处于同一网络段中，彼此可以通过各自IP相互访问。
* 虚拟机于虚拟机： 可以相互访问，原因同上。

方案特点：

* IP：一般是DHCP分配的，与主机的“本地连接”的IP 是同一网段的。虚拟机就能与主机互相通信。
* 笔记本已插网线时：（若网络中有DHCP服务器）主机与虚拟机会通过DHCP分别得到一个IP，这两个IP在同一网段。 主机与虚拟机可以ping通，虚拟机可以上互联网。
* 笔记本没插网线时：主机与虚拟机不能通信。主机的“本地连接”有红叉，就不能手工指定IP。虚拟机也不能通过DHCP得到IP地址，手工指定IP后，也无法与主机通信，因为主机无IP。

这时主机的VirtualBox Host-Only Network 网卡是有ip的，192.168.56.1。虚拟机就算手工指定了IP 192.168.56.*，也ping不能主机。

特点：

1、如果主机可以上网，虚拟机可以上网
2、虚拟机之间可以ping通
3、虚拟机可以ping通主机
4、主机可以ping通虚拟机
5、以上各点基于一个前提：主机可以上网，如果主机不可以上网，所有1-4特点均无

应用场景： 虚拟机要求可以上网，且虚拟机完全模拟一台实体机

配置方法：
连接方式 选择 桥接网卡
界面名称 选择 （如果你的笔记本有无线网卡和有线网卡，需要根据现在的上网方式对应选择）
高级-控制芯片 选择 PCnet-FAST III
高级-混杂模式 拒绝
高级-接入网线 √
（虚拟机ip自动获取）

ip样式：
ip 与本机ip在同一网段内
网关 与本机网关相同

原理：通过主机网卡，架设一条桥，直接连入到网络中。它使得虚拟机能被分配到一个网络中独立的IP，所有网络功能完全和在网络中的真实机器一样。
虚拟机是通过主机所在网络中的DHCP服务得到ip地址的，所以按理来说，两者是完全独立的，但事实却是虚拟机是没
有独立硬件的，它还是要依靠主机的网卡，因此，主机要断开网络，虚拟机也就没法拿到ip了，所以呵呵~~所有特点全
消失咯）


### 第三种 Internal模式

内网模式，顾名思义就是内部网络模式，虚拟机与外网完全断开，只实现虚拟机于虚拟机之间的内部网络模式。

虚拟机网络：

* 虚拟机与主机：不能相互访问，彼此不属于同一个网络，无法相互访问。
* 虚拟机与网络中其他主机：不能相互访问，理由同上。
* 虚拟机与虚拟机：可以相互访问，前提是在设置网络时，两台虚拟机设置同一网络名称。如上配置图中，名称为intnet。

方案特点：

* IP: VirtualBox的DHCP服务器会为它分配IP ，一般得到的是192.168.56.101，因为是从101起分的，也可手工指定192.168.56.*。
* 笔记本已插网线时：虚拟机可以与主机的VirtualBox Host-Only Network网卡通信，这种方案不受主机本地连接（网卡）是否有红叉的影响。

特点：

1、虚拟机不可以上网
2、虚拟机之间可以ping通
3、虚拟机不能ping通主机
4、主机不能ping通虚拟机

应用场景：让各台虚拟机处于隔离的局域网内，只让它们相互通信，与外界（包括主机）隔绝

配置方法：
连接方式 选择 内部网络
界面名称 选择 intnet（可以重新命名，所有放在同一局域网内的虚拟机此名称相同）
高级-控制芯片 选择 PCnet-FAST III
高级-混杂模式 拒绝
高级-接入网线 √
（虚拟机ip：对于XP自动获取ip即可，但对于linux，必须手动配置ip和子网掩码，手动配置时需保证各个虚拟机ip在同一网段）

ip样式：
ip 169.254.147.9
子网掩码 255.255.0.0
默认网关 无

原理：各个虚拟机利用VirtualBox内置的DHCP服务器得到ip，数据包传递不经过主机所在网络，因此安全性高，防止外部抓包~

### 第四种 Host-only Adapter模式

主机模式，这是一种比较复杂的模式，需要有比较扎实的网络基础知识才能玩转。
可以说前面几种模式所实现的功能，在这种模式下，通过虚拟机及网卡的设置都可以被实现。
我们可以理解为Vbox在主机中模拟出一张专供虚拟机使用的网卡，所有虚拟机都是连接到该网卡上的，我们可以通过设置这张网卡来实现上网及其他很多功能，比如（网卡共享、网卡桥接等）。

虚拟机网络：

* 虚拟机与主机：默认不能相互访问，双方不属于同一IP段，host-only网卡默认IP段为192.168.56.X 子网掩码为255.255.255.0，后面的虚拟机被分配到的也都是这个网段。通过网卡共享、网卡桥接等，可以实现虚拟机于主机相互访问。
* 虚拟机与网络主机：默认不能相互访问，原因同上，通过设置，可以实现相互访问。
* 虚拟机与虚拟机：默认可以相互访问，都是同处于一个网段。

方案特点：

* 虚拟机访问主机，用的是主机的 `VirtualBox Host-Only Network` 网卡的 `IP：192.168.56.1`，不管主机“本地连接”有无红叉，永远通。
* 主机访问虚拟机，用的虚拟机的 `网卡3` 的 `IP：192.168.56.101` ，不管主机“本地连接”有无红叉，永远通。
* 虚拟机访问互联网，用的是自己的 `网卡2`， 这时主机要能通过“本地连接”有线上网，（无线网卡不行）。

特点：

1、虚拟机不可以上网
2、虚拟机之间可以ping通
3、虚拟机可以ping通主机（注意虚拟机与主机通信是通过主机的名为VirtualBox Host-Only Network的网卡，因此ip是该网卡ip 192.168.56.1，而不是你现在正在上网所用的ip）
4、主机可以ping通虚拟机

应用场景：在主机无法上网的情况下（主机可以上网的情况下可以用host-only，也可以用桥接），需要搭建一个模拟局域网，所有机器可以互访

配置方法：

连接方式 选择 仅主机（Host-Only）适配器
界面名称 选择 VirtualBox Host-Only Ethernet Adapter
高级-控制芯片 选择 PCnet-FAST III
高级-混杂模式 拒绝
高级-接入网线 √
（虚拟机ip自动获取，也可以自己进行配置，网关配置为主机中虚拟网卡的地址【默认为192.168.56.1】，ip配置为与虚拟网卡地址同网段地址）

ip样式：

ip 与本机VirtualBox Host-Only Network的网卡ip在同一网段内（默认192.168.56.*）
网关  本机VirtualBox Host-Only Network的网卡ip（默认192.168.56.1）

原理：

通过VirtualBox Host-Only Network网卡进行通信，虚拟机以此ip作为网关，因此模拟了一个本机与各个虚拟机的局域网，如名称所指，
应该是无法上网的（但是有人说可以通过对VirtualBox Host-Only Network网卡进行桥接等操作使虚拟机可以上网，但如此就不如直接
采用桥接来的容易了，而且，呵呵，我没试成功，有的人也说不可以，因为主机不提供路由服务，我也不好乱说到底行不行，你自己试吧~~）
