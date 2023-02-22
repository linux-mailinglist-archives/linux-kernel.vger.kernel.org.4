Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8D69FBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjBVTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBVTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:03:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F99E055
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:02:59 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pUuO8-0003LX-IK; Wed, 22 Feb 2023 20:02:48 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pUuO6-0007Pj-P2; Wed, 22 Feb 2023 20:02:46 +0100
Date:   Wed, 22 Feb 2023 20:02:46 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add sound card
Message-ID: <20230222190246.ihknh2tgjb2w3qmf@pengutronix.de>
References: <20230222182252.2ad6d82b@booty>
 <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
 <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
 <10394cf6-70f0-638a-15d3-5a14615dad44@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10394cf6-70f0-638a-15d3-5a14615dad44@denx.de>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-22, Marek Vasut wrote:
> On 2/22/23 18:59, Marco Felsch wrote:
> > Hi Luca,
> > 
> > On 23-02-22, Luca Ceresoli wrote:
> > > The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
> > > NXPP SGTL5000 audio codec connected to I2S-0 (sai2).
> > > 
> > > This requires to:
> > > 
> > >   * add the power supplies (always on)
> > >   * enable sai2 with pinmuxes
> > >   * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
> > >     IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate
> > > 
> > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > ---
> > >   .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 60 +++++++++++++++++++
> > >   1 file changed, 60 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> > > index 470ff8e31e32..894d9809f76d 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> > > @@ -14,6 +14,57 @@ / {
> > >   	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
> > >   		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
> > >   		     "fsl,imx8mp";
> > 
> > ...
> > 
> > > +/* I2S-0 = sai2 */
> > > +&sai2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_sai2>;
> > > +
> > > +	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
> > > +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> > > +	assigned-clock-rates = <12288000>;
> > > +
> > > +	fsl,sai-mclk-direction-output;
> > > +	status = "okay";
> > >   };
> > 
> > Do you have some downstream patches for the sai interfaces? AFAIR Marek
> > worked on this but the patches are not mainlien yet.
> 
> I guess it is time to resubmit these.

I would have two patches for your series first is necessary the other is
changing the sound-card to make use of the simple-audio-card.

Regards,
  Marco

8<-----------------------------------------------------------------------------------------
[1]

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index 2d5d8255c7fa2..32eb29ae8f71f 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -18,7 +18,7 @@
 
 #define CLKEN0                 0x000
 #define CLKEN1                 0x004
-#define SAI_MCLK_SEL(n)                (300 + 4 * (n)) /* n in 0..5 */
+#define SAI_MCLK_SEL(n)                (0x300 + 4 * (n))       /* n in 0..5 */
 #define PDM_SEL                        0x318
 #define SAI_PLL_GNRL_CTL       0x400

8<-----------------------------------------------------------------------------------------
[2]

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 8547391d9cbbf..3b38ec7bb47be 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -47,7 +47,6 @@ reg_audio_pwr: regulator-audio-pwr {
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 	};
 
 	reg_can1_stby: regulator-can1-stby {
@@ -94,21 +93,34 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
-	sound-wm8960 {
-		compatible = "fsl,imx-audio-wm8960";
-		model = "wm8960-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&codec>;
-		audio-routing =
+	sound-wm8524 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8960-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Speaker", "External Speaker",
+			"Microphone", "Mic Jack";
+		simple-audio-card,routing =
 			"Headphone Jack", "HP_L",
 			"Headphone Jack", "HP_R",
-			"Ext Spk", "SPK_LP",
-			"Ext Spk", "SPK_LN",
-			"Ext Spk", "SPK_RP",
-			"Ext Spk", "SPK_RN",
+			"External Speaker", "SPK_LP",
+			"External Speaker", "SPK_LN",
+			"External Speaker", "SPK_RP",
+			"External Speaker", "SPK_RN",
 			"LINPUT1", "Mic Jack",
 			"LINPUT3", "Mic Jack",
 			"Mic Jack", "MICB";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8960>;
+		};
 	};
 };
 
@@ -364,7 +376,7 @@ &i2c3 {
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
-	codec: wm8960@1a {
+	wm8960: codec@1a {
 		compatible = "wlf,wm8960";
 		reg = <0x1a>;
 		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
@@ -373,6 +385,7 @@ codec: wm8960@1a {
 		wlf,hp-cfg = <3 2 3>;
 		wlf,gpio-cfg = <1 3>;
 		SPKVDD1-supply = <&reg_audio_pwr>;
+		#sound-dai-cells = <0>;
 	};
 
 	pca6416: gpio@20 {
8<-----------------------------------------------------------------------------------------
