Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101596A1C86
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjBXM4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjBXM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:56:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A9361EFE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:56:44 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pVXcn-0007AP-Vw; Fri, 24 Feb 2023 13:56:33 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pVXcm-0005Zq-2j; Fri, 24 Feb 2023 13:56:32 +0100
Date:   Fri, 24 Feb 2023 13:56:32 +0100
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
Message-ID: <20230224125632.eokbmb4wchxuny4s@pengutronix.de>
References: <20230222182252.2ad6d82b@booty>
 <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
 <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
 <10394cf6-70f0-638a-15d3-5a14615dad44@denx.de>
 <20230222190246.ihknh2tgjb2w3qmf@pengutronix.de>
 <63cbfbaf-7405-eaec-9681-36fc3792e637@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cbfbaf-7405-eaec-9681-36fc3792e637@denx.de>
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

On 23-02-23, Marek Vasut wrote:
> On 2/22/23 20:02, Marco Felsch wrote:
> 
> Hi,
> 
> [...]
> 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > index 8547391d9cbbf..3b38ec7bb47be 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> > @@ -47,7 +47,6 @@ reg_audio_pwr: regulator-audio-pwr {
> >   		regulator-max-microvolt = <3300000>;
> >   		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> >   		enable-active-high;
> > -		regulator-always-on;
> >   	};
> >   	reg_can1_stby: regulator-can1-stby {
> > @@ -94,21 +93,34 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >   		enable-active-high;
> >   	};
> > -	sound-wm8960 {
> > -		compatible = "fsl,imx-audio-wm8960";
> > -		model = "wm8960-audio";
> > -		audio-cpu = <&sai3>;
> > -		audio-codec = <&codec>;
> > -		audio-routing =
> > +	sound-wm8524 {
> 
> Why WM8524 ? The MX8MP EVK I have here is populated with WM8960 chip and
> with single headphone jack, are you sure the below is correct ?

Argh.. the name was copied from 8MM evk dts but the below setup is
working, at least the audio-outpath. Didn't tested the mic path.

Regards,
  Marco
