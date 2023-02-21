Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517469E0A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjBUMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjBUMq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:46:26 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370F28219;
        Tue, 21 Feb 2023 04:46:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A87143200927;
        Tue, 21 Feb 2023 07:46:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 21 Feb 2023 07:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676983584; x=1677069984; bh=HV
        +pK7weCQwzefnQB2ct/H0NIgIoXkqz3Kzgj5x1/Ec=; b=hWuWEixhb1PD9+AF3W
        CJ0UmnfMraBu2//N0+dHFSlNmF+H3ij7pxSBzuLRnW3NyqfQ9Rt2/3WZ3/YHQllC
        JVX4I4Uw+p0QdK20iiwu9XVU1c6OFTwhPVv47Ctg4r9w0fMct9bocShHM1deZAjU
        2t9ZOgKKGFJoxRZtFat1HDdCzt5NtOXS+65+YFFiqCz0Z0NDWE+vuHZlvGN/IHCE
        B28PNf4G37ehwsLJFHQv+wIZHl7NSuuhLbeyc9zdcTC1VN0DDlZLb9lCHe3H0cuZ
        KB5nymhc9oKplbra1XBa8gLODF6hfkts0NTUsFJDMDs0X0bH3YeCRau3DTV2sHM4
        bHzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1676983584; x=1677069984; bh=HV+pK7weCQwze
        fnQB2ct/H0NIgIoXkqz3Kzgj5x1/Ec=; b=ej6tpM2nMZwwgl1SnwhNnU9yh2cxO
        KrbDXSbXhOYeUi1GIq0THMySUg1DJKevql1jZSJ7l3uMcMZg8vy1o+rSoDjY3qXy
        naTk2V2xJleFnSUi14Wy2F/aNc2d7QD9TF9Jpi8W/x2P5sYmLILSX+miQcd1wksI
        Loz5qjkGt+rKSP9txzfAoQbULGQqWFCxjtN98vVSiQV2DVq5l5ShELYqzKTmXnio
        2e76o5+Qjj8EghX3ic2e5WN50at5KtNJqweY1805kwdcadHmFx45K7oPYmSS0c09
        C89Hadj8TTxijU7NEfUbi9VP/BL6tq6Y8eEitUsY/op2ck3o+txGe80xg==
X-ME-Sender: <xms:H730YxkL2gd53B5b_xyKm4ypHMwDHRwUJl_R3BXXvgB78ghYdIITTg>
    <xme:H730Y81L0W6ug5co2cDH7R_lzm9LaF2VWGfi6IqQxxsB6Cke2KaK1MnvFpPvJ8Wci
    hv1Fd44A3GCwW4IF9E>
X-ME-Received: <xmr:H730Y3rMk9feBr2UDlZKWXR9PM5Pd72dLA4ZG48dZAVZR8Y79fdkzbCTcQZ->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:H730YxkY_yRwJH8_mXfps7FowNizAmJG9SdX_U4AFSeCpRxoPrlzYA>
    <xmx:H730Y_18kxHacCZqxP2SJKAs0xqEXov5pDqp99jU6_A5VEVd1PUqfg>
    <xmx:H730YwsiOh52LtPZN2sE6IaQnrUHy99rNj87MKy1AUDCMVdHBvEYCg>
    <xmx:IL30Y4tId7B_ju2XgHJaR0s5nR4_dXNJ3m2xjL2nlIYW_C0U0EAKMA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 07:46:22 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/7] MIPS: Remove DMA_PERDEV_COHERENT
Date:   Tue, 21 Feb 2023 12:46:07 +0000
Message-Id: <20230221124613.2859-2-jiaxun.yang@flygoat.com>
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

As now we are always managing DMA coherence on per dev bias,
there is no need to have such option. And it's not selected
by any platform.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 15cb692b0a09..c6f3ad51f741 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -134,7 +134,6 @@ choice
 
 config MIPS_GENERIC_KERNEL
 	bool "Generic board-agnostic MIPS kernel"
-	select ARCH_HAS_SETUP_DMA_OPS
 	select MIPS_GENERIC
 	select BOOT_RAW
 	select BUILTIN_DTB
@@ -1079,11 +1078,6 @@ config FW_CFE
 config ARCH_SUPPORTS_UPROBES
 	bool
 
-config DMA_PERDEV_COHERENT
-	bool
-	select ARCH_HAS_SETUP_DMA_OPS
-	select DMA_NONCOHERENT
-
 config DMA_NONCOHERENT
 	bool
 	#
@@ -1097,6 +1091,7 @@ config DMA_NONCOHERENT
 	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
+	select ARCH_HAS_SETUP_DMA_OPS
 	select DMA_NONCOHERENT_MMAP
 	select NEED_DMA_MAP_STATE
 
-- 
2.37.1 (Apple Git-137.1)

