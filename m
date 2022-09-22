Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C205E6AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiIVSa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIVS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:27:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C1F10AB1A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:26:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q3so10631594pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=6ndWWjbbbJbtQHr06Dm1GUglIQIf8G1xTgr/LwYJzos=;
        b=Vt37OBIxIAoP+1nYlOTRHn8ZSBf7oCj94pnn6Q1iKL2/s4Jb08SQV36JYQcoe/kkEs
         3Trd+FHP3ZV7ru81ZK4wjagBY1/FN4BluDoKw/JWW11fZppqTj2gCSDpLbWMUlcXB/5V
         2jEiI4f3jIbIpI0GKWNr2AD094Amfii1FUxIIwL8Qoddf3/Qx/qUaFan6cfLfVr037b8
         UfyKdmHeDLsrO9JgF/j/UP9viZ3ELgCP9CeIsMmXO1AxUyMNEkz3cLEC/oRrQmlSpeom
         MqJWbcaZV9A5HP1KxHy0t/08l4SJHhT9vTceCGGrIN9yKvd76w8O61tjg7XfKxRE4iKL
         EEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6ndWWjbbbJbtQHr06Dm1GUglIQIf8G1xTgr/LwYJzos=;
        b=cRohXqaMQlTbLx/DP2FSGXwKuEeLfelO2lbBhRY0WnNR0rxvXNlaVG2ECYXFeXPdOM
         p2XudySZF6LUdK2okTsevYR4MNQIPDvKwCsp9lYfbmwKvdo13cbUBQR/Yd4VZCtSlOT2
         QVJ0nfU30DrgjBdT+TybwQmP0TmjKZ1gltukz3jRPGL9v9oY8o0T0S8x8bw0GmDwQG2z
         2+OQmOjmM6snPduhFusLcyttwH6EF493WW2b15nBDE8nIYFIEnd/vtkMztr8nI5y1p7k
         xsKj2c1wQtEDrfszsRosEooP5EKoCovSwRdSedBTYi6Oo+cKCmL2lNHrBhV1yVMOxfpO
         9knw==
X-Gm-Message-State: ACrzQf2pp1by8qnb8EbO94L3e7skiKP54gubKuT2mTDvO+Iy5OwOxUyL
        Z1O3XC+ti7vWMOqLnSs9z2pvW8BiaVr1IMHklb4=
X-Google-Smtp-Source: AMsMyM5A0gbdIv5p/pFowpErC6zyBs0v4TwJ6PjlbF/1s9bKPd9uxN9Xt0n5K4vT9iJ2TyrqS4iMymarA9qzXi+nUXQ=
X-Received: by 2002:a17:902:8346:b0:178:a33f:89cf with SMTP id
 z6-20020a170902834600b00178a33f89cfmr4466192pln.9.1663871087164; Thu, 22 Sep
 2022 11:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220922124306.34729-1-dev@pschenker.ch> <20220922124306.34729-2-dev@pschenker.ch>
In-Reply-To: <20220922124306.34729-2-dev@pschenker.ch>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 22 Sep 2022 20:24:36 +0200
Message-ID: <CABkfQAHcphPs=stWuT8XAFfbZnhx8sp9E_8i0nTgcMxoJp7agQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: lt8912b: add vsync hsync
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Philippe Schenker <philippe.schenker@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 22 sept. 2022 =C3=A0 14:43, Philippe Schenker <dev@pschenker.ch> a =
=C3=A9crit :
>
> From: Philippe Schenker <philippe.schenker@toradex.com>
>
> Currently the bridge driver does not take care whether or not the display
> needs positive/negative vertical/horizontal syncs. Pass these two flags
> to the bridge from the EDID that was read out from the display.
>
> Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Adrien Grassein <adrien.grassein@gmail.com>
>
> ---
>
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 28bad30dc4e5..0fd3472e767c 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -268,7 +268,7 @@ static int lt8912_video_setup(struct lt8912 *lt)
>         u32 hactive, h_total, hpw, hfp, hbp;
>         u32 vactive, v_total, vpw, vfp, vbp;
>         u8 settle =3D 0x08;
> -       int ret;
> +       int ret, hsync_activehigh, vsync_activehigh;
>
>         if (!lt)
>                 return -EINVAL;
> @@ -278,12 +278,14 @@ static int lt8912_video_setup(struct lt8912 *lt)
>         hpw =3D lt->mode.hsync_len;
>         hbp =3D lt->mode.hback_porch;
>         h_total =3D hactive + hfp + hpw + hbp;
> +       hsync_activehigh =3D lt->mode.flags & DISPLAY_FLAGS_HSYNC_HIGH;
>
>         vactive =3D lt->mode.vactive;
>         vfp =3D lt->mode.vfront_porch;
>         vpw =3D lt->mode.vsync_len;
>         vbp =3D lt->mode.vback_porch;
>         v_total =3D vactive + vfp + vpw + vbp;
> +       vsync_activehigh =3D lt->mode.flags & DISPLAY_FLAGS_VSYNC_HIGH;
>
>         if (vactive <=3D 600)
>                 settle =3D 0x04;
> @@ -317,6 +319,11 @@ static int lt8912_video_setup(struct lt8912 *lt)
>         ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3e, hfp & 0xff);
>         ret |=3D regmap_write(lt->regmap[I2C_CEC_DSI], 0x3f, hfp >> 8);
>
> +       ret |=3D regmap_update_bits(lt->regmap[I2C_MAIN], 0xab, BIT(0),
> +                                 vsync_activehigh ? BIT(0) : 0);
> +       ret |=3D regmap_update_bits(lt->regmap[I2C_MAIN], 0xab, BIT(1),
> +                                 hsync_activehigh ? BIT(1) : 0);
> +
>         return ret;
>  }
>
> --
> 2.37.3
>
