Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C4D617CF8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiKCMqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiKCMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:46:33 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20A140A2;
        Thu,  3 Nov 2022 05:46:30 -0700 (PDT)
Message-ID: <5f098c8f-ec11-88a7-6297-d0e415b45290@lirui.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1667479588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJBeHs/GmyBhCzZhdAomWqp7tU5vTA2+xQrQvm1nvq8=;
        b=THhhWHXBVjlZbjMZEu6Cy5R/vWmzdXD9pqg+CZU0tSlfXMP5Y89M8wky6jdOIcOwKRId3e
        /bVbGTU60fGHrohLCroU9xuaWAHa5g0jtDLjVsauFvms/EsyHB/2YaFB/FO/c6aYAFbQ/T
        aZvcQ4CW8+BBfbyslLlUxRlHLn0AWQK8JB2J3XqRrBNDuT5IiduXmSpzQD2QGxrR1DGR0x
        LOA19xiE7fw4E5zsaG1Fv8NjT8AwpzxdaihDCsWk2e1loe0f1LFAsklCyBN5+yPWZR2+AM
        vWRvCGMoBKZmhv030NQ1peVR6IDlSxyJvTYwdNB90vSt4lxledsmGQvuh48y3w==
Date:   Thu, 3 Nov 2022 20:46:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/seccomp_filter Chinese
 translation
Content-Language: en-US
To:     Wu XiangCheng <wu.xiangcheng@linux.dev>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221101122843.218114-1-me@lirui.org>
 <Y2JtdC+UfKfCgrZ/@bobwxc.mipc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rui Li <me@lirui.org>
In-Reply-To: <Y2JtdC+UfKfCgrZ/@bobwxc.mipc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/2 21:15, Wu XiangCheng wrote:
> Hi,
>
>> Translate the following documents into Chinese:
>>
>> - userspace-api/seccomp_filter.rst
>>
>> Also adjust index order according to the original index file.
>>
>> Signed-off-by: Rui Li <me@lirui.org>
>> ---
>>  .../zh_CN/userspace-api/index.rst             |   4 +-
>>  .../zh_CN/userspace-api/seccomp_filter.rst    | 291 ++++++++++++++++++
>>  2 files changed, 293 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/translations/zh_CN/userspace-api/seccomp_filter.rst
>>
>> diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
>> index 0f3483a46fa2..dad5ba7cae6d 100644
>> --- a/Documentation/translations/zh_CN/userspace-api/index.rst
>> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
>> @@ -24,13 +24,13 @@ Linux 内核用户空间API指南
>>  .. toctree::
>>     :maxdepth: 2
>>  
>> -   ebpf/index
>>     no_new_privs
>> +   seccomp_filter
>> +   ebpf/index
>>     sysfs-platform_profile
>>  
>>  TODOList:
>>  
>> -* seccomp_filter
>>  * landlock
>>  * unshare
>>  * spec_ctrl
>> diff --git a/Documentation/translations/zh_CN/userspace-api/seccomp_filter.rst b/Documentation/translations/zh_CN/userspace-api/seccomp_filter.rst
>> new file mode 100644
>> index 000000000000..24c3b18eb727
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/userspace-api/seccomp_filter.rst
>> @@ -0,0 +1,291 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/userspace-api/seccomp_filter.rst
>> +
>> +:翻译:
>> +
>> + 李睿 Rui Li <me@lirui.org>
>> +
>> +==================================
>> +Seccomp BPF (基于过滤器的安全计算)
>> +==================================
> Add a note line here? Like:
>
> *Seccomp: SECure COMPuting*
>
>> +
>> +介绍
>> +=====
> 4*=
>
>> +
>> +大量系统调用被暴露给每个用户空间进程，但其中又有许多系统调用在进程的整个生命
>> +周期中都没被使用。随着系统调用的改变和成熟，缺陷被找到并消除。允许某一部分应
>> +用程序仅能访问一部分系统调用是有好处的，这会减少内核暴露给应用程序的面积。
>> +系统调用过滤器就是为这些应用程序而生的。
>> [...]
>> +值得注意的是， ``struct seccomp_data`` 包含了系统调用寄存器参数的值，但是不包含指向
>> +内存的指针。任务的内存可以通过  ``ptrace()`` 或 ``/proc/pid/mem`` 由合适的特权跟踪
>> +访问。但是，需要注意避免之前提到的TOCTOU攻击：所有从被跟踪者内存中读到的参数都应该先
>> +读到追踪器的内存中，再做出策略决定。这样就可以对系统调用的参数做源自决定。
> 源自 -> 原子
>
>> +
>> +Sysctls
>> +=======
>> +
>> +Seccomp的sysctl文件可以在 ``/proc/sys/kernel/seccomp/`` 文件夹中找到。这里有对文件
>> +夹中每个文件的描述：
>> +
>> +``actions_avail``:
>> +	以字符串形式保存seccomp保存值（参考上文的 ``SECCOMP_RET_*`` 宏）的只读有序
> 保存值 -> 返回值
>
>> +	列表。从左往右按照最少许可返回值到最多许可返回值排序。
>> +
>> +	这个列表代表了内核支持的seccomp返回值集合。一个用户空间程序可以使用这个列表来在
>> +	程序建立时确定在 ``seccomp.h`` 中找到的动作是否和当前运行内核实际支持的动作有所
>> +	不同。
>> +
>> +``actions_logged``:
>> +	允许被记录的seccomp保存值（参考上文的 ``SECCOMP_RET_*`` 宏）的可读写有序列表。
> 保存值 -> 返回值
>
>> +	对文件写入不需要是有序的，但从文件读取将与actions_avail sysctl一致的方式排序。
>> +
>> +	``allow`` 字符串在 ``actions_logged`` sysctl中不被接收，因为不可能记录
>> +	``SECCOMP_RET_ALLOW`` 动作。尝试向sysctl写入 ``allow`` 会导致返回一个EINVAL。
>> +
>> +添加架构支持
>> +============
>> +
>> +请查看 ``arch/Kconfig`` 了解权威要求。总的来说如果一个架构同时支持ptrace_event和
>> +seccomp，那么它将可以通过较小的修改支持seccomp过滤器： ``SIGSYS`` 支持和seccomp
>> +返回值检查。然后必须将 ``CONFIG_HAVE_ARCH_SECCOMP_FILTER`` 添加到它的架构特定
>> +的Kconfig中。
>> +
>> +注意事项
>> +========
>> +
>> +vDSO可能导致一些系统调用完全在用户空间中运行，当你在不同机器上跑程序时可能导致回退
>> +到真正系统调用的意外发生。为了在x86上最小化这些意外的发生，请确保你在测试时把
>> +``/sys/devices/system/clocksource/clocksource0/current_clocksource`` 设置为
>> +``acpi_pm`` 之类的值。
>> +
>> +在x86-64上，vsyscall模拟默认开启。（vsyscalls是vDSO调用的传统变体。）目前，模拟
>> +vsyscalls会遵守seccomp，但是有一些奇怪情况：
>> +
>> +- ``SECCOMP_RET_TRAP`` 的返回值会设置一个指向给定vsyscall入口的 ``si_call_addr``，
>> +  而不是'syscall'指令之后的地址。任何想重新开始调用的代码都需要注意 (a) 返回指令
> 返回指令 -> ret指令
>
> Thanks,
> 	Wu
Thank you so much for correction and advice. :)

-- 
Rui Li    0x77E6D821D7AE84FE

