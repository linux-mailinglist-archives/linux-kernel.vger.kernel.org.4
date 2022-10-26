Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3482E60D8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiJZBs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiJZBsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:48:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83645A8359;
        Tue, 25 Oct 2022 18:48:51 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8AxStgCklhjnYECAA--.7950S3;
        Wed, 26 Oct 2022 09:48:50 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJlcBklhjbhUFAA--.976S3;
        Wed, 26 Oct 2022 09:48:49 +0800 (CST)
Message-ID: <e75fb7c4-67d8-1e17-8bf4-59e1be87893c@loongson.cn>
Date:   Wed, 26 Oct 2022 09:48:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/sysfs-platform_profile
 Chinese translation
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025061804.35801-1-me@lirui.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <20221025061804.35801-1-me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJlcBklhjbhUFAA--.976S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF1rGr17urWrJw13tF4rGrg_yoWrZFy8pF
        n8KrWxGr1kGryYk3W8GF1DGF15KF1ruF12g348G345tas8ZFWqkr1UtFWFg3ZxGrW8Aa1D
        Jr1jqFW8u3WIv37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
        8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/25 14:18, Rui Li 写道:
> Translate the following documents into Chinese:
>
> - userspace-api/sysfs-platform_profile.rst
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>   .../zh_CN/userspace-api/index.rst             |  2 +-
>   .../userspace-api/sysfs-platform_profile.rst  | 40 +++++++++++++++++++
>   2 files changed, 41 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
>
> diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
> index 6a7e82ac16b9..0f3483a46fa2 100644
> --- a/Documentation/translations/zh_CN/userspace-api/index.rst
> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
> @@ -26,6 +26,7 @@ Linux 内核用户空间API指南
>   
>      ebpf/index
>      no_new_privs
> +   sysfs-platform_profile
>   
>   TODOList:
>   
> @@ -38,7 +39,6 @@ TODOList:
>   * iommu
>   * media/index
>   * netlink/index
> -* sysfs-platform_profile
>   * vduse
>   * futex2
>   
> diff --git a/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst b/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
> new file mode 100644
> index 000000000000..6e861f911424
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
> @@ -0,0 +1,40 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/userspace-api/sysfs-platform_profile.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +==========================================================
> +平台配置文件选择（如 /sys/firmware/acpi/platform_profile）
> +==========================================================
> +
> +现代系统中平台性能、温度、风扇和其他硬件相关的特性通常是可以动态配置的。平台
> +配置通常会根据当前的状态由一些自动机制（很可能存在于内核之外）来自动调整。
> +
> +这些平台自动调整机制通常能够被配置成多个平台配置文件中的一个，要么偏向低功率
> +工作，要么偏向性能。
How about 其要么偏向节能运行，要么偏向性能运行？
> +
> +platform_profile属性的目的是提供一个通用的sysfs API来选择这些平台自动配置
> +机制的配置文件。
> +
> +需要注意的是，这个API只能用作选择平台配置文件。其目的并不是为了监测改变所致
> +的性能特征。监测性能最好使用设备/供应商提供的工具，比如turbostat。

Original: it is NOT a goal of this API to allow monitoring the resulting 
performance characteristics.


Here maybe the translation could be improved

> +
> +具体来说，当选择高性能配置文件时，真实能达到的性能可能受制于多种因素，比如：
> +其他组件的发热，房间温度，笔记本底部的自由空气流动等。这个API的目的明显不是让
> +用户空间知道任何阻碍达到要求性能等级的欠佳条件。
Hmmm, how about 
让用户空间知道任何阻碍达到要求的性能水平的局部最优条件，显然不是这个API的目标?
> +
> +由于数字本身并不能代表一个配置文件会调整的多个变量（功耗，发热等），这个API使
> +用字符串来描述多种配置文件。为了保证用户空间能够获得一致的体验，
> +sysfs-platform_profile ABI 文档定义了一个固定的配置文件名集合。驱动程序
> +*必须* 将它们内置的配置文件表示映射到这个固定的集合中。
> +
> +如果映射时没有很好的匹配，可以添加一个新的配置文件名称。驱动希望引入的新配置文
> +件名称时必须：
> +
> + 1. 解释为什么无法使用已有的配置文件名称。
> + 2. 添加一个新的配置文件名称，以及预期行为的清晰描述，保存到
> +    sysfs-platform_profile ABI文档中。


Thanks,

Yanteng

