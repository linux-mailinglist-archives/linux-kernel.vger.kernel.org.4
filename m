Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA966B5C4B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCKNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCKNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:39:07 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73A1204BC;
        Sat, 11 Mar 2023 05:39:06 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CE6C35C00EA;
        Sat, 11 Mar 2023 08:39:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 11 Mar 2023 08:39:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1678541945; x=
        1678628345; bh=Mb4+mJwB9+LzuGO9Ggk72OOMawB9qgwmFuhWOsw7aP4=; b=U
        G4Qt1C3qNvQ4eS4ZygEkSYDQSVWu69siFHSTTejTJLT2+xUEyXfaH/zui3oOpNSa
        tRLOedAAB9OVKxBueQ1zqtpeKBA6m/DFVXFxvxxRMDMv+dsmFafR9mQ+uJv+bMep
        o7K41ngxxW7Zj9KWuO08zS6+LOlnPuRWE9kMi/ZlwvAl+C2X9YShncPYaXsHdJR/
        JbCKkpc+TyDknYdw6abhj3ur6iquyEy/mFZXVwkvtap7nLgM5buXcgZSjmCgVENx
        gxLs0GpiKv7FhkmId8YJ9vc0dJ7WYbJN4Q0PSDof0YcMgXO4aXY+fHex/r8VCYZY
        OkVYtW04Iogh7j98h4/Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1678541945; x=
        1678628345; bh=Mb4+mJwB9+LzuGO9Ggk72OOMawB9qgwmFuhWOsw7aP4=; b=A
        Qo+JKgxfrPg7AL9JYNClLePLxZ5HlQec6TDPmHsDIUgAC4RBxvTAuHouTKsR/tYn
        4X/uBb5OK0Ka+MpBDr7I57rZ3px1vMTbuZZftfbv6j0ms3nsx9Ymtvi2ReEFbp7E
        gJKx9HAtm5mA1vzeNoQnyTG+4hjNA49drTua57yxZzbIabHFX6ylerT/ODfQXHJY
        +WjBz30YzVOMl5eBd62EVnpdMY7/fgbf4fZDqOgH7AdoZf+mNLum3dH2zTzPm2+X
        GCmEw+mIiKhndyUJT4531OYZpn1BDXINtfhBdsD5wd160n9iyhlfEyf96pPA4LCZ
        AdOPaIS8IiQPwjOA9XVqA==
X-ME-Sender: <xms:eYQMZPeuO_H4hh1-MLwU05GR9mr4_oL9U8QZsVFH1PZmKDo357LArw>
    <xme:eYQMZFOFRRv49N-fyjZJOJwdjcWvP62pEIzS2gNOvSNdhN-wWz0teKVcmg5VzoFnQ
    lJp6_2ONd4wEaZFVEA>
X-ME-Received: <xmr:eYQMZIiuRuzzy2PJDBSRHyAye3MSjSUI2mLCjVR0NGGF8Uj8_muAeicNH42pjE3oXskjUUGW_Tmnu4uVTUvQ0FCzBZt05xkxWfwQAI10B-AnhrrE4g1DvFu-PlvQIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvtddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:eYQMZA_sKTVtOgxP5NGpjr2d86nzCEtWgrWIxdWXqA9dJGPTlLVzfA>
    <xmx:eYQMZLvABimvVh2NNCx9A7q8Astjf03foyZk6lecPFRccBjXg73hjA>
    <xmx:eYQMZPGtUuANVgZ15KazdLDoGrwJjdBqWcmc883PFMG4ZFeV4euOyg>
    <xmx:eYQMZPEeJApPLP5GmGOeSm3ln6oUlW6Q4JFfKbpQA_s6qIGCZQEajA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 08:39:03 -0500 (EST)
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
Subject: [PATCH v3 2/3] iommu: dart: Write to all DART_T8020_STREAM_SELECT
Date:   Sat, 11 Mar 2023 14:38:55 +0100
Message-Id: <20230311133856.63840-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230311133856.63840-1-sven@svenpeter.dev>
References: <20230311133856.63840-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 74a367302d34..f73d0288e133 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -370,12 +370,14 @@ apple_dart_t8020_hw_stream_command(struct apple_dart_stream_map *stream_map,
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

