Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3E5BF2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIUB1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIUB1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:27:00 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D45756C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:26:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h11-20020a170902f54b00b001780f0f7ea7so2788572plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Zc82LmVew5/T1CkEfW5rs6gkMi/t3IMOs+9o8CakWjo=;
        b=Fg1NZ+GWt94sDG8qDDqXcoZpGfdn5EwhJKMaEkIvUBW+dfLv4ocTBHL/P2LHHuDHVf
         +YYIXUTg3zmTr0pzM5fVxhctKGC9WYxIaY/0zXV2wqIVU3wE2vLSLHvFfdTJU+2gfq0L
         voLAPO6S+ieDU8UHyW94wVMreNyGBaq/k3bkQM0qGa/I83t1jC7cd4PvfPpYCIyMbQbM
         J1faxAgvLya80zAXG8IitYwy+rlkNXA9wIh7F0b0Q3FWarAz6K3tolu8CIqvXHmDRAHI
         cEFHuUIkYjKgH2XIPoGgrLcouzQuWvfLyEyYUvVmNJOSTdu8TB9CmkwRkMndLAO0Pk3w
         s/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Zc82LmVew5/T1CkEfW5rs6gkMi/t3IMOs+9o8CakWjo=;
        b=ZEFaYwG/BpJZC+/gefyitmzJPz8WRy0l/qrKaedBd+/nOkgtUtkDlLzy4lw1vF3lin
         NWLR/IOK86pQYkqB0M6OnlaTkIMYWi9ORbyDHITGS3a/utIOhtQZ7mwj5LPQH2UPefQm
         Nqrna7JF+Ol0ToVsHgEqwQlzJLulLg1xApDccTfUfok6ACakd88D9Kb89A27HrlHwbfX
         O8XQYGciGNtQGOU9Xf5MsYUHruvFaYRuagf1uaZpEPpy21Ya6oc4WVHA/FWl5l+rAmLp
         VNzJHCe/l6p+GqG0gHZf1aO1unx0fGTPRp3Tobg6OdbxL07jJyeRtKF3NFPaX0HAbEJi
         PmdA==
X-Gm-Message-State: ACrzQf0ZvXC03w2sy5/SXmOWr2L6Xm/5JpozfHnSO8K7r+WrG2t3Ttxl
        cFcJok3yDMNLjPuhwCz6ZrPDzu6QoSsD06iVzgnH41h1Qd4LiGmYACHGlol3S99j1c4TeibqdRT
        glYrjepmpVkbzgHVgjEbJjjcEh7qrVj86wxA8jBQmaMFzpHWolRDgLVbfCmWxkZSC8i6VoGg=
X-Google-Smtp-Source: AMsMyM4HdAPt49plfVhTqKf/uwC3pV1pQZO/7JKgk/vNwlIJS5eBvF0b3AvM2CEnevlLPdmOJ+NdHdq4b4DC
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:d2d2:b0:177:4940:cc0f with SMTP id
 n18-20020a170902d2d200b001774940cc0fmr2371872plc.4.1663723556992; Tue, 20 Sep
 2022 18:25:56 -0700 (PDT)
Date:   Wed, 21 Sep 2022 01:25:48 +0000
In-Reply-To: <20220921012550.3288570-1-jstultz@google.com>
Mime-Version: 1.0
References: <20220921012550.3288570-1-jstultz@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921012550.3288570-2-jstultz@google.com>
Subject: [RFC PATCH v3 1/3] softirq: Add generic accessor to percpu
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
2.37.3.968.ga6b4b080e4-goog

