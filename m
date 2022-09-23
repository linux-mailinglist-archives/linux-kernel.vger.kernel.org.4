Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142085E8168
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiIWSC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiIWSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5081013E7E9;
        Fri, 23 Sep 2022 11:01:54 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40e0C8vQPTAs+xKilBOXUaqjbFbVjZlADo0NGavnflI=;
        b=iB3/voE2B7xIMX0RQBTYWuVnuTl0zGx2Ht4lnUDccPH+QGWyPzcxXxBou+cHDUzwMSrv+q
        4I6zENX/UtM9XKnWqVAbr1fnhJQFDfbZZ5wcYtv2HD1Jbs40j5Q33RPWxXXxtNm6TWH8kU
        wEK95+W4dW5FIH2VtT+vyIC1cHzzaSCemuzHaSfwcG9DFBZjZeeNGqq41BGnvm8oA0gf4+
        BCJuTmgY3GghrBblx9qrQ6X/9gUVqSWXD1Qy2hnGiHdKNjypl7hnFIHh0mN0x0KxC7seYY
        hyG2QA8TkP5EH/Fv9ufKsiphaqULwtUQIQHyqBEbq6rcIadCPb94v55GHai28g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40e0C8vQPTAs+xKilBOXUaqjbFbVjZlADo0NGavnflI=;
        b=YXwR/d4xONAMX4lGjVIiucptqXjpM3pDTSUeiHv7wZEPRy2/QdHlKOnvz6nMjN4cPIgcaL
        U0CG/4LvCVLa7bAQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove architecture copy of mbps_val
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-11-james.morse@arm.com>
References: <20220902154829.30399-11-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611163.401.9793745330775839197.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     b58d4eb1f199f5a26d8c756d8e74a31c48b90428
Gitweb:        https://git.kernel.org/tip/b58d4eb1f199f5a26d8c756d8e74a31c48b90428
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:18 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 17:37:16 +02:00

x86/resctrl: Remove architecture copy of mbps_val

The resctrl arch code provides a second configuration array mbps_val[]
for the MBA software controller.

Since resctrl switched over to allocating and freeing its own array
when needed, nothing uses the arch code version.

Remove it.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-11-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 20 ++++----------------
 arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +---
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f691829..f0e2820 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -397,7 +397,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	return NULL;
 }
 
-void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
+static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	int i;
@@ -406,18 +406,14 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	 * Initialize the Control MSRs to having no control.
 	 * For Cache Allocation: Set all bits in cbm
 	 * For Memory Allocation: Set b/w requested to 100%
-	 * and the bandwidth in MBps to U32_MAX
 	 */
-	for (i = 0; i < hw_res->num_closid; i++, dc++, dm++) {
+	for (i = 0; i < hw_res->num_closid; i++, dc++)
 		*dc = r->default_ctrl;
-		*dm = MBA_MAX_MBPS;
-	}
 }
 
 static void domain_free(struct rdt_hw_domain *hw_dom)
 {
 	kfree(hw_dom->ctrl_val);
-	kfree(hw_dom->mbps_val);
 	kfree(hw_dom);
 }
 
@@ -426,23 +422,15 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
 	struct msr_param m;
-	u32 *dc, *dm;
+	u32 *dc;
 
 	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val),
 			   GFP_KERNEL);
 	if (!dc)
 		return -ENOMEM;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val),
-			   GFP_KERNEL);
-	if (!dm) {
-		kfree(dc);
-		return -ENOMEM;
-	}
-
 	hw_dom->ctrl_val = dc;
-	hw_dom->mbps_val = dm;
-	setup_default_ctrlval(r, dc, dm);
+	setup_default_ctrlval(r, dc);
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index a7e2cbc..373aaba 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -308,14 +308,12 @@ struct mbm_state {
  *			  a resource
  * @d_resctrl:	Properties exposed to the resctrl file system
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
- * @mbps_val:	When mba_sc is enabled, this holds the bandwidth in MBps
  *
  * Members of this structure are accessed via helpers that provide abstraction.
  */
 struct rdt_hw_domain {
 	struct rdt_domain		d_resctrl;
 	u32				*ctrl_val;
-	u32				*mbps_val;
 };
 
 static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
@@ -529,7 +527,6 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom,
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 55d8a12..6c33dfe 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2370,10 +2370,8 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
-		for (i = 0; i < hw_res->num_closid; i++) {
+		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
-			hw_dom->mbps_val[i] = MBA_MAX_MBPS;
-		}
 	}
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
