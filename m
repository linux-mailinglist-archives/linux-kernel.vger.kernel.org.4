Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636956A6049
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjB1UWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjB1UV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:21:56 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD834C3D;
        Tue, 28 Feb 2023 12:21:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 800B5320027A;
        Tue, 28 Feb 2023 15:21:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Feb 2023 15:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677615711; x=
        1677702111; bh=BAhcF142/IhXpreaLpl1FjM856sTe69lr6eU5Px591c=; b=p
        X1G6Ky6/Chkf38pzpeb+li5Xw6v/M6Ro+NF7iTGBNqJlOEOoMYhN9/3ciq8d3wG6
        VEeooop0g+n4ZGJIllU+3CwebccYsB6iMDViLmHyyhQ+obW9v28EwPjPMXxazV2e
        Y3ycgqmXvVLEtft6Nxw1HjNH4dNC1tzmoxibOKSQgBgZBK9qP+DR7wUDn2ALVYGJ
        SvGacmcz/uRrqNFIvpyeE/xyybeLr4WgyzTJjB/5CRHcYQVmNB20RBAS1a2sPVob
        PTKbbgh3eUZfnAxdk87RpKy1vBygHYUx0Mzfh8zmzyCq5G7Yy80p7crw/hfsBls9
        nwV0YHl3vt7xV6UK3DvhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677615711; x=1677702111; bh=BAhcF142/IhXp
        reaLpl1FjM856sTe69lr6eU5Px591c=; b=UDhSkP4h6MGX0YuLyyd4UcMCiag5s
        GMifcgYHaG959sgIRShB369KGPh2fX2HBo0JbgDVEZNOEJJrOpzregoLNkUC8e56
        arZyjkrcueYv9BAPaxlq2QmYiDoQ6i2BYPe1ybHWTot/gN9vou151W2PAu+FioW0
        DL7c35pSCvO7yDIsjdpS63sWbpd4MMN3PW9Hu5bRunZ/ALVGlcTTKNn1vhFCr4Zy
        qiy570erQ6lBoC1n+KSAL2sL0JOGfZLqePU9XPLegrx/482mbRpgqCVphClvOa4H
        qZ5j1lBrt8HMV5MAd/cpIuuHiggA3XX7P2f29MxO7Sf5jjqaWXb5DWhdw==
X-ME-Sender: <xms:XmL-Y5dnOgwKbT_GMYUqVauzwMTF_G3IdOhZpp5RK1sVkHuVd98wFQ>
    <xme:XmL-Y3PhGWfhouYhW2rmL8XvTHx8ncybSTw_G8mteW-sNUULlf9bLUBaXEeIR-h9O
    9uOIsW1p4RayLf5v-E>
X-ME-Received: <xmr:XmL-Yyio9q0YI4jgMcOQnkp7wqnHwEPPbYZJbnCiVLhoBL6-wSnb3gaJZB5sld5_6d_GWKlfyBDGk3-SrDf7DWdLegrdyhY7xLWn0CGOTlF7nSl2BVyqwtojRiV2DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:XmL-Yy_13KYfa9wrnHheFPww1c7wZB-orkrW5i9Vlh7NKP-nHmcZYg>
    <xmx:XmL-Y1tj9JVAiRJvNEbnHNUfduWMIIX4mCslSFHbl9Qq9L-VrcqC5g>
    <xmx:XmL-YxGsHG0IvO9Bjksp8jWmFTq5-WX1e9IcUA51ihMRqUd-kjKxDg>
    <xmx:X2L-YxHl6YO0XFUwxlyfvq4kdwAC_1QUQmW93H-Mq-_G7QitSQIu7Q>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 15:21:48 -0500 (EST)
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
Subject: [PATCH v2 2/4] iommu: dart: Add flag to override bypass support
Date:   Tue, 28 Feb 2023 21:21:30 +0100
Message-Id: <20230228202132.4919-3-sven@svenpeter.dev>
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

The USB4 PCIe DARTs claim to support bypass but we never want to allow
that on externally facing ports.

Acked-by: Hector Martin <marcan@marcan.st>
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

