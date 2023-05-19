Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00E709C72
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjESQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjESQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:30:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3562C1;
        Fri, 19 May 2023 09:30:37 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2B2BA320089C;
        Fri, 19 May 2023 12:30:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 19 May 2023 12:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1684513834; x=1684600234; bh=sVerXNkFXD
        WVBV5DE1l1ISNu6UQ6WGVsKYLhufMC0fo=; b=ZsgkLXXUhlQVEZoSth6A1Jlkvs
        g219ItM5xjqfMFyOxd3zE5Qy55hQ8QmIDFsdw/fy8gZoHGRDshD+0jP/eFkSar2K
        ZHdnJ7Ylzcr47U0reO2ETWwepv84CERoc3PPd9Z85yaWGfI0gNLjWHUwoHHl4ClN
        LAd0fVJ2pfdsNgXBTgD1V3latrgbdfd7tM/VYpDJCMyBUOz97XQq/xAnznuFNZzG
        i05o5tEmXqFDBRruvPvXGPlky3mxCViH9TQJU1nD1I64hsoVgo5s5KA376hMMBEU
        zLY+W3rmxYkwDekjPgVZmzG+lD7xeWkTjIR81hyq9fmMYXvojkkh3Ox6kAjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684513834; x=1684600234; bh=sVerXNkFXDWVB
        V5DE1l1ISNu6UQ6WGVsKYLhufMC0fo=; b=pvYcpvHJ3k/2QSYXnmJO/ppgf943F
        zLELjSHilxh6bLNwXWp3tFWd5mInKmr70oymTWSQpQ0N8w9Ub2OktcHCTRYIIyvE
        8UWa98ygItZFJ82wIeLRDxmPjKzPA/LC1HVjxA4rG+EwxR0F+NSBpqnI68BdgHlP
        7nyDtgHrznciRB4/MtMEvlErv4rSYN56bIl8C0qnTejdx9oXtXO1hcC8rIT4tz/z
        +vM55U91cv8lDdMN2/AIZWvH8u7YFqqUbL3qM7UQ9gFKVTiAKkCaxRTvpWfIjmF2
        V+XPYRNTCE49eKPKLYIbEWIBaBnmEkfe6WTx9R6Rxg7tyxm4xwgFnmAaQ==
X-ME-Sender: <xms:KqRnZNsvqH0Sm4cm2CPhgbRgffRmsDhBKtId50PYZxtmdfcfx80xGQ>
    <xme:KqRnZGc-devM_E1qicWYu7NTZ-UsAThY4xkgl0qJXkUKSa3SW5qfzwXdcHgMY4REw
    2OAAZflo4yAcP1HVFs>
X-ME-Received: <xmr:KqRnZAx0UGdkK9I3SfI9-daHEywiKXCOPDftadzkPnHHnNsiiJA94x4MNBim>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeekuedvlefhuedtffetve
    dtleelvdehveejteevffevledtkedvudelveevudfgleenucffohhmrghinhepfhhpuhdr
    shgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjh
    hirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:KqRnZEOdd-2xWOxy6QDeT9CG7sksd3DO8xDQBPXNY8WgNpOt55ZEsg>
    <xmx:KqRnZN_rP-PIR27QTIZWbpHrn5n57FAlzWK1XSPQbmjigd7R5LKKgw>
    <xmx:KqRnZEVknITnDxvy4zqPPVvx-jCcFuJFHj2cIGHLKwo-9QQiHjZGNg>
    <xmx:KqRnZPL1wlPyQ56cWGhYdISp4LYxYGz96f7zo9DvfNIdgID7dDGWhA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 12:30:33 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] MIPS: Fix MIPS_O32_FP64_SUPPORT for 64bit CPUs before R2
Date:   Fri, 19 May 2023 17:30:23 +0100
Message-Id: <20230519163023.70542-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS_O32_FP64_SUPPORT enables possibility of using all 32 FPRs on 32bit
kernel in case CPU implemented FR1. As FR1 is present on all 64bit CPUs
following R4000's priviliged spec, there is no reason to limit such support
to R2+ CPUs.

Fix it by remove architecture reversion conditions in FR1 context switch
code and enable relevant bits in kernel's FIR copy.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/asmmacro.h |  6 ++----
 arch/mips/include/asm/fpu.h      |  3 +--
 arch/mips/kernel/elf.c           |  5 ++---
 arch/mips/kernel/fpu-probe.c     | 17 +++++++++++++++++
 arch/mips/kernel/r4k_fpu.S       | 16 ++++++----------
 5 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 067a635d3bc8..3e7c19ee6a90 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -130,8 +130,7 @@
 	.endm
 
 	.macro	fpu_save_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
-    defined(CONFIG_CPU_MIPSR5) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS_O32_FP64_SUPPORT)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f
 	fpu_save_16odd \thread
@@ -189,8 +188,7 @@
 	.endm
 
 	.macro	fpu_restore_double thread status tmp
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
-    defined(CONFIG_CPU_MIPSR5) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS_O32_FP64_SUPPORT)
 	sll	\tmp, \status, 5
 	bgez	\tmp, 10f				# 16 register mode?
 
diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
index 86310d6e1035..1cd820e79f77 100644
--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -71,8 +71,7 @@ static inline int __enable_fpu(enum fpu_mode mode)
 		goto fr_common;
 
 	case FPU_64BIT:
-#if !(defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5) || \
-      defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_64BIT))
+#if !(defined(CONFIG_64BIT) || defined(CONFIG_MIPS_O32_FP64_SUPPORT))
 		/* we only have a 32-bit FPU */
 		return SIGFPE;
 #endif
diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index 5582a4ca1e9e..0895bc9b5dd7 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -250,9 +250,8 @@ int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
 		state->overall_fp_mode = FP_FRE;
 	else if ((prog_req.fr1 && prog_req.frdefault) ||
 		 (prog_req.single && !prog_req.frdefault))
-		/* Make sure 64-bit MIPS III/IV/64R1 will not pick FR1 */
-		state->overall_fp_mode = ((raw_current_cpu_data.fpu_id & MIPS_FPIR_F64) &&
-					  cpu_has_mips_r2_r6) ?
+		/* Make sure CPUs without FR1 will not pick FR1 */
+		state->overall_fp_mode = (raw_current_cpu_data.fpu_id & MIPS_FPIR_F64) ?
 					  FP_FR1 : FP_FR0;
 	else if (prog_req.fr1)
 		state->overall_fp_mode = FP_FR1;
diff --git a/arch/mips/kernel/fpu-probe.c b/arch/mips/kernel/fpu-probe.c
index e689d6a83234..383c43e5c86a 100644
--- a/arch/mips/kernel/fpu-probe.c
+++ b/arch/mips/kernel/fpu-probe.c
@@ -289,6 +289,23 @@ void cpu_set_fpu_opts(struct cpuinfo_mips *c)
 			c->options |= MIPS_CPU_FRE;
 	}
 
+	/* Fix up FIR for FPU earlier than R2 */
+	if (!cpu_has_mips_r2_r6) {
+		c->fpu_id |= MIPS_FPIR_S;
+#ifdef CONFIG_CPU_R4K_FPU
+		/* All known R4000 class FPU implemented double */
+		c->fpu_id |= MIPS_FPIR_D;
+#endif
+		if (cpu_has_64bits) {
+			/* Try to enable FR1 */
+			change_c0_status(ST0_FR, ST0_FR);
+			if (read_c0_status() & ST0_FR) {
+				c->fpu_id |= MIPS_FPIR_F64;
+				c->options |= MIPS_CPU_32FPR;
+			}
+		}
+	}
+
 	cpu_set_fpu_fcsr_mask(c);
 	cpu_set_fpu_2008(c);
 	cpu_set_nan_2008(c);
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 4e8c98517d9d..eeef115fc39e 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -40,8 +40,7 @@
  */
 LEAF(_save_fp)
 EXPORT_SYMBOL(_save_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
-    defined(CONFIG_CPU_MIPSR5) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS_O32_FP64_SUPPORT)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_save_double a0 t0 t1		# clobbers t1
@@ -52,8 +51,7 @@ EXPORT_SYMBOL(_save_fp)
  * Restore a thread's fp context.
  */
 LEAF(_restore_fp)
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
-    defined(CONFIG_CPU_MIPSR5) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS_O32_FP64_SUPPORT)
 	mfc0	t0, CP0_STATUS
 #endif
 	fpu_restore_double a0 t0 t1		# clobbers t1
@@ -102,11 +100,10 @@ LEAF(_save_fp_context)
 	cfc1	t1, fcr31
 	.set	pop
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
-    defined(CONFIG_CPU_MIPSR5) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS_O32_FP64_SUPPORT)
 	.set	push
 	.set	hardfloat
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5)
+#if MIPS_ISA_REV < 6
 	.set	mips32r2
 	.set	fp=64
 	mfc0	t0, CP0_STATUS
@@ -170,11 +167,10 @@ LEAF(_save_fp_context)
 LEAF(_restore_fp_context)
 	EX	lw t1, 0(a1)
 
-#if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPSR2) || \
-    defined(CONFIG_CPU_MIPSR5) || defined(CONFIG_CPU_MIPSR6)
+#if defined(CONFIG_64BIT) || defined(CONFIG_MIPS_O32_FP64_SUPPORT)
 	.set	push
 	.set	hardfloat
-#if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5)
+#if MIPS_ISA_REV < 6
 	.set	mips32r2
 	.set	fp=64
 	mfc0	t0, CP0_STATUS
-- 
2.39.2 (Apple Git-143)

