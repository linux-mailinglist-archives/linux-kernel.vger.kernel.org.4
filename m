Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEF46374CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiKXJII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKXJIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:08:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60042729B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:07:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4617174pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpuryGZJKM59gQIs5x5YGpBkqDs6fnHEuG6NexMes78=;
        b=yph/fRCVfCoEmq/3sBY95VkHR/nOlP3ylkcd0NGrRXBH2BJpQlhfNo4Rl0Dh51OS9I
         cwOeGCa2cWpUR3RWxVAp8ejWAm9kEkt1h+/m7/3I3wsEKAjaN4ZayHpzURom65QMyuZl
         6rVgdzQSl1UJOe5k65wvVw08IEYX//yIP5Ybnq0mWKYIFCzx+SGCHX9ZTO6PL5nD0VVi
         Loyi9S3pSxFQIykIwXjyGZvQEAL55KgAI4YQ5ynmYmlwR9YwSU5KeFf6AAGnwdPOPurl
         tRvWJMvuh7G3246tS3vjuZKpqUYcFKfu2YBjr9vFY2uMhR/+ZCh631HOOdR5vKn6SMW8
         cZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lpuryGZJKM59gQIs5x5YGpBkqDs6fnHEuG6NexMes78=;
        b=6FApLXE6MY9INY8oZLCJylwQOlhvIUOqrY+r/1y7sUyVXKx5tOniNVUk56CPyWnmUs
         KW/zvMIXpy9FDEuYIcsTvz1sFLBrp2hzX9+3w1BXpI55JFQ5j8vyEU4yIp+tdDPKZ/uB
         EJ2SbtC6pMAkGu4KVFFdUZ9GzoOeWmdVOSMHE755oUtFjB2bPOX+ZrtmRn+9XCodwtQO
         JfGTbLe7xxXGOQLIMgDq+X+7qrM5qxjMSfkyLRTjsELYB29Y9CWh5LMzpdRp2MaafYnJ
         sOvMqmV1P8Ze4uYw8PtBl1oznmQUeXvsLQ8NJymAYRTN3+rjk8NeYLDjMV4WmESZ/bJJ
         8v2w==
X-Gm-Message-State: ANoB5plfCyjbtmJo1JE4kQmfW7nj6bUwjfLNeEl71CBmxw3rpjMoH8CU
        avauQHmoVPzwp3rf3TIHh5PFUw==
X-Google-Smtp-Source: AA0mqf52kSu03psvPnVxMJ9yyk/4Fi0SHQC5rOF8pPLKol+68U6nU0Uq8541R5NhJOkasNDXNStlfQ==
X-Received: by 2002:a17:90a:7896:b0:218:6fd6:b693 with SMTP id x22-20020a17090a789600b002186fd6b693mr34771104pjk.29.1669280878873;
        Thu, 24 Nov 2022 01:07:58 -0800 (PST)
Received: from ?IPV6:2409:8962:ba17:2b8:60e7:3d11:5617:d572? ([2409:8962:ba17:2b8:60e7:3d11:5617:d572])
        by smtp.gmail.com with ESMTPSA id x189-20020a6231c6000000b0056cee8af3a6sm686346pfx.54.2022.11.24.01.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:07:58 -0800 (PST)
Message-ID: <ef54b130-e727-5ed1-1a4e-1e3c0a713b98@bytedance.com>
Date:   Thu, 24 Nov 2022 17:07:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   chenying <chenying.kernel@bytedance.com>
Subject: [PATCH] Reduce rq lock contention in load_balance()
To:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Abel Wu <wuyun.abel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenying <chenying.kernel@bytedance.com>

When doing newidle load balancing, we may have lock contention on rq->lock
while finding the same busiest rq on multiple cpus. However, it is often
the case that after the first load balancing, the busiest-rq may not be the
busiest anymore. This may lead to pointless waits for locks. For this case,
we want to use trylock to reduce rq lock contention in load_balance().

We add rq->lb_lock for the load balancing path, and uses trylock to
try to acquire the busiest rq lb_lock, if it fails, clear the
busiest rq's cpu from load_balance_mask and then goto refind.

The test results show that this patch brings ~35% rq lock contentions
reduced and no scheduling latency reduction.

unpatched:
lock_stat version 0.4
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                               class name    con-bounces    contentions 
  waittime-min   waittime-max waittime-total   waittime-avg 
acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total 
  holdtime-avg
.............................................................................................................................................................................................................................

                                &rq->lock:         24906          25996 
          0.08          27.77       43122.87           1.66 
1216316        6601547           0.05          41.59    10224267.38 
      1.55
                                ---------
                                &rq->lock           1210 
[<000000000fe88813>] scheduler_tick+0x4f/0xf0
                                &rq->lock           1885 
[<00000000de367e3c>] _nohz_idle_balance+0x116/0x250 
          &rq->lock          15111          [<00000000daf6fa95>] 
update_blocked_averages+0x30/0x6f0
                                &rq->lock           1156 
[<00000000d5c71b0e>] __schedule+0xa9/0x800
                                ---------
                                &rq->lock          15542 
[<00000000daf6fa95>] update_blocked_averages+0x30/0x6f0
                                &rq->lock            733 
[<000000000fe88813>] scheduler_tick+0x4f/0xf0
                                &rq->lock           3066 
[<000000000bc2ee47>] try_to_wake_up+0x206/0x710
                                &rq->lock           1272 
[<00000000d5c71b0e>] __schedule+0xa9/0x800

patched:
lock_stat version 0.4
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                               class name    con-bounces    contentions 
  waittime-min   waittime-max waittime-total   waittime-avg 
acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total 
  holdtime-avg
.............................................................................................................................................................................................................................

                                &rq->lock:         16174          17105 
          0.07          33.13       31154.45           1.82 
1162817        6602803           0.05          64.68    10141979.28 
      1.54
                                ---------
                                &rq->lock          11665 
[<00000000ce27c902>] update_blocked_averages+0x30/0x700
                                &rq->lock           1457 
[<00000000a6302c24>] try_to_wake_up+0x206/0x710
                                &rq->lock           1159 
[<000000009f2bc605>] __schedule+0xa9/0x810
                                &rq->lock           1411 
[<00000000aa0a6e31>] _nohz_idle_balance+0x116/0x250
                                ---------
                                &rq->lock           3032 
[<00000000a6302c24>] try_to_wake_up+0x206/0x710
                                &rq->lock            248 
[<000000008bd7e827>] load_balance+0x571/0xe80
                                &rq->lock          11502 
[<00000000ce27c902>] update_blocked_averages+0x30/0x700
                                &rq->lock           1253 
[<000000009f2bc605>] __schedule+0xa9/0x810

unpatched:
  # ./runqlat 60 1

     usecs               : count     distribution
          0 -> 1          : 1172     | 
      |
          2 -> 3          : 210063   |************************ 
      |
          4 -> 7          : 337576 
|****************************************|
          8 -> 15         : 24555    |** 
      |
         16 -> 31         : 13598    |* 
      |
         32 -> 63         : 779      | 
      |
         64 -> 127        : 230      | 
      |
        128 -> 255        : 83       | 
      |
        256 -> 511        : 54       | 
      |
        512 -> 1023       : 62       | 
      |
       1024 -> 2047       : 123      | 
      |
       2048 -> 4095       : 283      | 
      |
       4096 -> 8191       : 1362     | 
      |
       8192 -> 16383      : 2775     | 
      |
      16384 -> 32767      : 52352    |****** 
      |
      32768 -> 65535      : 14       | 
      |
      65536 -> 131071     : 140      | 
      |

  patched:
  # ./runqlat 60 1

      usecs               : count     distribution
          0 -> 1          : 1091     | 
      |
          2 -> 3          : 205259   |*********************** 
      |
          4 -> 7          : 351620 
|****************************************|
          8 -> 15         : 27812    |*** 
      |
         16 -> 31         : 13971    |* 
      |
         32 -> 63         : 727      | 
      |
         64 -> 127        : 198      | 
      |
        128 -> 255        : 103      | 
      |
        256 -> 511        : 61       | 
      |
        512 -> 1023       : 45       | 
      |
       1024 -> 2047       : 108      | 
      |
       2048 -> 4095       : 271      | 
      |
       4096 -> 8191       : 1342     | 
      |
       8192 -> 16383      : 2732     | 
      |
      16384 -> 32767      : 49367    |***** 
      |
      32768 -> 65535      : 8        | 
      |
      65536 -> 131071     : 183      | 
      |

test script:

	#!/bin/bash

	mkdir /sys/fs/cgroup/cpuset/test1
	echo 12,14,16,18,20,22 > /sys/fs/cgroup/cpuset/test1/cpuset.cpus
	echo 0 > /sys/fs/cgroup/cpuset/test1/cpuset.mems

	mkdir /sys/fs/cgroup/cpuset/test2
	echo 0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46 
 > /sys/fs/cgroup/cpuset/test2/cpuset.cpus
	echo 0 > /sys/fs/cgroup/cpuset/test2/cpuset.mems

	cgexec -g cpuset:test1 sysbench --test=cpu --cpu-max-prime=200000 run 
--num-threads=24 --rate=100 --time=6000 &
	cgexec -g cpuset:test2 sysbench --test=cpu --cpu-max-prime=200000 run 
--num-threads=96 --rate=100 --time=6000 &

Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: chenying <chenying.kernel@bytedance.com>
---
  kernel/sched/core.c  |  1 +
  kernel/sched/fair.c  | 12 ++++++++++++
  kernel/sched/sched.h |  1 +
  3 files changed, 14 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index daff72f00385..d41f1a9c7d5f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9697,6 +9697,7 @@ void __init sched_init(void)

  		rq = cpu_rq(i);
  		raw_spin_lock_init(&rq->__lock);
+		raw_spin_lock_init(&rq->lb_lock);
  		rq->nr_running = 0;
  		rq->calc_load_active = 0;
  		rq->calc_load_update = jiffies + LOAD_FREQ;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..d92c42671b99 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10295,6 +10295,7 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,
  		goto out_balanced;
  	}

+refind:
  	busiest = find_busiest_queue(&env, group);
  	if (!busiest) {
  		schedstat_inc(sd->lb_nobusyq[idle]);
@@ -10303,6 +10304,14 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,

  	WARN_ON_ONCE(busiest == env.dst_rq);

+	if (!raw_spin_trylock(&busiest->lb_lock)) {
+		__cpumask_clear_cpu(cpu_of(busiest), cpus);
+		if (cpumask_intersects(sched_group_span(group), cpus))
+			goto refind;
+
+		goto out_balanced;
+	}
+
  	schedstat_add(sd->lb_imbalance[idle], env.imbalance);

  	env.src_cpu = busiest->cpu;
@@ -10403,6 +10412,8 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,

  		/* All tasks on this runqueue were pinned by CPU affinity */
  		if (unlikely(env.flags & LBF_ALL_PINNED)) {
+			raw_spin_unlock(&busiest->lb_lock);
+
  			__cpumask_clear_cpu(cpu_of(busiest), cpus);
  			/*
  			 * Attempting to continue load balancing at the current
@@ -10420,6 +10431,7 @@ static int load_balance(int this_cpu, struct rq 
*this_rq,
  			goto out_all_pinned;
  		}
  	}
+	raw_spin_unlock(&busiest->lb_lock);

  	if (!ld_moved) {
  		schedstat_inc(sd->lb_failed[idle]);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a20046e586..384690bda8c3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -954,6 +954,7 @@ struct balance_callback {
  struct rq {
  	/* runqueue lock: */
  	raw_spinlock_t		__lock;
+	raw_spinlock_t          lb_lock;

  	/*
  	 * nr_running and cpu_load should be in the same cacheline because
-- 
2.11.0
