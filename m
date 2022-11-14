Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A826627484
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiKNCV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiKNCVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:21:23 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7C3FAD2;
        Sun, 13 Nov 2022 18:21:22 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AAB7C320091D;
        Sun, 13 Nov 2022 21:21:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 13 Nov 2022 21:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668392480; x=1668478880; bh=um
        olr3krKDreOXkBCRZ2ECU8DgIaOFUrAbwdoxr5jYk=; b=hag55g1tUE4L+mclEK
        dlPwOqw7GtDUBcPb1uLPdd3jtsG2dbVhWYh6YsCKgfwHuIOurjU4HnzokYfBjGEa
        v4M3ugVEmku+ppkvrJN6o0C25KSyQMHCExkPPmJGkbTUcnbSbovTMcw8VB5TptcG
        a1tP6uV0gyEH+M7xF+fCKgANDmnmUK4n8YoFJlU4F0VDnSsA+W8c5EnUL+JNogzr
        wGQql5f/5YrbgiYhPOukAEa1s/jvckQDfQ0yUbypd5oGYOn/U37oEkwwUVdmAiJq
        i3GktiZm+7ZwX8FUGqJTV5VkdSuGflm2uHCpc8S43PpkSo4o0qMM8bryNjr5CtZ1
        uzHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668392480; x=1668478880; bh=umolr3krKDreO
        XkBCRZ2ECU8DgIaOFUrAbwdoxr5jYk=; b=rocms4d2lCJfpHIoSs8dzXri6ofgM
        aafnZghvkK3AcRg2XftkOYC40gRtbDYwlO55E5PfA3+Bwb0YLNV+iafmsYMag8pP
        K/iAs7fskFmauoWyi8CJpfS0sBwhiMk45cd41aPGHSLeWl1coIDVe+kCwcWSaiYq
        ZS8IuC0nkRXuzlqDUbp3WbH6nHxmsiXnzhDwImS8PNhePOX3COCB8VxTos4QKnV/
        eW0GxgfOiX9uh0L3tpRhwPsz+tFZLjb7GD40GGhdeygJtyQIFW/GYQf9ThQfWiwe
        2QU/6zjKHgSOd9Og8msCHd+Wr3JvOIjlXumFtq03ZDMK1UKijKPjdLM/g==
X-ME-Sender: <xms:IKZxY6BFcPQsO5jhSkLfotBCCpwA0pdlJ4J8CSOcIYLxnt7wivbXiQ>
    <xme:IKZxY0iB0SldyHQ0WFoUiALhiSUdZ8p_rmPoQls6gyRYD6R7z87Kzoi2NlWD225fV
    4ww4px5GYMeJ2quQA>
X-ME-Received: <xmr:IKZxY9kTG57-wyvIz23Z4TkiTNIk5II6L6HGSVvhWF0YEnrtRR3CT8obMcbvCUoDCGfm-m6y5wlhFt6HsiofRzofgbpz8JTzVSDsE383DJJeF3-SYhHjzyJISgwaY906ZyT9nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:IKZxY4zVS2Q663KYuzxMsGxMjDSQMtB-8FoaYkYlOSMVEaDLG1KOXw>
    <xmx:IKZxY_R4eVd2RNgLxxT5xJIte7bjbliZAHA54KuFw6ZQy_gDHqUUDA>
    <xmx:IKZxYzZUOvtyvxvRq8WB9nt-5-iReo13QFyA2o4Arrh7aRSE1l3hJw>
    <xmx:IKZxY-IZPSvx6GZhuDT2nVHj-L5H5TWZXoas-pYFbfdZNevwSLgwCQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Nov 2022 21:21:19 -0500 (EST)
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
Subject: [PATCH v2 2/8] ARM: dts: sun8i: a33: Add DPHY interrupt
Date:   Sun, 13 Nov 2022 20:21:07 -0600
Message-Id: <20221114022113.31694-3-samuel@sholland.org>
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

The DPHY has an interrupt line which is shared with the DSI controller.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 arch/arm/boot/dts/sun8i-a33.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index b3d1bdfb5118..30fdd2703b1f 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -278,6 +278,7 @@ dsi_in_tcon0: endpoint {
 		dphy: d-phy@1ca1000 {
 			compatible = "allwinner,sun6i-a31-mipi-dphy";
 			reg = <0x01ca1000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_MIPI_DSI>,
 				 <&ccu CLK_DSI_DPHY>;
 			clock-names = "bus", "mod";
-- 
2.37.3

