Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35124661125
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjAGSrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:47:52 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28C1FAC1;
        Sat,  7 Jan 2023 10:47:50 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id o63so4678444vsc.10;
        Sat, 07 Jan 2023 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hl69kOgS+yzRDDvDtZt5BHX9x7maB/n0P+iHqQiUgy0=;
        b=Devi/Aw9jT9N/qHkwOrvA2ZGjdyurn6O5TD023eBdxra/E9harS5Hq4G/jk//R2msX
         j296rrqFb7hwvzzvXu/lBboxZXge+mVGKJSiKokbCp0x3qytsAGa90+kxgZT4sM1g3um
         IWIv5+CJrIxtyWM/camS5T6VyqGSXyXaFPze/TPEONbcxRKkaoufwN5pty4li04Fqwmr
         dTYptuJ9zK5CNGiRUN11GXMP71pH8OTQZKscF7Wb6afD0jTr9yijL3r/dTkcMBh/y6y0
         jnsvG1sejoqElfX6UYcxKHlgtfcwsBqxcm17Ywy0J0WQXoVHjsV9PoyzB31PCmuVSQ7j
         KWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hl69kOgS+yzRDDvDtZt5BHX9x7maB/n0P+iHqQiUgy0=;
        b=EInB9u7Rb/Fa1YkgF8EZDBE6qOMyj09n8yE0qKZ0OJWw+RjoB8WHL/ZYnRk6O46njA
         JFUJfY44LvX+qcar69JaJUlV5jddHQiNJllfMhM8zyKKf5GPzPqkhQT4SW4mA4VADeOZ
         ysGvVXJwpE9LVkqIkMds1DWSgxH/KPxUJdm16kH/vRWBearIw/VoZuVVIgEkROrpFEK7
         v1w4kLSdAPSjChlSlEdVU+Ucdu3L6j5OSMwO4dVLRGNsjK/Dy6AK9UW2CCmYtaPCxO5d
         z1iY2fZGts6m85VsG5rT07fi9jFQvIVOSlqySS1jARre/x4O5nckeyuGHSAxipfWqLFQ
         vevw==
X-Gm-Message-State: AFqh2kobIKHseE//gTe9YarJCoCWFvf6aV/BE263alc4l4QfaElFpxZg
        FjPSAR0p4MOJtJVxuF0T15zcq/RdgGIulPLSXRI=
X-Google-Smtp-Source: AMrXdXvfsm1TArlC3IaUkU7rTskyuVrBWE9CrRPNQXzfXEGBjD7tyvjEL+U2351v3fCH1mEt3OhM6bGv94EqkY6dxFY=
X-Received: by 2002:a67:fe44:0:b0:3ce:3974:4558 with SMTP id
 m4-20020a67fe44000000b003ce39744558mr3464675vsr.0.1673117269806; Sat, 07 Jan
 2023 10:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-14-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-14-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Sat, 7 Jan 2023 19:47:34 +0100
Message-ID: <CAH+2xPB=jBKj=qzay-YsHSRXFZ+0Ln_LuVe0griHXYLsYEwFJw@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] rtc: pcf2127: add flag for watchdog register
 value read support
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> The watchdog value register cannot be read on the PCF2131 after being
> set.
>
> Add a new flag to identify which variant has read access to this
> register, and use this flag to selectively test if watchdog timer was
> started by bootloader.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

> ---
>  drivers/rtc/rtc-pcf2127.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 3fd2fee4978b..1d2b5c9e6757 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -214,6 +214,7 @@ struct pcf21xx_config {
>         int max_register;
>         unsigned int has_nvmem:1;
>         unsigned int has_bit_wd_ctl_cd0:1;
> +       unsigned int wd_val_reg_readable:1; /* If watchdog value register can be read. */
>         unsigned int has_int_a_b:1; /* PCF2131 supports two interrupt outputs. */
>         unsigned int has_reset_reg:1; /* If variant has a reset register. */
>         u8 regs_td_base; /* Time/data base registers. */
> @@ -511,7 +512,6 @@ static const struct watchdog_ops pcf2127_watchdog_ops = {
>
>  static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
>  {
> -       u32 wdd_timeout;
>         int ret;
>
>         if (!IS_ENABLED(CONFIG_WATCHDOG) ||
> @@ -539,12 +539,17 @@ static int pcf2127_watchdog_init(struct device *dev, struct pcf2127 *pcf2127)
>         watchdog_set_drvdata(&pcf2127->wdd, pcf2127);
>
>         /* Test if watchdog timer is started by bootloader */
> -       ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_wd_val, &wdd_timeout);
> -       if (ret)
> -               return ret;
> +       if (pcf2127->cfg->wd_val_reg_readable) {
> +               u32 wdd_timeout;
> +
> +               ret = regmap_read(pcf2127->regmap, pcf2127->cfg->reg_wd_val,
> +                                 &wdd_timeout);
> +               if (ret)
> +                       return ret;
>
> -       if (wdd_timeout)
> -               set_bit(WDOG_HW_RUNNING, &pcf2127->wdd.status);
> +               if (wdd_timeout)
> +                       set_bit(WDOG_HW_RUNNING, &pcf2127->wdd.status);
> +       }
>
>         return devm_watchdog_register_device(dev, &pcf2127->wdd);
>  }
> @@ -953,6 +958,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .max_register = 0x1d,
>                 .has_nvmem = 1,
>                 .has_bit_wd_ctl_cd0 = 1,
> +               .wd_val_reg_readable = 1,
>                 .has_int_a_b = 0,
>                 .has_reset_reg = 0,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> @@ -980,6 +986,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .max_register = 0x19,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
> +               .wd_val_reg_readable = 1,
>                 .has_int_a_b = 0,
>                 .has_reset_reg = 0,
>                 .regs_td_base = PCF2127_REG_TIME_DATE_BASE,
> @@ -1007,6 +1014,7 @@ static struct pcf21xx_config pcf21xx_cfg[] = {
>                 .max_register = 0x36,
>                 .has_nvmem = 0,
>                 .has_bit_wd_ctl_cd0 = 0,
> +               .wd_val_reg_readable = 0,
>                 .has_int_a_b = 1,
>                 .has_reset_reg = 1,
>                 .regs_td_base = PCF2131_REG_TIME_DATE_BASE,
> --
> 2.30.2
>
