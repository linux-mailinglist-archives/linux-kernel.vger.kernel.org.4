Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C7868CE47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBGEh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGEhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:37:54 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCDB273A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:37:53 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id cf30so11722395ybb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 20:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+0HCTBEcnsuxpAkRihzgpFaUXcz4XpnRKbh++S1fF8=;
        b=nHsuftEo1aQKAm2ZVJ/nFPa+zRmJiiAJ7Qf7sD4IoESSTSeTpJDLVKSFlNEcbWekKT
         KdvTghoizpNwfkkusRa79/zDsO6GB0sSgC7prCC31jW2jV98LvutYHPv8BSK8gXYdhXo
         A3CBp4zptXI5fQ5V/v2yqYYiLin1bLJnS42gUbhcMk4PgH8RMfDs0/+r7Fk2+7DnZA1w
         DmRk/qB1WCLo8tyA03l2t65T5a09cDkzb6HCVNZ1KXH+bYEDoAdetqzzXuRc8E4nMcZW
         vezJNgkjvTufTswBsUjI0GfhOjMj6kNKd6YuNCQ5UcZ/wmK59xLhm8yB1AW3GhzBRnDL
         rSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+0HCTBEcnsuxpAkRihzgpFaUXcz4XpnRKbh++S1fF8=;
        b=kAZ6kL882NLVGc2pzqdK9gbgzYvbcydAQaNq2Tum+A+WI2FJfmhfEvq34v0LTf2bJ5
         oPMWcwT8hkGEC24CXz2ZlH7BQ2RAUJLAEn6FOCdMrLD14ouTrTp7ULk2pufTjmX6262t
         tXM3Kf7PfqHRMyRWGuG7rIb0k0x0PnZVKQM+EScKjxMEBtImnuScbDyKud8xKZj0jZ2g
         wtaPI11qd2hrrVbhuovR3OZYewryCmAgDboapQlJLOtjTNnRhzOH6vkqEEhxdSInHqqE
         5Qi17JcPZxW5RdDKFa/6nh5aURIPykA2Vgr+Anm/SKZWyWVwgbQZBqgtn0RPFxB7Py4H
         uG5g==
X-Gm-Message-State: AO0yUKXDudMLzJoG7TvRWfH650qDHvV/VDef0soL1t3JSJEc6CciA3Sc
        374pXkFy+vuI32SXPZ7mmfPOi3UrUIZTP8cjrrZx
X-Google-Smtp-Source: AK7set86jCFE95r0neU15sUjMrj5DOmSBeC4ESEUxmd0FJ68H6d3XGaqiZEAL2yyyMYLeaLE54lrOfm5ubSX6AA6x0k=
X-Received: by 2002:a25:9e08:0:b0:7ba:e354:5aaf with SMTP id
 m8-20020a259e08000000b007bae3545aafmr246105ybq.37.1675744672187; Mon, 06 Feb
 2023 20:37:52 -0800 (PST)
MIME-Version: 1.0
References: <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
 <20230117082508.8953-1-jaewon31.kim@samsung.com> <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
 <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
 <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
 <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
 <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com>
 <20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed@epcms1p3>
 <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p8>
 <CANDhNCo1JRmfouBn985GZLmPY-xLn9JKNJfubY0PAUrCpY8K4g@mail.gmail.com> <20230204150215epcms1p8d466d002c1e4dc2005d38f847adea6fa@epcms1p8>
In-Reply-To: <20230204150215epcms1p8d466d002c1e4dc2005d38f847adea6fa@epcms1p8>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 6 Feb 2023 20:37:40 -0800
Message-ID: <CANDhNCrAMVT3rg0GPJhYKD75EAUn8bsivrp3yMJcsd6bouj1rQ@mail.gmail.com>
Subject: Re: (2) [PATCH] dma-buf: system_heap: avoid reclaim for order 4
To:     jaewon31.kim@samsung.com
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023 at 7:02 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> Hello John Stultz, sorry for late reply.
> I had to manage other urgent things and this test also took some time to finish.
> Any I hope you to be happy with following my test results.
>
>
> 1. system heap modification
>
> To avoid effect of allocation from the pool, all the freed dma
> buffer were passed to buddy without keeping them in the pool.
> Some trace_printk and order counting logic were added.
>
> 2. the test tool
>
> To test the dma-buf system heap allocation speed, I prepared
> a userspace test program which requests a specified size to a heap.
> With the program, I tried to request 16 times of 10 MB size and
> added 1 sleep between each request. Each memory was not freed
> until the total 16 times total memory was allocated.

Oof. I really appreciate all your effort that I'm sure went in to
generate these numbers, but  this wasn't quite what I was asking for.
I know you've been focused on allocation performance under memory
pressure, but I was hoping to see the impact of __using__ order 0
pages over order 4 pages in real world conditions (for camera or video
recording or other use cases that use large allocations). These
results seem to be still just focused on the difference in allocation
performance between order 0 and order 4 with and without contention.

That said, re-reading my email, I probably could have been more clear
on this aspect.


> 3. the test device
>
> The test device has arm64 CPU cores and v5.15 based kernel.
> To get stable results, the CPU clock was fixed not to be changed
> in run time, and the test tool was set to some specific CPU cores
> running in the same CPU clock.
>
> 4. test results
>
> As we expected if order 4 exist in the buddy, the order 8, 4, 0
> allocation was 1 to 4 times faster than the order 8, 0, 0. But
> the order 8, 0, 0 also looks fast enough.
>
> Here's time diff, and number of each order.
>
> order 8, 4, 0 in the enough order 4 case
>
>          diff   8       4       0
>      665 usec   0       160     0
>    1,148 usec   0       160     0
>    1,089 usec   0       160     0
>    1,154 usec   0       160     0
>    1,264 usec   0       160     0
>    1,414 usec   0       160     0
>      873 usec   0       160     0
>    1,148 usec   0       160     0
>    1,158 usec   0       160     0
>    1,139 usec   0       160     0
>    1,169 usec   0       160     0
>    1,174 usec   0       160     0
>    1,210 usec   0       160     0
>      995 usec   0       160     0
>    1,151 usec   0       160     0
>      977 usec   0       160     0
>
> order 8, 0, 0 in the enough order 4 case
>
>          diff   8       4       0
>      441 usec   10      0       0
>      747 usec   10      0       0
>    2,330 usec   2       0       2048
>    2,469 usec   0       0       2560
>    2,518 usec   0       0       2560
>    1,176 usec   0       0       2560
>    1,487 usec   0       0       2560
>    1,402 usec   0       0       2560
>    1,449 usec   0       0       2560
>    1,330 usec   0       0       2560
>    1,089 usec   0       0       2560
>    1,481 usec   0       0       2560
>    1,326 usec   0       0       2560
>    3,057 usec   0       0       2560
>    2,758 usec   0       0       2560
>    3,271 usec   0       0       2560
>
> From the perspective of responsiveness, the deterministic
> memory allocation speed, I think, is quite important. So I
> tested other case where the free memory are not enough.
>
> On this test, I ran the 16 times allocation sets twice
> consecutively. Then it showed the first set order 8, 4, 0
> became very slow and varied, but the second set became
> faster because of the already created the high order.
>
> order 8, 4, 0 in low memory
>
>          diff   8       4       0
>      584 usec   0       160     0
>   28,428 usec   0       160     0
>  100,701 usec   0       160     0
>   76,645 usec   0       160     0
>   25,522 usec   0       160     0
>   38,798 usec   0       160     0
>   89,012 usec   0       160     0
>   23,015 usec   0       160     0
>   73,360 usec   0       160     0
>   76,953 usec   0       160     0
>   31,492 usec   0       160     0
>   75,889 usec   0       160     0
>   84,551 usec   0       160     0
>   84,352 usec   0       160     0
>   57,103 usec   0       160     0
>   93,452 usec   0       160     0
>
>          diff   8       4       0
>      808 usec   10      0       0
>      778 usec   4       96      0
>      829 usec   0       160     0
>      700 usec   0       160     0
>      937 usec   0       160     0
>      651 usec   0       160     0
>      636 usec   0       160     0
>      811 usec   0       160     0
>      622 usec   0       160     0
>      674 usec   0       160     0
>      677 usec   0       160     0
>      738 usec   0       160     0
>    1,130 usec   0       160     0
>      677 usec   0       160     0
>      553 usec   0       160     0
>    1,048 usec   0       160     0
>
>
> order 8, 0, 0 in low memory
>
>         diff    8       4       0
>   1,699 usec    2       0       2048
>   2,082 usec    0       0       2560
>     840 usec    0       0       2560
>     875 usec    0       0       2560
>     845 usec    0       0       2560
>   1,706 usec    0       0       2560
>     967 usec    0       0       2560
>   1,000 usec    0       0       2560
>   1,905 usec    0       0       2560
>   2,451 usec    0       0       2560
>   3,384 usec    0       0       2560
>   2,397 usec    0       0       2560
>   3,171 usec    0       0       2560
>   2,376 usec    0       0       2560
>   3,347 usec    0       0       2560
>   2,554 usec    0       0       2560
>
>        diff     8       4       0
>  1,409 usec     2       0       2048
>  1,438 usec     0       0       2560
>  1,035 usec     0       0       2560
>  1,108 usec     0       0       2560
>    825 usec     0       0       2560
>    927 usec     0       0       2560
>  1,931 usec     0       0       2560
>  2,024 usec     0       0       2560
>  1,884 usec     0       0       2560
>  1,769 usec     0       0       2560
>  2,136 usec     0       0       2560
>  1,738 usec     0       0       2560
>  1,328 usec     0       0       2560
>  1,438 usec     0       0       2560
>  1,972 usec     0       0       2560
>  2,963 usec     0       0       2560

So, thank you for generating all of this. I think this all looks as
expected, showing the benefit of your change to allocation under
contention and showing the potential downside in the non-contention
case.

I still worry about the performance impact outside of allocation time
of using the smaller order pages (via map and unmap through iommu to
devices, etc), so it would still be nice to have some confidence this
won't introduce other regressions, but I do agree the worse case
impact is very bad.

> Finally if we change order 4 to use HIGH_ORDER_GFP,
> I expect that we could avoid the very slow cases.
>

Yeah. Again, this all aligns with the upside of your changes, which
I'm eager for.
I just want to have a strong sense of any regressions it might also cause.

I don't mean to discourage you, especially after all the effort here.
Do you think evaluating the before and after impact to buffer usage
(not just allocation) would be doable in the near term?

If you don't think so, given the benefit to allocation under pressure
is large (and I don't mean to give you hurdles to jump), I'm willing
to ack your change to get it merged, but if we later see performance
trouble, I'll be quick to advocate for reverting it.  Is that ok?

thanks
-john
