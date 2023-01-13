Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2269F669742
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbjAMMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbjAMMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04452C6E;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvkkEgGNc+X8JPMu5cL4mkFTzR3Cr00C/ewLCIV6n7A=;
        b=A002BPJv3ylvGpUu1LbJnExAWyKisYV34ZoLr9JZqLY5T2eHaDDGSrVqgg8yR0Z4ycQGyu
        BW2ZJS1e/KLifnJ53+WbFEhUephVVZSwBAFRT3IT4emrUUhRHlGNcw9husexLDWLM2ajsG
        eOZjIjXl/kMGUHD1jp4VWkj2MEf8ny/6i43DTWvkyCPFhf+DPB1EvcmMriD0SkW8FuP1Ah
        Zh5+oXVyKPKSEMr5WlFAUhaMCf2RAGtWA/vhdcL5AqiuC2l2n9lOPqQ0Rukme3Fr4zL1cz
        81yfrJdWX+L4F8FlvihCfKWXIOwOOuxriV/fEyLASjabeY9CXwChCCM77qT0qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvkkEgGNc+X8JPMu5cL4mkFTzR3Cr00C/ewLCIV6n7A=;
        b=4akcYBXgd76M0AgFmKJEap+bhgtG1pQAIus3XbF59AnwSEr9hPxH8Ps0Us+o9+R14CwQ3/
        w6WOQrSY1y3lwdAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle, ARM: OMAP2+: powerdomain: Remove
 trace_.*_rcuidle()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.782536366@infradead.org>
References: <20230112195541.782536366@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306694.4906.5223448518679666811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     db8f50861da6b1129b744da3998587a5cceeffeb
Gitweb:        https://git.kernel.org/tip/db8f50861da6b1129b744da3998587a5cceeffeb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:54 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

cpuidle, ARM: OMAP2+: powerdomain: Remove trace_.*_rcuidle()

OMAP was the one and only user.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.782536366@infradead.org
---
 arch/arm/mach-omap2/powerdomain.c | 10 +++++-----
 drivers/base/power/runtime.c      | 24 ++++++++++++------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 2d747f6..65fec41 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -187,9 +187,9 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 			trace_state = (PWRDM_TRACE_STATES_FLAG |
 				       ((next & OMAP_POWERSTATE_MASK) << 8) |
 				       ((prev & OMAP_POWERSTATE_MASK) << 0));
-			trace_power_domain_target_rcuidle(pwrdm->name,
-							  trace_state,
-							  raw_smp_processor_id());
+			trace_power_domain_target(pwrdm->name,
+						  trace_state,
+						  raw_smp_processor_id());
 		}
 		break;
 	default:
@@ -541,8 +541,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
 		/* Trace the pwrdm desired target state */
-		trace_power_domain_target_rcuidle(pwrdm->name, pwrst,
-						  raw_smp_processor_id());
+		trace_power_domain_target(pwrdm->name, pwrst,
+					  raw_smp_processor_id());
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	}
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 50e726b..98f7b3d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -468,7 +468,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	int (*callback)(struct device *);
 	int retval;
 
-	trace_rpm_idle_rcuidle(dev, rpmflags);
+	trace_rpm_idle(dev, rpmflags);
 	retval = rpm_check_suspend_allowed(dev);
 	if (retval < 0)
 		;	/* Conditions are wrong. */
@@ -508,7 +508,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 			dev->power.request_pending = true;
 			queue_work(pm_wq, &dev->power.work);
 		}
-		trace_rpm_return_int_rcuidle(dev, _THIS_IP_, 0);
+		trace_rpm_return_int(dev, _THIS_IP_, 0);
 		return 0;
 	}
 
@@ -530,7 +530,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	wake_up_all(&dev->power.wait_queue);
 
  out:
-	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
 	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
@@ -562,7 +562,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval;
 
-	trace_rpm_suspend_rcuidle(dev, rpmflags);
+	trace_rpm_suspend(dev, rpmflags);
 
  repeat:
 	retval = rpm_check_suspend_allowed(dev);
@@ -713,7 +713,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	}
 
  out:
-	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
 
 	return retval;
 
@@ -765,7 +765,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval = 0;
 
-	trace_rpm_resume_rcuidle(dev, rpmflags);
+	trace_rpm_resume(dev, rpmflags);
 
  repeat:
 	if (dev->power.runtime_error) {
@@ -935,7 +935,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		spin_lock_irq(&dev->power.lock);
 	}
 
-	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
+	trace_rpm_return_int(dev, _THIS_IP_, retval);
 
 	return retval;
 }
@@ -1091,7 +1091,7 @@ int __pm_runtime_idle(struct device *dev, int rpmflags)
 		if (retval < 0) {
 			return retval;
 		} else if (retval > 0) {
-			trace_rpm_usage_rcuidle(dev, rpmflags);
+			trace_rpm_usage(dev, rpmflags);
 			return 0;
 		}
 	}
@@ -1129,7 +1129,7 @@ int __pm_runtime_suspend(struct device *dev, int rpmflags)
 		if (retval < 0) {
 			return retval;
 		} else if (retval > 0) {
-			trace_rpm_usage_rcuidle(dev, rpmflags);
+			trace_rpm_usage(dev, rpmflags);
 			return 0;
 		}
 	}
@@ -1212,7 +1212,7 @@ int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
 	} else {
 		retval = atomic_inc_not_zero(&dev->power.usage_count);
 	}
-	trace_rpm_usage_rcuidle(dev, 0);
+	trace_rpm_usage(dev, 0);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return retval;
@@ -1576,7 +1576,7 @@ void pm_runtime_allow(struct device *dev)
 	if (ret == 0)
 		rpm_idle(dev, RPM_AUTO | RPM_ASYNC);
 	else if (ret > 0)
-		trace_rpm_usage_rcuidle(dev, RPM_AUTO | RPM_ASYNC);
+		trace_rpm_usage(dev, RPM_AUTO | RPM_ASYNC);
 
  out:
 	spin_unlock_irq(&dev->power.lock);
@@ -1646,7 +1646,7 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
 			atomic_inc(&dev->power.usage_count);
 			rpm_resume(dev, 0);
 		} else {
-			trace_rpm_usage_rcuidle(dev, 0);
+			trace_rpm_usage(dev, 0);
 		}
 	}
 
