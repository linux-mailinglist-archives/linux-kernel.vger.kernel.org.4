Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC770B1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjEUWdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjEUWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:32:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A09E45;
        Sun, 21 May 2023 15:32:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 36B905C00F0;
        Sun, 21 May 2023 18:31:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 21 May 2023 18:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684708291; x=
        1684794691; bh=FXoxgR8soaAJE0zXIWRGojqbl0zMimoMys8rNjtPPdI=; b=b
        psN3wndsrJr0wl4MmXW08m0fuIXwoyL1ZI63w4JqjW/QURuL2OMTcgVpKBSKtB28
        k9MWxvjLL+bKzXqkvD+Dp0bgfBrwt+QvWF4DkP1Ucod53lE0kfVlV7g9wpLX1Thw
        IM6In7ZiSgYovWhTba5cqnLyYHk8OWWA7FKQT5/xlr/fPtDC+ZLzIkYN6ws7de9D
        Gum341qC+0eF3Vm9MXS+D+U3NVTEbx1o6b0syykxu7DkDVoUiVfL518uNkhuAEva
        AptBfa7R5EXEuS7Yig5jozTfAq4jmorvVLFNyijrc3nILoA3jnlLzQSA2KZKzk+M
        X/mGCN56abrIBhbCsv6jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684708291; x=
        1684794691; bh=FXoxgR8soaAJE0zXIWRGojqbl0zMimoMys8rNjtPPdI=; b=b
        +Mj8sBtXEWwt7W2MMwZD07ND+pmeZW8vzGbaeBIOB1u3GG9m94HdUCY233nBNLkf
        LediTkWWk3aTYVr0ZxsUrPulAmdhV4j0FYAmcxxlENuz6GYIearFrTEJqZj3LZVY
        RoUuha7EeAh23O9+PtB/hC49WWJ78uH4qeb4BTafq6YM0vM4CTnAC+sPBsrZskN9
        poq/vTJ1tr5WsNtKD33W5e9uOaC3cxi4hhXpfSO0jmifqAPRbQWkbx1HhJ1ysGG5
        H/uSjNOJ0LREhomswpdOH+c0H2UBuhsSpLx3ExdR5Xch/Tt+VJ+J09WthOsVlB9F
        1mOE4QOO0o2xBnWIb4zCw==
X-ME-Sender: <xms:wptqZPbAt2xF-_wDWy3mqpJBQ_ie-T97Q_rLobveNq-_Mxrl3Hjh4A>
    <xme:wptqZOZIWOChgJtDzhthzkVtpzUX9rGAU7GDgOnM--Qlt0oT8ILkHCoUo758DLIOI
    BfZmNeqh9HIQ_C5xco>
X-ME-Received: <xmr:wptqZB8GfnbeSnOoIuwO14RXzRaeloAvTvNmY4b1Vi6JWRHltk97ZTGsnjkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:wptqZFrhn3iYtZupmspOO3Wd3sGfwG0P4_YfnfvCUfRt7XKAei1P3w>
    <xmx:wptqZKqTxQe-5tsI_-c93LeDWlOzej7FSenRABQpZvSKseSgAh1thw>
    <xmx:wptqZLQ3ad8qVytXOJb48mPkj6EqwiEuHmmo3JJpX5rbJm_c26-BrA>
    <xmx:w5tqZDnL4gliiHVyql4zn9GzmP3Q7mbriBM08s7qLfShdiaDKZezQg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 18:31:29 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] MIPS: Rework smt cmdline parameters
Date:   Sun, 21 May 2023 23:31:22 +0100
Message-Id: <20230521223124.21911-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
References: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a generic smt parameters interface aligned with s390
to allow users to limit smt usage and threads per core.

It replaced previous undocumented "nothreads" parameter for
smp-cps which is ambiguous and does not cover smp-mt.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../admin-guide/kernel-parameters.txt          |  4 ++--
 arch/mips/include/asm/smp.h                    |  2 ++
 arch/mips/kernel/smp-cps.c                     | 13 +------------
 arch/mips/kernel/smp-mt.c                      |  3 ++-
 arch/mips/kernel/smp.c                         | 18 ++++++++++++++++++
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91963d3f0d5c..515cd1f88ea2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3830,7 +3830,7 @@
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel,
 			and disable the IO APIC.  legacy for "maxcpus=0".
 
-	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
+	nosmt		[KNL,MIPS,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
 			[KNL,X86] Disable symmetric multithreading (SMT).
@@ -5743,7 +5743,7 @@
 				1: Fast pin select (default)
 				2: ATC IRMode
 
-	smt=		[KNL,S390] Set the maximum number of threads (logical
+	smt=		[KNL,MIPS,S390] Set the maximum number of threads (logical
 			CPUs) to use per physical CPU on systems capable of
 			symmetric multithreading (SMT). Will be capped to the
 			actual hardware limit.
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index aab8981bc32c..a40d8c0e4b87 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -57,6 +57,8 @@ extern int __cpu_logical_map[NR_CPUS];
 /* Mask of CPUs which are currently definitely operating coherently */
 extern cpumask_t cpu_coherent_mask;
 
+extern unsigned int smp_max_threads __initdata;
+
 extern asmlinkage void smp_bootstrap(void);
 
 extern void calculate_cpu_foreign_map(void);
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index d7fdbec232da..474318bc08cb 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -25,24 +25,13 @@
 #include <asm/time.h>
 #include <asm/uasm.h>
 
-static bool threads_disabled;
 static DECLARE_BITMAP(core_power, NR_CPUS);
 
 struct core_boot_config *mips_cps_core_bootcfg;
 
-static int __init setup_nothreads(char *s)
-{
-	threads_disabled = true;
-	return 0;
-}
-early_param("nothreads", setup_nothreads);
-
 static unsigned core_vpe_count(unsigned int cluster, unsigned core)
 {
-	if (threads_disabled)
-		return 1;
-
-	return mips_cps_numvps(cluster, core);
+	return min(smp_max_threads, mips_cps_numvps(cluster, core));
 }
 
 static void __init cps_smp_setup(void)
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 5f04a0141068..7729cc733421 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -46,7 +46,8 @@ static void __init smvp_copy_vpe_config(void)
 static unsigned int __init smvp_vpe_init(unsigned int tc, unsigned int mvpconf0,
 	unsigned int ncpu)
 {
-	if (tc > ((mvpconf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT))
+	if (tc >= smp_max_threads ||
+		(tc > ((mvpconf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT)))
 		return ncpu;
 
 	/* Deactivate all but VPE 0 */
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 90c71d800b59..8fbef537fb88 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -73,6 +73,24 @@ static cpumask_t cpu_core_setup_map;
 
 cpumask_t cpu_coherent_mask;
 
+unsigned int smp_max_threads __initdata = UINT_MAX;
+
+static int __init early_nosmt(char *s)
+{
+	smp_max_threads = 1;
+	return 0;
+}
+early_param("nosmt", early_nosmt);
+
+static int __init early_smt(char *s)
+{
+	get_option(&s, &smp_max_threads);
+	/* Ensure at least one thread is available */
+	smp_max_threads = clamp_val(smp_max_threads, 1U, UINT_MAX);
+	return 0;
+}
+early_param("smt", early_smt);
+
 #ifdef CONFIG_GENERIC_IRQ_IPI
 static struct irq_desc *call_desc;
 static struct irq_desc *sched_desc;
-- 
2.39.2 (Apple Git-143)

