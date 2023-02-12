Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F26693595
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 03:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBLCPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 21:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBLCPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 21:15:37 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D09166F6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 18:15:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BB6A45C00B3;
        Sat, 11 Feb 2023 21:15:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 11 Feb 2023 21:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676168133; x=1676254533; bh=Uq
        5aQpvzKMkJKSQwmWMMR9mZ/TQ6KPX7R/4xIPuGG1g=; b=OFVr68CiMd+J4VCai1
        FUJlZMLvrSrQMrEoDSPj/O5Vqvmp0ldboTq7dICCCWsKLeaghYu1pFCMfnPqTv4N
        Mhg80hDab4lk0vBu0ud9noGiTLDdRU+HlB1DIjsf4QuYhes2FkqcUiS948G2SzTo
        YcS7nyOUMzfAyGyzFEE3Xih5OyOO8etCwBEUlxRfq2d/4XXKYxuOQDEfg9/6fQcZ
        m/DGnoKj4D8+xC5ppd7en/8fk/aC2hoe7nND8ErQGd5c5FyyIDB0Jc3sk7LwlEhe
        a1hwy5e63fdnwRaSs8rEGBzxcTguG+OZaJeWmMOnrr/6T38ediDTRt57LMGYhQCZ
        WepA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676168133; x=1676254533; bh=Uq5aQpvzKMkJK
        SQwmWMMR9mZ/TQ6KPX7R/4xIPuGG1g=; b=RB/lFibS3OCcZ6i4DMUJooHt3CEBF
        bIXWeVju3bn82NDQn/wx8iWrGt3NiK1koybOH/w9FciB49nnnSOhlu+DKrn4s4CD
        Kp0Dntv7tu/wfHE/pTnodFEaSysdXaxVGUK9Dh9S/tmhPJ3f1IU0veekIQ2rTfsy
        08Vps085+0+N/bJd+hElaatAIr5f7B97Tt0/ZKMudn/XdmI5flBcXXnh1+Jtrdvh
        djm7T7GcI+LiWQ7kq2C9lVSniGEwnZvMILtZHrEmYJIDU+nQOiTO4Kmy5d+j5p+x
        LmUbawoNdag8A5nqWpciZMF213N3BNWmtz34PcChPi3nP14996Iq4as1Q==
X-ME-Sender: <xms:xUvoY4ICKyqmMvwVsxxA3oZ4b8rir3Sv1rNUfHQl_gHZQ2sTFz6vjw>
    <xme:xUvoY4L5Xuxvx9F9sb7yZk44ML9FsJPeoxNRz0bu0yDwlNJAohP4WfkAtZef29iiT
    rOTq0F-dr3Ezm8Saw>
X-ME-Received: <xmr:xUvoY4tg069NsDaqKpiATaWfckzKGwY5tldR8T6Fjb0dn2afWTube6uJ1P-5SvXFSK8KhnLZBzi3qfL5YNdwUiwl6WOFmGpF5cGk-RDT8-O8sYB2N5vcj-rgeZXJjv6F0plNVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheplefgffdthfffvdeuhfdugfevlefggeegffdvueekkeevieehtdei
    heegffelgffgnecuffhomhgrihhnpehsthhrtghmphdrshgspdhsthhrlhgvnhdrshgspd
    hsthhrnhgtmhhprdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:xUvoY1ZpxJRtSeuTir8JOmMU9eD08rJ3nT3TluVymMqCSt-D18xhvg>
    <xmx:xUvoY_bhz7nvHJiDfiWOjfxfa8drjdYL-A-VJjVop-0Xk1mYP5w3Tg>
    <xmx:xUvoYxDWNAbF9NBdGO-8a3A0Z92o5EH1xmMJpL2fFdUw-9j0w_-dDw>
    <xmx:xUvoY8TdagE_KNaHL57ETSwLdUAZl0zlMv2o94b4TKqEAfw-3Ot2PA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Feb 2023 21:15:32 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: Fix Zbb alternative IDs
Date:   Sat, 11 Feb 2023 20:15:33 -0600
Message-Id: <20230212021534.59121-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230212021534.59121-1-samuel@sholland.org>
References: <20230212021534.59121-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4bf8860760d9 ("riscv: cpufeature: extend
riscv_cpufeature_patch_func to all ISA extensions") switched ISA
extension alternatives to use the RISCV_ISA_EXT_* macros instead of
CPUFEATURE_*. This was mismerged when applied on top of the Zbb series,
so the Zbb alternatives referenced the wrong errata ID values.

Fixes: 9daca9a5b9ac ("Merge patch series "riscv: improve boot time isa extensions handling"")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/include/asm/errata_list.h | 5 -----
 arch/riscv/lib/strcmp.S              | 2 +-
 arch/riscv/lib/strlen.S              | 2 +-
 arch/riscv/lib/strncmp.S             | 2 +-
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index e158439029ce..274c6f889602 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -23,11 +23,6 @@
 #define	ERRATA_THEAD_NUMBER 3
 #endif
 
-#define	CPUFEATURE_SVPBMT 0
-#define	CPUFEATURE_ZICBOM 1
-#define	CPUFEATURE_ZBB 2
-#define	CPUFEATURE_NUMBER 3
-
 #ifdef __ASSEMBLY__
 
 #define ALT_INSN_FAULT(x)						\
diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 8148b6418f61..986ab23fe787 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -9,7 +9,7 @@
 /* int strcmp(const char *cs, const char *ct) */
 SYM_FUNC_START(strcmp)
 
-	ALTERNATIVE("nop", "j strcmp_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_ZBB)
+	ALTERNATIVE("nop", "j strcmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
 
 	/*
 	 * Returns
diff --git a/arch/riscv/lib/strlen.S b/arch/riscv/lib/strlen.S
index 0f9dbf93301a..8345ceeee3f6 100644
--- a/arch/riscv/lib/strlen.S
+++ b/arch/riscv/lib/strlen.S
@@ -9,7 +9,7 @@
 /* int strlen(const char *s) */
 SYM_FUNC_START(strlen)
 
-	ALTERNATIVE("nop", "j strlen_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_ZBB)
+	ALTERNATIVE("nop", "j strlen_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
 
 	/*
 	 * Returns
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index 7940ddab2d48..ee49595075be 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -9,7 +9,7 @@
 /* int strncmp(const char *cs, const char *ct, size_t count) */
 SYM_FUNC_START(strncmp)
 
-	ALTERNATIVE("nop", "j strncmp_zbb", 0, CPUFEATURE_ZBB, CONFIG_RISCV_ISA_ZBB)
+	ALTERNATIVE("nop", "j strncmp_zbb", 0, RISCV_ISA_EXT_ZBB, CONFIG_RISCV_ISA_ZBB)
 
 	/*
 	 * Returns
-- 
2.37.4

