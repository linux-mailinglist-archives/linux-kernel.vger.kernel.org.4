Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58C625756
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiKKJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiKKJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:54:50 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F69E0B5;
        Fri, 11 Nov 2022 01:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=evRlCKgEQECo3ai4GkdDmNZPq1lAkkoYTxFJ/d65SdE=; b=u+29K+4QkOtceIX3tLoQ9vv80+
        WqWzxn55E3NXSqrW80hjOWMm8HPnHdACBYCGVp6fuk1NHI/v16sPyieyfGY2Lt+d1rbVMytb1gZyS
        wFU5WcrRKjuMbj+/8bTW4MGUb5VQrUERWuBX5s14kZKYj5P7cTNyZJh1Cf/mRIHmiZlq5o14Orll2
        jC2ehRQmcYCsgOHKmOlQnWa/eFTMVgOPkNm2L8wcU9ftTMtcHZ7/Gh87IQVP65MuJ+RiGA4kXyzN4
        ypBYeSEwpCFjXuQ1sXcO4Mvq88Gepn/EydGefpCtSaF+/QEqpuxXIe4DEkfPgO8yYrFrUxw8CkOdD
        WAHNnxjQ==;
Received: from p200300ccff0666001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:6600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1otQkC-00057X-Ul; Fri, 11 Nov 2022 10:54:41 +0100
Date:   Fri, 11 Nov 2022 10:54:38 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alistair@alistair23.me
Subject: Re: [PATCH v3] ARM: dts: imx: e60k02: Add touchscreen
Message-ID: <20221111105438.26c477ae@aktux>
In-Reply-To: <20221111091223.if2ahwz67vkf72ba@pengutronix.de>
References: <20221108191543.1752080-1-andreas@kemnade.info>
        <20221109092350.2ke6sbgbcp3wpelc@pengutronix.de>
        <20221109124536.5154cb03@aktux>
        <20221111091223.if2ahwz67vkf72ba@pengutronix.de>
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

Hi Marco,

On Fri, 11 Nov 2022 10:12:23 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> Hi Andreas,
> 
> On 22-11-09, Andreas Kemnade wrote:
> > On Wed, 9 Nov 2022 10:23:50 +0100
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >   
> > > Hi Andreas,
> > > 
> > > On 22-11-08, Andreas Kemnade wrote:  
> > > > Add the touchscreen now, since the driver is available.
> > > > 
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---
> > > > Changes in v3: no phandles pointing from dtsi to dts    
> > > 
> > > Thanks for this change...
> > >   
> > > > Changes in v2: fix pinmux naming
> > > > 
> > > >  arch/arm/boot/dts/e60k02.dtsi              |  9 ++++++++-
> > > >  arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 12 ++++++++++++
> > > >  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 12 ++++++++++++
> > > >  3 files changed, 32 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/e60k02.dtsi
> > > > b/arch/arm/boot/dts/e60k02.dtsi index 935e2359f8df..99091db3ab2a
> > > > 100644 --- a/arch/arm/boot/dts/e60k02.dtsi
> > > > +++ b/arch/arm/boot/dts/e60k02.dtsi
> > > > @@ -104,7 +104,14 @@ &i2c2 {
> > > >  	clock-frequency = <100000>;
> > > >  	status = "okay";
> > > >  
> > > > -	/* TODO: CYTTSP5 touch controller at 0x24 */
> > > > +	cyttsp5: touchscreen@24 {
> > > > +		compatible = "cypress,tt21000";
> > > > +		reg = <0x24>;
> > > > +		interrupt-parent = <&gpio5>;
> > > > +		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> > > > +		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > > > +		vdd-supply = <&ldo5_reg>;
> > > > +	};    
> > > 
> > > but we still have a cross-reference to the .dtsi file here. Therefore
> > > I said to move the interrupt/reset-gpio into the dts file too. I know
> > > this is a kind of a nitpick but I really don't like such
> > > cross-references.
> > >   
> > hmm. &gpio5 references to imx6sl[l].dtsi, not dts, so what is the
> > problem here?  
> 
> Sorry for the missunderstanding, I didn't mean the phandle. I mean the
> mux setting which is done in the dts right? I'm just not a fan of
> muxing pins in one file an using those 'assumptions' in others. Except
> for platforms like the imx8mm-evk which is exactly the same hardware and
> only differs in the RAM they used. But you have two different platforms
> right?
> 
Same board, same PCB marking, the only spotted difference is the name on the
case and the SoC (which is pin-compatible, so GPIOs will be all the same).

In the case of different hardware platforms I would understand your
ruffled feathers.

Regards,
Andreas
