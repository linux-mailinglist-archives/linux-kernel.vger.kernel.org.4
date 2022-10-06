Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9F5F6435
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiJFKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJFKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:13:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4198E0D6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 03:13:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y100so2092879ede.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0Cc4GbZXNPCe1BVChf4c/KU1cC2ESSTAYoltZLkJy+A=;
        b=Z0GZxEyQvK5oTZPhnsBgqc5RnbdxkvppOXbZwAmnU7WzDZEamGtL9XqROZKiKIuHWA
         noDNGbHFphGr8JiDPMj3xHHlerD24Z2WdoxskM5XH2wC7sIxyTyMf7veepqFlKBU/znJ
         mnbN6yR7mH4T51jfnhvnLcffRpM1zvl4lpYWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0Cc4GbZXNPCe1BVChf4c/KU1cC2ESSTAYoltZLkJy+A=;
        b=dfICM89vhThz8w9pEuqCwzoDa/+T4yjQUQ6gPHB6U+SZ63NrQ26EOC1oJ+lVg75tgW
         7Xr9xNuwamRc+EubiDmJiv44vcnXDw45ahX0YZiV22jSo/2oz9P/uP//QDUrU2yAMhoh
         0a+hJYfSHAcbbSK+tAkQqDE5z2hh/DfiQM3xgeoAtHvZqaUj7jEzVjqpKu+7xx/rwzec
         KRUwORiSoNFEg7QP8E6icqAA9f/oQsMatiECjE/x8f0SFZyuqMoLAm1d9WPFKgjRLXI0
         O2tXux/Ypi/CiLWtlXQl/MNiW8xz3ueWOlprNFmIGFVmZb4T3yARHKUy0rvIY9j3Hehz
         Csqw==
X-Gm-Message-State: ACrzQf3SrYQ47J6gtho/J89v8KFJ1vykGdPAZey8Nbj/2T7KOdXT2p4w
        JAHtMdANjoU9AkCPQm+YzmQhhIb09dcYFg==
X-Google-Smtp-Source: AMsMyM4QdR+NM9HwTcRN3uvgAT9AC325gsDRWi7oiX7AScCZ9Xi9cL+H8UBPFFmzxaVF4Idet98NkQ==
X-Received: by 2002:a05:6402:2547:b0:459:1752:2a97 with SMTP id l7-20020a056402254700b0045917522a97mr3821514edb.323.1665051193135;
        Thu, 06 Oct 2022 03:13:13 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906314600b007389c5a45f0sm10189245eje.148.2022.10.06.03.13.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 03:13:12 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id r17so3451993eja.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 03:13:11 -0700 (PDT)
X-Received: by 2002:a17:906:ee8e:b0:730:3646:d178 with SMTP id
 wt14-20020a170906ee8e00b007303646d178mr3424757ejb.426.1665051191080; Thu, 06
 Oct 2022 03:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220921092417.2579126-1-hidenorik@chromium.org>
In-Reply-To: <20220921092417.2579126-1-hidenorik@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 6 Oct 2022 19:12:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C-ZNgrXKnCj+o7=_6-9YUzCDeLX1SHa6yO7U_mgiY05g@mail.gmail.com>
Message-ID: <CAAFQd5C-ZNgrXKnCj+o7=_6-9YUzCDeLX1SHa6yO7U_mgiY05g@mail.gmail.com>
Subject: Re: [PATCH v3] media: ov8856: Add runtime PM callbacks
To:     Hidenori Kobayashi <hidenorik@chromium.org>
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hidenori,

On Wed, Sep 21, 2022 at 6:24 PM Hidenori Kobayashi
<hidenorik@chromium.org> wrote:
>
> There were no runtime PM callbacks registered, leaving regulators being
> enabled while the device is suspended on DT systems. Adjust and register
> existing power controlling functions to turn them off/on.
>
> Signed-off-by: Hidenori Kobayashi <hidenorik@chromium.org>
> ---
> V2 -> V3: Remove redundant wrappers (were added in V1)
> V1 -> V2: Change argument of power controlling functions
> ---
>  drivers/media/i2c/ov8856.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>

Thanks for the patch!

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

---

> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index a9728afc81d4..760611ee5485 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -2110,17 +2110,18 @@ static int ov8856_set_stream(struct v4l2_subdev *sd, int enable)
>         return ret;
>  }
>
> -static int __ov8856_power_on(struct ov8856 *ov8856)
> +static int ov8856_power_on(struct device *dev)
>  {
> -       struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> +       struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +       struct ov8856 *ov8856 = to_ov8856(sd);
>         int ret;
>
> -       if (is_acpi_node(dev_fwnode(&client->dev)))
> +       if (is_acpi_node(dev_fwnode(dev)))
>                 return 0;
>
>         ret = clk_prepare_enable(ov8856->xvclk);
>         if (ret < 0) {
> -               dev_err(&client->dev, "failed to enable xvclk\n");
> +               dev_err(dev, "failed to enable xvclk\n");
>                 return ret;
>         }
>
> @@ -2132,7 +2133,7 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
>         ret = regulator_bulk_enable(ARRAY_SIZE(ov8856_supply_names),
>                                     ov8856->supplies);
>         if (ret < 0) {
> -               dev_err(&client->dev, "failed to enable regulators\n");
> +               dev_err(dev, "failed to enable regulators\n");
>                 goto disable_clk;
>         }
>
> @@ -2148,17 +2149,20 @@ static int __ov8856_power_on(struct ov8856 *ov8856)
>         return ret;
>  }
>
> -static void __ov8856_power_off(struct ov8856 *ov8856)
> +static int ov8856_power_off(struct device *dev)
>  {
> -       struct i2c_client *client = v4l2_get_subdevdata(&ov8856->sd);
> +       struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +       struct ov8856 *ov8856 = to_ov8856(sd);
>
> -       if (is_acpi_node(dev_fwnode(&client->dev)))
> -               return;
> +       if (is_acpi_node(dev_fwnode(dev)))
> +               return 0;
>
>         gpiod_set_value_cansleep(ov8856->reset_gpio, 1);
>         regulator_bulk_disable(ARRAY_SIZE(ov8856_supply_names),
>                                ov8856->supplies);
>         clk_disable_unprepare(ov8856->xvclk);
> +
> +       return 0;
>  }
>
>  static int __maybe_unused ov8856_suspend(struct device *dev)
> @@ -2170,7 +2174,7 @@ static int __maybe_unused ov8856_suspend(struct device *dev)
>         if (ov8856->streaming)
>                 ov8856_stop_streaming(ov8856);
>
> -       __ov8856_power_off(ov8856);
> +       ov8856_power_off(dev);
>         mutex_unlock(&ov8856->mutex);
>
>         return 0;
> @@ -2184,7 +2188,7 @@ static int __maybe_unused ov8856_resume(struct device *dev)
>
>         mutex_lock(&ov8856->mutex);
>
> -       __ov8856_power_on(ov8856);
> +       ov8856_power_on(dev);
>         if (ov8856->streaming) {
>                 ret = ov8856_start_streaming(ov8856);
>                 if (ret) {
> @@ -2451,7 +2455,7 @@ static int ov8856_remove(struct i2c_client *client)
>         pm_runtime_disable(&client->dev);
>         mutex_destroy(&ov8856->mutex);
>
> -       __ov8856_power_off(ov8856);
> +       ov8856_power_off(&client->dev);
>
>         return 0;
>  }
> @@ -2477,7 +2481,7 @@ static int ov8856_probe(struct i2c_client *client)
>
>         full_power = acpi_dev_state_d0(&client->dev);
>         if (full_power) {
> -               ret = __ov8856_power_on(ov8856);
> +               ret = ov8856_power_on(&client->dev);
>                 if (ret) {
>                         dev_err(&client->dev, "failed to power on\n");
>                         return ret;
> @@ -2533,13 +2537,14 @@ static int ov8856_probe(struct i2c_client *client)
>         mutex_destroy(&ov8856->mutex);
>
>  probe_power_off:
> -       __ov8856_power_off(ov8856);
> +       ov8856_power_off(&client->dev);
>
>         return ret;
>  }
>
>  static const struct dev_pm_ops ov8856_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(ov8856_suspend, ov8856_resume)
> +       SET_RUNTIME_PM_OPS(ov8856_power_off, ov8856_power_on, NULL)
>  };
>
>  #ifdef CONFIG_ACPI
> --
> 2.37.3.968.ga6b4b080e4-goog
>
