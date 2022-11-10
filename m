Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8E7624212
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiKJMO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiKJMO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:14:57 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E656C71E;
        Thu, 10 Nov 2022 04:14:55 -0800 (PST)
Date:   Thu, 10 Nov 2022 20:14:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668082493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9H7pTTfqZgw9EwyEoMwzAAEs2iWwvSSDuQZYS9UnE0Q=;
        b=as+lk1c48PS7v6TzqIvyLJbBsI5zZyHDxQGMrsHSNNnNRld05C5tMmtPfCbaWrn6Mh6bF5
        MLDF+G8tewoimugLK9kbaPYok8O3hQgjhrp/iCDvib8t+3UMJSuwFQB8/VqBp9keKMc1PM
        Vxo7N6dr95JTwzIprSFnm3kcEhoo4Ms=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Rui Li <me@lirui.org>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/accelerators/ocxl Chinese
 translation
Message-ID: <Y2zrKAZL38i48SA5@bobwxc.mipc>
References: <20221110062609.377848-1-me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110062609.377848-1-me@lirui.org>
X-Generator: review-reply, a very cute ai bot
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Translate the following documents into Chinese:
> 
> - userspace-api/accelerators/ocxl.rst
> 
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>  .../zh_CN/userspace-api/accelerators/ocxl.rst | 168 ++++++++++++++++++
>  .../zh_CN/userspace-api/index.rst             |   2 +-
>  2 files changed, 169 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/userspace-api/accelerators/ocxl.rst
> 
> diff --git a/Documentation/translations/zh_CN/userspace-api/accelerators/ocxl.rst b/Documentation/translations/zh_CN/userspace-api/accelerators/ocxl.rst
> new file mode 100644
> index 000000000000..274dcf4667db
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/accelerators/ocxl.rst
> @@ -0,0 +1,168 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/userspace-api/accelerators/ocxl.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +=====================================
> +OpenCAPI （开放相干加速器处理器接口）
> +=====================================
> +
> +*OpenCAPI: Open Coherent Accelerator Processor Interface*
> +
> +OpenCAPI是处理器和加速器之间的一个接口，致力于达到低延迟和高带宽。该规范
> +由 `OpenCAPI Consortium <http://opencapi.org/>`_ 开发。
> +
> +它允许加速器（可以是FPGA、ASIC等）使用虚拟地址连贯地访问主机内存。一个OpenCAPI
> +设备也可以托管它自己的内存，并可以由主机访问。
> +
> +OpenCAPI在Linux中称为“ocxl”，它作为“cxl”的开放、处理器无关的演进，这么命

missed:
	'cxl' (the driver for the IBM CAPI interface for powerpc)

> +名是为了避免与ISDN CAPI子系统相混淆。
> +
> +
> +高层视角
> +========
> +
> +OpenCAPI定义了一个在物理链路层上实现的数据链路层（TL）和传输层（TL）。任何
> +实现DL和TL的处理器或者设备都可以开始共享内存。
> +
> +::
> +
> +  +-----------+                         +-------------+
> +  |           |                         |             |
> +  |           |                         | Accelerated |
> +  | Processor |                         |  Function   |
> +  |           |  +--------+             |    Unit     |  +--------+
> +  |           |--| Memory |             |    (AFU)    |--| Memory |
> +  |           |  +--------+             |             |  +--------+
> +  +-----------+                         +-------------+
> +       |                                       |
> +  +-----------+                         +-------------+
> +  |    TL     |                         |    TLX      |
> +  +-----------+                         +-------------+
> +       |                                       |
> +  +-----------+                         +-------------+
> +  |    DL     |                         |    DLX      |
> +  +-----------+                         +-------------+
> +       |                                       |
> +       |                   PHY                 |
> +       +---------------------------------------+
> +
> +  Processor：处理器
> +  Memory：内存
> +  Accelerated Function Unit：加速函数单元
> +
> +
> +
> +设备发现
> +========
> +
> +OpenCAPI依赖一个在设备上实现的与PCI类似的配置空间。因此主机可以通过查询
> +配置空间来发现AFU。
> +
> +OpenCAPI设备在Linux中被当作PCI设备（有一些注意事项）。固件需要对硬件进行

类PCI设备

> +抽象，就好像它是一个PCI链路。许多已有的PCI架构被重用：在模拟标准PCI时，
> +设备被扫描并且BAR（基址寄存器）被分配。像“lspci”的命令因此可以被用于查看
> +哪些设备可用。
> +
> +配置空间定义了可以在物理适配器上可以被找到的AFU，比如它的名字、支持多少内
> +存上下文、内存映射IO（MMIO）区域的大小等。
> +
> +
> +
> +MMIO
> +====
> +
> +OpenCAPI为每个AFU定义了两个MMIO区域：
> +
> +* 全局MMIO区域，保存和整个AFU相关的寄存器。
> +* 每个进程的MMIO区域，对于每个上下文固定大小。
> +
> +
> +
> +AFU中断
> +=======
> +
> +OpenCAPI拥有AFU向主机进程发送中断的可能性。它通过定义在传输层的“intrp_req”
> +来完成，指定一个定义中断的64位对象句柄。
> +
> +驱动允许一个进程分配中断并获取可以传递给AFU的64位对象句柄。
> +
> +
> +
> +字符设备
> +========
> +
> +驱动为每个在物理设备上发现的AFU创建一个字符设备。一个物理设备可能拥有多个
> +函数，一个函数可以拥有多个AFU。不过编写这篇文档之时，只对导出一个AFU的设备
> +测试过。
> +
> +字符设备可以在 /dev/ocxl/ 中被找到，其命名为：
> +/dev/ocxl/<AFU 名称>.<位置>.<索引>
> +
> +<AFU 名称> 是一个最长20个字符的名称，和在AFU配置空间中找到的相同。
> +<位置>由驱动添加，可在系统有不止一个相同的OpenCAPI设备时帮助区分设备。
> +<索引>也是为了在少见情况下帮助区分AFU，即设备携带多个同样的AFU副本时。
> +
> +
> +
> +Sysfs 类
> +=========

Sysfs类
=======

> +
> +添加了代表AFU的ocxl类。查看/sys/class/ocxl。布局在
> +Documentation/ABI/testing/sysfs-class-ocxl 中描述。
> +
> +
> +
> +用户API
> +=======
> +
> +开放

打开


Thanks,


-- 
Wu XiangCheng	0x32684A40BCA7AEA7

