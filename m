Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77965E9047
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 00:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiIXWPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 18:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiIXWPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 18:15:33 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F7367B2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 15:15:32 -0700 (PDT)
Date:   Sat, 24 Sep 2022 22:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1664057730; x=1664316930;
        bh=vibURvDK8C9+axigLopCKC5jQEsrmsW5ulpcMBkfZGs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=ogp8N9s8hO2Z1JgKo/5W0A0nXSZWm841x2LEGIK5ontx8mZj3iHofDM2FfcW0xXCA
         hQlBelr+s6pZsD3i5PbLgcFYDIfSMVJUjjhcYsZDs8mFyqvz7T2CIcpgLMRT794Nxu
         LTvjLCfBv2fMy9pyBBhE0KsVePuGee7jWTQvey28=
To:     Nia Espera <a5b6@riseup.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: gpu: drm: remove support for sofef00 driver on s6e3fc2x01 panel
Message-ID: <f8a2b974-7f95-c158-5d52-3a9582fcd28c@connolly.tech>
In-Reply-To: <20220924203616.63325-3-a5b6@riseup.net>
References: <20220924203616.63325-1-a5b6@riseup.net> <20220924203616.63325-3-a5b6@riseup.net>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/09/2022 21:36, Nia Espera wrote:
> Removes functionality from sofef00 panel driver which allowed it to
> drive the s6e3fc2x01 panel
>
> Signed-off-by: Nia Espera <a5b6@riseup.net>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |  6 +++---
>   drivers/gpu/drm/panel/panel-samsung-sofef00.c | 18 ------------------
>   2 files changed, 3 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfi=
g
> index ee62d5d8828a..62b9cb6acd05 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -547,16 +547,16 @@ config DRM_PANEL_SAMSUNG_S6E8AA0
>   =09select VIDEOMODE_HELPERS
>
>   config DRM_PANEL_SAMSUNG_SOFEF00
> -=09tristate "Samsung sofef00/s6e3fc2x01 OnePlus 6/6T DSI cmd mode panels=
"
> +=09tristate "Samsung sofef00 OnePlus 6 DSI cmd mode panel"
>   =09depends on OF
>   =09depends on DRM_MIPI_DSI
>   =09depends on BACKLIGHT_CLASS_DEVICE
>   =09select VIDEOMODE_HELPERS
>   =09help
>   =09  Say Y or M here if you want to enable support for the Samsung AMOL=
ED
> -=09  command mode panels found in the OnePlus 6/6T smartphones.
> +=09  command mode panel found in the OnePlus 6 smartphone.
>
> -=09  The panels are 2280x1080@60Hz and 2340x1080@60Hz respectively
> +=09  The panel is 2280x1080@60Hz
>
>   config DRM_PANEL_SAMSUNG_S6E3FC2X01
>   =09tristate "Samsung s6e3fc2x01 OnePlus 6T DSI cmd mode panel"
> diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/=
drm/panel/panel-samsung-sofef00.c
> index bd02af81a4fe..68e58b9b8c5c 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> @@ -181,20 +181,6 @@ static const struct drm_display_mode enchilada_panel=
_mode =3D {
>   =09.height_mm =3D 145,
>   };
>
> -static const struct drm_display_mode fajita_panel_mode =3D {
> -=09.clock =3D (1080 + 72 + 16 + 36) * (2340 + 32 + 4 + 18) * 60 / 1000,
> -=09.hdisplay =3D 1080,
> -=09.hsync_start =3D 1080 + 72,
> -=09.hsync_end =3D 1080 + 72 + 16,
> -=09.htotal =3D 1080 + 72 + 16 + 36,
> -=09.vdisplay =3D 2340,
> -=09.vsync_start =3D 2340 + 32,
> -=09.vsync_end =3D 2340 + 32 + 4,
> -=09.vtotal =3D 2340 + 32 + 4 + 18,
> -=09.width_mm =3D 68,
> -=09.height_mm =3D 145,
> -};
> -
>   static int sofef00_panel_get_modes(struct drm_panel *panel, struct drm_=
connector *connector)
>   {
>   =09struct drm_display_mode *mode;
> @@ -327,10 +313,6 @@ static const struct of_device_id sofef00_panel_of_ma=
tch[] =3D {
>   =09=09.compatible =3D "samsung,sofef00",
>   =09=09.data =3D &enchilada_panel_mode,
>   =09},
> -=09{ // OnePlus 6T / fajita
> -=09=09.compatible =3D "samsung,s6e3fc2x01",
> -=09=09.data =3D &fajita_panel_mode,
> -=09},
>   =09{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, sofef00_panel_of_match);
> --
> 2.37.3
>

--
Kind Regards,
Caleb

