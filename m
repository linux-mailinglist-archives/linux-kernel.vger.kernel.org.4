Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4BF69FC99
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjBVT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjBVT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:58:02 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5295F3589;
        Wed, 22 Feb 2023 11:57:49 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 67E3960009;
        Wed, 22 Feb 2023 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677095868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GyCKi7Gn2sca9/TPHpNzjTIGusAZSY/AcvcFqjKOHg=;
        b=lljQ6PD9Ho5Uzv25Z2J2OZg5LmfKl+mjuFNXp39hjZ/SDdtjuGFtLoa98XT8qAtSctMu2R
        YvjLZasHH1ZmIWA3ZaRfbBVq2RGmiHJzujRomd4L3BSIhAbmGEJlYBFhlYSQoqQVk0LSeq
        CN1Zds6CD+2lBsYBJS/uPfvMlNj98aRBnAFpxeYeoc1BEyXFg7w3BiIeyZ9Z+1Acv8sA+C
        in8wzhDuYzR2HUNd3VZqKTQyGQZqOSK5/u1VEncw+VWPCbCenrunDfUWXKHE17XyV9a6Dv
        eHU6a3+LwH3rvst1nvWlXCPYXQLiShBK0stqXtxvhiOZ3MjvBxK5539v5AaH5g==
Date:   Wed, 22 Feb 2023 20:57:42 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add sound card
Message-ID: <20230222205742.505016e4@booty>
In-Reply-To: <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
References: <20230222182252.2ad6d82b@booty>
        <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
        <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Wed, 22 Feb 2023 18:59:41 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Luca,
> 
> On 23-02-22, Luca Ceresoli wrote:
> > The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
> > NXPP SGTL5000 audio codec connected to I2S-0 (sai2).
> > 
> > This requires to:
> > 
> >  * add the power supplies (always on)
> >  * enable sai2 with pinmuxes
> >  * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
> >    IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> > index 470ff8e31e32..894d9809f76d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
> > @@ -14,6 +14,57 @@ / {
> >  	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
> >  		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
> >  		     "fsl,imx8mp";  
> 
> ...
> 
> > +/* I2S-0 = sai2 */
> > +&sai2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_sai2>;
> > +
> > +	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
> > +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
> > +	assigned-clock-rates = <12288000>;
> > +
> > +	fsl,sai-mclk-direction-output;
> > +	status = "okay";
> >  };  
> 
> Do you have some downstream patches for the sai interfaces? AFAIR Marek
> worked on this but the patches are not mainlien yet.

Right, my patch is based on the v3 series by Marek, and it should be
threaded accordingly
(https://lore.kernel.org/linux-arm-kernel/20230222172552.1545519-1-luca.ceresoli@bootlin.com/),
but I realize I haven't made it 100% clear -- sorry about this.

I guess I should just resend separately with a clarifying cover letter
next time.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
