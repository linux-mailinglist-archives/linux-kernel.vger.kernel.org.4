Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CB8709CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjESQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjESQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:48:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0A110E7;
        Fri, 19 May 2023 09:48:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 938603200908;
        Fri, 19 May 2023 12:48:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 19 May 2023 12:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684514895; x=
        1684601295; bh=lT+iHz9VrY0aHR4mBtelHXJF3fZY/6N67rP+knhqt9U=; b=Z
        oIO1XJyARA8XmXB70u3bHm/1ernCqXuWoVFyXEWzsVKlTzKL2FYvpqeljGShe6uy
        B05rx0H/supgPr48Eo90PkHo5lLcori7DJHdS+WXj8aqGOf2ZOvGjgAruuajB3B8
        pXAOdNfVObTJ1vVPiRkt46mDhfSzIkKYRuDn0aUs66NIvhTsmbdov8BkQ23MrLre
        bgiHTNLKhDDzl26iwoBgXVPAeTvys/HlkK9qNNctljSxg5ZGGux2t9DYx8JEbxLg
        knk38dt9u444x/9DGjs57kbiaQI6nElyIJGXGW0V+poBMwpYPDrFN6KCFBCaSEXa
        72S9aTXTWnn0booCbzzHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684514895; x=
        1684601295; bh=lT+iHz9VrY0aHR4mBtelHXJF3fZY/6N67rP+knhqt9U=; b=m
        E8OKV/2g08djVBZlv0mfpQoEGjiasVaxF2RbczZihnZa4NiLvuTGG/cFRapcQxc2
        GJPf5wZguII7Y7+UyJhzF8KwY/ByJKrcSJVMKbQM6UmgxqELtMEz0HF1PuF6L5+X
        Q1xvVQPA63RabHErBotCiBtZNpHwXaB7lCm7tsyoFCuAJN67JoMCOlW+4xh+BU0q
        /yWTi8/0zaoYq9ZJeNIOC0k1gkjzo+E+zpbXUmNv+p8ySVtchSgG3zYbKflBwzLz
        WdwP0PMqQ4bd9UF87jZvmyYu1Cqr8R1iT6yuqJi6fq/5Sa/EtQpAI6qmJn/N/ud4
        Qttj9Xk74WFlITMlKf2Ow==
X-ME-Sender: <xms:T6hnZBsyFY1jrRqlJzJUReoS_X5BAIwT7A26d8k1BqIDx1LwjMBB1A>
    <xme:T6hnZKez5P_CQXaLvdokMDdOZ8tKsmqcIYJGJXTta_iwVN8oJ7iDXrap_m29Llw6n
    apVzOQXdf49UKMf50g>
X-ME-Received: <xmr:T6hnZEzgHNV3p0Yp_aqIII1W_8jn8ZmldOd5BMOcIjnB-07r-A5diPX9ZS80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
    dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:T6hnZIM0w6Hos1IGaYKF-FMl7Ja1u73tBRv7czDsHcdg4E__GOa18A>
    <xmx:T6hnZB_SUoAWascQSdTwsu-S6llo4lf_Mx_RDn-57S9vri-IdeU8LA>
    <xmx:T6hnZIXthSNQT_1jDAlWbqdLVlsuO7eGtu-nZRKehyYPpxky8qE6Aw>
    <xmx:T6hnZDJkdFewa5sIwWEnrAAMrdJCPPwSTqbCncSHUK3cJRaeBmxP6Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 12:48:14 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] MIPS: Introduce config options for LLSC availability
Date:   Fri, 19 May 2023 17:47:52 +0100
Message-Id: <20230519164753.72065-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
References: <20230519164753.72065-1-jiaxun.yang@flygoat.com>
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

Introduce CPU_HAS_LLSC and CPU_MAY_HAVE_LLSC to determine availability
of LLSC and Kconfig level.

They are both true for almost all supported CPUs besides:

R3000: Doesn't have LLSC, so both false.
R5000 series: LLSC is unusable for 64bit kernel, so both false.
R10000: Some platforms decided to opt-out LLSC due to errata, so only
	select CPU_MAY_HAVE_LLSC.
WAR_4KC_LLSC: LLSC is buggy on certain reversion, which can be detected
	at cpu-probe or platform override, so only select CPU_MAY_HAVE_LLSC.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                    | 20 ++++++++++++++++++++
 arch/mips/include/asm/cpu-features.h |  7 ++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 354d033364ad..85728e4703bd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1539,6 +1539,7 @@ config CPU_R3000
 config CPU_R4300
 	bool "R4300"
 	depends on SYS_HAS_CPU_R4300
+	select CPU_HAS_LLSC
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	help
@@ -1547,6 +1548,7 @@ config CPU_R4300
 config CPU_R4X00
 	bool "R4x00"
 	depends on SYS_HAS_CPU_R4X00
+	select CPU_HAS_LLSC
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
@@ -1557,6 +1559,7 @@ config CPU_R4X00
 config CPU_TX49XX
 	bool "R49XX"
 	depends on SYS_HAS_CPU_TX49XX
+	select CPU_HAS_LLSC
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
@@ -1565,6 +1568,7 @@ config CPU_TX49XX
 config CPU_R5000
 	bool "R5000"
 	depends on SYS_HAS_CPU_R5000
+	select CPU_HAS_LLSC if !64BIT
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
@@ -1574,6 +1578,7 @@ config CPU_R5000
 config CPU_R5500
 	bool "R5500"
 	depends on SYS_HAS_CPU_R5500
+	select CPU_HAS_LLSC
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
@@ -1584,6 +1589,7 @@ config CPU_R5500
 config CPU_NEVADA
 	bool "RM52xx"
 	depends on SYS_HAS_CPU_NEVADA
+	select CPU_HAS_LLSC if !64BIT
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HUGEPAGES
@@ -1593,6 +1599,8 @@ config CPU_NEVADA
 config CPU_R10000
 	bool "R10000"
 	depends on SYS_HAS_CPU_R10000
+	select CPU_HAS_LLSC if !WAR_R10000_LLSC
+	select CPU_MAY_HAVE_LLSC
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
@@ -1604,6 +1612,7 @@ config CPU_R10000
 config CPU_RM7000
 	bool "RM7000"
 	depends on SYS_HAS_CPU_RM7000
+	select CPU_HAS_LLSC
 	select CPU_HAS_PREFETCH
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
@@ -1613,6 +1622,7 @@ config CPU_RM7000
 config CPU_SB1
 	bool "SB1"
 	depends on SYS_HAS_CPU_SB1
+	select CPU_HAS_LLSC
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
@@ -1645,6 +1655,7 @@ config CPU_BMIPS
 	select CPU_BMIPS4350 if SYS_HAS_CPU_BMIPS4350
 	select CPU_BMIPS4380 if SYS_HAS_CPU_BMIPS4380
 	select CPU_BMIPS5000 if SYS_HAS_CPU_BMIPS5000
+	select CPU_HAS_LLSC
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select DMA_NONCOHERENT
 	select IRQ_MIPS_CPU
@@ -2382,6 +2393,15 @@ config CPU_DIEI_BROKEN
 config CPU_HAS_RIXI
 	bool
 
+# For CPU that must have LLSC
+config CPU_HAS_LLSC
+	def_bool TARGET_ISA_REV > 0 && !WAR_4KC_LLSC
+	select CPU_MAY_HAVE_LLSC
+
+# For CPU that LLSC support is optional
+config CPU_MAY_HAVE_LLSC
+	def_bool TARGET_ISA_REV > 0
+
 config CPU_NO_LOAD_STORE_LR
 	bool
 	help
diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 51a1737b03d0..2a0b90077b50 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -185,8 +185,13 @@
 #ifndef cpu_has_ejtag
 #define cpu_has_ejtag		__opt(MIPS_CPU_EJTAG)
 #endif
+
 #ifndef cpu_has_llsc
-#define cpu_has_llsc		__isa_ge_or_opt(1, MIPS_CPU_LLSC)
+# ifdef CONFIG_CPU_MAY_HAVE_LLSC
+#  define cpu_has_llsc		(IS_ENABLED(CONFIG_CPU_HAS_LLSC) ||  __opt(MIPS_CPU_LLSC))
+# else
+#  define cpu_has_llsc		0
+# endif
 #endif
 #ifndef kernel_uses_llsc
 #define kernel_uses_llsc	cpu_has_llsc
-- 
2.39.2 (Apple Git-143)

