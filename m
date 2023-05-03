Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBA6F5E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjECSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjECSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:43:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28168A56;
        Wed,  3 May 2023 11:41:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64115eef620so7041575b3a.1;
        Wed, 03 May 2023 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683139273; x=1685731273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffwvzJo3AetlasPY6gczdMsVH/amBSlWs9nz5GwhjKo=;
        b=BUwgoBPWsCmvVQYmmuOOxZi2Vjm5BAQyRtgpsU3UIjTvN96QrVGClIjRjcrP3CO/4a
         vKPHya5vUObcTcf2qbpwCNwRVZMrIV+yCVJicmSnLfRDLn5GQo/JRwoN1DO3YOSQXwKw
         iTAE8nywvJqc3X4JuNhaHD964flox43stbpb97fQN0E7Bxtn/8umJjl2LH4UIxG2OOcM
         OU3dtgxTlljLyDb8zW5dVcu9Z3K9tuUx97r8/sIHdEFDsXiEzvkgCK0Bb1yl6edwJbWy
         mNKTap/DotcsrKzDAnEMi4WxSoK+qQADqP8Rb7nxvikR7yfBfesjPELVdkU5rg+QH5ts
         w+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139273; x=1685731273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffwvzJo3AetlasPY6gczdMsVH/amBSlWs9nz5GwhjKo=;
        b=gt8vu529Ix1+8ZiUYJ61V+5PLvyAXVE8YCROqXXStS5Qj20Izp3WI5KEMvaLs2/lBc
         PybZCgzYbxIAGluj6/mXma1cCk1ay0H6/Dh0CRxUMmW4hO0yOrQVpckLHcJzevZRrV0I
         H6tIqn/WbxhAcKc1/OjuynlGnxOj3yOfNc+Jz0H4FaoA9wE5TUJouEx+4nQ1WM1mpLJ6
         p9ME/sx/XMGtFTAFyiuBaek/MEMRHfDIghTM6QF2TGzh6F6ReWw6Fc2OC68YtVoM/EsP
         RD5JfyWbQx05DO/0tYfIvy/yY1NxcIgUxK1Tiftx8nO4Ib9CLqWhecoMwBvOtPnRsdUG
         ZuFA==
X-Gm-Message-State: AC+VfDxpHjZddTEVmiz9ZZgWTR+63Lll8hDyaBqeSCLQDlvCjYB3TSv+
        yCQ9TaC5Fk0PlUog6JSTk4g=
X-Google-Smtp-Source: ACHHUZ4sGR2VzM/n/g6q/XijzKKMV6zu0D1LXBCdpHQIraxKFbmxB3ILwUBxWRATGPgJ4Z6CrVyxeQ==
X-Received: by 2002:a05:6a00:14c6:b0:636:e0fb:8c45 with SMTP id w6-20020a056a0014c600b00636e0fb8c45mr3611728pfu.16.1683139272680;
        Wed, 03 May 2023 11:41:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9390:e396:49ef:54dc])
        by smtp.gmail.com with ESMTPSA id q10-20020a63d60a000000b0051eff0a70d7sm19998800pgg.94.2023.05.03.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:41:11 -0700 (PDT)
Date:   Wed, 3 May 2023 11:41:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/4] Input/ARM: ads7846: Get pendown IRQ from descriptors
Message-ID: <ZFKqxNA9m9Kge1oo@google.com>
References: <20230430-nokia770-regression-v1-0-97704e36b094@linaro.org>
 <20230430-nokia770-regression-v1-1-97704e36b094@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v1-1-97704e36b094@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 30, 2023 at 11:22:16AM +0200, Linus Walleij wrote:
> The ADS7846 has some limited support for using GPIO descriptors,
> let's convert it over completely and fix all users to provide
> GPIOs in descriptor tables.
> 
> The Nokia 770 now has dynamic allocation of IRQ numbers, so this
> needs to be fixed for it to work.
> 
> Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-omap1/board-nokia770.c | 12 +++++++++++-
>  arch/arm/mach-pxa/spitz.c            | 11 ++++++++++-
>  arch/mips/alchemy/devboards/db1000.c | 11 ++++++++++-
>  drivers/input/touchscreen/ads7846.c  | 32 ++++++++------------------------
>  include/linux/spi/ads7846.h          |  2 --
>  5 files changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
> index a501a473ffd6..eb7652670447 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -118,7 +118,16 @@ static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata =
>  	.debounce_max	= 10,
>  	.debounce_tol	= 3,
>  	.debounce_rep	= 1,
> -	.gpio_pendown	= ADS7846_PENDOWN_GPIO,
> +};
> +
> +static struct gpiod_lookup_table nokia770_ads7846_gpio_table = {
> +	/* SPI bus 2, device with chip select 0 */
> +	.dev_id = "spi2.0",
> +	.table = {
> +		GPIO_LOOKUP("gpio-0-15", ADS7846_PENDOWN_GPIO,
> +			    "pendown", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
>  };

I would like to eventually get rid of GPIO_LOOKUP in favor of
PROPERTY_ENTRY_GPIO. Can we try something like the draft below (just
typed, not even compiled):

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index a501a473ffd6..34b8e392b917 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/input.h>
 #include <linux/omapfb.h>
 
@@ -35,6 +36,24 @@
 #include "clock.h"
 #include "mmc.h"
 
+static const struct software_node nokia770_mpuio_gpiochip_node = {
+	.name = "mpuio",
+};
+
+static const struct software_node nokia770_gpiochip1_node = {
+	.name = "gpio-0-15",
+};
+
+static const struct software_node nokia770_gpiochip2_node = {
+	.name = "gpio-16-31",
+};
+
+static const struct software_node nokia770_gpiochip_nodes[] = {
+	&nokia770_mpuio_gpiochip_node
+	&nokia770_gpiochip1_node,
+	&nokia770_gpiochip2_node,
+};
+
 #define ADS7846_PENDOWN_GPIO	15
 
 static const unsigned int nokia770_keymap[] = {
@@ -102,6 +121,17 @@ static const struct omap_lcd_config nokia770_lcd_config __initconst = {
 	.ctrl_name	= "hwa742",
 };
 
+static const struct property_entry nokia770_mipid_props[] = {
+	PROPERTY_ENTRY_GPIO("reset-gpios", &nokia770_gpiochip1_node,
+			    13, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node nokia770_mipid_swnode = {
+	.name = "lcd_mipid",
+	.properties = nokia770_mipid_props,
+};
+
 static void __init mipid_dev_init(void)
 {
 	nokia770_mipid_platform_data.nreset_gpio = 13;
@@ -110,15 +140,22 @@ static void __init mipid_dev_init(void)
 	omapfb_set_lcd_config(&nokia770_lcd_config);
 }
 
-static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata = {
-	.x_max		= 0x0fff,
-	.y_max		= 0x0fff,
-	.x_plate_ohms	= 180,
-	.pressure_max	= 255,
-	.debounce_max	= 10,
-	.debounce_tol	= 3,
-	.debounce_rep	= 1,
-	.gpio_pendown	= ADS7846_PENDOWN_GPIO,
+static const struct property_entry nokia770_ads7846_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 4096),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 4096),
+	PROPERTY_ENTRY_U32("touchscreen-max-pressure", 256),
+	PROPERTY_ENTRY_U32("touchscreen-average-samples", 10),
+	PROPERTY_ENTRY_U16("ti,x-plate-ohms", 180),
+	PROPERTY_ENTRY_U16("ti,debounce-tol", 3),
+	PROPERTY_ENTRY_U16("ti,debounce-rep", 1),
+	PROPERTY_ENTRY_GPIO("pendown-gpios", &nokia770_gpiochip1_node,
+			    ADS7846_PENDOWN_GPIO, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node nokia770_ads7846_swnode = {
+	.name = "ads7846",
+	.properties = nokia770_ads7846_props,
 };
 
 static struct spi_board_info nokia770_spi_board_info[] __initdata = {
@@ -128,13 +165,14 @@ static struct spi_board_info nokia770_spi_board_info[] __initdata = {
 		.chip_select    = 3,
 		.max_speed_hz   = 12000000,
 		.platform_data	= &nokia770_mipid_platform_data,
+		.swnode		= &nokia770_mipid_swnode,
 	},
 	[1] = {
 		.modalias       = "ads7846",
 		.bus_num        = 2,
 		.chip_select    = 0,
 		.max_speed_hz   = 2500000,
-		.platform_data	= &nokia770_ads7846_platform_data,
+		.swnode		= &nokia770_ads7846_swnode,
 	},
 };
 
@@ -212,14 +250,15 @@ static inline void nokia770_mmc_init(void)
 #endif
 
 #if IS_ENABLED(CONFIG_I2C_CBUS_GPIO)
-static struct gpiod_lookup_table nokia770_cbus_gpio_table = {
-	.dev_id = "i2c-cbus-gpio.2",
-	.table = {
-		GPIO_LOOKUP_IDX("mpuio", 9, NULL, 0, 0), /* clk */
-		GPIO_LOOKUP_IDX("mpuio", 10, NULL, 1, 0), /* dat */
-		GPIO_LOOKUP_IDX("mpuio", 11, NULL, 2, 0), /* sel */
-		{ },
-	},
+static const struct software_node_ref_args nokia770_cbus_gpio_refs[] = {
+	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_swnode, 9, 0),
+	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_swnode, 10, 0),
+	SOFTWARE_NODE_REFERENCE(&nokia770_mpuio_gpiochip_swnode, 11, 0),
+};
+
+static const struct property_entry nokia770_ads7846_props[] = {
+	PROPERTY_ENTRY_REF_ARRAY("gpios", nokia770_cbus_gpio_refs),
+	{ }
 };
 
 static struct platform_device nokia770_cbus_device = {
@@ -253,7 +292,8 @@ static void __init nokia770_cbus_init(void)
 	nokia770_i2c_board_info_2[1].irq = gpio_to_irq(tahvo_irq_gpio);
 	i2c_register_board_info(2, nokia770_i2c_board_info_2,
 				ARRAY_SIZE(nokia770_i2c_board_info_2));
-	gpiod_add_lookup_table(&nokia770_cbus_gpio_table);
+	device_create_managed_software_node(&nokia770_cbus_device.dev,
+					    nokia770_cbus_props, NULL);
 	platform_device_register(&nokia770_cbus_device);
 }
 #else /* CONFIG_I2C_CBUS_GPIO */
@@ -273,6 +313,7 @@ static void __init omap_nokia770_init(void)
 	/* Unmask SleepX signal */
 	omap_writew((omap_readw(0xfffb5004) & ~2), 0xfffb5004);
 
+	software_node_register_node_group(nokia770_gpiochip_swnodes);
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
 	nokia770_spi_board_info[1].irq = gpio_to_irq(15);
 	spi_register_board_info(nokia770_spi_board_info,


This will need switching ads7846.c from using of_property* to
device_property* so that it can parse software nodes.

Thanks.

-- 
Dmitry
