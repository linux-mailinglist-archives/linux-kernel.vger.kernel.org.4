Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50161F117
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiKGKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiKGKre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:47:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C1B19026;
        Mon,  7 Nov 2022 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ry5ssv5//fxqYn0d4RpHPFusuSQKCJRtdUdP1XYz37I=; b=QiH+V/xCgT+T16QBOvPMwL6vaY
        gyVrUU+p0rHMd/9gcKatOmeVC82N9y2S5wob6/Zo6mivAN/Dk4qn1R6sgCiUa43uG9uTGcVOUbxK9
        1T010zQFV5iqFqf3vVNvvUEpogdVGELyVpzPNHceye5GM2hLRAvOIcgf5x8obCpMgkh5ugBWN5Td6
        Zzw3V6KuFfYOShULfVvD8nda2zxn8qm/5/7j2+sWe3sXrbNC0H0oCAyryj8oUzOMvmvkHVvUpyWdW
        iHC96EfZinpfYD0eaMVdgVhqjLo6NPAXmKwZ//MARFVgV21b21vnjh0HeUlIIGgjlBqc0IlrzEBJh
        zq7wfEAg==;
Received: from p200300ccff0572001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:7200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1orzf4-0002fk-BC; Mon, 07 Nov 2022 11:47:26 +0100
Date:   Mon, 7 Nov 2022 11:47:23 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Subject: Re: [PATCH v2] ARM: dts: imx: e60k02: Add touchscreen
Message-ID: <20221107114723.37e86b0e@aktux>
In-Reply-To: <20221107081234.wxup6lq3xph2obfv@pengutronix.de>
References: <20221104204251.1458958-1-andreas@kemnade.info>
        <20221107081234.wxup6lq3xph2obfv@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 7 Nov 2022 09:12:34 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Andreas,
> 
[...]
> > diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> > index e3f1e8d79528..db5d8509935f 100644
> > --- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> > +++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> > @@ -52,6 +52,13 @@ &iomuxc {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_hog>;
> >  
> > +	pinctrl_cyttsp5_gpio: cyttsp5-gpiogrp {
> > +		fsl,pins = <
> > +			MX6SL_PAD_SD1_DAT3__GPIO5_IO06                0x17059 /* TP_INT */
> > +			MX6SL_PAD_SD1_DAT2__GPIO5_IO13                0x10059 /* TP_RST */
> > +		>;
> > +	};  
> 
> Hm.. I don't like that you enable it within the base dtsi and add the
> missing dependencies here. I would rather add the touchscreen within the
> base dtsi but with with status set to disabled and without specifying
> the interrupt and reset gpio. Within the dts and the below you can
> reference the touchscreen via phandle and add the missing properties.
> 
hmm, that makes things more complex and unreadable. Remember, we have two boards
differ in a pin-compatible soc here. Why I should set something present
in all cases to disabled?
And why I should add hardware just to set to disabled?

I notice that I have not followed the agreed pattern for this things like in
the lm3630 setting, there we have


       pinctrl_lm3630a_bl_gpio: lm3630a-bl-gpiogrp {
                fsl,pins = <
                        MX6SLL_PAD_EPDC_PWR_CTRL3__GPIO2_IO10   0x10059 /* HWEN */
                >;
        };
[...]
&lm3630a {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
};

in the dts file, so there is no phandle pointing from dtsi to dts.
I will send an updated version following this widely adopted style.

Regards,
Andreas

