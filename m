Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22162702E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiKMP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMP0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:26:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45CA9FF0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:26:33 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a14so13050351wru.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TE/dWKCWY1KQycwFCPtrfPmsFGBAr28wQ2jKc0q3HHk=;
        b=2Qm6Ogp4KkJ6T74KR8ziwx3yUux1b0wQ7jWOqxBpXjQc+Aazhrz/EcaVued+IJueKR
         Alo7VP+9Py/nY9ifN45d9EkVFMvLHBEuveaQMgcJSZxIGeMEAEV6zwvdBBHrn9yfsbea
         Q2isfSpQE64jKEBdW31b3lS+5++nzuY4TcryKZwz55oE48ATigWYccoEqvM8ghWxito2
         lOdkt1RD+4mEs9QbtFaj5lmsrUSkYGTKo2ryxGst1/quBN7Nob+BGac+1MW5ASWE20no
         fkSj1s3QhdbT4w7sP/+xFZuAdlHP5ZKRPBRzAkrDkzqWiYysbKPyaTH2Yf+Jq4T6NtOV
         B5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE/dWKCWY1KQycwFCPtrfPmsFGBAr28wQ2jKc0q3HHk=;
        b=hcEXu9vire4/P8UAilRezUVHWoK2XMBuJMpnEY+7ml7+gug2/OUsIlCqrDRjhQw7wn
         49Yhn+Jm47/elzH/Z7H+/cJRwn6h+j5PnYffo4xbBynxajXhLuIMrGdZDapCPobW9A3D
         EloWRfHqDiVae1z7wVNDIiwZOWkfJwupPwQp69KtWNTRLUp82MYx9gC1KYyZjnxIoBsQ
         hsg8smdFw2OPMJ+4mtOqcwqqt3U/PsmSqj3zLKvDyCNy0+HliV+Ct3n5RPBe390g4lOL
         ix6DNWb8biu39QxSJELXGOGxmDDoP3kLnaSGXbfdp6oFBIqto9gbk2qL0Q55kZ0SOCD+
         AMXQ==
X-Gm-Message-State: ANoB5pl0P4cf18wBO5mEkBAGPHIoq48BvR/q1u1jxC7rSq7bSD7bvXuS
        6fT6/edf81iyRyujjZ0IlqRnGw==
X-Google-Smtp-Source: AA0mqf7BsDAMqBCHy7thb7rLoqIgnCjqzwgyhd9/R3sRbxssfO7Y9/NiKUknW5C6oqqylOByiEWrhA==
X-Received: by 2002:a5d:46c1:0:b0:236:88e2:2321 with SMTP id g1-20020a5d46c1000000b0023688e22321mr5194683wrs.506.1668353192110;
        Sun, 13 Nov 2022 07:26:32 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b0023c8026841csm7195460wrd.23.2022.11.13.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 07:26:31 -0800 (PST)
Date:   Sun, 13 Nov 2022 15:26:29 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     kernel test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>
Subject: Re: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
Message-ID: <20221113152629.3wbyeejsj5v33rvu@airbuntu>
References: <20221105232343.887199-1-qyousef@layalina.io>
 <202211070130.k3Om9xZt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202211070130.k3Om9xZt-lkp@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 01:47, kernel test robot wrote:
> Hi Qais,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on lwn/docs-next]
> [also build test WARNING on tip/master linus/master v6.1-rc3 next-20221104]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Qais-Yousef/Documentation-sched-Add-a-new-sched-util-clamp-rst/20221106-072619
> base:   git://git.lwn.net/linux.git docs-next
> patch link:    https://lore.kernel.org/r/20221105232343.887199-1-qyousef%40layalina.io
> patch subject: [PATCH] Documentation: sched: Add a new sched-util-clamp.rst
> reproduce:
>         # https://github.com/intel-lab-lkp/linux/commit/18b40e54df3058f348a5df25fad6baad82d28f1a
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Qais-Yousef/Documentation-sched-Add-a-new-sched-util-clamp-rst/20221106-072619
>         git checkout 18b40e54df3058f348a5df25fad6baad82d28f1a
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
>         make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> Documentation/scheduler/sched-util-clamp.rst:181: WARNING: Unexpected indentation.
> >> Documentation/scheduler/sched-util-clamp.rst: WARNING: document isn't included in any toctree

Thanks! I have the below fixup patch that addresses these. It made me realize
my html output could look better. It's cosmetic; so won't post a new version
till some feedback is provided first.


Cheers

--
Qais Yousef


--->8---

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index b430d856056a..f12d0d06de3a 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -15,6 +15,7 @@ Linux Scheduler
     sched-capacity
     sched-energy
     schedutil
+    sched-util-clamp
     sched-nice-design
     sched-rt-group
     sched-stats
diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
index e75b69767afb..728ffa364fc7 100644
--- a/Documentation/scheduler/sched-util-clamp.rst
+++ b/Documentation/scheduler/sched-util-clamp.rst
@@ -169,24 +169,27 @@ could change with implementation details.
 2.1  BUCKETS:
 -------------
 
+.. code-block:: c
+
                            [struct rq]
 
-(bottom)                                                    (top)
+  (bottom)                                                    (top)
 
-  0                                                          1024
-  |                                                           |
-  +-----------+-----------+-----------+----   ----+-----------+
-  |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
-  +-----------+-----------+-----------+----   ----+-----------+
-     :           :                                   :
-     +- p0       +- p3                               +- p4
-     :                                               :
-     +- p1                                           +- p5
-     :
-     +- p2
+    0                                                          1024
+    |                                                           |
+    +-----------+-----------+-----------+----   ----+-----------+
+    |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
+    +-----------+-----------+-----------+----   ----+-----------+
+       :           :                                   :
+       +- p0       +- p3                               +- p4
+       :                                               :
+       +- p1                                           +- p5
+       :
+       +- p2
 
 
-DISCLAMER:
+.. note::
+  DISCLAMER:
    The diagram above is an illustration rather than a true depiction of the
    internal data structure.
 
@@ -200,6 +203,8 @@ The rq has a bucket for each uclamp_id: [UCLAMP_MIN, UCLAMP_MAX].
 The range of each bucket is 1024/N. For example for the default value of 5 we
 will have 5 buckets, each of which will cover the following range:
 
+.. code-block:: c
+
         DELTA = round_closest(1024/5) = 204.8 = 205
 
         Bucket 0: [0:204]
@@ -210,6 +215,8 @@ will have 5 buckets, each of which will cover the following range:
 
 When a task p
 
+.. code-block:: c
+
         p->uclamp[UCLAMP_MIN] = 300
         p->uclamp[UCLAMP_MAX] = 1024
 
@@ -222,12 +229,16 @@ uclamp_id.
 
 When a task p is enqueued, the rq value changes as follows:
 
+.. code-block:: c
+
         // update bucket logic goes here
         rq->uclamp[UCLAMP_MIN] = max(rq->uclamp[UCLAMP_MIN], p->uclamp[UCLAMP_MIN])
         // repeat for UCLAMP_MAX
 
 When a task is p dequeued the rq value changes as follows:
 
+.. code-block:: c
+
         // update bucket logic goes here
         rq->uclamp[UCLAMP_MIN] = search_top_bucket_for_highest_value()
         // repeat for UCLAMP_MAX
@@ -249,6 +260,8 @@ another task that doesn't need it or is disallowed from reaching this point.
 For example, if there are multiple tasks attached to an rq with the following
 values:
 
+.. code-block:: c
+
         p0->uclamp[UCLAMP_MIN] = 300
         p0->uclamp[UCLAMP_MAX] = 900
 
@@ -257,6 +270,8 @@ values:
 
 then assuming both p0 and p1 are enqueued to the same rq
 
+.. code-block:: c
+
         rq->uclamp[UCLAMP_MIN] = max(300, 500) = 500
         rq->uclamp[UCLAMP_MAX] = max(900, 500) = 900
 
@@ -316,6 +331,8 @@ sched_setattr() syscall was extended to accept two new fields:
 
 For example:
 
+.. code-block:: c
+
         attr->sched_util_min = 40% * 1024;
         attr->sched_util_max = 80% * 1024;
 
@@ -333,9 +350,13 @@ default.
 Note that resetting the uclamp value to system default using -1 is not the same
 as setting the uclamp value to system default.
 
+.. code-block:: c
+
         attr->sched_util_min = -1  // p0 is reset to system default e.g: 0
 
-        not the same as
+not the same as
+
+.. code-block:: c
 
         attr->sched_util_min = 0   // p0 is set to 0, the fact it is the same
                                    // as system default is irrelevant
@@ -375,6 +396,8 @@ as follows:
 
 For example:
 
+.. code-block:: c
+
         p0->uclamp[UCLAMP_MIN] = // system default;
         p0->uclamp[UCLAMP_MAX] = // system default;
 
@@ -389,6 +412,8 @@ For example:
 
 when p0 and p1 are attached to cgroup0
 
+.. code-block:: c
+
         p0->uclamp[UCLAMP_MIN] = cgroup0->cpu.uclamp.min = 20% * 1024;
         p0->uclamp[UCLAMP_MAX] = cgroup0->cpu.uclamp.max = 60% * 1024;
 
@@ -397,6 +422,8 @@ when p0 and p1 are attached to cgroup0
 
 when p0 and p1 are attached to cgroup1
 
+.. code-block:: c
+
         p0->uclamp[UCLAMP_MIN] = cgroup1->cpu.uclamp.min = 60% * 1024;
         p0->uclamp[UCLAMP_MAX] = cgroup1->cpu.uclamp.max = 100% * 1024;
 
@@ -452,6 +479,8 @@ The value must be greater than or equal to sched_util_clamp_min.
 
 By default all SCHED_NORMAL/SCHED_OTHER tasks are initialized to:
 
+.. code-block:: c
+
         p_fair->uclamp[UCLAMP_MIN] = 0
         p_fair->uclamp[UCLAMP_MAX] = 1024
 
@@ -461,6 +490,8 @@ provide this, but can be added in the future.
 
 For SCHED_FIFO/SCHED_RR tasks:
 
+.. code-block:: c
+
         p_rt->uclamp[UCLAMP_MIN] = 1024
         p_rt->uclamp[UCLAMP_MAX] = 1024
 
@@ -564,15 +595,21 @@ still would like to keep your browser performance intact; uclamp enables that.
 
 If task p0 is capped to run at 512
 
+.. code-block:: c
+
         p0->uclamp[UCLAMP_MAX] = 512
 
 is sharing the rq with p1 which is free to run at any performance point
 
+.. code-block:: c
+
         p1->uclamp[UCLAMP_MAX] = 1024
 
 then due to max aggregation the rq will be allowed to reach max performance
 point
 
+.. code-block:: c
+
         rq->uclamp[UCLAMP_MAX] = max(512, 1024) = 1024
 
 Assuming both p0 and p1 have UCLAMP_MIN = 0, then the frequency selection for
@@ -597,16 +634,22 @@ when severely capped tasks share the rq with a small non capped task.
 
 As an example if task p
 
+.. code-block:: c
+
         p0->util_avg = 300
         p0->uclamp[UCLAMP_MAX] = 0
 
 wakes up on an idle CPU, then it will run at min frequency this CPU is capable
 of.
 
+.. code-block:: c
+
         rq->uclamp[UCLAMP_MAX] = 0
 
 If the ratio of Fmax/Fmin is 3, then
 
+.. code-block:: c
+
         300 * (Fmax/Fmin) = 900
 
 Which indicates the CPU will still see idle time since 900 is < 1024. The
@@ -614,19 +657,27 @@ _actual_ util_avg will NOT be 900 though. It will be higher than 300, but won't
 approach 900. As long as there's idle time, p->util_avg updates will be off by
 a some margin, but not proportional to Fmax/Fmin.
 
+.. code-block:: c
+
         p0->util_avg = 300 + small_error
 
 Now if the ratio of Fmax/Fmin is 4, then
 
+.. code-block:: c
+
         300 * (Fmax/Fmin) = 1200
 
 which is higher than 1024 and indicates that the CPU has no idle time. When
 this happens, then the _actual_ util_avg will become 1024.
 
+.. code-block:: c
+
         p0->util_avg = 1024
 
 If task p1 wakes up on this CPU
 
+.. code-block:: c
+
         p1->util_avg = 200
         p1->uclamp[UCLAMP_MAX] = 1024
 
@@ -634,6 +685,8 @@ then the effective UCLAMP_MAX for the CPU will be 1024 according to max
 aggregation rule. But since the capped p0 task was running and throttled
 severely, then the rq->util_avg will be 1024.
 
+.. code-block:: c
+
         p0->util_avg = 1024
         p1->util_avg = 200
 
@@ -642,6 +695,8 @@ severely, then the rq->util_avg will be 1024.
 
 Hence lead to a frequency spike since if p0 wasn't throttled we should get
 
+.. code-block:: c
+
         p0->util_avg = 300
         p1->util_avg = 200
 
