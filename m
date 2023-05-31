Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8253717BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjEaJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjEaJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:21:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FDE6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:21:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-33b416c96fcso7082825ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685524887; x=1688116887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqZtyuK0U15DxZmjBsyfHeiLrrKr6W4JwftADT3FJhk=;
        b=4qC36suMHU6JStzGoINSAsJQMh6mklFEHuUchbO29b+s0jEjA05FUl6zoMoZcTpZoS
         oeAvnDggv/NdN2RHO/JYaxxkKjcQoymLf3On58NMUTcsUBHLwtd14mlCoObYepeZMGa4
         28CkUtsq8b3j0z9EF0NCRn4YdLem/92uWjpocIG3rpbUd62MbyOSLDPLlAYbefN99eVN
         qkYl99/Z2FZGjA8YGrchPpbz9bF4eFTxEux1kINW7KpiemoLomj85QHY4OchO4y80p3/
         4OySMVSLs9R/36wFuR2T7//IUiL4BuyFweh4QGIvJDrI7xyZp0VqvGcTGWIuxJ0EdEv1
         nEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524887; x=1688116887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqZtyuK0U15DxZmjBsyfHeiLrrKr6W4JwftADT3FJhk=;
        b=FWUtxAwygzJeVZP7YtkoOboHW71x/gDCQxLOfw6ed2R2a8rvZ0CfkfeG2AOvczYSOq
         qiJnenDTfXd/VkJTlQD3gwL2Q3eaasmY2dyotSnzaGMsu3vjPBuWuVId8O775T5qzp8R
         ilQfOVGl1MPiTdejcKMui+5wqHgZyYtSEOQ+BdzH66aBv9DOL2tXFW8v89P7uLzm+DXx
         wMScCL+DNFp46dSnXEboSEsmptNf6ja/80/hRCvcemdinu8Wa/3Eq3BlQlqfEo89Ltej
         FZvOZ8Z7+T9aftr6yDsKr/j6IGekefwpMQEig9BtLcGiYVqL7Ux6na8lmNnmj5nwvObd
         ECgA==
X-Gm-Message-State: AC+VfDzg82IeAvMIRrwLS/PYO2pIm7gsptjewcOa8uK6u4nrfT0X2iC6
        I6t0cF/bkLBJ9o0vD80kYJj1pea8PL7O/YgqeIC7iQ==
X-Google-Smtp-Source: ACHHUZ7LyNPt0HxypRayhfIi1WaR82cDETNK2Qlv3mO6R6AEg1TP7OgHUVcQmfU3nr4LBKzkcW68vrtg/txWvI6ifcw=
X-Received: by 2002:a92:d0c3:0:b0:33b:16e9:bba5 with SMTP id
 y3-20020a92d0c3000000b0033b16e9bba5mr1903781ila.28.1685524887536; Wed, 31 May
 2023 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-9-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-9-56eb7a4d5b8e@linaro.org>
From:   Nicolas Belin <nbelin@baylibre.com>
Date:   Wed, 31 May 2023 11:21:16 +0200
Message-ID: <CAJZgTGF7VJEW0-5Gctfft6r-9tFzw9oFV8hmeEqhSUrqmQ3tZg@mail.gmail.com>
Subject: Re: [PATCH v5 09/17] drm/meson: only use components with dw-hdmi
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
> Only DW-HDMI currently needs components since it reuses
> the drm-meson driver context to access HHI registers (sic).
>
> Once this is solved, we can get rid on components.
>
> Until now, limit the components matching to the dw-hdmi compatibles
> we know to require this hack, for other bridges simply use probe defer
> instead and get over this components sitation.
>
> The back story is that we simply cannot attach DSI adapters bridges
> if we use components, only DSI panels, this is because we bind/unbind
> the DSI controller at each drm-meson driver master bind tentative.
> With this the I2C DSI bridge is unable to find the DSI controller
> host and everything fails to probe.
>
> This will simplify a lot adding new or older HDMI bridges.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/me=
son_drv.c
> index e060279dc80a..e935c0286a20 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -451,10 +451,17 @@ static void meson_drv_shutdown(struct platform_devi=
ce *pdev)
>         drm_atomic_helper_shutdown(priv->drm);
>  }
>
> -/* Possible connectors nodes to ignore */
> -static const struct of_device_id connectors_match[] =3D {
> -       { .compatible =3D "composite-video-connector" },
> -       { .compatible =3D "svideo-connector" },
> +/*
> + * Only devices to use as components
> + * TOFIX: get rid of components when we can finally
> + * get meson_dx_hdmi to stop using the meson_drm
> + * private structure for HHI registers.
> + */
> +static const struct of_device_id components_dev_match[] =3D {
> +       { .compatible =3D "amlogic,meson-gxbb-dw-hdmi" },
> +       { .compatible =3D "amlogic,meson-gxl-dw-hdmi" },
> +       { .compatible =3D "amlogic,meson-gxm-dw-hdmi" },
> +       { .compatible =3D "amlogic,meson-g12a-dw-hdmi" },
>         {}
>  };
>
> @@ -472,17 +479,12 @@ static int meson_drv_probe(struct platform_device *=
pdev)
>                         continue;
>                 }
>
> -               /* If an analog connector is detected, count it as an out=
put */
> -               if (of_match_node(connectors_match, remote)) {
> -                       ++count;
> -                       of_node_put(remote);
> -                       continue;
> -               }
> -
> -               dev_dbg(&pdev->dev, "parent %pOF remote match add %pOF pa=
rent %s\n",
> -                       np, remote, dev_name(&pdev->dev));
> +               if (of_match_node(components_dev_match, remote)) {
> +                       component_match_add(&pdev->dev, &match, component=
_compare_of, remote);
>
> -               component_match_add(&pdev->dev, &match, component_compare=
_of, remote);
> +                       dev_dbg(&pdev->dev, "parent %pOF remote match add=
 %pOF parent %s\n",
> +                               np, remote, dev_name(&pdev->dev));
> +               }
>
>                 of_node_put(remote);
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
