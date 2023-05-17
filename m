Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF67069A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjEQNVT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjEQNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:21:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846407A9A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:20:42 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pzH51-0005lI-B6; Wed, 17 May 2023 15:20:35 +0200
Message-ID: <eeffc9d6ff1b5db2b096f4cde5f88c65d2258b9d.camel@pengutronix.de>
Subject: Re: [PATCH V6 4/6] drm: bridge: samsung-dsim: Select
 GENERIC_PHY_MIPI_DPHY
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 17 May 2023 15:20:32 +0200
In-Reply-To: <CAHCN7xJZMu2u2gydmL9gF16Sd6wVX62kJRpzvZnhQLCtRm-zrQ@mail.gmail.com>
References: <20230515235713.232939-1-aford173@gmail.com>
         <20230515235713.232939-5-aford173@gmail.com>
         <a0debcb9251aa99326aec44235d39f84c6086096.camel@pengutronix.de>
         <CAHCN7xJZMu2u2gydmL9gF16Sd6wVX62kJRpzvZnhQLCtRm-zrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 17.05.2023 um 08:02 -0500 schrieb Adam Ford:
> On Wed, May 17, 2023 at 7:58 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Am Montag, dem 15.05.2023 um 18:57 -0500 schrieb Adam Ford:
> > > In order to support variable DPHY timings, it's necessary
> > > to enable GENERIC_PHY_MIPI_DPHY so phy_mipi_dphy_get_default_config
> > > can be used to determine the nominal values for a given resolution
> > > and refresh rate.
> > > 
> > I would just squash this one into the patch introducing the dependency.
> 
> I thought Kconfig updates were supposed to be on their own.  Is that
> not correct?
> 
I'm not aware of a general rule for this, but maybe I just missed it.
Personally I would have added this to the patch introducing the
dependency, but I'm also fine with keeping it as a separate patch.

Regards,
Lucas


> adam
> > 
> > Regards,
> > Lucas
> > 
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >  drivers/gpu/drm/bridge/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > index f076a09afac0..82c68b042444 100644
> > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > @@ -227,6 +227,7 @@ config DRM_SAMSUNG_DSIM
> > >       select DRM_KMS_HELPER
> > >       select DRM_MIPI_DSI
> > >       select DRM_PANEL_BRIDGE
> > > +     select GENERIC_PHY_MIPI_DPHY
> > >       help
> > >         The Samsung MIPI DSIM bridge controller driver.
> > >         This MIPI DSIM bridge can be found it on Exynos SoCs and
> > 

