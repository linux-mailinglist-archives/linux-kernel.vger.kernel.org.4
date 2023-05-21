Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2860F70B1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjEUWdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjEUWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:33:09 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70B119;
        Sun, 21 May 2023 15:32:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D11665C00F4;
        Sun, 21 May 2023 18:31:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 21 May 2023 18:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684708293; x=
        1684794693; bh=U6/bYfEfdJ3fMhA2vzQuq00Kk2+AAgQk/ba6AQ72FxM=; b=j
        Y102dQi119pmHqHObrU9VmemtgwIc5xfMzXoESGQnRuZNmjAr8cyC8KwYBIOC3oX
        3iScrmkFTFV6YjhndRsQAdICTYow058rWKDC0i4HUUaJJn+U1uJvkPIqxMvt+lIO
        HUbWlFhdJhm+fAzKh0yRVxEgL29JVlqUz5RZnb274i93A8K+ebfCO3Tvfz/WlRVJ
        XnK3Vd91GQJfVOWWM7LVbADOMQR6pCzDT/Ivotu5ugfhM1IGKIf/vWn6r8yo/VBA
        NByDDsrCkhwNze/n7JYgtwpCuSa/YHaW3MxECWQgbCzR4d0sHwVTG/OrFN/le0gd
        0px+HpQxoc+M/eujRTxvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684708293; x=
        1684794693; bh=U6/bYfEfdJ3fMhA2vzQuq00Kk2+AAgQk/ba6AQ72FxM=; b=k
        hSs49pPR1q8viz+c3Mbo0BZ3JEiQ5GBliHmchB9B0MbbeQ399wacNtH1dQU6qwCq
        oLXTTRrJCiwvwWJwoO82DKM2u0eYFP0K/CaBRTPFxsJ1wm4IeOBIgN/m2SqFBKpz
        yIoGYTB0uNO3+x3u4Cjsz1WCtrdp50KrspjkMDfzA3lJJdaQfKumn+ILsBzF3h2d
        YkA5/qDHmiWFaWR+VL/2lCyzOuHxvfV6WXispf5EmDTlC0aj6X6HzxyEvxN+x88H
        Y6tq3ez9Qj2xopvGZ42Sur0Ln12e1mVhPu3psYeATGvAij8azh0FoSvKQ+oXYfVv
        eTeFSlLg0VDs6gi02pL5g==
X-ME-Sender: <xms:xZtqZPxa-PKhRtZERG7MyczOAnvmw8A3SKh_fTqNZ6cZUNo9N2YuqQ>
    <xme:xZtqZHRBw0VvWrOSlIjYC8qmgs56Mv1WpeElx4AvAWXPjOxrM-jSITQ6aDRoUCYPJ
    pdTiDGStqp-x5heubo>
X-ME-Received: <xmr:xZtqZJVuQQdGMm1Zmx7EHUK6FsrMMSJsSODc8rjAtr0lOmXlAvLGyxvlJkKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:xZtqZJhfdUzqzpyrNSq0UJAGnJS2AXfdf58ytfYR7mFQKcNO0yzMKg>
    <xmx:xZtqZBAIQC7506G9KgBOOT7Meih25e0vKtCG0-fk1F2IS_EK0ztxfA>
    <xmx:xZtqZCJrKAjtEOClLmY2RVZwYyiIIFd-kvM-y973g0WjIu7BFKm3OQ>
    <xmx:xZtqZM-p-S3q6tkrVQQZH706ORknvTmoMm-x-I7748KPH9h8F3YT1w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 18:31:32 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] Documentation: kernel-parameters: Add some MIPS parameters
Date:   Sun, 21 May 2023 23:31:24 +0100
Message-Id: <20230521223124.21911-4-jiaxun.yang@flygoat.com>
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

Those parameters lives in MIPS kernel since very start.
Document them for convenience.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../admin-guide/kernel-parameters.txt         | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9c502d3aa0cd..67a0c3f7eca3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -713,6 +713,8 @@
 			Sets the size of memory pool for coherent, atomic dma
 			allocations, by default set to 256K.
 
+	coherentio	[KNL,MIPS] Force enable hardware DMA cache coherency.
+
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
 			<io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
@@ -3626,6 +3628,8 @@
 
 	nocache		[ARM]
 
+	nocoherentio	[KNL,MIPS] Force enable software DMA cache coherency.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
@@ -3645,6 +3649,7 @@
 			[KNL] Disable object debugging
 
 	nodsp		[SH] Disable hardware DSP at boot time.
+			[MIPS] Disable DSP ASE at boot time.
 
 	noefi		Disable EFI runtime services support.
 
@@ -3667,6 +3672,8 @@
 
 	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
+	noftlb		[MIPS] Disable Fixed TLB at boot time.
+
 	nofxsr		[BUGS=X86-32] Disables x86 floating point extended
 			register save and restore. The kernel will only save
 			legacy floating-point registers on task switch.
@@ -3678,6 +3685,8 @@
 			in certain environments such as networked servers or
 			real-time systems.
 
+	nohtw		[MIPS] Disable hardware page table walker at boot time.
+
 	no_hash_pointers
 			Force pointers printed to the console or buffers to be
 			unhashed.  By default, when a pointer is printed via %p
@@ -3758,6 +3767,8 @@
 
 	nolapic_timer	[X86-32,APIC] Do not use the local APIC timer.
 
+	noulri          [MIPS] Disable RDHWR ULR access for user space.
+
 	nomca		[IA-64] Disable machine check abort handling
 
 	nomce		[X86-32] Disable Machine Check Exception
@@ -3882,6 +3893,8 @@
 			[X86,PV_OPS] Disable paravirtualized VMware scheduler
 			clock and use the default one.
 
+	nowait		[MIPS] Disable the wait instruction for idle.
+
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
@@ -3893,6 +3906,8 @@
 			LEGACY_XAPIC_DISABLED bit set in the
 			IA32_XAPIC_DISABLE_STATUS MSR.
 
+	noxpa		[MIPS] Disable XPA (eXtended Physical Addressing) ASE.
+
 	noxsave		[BUGS=X86] Disables x86 extended register state save
 			and restore using xsave. The kernel will fallback to
 			enabling legacy floating-point and sse state.
@@ -3936,6 +3951,8 @@
 
 	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
 
+	ntlb=		[MIPS] Override max number of TLB entries.
+
 	numa=off 	[KNL, ARM64, PPC, RISCV, SPARC, X86] Disable NUMA, Only
 			set up a single NUMA node spanning all memory.
 
@@ -5273,6 +5290,18 @@
 	rcupdate.rcu_self_test= [KNL]
 			Run the RCU early boot self tests
 
+	rd_size=	[KNL,MIPS]
+			Specify size of initrd in memory.
+			Need to be used with rd_start.
+
+	rd_start=	[KNL,MIPS]
+			Specify a virtual address from which to load the initrd.
+			Must in KSEG0 or XKPHYS space.
+			Need to be used with rd_size.
+
+	rdhwr_noopt	[MIPS] Disable optimization of trap and emulation for
+			"RDHWR v1, $29" instruction.
+
 	rdinit=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /init from the ramdisk,
-- 
2.39.2 (Apple Git-143)

