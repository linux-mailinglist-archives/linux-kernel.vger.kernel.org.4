Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4336562748D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbiKNCWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbiKNCVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:21:39 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704BDF3A;
        Sun, 13 Nov 2022 18:21:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 43F303200914;
        Sun, 13 Nov 2022 21:21:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Nov 2022 21:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668392490; x=1668478890; bh=Pe
        5+rxKJXBwbi3S5z0eDboZk1Gy4CrOI9srKQdU3gkc=; b=gvSnK23KlZhlQgj8By
        bFNa5ZFb8CgAhfh6C5eUE9LhBcthyducRab3pHtEmaF6z6z3sxZAJh+lQDRQOKwf
        XHHLGLe7dFVj7ZRkVn8tWwVkj8jtp0Y/3Pf0z/ZOgr+fGgh7At418Nfb0YBVoHF0
        3XUEqvURAhgpykh8iymFOZjOplbjjl6K31xUf1MShd2lcX2m4z0YgQxAGOkW5WHb
        0q3j6hOFTsa/OwnEr1y9lsKfLdC6rDvJg5z52P8kt82AZVv5ny2E8kclNUjEBlAm
        A3SgUvzaWn8WlLzYR1z3nj0phh62g+iIQXQlc6THGwgROHiPtAqcub8gNLsf/JVz
        N+0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668392490; x=1668478890; bh=Pe5+rxKJXBwbi
        3S5z0eDboZk1Gy4CrOI9srKQdU3gkc=; b=L3EOj7g2AClJ7LrMgV9z2rmaQ21rd
        cCWp4xVKqqPcqr0R+mMehllu13Df3hTOjCheC1YjdGrndbr866v8TO1NaQZA0p1K
        Yp3g6XzjjS3whKM6vBpjp1DXhRhJMPvM9etPTEujCDc8mVy82Da8P5WgZIb12eEZ
        hvtxknCb/SMUjB5n4jNZY88Mfm5F81n2JHac3X8IG7/ZYtUCg6SrQdRIDjVazy3s
        2OpsLxAKFnYrIOGduDKmE6HNcIMffpTx2/ceYjJLYq27t3KbmIMdtkH4C0qcupe3
        1Sw+MWRGxXT/jqZW1ZfaFet75OE1Ukb1P2tKCyhT9mppfCzy2yFNF96Ug==
X-ME-Sender: <xms:KqZxY66mDuNN4d_aq74DyPUjzqcLSV8X3-M_WCF231SV3rINnyCl1g>
    <xme:KqZxYz5oW6s56d4xaDtQ1gCxCvEZAqWdif8s4F-_an6yxZZypQroxbPgwRUY-4CIX
    _OXMSYd_ctOYJx4UA>
X-ME-Received: <xmr:KqZxY5duG-p7IQYwrAAMjtybPGx-UqhBO_LRhO7he8hkjM5474WPIyaCsfmePgOkhvpcsk6-NVJfug9-mv-xbjzhzObB_faqrywXZoECxeB4ni9nis4pp_yq3mjE3S8qZoM4iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:KqZxY3IsIX2dPzWHwknM9qqu8Kf-Ko3TLyMG3_RZiVXmixNwBZVVpw>
    <xmx:KqZxY-Icaib7DQzmS-HMs2B25RpCY7KNXmmKStYxnqNvK89ZNeZcVA>
    <xmx:KqZxY4z0X84Rp8_MAp67EKR6jsJJ11vgd0NSEhPYKxlUkuS2da4ONA>
    <xmx:KqZxYwAG4zbcI6YsLIzsd_-F_6ThAdWxdz_6J-gkH-XA4dPEqlHL4w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 21:21:30 -0500 (EST)
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
Subject: [PATCH v2 6/8] phy: allwinner: phy-sun6i-mipi-dphy: Set the enable bit last
Date:   Sun, 13 Nov 2022 20:21:11 -0600
Message-Id: <20221114022113.31694-7-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221114022113.31694-1-samuel@sholland.org>
References: <20221114022113.31694-1-samuel@sholland.org>
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

The A100 variant of the DPHY requires configuring the analog registers
before setting the global enable bit. Since this order also works on the
other variants, always use it, to minimize the differences between them.

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 7d7322670a83..a2afedc399fd 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -183,10 +183,6 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
 		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
 
-	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
-		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
-		     SUN6I_DPHY_GCTL_EN);
-
 	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
 		     SUN6I_DPHY_ANA0_REG_PWS |
 		     SUN6I_DPHY_ANA0_REG_DMPC |
@@ -244,6 +240,10 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 			   SUN6I_DPHY_ANA2_EN_P2S_CPU_MASK,
 			   SUN6I_DPHY_ANA2_EN_P2S_CPU(lanes_mask));
 
+	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
+		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
+		     SUN6I_DPHY_GCTL_EN);
+
 	return 0;
 }
 
-- 
2.37.3

