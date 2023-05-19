Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5B709CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjESQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjESQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:48:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D475E10FA;
        Fri, 19 May 2023 09:48:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9B3C43200935;
        Fri, 19 May 2023 12:48:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 19 May 2023 12:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684514893; x=
        1684601293; bh=F3XQUAgQCOlN5uBkLtjyaKBz6CFsqhjFQGgXG6jbvic=; b=K
        c8WU7T8IkBvsJCSF/9uQ7LT/WB532t+YlDO+jchAXzlyhtdz8C3tQwubUgF+StP2
        Cu95oiJfD7CO8oUELxmprroaS1CokTggSdw8/4UREl0R1R9Bq+dCCZGXYhbjIve6
        BHJyzXj7kx7efUbZNtHnD3sB9XqpZg7U0ADrJI0jXMfoFfQNjXkA+JZ/+U3NibGl
        V2i+JelcxBQ0ehS1eqxugCR4MpFhet2Q9oLmwNLuISyQgn+WXp8gRCE2Nu5SCIwX
        o1vNZwQPdeNZ4Zn3YamanLYFaQAFsrWeISVqRA57FwGHPv8X8md7BmdI1jBLBqe2
        gprhxBDAVTdr2Ft55NJyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684514893; x=
        1684601293; bh=F3XQUAgQCOlN5uBkLtjyaKBz6CFsqhjFQGgXG6jbvic=; b=H
        arxxgnxMHSrlbj9no4qixqDtlz+Er+fOSZuO0UcSue2pLGf96sEQhympqL8zZBb3
        4iVpqbVEwP+EYUzDs0HZglndCIW5QuazTgFAwBt0/e9h+4MDy4ooIDRNxPrhe4QA
        qOLLf5IR+4pnoNQf2yEJUlsDhEaByt33u/V5+kgd/jNm57Ugv7ml8lb39py1TJsb
        hyfanwD8xzMXh6GqTt9QMoJkol+XkuZAbJeiAQbN/XtNdIgZ0U9Lc2JZBp4Prxwp
        kvAqr+pPtCDfoXmm/6D/L7y9aC/+eLUBsvBEV6fxRyqkZOc5FW+nOJnBLl7xeM+g
        YnJ7dpWUOCvjiYi8cF+oA==
X-ME-Sender: <xms:TahnZCmNDv65y6eHYahQkXZydy60Eskxl7ElsTvT5-95EwAiYVomkw>
    <xme:TahnZJ0MxzaTFgf9y-5IjPqMHT3dOYXfzHH-kbWHm0Ig6eeL5LHbF0wawcoPoz_6U
    BX8Q9TJ7S-r6cVq0Sc>
X-ME-Received: <xmr:TahnZArFMeavcUb-xecYHwDP9DKzVmJGj5Mhh-NqM86b6ZDYkcwRV-exUipt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
    dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:TahnZGlNU1CRXCqo2zEcE_V-O-0NRybvYjY-X61tXCPAkb89OvGkyw>
    <xmx:TahnZA0QFLJOzNZOf_QgR8JJ_e3HaeRDPfM7dce1IW2d6i1yD3RWgA>
    <xmx:TahnZNsf2WvqTwXiH1L8dGSyX2LBR-bBfpi86ov-1WLqakvLWe3FYA>
    <xmx:TahnZOAxOozfzEv86nu-Yh_A3ew_z9V8Wdw4Z6Pl_Zwau0W8uHjYBA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 12:48:12 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] MIPS: Introduce WAR_4KC_LLSC config option
Date:   Fri, 19 May 2023 17:47:51 +0100
Message-Id: <20230519164753.72065-2-jiaxun.yang@flygoat.com>
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

WAR_4KC_LLSC is used to control workaround of 4KC LLSC issue
that affects 4Kc up to version 0.9.

Early ath25 chips are known to be affected.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig                                        | 6 ++++++
 arch/mips/include/asm/cpu.h                              | 1 +
 arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h | 2 +-
 arch/mips/kernel/cpu-probe.c                             | 7 +++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 30e90a2d53f4..354d033364ad 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -230,6 +230,7 @@ config ATH25
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_HAS_EARLY_PRINTK
+	select WAR_4KC_LLSC if !SOC_AR5312
 	help
 	  Support for Atheros AR231x and Atheros AR531x based boards
 
@@ -2544,6 +2545,11 @@ config WAR_ICACHE_REFILLS
 config WAR_R10000_LLSC
 	bool
 
+# On 4Kc up to version 0.9 (PRID_REV < 1) there is a bug that may cause llsc
+# sequences to deadlock.
+config WAR_4KC_LLSC
+	bool
+
 # 34K core erratum: "Problems Executing the TLBR Instruction"
 config WAR_MIPS34K_MISSED_ITLB
 	bool
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index ecb9854cb432..84bb1931a8b4 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -247,6 +247,7 @@
 #define PRID_REV_VR4122			0x0070
 #define PRID_REV_VR4181A		0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130			0x0080
+#define PRID_REV_4KC_V1_0		0x0001
 #define PRID_REV_34K_V1_0_2		0x0022
 #define PRID_REV_LOONGSON1B		0x0020
 #define PRID_REV_LOONGSON1C		0x0020	/* Same as Loongson-1B */
diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
index ec3604c44ef2..5df292b1ff04 100644
--- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
@@ -24,7 +24,7 @@
 #define cpu_has_counter			1
 #define cpu_has_ejtag			1
 
-#if !defined(CONFIG_SOC_AR5312)
+#if !defined(WAR_4KC_LLSC)
 #  define cpu_has_llsc			1
 #else
 /*
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 6d15a398d389..fd452e68cd90 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -152,6 +152,13 @@ static inline void check_errata(void)
 	struct cpuinfo_mips *c = &current_cpu_data;
 
 	switch (current_cpu_type()) {
+	case CPU_4KC:
+		if ((c->processor_id & PRID_REV_MASK) < PRID_REV_4KC_V1_0) {
+			c->options &= ~MIPS_CPU_LLSC;
+			if (!IS_ENABLED(CONFIG_WAR_4K_LLSC))
+				pr_err("CPU have LLSC errata, please enable CONFIG_WAR_4K_LLSC");
+		}
+		break;
 	case CPU_34K:
 		/*
 		 * Erratum "RPS May Cause Incorrect Instruction Execution"
-- 
2.39.2 (Apple Git-143)

