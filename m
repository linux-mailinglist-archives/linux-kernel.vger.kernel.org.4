Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D467F778
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjA1LLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjA1LLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:11:44 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13567518DD;
        Sat, 28 Jan 2023 03:11:41 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 769B73200437;
        Sat, 28 Jan 2023 06:11:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 28 Jan 2023 06:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674904299; x=
        1674990699; bh=95cFYESovP/5VNc+cPvOHG0EQFnShh8vh/vZRQA6QEE=; b=d
        zeyfbiWH4qMpOpayK7ptqs/ng+h+UgBQdxg/M4/Mz7jQPHAh/1PCYaBYJIM3sFXS
        8nlSvqzTb+0krb/EMFEDzd7lw0nQPwC3T+/xbt4EPVmb1cU8FThiW99FA/h/6nOW
        nPbgsE0YeWFmP05XvIP4BCGnHg0e9slquaog6aKjpJlvYPAshVFKj7DMqQAA7gQW
        JrybH740/n8ns0hpT/SWhxVOI1R2PCpREIs40xJao2DKG2zTGrXc/vNVwZtpBsXE
        2b+bCnnOyKwAjzNLsA4ljovkKS8KQ+Ku+Ay6pHYxe/jL5COFdgKG5VYh2aU1+yy3
        coBtuvkoUGsPauhpxnJVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674904299; x=1674990699; bh=95cFYESovP/5V
        Nc+cPvOHG0EQFnShh8vh/vZRQA6QEE=; b=ROaUUwA60NdlI0CcuJvUlvx9txZuX
        hlp6qf5PB7wiihk5tUJVba2gOwg8WcyArMzhnlL8+2B1oHYaOaDbqDbST8gPB87t
        mwmIskktVbBlrOnzr5wfCUD//megIbNXEsQYbQRvQxwcd+yz4WmGxAnPxKDb4tU4
        e5D28B+Ni0fwjAmh0rUC/B8O9XxUFYUJWlaDgzhnM4UHfPL0hwbzoq9Do6aw9oQW
        rASYPbPnyvRtg/8TYN4f6SBGDtaC90ueRt02HZaDX6UsjNn4l/7/co2s24BWKY7y
        i3J1AxOp6sjcxdigYbd6izvIyuMIgPFVY63S8qG1zVIBmrBFgL9Djsswg==
X-ME-Sender: <xms:6gLVY0fQ0TX0c2JLmEM9JsJCANiFealWk5-gXnci3F7Ni-PqkTwDIg>
    <xme:6gLVY2OU30agzVDJas9p1nSPLGef50iqnCVDAchVygMFFcAQa7ZFv24oBw5cVBTsm
    ZniBM95JATNl_tUlYI>
X-ME-Received: <xmr:6gLVY1h4J6l7a_aNCnoXW0buB30q75JO_ytKyWyMnLh_YSJwzIy-5Qwf0Kiyi0eKqILxtkrMKML-2mypytU1PgeVXxPLy1djAWWSlDnTINhUAoRvvnUmNTNPLphiZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:6gLVY5-58AG28G1-1QCn1C1jeVdyPkgTYkWvR6wk9tffJKUJ2RYKzw>
    <xmx:6gLVYwunG1f5hjHD0V-q8MkWEI7XkleuHPqZhfzLdPD2KAQQyTeL9Q>
    <xmx:6gLVYwGe5Pfp9IG0ZilZGVcpXg8mhrLnbOMa6ZfwVtqiADA6vdAcWw>
    <xmx:6wLVYwEzUvHsTmTrKjAOLnHRuvfB7ySvWnA6qtknCEaXwf6dm2mJaA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 06:11:37 -0500 (EST)
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
Subject: [PATCH 3/4] iommu: dart: Write to all DART_T8020_STREAM_SELECT
Date:   Sat, 28 Jan 2023 12:11:13 +0100
Message-Id: <20230128111114.4049-4-sven@svenpeter.dev>
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

We're about to add support for a DART variant that use more than 16
streams and requires writing to two separate stream select registers
when issuing TLB flushes.

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

