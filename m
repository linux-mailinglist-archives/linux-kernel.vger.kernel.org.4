Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA57627480
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiKNCVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiKNCVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:21:17 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AA263E5;
        Sun, 13 Nov 2022 18:21:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 581573200313;
        Sun, 13 Nov 2022 21:21:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Nov 2022 21:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1668392474; x=1668478874; bh=aYiCWONLZBFtYySFfLlgu9fEI
        +6ZzF2ACekapN/b5p0=; b=VdmRmhbqMNkU5ZwEs8K4R9v+KRqdjbYmRrG+fc4JG
        a2tN8MOoBesN+BaZ1btNO/zZwUEFgQ5ycRgKq+RBSBuBb3jGsGsO1NElyKtCbMQ0
        h2TzT3CuI4mB7kHwCivKShYT3jIOziwlLLOzpJdzcDhPtjaXsS1VpNvEDkU2GtCk
        yRonKC4rsvdufOiRyNySmtV+LVG2uGrw8mSMwv+Tm5smG0ifVtPNt0ol7tIZm6Mf
        vl78Ur6IDsZamQ9ruO57Te7W3PJ/LJnikUMfDVQ2W6Y9oaT1TFip7RoHNAZXhbqS
        eHSuUIrTg4BWqX0WZ2py2yFv0CkktVpH+Qox3LZSXPbVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668392474; x=1668478874; bh=aYiCWONLZBFtYySFfLlgu9fEI+6ZzF2ACek
        apN/b5p0=; b=JIBbtpjvZhRdOAbvnSmz0agoJzjRDEh8732u04Rtgx+cv6BucUw
        kYr65g7iCgssFPx9P9JZVzlXspHatlNSSdQBE62LGLirQDXM5JThcmMe/bZqjS9w
        MNDIrbFtIefShJ/xqEgUNPLq1rlrOod4u/uZGKvN8vGdU9wPwXMMm7eMXSA2mjon
        Z1Oy8QQvweNiCdg+MgKmhI3oe/4hDmJZdQw6EZddufVA2VFBkOHIeO5bzYMlH0xr
        vlxYJI5CROSdroDiWImYTG3hK8ExITWC1WdNnTOtkVqKM/M66lUTYDPuQthXFS4Q
        ZRXFEwPh+JNcU1xZ4gUZqeJssgmnP/dHDXQ==
X-ME-Sender: <xms:GqZxY1BAxcS0hhqRosBXYuCbB3L16WQej6wIbJGDMAOlEQg2Ue6GAg>
    <xme:GqZxYzheevG5R67k9kgJwHBbthTYVeHgXw73Ielw3Ig2i2gy6BkyZovd7lJyMAv4H
    xzKkVo-puyQ4aEiJA>
X-ME-Received: <xmr:GqZxYwnGwCRlD18sJhqyZiVDVUKMh1k_d2r1dRd3r21fugFQC0UL8Drfewh_wTyyQvLpCeBnrYSZAGI0SasUQLLyYOH5TjaJ9u-zERTRYhuXUw_wecYPsaRWQ4-hGaS4Fef1cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:GqZxY_zTL3vqvyRgYZC_kSGrofLTG3OaGu3sp5x6FLY2m-OG8V05TA>
    <xmx:GqZxY6RuZZwvEUjIVE-FwDUnlKbx-YhchIil56LXtCZsoWC_Y86JOw>
    <xmx:GqZxYyYQrnAJCJCd5RG6pDafDAkmN336MZqKHz0JbtqMKbSXxneysQ>
    <xmx:GqZxYxJr0by9ZqBo1mWj6RPElDbmaqB2vXy7V2IL9LNoaxI1SKAQlA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 21:21:13 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/8] phy: allwinner: phy-sun6i-mipi-dphy: Add the A100 DPHY
Date:   Sun, 13 Nov 2022 20:21:05 -0600
Message-Id: <20221114022113.31694-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the updated DPHY found in a couple of
recent Allwinner SoCs. The first three patches fix an omission in the
existing binding. The remaining patches add the new hardware variant.

Changes in v2:
 - Add the interrupts property to the binding example
 - Drop the inappropriate Fixes tags
 - Rename "supports_rx" to "rx_supported"
 - Add a blank line for readability

Samuel Holland (8):
  dt-bindings: sun6i-a31-mipi-dphy: Add the interrupts property
  ARM: dts: sun8i: a33: Add DPHY interrupt
  arm64: dts: allwinner: a64: Add DPHY interrupt
  dt-bindings: sun6i-a31-mipi-dphy: Add the A100 DPHY variant
  phy: allwinner: phy-sun6i-mipi-dphy: Make RX support optional
  phy: allwinner: phy-sun6i-mipi-dphy: Set the enable bit last
  phy: allwinner: phy-sun6i-mipi-dphy: Add a variant power-on hook
  phy: allwinner: phy-sun6i-mipi-dphy: Add the A100 DPHY variant

 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml    |  11 +
 arch/arm/boot/dts/sun8i-a33.dtsi              |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   1 +
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c   | 236 +++++++++++++++---
 4 files changed, 218 insertions(+), 31 deletions(-)

-- 
2.37.3

