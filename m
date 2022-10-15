Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6B15FF87F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 07:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJOFCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 01:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJOFCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 01:02:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474F5E675;
        Fri, 14 Oct 2022 22:02:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s2so9351712edd.2;
        Fri, 14 Oct 2022 22:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wl1CNvTcx9C1NQyxDr1FjFvdKECNGo52b0NkbSv8Mmc=;
        b=eeEFSLmnT9lXGWLDZPg3qEuKFzVzewXktLASJcGO1yeOQa6W468Eyao+PTciOZro0O
         2kkS6pAT9/AVx77VvqNTvHE5FGO3Ma4X2eB8v0Djy2ysj+mM7EcHDJjLfkX5SX4IB5f1
         JSwiKxv7Q3KOuhfimSjLrcH25x3Xx243vfq0RyGeRF+rKjWi2Ex6/5rNx2cdkTAE/FGJ
         UEsFTLBMT59CeTFv2N3lO5vcT2QBDIHo6L1nfqEVgDGZXNSat69+Ytg29rd6VQkQIYwv
         UGBNL/0ewVnuAutYiUWuL04qQfK2isRdP6RfVwgIliEr+cb8XboD7YQDKbToOe03X+WN
         VSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl1CNvTcx9C1NQyxDr1FjFvdKECNGo52b0NkbSv8Mmc=;
        b=IggGroHlWPpM7FKvP3+850Q00yoBxzfm8Cqvx1JbhZAoTvNWROYH4CTYJABrm/bNoP
         /EV0lfupAWRSlqiFoNOa2CERJ2FlEbR4P53rZlp9ZFjsJK8VPS7qupBiiD6dzl11ZXfI
         RlTbFM0ORLuf2ba5c3ySXJEP3M6qNnhaJaRf3pYd1Wn2X7TvEMoWK7UQ6xdizhHdvVPS
         BF6DG06HlsWvWuS9QodYuz8RQYaCoUow7uVxTHjnqzNvra1vuJT47JOBjBSfMUNcWo+l
         2idoaLNPppkMHozQgjWvWV13RyijI2AZQa2s3j5lHWB1cahG+2mHo95Nb+RD2R+ACatp
         DQLw==
X-Gm-Message-State: ACrzQf1gtVnp+efe9i5vVJuZTFj7lydQBY1nDBU7n6usqLdkC9xbbXQe
        aXzZyOz/iLj0jASZRN6cZqg=
X-Google-Smtp-Source: AMsMyM54Lfi2ufHuB3MBb1iQmFpjDzYeJlaCPnd3NnEocdemnj5EaHumfDM1UvRGifRen6uZM5nTKQ==
X-Received: by 2002:aa7:c314:0:b0:458:dc90:467a with SMTP id l20-20020aa7c314000000b00458dc90467amr907854edq.284.1665810137987;
        Fri, 14 Oct 2022 22:02:17 -0700 (PDT)
Received: from penguin ([57.190.1.13])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7da83000000b00458a243df3esm2999482eds.65.2022.10.14.22.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 22:02:17 -0700 (PDT)
Date:   Fri, 14 Oct 2022 22:01:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 5/9] gpiolib: of: add a quirk for reset line for
 Marvell NFC controller
Message-ID: <Y0o+wXYe9mXOuI58@penguin>
References: <20221011-gpiolib-quirks-v2-0-73cb7176fd94@gmail.com>
 <20221011-gpiolib-quirks-v2-5-73cb7176fd94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v2-5-73cb7176fd94@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 10:54:29AM -0700, Dmitry Torokhov wrote:
> The controller is using non-standard "reset-n-io" name for its reset
> gpio property, whereas gpiod API expects "<name>-gpios". Add a quirk
> so that gpiod API will still work on unmodified DTSes.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib-of.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 2b5d1b3095c7..5c11ee7638d1 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -390,6 +390,16 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
>  #if IS_ENABLED(CONFIG_MFD_ARIZONA)
>  		{ "wlf,reset",	NULL,		NULL },
>  #endif
> +
> +#if IS_ENABLED(CONFIG_NFC_MRVL_I2C)
> +		{ "reset",	"reset-n-io",	"marvell,nfc-i2c" },
> +#endif
> +#if IS_ENABLED(CONFIG_NFC_MRVL_SPI)
> +		{ "reset",	"reset-n-io",	"marvell,nfc-spi" },
> +#endif
> +#if IS_ENABLED(CONFIG_NFC_MRVL_UART)
> +		{ "reset",	"reset-n-io",	"marvell,nfc-uart" },

I just noticed that there is another compatible (not documented, so I
assume it is a legacy one): "mrvl,nfc-uart", so I will be adding it and
sending another version.

Thanks.

-- 
Dmitry
