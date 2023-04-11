Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28676DD90B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDKLMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDKLMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:43 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9559C5;
        Tue, 11 Apr 2023 04:12:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 451B75C00DD;
        Tue, 11 Apr 2023 07:12:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Apr 2023 07:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681211560; x=
        1681297960; bh=qWe8IvdF8H4iL7FM6XSpQ2R8Ky2u8F7Wy+R83JW6slo=; b=o
        UJUGk6+46HDIbkJbbjwhHtEcret3aHY6aiyNEud1a7ydtbd4cq+mFfsYR07p7qUf
        MDM1SzW4BKl7Dvoch1epkvIYVhozk+g3m8J/xFFO00h3eIICJAPzyOzQrh7t/M5P
        nTA5qk2432fJlOFO9B4LmYUuQl3K50s/LDSMTK3ic7u7WjFSibPsIpNyR/ucLmGM
        FPL4UE+MU8Cl2SdnixEM4ojKx3FnFG++qG43l1YhVpH7vBywgb3xjiebP35Asv70
        9Ytv9zsV0Wmtg2emBluk2JPOjmV6G770oSsBFxkUjuuveMksQemEqYL6e8QIiyGN
        ZTCR2HsBrO0ka5OUeFd0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681211560; x=
        1681297960; bh=qWe8IvdF8H4iL7FM6XSpQ2R8Ky2u8F7Wy+R83JW6slo=; b=B
        oH5Xooo5S8UqYUbXRs9vu5ZHFPhq+7P2zjSrggbqMYTP3NB5OJxTpVB8R6wcgNub
        64TokZPm+1+nbDvcxrOn6ukJwSA2JqvIw0jkRx1iilwREsDcVseRZ7vlVLhg8+S8
        mdDQsdPRLt79GygEfZ9D96H52ZwITq/xJmGEnEY2w2+ywBGQEfJDPHwWjBCtHAd6
        t7GHYz72PXteitAFRtKULrlcug3QHZHRVLFfn+0tL14oATVctvMOz9804FaOyRXE
        TnytjKwQwXKZgKVEfvvqBMkFX9HTBe0QPyAyhTE5I+tSWvnbhj0hQ5+oyGT13mIl
        u6cScY8BJV6QN6rUod1gQ==
X-ME-Sender: <xms:qEA1ZKnEzZDuvMW0M_NgnesCTg5CE2Wn4PFSYqm1hcC5y_du8URrUA>
    <xme:qEA1ZB2uDqi6MFWDM8qn7CFnYr92-6HBXuSQKeVtaJg3d2Q8Ubrwo0qHGYdypJvMp
    rualNCvCgeXS5gKJ2g>
X-ME-Received: <xmr:qEA1ZIqIyl4ny9rtDmGs3pqownnR9wHR_np0x1lYrzg-Wkmo7zlW0s3WTuOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfffhtdfhfeeuteefhf
    egkeefkeeitdfghedukeetkedtvdekieegleetkeeutddunecuffhomhgrihhnpehslhgv
    vghpvghrrdhssgdpvhgvtgdrshgspdhgvghnvgigrdhssgdpfhhpuhdrshgspdhprghrth
    hirghlrdhssgdptggvgidqohgtthdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homh
X-ME-Proxy: <xmx:qEA1ZOmKAyMKjSwnBirEqrPiBkTaBpAbGcACyoDhmpwIHB4iDYE1ww>
    <xmx:qEA1ZI0_X3Cl8EEj-Qu1FmO7xkdFbIOgilbofbghJxwXtYZ0rwkwQQ>
    <xmx:qEA1ZFtZicg-0aGaHF28WnLF2cgJ_3Ah-UWuocHPKtLkYCP2GQorOw>
    <xmx:qEA1ZFxvA30WQN67Itii6TjWjWW9nMh-E5tLFRYo-boPj9k165gx0g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:39 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/8] MIPS: Replace assembly isa level directives with macros
Date:   Tue, 11 Apr 2023 12:12:18 +0100
Message-Id: <20230411111225.55725-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
References: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are tons of .set assembly isa level directives in tree
to set current isa level to a higher level to enable some features.

However as nowadays MIPS is shuffling around opcodes, a single ISA
level setting may result wrong opcode in binary. We had MIPS_ISA_LEVEL
macros to determine most appropriate superset of ISA level, just do a
tree wide replacement to take advantage of those macros.

Mapping:
arch=r4000 -> MIPS_ISA_ARCH_LEVEL
{mips1, mips3, mips32r2, mips64r2} -> MIPS_ISA_LEVEL
{mips32r5, mips64r5} -> Special case for VZ, mips64r5 if target ISA
	is lower than R5, otherwise MIPS_ISA_LEVEL

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/alchemy/common/sleeper.S |  6 ++--
 arch/mips/include/asm/asmmacro.h   | 32 ++++++++++----------
 arch/mips/include/asm/futex.h      |  8 ++---
 arch/mips/include/asm/hazards.h    |  2 +-
 arch/mips/include/asm/io.h         |  4 +--
 arch/mips/include/asm/mipsmtregs.h | 18 ++++++------
 arch/mips/include/asm/mipsregs.h   | 47 +++++++++++++++++-------------
 arch/mips/include/asm/stackframe.h |  2 +-
 arch/mips/kernel/bmips_vec.S       |  4 +--
 arch/mips/kernel/csrc-r4k.c        |  2 +-
 arch/mips/kernel/genex.S           |  8 ++---
 arch/mips/kernel/idle.c            |  6 ++--
 arch/mips/kernel/r4k_fpu.S         |  4 +--
 arch/mips/kernel/syscall.c         |  2 +-
 arch/mips/lantiq/clk.c             |  2 +-
 arch/mips/lib/csum_partial.S       |  5 ++--
 arch/mips/mm/c-r4k.c               |  2 +-
 arch/mips/mm/cex-oct.S             |  2 +-
 arch/mips/mm/sc-ip22.c             |  6 ++--
 19 files changed, 85 insertions(+), 77 deletions(-)

diff --git a/arch/mips/alchemy/common/sleeper.S b/arch/mips/alchemy/common/sleeper.S
index 13586d224314..e19f20223aac 100644
--- a/arch/mips/alchemy/common/sleeper.S
+++ b/arch/mips/alchemy/common/sleeper.S
@@ -91,7 +91,7 @@ LEAF(alchemy_sleep_au1000)
 
 	/* cache following instructions, as memory gets put to sleep */
 	la	t0, 1f
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 	cache	0x14, 0(t0)
 	cache	0x14, 32(t0)
 	cache	0x14, 64(t0)
@@ -117,7 +117,7 @@ LEAF(alchemy_sleep_au1550)
 
 	/* cache following instructions, as memory gets put to sleep */
 	la	t0, 1f
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 	cache	0x14, 0(t0)
 	cache	0x14, 32(t0)
 	cache	0x14, 64(t0)
@@ -159,7 +159,7 @@ LEAF(alchemy_sleep_au1300)
 	la	t1, 4f
 	subu	t2, t1, t0
 
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 
 1:	cache	0x14, 0(t0)
 	subu	t2, t2, 32
diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 74c2dedc55b4..2491a6c68390 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -107,7 +107,7 @@
 
 	.macro	fpu_save_16odd thread
 	.set	push
-	.set	mips64r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	hardfloat
 	sdc1	$f1,  THREAD_FPR1(\thread)
@@ -166,7 +166,7 @@
 
 	.macro	fpu_restore_16odd thread
 	.set	push
-	.set	mips64r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	hardfloat
 	ldc1	$f1,  THREAD_FPR1(\thread)
@@ -242,7 +242,7 @@
 #ifdef CONFIG_AS_HAS_MSA
 	.macro	_cfcmsa	rd, cs
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	cfcmsa	\rd, $\cs
@@ -251,7 +251,7 @@
 
 	.macro	_ctcmsa	cd, rs
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	ctcmsa	$\cd, \rs
@@ -260,7 +260,7 @@
 
 	.macro	ld_b	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	ld.b	$w\wd, \off(\base)
@@ -269,7 +269,7 @@
 
 	.macro	ld_h	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	ld.h	$w\wd, \off(\base)
@@ -278,7 +278,7 @@
 
 	.macro	ld_w	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	ld.w	$w\wd, \off(\base)
@@ -287,7 +287,7 @@
 
 	.macro	ld_d	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	ld.d	$w\wd, \off(\base)
@@ -296,7 +296,7 @@
 
 	.macro	st_b	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	st.b	$w\wd, \off(\base)
@@ -305,7 +305,7 @@
 
 	.macro	st_h	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	st.h	$w\wd, \off(\base)
@@ -314,7 +314,7 @@
 
 	.macro	st_w	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	st.w	$w\wd, \off(\base)
@@ -323,7 +323,7 @@
 
 	.macro	st_d	wd, off, base
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	st.d	$w\wd, \off(\base)
@@ -332,7 +332,7 @@
 
 	.macro	copy_s_w	ws, n
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	copy_s.w $1, $w\ws[\n]
@@ -341,7 +341,7 @@
 
 	.macro	copy_s_d	ws, n
 	.set	push
-	.set	mips64r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	copy_s.d $1, $w\ws[\n]
@@ -350,7 +350,7 @@
 
 	.macro	insert_w	wd, n
 	.set	push
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	insert.w $w\wd[\n], $1
@@ -359,7 +359,7 @@
 
 	.macro	insert_d	wd, n
 	.set	push
-	.set	mips64r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	.set	msa
 	insert.d $w\wd[\n], $1
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index 05832eb240fa..2107e536a308 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -29,11 +29,11 @@
 		"	.set	push				\n"	\
 		"	.set	noat				\n"	\
 		"	.set	push				\n"	\
-		"	.set	arch=r4000			\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"1:	ll	%1, %4	# __futex_atomic_op	\n"	\
 		"	.set	pop				\n"	\
 		"	" insn	"				\n"	\
-		"	.set	arch=r4000			\n"	\
+		"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"	\
 		"2:	sc	$1, %2				\n"	\
 		"	beqzl	$1, 1b				\n"	\
 		__stringify(__WEAK_LLSC_MB) "			\n"	\
@@ -144,12 +144,12 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 		"	.set	push					\n"
 		"	.set	noat					\n"
 		"	.set	push					\n"
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"	\n"
 		"1:	ll	%1, %3					\n"
 		"	bne	%1, %z4, 3f				\n"
 		"	.set	pop					\n"
 		"	move	$1, %z5					\n"
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"	\n"
 		"2:	sc	$1, %2					\n"
 		"	beqzl	$1, 1b					\n"
 		__stringify(__WEAK_LLSC_MB) "				\n"
diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index cb16be93b048..ca18c66530e8 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -144,7 +144,7 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
-	"	.set	mips64r2				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	"	dla	%0, 1f					\n"	\
 	"	jr.hb	%0					\n"	\
 	"	.set	pop					\n"	\
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index cc28d207a061..e2ec7ec3dc20 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -243,7 +243,7 @@ static inline void pfx##write##bwlq(type val,				\
 			local_irq_save(__flags);			\
 		__asm__ __volatile__(					\
 			".set	push"		"\t\t# __writeq""\n\t"	\
-			".set	arch=r4000"			"\n\t"	\
+			".set	"MIPS_ISA_ARCH_LEVEL		"\n\t"	\
 			"dsll32 %L0, %L0, 0"			"\n\t"	\
 			"dsrl32 %L0, %L0, 0"			"\n\t"	\
 			"dsll32 %M0, %M0, 0"			"\n\t"	\
@@ -277,7 +277,7 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 			local_irq_save(__flags);			\
 		__asm__ __volatile__(					\
 			".set	push"		"\t\t# __readq" "\n\t"	\
-			".set	arch=r4000"			"\n\t"	\
+			".set	"MIPS_ISA_ARCH_LEVEL		"\n\t"	\
 			"ld	%L0, %1"			"\n\t"	\
 			"dsra32 %M0, %L0, 0"			"\n\t"	\
 			"sll	%L0, %L0, 0"			"\n\t"	\
diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index a8d67c2f4f7b..b6dea86b1b82 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -197,7 +197,7 @@ static inline unsigned int dvpe(void)
 	"	.set	push						\n"
 	"	.set	noreorder					\n"
 	"	.set	noat						\n"
-	"	.set	mips32r2					\n"
+	"	.set	"MIPS_ISA_LEVEL"				\n"
 	"	.word	0x41610001		# dvpe $1		\n"
 	"	move	%0, $1						\n"
 	"	ehb							\n"
@@ -215,7 +215,7 @@ static inline void __raw_evpe(void)
 	"	.set	push						\n"
 	"	.set	noreorder					\n"
 	"	.set	noat						\n"
-	"	.set	mips32r2					\n"
+	"	.set	"MIPS_ISA_LEVEL"				\n"
 	"	.word	0x41600021		# evpe			\n"
 	"	ehb							\n"
 	"	.set	pop						\n");
@@ -238,7 +238,7 @@ static inline unsigned int dmt(void)
 
 	__asm__ __volatile__(
 	"	.set	push						\n"
-	"	.set	mips32r2					\n"
+	"	.set	"MIPS_ISA_LEVEL"				\n"
 	"	.set	noat						\n"
 	"	.word	0x41610BC1			# dmt $1	\n"
 	"	ehb							\n"
@@ -256,7 +256,7 @@ static inline void __raw_emt(void)
 	__asm__ __volatile__(
 	"	.set	push						\n"
 	"	.set	noreorder					\n"
-	"	.set	mips32r2					\n"
+	"	.set	"MIPS_ISA_LEVEL"				\n"
 	"	.word	0x41600be1			# emt		\n"
 	"	ehb							\n"
 	"	.set	pop");
@@ -277,7 +277,7 @@ static inline void ehb(void)
 {
 	__asm__ __volatile__(
 	"	.set	push					\n"
-	"	.set	mips32r2				\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
 	"	ehb						\n"
 	"	.set	pop					\n");
 }
@@ -288,7 +288,7 @@ static inline void ehb(void)
 									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	"	.set	noat					\n"	\
 	"	# mftc0 $1, $" #rt ", " #sel "			\n"	\
 	"	.word	0x41000800 | (" #rt " << 16) | " #sel " \n"	\
@@ -306,7 +306,7 @@ static inline void ehb(void)
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noat					\n"	\
-	"	.set	mips32r2				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	"	# mftgpr $1," #rt "				\n"	\
 	"	.word	0x41000820 | (" #rt " << 16)		\n"	\
 	"	move	%0, $1					\n"	\
@@ -331,7 +331,7 @@ static inline void ehb(void)
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
 	"	# mttgpr $1, " #rd "				\n"	\
@@ -344,7 +344,7 @@ do {									\
 ({									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	"	.set	noat					\n"	\
 	"	move	$1, %0					\n"	\
 	"	# mttc0 %0," #rd ", " #sel "			\n"	\
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 8f0ebc399338..9d928b952abf 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1421,7 +1421,7 @@ do {								\
 	else								\
 		__asm__ vol(						\
 			".set\tpush\n\t"				\
-			".set\tmips32\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"mfc0\t%0, " #source ", " #sel "\n\t"		\
 			".set\tpop\n\t"					\
 			: "=r" (__res));				\
@@ -1435,14 +1435,14 @@ do {								\
 	else if (sel == 0)						\
 		__asm__ vol(						\
 			".set\tpush\n\t"				\
-			".set\tmips3\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dmfc0\t%0, " #source "\n\t"			\
 			".set\tpop"					\
 			: "=r" (__res));				\
 	else								\
 		__asm__ vol(						\
 			".set\tpush\n\t"				\
-			".set\tmips64\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dmfc0\t%0, " #source ", " #sel "\n\t"		\
 			".set\tpop"					\
 			: "=r" (__res));				\
@@ -1470,7 +1470,7 @@ do {									\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tpush\n\t"				\
-			".set\tmips32\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"mtc0\t%z0, " #register ", " #sel "\n\t"	\
 			".set\tpop"					\
 			: : "Jr" ((unsigned int)(value)));		\
@@ -1483,14 +1483,14 @@ do {									\
 	else if (sel == 0)						\
 		__asm__ __volatile__(					\
 			".set\tpush\n\t"				\
-			".set\tmips3\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dmtc0\t%z0, " #register "\n\t"			\
 			".set\tpop"					\
 			: : "Jr" (value));				\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tpush\n\t"				\
-			".set\tmips64\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dmtc0\t%z0, " #register ", " #sel "\n\t"	\
 			".set\tpop"					\
 			: : "Jr" (value));				\
@@ -1545,7 +1545,7 @@ do {									\
 	if (sel == 0)							\
 		__asm__ vol(						\
 			".set\tpush\n\t"				\
-			".set\tmips64\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dmfc0\t%L0, " #source "\n\t"			\
 			"dsra\t%M0, %L0, 32\n\t"			\
 			"sll\t%L0, %L0, 0\n\t"				\
@@ -1554,7 +1554,7 @@ do {									\
 	else								\
 		__asm__ vol(						\
 			".set\tpush\n\t"				\
-			".set\tmips64\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dmfc0\t%L0, " #source ", " #sel "\n\t"		\
 			"dsra\t%M0, %L0, 32\n\t"			\
 			"sll\t%L0, %L0, 0\n\t"				\
@@ -1582,7 +1582,7 @@ do {									\
 	else if (sel == 0)						\
 		__asm__ __volatile__(					\
 			".set\tpush\n\t"				\
-			".set\tmips64\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dsll\t%L0, %L0, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
 			"dsll\t%M0, %M0, 32\n\t"			\
@@ -1593,7 +1593,7 @@ do {									\
 	else								\
 		__asm__ __volatile__(					\
 			".set\tpush\n\t"				\
-			".set\tmips64\n\t"				\
+			".set\t "MIPS_ISA_LEVEL" \n\t"			\
 			"dsll\t%L0, %L0, 32\n\t"			\
 			"dsrl\t%L0, %L0, 32\n\t"			\
 			"dsll\t%M0, %M0, 32\n\t"			\
@@ -1628,7 +1628,7 @@ do {									\
 									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	_ASM_SET_MFHC0							\
 	"	mfhc0	%0, " #source ", %1			\n"	\
 	_ASM_UNSET_MFHC0						\
@@ -1642,7 +1642,7 @@ do {									\
 do {									\
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
-	"	.set	mips32r2				\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	_ASM_SET_MTHC0							\
 	"	mthc0	%z0, " #register ", %1			\n"	\
 	_ASM_UNSET_MTHC0						\
@@ -2040,7 +2040,14 @@ do {									\
  * Macros to access the guest system control coprocessor
  */
 
-#ifndef CONFIG_AS_HAS_VIRT
+#if MIPS_ISA_REV < 5
+/* VZ ASE should be able to work with Release 2 but LLVM thinks it needs R5 */
+#define MIPS_ISA_LEVEL_VIRT "mips64r5"
+#else
+#define MIPS_ISA_LEVEL_VIRT MIPS_ISA_LEVEL
+#endif
+
+#ifndef TOOLCHAIN_SUPPORTS_VIRT
 #define _ASM_SET_MFGC0							\
 	_ASM_MACRO_2R_1S(mfgc0, rt, rs, sel,				\
 			 _ASM_INSN_IF_MIPS(0x40600000 | __rt << 16 | __rs << 11 | \\sel)	\
@@ -2099,7 +2106,7 @@ do {									\
 ({ int __res;								\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips32r5\n\t"					\
+		".set\t " MIPS_ISA_LEVEL_VIRT " \n\t"			\
 		_ASM_SET_MFGC0						\
 		"mfgc0\t%0, " #source ", %1\n\t"			\
 		_ASM_UNSET_MFGC0					\
@@ -2113,7 +2120,7 @@ do {									\
 ({ unsigned long long __res;						\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips64r5\n\t"					\
+		".set\t " MIPS_ISA_LEVEL_VIRT " \n\t"			\
 		_ASM_SET_DMFGC0						\
 		"dmfgc0\t%0, " #source ", %1\n\t"			\
 		_ASM_UNSET_DMFGC0					\
@@ -2127,7 +2134,7 @@ do {									\
 do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips32r5\n\t"					\
+		".set\t " MIPS_ISA_LEVEL_VIRT " \n\t"			\
 		_ASM_SET_MTGC0						\
 		"mtgc0\t%z0, " #register ", %1\n\t"			\
 		_ASM_UNSET_MTGC0					\
@@ -2140,7 +2147,7 @@ do {									\
 do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
-		".set\tmips64r5\n\t"					\
+		".set\t " MIPS_ISA_LEVEL_VIRT " \n\t"			\
 		_ASM_SET_DMTGC0						\
 		"dmtgc0\t%z0, " #register ", %1\n\t"			\
 		_ASM_UNSET_DMTGC0					\
@@ -2376,7 +2383,7 @@ do {									\
 	"	.set	reorder					\n"	\
 	"	# gas fails to assemble cfc1 for some archs,	\n"	\
 	"	# like Octeon.					\n"	\
-	"	.set	mips1					\n"	\
+	"	.set	"MIPS_ISA_LEVEL"			\n"	\
 	"	.set hardfloat					\n"	\
 	"	cfc1	%0,"STR(source)"			\n"	\
 	"	.set	pop					\n"	\
@@ -2748,7 +2755,7 @@ static inline void tlb_read(void)
 	"	.set	push					\n"
 	"	.set	noreorder				\n"
 	"	.set	noat					\n"
-	"	.set	mips32r2				\n"
+	"	.set	"MIPS_ISA_LEVEL"			\n"
 	"	.word	0x41610001		# dvpe $1	\n"
 	"	move	%0, $1					\n"
 	"	ehb						\n"
@@ -2769,7 +2776,7 @@ static inline void tlb_read(void)
 		"	.set	push				\n"
 		"	.set	noreorder			\n"
 		"	.set	noat				\n"
-		"	.set	mips32r2			\n"
+		"	.set	"MIPS_ISA_LEVEL"		\n"
 		"	.word	0x41600021	# evpe		\n"
 		"	ehb					\n"
 		"	.set	pop				\n");
diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index a8705aef47e1..5b3d374f43e0 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -428,7 +428,7 @@
 		eretnc
 #else
 		.set	push
-		.set	arch=r4000
+		.set	MIPS_ISA_ARCH_LEVEL_RAW
 		eret
 		.set	pop
 #endif
diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 921a5fa55da6..f92a4b216da8 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -21,7 +21,7 @@
 #include <asm/bmips.h>
 
 	.macro	BARRIER
-	.set	mips32
+	.set	MIPS_ISA_LEVEL_RAW
 	_ssnop
 	_ssnop
 	_ssnop
@@ -123,7 +123,7 @@ NESTED(bmips_reset_nmi_vec, PT_SIZE, sp)
 	jr	k0
 
 	RESTORE_ALL
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 	eret
 
 #ifdef CONFIG_SMP
diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
index edc4afc080fa..906fa1a78f7f 100644
--- a/arch/mips/kernel/csrc-r4k.c
+++ b/arch/mips/kernel/csrc-r4k.c
@@ -35,7 +35,7 @@ static inline unsigned int rdhwr_count(void)
 
 	__asm__ __volatile__(
 	"	.set push\n"
-	"	.set mips32r2\n"
+	"	.set "MIPS_ISA_LEVEL"\n"
 	"	rdhwr	%0, $2\n"
 	"	.set pop\n"
 	: "=r" (count));
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index b6de8e88c1bd..2268304ae70e 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -50,7 +50,7 @@ NESTED(except_vec3_generic, 0, sp)
  */
 NESTED(except_vec3_r4000, 0, sp)
 	.set	push
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 	.set	noat
 	mfc0	k1, CP0_CAUSE
 	li	k0, 31<<2
@@ -403,7 +403,7 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
 ejtag_return:
 	back_to_back_c0_hazard
 	MFC0	k0, CP0_DESAVE
-	.set	mips32
+	.set	MIPS_ISA_LEVEL_RAW
 	deret
 	.set	pop
 	END(ejtag_debug_handler)
@@ -503,7 +503,7 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	 * We need to specify a selector to access the CP0.Diag1 (GSCause)
 	 * register. All GSExc-equipped processors have MIPS32.
 	 */
-	.set	mips32
+	.set	MIPS_ISA_LEVEL_RAW
 	mfc0	a1, CP0_DIAGNOSTIC1
 	.set	pop
 	TRACE_IRQS_ON
@@ -665,7 +665,7 @@ isrdhwr:
 	xori	k1, _THREAD_MASK
 	LONG_L	v1, TI_TP_VALUE(k1)
 	.set	push
-	.set	arch=r4000
+	.set	MIPS_ISA_ARCH_LEVEL_RAW
 	eret
 	.set	pop
 #endif
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 5abc8b7340f8..541470be5ec6 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -54,7 +54,7 @@ void __cpuidle r4k_wait_irqoff(void)
 	if (!need_resched())
 		__asm__(
 		"	.set	push		\n"
-		"	.set	arch=r4000	\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"\n"
 		"	wait			\n"
 		"	.set	pop		\n");
 }
@@ -68,7 +68,7 @@ static void __cpuidle rm7k_wait_irqoff(void)
 	if (!need_resched())
 		__asm__(
 		"	.set	push					\n"
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	.set	noat					\n"
 		"	mfc0	$1, $12					\n"
 		"	sync						\n"
@@ -89,7 +89,7 @@ static void __cpuidle au1k_wait(void)
 
 	__asm__(
 	"	.set	push			\n"
-	"	.set	arch=r4000		\n"
+	"	.set	"MIPS_ISA_ARCH_LEVEL"	\n"
 	"	cache	0x14, 0(%0)		\n"
 	"	cache	0x14, 32(%0)		\n"
 	"	sync				\n"
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 4e8c98517d9d..ec508ff455f2 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -107,7 +107,7 @@ LEAF(_save_fp_context)
 	.set	push
 	.set	hardfloat
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5)
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
@@ -175,7 +175,7 @@ LEAF(_restore_fp_context)
 	.set	push
 	.set	hardfloat
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5)
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	fp=64
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index ae93a607ddf7..7f2be5912997 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -109,7 +109,7 @@ static inline int mips_atomic_set(unsigned long addr, unsigned long new)
 	if (cpu_has_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {
 		__asm__ __volatile__ (
 		"	.set	push					\n"
-		"	.set	arch=r4000				\n"
+		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
 		"	li	%[err], 0				\n"
 		"1:	ll	%[old], (%[addr])			\n"
 		"	move	%[tmp], %[new]				\n"
diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
index 2d5a0bcb0cec..81e3329fc5de 100644
--- a/arch/mips/lantiq/clk.c
+++ b/arch/mips/lantiq/clk.c
@@ -177,7 +177,7 @@ static inline u32 get_counter_resolution(void)
 
 	__asm__ __volatile__(
 		".set	push\n"
-		".set	mips32r2\n"
+		".set	"MIPS_ISA_LEVEL"\n"
 		"rdhwr	%0, $3\n"
 		".set pop\n"
 		: "=&r" (res)
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 7767137c3e49..4b1060c3494b 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/compiler.h>
 #include <asm/export.h>
 #include <asm/regdef.h>
 
@@ -282,7 +283,7 @@ EXPORT_SYMBOL(csum_partial)
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5) || \
     defined(CONFIG_CPU_LOONGSON64)
 	.set	push
-	.set	arch=mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	wsbh	v1, sum
 	movn	sum, v1, t7
 	.set	pop
@@ -707,7 +708,7 @@ EXPORT_SYMBOL(csum_partial)
 #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5) || \
     defined(CONFIG_CPU_LOONGSON64)
 	.set	push
-	.set	arch=mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	wsbh	v1, sum
 	movn	sum, v1, odd
 	.set	pop
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 4b6554b48923..420440cc40b1 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -918,7 +918,7 @@ static inline void rm7k_erratum31(void)
 		__asm__ __volatile__ (
 			".set push\n\t"
 			".set noreorder\n\t"
-			".set mips3\n\t"
+			".set "MIPS_ISA_LEVEL"\n\t"
 			"cache\t%1, 0(%0)\n\t"
 			"cache\t%1, 0x1000(%0)\n\t"
 			"cache\t%1, 0x2000(%0)\n\t"
diff --git a/arch/mips/mm/cex-oct.S b/arch/mips/mm/cex-oct.S
index 9029092aa740..bb9f6b960786 100644
--- a/arch/mips/mm/cex-oct.S
+++ b/arch/mips/mm/cex-oct.S
@@ -19,7 +19,7 @@
 	LEAF(except_vec2_octeon)
 
 	.set	push
-	.set	mips64r2
+	.set	MIPS_ISA_LEVEL_RAW
 	.set	noreorder
 	.set	noat
 
diff --git a/arch/mips/mm/sc-ip22.c b/arch/mips/mm/sc-ip22.c
index d7238687d790..9a0c29946c2d 100644
--- a/arch/mips/mm/sc-ip22.c
+++ b/arch/mips/mm/sc-ip22.c
@@ -33,7 +33,7 @@ static inline void indy_sc_wipe(unsigned long first, unsigned long last)
 	__asm__ __volatile__(
 	"	.set	push			# indy_sc_wipe		\n"
 	"	.set	noreorder					\n"
-	"	.set	mips3						\n"
+	"	.set	"MIPS_ISA_LEVEL"				\n"
 	"	.set	noat						\n"
 	"	mfc0	%2, $12						\n"
 	"	li	$1, 0x80		# Go 64 bit		\n"
@@ -108,7 +108,7 @@ static void indy_sc_enable(void)
 	__asm__ __volatile__(
 	".set\tpush\n\t"
 	".set\tnoreorder\n\t"
-	".set\tmips3\n\t"
+	".set\t"MIPS_ISA_LEVEL"\n\t"
 	"mfc0\t%2, $12\n\t"
 	"nop; nop; nop; nop;\n\t"
 	"li\t%1, 0x80\n\t"
@@ -138,7 +138,7 @@ static void indy_sc_disable(void)
 	__asm__ __volatile__(
 	".set\tpush\n\t"
 	".set\tnoreorder\n\t"
-	".set\tmips3\n\t"
+	".set\t"MIPS_ISA_LEVEL"\n\t"
 	"li\t%0, 0x1\n\t"
 	"dsll\t%0, 31\n\t"
 	"lui\t%1, 0x9000\n\t"
-- 
2.39.2 (Apple Git-143)

