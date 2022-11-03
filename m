Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14096175FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiKCFGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCFGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:06:00 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B183C1836A;
        Wed,  2 Nov 2022 22:05:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B57BC32003F4;
        Thu,  3 Nov 2022 01:05:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 03 Nov 2022 01:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667451958; x=
        1667538358; bh=zzJUfOgl2bkahyM/7t01UCaL5O9zzC7X41N1MA9mOPI=; b=C
        3XSspZi5Et72oYvpiry1moAwxbS4KGIlqPJM7J4O55HSexu/1UUPLA4ve6b4qN2O
        oe7XF6QY0FfS+pgf4qdZjZk6vnqBHvALx2XOLZAVlIqwz72gtL8HLhKUOyt6eNBS
        qhzBVy3A61LoEKHuBobY44IbUE2QvJ4cWj8X9kTXNSD6cmrR4vnJOMzJCbUJktTd
        O/ss+vKoZTN4fjtbWckK54BGp5qvzi42liBgBShBzX1GE4qPKZcRlgC9+TesM986
        gB0Xb8F11k4IKpkSoKnKoR2Eb8X/M4BFejoRMcmUoxd469PSgVCxKsjveWeJtQ0s
        nvN5jQZYgqPNkeYF2jqcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667451958; x=1667538358; bh=zzJUfOgl2bkah
        yM/7t01UCaL5O9zzC7X41N1MA9mOPI=; b=uKZ1hCZdVblDdcltPEPLT7i7Pls2D
        ACJXxWX6QD7bBMj35/evchM6MoXVhW/cQf835CuYjZyxEg2IoZP/gKgf0RJomlNv
        WIc2AixS1SAnl532+izZ3Tangr21G94oS1fJhp23q6GG0uBnUCAuvGsoHRnijWmH
        MwYmqV5e3yC+EbjJ62GiwH0P84w2rx2+Yk8lMdHdKNAyPUvin42AshuJTApZtAnp
        fZ3+JWUFpQjPAUlj06DOm6gig7tBP0Iv6by6txZ1XFToH4PHYxdy/kt47yeg1U9+
        twHoXWJcw1Rrh6UiD2wpxcVcmCjkW8GVHFNpLCLb19amhHnrJBQwI/2sQ==
X-ME-Sender: <xms:NUxjYwRzO5nmqEbhegvVid7DPqTJ-_Z6wh6s3-qfVbIYtnecGtUUfg>
    <xme:NUxjY9ysS2_z2vXCwV6TlrXWeWkrsfXYZJEFAddSzDmEBJa7ic2FckT7x0MBfMLig
    kbtLNdyum-5FAYNnw>
X-ME-Received: <xmr:NUxjY92Ztnoilipl3RywC8JZIRKXheLG3V1Bgb2GqycUnXP9oe0BNTHEHjuDJjLvqwSgxMSMSgPIcweyLz5KesQ9Zm5T6NNhP7Lcsm8E81ikg9ELkMj1gCMQn2_xqd8_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudekgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcu
    vfhhohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtg
    homhdrrghuqeenucggtffrrghtthgvrhhnpeejgfffffeijedtueejffekgeevieduvdeu
    keffjeeiueetkeffjeekveelieejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghi
    lhdrtghomhdrrghu
X-ME-Proxy: <xmx:NkxjY0B9mxAAxYeykezT4sdaqIaaDxUjEqoqK7GlDG7olVpljy5cLw>
    <xmx:NkxjY5iY__dju6L0luZzhKuPr_wfHnt2l2359MW7dMGjuMIpWNmu0Q>
    <xmx:NkxjYwol8zdnCIeF7GJcxHUS4yRdMdKA9G12rjNoir3WssuES8YZgw>
    <xmx:NkxjY3ZqHuOmqRFBDHIyRPGAh2c94SUiAtkFhwrvtpf5VlC9h4lMIQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Nov 2022 01:05:55 -0400 (EDT)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        John Crispin <john@phrozen.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [RFC PATCH 1/3] mips: ralink: mt7621: define MT7621_SYSC_BASE with __iomem
Date:   Thu,  3 Nov 2022 15:05:36 +1000
Message-Id: <20221103050538.1930758-2-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
References: <20221103050538.1930758-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that MT7621_SYSC_BASE can be used later in multiple functions without
needing to repeat this __iomem declaration each time

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
---
 arch/mips/include/asm/mach-ralink/mt7621.h | 4 +++-
 arch/mips/ralink/mt7621.c                  | 7 +++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/mt7621.h b/arch/mips/include/asm/mach-ralink/mt7621.h
index 6bbf082dd149..905c5b3ed2bd 100644
--- a/arch/mips/include/asm/mach-ralink/mt7621.h
+++ b/arch/mips/include/asm/mach-ralink/mt7621.h
@@ -7,10 +7,12 @@
 #ifndef _MT7621_REGS_H_
 #define _MT7621_REGS_H_
 
+#define IOMEM(x)			((void __iomem *)(KSEG1ADDR(CPHYSADDR(x))))
+
 #define MT7621_PALMBUS_BASE		0x1C000000
 #define MT7621_PALMBUS_SIZE		0x03FFFFFF
 
-#define MT7621_SYSC_BASE		0x1E000000
+#define MT7621_SYSC_BASE		IOMEM(0x1E000000)
 
 #define SYSC_REG_CHIP_NAME0		0x00
 #define SYSC_REG_CHIP_NAME1		0x04
diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index fb0565bc34fd..17dbf28897e0 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -126,7 +126,6 @@ static void soc_dev_init(struct ralink_soc_info *soc_info, u32 rev)
 
 void __init prom_soc_init(struct ralink_soc_info *soc_info)
 {
-	void __iomem *sysc = (void __iomem *) KSEG1ADDR(MT7621_SYSC_BASE);
 	unsigned char *name = NULL;
 	u32 n0;
 	u32 n1;
@@ -154,8 +153,8 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 		__sync();
 	}
 
-	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
+	n0 = __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+	n1 = __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_NAME1);
 
 	if (n0 == MT7621_CHIP_NAME0 && n1 == MT7621_CHIP_NAME1) {
 		name = "MT7621";
@@ -164,7 +163,7 @@ void __init prom_soc_init(struct ralink_soc_info *soc_info)
 		panic("mt7621: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
 	}
 	ralink_soc = MT762X_SOC_MT7621AT;
-	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
+	rev = __raw_readl(MT7621_SYSC_BASE + SYSC_REG_CHIP_REV);
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
 		"MediaTek %s ver:%u eco:%u",
-- 
2.37.2

