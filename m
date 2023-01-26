Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A836C67C481
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 07:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjAZGem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 01:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbjAZGee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 01:34:34 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9947417;
        Wed, 25 Jan 2023 22:34:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id CEC30320092E;
        Thu, 26 Jan 2023 01:34:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 01:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674714869; x=1674801269; bh=Ob
        MekPzegFWo+wBsswL5Mv22V9QXAO26FNLwMRm8iqc=; b=Vm9AXhg0gVaC5/ft9A
        FqTnAa/U1xCK50dU8Gm3sCRQOk8KYtlElCoIwHgM0d6kr2vwE7JWOdNPOOLFsvYK
        7DfYdyof2A2CKJI7o5G9lB5+poXkPXztcL1BB2DHF1NrbCq149QZPSvWylfWdYdt
        fOfZbWtLDHoalO0O+WD8zp6gcFeNzVcBMsVIZiqDWHl5Xuu4jDgFvJp66z/RcAK5
        Psv2esbZNXYOFF48MlI6MkPUhwbbQkW7yUowsUTNA614sJe12P1maRkKOkXokfCj
        YSZ9dBElOVdDCboTywPird8nQqJf2at0InanVkBTKtArBkH0hKhBTAff7TGal777
        RxUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674714869; x=1674801269; bh=ObMekPzegFWo+
        wBsswL5Mv22V9QXAO26FNLwMRm8iqc=; b=CVlFV0P2pFp/0KWpFkP1/4O9AU/kB
        q5Mb8iXB7YSwa7wIVf9X0lboAMO8Klr6ZErON1x+C+7yjGu+XXD/1xeBjtpyRH4H
        Kiv0lceVr2ICtFMSYC2con0Hfgh4II4qmnlOsUazFYNMaGW1DhL8V4ToWi06JRyU
        m9uJWpiQWgT0eE/8X/w76YEL4qWW9ot4lHiS+Ixnhs04ImawUdj428UCRhzjsHyp
        /zdkI3NPrkZbyOmQ+XotzsrSycF1uz3JMvlZiKZZRcKSoZI0JRtv0qdfLHGp/psN
        gAMfbDqMtc3TpVH2SpBLJa08U4neqsLX3MYVeBDsolYqiF4hCOqVZJWOg==
X-ME-Sender: <xms:9R7SY-FrOL0L80cstx81k__ERMc_k5rUmocKJJadgJBOQuRv-iSkYA>
    <xme:9R7SY_UwVBslMhLx-e8N-kD6HykCYw6hEXvmMT98--FdBO9ZWJc1VIa55UaWdNMbA
    uNnpCkX4QPHnUSNZg>
X-ME-Received: <xmr:9R7SY4JOEdaWe3j2XQJjKqIRzX7MctAwUHEW43Df5ZjNyInP4nCTUamF71I3o9soU_y6_l7FQOfH7Qp4zAkohSMXH3Fg1m49B-2pHrdS-H-6A9VmhIzyZE4acfI2SulBw6K7Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:9R7SY4GlohJ68L6sBqAgPx9Jds94MKrFYY6wlGzHp2f0MTyi8iF4SQ>
    <xmx:9R7SY0UiIr26njO3ngbuv-uDVp8OsiG8gcuTB5R1IB8KfwSoYC--Ag>
    <xmx:9R7SY7Mx1SBLoA7C9yYMTI5Z-b94EuchjqR2nacVnDecpDhQRTkICg>
    <xmx:9R7SY1VisV61jvPWcNuzczcmowmBbtBpF5a_0cOsx4aRImkqOlw0vA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 01:34:28 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 3/3] riscv: dts: allwinner: d1: Add power controller node
Date:   Thu, 26 Jan 2023 00:34:19 -0600
Message-Id: <20230126063419.15971-4-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230126063419.15971-1-samuel@sholland.org>
References: <20230126063419.15971-1-samuel@sholland.org>
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

The Allwinner D1 family of SoCs contain a PPU power domain controller
separate from the PRCM. It can power down the video engine and DSP, and
it contains special logic for hardware-assisted CPU idle.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Include a patch adding the device tree node

 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 3723612b1fd8..6fadcee7800f 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -799,6 +799,14 @@ tcon_tv0_out_tcon_top_hdmi: endpoint {
 			};
 		};
 
+		ppu: power-controller@7001000 {
+			compatible = "allwinner,sun20i-d1-ppu";
+			reg = <0x7001000 0x1000>;
+			clocks = <&r_ccu CLK_BUS_R_PPU>;
+			resets = <&r_ccu RST_BUS_R_PPU>;
+			#power-domain-cells = <1>;
+		};
+
 		r_ccu: clock-controller@7010000 {
 			compatible = "allwinner,sun20i-d1-r-ccu";
 			reg = <0x7010000 0x400>;
-- 
2.37.4

