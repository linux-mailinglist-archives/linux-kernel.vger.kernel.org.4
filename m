Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00286F9A95
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjEGRbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEGRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:31:42 -0400
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D3A71156D;
        Sun,  7 May 2023 10:31:27 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 5B3D6409FE; Sun,  7 May 2023 17:36:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 5B3D6409FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1683473786;
        bh=gTrugC1Tfe8NntAJ4r/hKWa/vAR/hMTXBXmU9T05C4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9+uu4TZA/xeEtZnFi4lOBhXVwirUPgR4DGnMJ+ylLqYepWDgPBdK/oCd81gT2fWN
         DZJCAUrssHPHktGYgMpxoqYQLVJtPyClvtTxkeKp3A+z3gjWtRybDh3rs0DMH7Dsqx
         quPX4aQAiM3dAClAEnZ5jahnRYRhpuWKGeF2+Lko=
Date:   Sun, 7 May 2023 17:36:25 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
Message-ID: <20230507153625.GA3135@www.linux-watchdog.org>
References: <20221103223956.50575-1-fabrizio.castro.jz@renesas.com>
 <20221103223956.50575-2-fabrizio.castro.jz@renesas.com>
 <20221115132811.GA4189373@roeck-us.net>
 <TYWPR01MB87753203F46FA9C744FEF7E6C2069@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYWPR01MB87753203F46FA9C744FEF7E6C2069@TYWPR01MB8775.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Based on below e-mail I excluded this patch from the merge window.
I saw that Guenter still has it in his branch.
So can we have an update on this please?

Thanks in advance,
Wim.

> Hi Geert and Guenter,
> 
> Thank you for your reviews!
> 
> As it turns out, the rzg2l_wdt driver has some reset related issues
> (currently not addressed by the driver) for the RZ/V2M and RZ/Five
> SoCs. More specifically to this patch, there is a better way to fix
> the restart callback by addressing the way the reset is handled
> for the watchdog IP.
> 
> I am dropping this patch, and I'll send out a series to address
> the above concerns (which will tackle the issues with the restart
> callback in a better way).
> 
> 
> Thanks,
> Fab
> 
> 
> > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> > Sent: 15 November 2022 13:28
> > Subject: Re: [PATCH 1/3] watchdog: rzg2l_wdt: Fix reboot for RZ/V2M
> > 
> > On Thu, Nov 03, 2022 at 10:39:54PM +0000, Fabrizio Castro wrote:
> > > The setting for the RZ/V2M watchdog cannot be changed once
> > > the watchdog has been enabled, unless the IP gets reset.
> > > The current implementation of the restart callback assumes
> > > that the watchdog is not enabled, but that's not always the
> > > case, and it leads to longer than necessary reboot times if
> > > the watchdog is already running.
> > >
> > > Always reset the RZ/V2M watchdog first, so that we can always
> > > restart quickly.
> > >
> > > Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > > ---
> > >  drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> > > index 974a4194a8fd..00438ceed17a 100644
> > > --- a/drivers/watchdog/rzg2l_wdt.c
> > > +++ b/drivers/watchdog/rzg2l_wdt.c
> > > @@ -145,10 +145,10 @@ static int rzg2l_wdt_restart(struct
> > watchdog_device *wdev,
> > >  {
> > >  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> > >
> > > -	clk_prepare_enable(priv->pclk);
> > > -	clk_prepare_enable(priv->osc_clk);
> > > -
> > >  	if (priv->devtype == WDT_RZG2L) {
> > > +		clk_prepare_enable(priv->pclk);
> > > +		clk_prepare_enable(priv->osc_clk);
> > > +
> > >  		/* Generate Reset (WDTRSTB) Signal on parity error */
> > >  		rzg2l_wdt_write(priv, 0, PECR);
> > >
> > > @@ -157,6 +157,11 @@ static int rzg2l_wdt_restart(struct watchdog_device
> > *wdev,
> > >  	} else {
> > >  		/* RZ/V2M doesn't have parity error registers */
> > >
> > > +		reset_control_reset(priv->rstc);
> > > +
> > > +		clk_prepare_enable(priv->pclk);
> > > +		clk_prepare_enable(priv->osc_clk);
> > > +
> > >  		wdev->timeout = 0;
> > >
> > >  		/* Initialize time out */
> > > --
> > > 2.34.1
> > >
