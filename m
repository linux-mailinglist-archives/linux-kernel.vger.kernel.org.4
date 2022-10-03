Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273175F3808
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJCVqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJCVqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:46:01 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986C1F63F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:45:23 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id z9-20020a17090a468900b00202fdb32ba1so5708284pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=WKUdDwUXNtZRx5PjFvn2A/V+Qo15qrWo556Rc6AuXP4=;
        b=btxKBJ0ghzjh53LxOr6O1JryCayAw9ytuBX5kUVLRfG7fvMsrgjFD7QjMNd47QXvRy
         4f5LBACa7dkFrJig2qDVxE9hEANHoDnk8bWbH+R/Q/gbUJdoCa34DRPU2KDmXOgqiwdC
         V8F1TNuYh6giWq5StIIzsmsneJcLittlBNmoJby2pXmSgim/xJeVDbA7cfLAkyrEf9eW
         NN2MFFxy0a0aY84A3Ym1Zi4/y2Np7/2eVYY/vMvnteesUIdWUe4OvigAeEHuSHfZ74Pc
         01T+mPEMdFNdaQas5GOL538mjtIiE8ZJNDnY1zRUq98Rbk2El4YuUu9E2YTOC2//UDki
         1IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=WKUdDwUXNtZRx5PjFvn2A/V+Qo15qrWo556Rc6AuXP4=;
        b=AgjgSWPyC07WOJ1I2SXWKEO6xyz+/kmVmhyHWHRXQi1pAeL/PeKqLDGsh09+Xly1OZ
         TTNVN2aEl4zx+S3jO7J5tCayef1EFjhFYDF7mqxFhUbYLkp7x6221mz1gftX0J6B3QZN
         vYs6y+vFHISkhrCoKhH+eOldlWpxSeC1Y/9+9VOAa/z/hWcQmkAZrOJt/6XOOYqkx+KW
         07gMtVrJyYNsRwS26KwSP/VvVjgTaZmQh5LDtwPHNNDiGmjZHXaNImyEaQ3K+3Ls2OSE
         8FC2+wMoQOPJNIQfLTSidovIc/ZwBU+K3674tjFMQDKmA/gf+Eizs9sjc5hx+bnatnT3
         ENng==
X-Gm-Message-State: ACrzQf082jWNBScGTr3G7C23TSswJKh6eN1Ya5qwC0MFHMX2D5ACqluF
        ceSl321lIwZFmuuRb2Ps3vvB/ch4FEEuMqpIQJyW9n37IV8jjPAtz9giGvPC/PRhB+CgdvKvkJF
        YeVvqGR3ieIJCdo7sNodtQdypokSDb5h1ndmNLyk61zksjz9KYFkVT95gP57Xtjd1xohEv5lw
X-Google-Smtp-Source: AMsMyM6/7KgjqX2wNR8Jh0KD57y1OZR6ISf6weJ2ikFPnadFJnm3cRqqWjt3iJgVneEGkiC2Sq/7z/CJNigV
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a17:902:db12:b0:178:1f91:74e6 with SMTP id
 m18-20020a170902db1200b001781f9174e6mr24370700plx.100.1664833521452; Mon, 03
 Oct 2022 14:45:21 -0700 (PDT)
Date:   Mon,  3 Oct 2022 21:45:00 +0000
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
Mime-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003214501.2050087-11-connoro@google.com>
Subject: [RFC PATCH 10/11] torture: support randomized shuffling for proxy
 exec testing
From:   "Connor O'Brien" <connoro@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quick hack to better surface bugs in proxy execution.

Shuffling sets the same cpu affinities for all tasks, which makes us
less likely to hit paths involving migrating blocked tasks onto a cpu
where they can't run. Add an element of randomness to allow affinities
of different writer tasks to diverge.

Signed-off-by: Connor O'Brien <connoro@google.com>
---
 kernel/torture.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 789aeb0e1159..1d0dd88369e3 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -54,6 +54,9 @@ module_param(verbose_sleep_frequency, int, 0444);
 static int verbose_sleep_duration = 1;
 module_param(verbose_sleep_duration, int, 0444);
 
+static int random_shuffle;
+module_param(random_shuffle, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -518,6 +521,7 @@ static void torture_shuffle_task_unregister_all(void)
  */
 static void torture_shuffle_tasks(void)
 {
+	DEFINE_TORTURE_RANDOM(rand);
 	struct shuffle_task *stp;
 
 	cpumask_setall(shuffle_tmp_mask);
@@ -537,8 +541,10 @@ static void torture_shuffle_tasks(void)
 		cpumask_clear_cpu(shuffle_idle_cpu, shuffle_tmp_mask);
 
 	mutex_lock(&shuffle_task_mutex);
-	list_for_each_entry(stp, &shuffle_task_list, st_l)
-		set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
+	list_for_each_entry(stp, &shuffle_task_list, st_l) {
+		if (!random_shuffle || torture_random(&rand) & 0x1)
+			set_cpus_allowed_ptr(stp->st_t, shuffle_tmp_mask);
+	}
 	mutex_unlock(&shuffle_task_mutex);
 
 	cpus_read_unlock();
-- 
2.38.0.rc1.362.ged0d419d3c-goog

