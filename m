Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B4D6B5C48
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCKNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCKNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:39:05 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F24120494;
        Sat, 11 Mar 2023 05:39:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 858BF5C00E8;
        Sat, 11 Mar 2023 08:39:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 11 Mar 2023 08:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1678541943; x=
        1678628343; bh=NLAAjqI5hAqO+6T5ybLfjafnBv2sskMvoLWugFUpxvk=; b=m
        sfuyDZ6xSrSyN9Bs0NFxcqy01mxu9waEbETR1YmpTJRfs0eMDUwM4pLgkCPwP3Eb
        HLJMZdVGiV5+SSyKqfbBMJPlZnzCCYUfMpIqp22dFQDbbBV3v3gkJwoAGtZksGaV
        /DenYe35jdZSHTuxlxr81Me+D2M1/cGDeR3WE55inEdr68ucK18flVcRhRJ+ByEf
        brk3rHVGGAF4UPVFcRBTb7rr47GLX/3cCAoz3nTZoEoaeIBswnDVaevXio82r2Px
        0GCbf5yxLFAmd3ESJl40dlIEHTrzdtcni7EstHgP6LZMQJXqULK8+xxP/BlOJa9l
        yxLn/j/Dy4xlV0A5cfRiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1678541943; x=
        1678628343; bh=NLAAjqI5hAqO+6T5ybLfjafnBv2sskMvoLWugFUpxvk=; b=A
        UsB758ypS4D8RDAwC5ujxUdLmi7kpaEPNR4YVak6988PrG4eldZcFkxiDuqjoZ+b
        zvhcXqnsnw2evLT53FP4wp4iYmcJOFJFjA75Df1sbR4vOCQjcExNthoouXLQM+yC
        cWsETBinXc5VAcH8mGr2Ld+k+WMsq3W5BwSreUVx3Eqmy2nqSnkdmlZeAHvX0dwH
        oujoX/T2Bjas2s6Cr/fBJD6jqDsz+16oXqZuyHMCOTi7ZKGDcBRpORPUn/FWFQpN
        QQCUVgalS1ci7iv3mnF85dw7yuTdr0LHsan3BYSNo2CGRiyD3kWChTnv90VT3z6L
        IuHsIsehiXuEZj+WaRGSQ==
X-ME-Sender: <xms:d4QMZEFRto97uFnx0G-XW0mmIBzj0LTAoKErzDy6jzCx7YPrRGXZ2w>
    <xme:d4QMZNUag4vA7VHS5FuUN3gD0o5rQ_crU5_zcUOzQXLlTJq9tTTeJV9yQzsH55P8e
    NFahn9wcxL-f68kik4>
X-ME-Received: <xmr:d4QMZOIiqpr3718fMpTlv01XGxAq9uuUuGRJxEtLMrjcQmUOFDzYemSc4TgKo4LISotCXjNHX7zT7kbuFn9N8V6MHXYbW-80owLVu0SkpVRFvV-NV6I5rXRhxlRGUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvtddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:d4QMZGFSAx9HsgTUmz5rr_hW6XnDnSeu_dK1RMZhLC9Vq0n5P_mMDw>
    <xmx:d4QMZKX9HHzTlV3P4znIzMbCI8NNASYIf3f9ItmTWBSWjstho7J5DQ>
    <xmx:d4QMZJPZPE8FzNtu4Na88Gr8hU7LGn6is4y-wxQByPHHd1sBzT4LKA>
    <xmx:d4QMZLtI9NHC5p9uBOjjrVA3P6PlE64J58SRb0Nom3axv2KSQVh8uQ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 08:39:01 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
Date:   Sat, 11 Mar 2023 14:38:54 +0100
Message-Id: <20230311133856.63840-2-sven@svenpeter.dev>
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

This DART variant is found in the t8103 (M1) SoCs and used for the
USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
up to 64 SIDs and require a slightly different MMIO layout.

Acked-by: Hector Martin <marcan@marcan.st>
Acked-by: Rob Herring <robh@kernel.org>
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

