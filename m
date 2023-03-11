Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177C16B5C46
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjCKNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCKNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:39:02 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9001911F6A3;
        Sat, 11 Mar 2023 05:39:01 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 093D55C00E6;
        Sat, 11 Mar 2023 08:39:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 11 Mar 2023 08:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678541941; x=1678628341; bh=it
        VVtU9Drcg8BUr7cYlsI8p83sJPuETIMO1tPfSIU8I=; b=qh5Vg0pu/qeoEMsTJ/
        5uBEZS1YZaiM32R6f98WgOzx+cW2iUdiW+ia+nJ4bYNIc87BsM+0aKWvi7DxhZzW
        RQFXe6FHVD8Oz8dxOuCyF0Mvp0+ZFnztoYv8t1p26cmi/ELK5MxnVD7lqw0yz8x7
        aPnTC16+641BekwZE1r2SxtupXthg6I5CGywBQCwRLVOiZVDPg6gspipqNhhVIhT
        vFd4lAcG6+060KN80QNrNH0/l8eSwX2NxYwQiwRcsGaqxsjcUkRoTLowW+2Nkj6w
        xwuQ7EPWCvde670yi42WxiUSnbtinrRxJOzbf56glZypEJGUabsB32AriNtx4BfG
        wnpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678541941; x=1678628341; bh=itVVtU9Drcg8B
        Ur7cYlsI8p83sJPuETIMO1tPfSIU8I=; b=Gz0GYODrCPnfczSiw5q94odxrLvIh
        A3GbK2szijOCUNkDaKVBECc0C2tmGopgO33XrvtfTukX12HqmlfYrZjCJNgNJroG
        9n8HL9HFlJ+kWYvwiHLtvyPNtQyOCOOvekF8mWvPQooRqj6bSb9zSLh98XJKWzFV
        Z7hUrXU/CB895rELDSSsOWo4mVc/OpGx0Fd5VludgY1Ntv4BBp/q2y+JfB1IDIeB
        l2bgYFN1+PpGqF2Ahceo+z3SLiG1t+fTBgBW7dPY5T0qyREIZPM3h6qkGcPeN/ND
        8k0+it/pq1ktjPfVBexy9ocQV/UEiG3dikyg/G3tvol3ZiHqlA47FfdEg==
X-ME-Sender: <xms:dIQMZLGdfcsDp7xbsXHuSDuhKPtQR_MgJ1EHx5nezmH0zra5au_JWw>
    <xme:dIQMZIVGS6V2Iq_VT6oLDkKPBKJcKClOO_-ko0t65PlRwBZeO9nJHfO6r5mjGpQVz
    Ol1rrh1m6BLf2049h4>
X-ME-Received: <xmr:dIQMZNLcZFLl-BaTnAlkObfkt7EyFQTIYouIt0u2ECIs-l2O-fg5XvhkLALUND8pQk9l8blHdtfqWvsycHdYu8Fxe9XOdC1WocpNbV-8z5Mzj-gnykLtp9WM-jeq0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvtddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeludffieehueevtdffvedtueelleejuddugfettdevhfefffdvgffhjeehgfelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:dIQMZJEd0qWz6xLOr4i-t5JFzN2VHLmWIPkvTJ23-LUkcjA0GrKXzQ>
    <xmx:dIQMZBWh9px26z-lJVb5cG6aBKw7DdTJlyJ_l-sohYVRllWFsaW8FQ>
    <xmx:dIQMZEMQ_p-ceCycoDnSFWxuzyItT6owk69UDaaKQueSyiwVoV1GoQ>
    <xmx:dYQMZMO5lFgkwADtvi8fhhpZzoqCukzZ1_35VKbhWBN05lxzFDN3qg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 08:38:58 -0500 (EST)
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
Subject: [PATCH v3 0/3] Apple M1 USB4/Thunderbolt DART support
Date:   Sat, 11 Mar 2023 14:38:53 +0100
Message-Id: <20230311133856.63840-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

Hi,

The M1 SoCs have a second slightly different variant of the regular
DART used for the USB4 PCIe ports. It supports 64 instead of 16 streams
which requires a minor change to the MMIO layout.
There seems to be no way to tell them apart from the regular DARTs by
just looking at the DART_PARAMs register so we have to add a new
compatible for those.

Changes since v2:
  - drop the manual bypass disable
	- added Rob's tag

Changes since v1:
  - apple,t8103-usb4-dart instead of apple,t8103-dart-usb4 as the
    compatible
  - collected Hector's tags

Best,

Sven

Sven Peter (3):
  dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
  iommu: dart: Write to all DART_T8020_STREAM_SELECT
  iommu: dart: Add support for t8103 USB4 DART

 .../devicetree/bindings/iommu/apple,dart.yaml |  1 +
 drivers/iommu/apple-dart.c                    | 35 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.25.1

