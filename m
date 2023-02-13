Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F73B695123
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjBMT42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBMT40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:56:26 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D788C1CAD3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:56:25 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pRevy-0005N8-Qi; Mon, 13 Feb 2023 20:56:18 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pRevx-0002IA-Kb; Mon, 13 Feb 2023 20:56:17 +0100
Date:   Mon, 13 Feb 2023 20:56:17 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Marek Vasut <marex@denx.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Message-ID: <20230213195617.xndagbarc3k5kegr@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-7-frieder@fris.de>
 <20230213161548.ucaqpza65byyqvfo@pengutronix.de>
 <eef49a1c-4dc3-7517-c760-ecc20704f943@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef49a1c-4dc3-7517-c760-ecc20704f943@denx.de>
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

Hi Marek, Frieder,

On 23-02-13, Marek Vasut wrote:
> On 2/13/23 17:15, Marco Felsch wrote:
> 
> [...]
> 
> > > @@ -347,7 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
> > >   			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
> > >   			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
> > >   			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
> > > -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
> > > +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
> > 
> > The VSELECT pin should be driven by the (u)sdhc core...
> > 
> > >   		>;
> > >   	};
> > >   };
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
> > > index 5172883717d1..90daaf54e704 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
> > > @@ -196,6 +196,7 @@ reg_nvcc_sd: LDO5 {
> > >   				regulator-name = "NVCC_SD (LDO5)";
> > >   				regulator-min-microvolt = <1800000>;
> > >   				regulator-max-microvolt = <3300000>;
> > > +				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> > 
> > and by using the sd-vsel-gpios property the IOMUXC_GPIO1_IO04 have to be
> > muxed as GPIO, which is not the case. So I think that u-boot have a bug
> > within the (u)sdhc core.
> 
> The trick here is that the VSELECT is operated by the usdhc block as a
> function pin, but the PMIC driver can read the current state of the VSELECT
> pin by reading out the GPIO block SR register. Since the IOMUX SION bit is
> set on the VSELECT pin, the state of the pin is reflected in the GPIO block
> SR register even if the pin is muxed as function pin.
> 

Thanks for this explanation :) Why does the regulator driver need to
know the current state of this pin? Since the voltage switching requires
some cmd's before the actual voltage level switch. So this must be
handled within the core.

Also after checking the driver, adding the sd-vsel-gpios will request
the specified gpio as output-high. Out of curiosity, what's the bug you
triggering within U-Boot?

Regards,
  Marco
