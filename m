Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB0C63C5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbiK2Q7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbiK2Q6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:58:50 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707B45C0DA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:53:30 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id h132so15868674oif.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nX3XDw+aJWbqG71jNK2XOm8EYBY4nRDO50tiBkk6nzE=;
        b=eZGUMebShf+nYBcnZ7+qSuog/s1H+Yimyzp9jVbMHDnUyBIOtfdsnqOmKxJgXhilUd
         kCXBn7Yj1M1Lji4/kmPp22ZbV8L2bYAvIcl9J+UYTD9d7jjjdIF6ZBGC1sYmCukK7y+w
         6aFYnilDbD+HyK8J/Y4o/PtDq/xStFYCLkAEVDmMwchKt2sw+M0T+CCo68KLN2fjES/t
         VWiWU7c/hgJb8sW+E/qFU6bABXcp+OnEMRzS53qibSrm9O5I+6nRBFva891L6ph/KSbC
         zyuy1HPdFjuz3+iSiKFzARg/85GaMyGxDMYRiciqzd8wWdWoOd2TFNu1zf1zYgSkvH80
         ShBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nX3XDw+aJWbqG71jNK2XOm8EYBY4nRDO50tiBkk6nzE=;
        b=n5QYVZNOfC56HyMP08IKUOG7f63Bt1x67LXCPIbxRSqFwYO4IM92mt6aJtl3nR9eEW
         N+rgDFOI75BUWH+kIMfGXau244CFLAYDWE/zn5kdjqEEWM6DnfnP/VPQ9C/hjAnlxbO/
         4GJ+A1bxY2U/vyfpoR4YhdmleC/054hN9lNRvH1h93wI/3XuAGX3d6LHII7M0AUiz/Fr
         4BUifC6abLJhSr5/eHsuCjsSIhHPyAbFoWZPkzHV5zd6vU8uZL+vf9VBlIoQXn/54Spf
         ONP3zJUAQhFAwnH69MR8StXw/kUWbJgxr8noiYGET3kM8nL9tY/OPA9OCoLneISPX0Sc
         8iLw==
X-Gm-Message-State: ANoB5plQIuOouQITI0KEaTMkxNDIwr6v0Xv/IkkIA40Y7YwPGc9FRM4z
        dM3rO7PF8J9/vxhPe/DiDiwjaqeM+IVeFe+37Os9fw==
X-Google-Smtp-Source: AA0mqf5IXY8LzctaU4Fl4SjDm7702lMsmNWFfYQL6NXNStETLNdQMSdiKZ9Qj80YpnL+BWAZoUuLwX40hFVJgAK67OI=
X-Received: by 2002:aca:2801:0:b0:35a:13f4:d875 with SMTP id
 1-20020aca2801000000b0035a13f4d875mr30406072oix.190.1669740809533; Tue, 29
 Nov 2022 08:53:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668602942.git.mazziesaccount@gmail.com> <a2f0835e8d3b5f5768d887ce47a1575ae11b19f0.1668602942.git.mazziesaccount@gmail.com>
In-Reply-To: <a2f0835e8d3b5f5768d887ce47a1575ae11b19f0.1668602942.git.mazziesaccount@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 29 Nov 2022 17:53:18 +0100
Message-ID: <CAG3jFytRrhzWj+ka+fSK=cQfhg83pK9ZJAH4u5aRGnCmzJAZqg@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 2/2] gpu: drm: meson: Use devm_regulator_*get_enable*()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prefix to the commit title is a new one, let's use an existing one:
- drm/meson: dw-hdmi:
- drm: meson: dw-hdmi:

On Wed, 16 Nov 2022 at 14:04, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> Simplify using the devm_regulator_get_enable_optional(). Also drop the
> seemingly unused struct member 'hdmi_supply'.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>
> ---
> I am doing a clean-up for my local git and encountered this one.
> Respinning as it seems this one fell through the cracks.
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index 5cd2b2ebbbd3..7642f740272b 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -140,7 +140,6 @@ struct meson_dw_hdmi {
>         struct reset_control *hdmitx_apb;
>         struct reset_control *hdmitx_ctrl;
>         struct reset_control *hdmitx_phy;
> -       struct regulator *hdmi_supply;
>         u32 irq_stat;
>         struct dw_hdmi *hdmi;
>         struct drm_bridge *bridge;
> @@ -665,11 +664,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
>
>  }
>
> -static void meson_disable_regulator(void *data)
> -{
> -       regulator_disable(data);
> -}
> -
>  static void meson_disable_clk(void *data)
>  {
>         clk_disable_unprepare(data);
> @@ -723,20 +717,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>         meson_dw_hdmi->data = match;
>         dw_plat_data = &meson_dw_hdmi->dw_plat_data;
>
> -       meson_dw_hdmi->hdmi_supply = devm_regulator_get_optional(dev, "hdmi");
> -       if (IS_ERR(meson_dw_hdmi->hdmi_supply)) {
> -               if (PTR_ERR(meson_dw_hdmi->hdmi_supply) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -               meson_dw_hdmi->hdmi_supply = NULL;
> -       } else {
> -               ret = regulator_enable(meson_dw_hdmi->hdmi_supply);
> -               if (ret)
> -                       return ret;
> -               ret = devm_add_action_or_reset(dev, meson_disable_regulator,
> -                                              meson_dw_hdmi->hdmi_supply);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret = devm_regulator_get_enable_optional(dev, "hdmi");
> +       if (ret != -ENODEV)
> +               return ret;
>
>         meson_dw_hdmi->hdmitx_apb = devm_reset_control_get_exclusive(dev,
>                                                 "hdmitx_apb");
> --
> 2.38.1
>
>
> --
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =]
