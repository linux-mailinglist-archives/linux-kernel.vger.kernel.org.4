Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6C0616F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiKBVKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBVKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:10:07 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55756DEE2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:10:05 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221102210959euoutp0193aba5429eeec5e50b20aac83a982306~j4L9GiRvq2701027010euoutp01w
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 21:09:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221102210959euoutp0193aba5429eeec5e50b20aac83a982306~j4L9GiRvq2701027010euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667423399;
        bh=Kg/3YSQS2ju6IWjYQjmxTOS7Mgb/Tgi9X6kUI85rHJo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=DUlC3Q50KFLoNUhVWR4nm9vS2xLFPzGkXsNnczG3FVD0lBW4Qzwo3qAarL/HeLrOH
         wv9JfLwGX15mbdR4nB3LBGxKJGI8gM3ogOv+qC6DGB6OOfKVE0FuwuQU0+OCpHF7tt
         CT1M68mu9nrl8nvHTPr/NgbEq6L99xORGikwhzk8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221102210958eucas1p1d49b35487b4da87e8134b8ffe55ea948~j4L8J36VP1568615686eucas1p1E;
        Wed,  2 Nov 2022 21:09:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 76.F6.07817.6ACD2636; Wed,  2
        Nov 2022 21:09:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd~j4L74XeyT2854128541eucas1p2S;
        Wed,  2 Nov 2022 21:09:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221102210957eusmtrp22a9cb8b5a466ef1663cc2c06f55e1be7~j4L7yS4iL0448804488eusmtrp2x;
        Wed,  2 Nov 2022 21:09:57 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-a3-6362dca62d48
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AA.B3.07473.5ACD2636; Wed,  2
        Nov 2022 21:09:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221102210957eusmtip257a1995496edf59b19eab9669c7f2726~j4L7etzJc2005020050eusmtip2-;
        Wed,  2 Nov 2022 21:09:57 +0000 (GMT)
Message-ID: <fb370ccf-d22a-7885-1773-da85c9d7ea8c@samsung.com>
Date:   Wed, 2 Nov 2022 22:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] mm: convert mm's rss stats into percpu_counter
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20221024052841.3291983-1-shakeelb@google.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzned1ld5KSDdpXsFvMWb+GzeLyrjls
        FvfW/Ge1OHjtNaMDi8eCTaUemz5NYvc4MeM3i8fnTXIBLFFcNimpOZllqUX6dglcGVOOnWcv
        eC5W8X/HZrYGxmlCXYycHBICJhLrl5xl6mLk4hASWMEosfrVS3YI5wujxN41q6Aynxkl5k28
        yQTTcmP+QqjEckaJpkVvoFo+MkrseHYZyGHn4BWwk5hTA1LPIqAi8WfbRlYQm1dAUOLkzCcs
        ILaoQIrE7u5tYLawgLPEsaVTwWxmAXGJW0/mg+0SEQiWWPbkCDNE3ETifutDsDlsAoYSXW+7
        2EBsTgFriaUzdrJC1MhLbH87hxnkHAmBIxwSd+5eYIQ42kXi08NPbBC2sMSr41vYIWwZif87
        5zNBNLQzSiz4fR/KmcAo0fD8FlS3tcSdc7+AujmAVmhKrN+lDxF2lLi6bi4LSFhCgE/ixltB
        iCP4JCZtm84MEeaV6GiDBrWaxKzj6+DWHrxwiXkCo9IspGCZheT9WUjemYWwdwEjyypG8dTS
        4tz01GKjvNRyveLE3OLSvHS95PzcTYzAxHL63/EvOxiXv/qod4iRiYPxEKMEB7OSCG/92ehk
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxsM7SShQTSE0tSs1NTC1KLYLJMHJxSDUzZZ3jf5ezc
        VCDiFzFP8t+n/b3eNg6JfpFrOb+sWsq9avl7zz5W26m27+5eCTh31TTwqPPO+zwda69pT7D+
        dndBRlPS4z9bW0wtuHfPeFZ9/UZXa+RBeRMp1zl6vCuERBc/3zk7Wn9NYMtdW62ZUc/KmtZs
        2zRvpUzX7auvyqX6TprXtkyyeqqd9rfXR3T+zA37Zjv71E23WMOf2n19pnmITPbjq3d3HHkq
        8MK4yXOjLJfim7OXV3h867zypGn/2Xmv/gde/fv85cZDbjc2uxzib7ASZ+Dlf7mXoWC5H3O1
        gI70OUVWB/3IcyafJh/eE3t2ypWDlfPUtv3y7xfborG0RbvhbotqfcKxc/LXd9u+UmIpzkg0
        1GIuKk4EANTF/sSbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7pL7yQlG1x/qWUxZ/0aNovLu+aw
        Wdxb85/V4uC114wOLB4LNpV6bPo0id3jxIzfLB6fN8kFsETp2RTll5akKmTkF5fYKkUbWhjp
        GVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUw5dp694LlYxf8dm9kaGKcJdTFyckgI
        mEjcmL+QqYuRi0NIYCmjxM6HvYwQCRmJk9MaWCFsYYk/17rYIIreM0psvn8NqIOdg1fATmJO
        DUgJi4CKxJ9tG8HKeQUEJU7OfMLSxcjBISqQIvHtXB1IWFjAWeLY0qksIDazgLjErSfzmUBK
        RASCJe6tVoYIm0jcb30INkVIwEri8/07YMewCRhKdL0FOYCTg1PAWmLpjJ2sEPVmEl1buxgh
        bHmJ7W/nME9gFJqF5IhZSLbNQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIEx
        tO3Yz807GOe9+qh3iJGJg/EQowQHs5IIb/3Z6GQh3pTEyqrUovz4otKc1OJDjKbAkJjILCWa
        nA+M4rySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBiYhQ5XNp6y5
        LSadED9aelEh+OzEwzI3O58IC99ju5RQ/knrmWpTaOeN9p1SVt7n7z9XmqP4/lXc2cmMcfnd
        3z0vxc2bWXM77q0YV84CI//qF32Ouaa3tW91TElfyaj4T9Bk58H5t4uqKvxT4sVTiu+f0inU
        mJrGnXbqr6X0UvePajJxXX9XLL7+XK9oUcI5lrCSCs6WkmlRawQn+3rzP/a5fHuP69pVrwXN
        FiQq6qhtnHiBddmHMy8Ontc72snpb93GMFtTb5nfgYTqnYz2egtEwxfkTTmTFbZEbNK5by29
        Yuxaa0z3GAW09rz1+9/I2FIuKXpSZN4zt9J1Kb5PCwNXz951PrdR6cgby81bTiixFGckGmox
        FxUnAgDXRWACKgMAAA==
X-CMS-MailID: 20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd
References: <20221024052841.3291983-1-shakeelb@google.com>
        <CGME20221102210957eucas1p2915f88d8b923ccf79f0e8770d208a1bd@eucas1p2.samsung.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 24.10.2022 07:28, Shakeel Butt wrote:
> Currently mm_struct maintains rss_stats which are updated on page fault
> and the unmapping codepaths. For page fault codepath the updates are
> cached per thread with the batch of TASK_RSS_EVENTS_THRESH which is 64.
> The reason for caching is performance for multithreaded applications
> otherwise the rss_stats updates may become hotspot for such
> applications.
>
> However this optimization comes with the cost of error margin in the rss
> stats. The rss_stats for applications with large number of threads can
> be very skewed. At worst the error margin is (nr_threads * 64) and we
> have a lot of applications with 100s of threads, so the error margin can
> be very high. Internally we had to reduce TASK_RSS_EVENTS_THRESH to 32.
>
> Recently we started seeing the unbounded errors for rss_stats for
> specific applications which use TCP rx0cp. It seems like
> vm_insert_pages() codepath does not sync rss_stats at all.
>
> This patch converts the rss_stats into percpu_counter to convert the
> error margin from (nr_threads * 64) to approximately (nr_cpus ^ 2).
> However this conversion enable us to get the accurate stats for
> situations where accuracy is more important than the cpu cost. Though
> this patch does not make such tradeoffs.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

This patch landed recently in linux-next as commit d59f19a7a068 ("mm: 
convert mm's rss stats into percpu_counter"). Unfortunately it causes a 
regression on my test systems. I've noticed that it triggers a 'BUG: Bad 
rss-counter state' warning from time to time for random processes. This 
is somehow related to CPU hot-plug and/or system suspend/resume. The 
easiest way to reproduce this issue (although not always) on my test 
systems (ARM or ARM64 based) is to run the following commands:

root@target:~# for i in /sys/devices/system/cpu/cpu[1-9]; do echo 0 
 >$i/online;
BUG: Bad rss-counter state mm:f04c7160 type:MM_FILEPAGES val:1
BUG: Bad rss-counter state mm:50f1f502 type:MM_FILEPAGES val:2
BUG: Bad rss-counter state mm:50f1f502 type:MM_ANONPAGES val:15
BUG: Bad rss-counter state mm:63660fd0 type:MM_FILEPAGES val:2
BUG: Bad rss-counter state mm:63660fd0 type:MM_ANONPAGES val:15

Let me know if I can help debugging this somehow or testing a fix.

> ---
>   include/linux/mm.h             | 26 ++++--------
>   include/linux/mm_types.h       |  7 +---
>   include/linux/mm_types_task.h  | 13 ------
>   include/linux/percpu_counter.h |  1 -
>   include/linux/sched.h          |  3 --
>   include/trace/events/kmem.h    |  8 ++--
>   kernel/fork.c                  | 16 +++++++-
>   mm/memory.c                    | 73 +++++-----------------------------
>   8 files changed, 40 insertions(+), 107 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

