Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0905BA5DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIPE2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIPE14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:27:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D387DF6F;
        Thu, 15 Sep 2022 21:27:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 654335C021B;
        Fri, 16 Sep 2022 00:27:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 16 Sep 2022 00:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663302475; x=1663388875; bh=Di
        L2PG2GPLYyviQvFsfljqZCMe4E9U/861rwG5Z393w=; b=MB7zTG8SQEPBaX9Ot2
        tY+J8n7TdmNpnL0bMVPP6DelmfZAiyxOh2qVyvwJ1kwxMI6s1thRylaissHVz6FC
        3iDYypwTg/uCxlNl7maMRnpr5p9szPOXMT24aF+bZ4hLujFIQn0TbHruNTOAneCQ
        nvRWgbxn72FDauaobaZfwSRn8p27ap1j2EWo3pWTTjybH6t2OKD2ArxUnWpAnJJG
        ynZlFfYbcoiW01u5GWXfAVV+5pDmPyVtLicie00tcGhC7Feb2N8s1Nccm8k1a6u+
        Kn9RnXXxVPGd1A5qJYD4J+yzqh2bZGvnrVZaHbsYVoo1aeIT+5oqDmscia/R3ZKk
        bvVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663302475; x=1663388875; bh=DiL2PG2GPLYyv
        iQvFsfljqZCMe4E9U/861rwG5Z393w=; b=AtM5RRrFTK1SCq1ILeiSqYx4Icenk
        XXWdIiKJaaK0j6mDjrR8NEduxZjyA3XZrOkUI0DNspOUUs8DNl80dQzGn8RCG1Jl
        Jew7y4d2QmS47w20Pycn1vdFyRKjR8yLU+dGs9c27tyAAy4yN2kt4nBjQpoYXOi3
        N4yNBGX1aKrOKrPWIIR+ADJWT7z+uAvBAC5s0zrv53Gg/W1CiWc0UTsJx34SelAU
        G7Fotm/1wbUSIy+5G/LMD0wDfvgriyKKEN8v5gBS6zbNMQ1rHcWyNgrGh1u8z7ZH
        iYZpP8o0NZ1invbK4fnSLvuqz4+zrKR3akkN9wbzSJY2/avPTt1IRQGRA==
X-ME-Sender: <xms:S_sjY4vU5OGKTw32h0ewbnhlvwUbGth0orQmlguh1qZnXj5bNjwoqA>
    <xme:S_sjY1d9fYd5WFxpB5kZiH6V48BoNIaoBZvLassyC903utEPHZdtXk238yD2Zlgfz
    e9gmvtmbiOOJm0auw>
X-ME-Received: <xmr:S_sjYzzgnmTn96Z9sl_8gwjW78WhAQk3DCqQ48WTKqHlV6hiRXs5OaGAqud9p5t1RaRvlrOEL-W3eNs4jVPAK5ct-YzhN5BiEa5IQxy0LVGjYiGGZlD11vN9w8IlGiVUBJ-7ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:S_sjY7PNTpmJ5CMRh9uL0I-Sju2J_hlsfbh9TPs2CbR73KgyPvNcCA>
    <xmx:S_sjY48rpCoBPiIOPcK-gXR6roWPjwnnOE_rIDF-Y_YIFgfDy0WocA>
    <xmx:S_sjYzWiw1GIKNd3t06gkKlkL-LBaGo2Ig_s1EvahLXoAMM1Frg4sg>
    <xmx:S_sjY1MLrb8U5d9eEaYwSMlcBmblnrL55clnprOindw6Tksv3mr1Vg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 00:27:54 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 2/2] ARM: dts: axp22x/axp809: Add GPIO controller nodes
Date:   Thu, 15 Sep 2022 23:27:51 -0500
Message-Id: <20220916042751.47906-3-samuel@sholland.org>
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

These PMICs all contain a GPIO controller. Now that the binding for this
variant is documented, wire up the controller in the device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Remove "ldo" pinctrl children from new nodes

 arch/arm/boot/dts/axp22x.dtsi | 6 ++++++
 arch/arm/boot/dts/axp809.dtsi | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index a020c12b2884..f79650afd0a7 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -67,6 +67,12 @@ battery_power_supply: battery-power {
 		status = "disabled";
 	};
 
+	axp_gpio: gpio {
+		compatible = "x-powers,axp221-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
diff --git a/arch/arm/boot/dts/axp809.dtsi b/arch/arm/boot/dts/axp809.dtsi
index ab8e5f2d9246..d134d4c00bd8 100644
--- a/arch/arm/boot/dts/axp809.dtsi
+++ b/arch/arm/boot/dts/axp809.dtsi
@@ -50,4 +50,11 @@ &axp809 {
 	compatible = "x-powers,axp809";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp809-gpio",
+			     "x-powers,axp221-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
2.35.1

