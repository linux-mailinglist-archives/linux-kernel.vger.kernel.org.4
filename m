Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA56259BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiKKLsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKKLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:48:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B45E0BB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:48:15 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1otSW4-0002UZ-Ln; Fri, 11 Nov 2022 12:48:12 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1otSW3-0007NZ-UL; Fri, 11 Nov 2022 12:48:11 +0100
Date:   Fri, 11 Nov 2022 12:48:11 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to
 support wifi
Message-ID: <20221111114811.mvsjlfggxmdrhsep@pengutronix.de>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
 <20221111032811.2456916-13-peng.fan@oss.nxp.com>
 <20221111090232.6ibqzoivfqsndhxg@pengutronix.de>
 <DU0PR04MB94177ED8966506D445CFBA5688009@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <AS8PR04MB8404426EC83A75A3058F774192009@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <20221111093002.dpp73hkef6ihkduk@pengutronix.de>
 <AS8PR04MB8404B33905D685F820A6F07D92009@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8404B33905D685F820A6F07D92009@AS8PR04MB8404.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-11, Sherry Sun wrote:
> 
> 
> > -----Original Message-----
> > From: Marco Felsch <m.felsch@pengutronix.de>
> > Sent: 2022年11月11日 17:30
> > To: Sherry Sun <sherry.sun@nxp.com>
> > Cc: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS)
> > <peng.fan@oss.nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > linux-kernel@vger.kernel.org; kernel@pengutronix.de; festevam@gmail.com;
> > linux-arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to
> > support wifi
> > 
> > On 22-11-11, Sherry Sun wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > > Sent: 2022年11月11日 17:08
> > > > To: Marco Felsch <m.felsch@pengutronix.de>; Peng Fan (OSS)
> > > > <peng.fan@oss.nxp.com>
> > > > Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; linux-
> > > > kernel@vger.kernel.org; Sherry Sun <sherry.sun@nxp.com>;
> > > > kernel@pengutronix.de; festevam@gmail.com; linux-arm-
> > > > kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>
> > > > Subject: RE: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1
> > > > to support wifi
> > > >
> > > > Sherry,
> > > >
> > > > > Subject: Re: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable
> > > > > usdhc1 to support wifi
> > > > >
> > > > > Hi Peng,
> > > > >
> > > > > On 22-11-11, Peng Fan (OSS) wrote:
> > > > > > From: Sherry Sun <sherry.sun@nxp.com>
> > > > > >
> > > > > > Enable usdhc1 which is used for wifi.
> > > > > >
> > > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 27
> > > > > > +++++++++++++ arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |
> > 39
> > > > > +++++++++++++++++++
> > > > > >  2 files changed, 66 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > > > > index a2b24d4d4e3e..7b80f144327d 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> > > > > > @@ -15,6 +15,13 @@ / {
> > > > > >  	aliases {
> > > > > >  		spi0 = &flexspi;
> > > > > >  	};
> > > > > > +
> > > > > > +	usdhc1_pwrseq: usdhc1_pwrseq {
> > > > > > +		compatible = "mmc-pwrseq-simple";
> > > > > > +		pinctrl-names = "default";
> > > > > > +		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
> > > > > > +		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> > > > > > +	};
> > > > > >  };
> > > > > >
> > > > > >  &ddrc {
> > > > > > @@ -53,6 +60,19 @@ flash@0 {
> > > > > >  	};
> > > > > >  };
> > > > > >
> > > > > > +&usdhc1 {
> > > > > > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > > > > > +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
> > > > > > +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
> > > > > > +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
> > > > > > +	bus-width = <4>;
> > > > > > +	keep-power-in-suspend;
> > > > > > +	mmc-pwrseq = <&usdhc1_pwrseq>;
> > > > > > +	non-removable;
> > > > > > +	wakeup-source;
> > > > > > +	status = "okay";
> > > > > > +};
> > > > > > +
> > > > > >  &usdhc3 {
> > > > > >  	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
> > > > > >  	assigned-clock-rates = <400000000>; @@ -125,4 +145,11 @@
> > > > > > MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7
> > > > > 0x1d6
> > > > > >  			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE
> > > > > 0x196
> > > > > >  		>;
> > > > > >  	};
> > > > > > +
> > > > > > +	pinctrl_wlan: wlangrp {
> > > > > > +		fsl,pins = <
> > > > > > +
> > > > > 	MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K
> > > > > 	0x141
> > > > > > +			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9
> > > > > 	0x159
> > > > > > +		>;
> > > > > > +	};
> > > > >
> > > > > Out of curiousity, this is not shareable with the other ddr4 evk?
> > > > [Peng Fan]
> > > >
> > > > Could you please help answer?
> > > >
> > >
> > > Hi Peng, I suggest to remove the pinctrl_wlan configure here, it should be
> > added along with the wifi wowlan subnode later.
> > 
> > Does this apply to the imx8mn-evk patch as well?
> > 
> > Also if the usdhc1 is used only for WLAN and this patch series don't add the
> > WLAN subnode, we could remove this patch and the imx8mn-evk usdhc1
> > patch completely till you have a complete patchset adding the full WLAN
> > support.
> > 
> 
> Hi Marco, actually here enable usdhc1 can support the wifi basic
> function, so this patch is ok to enable wifi on 8mm, same for 8mn.

Okay, thanks for the clarification.

> But pinctrl_wlan is used to support the out-of-band WoWLAN feature,
> needs to be used with wifi child dts node, which looks like the
> following code.
> 
> So I suggest to add the pinctrl_wlan along with the wifi_wake_host
> child node later to support the wifi WoWLAN function. Here only need
> to enable the usdhc1 to support wifi basic function, no need to add
> pinctrl_wlan.

+1 from my side. @Peng can you drop the pinctrl_wlan from this patch and
from the mx8mn patch as well?

Regards,
  Marco

> &usdhc1 {
>     pinctrl-names = "default", "state_100mhz", "state_200mhz";
>     pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
>     pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
>     pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
>     bus-width = <4>;
>     keep-power-in-suspend;
>     non-removable;
>     wakeup-source;
>     mmc-pwrseq = <&usdhc1_pwrseq>;
>     status = "okay";
> 
>     wifi_wake_host {
>         compatible = "nxp,wifi-wake-host";
>         interrupt-parent = <&gpio2>;
>         interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
>         interrupt-names = "host-wake";
>     };
> };
> 
> Best Regards
> Sherry
