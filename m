Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAED16A3DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjB0JKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjB0JKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:10:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE3C234F2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:02:11 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWZ0v-0002GW-0V; Mon, 27 Feb 2023 09:37:41 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWZ0t-0004O0-Tx; Mon, 27 Feb 2023 09:37:39 +0100
Date:   Mon, 27 Feb 2023 09:37:39 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM64: dts: debix model-a: enable hdmi
Message-ID: <20230227083739.fxcw2nrkeuuimk26@pengutronix.de>
References: <MA0PR01MB7145D1E9382C7F91197B259FFFA99@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
 <af766b65-ae00-e2e9-09f9-9ddf6d9d5e21@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af766b65-ae00-e2e9-09f9-9ddf6d9d5e21@linaro.org>
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

Hi,

thanks for your patch, please see my comments below.

On 23-02-25, Krzysztof Kozlowski wrote:
> On 25/02/2023 15:25, Hardevsinh Palaniya wrote:
> > From: HardevSinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> > Date: Sat, 25 Feb 2023 19:38:20 +0530
> > Subject: [PATCH] arm64: dts: debix model-a: enable hdmi
> 
> Your patch is corrupted... See above.
> 
> > 
> > Enable HDMI support for Polyhex Debix Model A Board
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
> 
> > 
> > Signed-off-by: HardevSinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > index 2876d18f2a38..bc2515113ae3 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > @@ -45,6 +45,43 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >  	};
> >  };
> >  
> > +
> 
> No need for two blank lines, but one.
> 
> 
> > +&irqsteer_hdmi {
> > +	status = "okay";
> > +};
> > +
> > +&hdmi_blk_ctrl {
> > +	status = "okay";
> > +};
> > +
> > +&hdmi_pavi {
> > +	status = "okay";
> > +};
> > +
> > +&hdmi {
> > +	status = "okay";
> > +};
> > +
> > +&hdmiphy {
> > +	status = "okay";
> > +};
> > +
> > +&lcdif1 {
> > +	status = "okay";
> > +};
> > +
> > +&lcdif2 {
> > +	status = "okay";
> > +};
> > +
> > +&lcdif3 {
> > +	status = "okay";
> > +
> > +	thres-low  = <1 2>;             /* (FIFO * 1 / 2) */
> > +	thres-high = <3 4>;             /* (FIFO * 3 / 4) */

Isn't this a downstream property?

Regards,
  Marco

> > +};
> > +
> > +
> 
> Same problem.
> 
> >  &A53_0 {
> >  	cpu-supply = <&buck2>;
> >  };
> 
> Best regards,
> Krzysztof
> 
> 
> 
