Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAC867F77A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjA1LMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjA1LLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:11:52 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF46DFE8;
        Sat, 28 Jan 2023 03:11:44 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 501583200437;
        Sat, 28 Jan 2023 06:11:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 28 Jan 2023 06:11:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674904302; x=
        1674990702; bh=493UH9whhEk1w0ep2M9HRG0EP8+U1OlA4AfdHG/OFhw=; b=d
        e1jlgU34CGxuCvyj8cZMBK6/bWoiFIZZ14RcjZHMjYqEeQhToEkBt90vb4EG/Fzv
        ptuZ1dki+TmLwHkSUoHsw/FQCSC6jrAX9gtJYcucp/E7FKWkWXAJzF7bxBbC9PBf
        ZbeWNtztp4wUs0FvUdASrT+bk2cN1Ftkf0lK9rgdiGj2/6ljdFsXfTuKFgh2T1lp
        3MzKs3vpVbXcuCzTKOj9Qv3W8h6Ly2u/zzWsJxF3zaPcJ0EhNtcsnUMZDigSMDaN
        Yl9dC/aSurjv2YkLsul5saJgHY43Oejy9rL7z/3WqMQXou/vOhmDLiIqNEjx6q/a
        hn9I43GvOxJ7j3OqSLagA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674904302; x=1674990702; bh=493UH9whhEk1w
        0ep2M9HRG0EP8+U1OlA4AfdHG/OFhw=; b=PiC/NiSwFoLtaE5G9J5ld6e2XJUJc
        15KN4gg4UVQFlPLMuT1t7H0mzQXqsehV8LNDs+cfarFaZBfPwgl2ZfE5uyS+IKUG
        w5Xj+QbmPDj5d/aby83veig5W0liEQ15XRFOI76cpcQsPv3VDuevHTVcwZbbsQJg
        knsaiOTyyk7zmCokE591nRt84XTYNhtmfc+9EmYqwx4ilwTgOAE30/unrQd6IOyZ
        cH8E8u6PSa1EqImcI4ROrNHxk3daX0GksTtT75G0BzufUlaQfA8yAoQydiY2Enef
        Y9R+AFqB+Cv5GYRQ0tkiBUzTQyXREMPA4Sh6NI8pTVFbUrbr5CsEFrhfQ==
X-ME-Sender: <xms:7gLVY4nvck79p42jxXJL_nV3K0FoHJxIPO-J3dux_3rQk5uR8fsPjQ>
    <xme:7gLVY30vZ5J-P2v2s5GGRHNxtFSEAxSxXrQzlw8VGZigVL7WW5xu5rTzKTn2uZ1-H
    9IajvmSHc-msO_r6eg>
X-ME-Received: <xmr:7gLVY2reNS9WhSXBKUeCCslFd4iu8DTVYbR9axTZxtPRivPobJv4Yxu4py82ZNP_8qXfWDQkshUQYfi1DsPp-RTBadWUZG8jYdr6kngpBIwHQeQzL9_pONsplnnzXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:7gLVY0lbXrrVF7HgW2kTl-OeedJJzagd7BRCKrjPrhx0_mvzqCVJhg>
    <xmx:7gLVY204wNFjpfMcZBILTvxh1bZsgbXQv9G5LHhvgo5K1TIQca3iig>
    <xmx:7gLVY7uQ7AxsshVmj8mfveE0p_G8aCAVOahDv8Dxin77r9PY3STdjw>
    <xmx:7gLVYztIhBTfWIEwZv-re8MnBN1pgNsmTNkRPDh6krWi6sNFNvPfhw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 06:11:40 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iommu: dart: Add support for M1 USB4 PCIe DART
Date:   Sat, 28 Jan 2023 12:11:14 +0100
Message-Id: <20230128111114.4049-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230128111114.4049-1-sven@svenpeter.dev>
References: <20230128111114.4049-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variant of the regular t8103 DART is used for the two
USB4/Thunderbolt PCIe controllers. It supports 64 instead of 16 streams
which requires a slightly different MMIO layout. We also disallow bypass
support since these DARTs will only ever be used for externally facing
devices on the USB4 ports.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 7579c97a9062..a1304ba3639b 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -81,6 +81,7 @@
 #define DART_T8020_TCR_BYPASS_DAPF      BIT(12)
 
 #define DART_T8020_TTBR       0x200
+#define DART_T8020_USB4_TTBR  0x400
 #define DART_T8020_TTBR_VALID BIT(31)
 #define DART_T8020_TTBR_ADDR_FIELD_SHIFT 0
 #define DART_T8020_TTBR_SHIFT 12
@@ -1184,6 +1185,35 @@ static const struct apple_dart_hw apple_dart_hw_t8103 = {
 	.ttbr_shift = DART_T8020_TTBR_SHIFT,
 	.ttbr_count = 4,
 };
+
+static const struct apple_dart_hw apple_dart_hw_t8103_usb4 = {
+	.type = DART_T8020,
+	.irq_handler = apple_dart_t8020_irq,
+	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
+	.oas = 36,
+	.fmt = APPLE_DART,
+	.max_sid_count = 64,
+
+	.enable_streams = DART_T8020_STREAMS_ENABLE,
+	.lock = DART_T8020_CONFIG,
+	.lock_bit = DART_T8020_CONFIG_LOCK,
+
+	.error = DART_T8020_ERROR,
+
+	.tcr = DART_T8020_TCR,
+	.tcr_enabled = DART_T8020_TCR_TRANSLATE_ENABLE,
+	.tcr_disabled = 0,
+	.tcr_bypass = 0,
+
+	.ttbr = DART_T8020_USB4_TTBR,
+	.ttbr_valid = DART_T8020_TTBR_VALID,
+	.ttbr_addr_field_shift = DART_T8020_TTBR_ADDR_FIELD_SHIFT,
+	.ttbr_shift = DART_T8020_TTBR_SHIFT,
+	.ttbr_count = 4,
+
+	.disable_bypass = true,
+};
+
 static const struct apple_dart_hw apple_dart_hw_t6000 = {
 	.type = DART_T6000,
 	.irq_handler = apple_dart_t8020_irq,
@@ -1276,6 +1306,7 @@ DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resum
 
 static const struct of_device_id apple_dart_of_match[] = {
 	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
+	{ .compatible = "apple,t8103-dart-usb4", .data = &apple_dart_hw_t8103_usb4 },
 	{ .compatible = "apple,t8110-dart", .data = &apple_dart_hw_t8110 },
 	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
 	{},
-- 
2.25.1

