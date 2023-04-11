Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414826DD914
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDKLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDKLM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91482BA;
        Tue, 11 Apr 2023 04:12:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C12315C00C2;
        Tue, 11 Apr 2023 07:12:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Apr 2023 07:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1681211568; x=1681297968; bh=NAKOvLI4RsnFPGBuXhbz8aSMu8was8JKV0h
        Nv5q1VA8=; b=pr58Mj2zWse46UhLZETmLm0mcc9bIqiMMtnNhYau09iIZae6+6M
        mcb24FYU4MfmAGudC/Ne3e2Q07Bq/y4fymnmrV96vcncTK9ppSb2QDFUTB1kDgja
        oen/awyUGTMQz2GhEW6iFsPwiH6NZneK2UQByDQJsEQtL4sejOAZNNUzVk3EpG3y
        WMVWiI5hiaMZ/HFwZpVlUuSXtQqlVQsbLaeM90z1YN6Z5QMSKLXiKfC4WJvWPVHO
        fzalwqlmXgwnAGf2So2PiD+gQKR5Da6wrHHR67zPWX55QLpNyn7HQe75BBNEjZjj
        PYz4HMpsfB7qTn1huaAU5tx0B/DTMr2GJ/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681211568; x=1681297968; bh=NAKOvLI4RsnFPGBuXhbz8aSMu8was8JKV0h
        Nv5q1VA8=; b=A3yYMyOqUNqzAPkBisn9yrJfGFvpIEWKbfw5lFqhGVGz5xd/VLC
        TDyE4LHUjs9CsoXFoFKlC9ML3lmzCJ4VhM0eETcgxEA3SY718voF03T7s7/xIsrm
        57mag4e1ZtBlpe4YSjvO9zkpSDPIGA7/8qgZdDjLrKXgov5Mz2ebCDGFB8XZ86vb
        /WkKFJor5pa2+4HDpo5fobJ+TlT/fQuVBmX84FyVOqzKqhJ/lcsf3VyzIlG7YjHK
        Qpkw2GPHfkVsjruCsFR3zCqaoHRq4ZaiV4yNWt/HBKgBj0OQQt9dRDp92PnkvVwy
        GOimB8g4IlFz0nHf0IBvL4xTL8Zl1sK+Wvg==
X-ME-Sender: <xms:sEA1ZIZW035zfxWhjOO0i5MKThViJKghRZ8Ymv8HeRaAVMrHJgbFog>
    <xme:sEA1ZDZXNh_cM9GcHBVj7n-VlbUhpNfchwZHc2HotQrAQQBVJPH_w61rQXJOd6GQ9
    TSj66eZPooHLYrZKkw>
X-ME-Received: <xmr:sEA1ZC_-pU3HEaj0WnZuAG-94ZAXxwiv0HXS1vbAkS5sjh0n08GpCuUG45dZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevfedtffekjeefff
    ejtdduvddujeefvdejleeutdeufefffedtueevvdduveejffenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:sEA1ZCrgQowqWvfFyjG7anV8B5sFLuA8i__wE_o6uocI9WtlkuQ1DQ>
    <xmx:sEA1ZDry2hzpiFB2Y1rvxdxuKy7eiJ2sPLa0svqLX0Lp9F7gdAmvyA>
    <xmx:sEA1ZATbNxluZZG04eOWVDhZukA4Uf_UlMvzlVARB87BjfZfa51iRA>
    <xmx:sEA1ZCUdd_q-VRcAN87A52dpaCh5ip3wCZdfHrebNkRSh1yvaae6vg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:47 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 8/8] MIPS: Implement microMIPS MT ASE helpers
Date:   Tue, 11 Apr 2023 12:12:25 +0100
Message-Id: <20230411111225.55725-9-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
References: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement various microMIPS MT ASE helpers accroading to:

MIPS® Architecture for Programmers
Volume IV-f: The MIPS® MT Module for the microMIPS32™ Architecture

Fixes build error:
{standard input}:2616: Error: branch to a symbol in another ISA mode

Boot tested on M5150 with microMIPS enabled on M5150.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/asmmacro.h   |  22 ++-
 arch/mips/include/asm/mipsmtregs.h | 256 +++++++++++++++++------------
 arch/mips/include/asm/mipsregs.h   |   9 +
 3 files changed, 177 insertions(+), 110 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index de9688911cae..e56bdda483f5 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -217,27 +217,33 @@
  * Temporary until all gas have MT ASE support
  */
 	.macro	DMT	reg=0
-	.word	0x41600bc1 | (\reg << 16)
+	insn_if_mips	0x41600bc1 | (\reg << 16)
+	insn32_if_mm    0x0000057C | (\reg << 21)
 	.endm
 
 	.macro	EMT	reg=0
-	.word	0x41600be1 | (\reg << 16)
+	insn_if_mips	0x41600be1 | (\reg << 16)
+	insn32_if_mm    0x0000257C | (\reg << 21)
 	.endm
 
 	.macro	DVPE	reg=0
-	.word	0x41600001 | (\reg << 16)
+	insn_if_mips	0x41600001 | (\reg << 16)
+	insn32_if_mm    0x0000157C | (\reg << 21)
 	.endm
 
 	.macro	EVPE	reg=0
-	.word	0x41600021 | (\reg << 16)
+	insn_if_mips	0x41600021 | (\reg << 16)
+	insn32_if_mm    0x0000357C | (\reg << 21)
 	.endm
 
-	.macro	MFTR	rt=0, rd=0, u=0, sel=0
-	 .word	0x41000000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
+	.macro	MFTR	rs=0, rt=0, u=0, sel=0
+	insn_if_mips	0x41000000 | (\rt << 16) | (\rs << 11) | (\u << 5) | (\sel)
+	insn32_if_mm	0x0000000E | (\rt << 21) | (\rs << 16) | (\u << 10) | (\sel << 4)
 	.endm
 
-	.macro	MTTR	rt=0, rd=0, u=0, sel=0
-	 .word	0x41800000 | (\rt << 16) | (\rd << 11) | (\u << 5) | (\sel)
+	.macro	MTTR	rt=0, rs=0, u=0, sel=0
+	insn_if_mips	0x41800000 | (\rt << 16) | (\rs << 11) | (\u << 5) | (\sel)
+	insn32_if_mm	0x00000006 | (\rt << 21) | (\rs << 16) | (\u << 10) | (\sel << 4)
 	.endm
 
 #ifdef CONFIG_AS_HAS_MSA
diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index b6dea86b1b82..30e86861c206 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -189,19 +189,24 @@ static inline unsigned core_nvpes(void)
 	return ((conf0 & MVPCONF0_PVPE) >> MVPCONF0_PVPE_SHIFT) + 1;
 }
 
+#define _ASM_SET_DVPE							\
+	_ASM_MACRO_1R(dvpe, rt,						\
+			_ASM_INSN_IF_MIPS(0x41600001 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000157C | __rt << 21))
+#define _ASM_UNSET_DVPE ".purgem dvpe\n\t"
+
 static inline unsigned int dvpe(void)
 {
 	int res = 0;
 
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	noat						\n"
-	"	.set	"MIPS_ISA_LEVEL"				\n"
-	"	.word	0x41610001		# dvpe $1		\n"
-	"	move	%0, $1						\n"
-	"	ehb							\n"
-	"	.set	pop						\n"
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_DVPE
+	"	dvpe	%0					\n"
+	"	ehb						\n"
+	_ASM_UNSET_DVPE
+	"	.set	pop					\n"
 	: "=r" (res));
 
 	instruction_hazard();
@@ -209,16 +214,22 @@ static inline unsigned int dvpe(void)
 	return res;
 }
 
+#define _ASM_SET_EVPE							\
+	_ASM_MACRO_1R(evpe, rt,					\
+			_ASM_INSN_IF_MIPS(0x41600021 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000357C | __rt << 21))
+#define _ASM_UNSET_EVPE ".purgem evpe\n\t"
+
 static inline void __raw_evpe(void)
 {
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	noat						\n"
-	"	.set	"MIPS_ISA_LEVEL"				\n"
-	"	.word	0x41600021		# evpe			\n"
-	"	ehb							\n"
-	"	.set	pop						\n");
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_EVPE
+	"	evpe    $0					\n"
+	"	ehb						\n"
+	_ASM_UNSET_EVPE
+	"	.set	pop					\n");
 }
 
 /* Enable virtual processor execution if previous suggested it should be.
@@ -232,18 +243,24 @@ static inline void evpe(int previous)
 		__raw_evpe();
 }
 
+#define _ASM_SET_DMT							\
+	_ASM_MACRO_1R(dmt, rt,						\
+			_ASM_INSN_IF_MIPS(0x41600bc1 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000057C | __rt << 21))
+#define _ASM_UNSET_DMT ".purgem dmt\n\t"
+
 static inline unsigned int dmt(void)
 {
 	int res;
 
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	"MIPS_ISA_LEVEL"				\n"
-	"	.set	noat						\n"
-	"	.word	0x41610BC1			# dmt $1	\n"
-	"	ehb							\n"
-	"	move	%0, $1						\n"
-	"	.set	pop						\n"
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_DMT
+	"	dmt	%0					\n"
+	"	ehb						\n"
+	_ASM_UNSET_DMT
+	"	.set	pop					\n"
 	: "=r" (res));
 
 	instruction_hazard();
@@ -251,14 +268,21 @@ static inline unsigned int dmt(void)
 	return res;
 }
 
+#define _ASM_SET_EMT							\
+	_ASM_MACRO_1R(emt, rt,						\
+			_ASM_INSN_IF_MIPS(0x41600be1 | __rt << 16)	\
+			_ASM_INSN32_IF_MM(0x0000257C | __rt << 21))
+#define _ASM_UNSET_EMT ".purgem emt\n\t"
+
 static inline void __raw_emt(void)
 {
 	__asm__ __volatile__(
-	"	.set	push						\n"
-	"	.set	noreorder					\n"
-	"	.set	"MIPS_ISA_LEVEL"				\n"
-	"	.word	0x41600be1			# emt		\n"
-	"	ehb							\n"
+	"	.set	push					\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
+	_ASM_SET_EMT
+	"	emt	$0					\n"
+	_ASM_UNSET_EMT
+	"	ehb						\n"
 	"	.set	pop");
 }
 
@@ -276,41 +300,55 @@ static inline void emt(int previous)
 static inline void ehb(void)
 {
 	__asm__ __volatile__(
-	"	.set	push					\n"
-	"	.set	"MIPS_ISA_LEVEL"			\n"
-	"	ehb						\n"
-	"	.set	pop					\n");
+	"	.set	push				\n"
+	"	.set	"MIPS_ISA_LEVEL"		\n"
+	"	ehb					\n"
+	"	.set	pop				\n");
 }
 
-#define mftc0(rt,sel)							\
+#define _ASM_SET_MFTC0							\
+	_ASM_MACRO_2R_1S(mftc0, rs, rt, sel,				\
+			_ASM_INSN_IF_MIPS(0x41000000 | __rt << 16 |	\
+				__rs << 11 | \\sel)			\
+			_ASM_INSN32_IF_MM(0x0000000E | __rt << 21 |	\
+				__rs << 16 | \\sel << 4))
+#define _ASM_UNSET_MFTC0 ".purgem mftc0\n\t"
+
+#define mftc0(rt, sel)							\
 ({									\
-	 unsigned long	__res;						\
+	unsigned long	__res;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	"MIPS_ISA_LEVEL"			\n"	\
-	"	.set	noat					\n"	\
-	"	# mftc0 $1, $" #rt ", " #sel "			\n"	\
-	"	.word	0x41000800 | (" #rt " << 16) | " #sel " \n"	\
-	"	move	%0, $1					\n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MFTC0							\
+	"	mftc0	$1, " #rt ", " #sel "		\n"	\
+	_ASM_UNSET_MFTC0						\
+	"	.set	pop				\n"	\
 	: "=r" (__res));						\
 									\
 	__res;								\
 })
 
+#define _ASM_SET_MFTGPR							\
+	_ASM_MACRO_2R(mftgpr, rs, rt,					\
+			_ASM_INSN_IF_MIPS(0x41000020 | __rt << 16 |	\
+				__rs << 11)				\
+			_ASM_INSN32_IF_MM(0x0000040E | __rt << 21 |	\
+				__rs << 16))
+#define _ASM_UNSET_MFTGPR ".purgem mftgpr\n\t"
+
 #define mftgpr(rt)							\
 ({									\
 	unsigned long __res;						\
 									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	noat					\n"	\
-	"	.set	"MIPS_ISA_LEVEL"			\n"	\
-	"	# mftgpr $1," #rt "				\n"	\
-	"	.word	0x41000820 | (" #rt " << 16)		\n"	\
-	"	move	%0, $1					\n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MFTGPR							\
+	"	mftgpr	%0," #rt "			\n"	\
+	_ASM_UNSET_MFTGPR						\
+	"	.set	pop				\n"	\
 	: "=r" (__res));						\
 									\
 	__res;								\
@@ -321,35 +359,49 @@ static inline void ehb(void)
 	unsigned long __res;						\
 									\
 	__asm__ __volatile__(						\
-	"	mftr	%0, " #rt ", " #u ", " #sel "		\n"	\
+	"	mftr	%0, " #rt ", " #u ", " #sel "	\n"	\
 	: "=r" (__res));						\
 									\
 	__res;								\
 })
 
-#define mttgpr(rd,v)							\
+#define _ASM_SET_MTTGPR							\
+	_ASM_MACRO_2R(mttgpr, rt, rs,					\
+			_ASM_INSN_IF_MIPS(0x41800020 | __rt << 16 |	\
+				__rs << 11)				\
+			_ASM_INSN32_IF_MM(0x00000406 | __rt << 21 |	\
+				__rs << 16))
+#define _ASM_UNSET_MTTGPR ".purgem mttgpr\n\t"
+
+#define mttgpr(rs, v)							\
 do {									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	"MIPS_ISA_LEVEL"			\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mttgpr $1, " #rd "				\n"	\
-	"	.word	0x41810020 | (" #rd " << 11)		\n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MTTGPR							\
+	"	mttgpr	%0, " #rs "			\n"	\
+	_ASM_UNSET_MTTGPR						\
+	"	.set	pop				\n"	\
 	: : "r" (v));							\
 } while (0)
 
-#define mttc0(rd, sel, v)							\
+#define _ASM_SET_MTTC0							\
+	_ASM_MACRO_2R_1S(mttc0, rt, rs, sel,				\
+			_ASM_INSN_IF_MIPS(0x41800000 | __rt << 16 |	\
+				__rs << 11 | \\sel)			\
+			_ASM_INSN32_IF_MM(0x0000040E | __rt << 21 |	\
+				__rs << 16 | \\sel << 4))
+#define _ASM_UNSET_MTTC0 ".purgem mttc0\n\t"
+
+#define mttc0(rs, sel, v)							\
 ({									\
 	__asm__ __volatile__(						\
-	"	.set	push					\n"	\
-	"	.set	"MIPS_ISA_LEVEL"			\n"	\
-	"	.set	noat					\n"	\
-	"	move	$1, %0					\n"	\
-	"	# mttc0 %0," #rd ", " #sel "			\n"	\
-	"	.word	0x41810000 | (" #rd " << 11) | " #sel " \n"	\
-	"	.set	pop					\n"	\
+	"	.set	push				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"		\n"	\
+	_ASM_SET_MTTC0							\
+	"	mttc0	%0," #rs ", " #sel "		\n"	\
+	_ASM_UNSET_MTTC0						\
+	"	.set	pop				\n"	\
 	:								\
 	: "r" (v));							\
 })
@@ -371,49 +423,49 @@ do {									\
 
 
 /* you *must* set the target tc (settc) before trying to use these */
-#define read_vpe_c0_vpecontrol()	mftc0(1, 1)
-#define write_vpe_c0_vpecontrol(val)	mttc0(1, 1, val)
-#define read_vpe_c0_vpeconf0()		mftc0(1, 2)
-#define write_vpe_c0_vpeconf0(val)	mttc0(1, 2, val)
-#define read_vpe_c0_vpeconf1()		mftc0(1, 3)
-#define write_vpe_c0_vpeconf1(val)	mttc0(1, 3, val)
-#define read_vpe_c0_count()		mftc0(9, 0)
-#define write_vpe_c0_count(val)		mttc0(9, 0, val)
-#define read_vpe_c0_status()		mftc0(12, 0)
-#define write_vpe_c0_status(val)	mttc0(12, 0, val)
-#define read_vpe_c0_cause()		mftc0(13, 0)
-#define write_vpe_c0_cause(val)		mttc0(13, 0, val)
-#define read_vpe_c0_config()		mftc0(16, 0)
-#define write_vpe_c0_config(val)	mttc0(16, 0, val)
-#define read_vpe_c0_config1()		mftc0(16, 1)
-#define write_vpe_c0_config1(val)	mttc0(16, 1, val)
-#define read_vpe_c0_config7()		mftc0(16, 7)
-#define write_vpe_c0_config7(val)	mttc0(16, 7, val)
-#define read_vpe_c0_ebase()		mftc0(15, 1)
-#define write_vpe_c0_ebase(val)		mttc0(15, 1, val)
-#define write_vpe_c0_compare(val)	mttc0(11, 0, val)
-#define read_vpe_c0_badvaddr()		mftc0(8, 0)
-#define read_vpe_c0_epc()		mftc0(14, 0)
-#define write_vpe_c0_epc(val)		mttc0(14, 0, val)
+#define read_vpe_c0_vpecontrol()	mftc0($1, 1)
+#define write_vpe_c0_vpecontrol(val)	mttc0($1, 1, val)
+#define read_vpe_c0_vpeconf0()		mftc0($1, 2)
+#define write_vpe_c0_vpeconf0(val)	mttc0($1, 2, val)
+#define read_vpe_c0_vpeconf1()		mftc0($1, 3)
+#define write_vpe_c0_vpeconf1(val)	mttc0($1, 3, val)
+#define read_vpe_c0_count()		mftc0($9, 0)
+#define write_vpe_c0_count(val)		mttc0($9, 0, val)
+#define read_vpe_c0_status()		mftc0($12, 0)
+#define write_vpe_c0_status(val)	mttc0($12, 0, val)
+#define read_vpe_c0_cause()		mftc0($13, 0)
+#define write_vpe_c0_cause(val)		mttc0($13, 0, val)
+#define read_vpe_c0_config()		mftc0($16, 0)
+#define write_vpe_c0_config(val)	mttc0($16, 0, val)
+#define read_vpe_c0_config1()		mftc0($16, 1)
+#define write_vpe_c0_config1(val)	mttc0($16, 1, val)
+#define read_vpe_c0_config7()		mftc0($16, 7)
+#define write_vpe_c0_config7(val)	mttc0($16, 7, val)
+#define read_vpe_c0_ebase()		mftc0($15, 1)
+#define write_vpe_c0_ebase(val)		mttc0($15, 1, val)
+#define write_vpe_c0_compare(val)	mttc0($11, 0, val)
+#define read_vpe_c0_badvaddr()		mftc0($8, 0)
+#define read_vpe_c0_epc()		mftc0($14, 0)
+#define write_vpe_c0_epc(val)		mttc0($14, 0, val)
 
 
 /* TC */
-#define read_tc_c0_tcstatus()		mftc0(2, 1)
-#define write_tc_c0_tcstatus(val)	mttc0(2, 1, val)
-#define read_tc_c0_tcbind()		mftc0(2, 2)
-#define write_tc_c0_tcbind(val)		mttc0(2, 2, val)
-#define read_tc_c0_tcrestart()		mftc0(2, 3)
-#define write_tc_c0_tcrestart(val)	mttc0(2, 3, val)
-#define read_tc_c0_tchalt()		mftc0(2, 4)
-#define write_tc_c0_tchalt(val)		mttc0(2, 4, val)
-#define read_tc_c0_tccontext()		mftc0(2, 5)
-#define write_tc_c0_tccontext(val)	mttc0(2, 5, val)
+#define read_tc_c0_tcstatus()		mftc0($2, 1)
+#define write_tc_c0_tcstatus(val)	mttc0($2, 1, val)
+#define read_tc_c0_tcbind()		mftc0($2, 2)
+#define write_tc_c0_tcbind(val)		mttc0($2, 2, val)
+#define read_tc_c0_tcrestart()		mftc0($2, 3)
+#define write_tc_c0_tcrestart(val)	mttc0($2, 3, val)
+#define read_tc_c0_tchalt()		mftc0($2, 4)
+#define write_tc_c0_tchalt(val)		mttc0($2, 4, val)
+#define read_tc_c0_tccontext()		mftc0($2, 5)
+#define write_tc_c0_tccontext(val)	mttc0($2, 5, val)
 
 /* GPR */
-#define read_tc_gpr_sp()		mftgpr(29)
-#define write_tc_gpr_sp(val)		mttgpr(29, val)
-#define read_tc_gpr_gp()		mftgpr(28)
-#define write_tc_gpr_gp(val)		mttgpr(28, val)
+#define read_tc_gpr_sp()		mftgpr($29)
+#define write_tc_gpr_sp(val)		mttgpr($29, val)
+#define read_tc_gpr_gp()		mftgpr($28)
+#define write_tc_gpr_gp(val)		mttgpr($28, val)
 
 __BUILD_SET_C0(mvpcontrol)
 
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 7d2c1c90fa10..b30d5e1672c4 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1310,6 +1310,15 @@ static inline int mm_insn_16bit(u16 insn)
  * the ENC encodings.
  */
 
+/* Instructions with 1 register operand */
+#define _ASM_MACRO_1R(OP, R1, ENC)				\
+		".macro	" #OP " " #R1 "\n\t"			\
+		_ASM_SET_PARSE_R					\
+		"parse_r __" #R1 ", \\" #R1 "\n\t"			\
+		ENC							\
+		_ASM_UNSET_PARSE_R					\
+		".endm\n\t"
+
 /* Instructions with 1 register operand & 1 immediate operand */
 #define _ASM_MACRO_1R1I(OP, R1, I2, ENC)				\
 		".macro	" #OP " " #R1 ", " #I2 "\n\t"			\
-- 
2.39.2 (Apple Git-143)

