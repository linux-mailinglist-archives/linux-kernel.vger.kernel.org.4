Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA063C5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiK2Q72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiK2Q7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:59:10 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75BF71190
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:54:16 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w26-20020a056830061a00b0066c320f5b49so9491245oti.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GjK6wLJFPx5Ih8mUW+LXCJ4FyZfD2H0IDjVyBwYNMMM=;
        b=xiduauuFBf2qfRxNcUMRblnEUfLrPfAltlgt6lqpMgDqNSojAre/rwEQItqbThxdK8
         e9mJNQ8kCEEDk3ktRxHenkyE/OwMxS8Ra4weD/uf947jM5pSNzy1z9O2kGCR5oEMoiSu
         LnzV+RDiVe5kZ7+29ENuJ5K1J6RHnrx3PHYWrH/zBcZB9jKPZKxyfjBgZgU+jd8VAaH1
         xB4ki8zWbEzUd5O6HSsQCWD5aJjBm4C7H8yZn5K3WRZCIiE3Oktg/EV0P7B3jS4DBBJN
         Zi1ZSa7jopDccmcMsA1kgIS9LLPIKi1uSLU/uOFGW+LiQC6iBCPnUdFj7c9/bAQ/VFes
         T3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjK6wLJFPx5Ih8mUW+LXCJ4FyZfD2H0IDjVyBwYNMMM=;
        b=hkm9I8+qsiC9UCF7/y+F+ca+qLNktEqXDFSeA/hu6I59f8r2w1VZMYakNVInuYNELT
         0X9Qa6KIZ/4D0b/wv8oXJ3DlCSkKNXTVXOlSdUu5hRpJyzIUrOQL6fXmNjoZihxoHq5C
         wE8rqYyz0h0E/BeL2cvwT3HVi+kEFkCUZva7jIUi5dPIHvhl6gqjD56masB8txEHpEG5
         M+norA6HZaswQPYfCoIWFJo9qRBQR8Lfz1C+dgfSoDLDj/sHuHQLWCtb9iBnsGxXuimz
         FOZdKvuKiwOYP62YD7XHJGSKpRIUBP4ooOl1DJhwNESGqgZgJE0VQahofjqLBtPnWEfB
         /Gkw==
X-Gm-Message-State: ANoB5pm1+xTs6FTXj+g9wmkcjvhw7w75JiDJlafLun+yghO7GsxQr2ew
        FnX00s3fIqzxwGIbZbACPqtc+joVGH5AAQytLZ2rTISw+B55NAgL
X-Google-Smtp-Source: AA0mqf6Y98DrQOEDHEupyc5vTxxgwP7MNwATXauHvunrFi0GpgHwfmuVTpDmkh+ilLVYz4CM9XlG810hOdv0aIVLV5o=
X-Received: by 2002:a9d:61d6:0:b0:66d:685d:a138 with SMTP id
 h22-20020a9d61d6000000b0066d685da138mr28906736otk.208.1669740856030; Tue, 29
 Nov 2022 08:54:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668602942.git.mazziesaccount@gmail.com> <3f0ffbc27e6bcc208d32eb3bb94979a8ab28265f.1668602942.git.mazziesaccount@gmail.com>
In-Reply-To: <3f0ffbc27e6bcc208d32eb3bb94979a8ab28265f.1668602942.git.mazziesaccount@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 29 Nov 2022 17:54:05 +0100
Message-ID: <CAG3jFys-5sqCAtM99HyaEE-3XFNGn++kok3TCzhsFM7czXAXAQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v4 1/2] gpu: drm: sii902x: Use devm_regulator_bulk_get_enable()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matti,

Can you use an already used prefix for this commit title:
- drm/bridge: sii902x:

On Wed, 16 Nov 2022 at 14:03, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>
> Simplify using devm_regulator_bulk_get_enable()
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Robert Foss <robert.foss@linaro.org>
>
> ---
> I am doing a clean-up for my local git and encountered this one.
> Respinning as it seems this one fell through the cracks.
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 26 ++++----------------------
>  1 file changed, 4 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
> index 878fb7d3732b..f6e8b401069b 100644
> --- a/drivers/gpu/drm/bridge/sii902x.c
> +++ b/drivers/gpu/drm/bridge/sii902x.c
> @@ -171,7 +171,6 @@ struct sii902x {
>         struct drm_connector connector;
>         struct gpio_desc *reset_gpio;
>         struct i2c_mux_core *i2cmux;
> -       struct regulator_bulk_data supplies[2];
>         bool sink_is_hdmi;
>         /*
>          * Mutex protects audio and video functions from interfering
> @@ -1072,6 +1071,7 @@ static int sii902x_probe(struct i2c_client *client,
>         struct device *dev = &client->dev;
>         struct device_node *endpoint;
>         struct sii902x *sii902x;
> +       static const char * const supplies[] = {"iovcc", "cvcc12"};
>         int ret;
>
>         ret = i2c_check_functionality(client->adapter,
> @@ -1122,27 +1122,11 @@ static int sii902x_probe(struct i2c_client *client,
>
>         mutex_init(&sii902x->mutex);
>
> -       sii902x->supplies[0].supply = "iovcc";
> -       sii902x->supplies[1].supply = "cvcc12";
> -       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(sii902x->supplies),
> -                                     sii902x->supplies);
> +       ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies), supplies);
>         if (ret < 0)
> -               return ret;
> -
> -       ret = regulator_bulk_enable(ARRAY_SIZE(sii902x->supplies),
> -                                   sii902x->supplies);
> -       if (ret < 0) {
> -               dev_err_probe(dev, ret, "Failed to enable supplies");
> -               return ret;
> -       }
> +               return dev_err_probe(dev, ret, "Failed to enable supplies");
>
> -       ret = sii902x_init(sii902x);
> -       if (ret < 0) {
> -               regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
> -                                      sii902x->supplies);
> -       }
> -
> -       return ret;
> +       return sii902x_init(sii902x);
>  }
>
>  static void sii902x_remove(struct i2c_client *client)
> @@ -1152,8 +1136,6 @@ static void sii902x_remove(struct i2c_client *client)
>
>         i2c_mux_del_adapters(sii902x->i2cmux);
>         drm_bridge_remove(&sii902x->bridge);
> -       regulator_bulk_disable(ARRAY_SIZE(sii902x->supplies),
> -                              sii902x->supplies);
>  }
>
>  static const struct of_device_id sii902x_dt_ids[] = {
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
