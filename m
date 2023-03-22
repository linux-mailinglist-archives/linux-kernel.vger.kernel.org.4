Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3CB6C4FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCVQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjCVQA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:00:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E1B6546D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:00:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y14so17624403wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679500823;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b1A56twIdd4XdlBDQ/o8uz6vaFh0/U1CPyi1UN3+GrI=;
        b=ziXK8E/wvSN6p/5FBJRC6CeiEKqO6RkykeFO/BFCiquAcE1xwEpmgdBsP0b9k9LkGe
         MJLn8PdV/rIj6jeU7DkN9FICKLG5P7nSYucrtEw3UUo0iVyzjsuk0Xe4CNKMWfhlsTvv
         alfKa4MrwfRxcdT+XVy8cIxUN6FBl1Z3elzCSi3EKqXlmVS+ZCB5OhSbUw7e0whuxGAv
         4vBx8T7V4eEfNyiwZJ8/JvRv2FxCYPyy3nSZjcmw98qwImaZ1uEgfBaWvpvQZOPhrBi0
         dFqvicKLRZg9sBRzzbW3lHrxmOciOjKjZ5Uqp2OJ/Vtj0e5L2em0MYotmU5QKoDBWSZe
         ePIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500823;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1A56twIdd4XdlBDQ/o8uz6vaFh0/U1CPyi1UN3+GrI=;
        b=XzZ+oCv5EXb6QeClVJzuuTW/dW8d86pYGpPo2KpC/wFr5zTQj7CfPA7FywCt2QZuD6
         IB9ikBQOI8KYrDllu8sIuztHV5wO1IUTCAdp3LVC0v9mrT43/lmulyFgzmslcjYqlKUs
         vafzZdWFi9+ydT8lTPKflfDJlZ1bIU2UCKvbiYwhvxIjxa1p/wggjZqO64dlFjePyff6
         X9npaGDmJE6q1sQ2ASHyO9Dl0/bZ55QhaeO0C1/D8RtJ5/MNHRTgu6LsfDPe4A7h+X+q
         UHVXMfU4QoVVkWRe+BPYKenwdNKuUYZ88SsLyFrEs2VR0stWClN/slUZzU5c0Vz5dIOT
         g5Mw==
X-Gm-Message-State: AAQBX9ckW8VZTAnhmcQfoHh3Zh3MsoUYZ2nCQ5pzLr9zc8XBNEJEOzXS
        7Dojo20hfnN287kTK8qyEtsCRQ==
X-Google-Smtp-Source: AKy350bPd3r7zDh6GA3RkT4KF6T12j2TXmukQIC7PsSb5x/WiuAQyTCvWTHYGJRvcxGKZ+SHhO2Esw==
X-Received: by 2002:adf:e70c:0:b0:2cf:efc7:19ad with SMTP id c12-20020adfe70c000000b002cfefc719admr210428wrm.53.1679500823327;
        Wed, 22 Mar 2023 09:00:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3606:a601:f273:994a? ([2a01:e0a:982:cbb0:3606:a601:f273:994a])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b003ede03e4369sm11749524wmg.33.2023.03.22.09.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 09:00:22 -0700 (PDT)
Message-ID: <e3f5751a-9a24-3902-cf31-e621b4cb21ab@linaro.org>
Date:   Wed, 22 Mar 2023 17:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/2] spi: add support for Meson A1 SPI Flash Controller
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230322150458.783901-1-mmkurbanov@sberdevices.ru>
 <20230322150458.783901-3-mmkurbanov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230322150458.783901-3-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/03/2023 16:04, Martin Kurbanov wrote:
> This is a driver for the Amlogic Meson SPI flash controller support
> on A113L SoC.
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>   drivers/spi/Kconfig              |   7 +
>   drivers/spi/Makefile             |   1 +
>   drivers/spi/spi-meson-spifc-a1.c | 444 +++++++++++++++++++++++++++++++
>   3 files changed, 452 insertions(+)
>   create mode 100644 drivers/spi/spi-meson-spifc-a1.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3b1c0878bb85..a12452bd1e0c 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -582,6 +582,13 @@ config SPI_MESON_SPIFC
>   	  This enables master mode support for the SPIFC (SPI flash
>   	  controller) available in Amlogic Meson SoCs.
>   
> +config SPI_MESON_SPIFC_A1
> +	tristate "Amlogic Meson A113L SPIFC controller"

The title should be "Amlogic Meson A1 SPIFC controller" for coherency.

> +	depends on ARCH_MESON || COMPILE_TEST
> +	help
> +	  This enables master mode support for the SPIFC (SPI flash
> +	  controller) available in Amlogic Meson A113L (A1 family) SoC.

You should write the reverse: available in Amlogic Meson A1 Family (A113L SoC).

> +
>   config SPI_MICROCHIP_CORE
>   	tristate "Microchip FPGA SPI controllers"
>   	depends on SPI_MASTER
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index be9ba40ef8d0..702053970967 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
>   obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
>   obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
>   obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
> +obj-$(CONFIG_SPI_MESON_SPIFC_A1)	+= spi-meson-spifc-a1.o
>   obj-$(CONFIG_SPI_MICROCHIP_CORE)	+= spi-microchip-core.o
>   obj-$(CONFIG_SPI_MICROCHIP_CORE_QSPI)	+= spi-microchip-core-qspi.o
>   obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
> diff --git a/drivers/spi/spi-meson-spifc-a1.c b/drivers/spi/spi-meson-spifc-a1.c
> new file mode 100644
> index 000000000000..213c8b692675
> --- /dev/null
> +++ b/drivers/spi/spi-meson-spifc-a1.c
> @@ -0,0 +1,444 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Amlogic Meson A113L SPI flash controller (SPIFC)

Same here

> + *
> + * Copyright (c) 2023, SberDevices. All Rights Reserved.
> + *
> + * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +#include <linux/types.h>
> +
> +#define A1_SPIFC_AHB_CTRL_REG		0x0
> +#define A1_SPIFC_AHB_BUS_EN		BIT(31)

I find the "A1_SPIFC" hard to read, I think you should reverse
it in all the file into :
#define SPIFC_A1_...
and
static XXX meson_spifc_a1_request to be coherent with the legacy spifc
driver and spicc driver.


<snip>

> +
> +MODULE_AUTHOR("Martin Kurbanov <mmkurbanov@sberdevices.ru>");
> +MODULE_DESCRIPTION("Amlogic Meson A113L SPIFC driver");

Same here "Meson A1 SPIFC driver"

> +MODULE_LICENSE("GPL");

Thanks,
Neil

