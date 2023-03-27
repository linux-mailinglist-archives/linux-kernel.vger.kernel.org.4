Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562636CAFD8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjC0UUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC0UUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:20:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5091B1BFD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:20:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B1A2F5C00E9;
        Mon, 27 Mar 2023 16:20:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Mar 2023 16:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1679948447; x=1680034847; bh=ZsScFOMcDutT3pQYC+al8Js5gcF51UcRlxh
        B4rzqBQw=; b=Gql8zZO8TAknYH1tqIwjBydqJwf0hGd86EZUqINPQxPnOdTBuNe
        osNGxo3uwlRNMkxsHv7qqn6FKeyWdXC6tNJjQlOg4BAQjubffxMgOKsbE+NZaUF1
        5nAk4kuYzjbMC8GNqeJlqBX0pjRKIvev50P0jKlCsZnBxU/c21hMs7nGu/UTR8wG
        NS00/7BYZKh9+ANOTh4PG40ZeEFFPknW9ZlN/fEjEaUuoKpSWt8aUu0ro6DTc99z
        HO/cvYsI9F1LtiiaS9GuKUepVENLpAuGZvxgmeXCdif4wlpQmLZcVq8jWBrNCoW1
        LBeF2es/JjTTW4UT6mlT9L+rZf7Frb3LC5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679948447; x=1680034847; bh=ZsScFOMcDutT3pQYC+al8Js5gcF51UcRlxh
        B4rzqBQw=; b=cp6K6XWTuSWtc1pWbTtavRyNTCUa5fny16EyUdkuVTZVdVmUcXI
        ZzwqzSdT30jvo1v1jRxL9ITWUfGNGcXfxj9YA/LVF0OpR7pBM6QuPYtQq2PQ0hR6
        rpiHMGWkvrZbJMjcBmi6CJ09waioAGMvcQHWedZ6101YuRF114ExiJ4Q7NgeiEK1
        MNdSO/5X5b0GgMlk4ZAIuM+8+T2c5s4EGy4LhN5x5CfkKJBQiY52ZQYYbwuffPKC
        Z6Z59mDf37RnCBcB2pHFlsr4PVeGbLs8ta+4rMJIwcXqgtPI5cvJ8nuQfY/H8VQ3
        7qji9shnKcBcAUfaLF36D9eBXACaFtYr+nQ==
X-ME-Sender: <xms:n_ohZItHfbsZZN6W4T8UgaIfls3AznYAJhHzEVaSjf_dnDDmvwz34Q>
    <xme:n_ohZFd0uCj5NqIxqcJ496R4isGRfg6_c6PqIVaMAoTaW4MnolJEprAeW05sYwUKG
    cZHstFTVuA69_xLRsg>
X-ME-Received: <xmr:n_ohZDwLpLjaqBI-xR5T0Vyf1Q-8DsKNIJt8dcp0AiljZfBrVpkgYNybBwih>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehvddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeejudejjeektedtjeeihfeltdffjedvfeethfdugfehffevhfekffeh
    jedtgfeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgig
    ihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:n_ohZLMcJKgViuoDWyaRIupG0Cm3Sy16RQ9anWWjYbp2xLTm5cFKQw>
    <xmx:n_ohZI_OcPQIK_ZDbK-nlRRDCwQatg8k4jYtCjB2gBVdi8lJF_enBw>
    <xmx:n_ohZDUJV1wpkBUOj8XpciDZDvjzNmPYxcKBrmirvzkTt0eNwkdSZw>
    <xmx:n_ohZDbQlTezZEwVKaT8TQhJ8kR0MbIJhD0iX8FXkKXWh6GS-2tcvQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Mar 2023 16:20:46 -0400 (EDT)
Date:   Mon, 27 Mar 2023 22:20:45 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Roman Beranek <romanberanek@icloud.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from
 TCON0_DCLK_REG
Message-ID: <20230327202045.ceeqqwjug4ktxtsf@penduick>
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <87wn356ni4.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wn356ni4.fsf@oltmanns.dev>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Mar 25, 2023 at 12:40:04PM +0100, Frank Oltmanns wrote:
> On 2023-03-20 at 17:16:36 +0100, Roman Beranek <romanberanek@icloud.com> wrote:
> > In the case of DSI output, the value of SUN4I_TCON0_DCLK_DIV (4) does
> > not represent the actual dotclock divider, PLL_MIPI instead runs at
> > (bpp / lanes )-multiple [1] of the dotclock. [2] Setting 4 as dotclock
> > divder thus leads to reduced frame rate, specifically by 1/3 on 4-lane
> > panels, and by 2/3 on 2-lane panels respectively.
> >
> > As sun4i_dotclock driver stores its calculated divider directly in
> > the register, conditional handling of the DSI output scenario is needed.
> > Instead of reading the divider from SUN4I_TCON0_DCLK_REG, retrieve
> > the value from tcon->dclk_min_div.
> >
> > [1] bits per pixel / number of DSI lanes
> > [2] <https://github.com/BPI-SINOVOIP/BPI-M64-bsp-4.4/blob/66bef0f2f30b367eb93b1cbad21ce85e0361f7ae/linux-sunxi/drivers/video/fbdev/sunxi/disp2/disp/de/lowlevel_sun50iw1/disp_al.c#L322>
> >
> > Signed-off-by: Roman Beranek <romanberanek@icloud.com>
> > —
> >  drivers/gpu/drm/sun4i/sun4i_dotclock.c | 6 +++++-
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c     | 5 +++–
> >  drivers/gpu/drm/sun4i/sun4i_tcon.h     | 1 +
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff –git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> > index 417ade3d2565..26fa99aff590 100644
> > — a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
> > @@ -11,6 +11,7 @@
> >
> >  #include “sun4i_tcon.h”
> >  #include “sun4i_dotclock.h”
> > +#include “sun6i_mipi_dsi.h”
> >
> >  struct sun4i_dclk {
> >  	struct clk_hw  hw;
> > @@ -56,6 +57,9 @@ static unsigned long sun4i_dclk_recalc_rate(struct clk_hw *hw,
> >  	struct sun4i_dclk *dclk = hw_to_dclk(hw);
> >  	u32 val;
> >
> > +	if (dclk->tcon->is_dsi)
> > +		return parent_rate / dclk->tcon->dclk_min_div;
> > +
> >  	regmap_read(dclk->regmap, SUN4I_TCON0_DCLK_REG, &val);
> >
> >  	val >>= SUN4I_TCON0_DCLK_DIV_SHIFT;
> > @@ -116,7 +120,7 @@ static int sun4i_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
> >  			       unsigned long parent_rate)
> >  {
> >  	struct sun4i_dclk *dclk = hw_to_dclk(hw);
> > -	u8 div = parent_rate / rate;
> > +	u8 div = dclk->tcon->is_dsi ? SUN6I_DSI_TCON_DIV : parent_rate / rate;
> >
> >  	return regmap_update_bits(dclk->regmap, SUN4I_TCON0_DCLK_REG,
> >  				  GENMASK(6, 0), div);
> > diff –git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > index 523a6d787921..7f5d3c135058 100644
> > — a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -367,8 +367,9 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
> >  	u32 block_space, start_delay;
> >  	u32 tcon_div;
> >
> > -	tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
> > -	tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
> > +	tcon->is_dsi = true;
> > +	tcon->dclk_min_div = bpp / lanes;
> > +	tcon->dclk_max_div = bpp / lanes;
> 
> Claiming to set the divider to a different value (bpp / lanes) than what we’re actually using in
> the end (SUN6I_DSIO_TCON_DIV) is somehow bugging me. I feel like the proposal that I submitted is
> more direct: <https://lore.kernel.org/all/20230319160704.9858-2-frank@oltmanns.dev/>

Yeah, this patch looks better to me too: it's simpler, more straightforward. If Roman can confirm it
works with his testing, I'll be happy to merge it.

> Actually, I had the following third patch prepared that adjusted the dotclock rate so that the
> required PLL rate is set. But again, this seems very indirect, so that’s why I refrained from
> submitting it and I submitted the linked patch above instead.
> 
> Anyway, here is the third proposal:
> 
> — a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -819,6 +819,34 @@ static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
>  	regulator_disable(dsi->regulator);
>  }
> 
> +static bool sun6i_dsi_encoder_mode_fixup(
> ⁃ struct drm_encoder *encoder,
> ⁃ const struct drm_display_mode *mode,
> ⁃ struct drm_display_mode *adjusted_mode)
> +{
> ⁃ if (encoder->encoder_type == DRM_MODE_ENCODER_DSI) {
> ⁃ /*
> ⁃ * For DSI the PLL rate has to respect the bits per pixel and
> ⁃ * number of lanes.
> ⁃ *
> ⁃ * According to the BSP code:
> ⁃ * PLL rate = DOTCLOCK * bpp / lanes
> ⁃ *
> ⁃ * Therefore, the clock has to be adjusted in order to set the
> ⁃ * correct PLL rate when actually setting the clock.
> ⁃ */
> ⁃ struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
> ⁃ struct mipi_dsi_device *device = dsi->device;
> ⁃ u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
> ⁃ u8 lanes = device->lanes;
> ⁃ 
> 
> ⁃ adjusted_mode->crtc_clock = mode->crtc_clock
> ⁃ * bpp / (lanes * SUN6I_DSI_TCON_DIV);
> ⁃ }
> ⁃ 
> 
> ⁃ return true;
> +}
> ⁃ static int sun6i_dsi_get_modes(struct drm_connector *connector)
>   {
>       struct sun6i_dsi *dsi = connector_to_sun6i_dsi(connector);
> @@ -851,6 +879,7 @@ static const struct drm_connector_funcs sun6i_dsi_connector_funcs = {
>  static const struct drm_encoder_helper_funcs sun6i_dsi_enc_helper_funcs = {
>  	.disable	= sun6i_dsi_encoder_disable,
>  	.enable		= sun6i_dsi_encoder_enable,
> ⁃ .mode_fixup = sun6i_dsi_encoder_mode_fixup,
>   };

It's not clear to me what this patch is supposed to be doing, there's no mode_fixup implementation
upstream?

Maxime
