Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A5627459
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiKNB5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiKNB5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:57:20 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85784625C;
        Sun, 13 Nov 2022 17:57:19 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ED9EF5C00F1;
        Sun, 13 Nov 2022 20:57:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 13 Nov 2022 20:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668391038; x=
        1668477438; bh=kb2KL/xNBPAUpKNppz0Hv1Qzx9PzkMbgYoTAwQW8XmE=; b=4
        /yjO5Pz01qhLDkb2WcxXwFqBymiocxmmcwpbyQs+moVPID/d1NdQM/ryeXfvkdk+
        LiVlxHfPaOOjpvObgVM4Gx81r6eWytP9qQf2FWa1HdOLT0zcYe9/6YLVOnbSpfNP
        ySeJKDGn5DfJsD/WnOjVPG4f5e6a3eOv1QZSgrKWNm8y7/BomXEVBGcfOlNwxTTh
        AouKpSfitBAqQ7vIaUt3e3SqTglcynVCn9PMBQYKRTHuOtX92MnF5ulkwxpvHF8q
        pCQNMAKEtdlLpQKCb9P/kkhIbmidm8xiRZ+hwG8zMaO08L7yVgY/0uMiB6jvimdx
        0KEp3tPpqjWNhtUdh7eZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668391038; x=1668477438; bh=kb2KL/xNBPAUp
        KNppz0Hv1Qzx9PzkMbgYoTAwQW8XmE=; b=D5f28vnsPucZz73azymHtj6ze61pk
        DniUQcK0WQnwq4jS4guz6AKB7x7wq2qDoauXzRYSeSKT848s1kPPjw4J8c6xrDLP
        evygnUE6+xBw+u1tlgKfckUuDfk3hKqz8f+rktlVnl3t8mHPsmCHRyFlA9LdUdid
        czvW9cVcIdZcLy05LLOsl3H3jAZfLH14M+5ktyTfve/S8BOc0otHp323eosQsICB
        IUBUoKtsk1RAoFbDlkRhbMX07KHg+wmhz9ZAjLyjuFlRk6CU6ae72JAJVSYbCg4C
        4MD62jyjOiOh8NEPyyDBPPj0oqIbp+6udd7JzgJzCjs3bZIj+Ux217p3A==
X-ME-Sender: <xms:fqBxYwZEnkDE3kCZgBKbmFkejnz1z9kiuHdPrwaZKagW8qgXn8OSuQ>
    <xme:fqBxY7Z2_uV85tSN8ndOCWL25irVJ-lyVsWNNvjCXGtU2OHSkLDatgFHV3KTVMSXD
    agyEk9Ffs6Jvsthfw>
X-ME-Received: <xmr:fqBxY69nKMdVSHJrG7UBxjlXJBIAp8CKEdCx0QdxQueYZ3ls7Svvj00SD7vmKoMkQnCOdaJrGcFTDWh4Mvfr6LbekYOeGttnO3Vyvon2doicIsK45ZQgA4xRC_rR-nmT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhhnhcu
    vfhhohhmshhonhcuoehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtg
    homhdrrghuqeenucggtffrrghtthgvrhhnpeejgfffffeijedtueejffekgeevieduvdeu
    keffjeeiueetkeffjeekveelieejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghi
    lhdrtghomhdrrghu
X-ME-Proxy: <xmx:fqBxY6rLkrWCoLzpNPqeiB6E0xgJeu7crkypptM7BqHRuwOSDKuUfw>
    <xmx:fqBxY7o3d5tQuFf_opebYlQ2mfkVL_21XZpTWhQuMBpNVKoawTS7AA>
    <xmx:fqBxY4RyMnqoNvWL1OFeGLKBLXIvXtREcDqXbRfzzGcpIbXA54TR1w>
    <xmx:fqBxY8CMWr34R0D8dMK1i9JqR4W8oI1tZJbPj-Vhz8mIlv7sSH8dCQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 20:57:16 -0500 (EST)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [PATCH 1/3] mips: ralink: mt7621: define MT7621_SYSC_BASE with __iomem
Date:   Mon, 14 Nov 2022 11:56:56 +1000
Message-Id: <20221114015658.2873120-2-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
References: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 6bbf082dd149..79d5bb0e06d6 100644
--- a/arch/mips/include/asm/mach-ralink/mt7621.h
+++ b/arch/mips/include/asm/mach-ralink/mt7621.h
@@ -7,10 +7,12 @@
 #ifndef _MT7621_REGS_H_
 #define _MT7621_REGS_H_
 
+#define IOMEM(x)			((void __iomem *)(KSEG1ADDR(x)))
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

