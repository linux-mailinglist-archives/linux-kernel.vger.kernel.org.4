Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61215BA5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIPE2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIPE14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:27:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ACC90192;
        Thu, 15 Sep 2022 21:27:55 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 70A335C0216;
        Fri, 16 Sep 2022 00:27:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 16 Sep 2022 00:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663302474; x=1663388874; bh=Hs
        EeHUxeyjrWeBuU3VZqny77i56V+x03du1DVM7uI8w=; b=brIryO/EcVwIjqFUBL
        smIzOJN05x3U1vMGm6yDn94n6te/A2IkvkNLzmWLHStTaD95qm9cGsGtj0DeyQMs
        jDwV2iCjZ9r8Ge5ZlePd3apRUwiIcP813e4j4MumD6Pe06b4J+Ha44yNdOCGR3qO
        M+Ol/5ItXWL9sYZ/d5okCmb1JXGTFaEDRArXYpJyubo5mz/D6Na+PK/WifflXzND
        kuWnfyUEE9UzjfzP8FCob+2NjIc95uNByLV3RFLj4AcDZVtP3Ed/FqQgvURX7Vzl
        /fYYZTL2RJEjmwJmjocDw6Qiyk2xAhjtBBpoMIorcV/ZOUUHQp1IlgADnAFfF5HH
        Y1lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663302474; x=1663388874; bh=HsEeHUxeyjrWe
        BuU3VZqny77i56V+x03du1DVM7uI8w=; b=eVaRb/oGyl2kcifsoa38TGZsG6VYf
        kZ8yH4JwF0s9VzYbcEyR8tuzpPxYFLibAiHeLPTaIfimFtwST8GHND0kue+CHssL
        gejfibC81ReGsw7vhBa3l0cZ68qm5Su5wn01q+ms7Ee5wCbrk9rsa9gyDAfR5anu
        eEWIWxE6bfKjiRWcdXdltS3TVI6a6n+74dFAQDQhb6+orzPYJap3zfLT4Tt3Yqxh
        Rxd9Z7c59Y2Z9ZG7Or9vWqs/rLuYd1ZS3fwrESI+EH5bEd5vAaHuB5Rf1DfRUVTZ
        zOTVwRmE78qUZ9MDSb8EfhN2do3lJTzmHa2XZzDPBwaRGL41FqfzaoUKg==
X-ME-Sender: <xms:SvsjYyonKmvZSzu8qiFwR7wm16D2e4NimjivLKrXdYHafL75z6IINQ>
    <xme:SvsjYwqF0E69ga7FIcR_g3bGMYRUWwEco33Sx2HS5Hbja74KHF1lePGviY-e6e2zl
    RqATe0sntPOsp6oFw>
X-ME-Received: <xmr:SvsjY3P55y6dblYUhy5HYEiXJYl01D3CWaKYEL37rlr2nT6tmuKL8IXSo3GYskJ0aQ5I5WcXZQVuB5RZarhZPmbVEnarB-RbfuryX__Tab4WwVYUSEkTsvMBb_q1ef2QuONk_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:SvsjYx70yVdWwr3_nB3Y2bQgXffm5zbUCmY1BwymZPEsfQgH0iUB_w>
    <xmx:SvsjYx6pOx53sf2XCzNhtlUCCoZtH4lBT2op3l9v8NEb1BmQWWli1Q>
    <xmx:SvsjYxiS5uWyHodVSIsliCpFy3wLl8xXkEguf1_VQlnglKpHuqpnFw>
    <xmx:SvsjY8Zl7Z5l9CPzbFtBz4H9tKggIZmqZeuvnthUtBeip9CdxLxf5g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 00:27:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 1/2] ARM: dts: axp803/axp81x: Drop GPIO LDO pinctrl nodes
Date:   Thu, 15 Sep 2022 23:27:50 -0500
Message-Id: <20220916042751.47906-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916042751.47906-1-samuel@sholland.org>
References: <20220916042751.47906-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ldo-io0" and "ldo-io1" regulators are enabled/disabled by toggling
the pinmux between two functions. This happens in the regulator driver.
Setting the pinmux to "ldo" in the DT is inappropriate because it would
enable the regulator before the driver has a chance to set the correct
initial voltage.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Added patch to remove existing "ldo" pinctrl nodes

 arch/arm/boot/dts/axp81x.dtsi             | 14 --------------
 arch/arm64/boot/dts/allwinner/axp803.dtsi | 10 ----------
 2 files changed, 24 deletions(-)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index b93387b0c1c3..ebaf1c3ce8db 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -62,16 +62,6 @@ axp_gpio: gpio {
 		compatible = "x-powers,axp813-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
-
-		gpio0_ldo: gpio0-ldo-pin {
-			pins = "GPIO0";
-			function = "ldo";
-		};
-
-		gpio1_ldo: gpio1-ldo-pin {
-			pins = "GPIO1";
-			function = "ldo";
-		};
 	};
 
 	battery_power_supply: battery-power {
@@ -144,15 +134,11 @@ reg_fldo3: fldo3 {
 		};
 
 		reg_ldo_io0: ldo-io0 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gpio0_ldo>;
 			/* Disable by default to avoid conflicts with GPIO */
 			status = "disabled";
 		};
 
 		reg_ldo_io1: ldo-io1 {
-			pinctrl-names = "default";
-			pinctrl-0 = <&gpio1_ldo>;
 			/* Disable by default to avoid conflicts with GPIO */
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/dts/allwinner/axp803.dtsi
index 578ef368e2b4..a6b4b87f185d 100644
--- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
+++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
@@ -25,16 +25,6 @@ axp_gpio: gpio {
 		compatible = "x-powers,axp803-gpio", "x-powers,axp813-gpio";
 		gpio-controller;
 		#gpio-cells = <2>;
-
-		gpio0_ldo: gpio0-ldo-pin {
-			pins = "GPIO0";
-			function = "ldo";
-		};
-
-		gpio1_ldo: gpio1-ldo-pin {
-			pins = "GPIO1";
-			function = "ldo";
-		};
 	};
 
 	battery_power_supply: battery-power {
-- 
2.35.1

