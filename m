Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449036FD402
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjEJDIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEJDIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:08:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681D2703
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:08:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643990c5373so6603148b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683688091; x=1686280091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=C9PwoT9duAavJS8s+p5CuyuLX7BseRfO8juntKgv42o=;
        b=ctdVFaRIxyeEKOu2W4YIc/naAkQsLrd70upydX2LJpmnDMCM+urrGY26KAxG9gTaB3
         VFQLJ+EJw6ocFbf4B7KVtCEqXXlYPm4rlUdRZCUWntszU/u6qT7uAT+yVNKRnvuKraLE
         oZejDDTP2N7rXLXjNVFV+M/IpRxFvKNEtu0xLo4AKe712l/uskUOhnyCjhpvTwYw6hfC
         79UW3rNtZUzVZjUXX4UVy/BuilMRXyWVx3PLuO7EOQmXbx9lKogG1FFepyrTPqUL0coe
         vnibNo3+spvu4mW99d8c7wVcrd9eWnpNhdkyNOQDqjBeNLVtXPOI+cShU15bgcbporMG
         UasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688091; x=1686280091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9PwoT9duAavJS8s+p5CuyuLX7BseRfO8juntKgv42o=;
        b=V0OvaMbV/3I6/01aFBJCdjRqTBetwhD46N/hF2wm0qwWERLWT8q09Ve3buHztKdzeE
         0h1c8OgFEx95Tv7+ePHcUQaszU1xWjUXUfc1gsiA6p7Na6Eb+Yt57DMdDCqoTfpcuM65
         T9RTA0SeTtF0KN7dsStAlaEbIL24Z0yjkXlvmLHC1cH+xj0lkhb7DGevsxE3AfwsmfP9
         TYusX4X2/H/J9NZP4fhv9IbO81Uj/03tjEobRYxvZREn6Gv/Pr78pz/DNv15rRifqMqr
         tn/JDH6dHCFdXrBW7lsbQUy+Zmcqeet+Ly+pf0+9v2r2ENv1NeR9aMugjzXDVm+z5Y54
         753g==
X-Gm-Message-State: AC+VfDwsC0JM3bVAMbX2GM1Tpim922snPfA2VjxmBXKdbuFYZ8NVz+il
        qTNZI9kTaPETT/qPmiFFLk1hnoeBzww=
X-Google-Smtp-Source: ACHHUZ7ZsSOmrW94nfFTyksHJbLysaAso7syek6ihBBDfegwH+a3VgDKpVXcTBGsG4Vk7MAUycYZWw==
X-Received: by 2002:a05:6a00:10cd:b0:645:fc7b:63d6 with SMTP id d13-20020a056a0010cd00b00645fc7b63d6mr11487506pfu.6.1683688091176;
        Tue, 09 May 2023 20:08:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b0063b54ccc123sm2443307pfb.196.2023.05.09.20.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:08:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCHSET v2 wq/for-6.5] workqueue: Implement automatic CPU intensive detection and add monitoring
Date:   Tue,  9 May 2023 17:07:46 -1000
Message-Id: <20230510030752.542340-1-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: * Lai pointed out that !SM_NONE cases should also be notified. 0001 and
      0004 are updated accordingly.

    * PeterZ suggested reporting on work items that trigger the auto CPU
      intensive mechanism. 0006 adds reporting of work functions that
      trigger the mechanism repeatedly with exponential backoff.

Hello,

To reduce the number of concurrent worker threads, workqueue holds back
starting per-cpu work items while the previous work item stays in the
RUNNING state. As such a per-cpu work item which consumes a lot of CPU
cycles, even if it has cond_resched()'s in the right places, can stall other
per-cpu work items.

To support per-cpu work items that may occupy the CPU for a substantial
period of time, workqueue has WQ_CPU_INTENSIVE flag which exempts work items
issued through the marked workqueue from concurrency management - they're
started immediately and don't block other work items. While this works, it's
error-prone in that a workqueue user can easily forget to set the flag or
set it unnecessarily. Furthermore, the impacts of the wrong flag setting can
be rather indirect and challenging to root-cause.

This patchset makes workqueue auto-detect CPU intensive work items based on
CPU consumption. If a work item consumes more than the threshold (5ms by
default) of CPU time, it's automatically marked as CPU intensive when it
gets scheduled out which unblocks starting of pending per-cpu work items.

The mechanism isn't foolproof in that the detection delays can add up if
many CPU-hogging work items are queued at the same time. However, in such
situations, the bigger problem likely is the CPU being saturated with
per-cpu work items and the solution would be making them UNBOUND. Future
changes will make UNBOUND workqueues more attractive by improving their
locality behaviors and configurability. We might eventually remove the
explicit WQ_CPU_INTENSIVE flag.

While at it, add statistics and a monitoring script. Lack of visibility has
always been a bit of pain point when debugging workqueue related issues and
with this change and more drastic ones planned for workqueue, this is a good
time to address the shortcoming.

This patchset was born out of the discussion in the following thread:

 https://lkml.kernel.org/r/CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com

and contains the following five patches:

 0001-workqueue-sched-Notify-workqueue-of-scheduling-of-RU.patch
 0002-workqueue-Re-order-struct-worker-fields.patch
 0003-workqueue-Move-worker_set-clr_flags-upwards.patch
 0004-workqueue-Automatically-mark-CPU-hogging-work-items-.patch
 0005-workqueue-Report-work-funcs-that-trigger-automatic-C.patch
 0006-workqueue-Add-pwq-stats-and-a-monitoring-script.patch

and also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git auto-cpu-intensive-v2

diffstat follows. Thanks.

 Documentation/core-api/workqueue.rst |   30 ++
 kernel/sched/core.c                  |   48 ++--
 kernel/workqueue.c                   |  364 +++++++++++++++++++++++++++--------
 kernel/workqueue_internal.h          |   14 -
 lib/Kconfig.debug                    |   13 +
 tools/workqueue/wq_monitor.py        |  148 ++++++++++++++
 6 files changed, 513 insertions(+), 104 deletions(-)

--
tejun

