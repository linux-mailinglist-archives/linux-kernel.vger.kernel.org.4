Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E96DAB43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbjDGKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbjDGKKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:10:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB504C3F;
        Fri,  7 Apr 2023 03:10:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id o3so861709lfd.12;
        Fri, 07 Apr 2023 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680862233;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AV2F4DSz+hAoPsBNchYpKP8BCe+dN7CqxHM1THS5IQ0=;
        b=jtcPqo9Nzp/sRPesvPFdYJrtzFvHqBua33jYxPt9ouLKx6u8j/8spna48t0xnQOsCs
         C6ullEloa94nBjloYClYwfHGx4VOB41ES/Iw5dpeiMGKVriYSDOV4toQ4fKnF6G/J8On
         w7Yz6OpWm7dtIXxvSmR8Bo+MAxOOFjCA8LeTsznTA2fx1KNgu+N2JH5eMFAHqhW8R3EJ
         ATZMTxiUkcESt7T7ZX3OOtIlQv10WgWdS+Hs8//oNxPOx9C1iZ4uUIbKweZJoPRJOelh
         nT3D2M8GgjFsR4eIf2qihwDMJkB6u2P3d7PqcIQ4Xc+SsY767/6mAJEpO7YlMtN2kgWU
         H9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680862233;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AV2F4DSz+hAoPsBNchYpKP8BCe+dN7CqxHM1THS5IQ0=;
        b=gFuxh/fGkN+AeBJuYXFhOHY+LzWFSoLY8Rz2mCjrDalpjwrm8yVhRkXFeNHO6vINKt
         NyKkhFRUrBLSdlxrZ0zbHCBgqsMzOOxXP0cyl/JXJXouJE0SGPWdS5vh9ROWYjkZd53t
         CaKRWUjH3rJ6n/ZyHyofu1J24+aDNusq8NucwAEOtXPW0umPFexjvek0037/n60wJscI
         01c/FjDj1gUGQvn4FxDoAr5x62KSn5G2CFnSiI8aeeEtUhXGKJafOPpyCtP2MZioi4r1
         L+PaVqwADPfUGYih22U8fXrDPDfoJvuWgY7JuQ5m5jNSPQKXmsIoZt4Y8NICslxT9Z3O
         d9pA==
X-Gm-Message-State: AAQBX9dgcNS2Drm7xZjLiV9INxS4LPMxHLkTl0vTegFvdfFcAh+K4/JX
        0QDRn8+mKAjUvPBi2TwGofs6dG5Ua7g=
X-Google-Smtp-Source: AKy350br/Td7o2c/LAJhdK5O38l6fhc+mxteoTiiKRQb3dpdqHGT4CokLccW1bx7vT5KcfJZWFttPA==
X-Received: by 2002:a05:6512:3885:b0:4ea:f526:5bee with SMTP id n5-20020a056512388500b004eaf5265beemr648395lft.11.1680862233175;
        Fri, 07 Apr 2023 03:10:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id h26-20020a19701a000000b004e1b880ba20sm630423lfc.292.2023.04.07.03.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 03:10:32 -0700 (PDT)
Message-ID: <1f6b470d-7740-8b0f-6c1d-a4a986d1c0c8@gmail.com>
Date:   Fri, 7 Apr 2023 13:10:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c
 LED driver
Content-Language: en-US, en-GB
To:     Andreas Kemnade <andreas@kemnade.info>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230407050803.170773-1-andreas@kemnade.info>
 <20230407050803.170773-3-andreas@kemnade.info>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230407050803.170773-3-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 08:08, Andreas Kemnade wrote:
> The device provides 6 channels which can be individually
> turned off and on but groups of two channels share a common brightness
> register.
> 
> Limitation: The GPIO to enable the device is not used yet.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/leds/Kconfig          |  11 +++
>   drivers/leds/Makefile         |   1 +
>   drivers/leds/leds-bd2606mvv.c | 143 ++++++++++++++++++++++++++++++++++
>   3 files changed, 155 insertions(+)
>   create mode 100644 drivers/leds/leds-bd2606mvv.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9dbce09eabacf..cc4eadbb2542e 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -551,6 +551,17 @@ config LEDS_REGULATOR
>   	help
>   	  This option enables support for regulator driven LEDs.
>   
> +config LEDS_BD2606MVV
> +	tristate "LED driver for BD2606MVV"
> +	depends on LEDS_CLASS
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  This option enables support for BD2606MVV LED driver chips
> +	  accessed via the I2C bus. It supports setting brightness, with
> +	  the limitiation that there are groups of two channels sharing
> +	  a brightness setting, but not the on/off setting.
> +
>   config LEDS_BD2802
>   	tristate "LED driver for BD2802 RGB LED"
>   	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index d30395d11fd84..c07d1512c745a 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
>   obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
>   obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
>   obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
> +obj-$(CONFIG_LEDS_BD2606MVV)		+= leds-bd2606mvv.o
>   obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
>   obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
>   obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
> diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
> new file mode 100644
> index 0000000000000..808100e50487c
> --- /dev/null
> +++ b/drivers/leds/leds-bd2606mvv.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Andreas Kemnade
> + *
> + * Datasheet:
> + * https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/led_driver/bd2606mvv_1-e.pdf
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#define BD2606_MAX_LEDS 6
> +#define BD2606_MAX_BRIGHTNESS 63
> +#define BD2606_REG_PWRCNT 3
> +#define ldev_to_led(c)	container_of(c, struct bd2606mvv_led, ldev)
> +
> +struct bd2606mvv_led {
> +	bool active;

I still think having this 'active' here for the whole lifetime of the 
driver is a bit misleading. This, however, is a minor thing. With or 
without the 'active' removed from the private data:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

