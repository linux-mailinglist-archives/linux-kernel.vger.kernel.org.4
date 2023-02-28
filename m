Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE866A6046
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjB1UV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjB1UVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:21:52 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA834336;
        Tue, 28 Feb 2023 12:21:48 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0290E32008FA;
        Tue, 28 Feb 2023 15:21:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Feb 2023 15:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1677615706; x=
        1677702106; bh=tRDCxZFtukaHOUD+fpMmWdeVyai9y+sjwI29CnAl7cA=; b=Z
        kJEz7B0qMMNujmfkrzqEcMm2hYhts7x0GIjxc8PApiIkcaSLxREQhFrts20r02Uu
        cFm/t3xbHQqzNQwXSh00P+lJH+mkkhX60ISO32egN+3FcTrN7fv2uRiLpS90cECS
        XA6op3ndCXCjnnPov8FJNo9Gpau+aZCv7dooOF+E7tzwBhpyjiUvmmqxH43MOkij
        ML0McgY6PEVRvYl3WU0jctXLf5FDCw55kA662RaDKLpfXbkQwCi5BUhUaIEvgSlL
        tyQ9Dgqfj7+QhJuZATAXk1SLCN1kOyLr/kDTxooHcPe6iV7OwvVMJM406oR7oVDj
        y/62+xZd/9MmCdkyWC81g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677615706; x=1677702106; bh=tRDCxZFtukaHO
        UD+fpMmWdeVyai9y+sjwI29CnAl7cA=; b=TWI0AO9FfDvAoGG60KH4G15wRNyg4
        W2DhQRR+xv1I/HDi9htErE3Y/zbwkKniYcXLNliidZzSVuowPsdC5eOWB8/T/+DQ
        ENi1VZ/EvCAW/0deB+rIrn4PjNbDFqmphmFFoj1dCRWb77lBPVfJKPHkuMKJ+256
        AaJGH5xRNxAwRfh6ao0iLKP6CFR77MGoPcNDUCXpok/7A6HMYVQS1FK7K51HRlUp
        zBRt27o2+isZ0A15Grric3b0gI7gp9VfzLE77EMGSjksLaLt4y6WzzsDQ48u1pz4
        QgLLcGEJ+WY90gN7hjYtGHBNzn2+yVxljDFLJBs76D1Ixy21URktvAcfw==
X-ME-Sender: <xms:WmL-Y8Khtn_cAsN_bAWJ97ig20grNME_c7nUAGy3VR3W4kJoUouU5Q>
    <xme:WmL-Y8JH5Ri06pHZlWMoDwCgJS26DISOZvdnn6R3SMXcaGwUPWuqzjKA5PH7FFOqF
    hbfZYvmgQW_g7SqVHQ>
X-ME-Received: <xmr:WmL-Y8sxUPJE1G_WIkyAOlBL6sjxAR6MatrilDgKhoOcU95wmSzq-rZgJebJeiuH9shr7F9jlqK9DHiDxJbtdr4GhH2wS1AFgzKaWiqxvEOjHo1_HEDorveqdp48zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:WmL-Y5YB6W6WTVVZn3QK2utQLgOwQxSmtQXIkFkbM5b7x5Dx2d7N3w>
    <xmx:WmL-YzY1LldBdyaNKkQY1oq2yvCOX9MJID5e45tgrXXKCYmvI_MeoQ>
    <xmx:WmL-Y1DIKQXDdRmES9QQpAWoPFt12hQ1d1AkbeGM--N3KvXc6ON3XQ>
    <xmx:WmL-YxCPAqY6DJdUxaUOZBn45LbfRRvKc_OmgvwVqK4c0suyKnrdIQ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 15:21:43 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
Date:   Tue, 28 Feb 2023 21:21:29 +0100
Message-Id: <20230228202132.4919-2-sven@svenpeter.dev>
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

This DART variant is found in the t8103 (M1) SoCs and used for the
USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
up to 64 SIDs and require a slightly different MMIO layout. This variant
is only found on the M1 SoCs.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 903edf85d72e..7adb1de455a5 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - apple,t8103-dart
+      - apple,t8103-usb4-dart
       - apple,t8110-dart
       - apple,t6000-dart
 
-- 
2.25.1

