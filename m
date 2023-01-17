Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9E166E845
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjAQVOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjAQVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:13:34 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E6A6D693;
        Tue, 17 Jan 2023 11:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9RkDeLwVisy2/Gg2it+//8F4tee3446fu5LQUzCC/3A=; b=vfo8Gc8mgVbrX5629MsR+xqCQi
        B6XGZ+msvncFzXdFk6/g8pNLxr4xrfNJWYts8gIyaet2rXk83/ioFVG1gf7H3r7h6p1t9kwO3++3J
        ipa74jJYMW0lqT/vaEEEPWMvTleOW9j4q+Fh6WFXUi91xV5HTXjeudv+tHHV+SiKpvaUb1A/p1G8K
        2MVT8y6su1jdwo7j9SleQKjXEF0PwBai16PgJeYiyI5usVvooMnKYM4tmt3oJw9LC/SxxxxazpWCm
        7pY+0KzJ0s0yZt+pEgBDTVkfgL/Z3tbwET2DLtVHrkSPUVLEsFL7zZa0lylwzMoQnBwCDc3/ScuJb
        f9tne7Hg==;
Received: from p200300ccff136d001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff13:6d00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pHrkv-0006Be-GH; Tue, 17 Jan 2023 20:36:25 +0100
Date:   Tue, 17 Jan 2023 20:36:24 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap: gta04: add BNO055 IMU chip
Message-ID: <20230117203624.232be41c@aktux>
In-Reply-To: <2ebbe66f-fc98-3be2-1f93-857f0025e75e@linaro.org>
References: <20230113221058.2355840-1-andreas@kemnade.info>
        <2ebbe66f-fc98-3be2-1f93-857f0025e75e@linaro.org>
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

On Sun, 15 Jan 2023 15:58:05 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/01/2023 23:10, Andreas Kemnade wrote:
> > There is finally a driver upstreamed, so add the
> > device.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  arch/arm/boot/dts/omap3-gta04a5.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
> > index 0b5bd7388877..4f56f7fc0d1b 100644
> > --- a/arch/arm/boot/dts/omap3-gta04a5.dts
> > +++ b/arch/arm/boot/dts/omap3-gta04a5.dts
> > @@ -75,6 +75,11 @@ OMAP3_CORE1_IOPAD(0x2138, PIN_INPUT | MUX_MODE4) /* gpin114 */  
> >  		>;  
> >  	};
> >  
> > +	bno050_pins: pinmux-bno050-pins {
> > +		pinctrl-single,pins = <
> > +			OMAP3_CORE1_IOPAD(0x2136, PIN_INPUT | MUX_MODE4) /* gpin113 */
> > +		>;
> > +	};
> >  };
> >  
> >  /*
> > @@ -136,4 +141,13 @@ bme280@76 {
> >  		vdda-supply = <&vio>;
> >  		vddd-supply = <&vio>;
> >  	};
> > +
> > +	bno055@29 {  
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
the usual pitfall, just looking at the style around... Especially if it an
old patch, not needing too much attention, just removing some now undefined
properties. The file deserves some cleanup, since generic node names were
not invented there yet.

Regards,
Andreas
 

