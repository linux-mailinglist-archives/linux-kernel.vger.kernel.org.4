Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1169E0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjBUMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjBUMqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:46:32 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277F3298F7;
        Tue, 21 Feb 2023 04:46:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C17A53200931;
        Tue, 21 Feb 2023 07:46:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Feb 2023 07:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676983587; x=1677069987; bh=13
        TjcRtfoBgYUAonSXqop4Xu1irhLU8jxIGd4/dBxmQ=; b=q2idsRBqJazuFn72mE
        20jDBSb0qMCAnmvgZQ+5TXd2mmJOmBq7/DJo9wgPMXpfZdkMzC9JY5jjjNJ/aVCC
        kTlkIVMAdrdBlX0JNhNB3DsN/GUFtqBcoMyWUzi/dYTzzhEReZjdXTPs/SJ9yUsu
        JdfFov/ubH3yO8fTz+m6l6xa2+HISPeXko9M+6Iwvg+KG24BnkK13hMoZ3ON5Jb5
        MXsumUkMEsPSAWiBVtdSUPo15H25awi9wj+17CnsodYAS72xE+p1d600D8xBBiUq
        wZLjIzbWRevh4Z6tITef2rQlaeOn1Ptlr7/AMXgOCC/BBIkRD2QutXFZnYFqz/TL
        oT0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676983587; x=1677069987; bh=13TjcRtfoBgYU
        AonSXqop4Xu1irhLU8jxIGd4/dBxmQ=; b=h4uH7u6pzpVpFaAI8C3RnTR87tY7C
        k8HOnLs5JJ1/43cc3BG9jXbWS9hiwzntd64K1QMa7yXHDub5ue2ppM/sSBW2li0a
        oTDT7hksncFaYcmYWP3dloIOp1sNpxWn85Mz7Zehhbsl5Fc9JuXDRjaLfj/Iw7cq
        vaCm2VhXPqs04ypGwzzfJdji1/PVJGLez3bo8RRduhpdgbEWH+whsjFOGyLfsP25
        axgoAlmQYaRUmwoq2j4XCRuHjH1IP6g+rkfLdkdEL4SSXSU0sen3NB92zcbY8v3D
        asWqulMzb9/1AJuLawhhX1BJT+Ab6q7OfU7C0GUA53Icea6xGP62v3ieg==
X-ME-Sender: <xms:I730Y8eHpoe0gA0xd547i5IokcRRORoSln2ePGzSVNuAuS32S31_0w>
    <xme:I730Y-O1TmUKE1KKNfPxMXxzbJOFkO9mBVRlK7r06Eb0IObc63Sz8XZKyrtP7S7bZ
    Do26lgoRFr3cRYcq58>
X-ME-Received: <xmr:I730Y9i7kVgGxqjkOlUoEhwVWIbNMlDtsg6m4wFjxcmZNvGbtfKerEWwFDeU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:I730Yx931GTrdlGF6WlarpSerBGSvLgUBJCE43XFSDkkRPGUy9-4Mg>
    <xmx:I730Y4tWVMDgwZdBCU_MMEtjSA1Q-LVBVcabicYnflJ9ceVIq9_KPA>
    <xmx:I730Y4FXtHy5BuKXty__JnmoluUx_6598FadWmwGnRuZzy2voBM8ng>
    <xmx:I730Y5mheWXh-9jxc7IcdfnjkPj3hP_CMtiLhzlafK5KczHvykubtg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 07:46:25 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/7] MIPS: Always select ARCH_HAS_SYNC_DMA_FOR_CPU for noncoherent platforms
Date:   Tue, 21 Feb 2023 12:46:08 +0000
Message-Id: <20230221124613.2859-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index c6f3ad51f741..8da52863da4e 100644
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
@@ -1089,6 +1088,7 @@ config DMA_NONCOHERENT
 	#
 	select ARCH_HAS_DMA_WRITE_COMBINE
 	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_SETUP_DMA_OPS
@@ -1853,11 +1853,9 @@ config SYS_HAS_CPU_MIPS32_R3_5
 
 config SYS_HAS_CPU_MIPS32_R5
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_MIPS32_R6
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_MIPS64_R1
 	bool
@@ -1867,15 +1865,12 @@ config SYS_HAS_CPU_MIPS64_R2
 
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
@@ -1900,7 +1895,6 @@ config SYS_HAS_CPU_NEVADA
 
 config SYS_HAS_CPU_R10000
 	bool
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if DMA_NONCOHERENT
 
 config SYS_HAS_CPU_RM7000
 	bool
@@ -1929,7 +1923,6 @@ config SYS_HAS_CPU_BMIPS4380
 config SYS_HAS_CPU_BMIPS5000
 	bool
 	select SYS_HAS_CPU_BMIPS
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
 
 #
 # CPU may reorder R->R, R->W, W->R, W->W
-- 
2.37.1 (Apple Git-137.1)

