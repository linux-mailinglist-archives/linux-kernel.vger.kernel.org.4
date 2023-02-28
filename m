Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B066A604D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjB1UWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjB1UWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:22:09 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FCD34F7A;
        Tue, 28 Feb 2023 12:22:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 2C45A3200916;
        Tue, 28 Feb 2023 15:22:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Feb 2023 15:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677615719; x=
        1677702119; bh=p8ZqQhrJ3wpAF4QuT+1zVLuNbpYdyDzeaaN6r1CTKxU=; b=t
        rlGkeujQfNFXD62Xfz3q4LflZgaZJsFzXo3DQBvFa0VNGFDiZWMh1IeRQwDYHGTK
        +HZJdsRyEgMRq5tCCgkfO/hWPiuGt4jtVT1oS8hdduw6lXVLsZCkuAD+ZQqxSoEq
        woW4O9IYhWuLyIVd9iPVLfVgCoIHxiK9Nv4gPsOGZElihm3mh7uPEbEy3tB2wMQC
        nbK1zQrIbdDphRvyjwFezNWD79Oecx3nIHaJMT6SdsYaGIstMB6hYPbFVXhJSaCb
        3NUV0/Ta2XNdR3P3hn89Ik2qIx+8hrA5roaMnXBRQ3OZ8KlUnaW9SzeCcQpBNorI
        RwNNqjvbeeOGpzhotN2wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677615719; x=1677702119; bh=p8ZqQhrJ3wpAF
        4QuT+1zVLuNbpYdyDzeaaN6r1CTKxU=; b=f3lmAnn4WfiAWAm3n4Xyv/uaTT4S4
        e07toQkoAM1x4TorxcCICgPOVT2nNVQHl5hnaIWwbb6zR29bEhP1kHVKvSUT5w61
        bMEPRApxa1U2e8V0f4Pt+063ZkM3WCGvR1nQ1ob+wS3TNNwxiUNOR1y7+sEgv2Zp
        qoHyQqBQyiadW8ogumsqo0PFINYEGL6cr/jjriRimO5ugh5Gg9RgVPumw6vHz4Np
        CBE0sgP0BvjfNA3zMnR5nwHAD69wI/tKPwtK1L3klmUO5mJDDL77rz+sxNbl4iPp
        9pO2tTW7QRM+QcPyC948ol5IAtEEjpUhE635amScHqvyhQH7YUYmJ70Lg==
X-ME-Sender: <xms:Z2L-Y7S9I8oHZwna1yO9-fUM6OYZdVJawak-TZqMKQ3mwr4QkmXqEQ>
    <xme:Z2L-Y8yZjW9Gf27mLFw0aJOoW7VuuQxCq9RR0ib9RSdHdxFXZ-cEWEeI8xXPLd_eX
    dJcPZUFnj5Nbx8Tag8>
X-ME-Received: <xmr:Z2L-Yw0c6F44MRWLzjYf43i22bLTAZH4RjF35zoCtQb0jbRdJIyKDIHB3Qd4o4TTchl2cwTPfScCgx0xMQ0uTqwYeaRS728jwy58LLoV0KQtpmrK47qMZKSjGD12lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Z2L-Y7AL51je9_5K7W9NK3w-lOcHfrFyNyCTxZ-MtQuHsbBySDcJig>
    <xmx:Z2L-Y0jeYxFm_DrYcSlskAkxfHSGCyFdXLCxd5JTmKO-O3-fpccpRQ>
    <xmx:Z2L-Y_rwgPwlGn0OWfmyEAWL6PoIIx1HZltUCceFr7lvFZZJSObQUg>
    <xmx:Z2L-Yzo2fU5t4QrKXyVPYMTy5hW2JvHfSGHS96eBOxwKzlCIFkjYIQ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 15:21:57 -0500 (EST)
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
Subject: [PATCH v2 4/4] iommu: dart: Add support for t8103 USB4 DART
Date:   Tue, 28 Feb 2023 21:21:32 +0100
Message-Id: <20230228202132.4919-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230228202132.4919-1-sven@svenpeter.dev>
References: <20230228202132.4919-1-sven@svenpeter.dev>
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

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 7579c97a9062..b9886d40a4d1 100644
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
+	{ .compatible = "apple,t8103-usb4-dart", .data = &apple_dart_hw_t8103_usb4 },
 	{ .compatible = "apple,t8110-dart", .data = &apple_dart_hw_t8110 },
 	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
 	{},
-- 
2.25.1

