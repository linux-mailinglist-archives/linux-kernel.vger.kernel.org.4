Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66767F776
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjA1LLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjA1LLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:11:38 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586EA7B421;
        Sat, 28 Jan 2023 03:11:37 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B7BB53200437;
        Sat, 28 Jan 2023 06:11:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 28 Jan 2023 06:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674904295; x=
        1674990695; bh=q5YiyykUrJZCR2wH4YUrGX/fn5nsnR9BnsXm4VxP70I=; b=M
        5hIrXK9KxWDyNn15dh2pSalCeHuM/TcV9xP7KRvPBobzBysKiF7758ZXp7kU1ZIE
        gcOsxPukGSmJVUSeI+g4+GNGRIDvVZ5YFIlzYKIuX0ivxovODZUrHE34ReHfHSGe
        P8pLqFFvZcz71UCd1Q2D6J+ARmV6V9m1L6gmBCwUAqZ4Rl6HVG7RIYPgShTKoiCT
        I/x4C+FiIIrEOCRiP+YFh/Rxd+WKEvrBCP76CtTTnw36XFu1gVgf1OGWseyTILF3
        VHnCv6umtK2jiXVLnxQSMx68DI6hH9wA4DeYHknptnzyBLlp+4yLhPm8ic5BqdRX
        9TKscmI7s6agZCokw8wPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674904295; x=1674990695; bh=q5YiyykUrJZCR
        2wH4YUrGX/fn5nsnR9BnsXm4VxP70I=; b=dwMlyRe75uk6OXBC6Fo6AA4vYoq7o
        qy21TzeJ7FYEXjGlPi7JgVFy7ohmr0LNxUI86EhLr3YcBTjeNnOdfPnCNWLoTEC2
        E4GK3jFuOVFgvtXYAAeGqd0BmukKcTjttFRKsHSdK5W//9NAEgOWN+i862eW4FcO
        B1nrh9RyxOg50nuXYFNYDXq1WMJIUTMiJoGqaHhIdzWUs00Y48YJ+uRetUG+Ya+J
        wvGj6ULQ8ZDqObaiL14XANwIUAdL9ljSVVRZojsyteCYtJ+nrP/UUKUWa2lrEILV
        iZk3YwV+/XDNectwbw+iQ+WPvaWVXlyKKphmcVcvmJyv2o69xuU1j3HYA==
X-ME-Sender: <xms:5gLVY6qs5kDPcqp9QhmjZunJJ9Ovn-91IE2Nzbr36Mse4k4GFgxulw>
    <xme:5gLVY4pcBsJwMU0pjxzsQiypWMMKY2DQJhq9XBxQjtwrV4Uf0hQ_VgMsXtGRigNVC
    LUwTO-mRmak2soBWD8>
X-ME-Received: <xmr:5gLVY_O6cUZDC6RUcAwwWeBC42np7Wl2fiJwGuin-IeQOHdjt3fl7xCWr-g0wmahUeHJJb_lEwSh7-6y_5gAFNKWC9Ipf_RjlLOuXw-w4sEMWCd2Wl0fwudGSq3Gvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:5gLVY55XSoNlytVwQ6L723qPe46sP_cnedBZLFfauI9FdAjtq8UjeA>
    <xmx:5gLVY54GS7c2flCjlP4HI-ldERq-Af44XdNcgJk_aCIUvUOeIqEK2Q>
    <xmx:5gLVY5hhchFKPCoJN35kXN11hvcWbdil_el0nX5Yq9DrB2wSQXSQyw>
    <xmx:5wLVY1gKRMpfbBD1SJtRyPDeCI_w2bz_RGY3416YFYfmLtJ7CByYhg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 06:11:33 -0500 (EST)
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
Subject: [PATCH 2/4] iommu: dart: Add flag to override bypass support
Date:   Sat, 28 Jan 2023 12:11:12 +0100
Message-Id: <20230128111114.4049-3-sven@svenpeter.dev>
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

The USB4 PCIe DARTs claim to support bypass but we never want to allow
that on externally facing ports.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 42666617803d..7d8b2b90cdb6 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -182,6 +182,8 @@ struct apple_dart_hw {
 	u64 ttbr_addr_field_shift;
 	u64 ttbr_shift;
 	int ttbr_count;
+
+	bool disable_bypass;
 };
 
 /*
@@ -1075,6 +1077,9 @@ static int apple_dart_probe(struct platform_device *pdev)
 	dart->pgsize = 1 << FIELD_GET(DART_PARAMS1_PAGE_SHIFT, dart_params[0]);
 	dart->supports_bypass = dart_params[1] & DART_PARAMS2_BYPASS_SUPPORT;
 
+	if (dart->hw->disable_bypass)
+		dart->supports_bypass = 0;
+
 	switch (dart->hw->type) {
 	case DART_T8020:
 	case DART_T6000:
-- 
2.25.1

