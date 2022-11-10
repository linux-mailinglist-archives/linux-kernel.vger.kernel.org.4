Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35406242CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKJNEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiKJNEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:04:10 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2C554F4;
        Thu, 10 Nov 2022 05:04:07 -0800 (PST)
Message-ID: <77cb65e1-d032-b7e3-e806-c663be8daea3@lirui.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1668085446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBCxljvJFZuUWwu9LUQoEPabdUF1Vyq8pG5TY2+2zao=;
        b=U1qf/fl688R5olFTaD1BjMcoJ3Z7QWUAvKs36aDEfOCdWIydp3wtyQH0GvLUiQRPIenWeH
        phYjvBa5nYHKNDMCzSEj/kIZz1TYuvqr6+vM2Obu83d4NgcaSOem29Mf7lstM97E+R3TEK
        irxJGV0OBOEAi1hnzdQgh+9OzX7elCfSQ5pDRBJu6boWLv88Xut5QlcNIu/FpbYQ40yEKo
        0Yo2QvDrkAuTSVpxKzj9soa+zSi+918epmqRddFWiJlrRgiXIdwNASkHVkSskvtJg1kdtN
        vs5RoTY9SDuKyImgdozrrKhT9xvaefYGFiax8biH+Kiu7cQNifVa7Gye8ekuNQ==
Date:   Thu, 10 Nov 2022 21:03:53 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] docs/zh_CN: Add userspace-api/futex2 Chinese translation
Content-Language: en-US
To:     Alex Shi <seakeel@gmail.com>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221105041741.288094-1-me@lirui.org>
 <CAJy-Am=QiK-YuntZvbVyhVatY4t3b0CFkmi2c7PTX-gomS7MYw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rui Li <me@lirui.org>
In-Reply-To: <CAJy-Am=QiK-YuntZvbVyhVatY4t3b0CFkmi2c7PTX-gomS7MYw@mail.gmail.com>
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

On 2022/11/10 17:23, Alex Shi wrote:
> On Sat, Nov 5, 2022 at 12:18 PM Rui Li <me@lirui.org> wrote:
>> Translate the following documents into Chinese:
>>
>> - userspace-api/futex2.rst
>>
>> Signed-off-by: Rui Li <me@lirui.org>
>> ---
>>  .../zh_CN/userspace-api/futex2.rst            | 80 +++++++++++++++++++
>>  .../zh_CN/userspace-api/index.rst             |  2 +-
>>  2 files changed, 81 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/translations/zh_CN/userspace-api/futex2.rst
>>
>> diff --git a/Documentation/translations/zh_CN/userspace-api/futex2.rst b/Documentation/translations/zh_CN/userspace-api/futex2.rst
>> new file mode 100644
>> index 000000000000..04f9d62db1f7
>> --- /dev/null
>> +++ b/Documentation/translations/zh_CN/userspace-api/futex2.rst
>> @@ -0,0 +1,80 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: ../disclaimer-zh_CN.rst
>> +
>> +:Original: Documentation/userspace-api/futex2.rst
>> +
>> +:翻译:
>> +
>> + 李睿 Rui Li <me@lirui.org>
>> +
>> +======
>> +futex2
>> +======
>> +
>> +:作者: André Almeida <andrealmeid@collabora.com>
>> +
>> +futex，或者称为快速用户互斥锁（fast user mutex），是一组允许用户空间创建高性能同步
>> +机制的系统调用，比如用户空间中的互斥锁，信号量和条件变量。C标准库，如glibc，使用它作
>> +为实现更多高级接口的方式，如pthreads。
>> +
>> +futex2是初代futex系统调用的后续版本，旨在克服原有接口的限制。
>> +
>> +用户API
>> +=======
>> +
>> +``futex_waitv()``
>> +-----------------
>> +
>> +等待一个futex数组，可由其中任意一个唤醒::
>> +
>> +  futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
>> +              unsigned int flags, struct timespec *timeout, clockid_t clockid)
>> +
>> +  struct futex_waitv {
>> +        __u64 val;
>> +        __u64 uaddr;
>> +        __u32 flags;
>> +        __u32 __reserved;
>> +  };
>> +
>> +用户空间设置一个struct futex_waitv数组（最多128项），设置 ``uaddr`` 为等待的
>> +地址， ``val`` 为期望值， ``flags`` 为指定的类型（如private）和futex的大小。
>> +``__reserved`` 需要置为0，但是它可用作未来扩展。指向数组第一个元素的指针作为
>> +``waiters`` 传递。如果 ``waiters`` 或任何的  ``uaddr`` 地址无效，将返回 ``-EFAULT`` 。
>> +
>> +如果用户空间拥有32位的指针，那么需要做显式转换来保证高位清零。 ``uintptr_t`` 设计
>> +得很精巧，在32/64位的指针上都正常工作。
>> +
>> +``nr_futexes`` 指定了数组的大小。不在[1,128]区间内的值会使系统调用返回 ``-EINVAL`` 。
>> +
>> +系统调用的 ``flags`` 参数需要置0，但可用作未来扩展。
>> +
>> +对于每个 ``waiters`` 数组中的项，在 ``uaddr`` 的当前值会和 ``val`` 比较。如果
>> +不一致，系统调用会撤销截至目前完成的所有工作，并返回 ``-EAGAIN`` 。如果所有测试
>> +和验证都通过，系统调用会等待直到以下情况之一发生：
>> +
>> +- 指定的timeout超时，返回 ``-ETIMEOUT`` 。
>> +- 一个信号被传递给睡眠中的任务，返回 ``-ERESTARTSYS`` 。
>> +- 某个列表中的futex被唤醒，返回那个被唤醒的futex的索引。
>> +
>> +关于如何使用接口的例子可以在 ``tools/testing/selftests/futex/functional/futex_waitv.c``
>> +中找到。
>> +
>> +超时
>> +----
>> +
>> +``struct timespec *timeout`` 是一个指向绝对超时时间的可选参数。你需要在 ``clockid``
>> +参数中指定要使用的时钟类型。支持 ``CLOCK_MONOTONIC`` 和 ``CLOCK_REALTIME`` 。这个
>> +系统调用只接受64位的timespec结构体。
>> +
>> +futex的类型
>> +-----------
>> +
>> +futex既可以是私有的也可以是共享的。私有用于多个进程共享同样的内存空间，并且futex的虚拟
>> +地址对所有进程都是一样的。这允许在内核中进行优化。要使用私有futex，需要在futex标志中指定
>> +``FUTEX_PRIVATE_FLAG`` 。对于那些不在同一内存空间共享的进程，可以让同一个futex拥有不同
>> +的虚拟地址（例如使用基于文件的共享内存），这需要不同的内部机制来使得正确进入队列。这是默认
>> +的行为，而且对私有futex和共享futex都适用。
> Good job. Just "这需要不同的内部机制来使得正确进入队列" is a bit odd. could you repolish it?
>
> To others:
> Reviewed-by: Alex Shi <alexs@kernel.org>
>
> Thanks
>
>> +
>> +futex可以是不同的大小：8，16，32或64位。目前只支持32位大小的futex，并且需要通过 ``FUTEX_32``
>> +标志指定。
>> diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
>> index dad5ba7cae6d..68b69b14b143 100644
>> --- a/Documentation/translations/zh_CN/userspace-api/index.rst
>> +++ b/Documentation/translations/zh_CN/userspace-api/index.rst
>> @@ -28,6 +28,7 @@ Linux 内核用户空间API指南
>>     seccomp_filter
>>     ebpf/index
>>     sysfs-platform_profile
>> +   futex2
>>
>>  TODOList:
>>
>> @@ -40,7 +41,6 @@ TODOList:
>>  * media/index
>>  * netlink/index
>>  * vduse
>> -* futex2
>>
>>  .. only::  subproject and html
>>
>> --
>> 2.30.2
>>
Thanks. I will think a better translation, and send updated one later.

-- 
Rui Li    0x77E6D821D7AE84FE

