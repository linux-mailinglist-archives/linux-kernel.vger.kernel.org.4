Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FF75F39BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJCXUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJCXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:20:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56E186CB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:20:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cp14-20020a056a00348e00b005604b9eb5aaso3917180pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=c2cO7Sy64Zhrp4qdC6wFKXRMlV4RIl42WCCMI78jqrM=;
        b=oKuEPo8fzinBKPuCyPOK02shSwOH4GNl+UA1yIV+WYtbFo9sv0kKty/FVZfrb/wZ3q
         9bw+T4ylsRKutVSfSPf9dxrnkxzvLxyHu32/vbeNI0QtvQk1Ukcs0JMd0uPxbbnG9oez
         pBuCyeyp6+dYZrADXn7FcuDn866q0Ipw3edJQEUPHMfsaa+/Zr+0X/85220MR0QOs6QS
         zp9oB4+zeFQnGOvOx83+5aY1r5CJuC+/bMw2EvlgQJLtG+qsksXpHwE2YirCkOsrxB3a
         JddC5PpbRuIc2uXC7o5O+p6/Wjxch1udK5pP5dUfXcAh/9zkaC0UJdW4Q+XxQQEWQj27
         LURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=c2cO7Sy64Zhrp4qdC6wFKXRMlV4RIl42WCCMI78jqrM=;
        b=FreaxkbBD+zXee7kYG79/5jxbrSWMH0pqvZfulLE2lbxA5IAHUMcrF5Irj6r2Cy8/b
         3VRCPPdPCIR/EEqNrPlEkvZPlrYrs47GcmOgF0PWN80+FhSBll536AWa9lDmMYqxvuVb
         3+L2K+TGt8voDdP/J9d2HhdMxh/gzWmHii4p5jLY6VVzQ4gm6jwxfwa4b1QfFUqdYK4r
         TbIdJOpNsNugrLwsjn/lOcbujEb0l0p2Ba1H3mGTpsMY3AtRcBmg6GpoEDzoAz+I0VBh
         RL3pN6nM12ZHCECcwyesHYsV/mrfVBpOhLahc4eaucctLmp1HJCva0Lp0o0adlGhIDZJ
         2fPg==
X-Gm-Message-State: ACrzQf2lzPl6Ay0NevSTOMbmJ9lnARQSu3CsjVQ/9SfQGL8IyUnhnAAd
        LX9M6AOOFZMUgPAGmH9yOJO0+FocW5W1VkdBLmxGd+xs+COIj0iQqAR+GnrdRdH+G+19E5LRyIF
        v3ZFqr4C9sVJP5klRBhkn58keVw7QdE9KXwun210Z7l+kp6XhT34urSctcRMw6me4Sv/XExo=
X-Google-Smtp-Source: AMsMyM4V9u6cPtlnNBhlU7Yzc0gm+3oXE20A2kEVPVUi4odHcUxHLBf8A5t4BxIAbzu+FKRWoI44RRIDH+8j
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP id
 d6-20020a17090acd0600b00203ae0e6a21mr86882pju.0.1664839241058; Mon, 03 Oct
 2022 16:20:41 -0700 (PDT)
Date:   Mon,  3 Oct 2022 23:20:31 +0000
In-Reply-To: <20221003232033.3404802-1-jstultz@google.com>
Mime-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003232033.3404802-2-jstultz@google.com>
Subject: [RFC PATCH v4 1/3] softirq: Add generic accessor to percpu
 softirq_pending data
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <jstultz@google.com>, John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kernel-team@android.com,
        kernel test robot <lkp@intel.com>
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

In a previous iteration of this patch series, I was checking:

   per_cpu(irq_stat, cpu).__softirq_pending

which resulted in build errors on s390.

This patch tries to create a generic accessor to this percpu
softirq_pending data.

This interface is inherently racy as its reading percpu data
without a lock. However, being able to peek at the softirq
pending data allows us to make better decisions about rt task
placement vs just ignoring it.

On s390 this call returns 0, which maybe isn't ideal but
results in no functional change from what we do now.

TODO: Heiko suggested changing s390 to use a proper per-cpu
irqstat variable instead.

Feedback or suggestions for better approach here would be
welcome!

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: kernel-team@android.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 arch/s390/include/asm/hardirq.h |  6 ++++++
 include/linux/interrupt.h       | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 58668ffb5488..cd9cc11588ab 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -16,6 +16,12 @@
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
 #define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
 #define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
+/*
+ *  Not sure what the right thing is here  for s390,
+ *  but returning 0 will result in no logical change
+ *  from what happens now
+ */
+#define __cpu_softirq_pending(x) (0)
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b..a749a8663841 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -527,6 +527,17 @@ DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
 #define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
 #define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
 
+/**
+ * __cpu_softirq_pending() - Checks to see if softirq is pending on a cpu
+ *
+ * This helper is inherently racy, as we're accessing per-cpu data w/o locks.
+ * But peeking at the flag can still be useful when deciding where to place a
+ * task.
+ */
+static inline u32 __cpu_softirq_pending(int cpu)
+{
+	return (u32)per_cpu(local_softirq_pending_ref, cpu);
+}
 #endif /* local_softirq_pending */
 
 /* Some architectures might implement lazy enabling/disabling of
-- 
2.38.0.rc1.362.ged0d419d3c-goog

