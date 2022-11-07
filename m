Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336B161EA75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKGFc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKGFcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:32:53 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64755FAF4;
        Sun,  6 Nov 2022 21:32:52 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C0A215C0097;
        Mon,  7 Nov 2022 00:32:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Nov 2022 00:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1667799171; x=1667885571; bh=JY
        akY2qIENbEGtAlpSn1HIxk/DMOaz61CNK4NIgSOWM=; b=JiwHq9SLt7hwYEbGnL
        rMLVn060GNr/PqIaVQw1jLrHN2GR5KCz8aB6kNPxkNQhllzJELYBAbygS4g1pBAh
        YBYK/P0PTX1SbDikJozxIisyTV5bXWmmYmxhg+USzIN3IDnPWcCnHmQhaQZJztRu
        rz+hqMJxg7rzyFL2zaORui2Dlzu+3MMQbbdnpKrvS25P6SHq6b63q5U6QTrXLZ92
        Q0isclVE0OOflA1Y0vF2ijgDI4eOeBCkvZZvY5wCiAwOzMUywe4iW4t9C8THO5Q1
        9WFwtuMRCUIpyVld/8K20Pm8owHpIZDxoUv8FrQyOFLiFI3XOxJ6eVUic/DCwJXv
        h0kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667799171; x=1667885571; bh=JYakY2qIENbEG
        tAlpSn1HIxk/DMOaz61CNK4NIgSOWM=; b=UOhFY3cP4Thc0H/8dx2byeww8WXnO
        ORVRK2F4JoSKTRSgbTQ8HlOs1YbWTht1gBEvHqe/hTRInJbr5FlzHdLaa1VtOHxW
        2ZJSlqdnMS1lTpBephvayDztv8lg2/DtoW4tRUwxHLSm4GXWgrHkBWFRDkgMpvqf
        c19n7inc1wsq0UhH2psiGsl4gnLWjXrxmwPbdCXJufmS/0okuz18fVAMtW8MeDjc
        0hPS7oa8+CAMzV6Z+xjvggsRAS4/Fa40T9Njkpp3sNmNqpJksqWeSCRQx43Q4D2Q
        oFkJcWFwkCoIzw+0XBZFXgkF5zXad0r0EjmO0rRRB/0Bvbw5NRl5od+Lg==
X-ME-Sender: <xms:g5hoY0lcKTccTOI_i4uFUCyMUiptVm9_8UGrcYrIrFXYO_LHNc4Yjg>
    <xme:g5hoYz39x05i_IOG9g4n900K8ADVnOd7mNLbHrl7TGn93BHTTyWTpjl80VzliHY_N
    vpslccg9cBRnhi1UQ>
X-ME-Received: <xmr:g5hoYyr5R4pD_KeD3vsJJon63qoWbhsFq0e8VzC2kEH0frHEvbYrX1EWVrWXeVJ3P7kQCTXfLmDtWVRXqME7VYED95c1ncBmfflnLOQaioOOlGWZsDAku-DJFEzF5uR8BON1gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdejgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:g5hoYwk_HO4kU6FEWFbsBV9lKgfLEBzwI_HIkAOwTlry7AKN7E0cAg>
    <xmx:g5hoYy2xOOkhadHjn04dvfRMa9KMerXdB6fGSJAn1QTUKwqsdwy1lA>
    <xmx:g5hoY3t6tBhl4TrwHeetw7-Ra_SNjfO4vOuKaiQ7QQF8QNPHTnMNhQ>
    <xmx:g5hoY7lQzyIMiu8vOm17oPQ2732gWaqgfBlDO5AMJnj9ezaSeE7aeQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 00:32:51 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v6 3/5] arm64: dts: allwinner: a100: Add LED controller node
Date:   Sun,  6 Nov 2022 23:32:44 -0600
Message-Id: <20221107053247.1180-4-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107053247.1180-1-samuel@sholland.org>
References: <20221107053247.1180-1-samuel@sholland.org>
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

Allwinner A100 contains an LED controller. Add it to the devicetree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v5)

Changes in v5:
 - New patch for v5

 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index 97e3e6907acd..2c90683145f2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -273,6 +273,20 @@ i2c3: i2c@5002c00 {
 			#size-cells = <0>;
 		};
 
+		ledc: led-controller@5018000 {
+			compatible = "allwinner,sun50i-a100-ledc";
+			reg = <0x5018000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LEDC>, <&ccu CLK_LEDC>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_LEDC>;
+			dmas = <&dma 42>;
+			dma-names = "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		ths: thermal-sensor@5070400 {
 			compatible = "allwinner,sun50i-a100-ths";
 			reg = <0x05070400 0x100>;
-- 
2.37.3

