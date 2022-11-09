Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B617622ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiKILpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKILpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:45:47 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5AE8F;
        Wed,  9 Nov 2022 03:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IseUHcC0UR0gxynIRWnMMbp9tHRTS9eW34J38UxyWjU=; b=65NUPX0RvDsVrueYcOgQ7zBCQb
        BLIqV8nXDfrEWhvGrM9f5QsjikIyWkDo5x/x1MEEAbMkrySdzoLR8HNRfYvxnZDd2RXwQfXvwe58W
        /U6x/yKgRB2rU58XxtcCILJj4EmYsEpMjPtR8htfnwzDnTXDH8tjF2sAte35X037cXtn/RsM/fQNa
        E/E5GVqjdjpqf82DsBexgwZplshJcdN5H5+XMi8cAQEdBTfJUsnzQVQlM66glUxrOgW7msZVqlGBP
        vQRYnLEfCcLK4TgTrWV+8+lA3lgT3smY9x7bLjatty96OYySPJdfnKk1kHrUpA/BdYF5AIlEhv/L5
        A2tVhbMA==;
Received: from p200300ccff05c4001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:c400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1osjWU-0000BT-N8; Wed, 09 Nov 2022 12:45:38 +0100
Date:   Wed, 9 Nov 2022 12:45:36 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Subject: Re: [PATCH v3] ARM: dts: imx: e60k02: Add touchscreen
Message-ID: <20221109124536.5154cb03@aktux>
In-Reply-To: <20221109092350.2ke6sbgbcp3wpelc@pengutronix.de>
References: <20221108191543.1752080-1-andreas@kemnade.info>
        <20221109092350.2ke6sbgbcp3wpelc@pengutronix.de>
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

On Wed, 9 Nov 2022 10:23:50 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Andreas,
> 
> On 22-11-08, Andreas Kemnade wrote:
> > Add the touchscreen now, since the driver is available.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v3: no phandles pointing from dtsi to dts  
> 
> Thanks for this change...
> 
> > Changes in v2: fix pinmux naming
> > 
> >  arch/arm/boot/dts/e60k02.dtsi              |  9 ++++++++-
> >  arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 12 ++++++++++++
> >  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 12 ++++++++++++
> >  3 files changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/e60k02.dtsi
> > b/arch/arm/boot/dts/e60k02.dtsi index 935e2359f8df..99091db3ab2a
> > 100644 --- a/arch/arm/boot/dts/e60k02.dtsi
> > +++ b/arch/arm/boot/dts/e60k02.dtsi
> > @@ -104,7 +104,14 @@ &i2c2 {
> >  	clock-frequency = <100000>;
> >  	status = "okay";
> >  
> > -	/* TODO: CYTTSP5 touch controller at 0x24 */
> > +	cyttsp5: touchscreen@24 {
> > +		compatible = "cypress,tt21000";
> > +		reg = <0x24>;
> > +		interrupt-parent = <&gpio5>;
> > +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> > +		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +		vdd-supply = <&ldo5_reg>;
> > +	};  
> 
> but we still have a cross-reference to the .dtsi file here. Therefore
> I said to move the interrupt/reset-gpio into the dts file too. I know
> this is a kind of a nitpick but I really don't like such
> cross-references.
> 
hmm. &gpio5 references to imx6sl[l].dtsi, not dts, so what is the
problem here?
And we have this pattern all over the place.

What is different to the touchscreen that this pattern is not wanted
here but
accepted everywhere else? It is there for
  - backlight
  - irq of pmic
  - reset/gpio-regulator of wifi
  - leds
  - keys

And you have also done some review work there.

Here I am caring a bit about readability since I have still to do
maintenance work on this file, so I am a bit more concerned than that
it a) just works and b) is being accepted upstream.

If it is not allowed to have common things in the e60k02.dtsi file, what
about ditching that file alltogether and just have the two .dts files?

I personally prefer the v2 variant, but v3 is a compromise.

For comparison, the feature-complete version used by postmarketOS is
here:
https://github.com/akemnade/linux/blob/kobo/drm-merged-5.19/arch/arm/boot/dts/e60k02.dtsi

Regards,
Andreas
