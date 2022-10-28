Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A56610E71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJ1K2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ1K2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:28:35 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F90841521;
        Fri, 28 Oct 2022 03:28:33 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.239])
        by gateway (Coremail) with SMTP id _____8BxWtjQrltjjxQDAA--.9904S3;
        Fri, 28 Oct 2022 18:28:32 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.239])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuDQrltjhlMGAA--.22302S3;
        Fri, 28 Oct 2022 18:28:32 +0800 (CST)
Message-ID: <53b87ee6-c803-1f33-eb2c-bb39c3ada7dd@loongson.cn>
Date:   Fri, 28 Oct 2022 18:28:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/no_new_privs Chinese
 translation
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022120557.381115-1-me@lirui.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <20221022120557.381115-1-me@lirui.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPuDQrltjhlMGAA--.22302S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF17ZFy5CrWUur47JryfCrg_yoW7Jr4Up3
        WagryfG3WxAryjkryjgr17XF1fuFykWasrua17GayFgwn0kFWDCr1qyrZFyrn7J3y2yF98
        JF4qgFW8u342k37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
        67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
        8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8
        JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
        1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/22 20:05, Rui Li 写道:
> Translate the following documents into Chinese:
>
> - userspace-api/no_new_privs.rst
>
> Signed-off-by: Rui Li <me@lirui.org>

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   .../zh_CN/userspace-api/index.rst             |  2 +-
>   .../zh_CN/userspace-api/no_new_privs.rst      | 57 +++++++++++++++++++
>   2 files changed, 58 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/translations/zh_CN/userspace-api/no_new_privs.rst
>
> diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
> index 12c63d81c663..6a7e82ac16b9 100644
> --- a/Documentation/translations/zh_CN/userspace-api/index.rst
> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
> @@ -25,10 +25,10 @@ Linux 内核用户空间API指南
>      :maxdepth: 2
>   
>      ebpf/index
> +   no_new_privs
>   
>   TODOList:
>   
> -* no_new_privs
>   * seccomp_filter
>   * landlock
>   * unshare
> diff --git a/Documentation/translations/zh_CN/userspace-api/no_new_privs.rst b/Documentation/translations/zh_CN/userspace-api/no_new_privs.rst
> new file mode 100644
> index 000000000000..81bd16ce3ad2
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/userspace-api/no_new_privs.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/userspace-api/no_new_privs.rst
> +
> +:翻译:
> +
> + 李睿 Rui Li <me@lirui.org>
> +
> +============
> +无新权限标志
> +============
> +
> +execve系统调用可以给一个新启动的程序授予它的父程序本没有的权限。最明显的两个
> +例子就是setuid/setgid控制程序和文件的能力。为了避免父程序也获得这些权限，内
> +核和用户代码必须小心避免任何父程序可以颠覆子程序的情况。比如：
> +
> + - 程序在setuid后，动态装载器处理 ``LD_*`` 环境变量的不同方式。
> +
> + - 对于非特权程序，chroot是不允许的，因为这会允许 ``/etc/passwd`` 在继承
> +   chroot的程序眼中被替换。
> +
> + - 执行代码对ptrace有特殊处理。
> +
> +这些都是临时性的修复。 ``no_new_privs`` 位（从 Linux 3.5 起）是一个新的通
> +用的机制来保证一个进程安全地修改其执行环境并跨execve持久化。任何任务都可以设
> +置 ``no_new_privs`` 。一旦该位被设置，它会在fork、clone和execve中继承下去
> +，并且不能被撤销。在 ``no_new_privs`` 被设置的情况下， ``execve()`` 将保证
> +不会授予权限去做任何没有execve调用就不能做的事情。比如， setuid 和 setgid
> +位不会再改变 uid 或 gid；文件能力不会被添加到授权集合中，并且Linux安全模块（
> +LSM）不会在execve调用后放松限制。
> +
> +设置 ``no_new_privs`` 使用::
> +
> +    prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +
> +不过要小心，Linux安全模块（LSM）也可能不会在 ``no_new_privs`` 模式下收紧约束。
> +（这意味着一个一般的服务启动器在执行守护进程前就去设置 ``no_new_privs`` 可能
> +会干扰基于LSM的沙箱。）
> +
> +请注意， ``no_new_privs`` 并不能阻止不涉及 ``execve()`` 的权限变化。一个拥有
> +适当权限的任务仍然可以调用 ``setuid(2)`` 并接收 SCM_RIGHTS 数据报。
> +
> +目前来说， ``no_new_privs`` 有两大使用场景：
> +
> + - 为seccomp模式2沙箱安装的过滤器会跨execve持久化，并能够改变新执行程序的行为。
> +   非特权用户因此在 ``no_new_privs`` 被设置的情况下只允许安装这样的过滤器。
> +
> + - ``no_new_privs`` 本身就能被用于减少非特权用户的攻击面。如果所有以某个 uid
> +   运行的程序都设置了 ``no_new_privs`` ，那么那个 uid 将无法通过攻击 setuid，
> +   setgid 和使用文件能力的二进制来提权；它需要先攻击一些没有被设置 ``no_new_privs``
> +   位的东西。
> +
> +将来，其他潜在的危险的内核特性可能被非特权任务利用，即使 ``no_new_privs`` 被置位。
> +原则上，当 ``no_new_privs`` 被置位时， ``unshare(2)`` 和 ``clone(2)`` 的几个选
> +项将是安全的，并且 ``no_new_privs`` 加上 ``chroot`` 是可以被认为比 chroot本身危
> +险性小得多的。

