Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977DD717BCD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjEaJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjEaJXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:23:31 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA08BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:23:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33b73741017so5532485ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685525009; x=1688117009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkehbS7//ferRXwM6kvo7oRNHn1QNtaSgYp/ExQ0jdM=;
        b=jwezaxfaUWtfR62wBCm6nQcQVihAO87LksVgscSu+iYR71oqCzT7dg9trN4Mcl1t3F
         pUOWJGlu+fg63SeGPua4KDd5/Km6Ky0jKMCsTTx86qjTONR/CjhiyuYvqCsFJjLwa2xa
         7QHQnbeJ3NqVDZtNJlD5zpintmktBrldJaOCReUdHGrQyDX/msTjP6WwhC2zB4bqu4pm
         K0x7sNwxF5JGH3aVWDIRb0X6yZfHbWS4Cb9uvH1MdL7gg+ZpaDbt4LcFQR0ko8AQpH2f
         AXfhvMHO1efJk+b6J7sc3al/DAvDaeZX2+sDfe84r68ln1NG8xSl2CmcJzjrS+Xzv3hx
         /ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685525009; x=1688117009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkehbS7//ferRXwM6kvo7oRNHn1QNtaSgYp/ExQ0jdM=;
        b=SaIX90VFS7e5PfxxoguQ4GZDx1SvCEEsi2Upktme9MIpIyj0VLi9zy8hSFUFnYXrxR
         Qkmrj5H2Jq3667dpIq+m0wlcGqaOxhunsNdC+koMTb9pRXI7nl0fsmyk75F8MUSi0yFF
         YaYxJaHCp7f6NDWbThYHJtlCdH55f196D++DaNiyBI9TEzM3GXxt4HFYhmWYMW/5Gzgc
         1m/nWzWVAnNjNs2rqT617j3Ujc90XZhjodr6Nb+gUMp2efas21udfudc/WXF37eIFT1o
         NU0MxA4ppayuxN4iGxTK58aqGYzpNZYjIsFJuK449sItb8mlrbSs2m0J4F0QmHNsOEru
         uZEg==
X-Gm-Message-State: AC+VfDz6v9gOgvnYUOLaMiA4LCrH12rUwC+ka9UOmAey0+v3K7TuGF4L
        Zw5ImV36FRsbdi2ioTHK3m8Kzp9Tsy7swxJ/EFGQ2A==
X-Google-Smtp-Source: ACHHUZ70GbnB79GmkXTRMAGnGG/KKU1NUQSh6qgC/iLrY7CmzQsyxOazfkdFa/H20GQjdIwHhjjVzsSUdxUmKohoaIA=
X-Received: by 2002:a92:c60f:0:b0:332:e5aa:f9ab with SMTP id
 p15-20020a92c60f000000b00332e5aaf9abmr1742865ilm.11.1685525009247; Wed, 31
 May 2023 02:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-13-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-13-56eb7a4d5b8e@linaro.org>
From:   Nicolas Belin <nbelin@baylibre.com>
Date:   Wed, 31 May 2023 11:23:17 +0200
Message-ID: <CAJZgTGExa-Bx3uxEYr3KLEs84-GGR-=siY2UM+Z2kE9cJSUOcA@mail.gmail.com>
Subject: Re: [PATCH v5 13/17] drm/panel: khadas-ts050: update timings to
 achieve 60Hz refresh rate
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 30 mai 2023 =C3=A0 09:38, Neil Armstrong
<neil.armstrong@linaro.org> a =C3=A9crit :
>
> This updates the panel timings to achieve a clean 60Hz refresh rate.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-khadas-ts050.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm=
/panel/panel-khadas-ts050.c
> index 1ab1ebe30882..b942a0162274 100644
> --- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
> +++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
> @@ -568,7 +568,7 @@ static const struct khadas_ts050_panel_cmd init_code[=
] =3D {
>         {0xfb, 0x01},
>         /* Select CMD1 */
>         {0xff, 0x00},
> -       {0xd3, 0x05}, /* RGBMIPICTRL: VSYNC back porch =3D 5 */
> +       {0xd3, 0x22}, /* RGBMIPICTRL: VSYNC back porch =3D 34 */
>         {0xd4, 0x04}, /* RGBMIPICTRL: VSYNC front porch =3D 4 */
>  };
>
> @@ -717,15 +717,15 @@ static int khadas_ts050_panel_disable(struct drm_pa=
nel *panel)
>  }
>
>  static const struct drm_display_mode default_mode =3D {
> -       .clock =3D 120000,
> -       .hdisplay =3D 1088,
> -       .hsync_start =3D 1088 + 104,
> -       .hsync_end =3D 1088 + 104 + 4,
> -       .htotal =3D 1088 + 104 + 4 + 127,
> +       .clock =3D 160000,
> +       .hdisplay =3D 1080,
> +       .hsync_start =3D 1080 + 117,
> +       .hsync_end =3D 1080 + 117 + 5,
> +       .htotal =3D 1080 + 117 + 5 + 160,
>         .vdisplay =3D 1920,
>         .vsync_start =3D 1920 + 4,
> -       .vsync_end =3D 1920 + 4 + 2,
> -       .vtotal =3D 1920 + 4 + 2 + 3,
> +       .vsync_end =3D 1920 + 4 + 3,
> +       .vtotal =3D 1920 + 4 + 3 + 31,
>         .flags =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>  };
>
>
> --
> 2.34.1
>
Reviewed-by: Nicolas Belin <nbelin@baylibre.com>
Tested-by: Nicolas Belin <nbelin@baylibre.com> # on Khadas VIM3 + TS050 Pan=
el

Thanks,
Nicolas
