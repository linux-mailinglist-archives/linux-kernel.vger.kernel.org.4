Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA666A6044
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjB1UVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1UVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:21:48 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E2734037;
        Tue, 28 Feb 2023 12:21:42 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 24B58320027A;
        Tue, 28 Feb 2023 15:21:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 28 Feb 2023 15:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1677615700; x=1677702100; bh=80HN6tNx1o
        zGuvhWGo3Rdaml7NQ1ggVCX7mzw8UAeq4=; b=VNnIAw7Z+so5a+07y3LSfMCrG8
        olIHuKQ4ehz/JcEbUxjawVcyh+XebLoflCRa79c8n+jkl55K82TIVT+2E//jm2hn
        tZLek8JsY5s2X+I2cF67j1aFGlXTr1IiWoFDP79zM65tkJ1wfNYocD1uCYIcT6Jl
        a1yin/aBCTZGVaKY0bQgSHdQ31qfOaEYh84SMC7LNsceMz7MKOZPnnVroGVMzDEZ
        GkRB66Y4Ky9mr5jrrKhudFc0uqLgs+reaDq9PfwWPp/+Jchu2g7ELabZ+k6I00sR
        AEi3ewVJWl+woqSSSGg2JNJK5+17zit7YCiFdCux4DEtl3d1Gs5pwk2d/bIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1677615700; x=1677702100; bh=80HN6tNx1ozGuvhWGo3Rdaml7NQ1ggVCX7m
        zw8UAeq4=; b=gP+yMM/OKUfYKb9I4a53t7ZaW01eyg/xajf+r8BWcDUAWw08xNp
        //DaQKJsfU60GlTj60fCm666+lUHKf1SLnqF32wdjoK5qs5ZjBBvrMd2zN8tT/kt
        QXxex/eqRN4q9/wdPue2nlbQDO8nOGVc7ygdjPxLeSPgKu8e133soWl6LlZNrm2e
        Pl1XgNDXTwFp7TrEZhI57Nde2+P7cAvoaLqd9BWSUh6YxsyHaurQBuCOlR+LtxDd
        Sgy4/5jZFX69fnKHaOd4LgiaO3olY6u0F8mJXVwC6+lNeZf6EmePksBdVEPAysH9
        U6wlHViFIjyhtsIW73kxuX8XOjgUIDFNxbg==
X-ME-Sender: <xms:VGL-Y3G00odI-HEg2RwJxrEajIf-IE7eT5gF5BWQXhwbIUcRpeNiKw>
    <xme:VGL-Y0V29sAVoqwIG7l5ltMKwMZYTO4msVVRGPA72535ULBpJqhGlSpeG6MVNsTMK
    QK8TIeDMeUUuRR2sbA>
X-ME-Received: <xmr:VGL-Y5KxLmwEBXXb8W7lTz9V1dVAAmoHQiPiZTU77y23Y9b4iyTWvnvGuLRcTYI7HLUUSavRsC785cW25Twc4Xw7VnceIpEhzhJ1TtE5Ej3jcLZ8MYVxqH0egc6OwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeludffieehueevtdffvedtueelleejuddugfettdevhfefffdvgffhjeehgfelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:VGL-Y1Ez5paHXevuEnqAyQvLOWNrtoN4fi_FWxysO64ZW4ftkAV5vg>
    <xmx:VGL-Y9VjDtvS5EJ28BtTNBXEnNIWVziPj2f-IbVJIYsgNX9h1LBHng>
    <xmx:VGL-YwN8FHKFAG22LuzO1mvMRcCVFAxssgicgkmfGhBXeAYLXRRPjA>
    <xmx:VGL-Y4OVHbB-QS-VB8Hg1_b71U-Ij2w_YauTsmXzdQfgFJbnbNTQWQ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Feb 2023 15:21:38 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Apple M1 USB4/Thunderbolt DART support
Date:   Tue, 28 Feb 2023 21:21:28 +0100
Message-Id: <20230228202132.4919-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

Hi,

The M1 SoCs have a second slightly different variant of the regular
DART used for the USB4 PCIe ports. It supports 64 instead of 16 streams
which requires a minor change to the MMIO layout.
There seems to be no way to tell them apart from the regular DARTs by
just looking at the DART_PARAMs register so we have to add a new
compatible for those.

Change since v1:
  - apple,t8103-usb4-dart instead of apple,t8103-dart-usb4 as the
    compatible
  - collected Hector's tags

Best,

Sven

Sven Peter (4):
  dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
  iommu: dart: Add flag to override bypass support
  iommu: dart: Write to all DART_T8020_STREAM_SELECT
  iommu: dart: Add support for t8103 USB4 DART

 .../devicetree/bindings/iommu/apple,dart.yaml |  1 +
 drivers/iommu/apple-dart.c                    | 42 ++++++++++++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.25.1

