Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D1E717BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjEaJUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbjEaJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:19:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579DBE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:19:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64fbfe0d037so547155b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685524783; x=1688116783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/F8jIF8NqATxdAvMuHV954nGjADHoS+vIBQmhEkWOs=;
        b=g2QKglMZH/mJ1PlHw0xaAb1Atu0wvBgVAqYnuu8mReQEONCqAC+kuvmXr1GOl2K8hi
         PELXRr9/ZHFzDZ1y3TGPnhTkxyRxzi2WWpiULuLFvRre0MOUR2wmfXd4PYcyHYisgga9
         vIxf3UCExwjWT2hL5wZhyPw1/THRLmg9F35utlvE2h3bHMSJOdGF1FVhqXM8zvkuKeiA
         QDOmg7HzxXmpRYriQ+VggWvGgLlVCw55VPwJnR21xsMdQuKGIVaBL+9JKvxwHIb3unI0
         dNbqyoJWOojJolHETOZRlnmey1S+0lkpPlrlK4bJKbtj2DG0b51oWPxTwnJeIwJ9apJ4
         TZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685524783; x=1688116783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/F8jIF8NqATxdAvMuHV954nGjADHoS+vIBQmhEkWOs=;
        b=Nj7hrURl6FAmrCdr2nf/wFVhgGq19uMwa7Ttc+/oGHEcIz0JMd2jtkzOkkWgbWsRrM
         DCK8cAKaOU+A/MNxksii3br/GW+QqeSd4B+eeKmTgvuZeoJZLl7EVdwR44BRMwNlAMFo
         CFs8Sxznjnut8QJCBUe90ucQsOtJM2pqG8FMWi5Uq6MEKaX183IEZhGHl1WlGZXZXv/y
         Ne6yYArvXeD+HVueg3NjApm14i1qtArY+ettfhyYKOvYZdd7V2uwt262joAGgXsd30l4
         Bl9tXmNjEA0Cj8iIEmvQIfPtllBVBCs1evpyYAI28WVIii5YApW7T3VP+xkPWvlEuEaD
         soNg==
X-Gm-Message-State: AC+VfDxpc4lmOzEpXxNV9yFNznCkTwYGdcH8YMQkIrpUkNJackq7LyxY
        3kbr0lpUxJFAbmvkMrWt0+i1XwgbW9uo8XwfXK52kw==
X-Google-Smtp-Source: ACHHUZ6Ofzg7tjk5fXnBtT7CKLOKxvtwCuBdh95OKJ7ZvI9XlppTjSg852EOtBKSeeNZAfFL9zCpUaqHc9KwNzmaA5U=
X-Received: by 2002:a17:902:e744:b0:1ac:86b5:70d9 with SMTP id
 p4-20020a170902e74400b001ac86b570d9mr14542055plf.32.1685524783362; Wed, 31
 May 2023 02:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-8-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-8-56eb7a4d5b8e@linaro.org>
From:   Nicolas Belin <nbelin@baylibre.com>
Date:   Wed, 31 May 2023 11:19:32 +0200
Message-ID: <CAJZgTGEQ3B5M9BtDfUdyMiH+VQkWcFHU2fOJgE_1=a4E1bxMTA@mail.gmail.com>
Subject: Re: [PATCH v5 08/17] drm/meson: fix unbind path if HDMI fails to bind
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 30 mai 2023 =C3=A0 09:38, Neil Armstrong
<neil.armstrong@linaro.org> a =C3=A9crit :
>
> If the case the HDMI controller fails to bind, we try to unbind
> all components before calling drm_dev_put() which makes drm_bridge_detach=
()
> crash because unbinding the HDMI controller frees the bridge memory.
>
> The solution is the unbind all components at the end like in the remove
> path.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/me=
son_drv.c
> index ca6d1e59e5d9..e060279dc80a 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -316,32 +316,34 @@ static int meson_drv_bind_master(struct device *dev=
, bool has_components)
>                 goto exit_afbcd;
>
>         if (has_components) {
> -               ret =3D component_bind_all(drm->dev, drm);
> +               ret =3D component_bind_all(dev, drm);
>                 if (ret) {
>                         dev_err(drm->dev, "Couldn't bind all components\n=
");
> +                       /* Do not try to unbind */
> +                       has_components =3D false;
>                         goto exit_afbcd;
>                 }
>         }
>
>         ret =3D meson_encoder_hdmi_init(priv);
>         if (ret)
> -               goto unbind_all;
> +               goto exit_afbcd;
>
>         ret =3D meson_plane_create(priv);
>         if (ret)
> -               goto unbind_all;
> +               goto exit_afbcd;
>
>         ret =3D meson_overlay_create(priv);
>         if (ret)
> -               goto unbind_all;
> +               goto exit_afbcd;
>
>         ret =3D meson_crtc_create(priv);
>         if (ret)
> -               goto unbind_all;
> +               goto exit_afbcd;
>
>         ret =3D request_irq(priv->vsync_irq, meson_irq, 0, drm->driver->n=
ame, drm);
>         if (ret)
> -               goto unbind_all;
> +               goto exit_afbcd;
>
>         drm_mode_config_reset(drm);
>
> @@ -359,15 +361,18 @@ static int meson_drv_bind_master(struct device *dev=
, bool has_components)
>
>  uninstall_irq:
>         free_irq(priv->vsync_irq, drm);
> -unbind_all:
> -       if (has_components)
> -               component_unbind_all(drm->dev, drm);
>  exit_afbcd:
>         if (priv->afbcd.ops)
>                 priv->afbcd.ops->exit(priv);
>  free_drm:
>         drm_dev_put(drm);
>
> +       meson_encoder_hdmi_remove(priv);
> +       meson_encoder_cvbs_remove(priv);
> +
> +       if (has_components)
> +               component_unbind_all(dev, drm);
> +
>         return ret;
>  }
>
>
> --
> 2.34.1
>

Works fine on a Khadas VIM3 using a TS050 panel,
Thanks

Reviewed-by: Nicolas Belin <nbelin@baylibre.com>
Tested-by: Nicolas Belin <nbelin@baylibre.com>
