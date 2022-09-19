Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F65BCCCC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiISNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiISNSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:18:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9627FF4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:18:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so64465735ejy.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gzjER0yDfgC7AM3XY5AmZTUcIYvTw+ZPBU8Ab6kCF1A=;
        b=oCvGpuKao+NdPHOlaIZDp2egAgLgEPw3IteIyQ/QvfEJdQUKlHPnCEr7GlPg6HpfMP
         dVIYPSycLDoCGucAf+dgMukqSqMyU3sljxWQZ1C5O5yfErbYxOR/x/hLQhMP1mEdw4ZP
         cjQShEMYMP250cAvjyqZ3M7U0yaSNoDJxB29kW3qQNCnN9wZ6HHS9CpdNaD1iAy1Amm6
         gVn2aO/yPFwPoa6zCOyAX5D7hY17WUsONgau+7fxInzn7dXZ/1MMZnIFhfYkr+cyrua5
         /goX39eWj/ydD63FYnlELFczwPrC7UW1fTB8T8fcSpjbmA2N/YhqWfH3jlgQhzHeyDdn
         kgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gzjER0yDfgC7AM3XY5AmZTUcIYvTw+ZPBU8Ab6kCF1A=;
        b=IIyXV5rXYj5Af90kLcbI8BkyPBid/7LHTg9ZM458y+RZZPQTdokdgY6D//iSQ6io6M
         F0FUeSKw88WNyRqytD3NUD70Y8EYD0SxGvcUuQ6NemMrUd5OdtvEzi7rGMMa1323r/et
         UQecEoQ/Ls+SlGsETCqwbvUVdMleH7/F7ezLUYvad+WrPzsKlCJuHtgOJHGX8j2RxB4Y
         EuW0QYoKV8FXLffVzKUbtUhWaHXLc/MiwM5JmVfsQc56V3t+zqzGl//CfAA47TOi78H5
         s8X4SMlOJi+x2BvJYVccAsARjW2pZmQTJvwNuwcbnfFkgayKVh1kQ+t0SJb7x4/+I/hT
         aiow==
X-Gm-Message-State: ACrzQf1OuGBdz1nTlgwT9zQgCdrtJVGP3mKRZxr1Smmfz9LcvfG+9Y7l
        HfNJyNEvLcxFTyEj7C3Vpuvq8626gN++yNmmOiOTDA==
X-Google-Smtp-Source: AMsMyM44eZwNFcm9nbCPeKjoB6bDjAqdr1WQR9kY74b4PjDUbuCLEI1O22R9NLQqBpz/Q33j8Sm+v+qscaBv2lxtl/o=
X-Received: by 2002:a17:906:9beb:b0:773:db0f:d53a with SMTP id
 de43-20020a1709069beb00b00773db0fd53amr13173696ejc.580.1663593525988; Mon, 19
 Sep 2022 06:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220919102009.150503-1-robert.foss@linaro.org>
 <20220919102009.150503-3-robert.foss@linaro.org> <YyhI0/aG97cCB8DB@pendragon.ideasonboard.com>
In-Reply-To: <YyhI0/aG97cCB8DB@pendragon.ideasonboard.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 19 Sep 2022 15:18:35 +0200
Message-ID: <CAG3jFysr3VCgU_sjR-Dd0pn_VK0HpDb2=pQuH+Did9giCYGZLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "drm/bridge: chrontel-ch7033: Add byteswap
 order setting"
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 12:48, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Mon, Sep 19, 2022 at 12:20:09PM +0200, Robert Foss wrote:
> > Revert this patch since it depends on devicetree functionality that
> > previously has been reverted in the below commit.
> >
> > commit e798ba3374a1 ("Revert "dt-bindings: Add byteswap order to chrontel ch7033"")
> >
> > This reverts commit ce9564cfc9aea65e68eb343c599317633bc2321a.
> >
> > Fixes: 8c9c40ec8344 ("Revert "drm/bridge: ti-sn65dsi86: Implement bridge connector operations for DP"")
>
> I'm not sure this Fixes tag is meaningful here. Apart from that,

Ack.

>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >  drivers/gpu/drm/bridge/chrontel-ch7033.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
> > index c5719908ce2d..ba060277c3fd 100644
> > --- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
> > +++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
> > @@ -68,7 +68,6 @@ enum {
> >       BYTE_SWAP_GBR   = 3,
> >       BYTE_SWAP_BRG   = 4,
> >       BYTE_SWAP_BGR   = 5,
> > -     BYTE_SWAP_MAX   = 6,
> >  };
> >
> >  /* Page 0, Register 0x19 */
> > @@ -356,8 +355,6 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
> >       int hsynclen = mode->hsync_end - mode->hsync_start;
> >       int vbporch = mode->vsync_start - mode->vdisplay;
> >       int vsynclen = mode->vsync_end - mode->vsync_start;
> > -     u8 byte_swap;
> > -     int ret;
> >
> >       /*
> >        * Page 4
> > @@ -401,16 +398,8 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
> >       regmap_write(priv->regmap, 0x15, vbporch);
> >       regmap_write(priv->regmap, 0x16, vsynclen);
> >
> > -     /* Input color swap. Byte order is optional and will default to
> > -      * BYTE_SWAP_BGR to preserve backwards compatibility with existing
> > -      * driver.
> > -      */
> > -     ret = of_property_read_u8(priv->bridge.of_node, "chrontel,byteswap",
> > -                               &byte_swap);
> > -     if (!ret && byte_swap < BYTE_SWAP_MAX)
> > -             regmap_update_bits(priv->regmap, 0x18, SWAP, byte_swap);
> > -     else
> > -             regmap_update_bits(priv->regmap, 0x18, SWAP, BYTE_SWAP_BGR);
> > +     /* Input color swap. */
> > +     regmap_update_bits(priv->regmap, 0x18, SWAP, BYTE_SWAP_BGR);
> >
> >       /* Input clock and sync polarity. */
> >       regmap_update_bits(priv->regmap, 0x19, 0x1, mode->clock >> 16);
>
> --
> Regards,
>
> Laurent Pinchart
