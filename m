Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43916A604B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjB1UWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1UV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:21:59 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A934C23;
        Tue, 28 Feb 2023 12:21:57 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DF2FD32008FF;
        Tue, 28 Feb 2023 15:21:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Feb 2023 15:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677615715; x=
        1677702115; bh=oFtCq/8ptiJr0c+cZcdA6FMq2x5G60376xTChRpUewg=; b=q
        4UYxns75EGHGGBpFRayF3+bpvjeBD32EKSP+0OmqaOrVMC1i4kbWqsgvrbO9Ml+3
        HacPOzH90Lg7EXHPjCuqYY+uuw6bzSDo45kd8T2d2y+vPQaNcyXwjPQpBq9PNj03
        basPwBuv5Cjsk3BXDHhFZdihgjmmgmIffTs09Sz0GY5MhRnpPUauoMUCry+wyu+G
        ZEdINlETPRPhPVqdy0qhGZBLi8xQQfGJmgZMZ8Fnkcw8ahrbUkHfeA3qRuOaLn/H
        N7kReeL4EptUQLhM1JrtPtBxNiy2GkB345PHybOso8RUP1cdTNHmr/Hj4J4l5LLh
        iQaIHoSbI4Q2BfvXIKK/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677615715; x=1677702115; bh=oFtCq/8ptiJr0
        c+cZcdA6FMq2x5G60376xTChRpUewg=; b=iUd8hPxUyMc2gDOcqfjbtx8/TYfXI
        98Py0lRk9zYMnWF8bsXsNWpK9fjwznandhnYwfPCk0FSKyev948aKvUJqEIT/orR
        etZPV88c2c3fUxq2wMbRtSPJjs+rbN7DIRsu5jNREtj9UP/rfzVUPTGBsfsRG4R5
        PX7z5FNi61K8vxTKbGgzSH7jetFflo6yxdmY/o2dAno1stcs2NlvjyDKatW5Pa+W
        E9qW3/rfhBTc04aQwSI6xdXDDd3nrHC+dQVfTxAgbboIQDgB0PAIn/56qwSqyGYO
        uhyN3kmV1VYkaXzNQ+11f2Ekv0sgVaZZ8sy5sFFR/s9O2WAdekpxqwi9w==
X-ME-Sender: <xms:Y2L-Y_V4LmlqK7T4TYWqgh14r7b2hjTTvyMUMPU-9aPAM0cltt7Khw>
    <xme:Y2L-Y3m6R8nLcOsGOY0tr-cElf19engg73uiSI6miXBufGBBlHuMdpeFeu6oyf9Lq
    ct6rAWL5K_oWctkJdY>
X-ME-Received: <xmr:Y2L-Y7Zz__GTSuPC6iR2yfUDpEbcRtJDUJUl9-fc02l7YEN7ubxxljla97uoDzAkqWICQJRRgPUfFuwQVr4R5sswBMSK_9aZMDWnvtlOww9ZI9oNRIZayVVKW88DyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Y2L-Y6U0ZVDjkA7HwqkyQcbVc6hNQNTKhQ_h4EUSl9wSp3XgSszFwg>
    <xmx:Y2L-Y5lswwK79-qZ6SD-JsQ9SW94WdDqjiNBDIrm-EXUy4348c1gNA>
    <xmx:Y2L-Y3dPuQxEJh3uykxR2CgnP77KujV8OytbhCd6U3yJG4u-W04TAg>
    <xmx:Y2L-Y_ctLo6nrt66jhm_wwu727oForZAqkHnHmemlPvSzM3gTs7saw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 15:21:52 -0500 (EST)
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
Subject: [PATCH v2 3/4] iommu: dart: Write to all DART_T8020_STREAM_SELECT
Date:   Tue, 28 Feb 2023 21:21:31 +0100
Message-Id: <20230228202132.4919-4-sven@svenpeter.dev>
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

We're about to add support for a DART variant that use more than 16
streams and requires writing to two separate stream select registers
when issuing TLB flushes.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 7d8b2b90cdb6..7579c97a9062 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -372,12 +372,14 @@ apple_dart_t8020_hw_stream_command(struct apple_dart_stream_map *stream_map,
 			     u32 command)
 {
 	unsigned long flags;
-	int ret;
+	int ret, i;
 	u32 command_reg;
 
 	spin_lock_irqsave(&stream_map->dart->lock, flags);
 
-	writel(stream_map->sidmap[0], stream_map->dart->regs + DART_T8020_STREAM_SELECT);
+	for (i = 0; i < BITS_TO_U32(stream_map->dart->num_streams); i++)
+		writel(stream_map->sidmap[i],
+		       stream_map->dart->regs + DART_T8020_STREAM_SELECT + 4 * i);
 	writel(command, stream_map->dart->regs + DART_T8020_STREAM_COMMAND);
 
 	ret = readl_poll_timeout_atomic(
-- 
2.25.1

