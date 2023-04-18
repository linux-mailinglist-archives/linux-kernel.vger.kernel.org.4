Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF86E6AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDRRRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjDRRRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:17:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E3A26B;
        Tue, 18 Apr 2023 10:17:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b661097bfso1567657a12.0;
        Tue, 18 Apr 2023 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681838262; x=1684430262;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvMBUlD2RKZ6UIwxm4eKT7sCusw30lqfOdgqJy/cIXI=;
        b=XL/MpIszOexUXoFztC9+WsiWsYFS30e9NaS9Ie+AMYS1XY68dQqfUrz7E4sIMbXEfe
         KDOFEhA4E40s6L5Y4cK1/iFOVOZHs2o9REMUAiacLUo85HqpzHZhqZ5geDrAyKo9VUf1
         lUmYKIhzjmLtsKxn2D4GUWQw2Zi6i3rowIZUewYkKfekufPwfrYa4x3CT8lQFF2t1Atz
         pabL50JljhdjmemNq4gReaxi0ypAG69KY+Ur5yRaLQx9YjmW4h2tMPYxgKHMETop/oN1
         QxyZG/nZOsPcE5jCx9W85SBAqH3NBK/vBpbNYSmraUiakCZ+1BeOQiHbG747icn1tx7m
         GV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681838262; x=1684430262;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvMBUlD2RKZ6UIwxm4eKT7sCusw30lqfOdgqJy/cIXI=;
        b=PDTNackAbLVNvd+CiVzv99Zp2kWzaacLcDR5puYH2M4KjRCdZjS95LH8LXRpL11KVz
         +gCvrtkUh94IkTjIzvQaedSrsAw3zSE2lMHPkkHwCkzPx1qy9ByFkbPLyAqtykKn24sH
         NET1Eev1DuvpKmkgMuFMoEjm/nd6T1MHqpypVmGUra6BGEHfHr8pbObbBaPv/0AZcR4F
         sTJ0/Ir/JoftQDgUdJOcvRWGC80IjY/y/sgUYhYIhCkivO3E4AdIwLU37XXu7NqdHCF+
         cHFdvBrK7Q1PFMMdARaXJnKZ9UMvvStiDibECzEMrLZqhaYgT6wEgMb4uSCzvnSviTCo
         LZlA==
X-Gm-Message-State: AAQBX9erj76bYO4hit2NAangFyHD0ao6ReAZdwPOxHw6lBCz3lSKxxTC
        Rg6orlvSLtbR7md4tSiNq34=
X-Google-Smtp-Source: AKy350afYJtEE25fu/Fz/Zoq9m3FvXTXTBwalKiPX87fQDAZGWIT7pzYMNIEjvkz8ATEgs/FtE98+A==
X-Received: by 2002:a17:902:cf52:b0:1a6:639e:887e with SMTP id e18-20020a170902cf5200b001a6639e887emr2539252plg.13.1681838261608;
        Tue, 18 Apr 2023 10:17:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001a1a8e98e93sm9833793plb.287.2023.04.18.10.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:17:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c27e07d2-8eb1-16a8-4619-280967fc0de9@roeck-us.net>
Date:   Tue, 18 Apr 2023 10:17:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@armlinux.org.uk, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-2-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
In-Reply-To: <20230418152824.110823-2-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 08:28, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC supports GPIO on multiple interfaces: Host, CPLD and Soc
> pins. The interface from CPLD and Host are interruptable from vic0
> and vic1. This driver allows support for both of these interfaces
> through the use of different compatible bindings.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>   drivers/gpio/Kconfig    |    9 +
>   drivers/gpio/Makefile   |    1 +
>   drivers/gpio/gpio-gxp.c | 1056 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 1066 insertions(+)
>   create mode 100644 drivers/gpio/gpio-gxp.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 13be729710f2..47435307698c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1235,6 +1235,15 @@ config HTC_EGPIO
>   	  several HTC phones.  It provides basic support for input
>   	  pins, output pins, and IRQs.
>   
> +config GPIO_GXP
> +        tristate "GXP GPIO support"
> +        depends on ARCH_HPE_GXP
> +        select GPIOLIB_IRQCHIP
> +        help
> +	  Say Y here to support GXP GPIO controllers. It provides
> +	  support for the multiple GPIO interfaces available to be
> +	  available to the Host.
> +
>   config GPIO_JANZ_TTL
>   	tristate "Janz VMOD-TTL Digital IO Module"
>   	depends on MFD_JANZ_CMODIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index c048ba003367..a7ce0ab097aa 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_GPIO_FTGPIO010)		+= gpio-ftgpio010.o
>   obj-$(CONFIG_GPIO_GE_FPGA)		+= gpio-ge.o
>   obj-$(CONFIG_GPIO_GPIO_MM)		+= gpio-gpio-mm.o
>   obj-$(CONFIG_GPIO_GRGPIO)		+= gpio-grgpio.o
> +obj-$(CONFIG_GPIO_GXP)                  += gpio-gxp.o
>   obj-$(CONFIG_GPIO_GW_PLD)		+= gpio-gw-pld.o
>   obj-$(CONFIG_GPIO_HISI)                 += gpio-hisi.o
>   obj-$(CONFIG_GPIO_HLWD)			+= gpio-hlwd.o
> diff --git a/drivers/gpio/gpio-gxp.c b/drivers/gpio/gpio-gxp.c
> new file mode 100644
> index 000000000000..86f69174434d
> --- /dev/null
> +++ b/drivers/gpio/gpio-gxp.c
> @@ -0,0 +1,1056 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define GPIDATL		0x40
> +#define GPIDATH		0x60
> +#define GPODATL		0xb0
> +#define GPODATH		0xb4
> +#define GPODAT2L	0xf8
> +#define GPODAT2H	0xfc
> +#define GPOOWNL		0x110
> +#define GPOOWNH		0x114
> +#define GPOOWN2L	0x118
> +#define GPOOWN2H	0x11c
> +
> +#define GPIO_DIR_OUT	0
> +#define GPIO_DIR_IN	1
> +
> +#define PGOOD_MASK		1
> +
> +#define PLREG_INT_GRP_STAT_MASK	0x8
> +#define PLREG_INT_HI_PRI_EN	0xC
> +#define PLREG_INT_GRP5_BASE	0x31
> +#define PLREG_INT_GRP6_BASE	0x35
> +#define PLREG_INT_GRP5_FLAG	0x30
> +#define PLREG_INT_GRP6_FLAG	0x34
> +#define PLREG_INT_GRP5_PIN_BASE	59
> +#define PLREG_INT_GRP6_PIN_BASE	90
> +
> +enum pl_gpio_pn {
> +	IOP_LED1 = 0,
> +	IOP_LED2,
> +	IOP_LED3,
> +	IOP_LED4,
> +	IOP_LED5,
> +	IOP_LED6,
> +	IOP_LED7,
> +	IOP_LED8,
> +	FAN1_INST = 8,
> +	FAN2_INST,
> +	FAN3_INST,
> +	FAN4_INST,
> +	FAN5_INST,
> +	FAN6_INST,
> +	FAN7_INST,
> +	FAN8_INST,
> +	FAN1_FAIL,
> +	FAN2_FAIL,
> +	FAN3_FAIL,
> +	FAN4_FAIL,
> +	FAN5_FAIL,
> +	FAN6_FAIL,
> +	FAN7_FAIL,
> +	FAN8_FAIL,
> +	LED_IDENTIFY = 56,
> +	LED_HEALTH_RED,
> +	LED_HEALTH_AMBER,
> +	PWR_BTN_INT = 59,
> +	UID_PRESS_INT,
> +	SLP_INT,
> +	ACM_FORCE_OFF = 70,
> +	ACM_REMOVED,
> +	ACM_REQ_N,
> +	PSU1_INST,
> +	PSU2_INST,
> +	PSU3_INST,
> +	PSU4_INST,
> +	PSU5_INST,
> +	PSU6_INST,
> +	PSU7_INST,
> +	PSU8_INST,
> +	PSU1_AC,
> +	PSU2_AC,
> +	PSU3_AC,
> +	PSU4_AC,
> +	PSU5_AC,
> +	PSU6_AC,
> +	PSU7_AC,
> +	PSU8_AC,
> +	PSU1_DC,
> +	PSU2_DC,
> +	PSU3_DC,
> +	PSU4_DC,
> +	PSU5_DC,
> +	PSU6_DC,
> +	PSU7_DC,
> +	PSU8_DC
> +};
> +
> +enum plreg_gpio_pn {
> +	RESET = 192,
> +	NMI_OUT = 193,
> +	VPBTN = 210,
> +	PGOOD,
> +	PERST,
> +	POST_COMPLETE,
> +};
> +
> +struct gxp_gpio_drvdata {
> +	struct regmap *csm_map;
> +	void __iomem *fn2_vbtn;
> +	struct regmap *fn2_stat;
> +	struct regmap *vuhc0_map;
> +	void __iomem *vbtn;
> +	struct regmap *pl_led;
> +	struct regmap *pl_health;
> +	struct regmap *pl_int;
> +	struct gpio_chip chip;
> +	int irq;
> +};
> +
> +extern u8 get_psu_inst(void);
> +extern u8 get_psu_ac(void);
> +extern u8 get_psu_dc(void);
> +extern u8 get_fans_installed(void);
> +extern u8 get_fans_failed(void);
> +

This is not information which should be reported through a gpio driver.
Besides, the functions don't exist at this point in the series,
and there should be no extern declarations in source files.

If you want to model fan or psu information through gpio, drop
the hwmon drivers and implement reading the status here, then use
the existing gpio-fan hwmon driver to report it in the hwmon subsystem.

Guenter

