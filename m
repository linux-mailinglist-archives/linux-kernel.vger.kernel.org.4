Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58769F53F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjBVNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjBVNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:24:42 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E23A87E;
        Wed, 22 Feb 2023 05:24:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B8E05C0126;
        Wed, 22 Feb 2023 08:24:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 Feb 2023 08:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677072281; x=1677158681; bh=1f
        HXxGT/iesFaGy7SZWpw+qtrHiwycc/gJ0b/Z34gNU=; b=RFR1ljJO1HboBLMR/k
        T8Owsv6wy0nYzCS+jvf+ayOZgYpSJyumTyuTFBIvNfJ05GDoYVVUBRvXCjTr1xA5
        QiUcLfCWw3laN/2oHpj3N974lTNifZmyMzR32ms+P4wtnmL6M9Aincw/3E0RIE1L
        zOj1iJ05NI/n/tRp5RIc0e8KZ8UXWi+LA8ayae1FOMjrr0AE8zfpU35ErTFg1mDk
        o2TljOTaTne87baKSZ02XMky1gnOZbyvpHykcdfUCDjm+Up9Ybg3KyMCDnBUZcct
        wMfX/kxlq/y4K13H2mT7s/ecaErC0Ra/QfNIx0NLtkyJcclBUE7OOE+mB/xBqF22
        FJ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677072281; x=1677158681; bh=1fHXxGT/iesFa
        Gy7SZWpw+qtrHiwycc/gJ0b/Z34gNU=; b=hUOO9KVAuogMaAaQdxoQ3PeUBZpWH
        YKWAcTVQw46gIBjKFGNWNTUnkdJBNWe+7+Oa96y/JrpjrM9oWtABwIacb0fk8Exz
        5J1lgaivP9OhGD3ccijPUG+mutq4o5SqfcPppnwl3UcmKUVeV4U7p+PHzCCeOZnO
        K/HpfyAwmEGsIQvSufEYGQKghACqC4eWlfjAPv7NVDLRCwSh4HFUlQtMwl9MdmQ0
        +sIPdDvO1OjTVrCgSPK5WX7iCzc5Scc7gWbyLaWK5iQXVDbWzTlZdSwbOV9SQw0X
        4rtOEHgUAo3ODEnod7PxnXWdq035n4bnU0Eqcwez0gdUMsSjALjOHJdFg==
X-ME-Sender: <xms:mRf2Y4kcKO3PU5ls_mtpCgW3rhvYL9n6HL6A2Z0mxYBL6cbJgyb4mA>
    <xme:mRf2Y31Y-WcoEGfGr8jlYGP8WZrk2LtGYMG3nKmvismvQdwXZeDLJnutWF3Twtxy2
    Z6ZHOnrNy_zxTK9dHM>
X-ME-Received: <xmr:mRf2Y2pTRzt18UX5jjoBU88_F1BsNVK1kARymCdgsnUPJRxAegia0TDI7-ty>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:mRf2Y0ks62gG4BEGD8ciaED6FLAcku9xXkbJDS2ncVF4lJ2Tk2tRkA>
    <xmx:mRf2Y201e1Pe5awKsE_ko_SBLk5wjaKJoAro5kb7KGdTIaxOGjJe9g>
    <xmx:mRf2Y7tJ2IQhGQvi1OA_V6Xo3O_up5eKORf1TrTjsLO4LV9le4Ia0w>
    <xmx:mRf2Y7wLXCiOXqcTa6UDD1KvWI8jziO54wh2iT2VjyZOkZ73gzwu4w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:24:39 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        hch@lst.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 3/4] MIPS: Always select ARCH_HAS_SYNC_DMA_FOR_CPU for noncoherent platforms
Date:   Wed, 22 Feb 2023 13:24:24 +0000
Message-Id: <20230222132425.7442-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230222132425.7442-1-jiaxun.yang@flygoat.com>
References: <20230222132425.7442-1-jiaxun.yang@flygoat.com>
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

As now we are telling the necessity of post DMA flush per CPU type,
there is no need to select ARCH_HAS_SYNC_DMA_FOR_CPU on per platform
bias, just select it unconditionally and we can sort it at runtime.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dae894b7d857..bcca65b25f62 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -115,7 +115,6 @@ config MACH_INGENIC
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_ZBOOT
 	select DMA_NONCOHERENT
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select IRQ_MIPS_CPU
 	select PINCTRL
 	select GPIOLIB
@@ -1091,6 +1090,7 @@ config DMA_NONCOHERENT
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_DMA_WRITE_COMBINE
 	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select DMA_NONCOHERENT_MMAP
@@ -1854,11 +1854,9 @@ config SYS_HAS_CPU_MIPS32_R3_5
 
 config SYS_HAS_CPU_MIPS32_R5
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_MIPS32_R6
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_MIPS64_R1
 	bool
@@ -1868,15 +1866,12 @@ config SYS_HAS_CPU_MIPS64_R2
 
 config SYS_HAS_CPU_MIPS64_R5
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_MIPS64_R6
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_P5600
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_R3000
 	bool
@@ -1901,7 +1896,6 @@ config SYS_HAS_CPU_NEVADA
 
 config SYS_HAS_CPU_R10000
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_RM7000
 	bool
@@ -1930,7 +1924,6 @@ config SYS_HAS_CPU_BMIPS4380
 config SYS_HAS_CPU_BMIPS5000
 	bool
 	select SYS_HAS_CPU_BMIPS
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
 
 #
 # CPU may reorder R->R, R->W, W->R, W->W
-- 
2.37.1 (Apple Git-137.1)

