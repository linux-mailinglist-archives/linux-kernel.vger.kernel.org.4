Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E295E814C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiIWSCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIWSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BAE6DD3;
        Fri, 23 Sep 2022 11:01:44 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nz+ZFKT1YAT2GaWNT7GTr0IeqHTpJVIwd5mwVOupz80=;
        b=DquBCzQqhvkV74PlcO0XIOMZqr/XF6E7/N6DvMDnOmeT9lBVmbG8Ld1DCph1y6yP2iA8bN
        w1Y5nlN0wkcMeVVEznz9x/3ssssN6SJ3MEOzkfaOJwkpEosTVYMpkimKL6hMMp8pEtUT9a
        ZioHVQicQY5lSjQNzW7pzvTQ5xqsjI0mcLf9a730/0y4tZAib8hJn2pRpzn55OA5INp1gH
        ryWdOQV2fBmYRuMnCCk9ZFAzDK6qN79zyNJ0GaunK41mbL9muxUabiPHKUbRuhvBYkqUVM
        EVNo3ls9hZvl4OWoANsAwbcLeTWdGUSeliNM9QMGuYgL1HLxuxIqCt1Zpr8ZVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nz+ZFKT1YAT2GaWNT7GTr0IeqHTpJVIwd5mwVOupz80=;
        b=+u1zW+7G1wzdr5Bo+1UNqjNfu/QBwakl8zSDPyMQUP3yj/goFDekdcDEuAOZ4g7fMe/JZT
        rHQbbejDZp1Pa+AA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rename and change the units of
 resctrl_cqm_threshold
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-20-james.morse@arm.com>
References: <20220902154829.30399-20-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610216.401.8310827339920212417.tip-bot2@tip-bot2>
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

Commit-ID:     ae2328b52962531c2d7c6b531022a3eb2d680f17
Gitweb:        https://git.kernel.org/tip/ae2328b52962531c2d7c6b531022a3eb2d680f17
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:27 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 14:23:41 +02:00

x86/resctrl: Rename and change the units of resctrl_cqm_threshold

resctrl_cqm_threshold is stored in a hardware specific chunk size,
but exposed to user-space as bytes.

This means the filesystem parts of resctrl need to know how the hardware
counts, to convert the user provided byte value to chunks. The interface
between the architecture's resctrl code and the filesystem ought to
treat everything as bytes.

Change the unit of resctrl_cqm_threshold to bytes. resctrl_arch_rmid_read()
still returns its value in chunks, so this needs converting to bytes.
As all the users have been touched, rename the variable to
resctrl_rmid_realloc_threshold, which describes what the value is for.

Neither r->num_rmid nor hw_res->mon_scale are guaranteed to be a power
of 2, so the existing code introduces a rounding error from resctrl's
theoretical fraction of the cache usage. This behaviour is kept as it
ensures the user visible value matches the value read from hardware
when the rmid will be reallocated.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-20-james.morse@arm.com
---
 arch/x86/include/asm/resctrl.h         |  9 +++++-
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 43 +++++++++++++++----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +----
 include/linux/resctrl.h                |  2 +-
 5 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index d60ed06..d24b04e 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -81,6 +81,15 @@ static void __resctrl_sched_in(void)
 	}
 }
 
+static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
+{
+	unsigned int scale = boot_cpu_data.x86_cache_occ_scale;
+
+	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
+	val /= scale;
+	return val * scale;
+}
+
 static inline void resctrl_sched_in(void)
 {
 	if (static_branch_likely(&rdt_enable_key))
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index bdb55c2..c05e9b7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -98,7 +98,6 @@ struct rmid_read {
 	u64			val;
 };
 
-extern unsigned int resctrl_cqm_threshold;
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
 extern unsigned int rdt_mon_features;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 27bb494..e91afe9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -17,7 +17,10 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+
 #include <asm/cpu_device_id.h>
+#include <asm/resctrl.h>
+
 #include "internal.h"
 
 struct rmid_entry {
@@ -37,8 +40,8 @@ static LIST_HEAD(rmid_free_lru);
  * @rmid_limbo_count     count of currently unused but (potentially)
  *     dirty RMIDs.
  *     This counts RMIDs that no one is currently using but that
- *     may have a occupancy value > intel_cqm_threshold. User can change
- *     the threshold occupancy value.
+ *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
+ *     change the threshold occupancy value.
  */
 static unsigned int rmid_limbo_count;
 
@@ -59,10 +62,10 @@ bool rdt_mon_capable;
 unsigned int rdt_mon_features;
 
 /*
- * This is the threshold cache occupancy at which we will consider an
+ * This is the threshold cache occupancy in bytes at which we will consider an
  * RMID available for re-allocation.
  */
-unsigned int resctrl_cqm_threshold;
+unsigned int resctrl_rmid_realloc_threshold;
 
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
@@ -223,14 +226,13 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
  */
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rmid_entry *entry;
-	struct rdt_resource *r;
 	u32 crmid = 1, nrmid;
 	bool rmid_dirty;
 	u64 val = 0;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-
 	/*
 	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
 	 * are marked as busy for occupancy < threshold. If the occupancy
@@ -245,10 +247,12 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		entry = __rmid_entry(nrmid);
 
 		if (resctrl_arch_rmid_read(r, d, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val))
+					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
-		else
-			rmid_dirty = (val >= resctrl_cqm_threshold);
+		} else {
+			val *= hw_res->mon_scale;
+			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+		}
 
 		if (force_free || !rmid_dirty) {
 			clear_bit(entry->rmid, d->rmid_busy_llc);
@@ -289,13 +293,12 @@ int alloc_rmid(void)
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
-	struct rdt_resource *r;
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
-
 	entry->busy = 0;
 	cpu = get_cpu();
 	list_for_each_entry(d, &r->domains, list) {
@@ -303,7 +306,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 			err = resctrl_arch_rmid_read(r, d, entry->rmid,
 						     QOS_L3_OCCUP_EVENT_ID,
 						     &val);
-			if (err || val <= resctrl_cqm_threshold)
+			val *= hw_res->mon_scale;
+			if (err || val <= resctrl_rmid_realloc_threshold)
 				continue;
 		}
 
@@ -744,6 +748,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int cl_size = boot_cpu_data.x86_cache_size;
+	unsigned int threshold;
 	int ret;
 
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
@@ -762,10 +767,14 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;
+	threshold = cl_size * 1024 / r->num_rmid;
 
-	/* h/w works in units of "boot_cpu_data.x86_cache_occ_scale" */
-	resctrl_cqm_threshold /= hw_res->mon_scale;
+	/*
+	 * Because num_rmid may not be a power of two, round the value
+	 * to the nearest multiple of hw_res->mon_scale so it matches a
+	 * value the hardware will measure. mon_scale may not be a power of 2.
+	 */
+	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
 	ret = dom_data_init(r);
 	if (ret)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6c33dfe..849bdec 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1030,10 +1030,7 @@ static int rdt_delay_linear_show(struct kernfs_open_file *of,
 static int max_threshold_occ_show(struct kernfs_open_file *of,
 				  struct seq_file *seq, void *v)
 {
-	struct rdt_resource *r = of->kn->parent->priv;
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-
-	seq_printf(seq, "%u\n", resctrl_cqm_threshold * hw_res->mon_scale);
+	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
 
 	return 0;
 }
@@ -1055,7 +1052,6 @@ static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 				       char *buf, size_t nbytes, loff_t off)
 {
-	struct rdt_hw_resource *hw_res;
 	unsigned int bytes;
 	int ret;
 
@@ -1066,8 +1062,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
 		return -EINVAL;
 
-	hw_res = resctrl_to_arch_res(of->kn->parent->priv);
-	resctrl_cqm_threshold = bytes / hw_res->mon_scale;
+	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(bytes);
 
 	return nbytes;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 7ccfa0d..9995d04 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -250,4 +250,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
+extern unsigned int resctrl_rmid_realloc_threshold;
+
 #endif /* _RESCTRL_H */
