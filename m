Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3036B7388A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjFUPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjFUPTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:19:14 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Jun 2023 08:15:56 PDT
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD926A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1687360556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ROv8WH2KRHqBNrcnRL0RAQ0km5kswdguMzERRm4vfNw=;
  b=O30dSfWraep2/epHy/4eqNZ0/tx/WDwB127hJgd6gkB7lAPd23cSZPBQ
   9TF+MWS8Ip8Wy3+ybvFkxChT5XcKIi942ZQeOqYTLqJXcBkAfKJGnnRli
   iKH/O7LZ2YrrOUKA/hxCWNwRua8MDx6oXBMIWz9lglOZo17vGxjH4I8E3
   w=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 113660268
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:aDB4vqi1/1j5JWqKC+7BuswvX161JBcKZh0ujC45NGQN5FlHY01je
 htvCj2POfuIYDP9KY8iPtuz9hxQ7JfWytVqSARqpSw3F38b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyq0N8klgZmP6sT4gWHzyJ94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tRBEx0WPkGgmdvug6OZdrZr14clF8rSadZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkMJYw1MYH49tL7Aan3XSzBC7niUobE6y2PS0BZwwP7mN9+9ltmiHJwOwBjA/
 DyWl4j/Ki9GNda162aiy2ixu8PpogXWQ4wjRKLto5aGh3XMnzdOWXX6T2CTpeSljWa9VshZJ
 khS/TAhxYAu+0i7Zt38WQCkunmCvw5aV9c4O+g77g6K4rDZ7waQGi4PSTspQNY+nMYyRDEsh
 hmFkrvBCTVxvfuVQHSG+7G8qTK0JDhTLGkeaCtCRgwAi/Hz8N8bjR/VSNtnVqmvgbXdGSn56
 yKbsC8kwb4UiKYj1aqh+kvcqymxvZWPRQkwji3MRX6s5A59YI+jZqSr5ELd4PIGK5yWJnGGu
 HUHgMGY4Po5EYCWlCeNTeMOG5mk//+AdjbbhDZHG5gn6iTo+HO5e41UyC9xKV0vMcsefzLtJ
 kjJtmt59JJVeXenc6JzS4awENgxi7jtE8z/UfLZZcYIZYJ+HDJr5wk3OxTWhTq01hFxz+dmY
 8zznduQ4WgyUJ9K12rnZPkkifw65BxhwjKQQ6v49kHyuVaBX0J5WYvpIXPXMLBmtvPb+VWPm
 zpMH5DUkksCCYUSdgGSqNdOdg5ScBDXELis86Rqmvi/zh2K8Y3LI9vY2vsfdoNshMy5fc+Yr
 yjmCie0JLcS7EAryDlmiVg5MtsDpb4l8RoG0dUEZD5EIUQLb4e197s4fJAqZ7Qh/+EL5acqH
 6ZfK5vYX6QVGm6vF9EhgX7V9tYKSfhWrVjWY3rNjMYXIvaMuDAlCve7J1CypUHi/wK8tNcko
 q3I6+8oacNreuiWN+6PMKjH5wro7RAgdBdaAxOgzi97JB+9r+CH6kXZ0pcKHi37AUWfmmTCi
 1rNWn/1Z4Dl+ucIzTUAvojcx6/BLge0NhMy87XzhVpuCRTnww==
IronPort-HdrOrdr: A9a23:ibGbUa26i8UKI4C2b4tlOgqjBLYkLtp133Aq2lEZdPUCSL39qy
 nOppQmPHDP4wr5NEtLpTniAsi9qBHnmqKdurNhWItKNTOO0FdASrsO0WKI+VPd8kPFmtK0es
 1bAs9D4HGbNykYsS5aijPIceod/A==
X-Talos-CUID: 9a23:22AFNG6/ZGIL1jsO6tssrXU5AZB0UWPklDTBAXPnDjcqToaWcArF
X-Talos-MUID: 9a23:B5E0hQrfUJbC4MiGGc0ezw8+Nc1CwfiJMVoQrLkghO+pLiJBayjI2Q==
X-IronPort-AV: E=Sophos;i="6.00,260,1681185600"; 
   d="scan'208";a="113660268"
From:   Per Bilse <per.bilse@citrix.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
        "open list:X86 ENTRY CODE" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
CC:     Per Bilse <per.bilse@citrix.com>
Subject: [PATCH] Updates to Xen hypercall preemption
Date:   Wed, 21 Jun 2023 15:14:42 +0000
Message-ID: <20230621151442.2152425-1-per.bilse@citrix.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Xen hypercalls issued by dom0 guests may run for many 10s of
seconds, potentially causing watchdog timeouts and other problems.
It's rare for this to happen, but it does in extreme circumstances,
for instance when shutting down VMs with very large memory allocations
(> 0.5 - 1TB).  These hypercalls are preemptible, but the fixes in the
kernel to ensure preemption have fallen into a state of disrepair, and
are currently ineffective.  This patch brings things up to date by way of:

1) Update general feature selection from XEN_PV to XEN_DOM0.
The issue is unique to dom0 Xen guests, but isn't unique to PV dom0s,
and will occur in future PVH dom0s.  XEN_DOM0 depends on either PV or PVH,
as well as the appropriate details for dom0.

2) Update specific feature selection from !PREEMPTION to !PREEMPT.
The following table shows the relationship between different preemption
features and their indicators/selectors (Y = "=Y", N = "is not set",
. = absent):

                            | np-s | np-d | vp-s | vp-d | fp-s | fp-d
    CONFIG_PREEMPT_DYNAMIC      N      Y      N      Y      N      Y
         CONFIG_PREEMPTION      .      Y      .      Y      Y      Y
            CONFIG_PREEMPT      N      N      N      N      Y      Y
  CONFIG_PREEMPT_VOLUNTARY      N      N      Y      Y      N      N
       CONFIG_PREEMPT_NONE      Y      Y      N      N      N      N

Unless PREEMPT is set, we need to enable the fixes.

3) Update flag access from __this_cpu_XXX() to raw_cpu_XXX().
The long-running hypercalls are flagged by way of a per-cpu variable
which is set before and cleared after the relevant calls.  This elicits
a warning "BUG: using __this_cpu_write() in preemptible [00000000] code",
but xen_pv_evtchn_do_upcall() deals specifically with this.  For
consistency, flag testing is also updated, and the code is simplified
and tidied accordingly.

4) Update irqentry_exit_cond_resched() to raw_irqentry_exit_cond_resched().
The code will call irqentry_exit_cond_resched() if the flag (as noted
above) is set, but the dynamic preemption feature will livepatch that
function to a no-op unless full preemption is selected.  The code is
therefore updated to call raw_irqentry_exit_cond_resched().

Signed-off-by: Per Bilse <per.bilse@citrix.com>
---
 arch/x86/entry/common.c | 34 +++++++++++++---------------------
 drivers/xen/privcmd.c   | 12 ++++++------
 include/xen/xen-ops.h   | 14 +++++++-------
 3 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..19e8609a7a5a 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -20,7 +20,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 
-#ifdef CONFIG_XEN_PV
+#ifdef CONFIG_XEN_DOM0
 #include <xen/xen-ops.h>
 #include <xen/events.h>
 #endif
@@ -252,17 +252,17 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
-#ifdef CONFIG_XEN_PV
-#ifndef CONFIG_PREEMPTION
+#ifdef CONFIG_XEN_DOM0
+#ifndef CONFIG_PREEMPT
 /*
  * Some hypercalls issued by the toolstack can take many 10s of
  * seconds. Allow tasks running hypercalls via the privcmd driver to
  * be voluntarily preempted even if full kernel preemption is
  * disabled.
  *
- * Such preemptible hypercalls are bracketed by
- * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
- * calls.
+ * Such preemptible hypercalls are flagged by
+ * xen_preemptible_hcall_set(true/false), and status is
+ * returned by xen_preemptible_hcall_get().
  */
 DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
 EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
@@ -271,21 +271,15 @@ EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
  * In case of scheduling the flag must be cleared and restored after
  * returning from schedule as the task might move to a different CPU.
  */
-static __always_inline bool get_and_clear_inhcall(void)
+static __always_inline bool get_and_unset_hcall(void)
 {
-	bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
+	bool inhcall = xen_preemptible_hcall_get();
 
-	__this_cpu_write(xen_in_preemptible_hcall, false);
+	xen_preemptible_hcall_set(false);
 	return inhcall;
 }
-
-static __always_inline void restore_inhcall(bool inhcall)
-{
-	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
-}
 #else
-static __always_inline bool get_and_clear_inhcall(void) { return false; }
-static __always_inline void restore_inhcall(bool inhcall) { }
+static __always_inline bool get_and_unset_hcall(void) { return false; }
 #endif
 
 static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
@@ -302,16 +296,14 @@ static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
-	bool inhcall;
 
 	instrumentation_begin();
 	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
-	inhcall = get_and_clear_inhcall();
-	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		irqentry_exit_cond_resched();
+	if (get_and_unset_hcall() && !WARN_ON_ONCE(state.exit_rcu)) {
+		raw_irqentry_exit_cond_resched();
 		instrumentation_end();
-		restore_inhcall(inhcall);
+		xen_preemptible_hcall_set(true);
 	} else {
 		instrumentation_end();
 		irqentry_exit(regs, state);
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index e2f580e30a86..78c91227d2a5 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -77,12 +77,12 @@ static long privcmd_ioctl_hypercall(struct file *file, void __user *udata)
 	if (copy_from_user(&hypercall, udata, sizeof(hypercall)))
 		return -EFAULT;
 
-	xen_preemptible_hcall_begin();
+	xen_preemptible_hcall_set(true);
 	ret = privcmd_call(hypercall.op,
 			   hypercall.arg[0], hypercall.arg[1],
 			   hypercall.arg[2], hypercall.arg[3],
 			   hypercall.arg[4]);
-	xen_preemptible_hcall_end();
+	xen_preemptible_hcall_set(false);
 
 	return ret;
 }
@@ -688,9 +688,9 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 		xbufs[i].size = kbufs[i].size;
 	}
 
-	xen_preemptible_hcall_begin();
+	xen_preemptible_hcall_set(true);
 	rc = HYPERVISOR_dm_op(kdata.dom, kdata.num, xbufs);
-	xen_preemptible_hcall_end();
+	xen_preemptible_hcall_set(false);
 
 out:
 	unlock_pages(pages, pinned);
@@ -790,9 +790,9 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	xdata.nr_frames = kdata.num;
 	set_xen_guest_handle(xdata.frame_list, pfns);
 
-	xen_preemptible_hcall_begin();
+	xen_preemptible_hcall_set(true);
 	rc = HYPERVISOR_memory_op(XENMEM_acquire_resource, &xdata);
-	xen_preemptible_hcall_end();
+	xen_preemptible_hcall_set(false);
 
 	if (rc)
 		goto out;
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 47f11bec5e90..c5b06405f355 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -194,24 +194,24 @@ bool xen_running_on_version_or_later(unsigned int major, unsigned int minor);
 void xen_efi_runtime_setup(void);
 
 
-#if defined(CONFIG_XEN_PV) && !defined(CONFIG_PREEMPTION)
+#if defined(CONFIG_XEN_DOM0) && !defined(CONFIG_PREEMPT)
 
 DECLARE_PER_CPU(bool, xen_in_preemptible_hcall);
 
-static inline void xen_preemptible_hcall_begin(void)
+static inline void xen_preemptible_hcall_set(bool status)
 {
-	__this_cpu_write(xen_in_preemptible_hcall, true);
+	raw_cpu_write(xen_in_preemptible_hcall, status);
 }
 
-static inline void xen_preemptible_hcall_end(void)
+static inline bool xen_preemptible_hcall_get(void)
 {
-	__this_cpu_write(xen_in_preemptible_hcall, false);
+	return raw_cpu_read(xen_in_preemptible_hcall);
 }
 
 #else
 
-static inline void xen_preemptible_hcall_begin(void) { }
-static inline void xen_preemptible_hcall_end(void) { }
+static inline void xen_preemptible_hcall_set(bool status) { }
+static inline bool xen_preemptible_hcall_get(void) { return false; }
 
 #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
 
-- 
2.31.1

