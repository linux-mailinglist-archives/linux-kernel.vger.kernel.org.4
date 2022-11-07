Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82C861FD7F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKGS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiKGS1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:27:12 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B096410F0;
        Mon,  7 Nov 2022 10:27:10 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so32386774ejb.13;
        Mon, 07 Nov 2022 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wkI26nx99NJ2kcFnfPzULPFDVIzLRG1vZbFN6ivO5Y=;
        b=P40a7nPDHpZW6tGUBCDJPeihitaBWS4ePUriifa+A2DsEyXkQKpQKecX0y2MdZx0vE
         gMIgM/ke/ZLlNdRW2srQf76SJiurtpi2E3TKWZ3yFYJgj8AtwEn6qIDZ/5neclO/Rseu
         mvKEMW91waN9lIsfhqQ+MpDMYH5pLIKPRAdkS7mLRV0cWQ4uF6dioDn5pV/1mnPF6qX9
         cFIk7Ignk/7rWDoVNv3P8gCNeJSm7az1UzBels2kVge90eG5LpSh+5sjrUVZT68OQrT/
         h8GqKNWUMCf2DjwRYAGaBdFx/9dCyGFuVchPIxzknpbi2J7zB0AJHtOV2NCBrZfahm+D
         2ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wkI26nx99NJ2kcFnfPzULPFDVIzLRG1vZbFN6ivO5Y=;
        b=WenQ6mhxFiSkFqGgn/hrCDhRrnuVsqg1ie+//Jy+V0wDcfYUOLnAyb2MKBjU0o9iwT
         mYw7FLNs6w/Np0rUNEQj5KTEuZ5rmEA2PRq2LOm0sQT2BGrAg6nt83FF0pw8px8q1HTX
         mmc18hmKx6cDyDKSv1dbgxCg0771gS60esU5v2VHL2anID/67Hs8jlFOC57oniZEsjE1
         DJLeTzkH+Np2izZ1WF5iTKrI40LB4rdFpacD8VUVpfBRsNwP0Fc0A7VmrcuiiQDzgcWh
         Pj61oF/84vsXNf3E1Xv+xD/cPIKOXbwlj5RJeSxHlJJezDUUPmvFnuyCqCNQQ76m7EDK
         Ow5w==
X-Gm-Message-State: ACrzQf2KA+6zSfLL+jiRWr2aHTnwt6hFHLRJJLz8KO19L2tWkqgWQB/k
        tvfakBCb7wUm9ocVXFAufMM=
X-Google-Smtp-Source: AMsMyM5J0NGiR7xDfSRqkzaETeIqO+wRPq9kwptpdvRirh3RqmWeTO/D2wO85BRpiDQJlE2+YQ+YtQ==
X-Received: by 2002:a17:907:a0c7:b0:7ad:d945:553d with SMTP id hw7-20020a170907a0c700b007add945553dmr38875284ejc.95.1667845629074;
        Mon, 07 Nov 2022 10:27:09 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id d14-20020aa7d5ce000000b0046447e4e903sm4637349eds.32.2022.11.07.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:27:08 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 2/5] leds: sun50i-a100: New driver for the A100 LED controller
Date:   Mon, 07 Nov 2022 19:27:05 +0100
Message-ID: <2532156.Lt9SDvczpP@kista>
In-Reply-To: <20221107053247.1180-3-samuel@sholland.org>
References: <20221107053247.1180-1-samuel@sholland.org> <20221107053247.1180-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 07. november 2022 ob 06:32:43 CET je Samuel Holland=20
napisal(a):
> Some Allwinner sunxi SoCs, starting with the A100, contain an LED
> controller designed to drive RGB LED pixels. Add a driver for it using
> the multicolor LED framework, and with LEDs defined in the device tree.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
> (no changes since v5)
>=20
> Changes in v5:
>  - Rename the driver R329 -> A100, since that is the actual original
>    implementation
>=20
> Changes in v4:
>  - Depend on LEDS_CLASS_MULTICOLOR
>=20
> Changes in v3:
>  - Added vendor prefix to timing/format properties
>  - Renamed "format" property to "pixel-format" for clarity
>  - Dropped "vled-supply" as it is unrelated to the controller hardware
>  - Changed "writesl" to "iowrite32_rep" so the driver builds on hppa
>=20
> Changes in v2:
>  - Renamed from sunxi-ledc to sun50i-r329-ledc
>  - Added missing "static" to functions/globals as reported by 0day bot
>=20
>  drivers/leds/Kconfig            |   9 +
>  drivers/leds/Makefile           |   1 +
>  drivers/leds/leds-sun50i-a100.c | 554 ++++++++++++++++++++++++++++++++
>  3 files changed, 564 insertions(+)
>  create mode 100644 drivers/leds/leds-sun50i-a100.c
>=20
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 499d0f215a8b..4f4c515ed7d7 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -281,6 +281,15 @@ config LEDS_COBALT_RAQ
>  	help
>  	  This option enables support for the Cobalt Raq series LEDs.
>=20
> +config LEDS_SUN50I_A100
> +	tristate "LED support for Allwinner A100 RGB LED controller"
> +	depends on LEDS_CLASS_MULTICOLOR && OF
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	help
> +	  This option enables support for the RGB LED controller found
> +	  in some Allwinner sunxi SoCs, includeing A100, R329, and D1.
> +	  It uses a one-wire interface to control up to 1024 LEDs.
> +
>  config LEDS_SUNFIRE
>  	tristate "LED support for SunFire servers."
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4fd2f92cd198..a6ee3f5cf7be 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_LEDS_PWM)			+=3D leds-
pwm.o
>  obj-$(CONFIG_LEDS_REGULATOR)		+=3D leds-regulator.o
>  obj-$(CONFIG_LEDS_S3C24XX)		+=3D leds-s3c24xx.o
>  obj-$(CONFIG_LEDS_SC27XX_BLTC)		+=3D leds-sc27xx-bltc.o
> +obj-$(CONFIG_LEDS_SUN50I_A100)		+=3D leds-sun50i-a100.o
>  obj-$(CONFIG_LEDS_SUNFIRE)		+=3D leds-sunfire.o
>  obj-$(CONFIG_LEDS_SYSCON)		+=3D leds-syscon.o
>  obj-$(CONFIG_LEDS_TCA6507)		+=3D leds-tca6507.o
> diff --git a/drivers/leds/leds-sun50i-a100.c
> b/drivers/leds/leds-sun50i-a100.c new file mode 100644
> index 000000000000..238626288547
> --- /dev/null
> +++ b/drivers/leds/leds-sun50i-a100.c
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
> +//
> +// Partly based on drivers/leds/leds-turris-omnia.c, which is:
> +//     Copyright (c) 2020 by Marek Beh=FAn <kabel@kernel.org>
> +//
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +
> +#define LEDC_CTRL_REG			0x0000
> +#define LEDC_CTRL_REG_DATA_LENGTH		(0x1fff << 16)
> +#define LEDC_CTRL_REG_RGB_MODE			(0x7 << 6)
> +#define LEDC_CTRL_REG_LEDC_EN			BIT(0)
> +#define LEDC_T01_TIMING_CTRL_REG	0x0004
> +#define LEDC_T01_TIMING_CTRL_REG_T1H		(0x3f << 21)
> +#define LEDC_T01_TIMING_CTRL_REG_T1L		(0x1f << 16)
> +#define LEDC_T01_TIMING_CTRL_REG_T0H		(0x1f << 6)
> +#define LEDC_T01_TIMING_CTRL_REG_T0L		(0x3f << 0)
> +#define LEDC_RESET_TIMING_CTRL_REG	0x000c
> +#define LEDC_RESET_TIMING_CTRL_REG_LED_NUM	(0x3ff << 0)
> +#define LEDC_DATA_REG			0x0014
> +#define LEDC_DMA_CTRL_REG		0x0018
> +#define LEDC_DMA_CTRL_REG_FIFO_TRIG_LEVEL	(0x1f << 0)
> +#define LEDC_INT_CTRL_REG		0x001c
> +#define LEDC_INT_CTRL_REG_GLOBAL_INT_EN		BIT(5)
> +#define LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN	BIT(1)
> +#define LEDC_INT_CTRL_REG_TRANS_FINISH_INT_EN	BIT(0)
> +#define LEDC_INT_STS_REG		0x0020
> +#define LEDC_INT_STS_REG_FIFO_CPUREQ_INT	BIT(1)
> +#define LEDC_INT_STS_REG_TRANS_FINISH_INT	BIT(0)
> +
> +#define LEDC_FIFO_DEPTH			32
> +#define LEDC_MAX_LEDS			1024
> +
> +#define LEDS_TO_BYTES(n)		((n) * sizeof(u32))
> +
> +struct sun50i_a100_ledc_led {
> +	struct led_classdev_mc mc_cdev;
> +	struct mc_subled subled_info[3];
> +};
> +
> +#define to_ledc_led(mc) container_of(mc, struct sun50i_a100_ledc_led,
> mc_cdev) +
> +struct sun50i_a100_ledc_timing {
> +	u32 t0h_ns;
> +	u32 t0l_ns;
> +	u32 t1h_ns;
> +	u32 t1l_ns;
> +	u32 treset_ns;
> +};
> +
> +struct sun50i_a100_ledc {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct clk *bus_clk;
> +	struct clk *mod_clk;
> +	struct reset_control *reset;
> +
> +	u32 *buffer;
> +	struct dma_chan *dma_chan;
> +	dma_addr_t dma_handle;
> +	int pio_length;
> +	int pio_offset;
> +
> +	spinlock_t lock;
> +	int next_length;
> +	bool xfer_active;
> +
> +	u32 format;
> +	struct sun50i_a100_ledc_timing timing;
> +
> +	int num_leds;
> +	struct sun50i_a100_ledc_led leds[];
> +};
> +
> +static int sun50i_a100_ledc_dma_xfer(struct sun50i_a100_ledc *priv, int
> length) +{
> +	struct dma_async_tx_descriptor *desc;
> +	dma_cookie_t cookie;
> +
> +	desc =3D dmaengine_prep_slave_single(priv->dma_chan, priv-
>dma_handle,
> +					  =20
LEDS_TO_BYTES(length),
> +					   DMA_MEM_TO_DEV, 0);
> +	if (!desc)
> +		return -ENOMEM;
> +
> +	cookie =3D dmaengine_submit(desc);
> +	if (dma_submit_error(cookie))
> +		return -EIO;
> +
> +	dma_async_issue_pending(priv->dma_chan);
> +
> +	return 0;
> +}
> +
> +static void sun50i_a100_ledc_pio_xfer(struct sun50i_a100_ledc *priv, int
> length) +{
> +	u32 burst, offset, val;
> +
> +	if (length) {
> +		/* New transfer (FIFO is empty). */
> +		offset =3D 0;
> +		burst  =3D min(length, LEDC_FIFO_DEPTH);
> +	} else {
> +		/* Existing transfer (FIFO is half-full). */
> +		length =3D priv->pio_length;
> +		offset =3D priv->pio_offset;
> +		burst  =3D min(length, LEDC_FIFO_DEPTH / 2);
> +	}
> +
> +	iowrite32_rep(priv->base + LEDC_DATA_REG, priv->buffer + offset,=20
burst);
> +
> +	if (burst < length) {
> +		priv->pio_length =3D length - burst;
> +		priv->pio_offset =3D offset + burst;
> +
> +		if (!offset) {
> +			val =3D readl(priv->base + LEDC_INT_CTRL_REG);
> +			val |=3D LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN;
> +			writel(val, priv->base + LEDC_INT_CTRL_REG);
> +		}
> +	} else {
> +		/* Disable the request IRQ once all data is written. */
> +		val =3D readl(priv->base + LEDC_INT_CTRL_REG);
> +		val &=3D ~LEDC_INT_CTRL_REG_FIFO_CPUREQ_INT_EN;
> +		writel(val, priv->base + LEDC_INT_CTRL_REG);
> +	}
> +}
> +
> +static void sun50i_a100_ledc_start_xfer(struct sun50i_a100_ledc *priv,
> +					int length)
> +{
> +	u32 val;
> +
> +	dev_dbg(priv->dev, "Updating %d LEDs\n", length);
> +
> +	val =3D readl(priv->base + LEDC_CTRL_REG);
> +	val &=3D ~LEDC_CTRL_REG_DATA_LENGTH;
> +	val |=3D length << 16 | LEDC_CTRL_REG_LEDC_EN;
> +	writel(val, priv->base + LEDC_CTRL_REG);
> +
> +	if (length > LEDC_FIFO_DEPTH) {
> +		int ret =3D sun50i_a100_ledc_dma_xfer(priv, length);
> +
> +		if (!ret)
> +			return;
> +
> +		dev_warn(priv->dev, "Failed to set up DMA: %d\n", ret);
> +	}
> +
> +	sun50i_a100_ledc_pio_xfer(priv, length);
> +}
> +
> +static irqreturn_t sun50i_a100_ledc_irq(int irq, void *dev_id)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_id;
> +	u32 val;
> +
> +	val =3D readl(priv->base + LEDC_INT_STS_REG);
> +
> +	if (val & LEDC_INT_STS_REG_TRANS_FINISH_INT) {
> +		int next_length;
> +
> +		/* Start the next transfer if needed. */
> +		spin_lock(&priv->lock);
> +		next_length =3D priv->next_length;
> +		if (next_length)
> +			priv->next_length =3D 0;
> +		else
> +			priv->xfer_active =3D false;
> +		spin_unlock(&priv->lock);
> +
> +		if (next_length)
> +			sun50i_a100_ledc_start_xfer(priv,=20
next_length);
> +	} else if (val & LEDC_INT_STS_REG_FIFO_CPUREQ_INT) {
> +		/* Continue the current transfer. */
> +		sun50i_a100_ledc_pio_xfer(priv, 0);
> +	}
> +
> +	writel(val, priv->base + LEDC_INT_STS_REG);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sun50i_a100_ledc_brightness_set(struct led_classdev *cdev,
> +					    enum=20
led_brightness brightness)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_get_drvdata(cdev->dev-
>parent);
> +	struct led_classdev_mc *mc_cdev =3D lcdev_to_mccdev(cdev);
> +	struct sun50i_a100_ledc_led *led =3D to_ledc_led(mc_cdev);
> +	int addr =3D led - priv->leds;
> +	unsigned long flags;
> +	bool xfer_active;
> +	int next_length;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +
> +	priv->buffer[addr] =3D led->subled_info[0].brightness << 16 |
> +			     led->subled_info[1].brightness <<  8 |
> +			     led->subled_info[2].brightness;
> +
> +	dev_dbg(priv->dev, "LED %d -> #%06x\n", addr, priv->buffer[addr]);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	next_length =3D max(priv->next_length, addr + 1);
> +	xfer_active =3D priv->xfer_active;
> +	if (xfer_active)
> +		priv->next_length =3D next_length;
> +	else
> +		priv->xfer_active =3D true;
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	if (!xfer_active)
> +		sun50i_a100_ledc_start_xfer(priv, next_length);
> +}
> +
> +static const char *const sun50i_a100_ledc_formats[] =3D {
> +	"rgb",
> +	"rbg",
> +	"grb",
> +	"gbr",
> +	"brg",
> +	"bgr",
> +};
> +
> +static int sun50i_a100_ledc_parse_format(const struct device_node *np,
> +					 struct=20
sun50i_a100_ledc *priv)
> +{
> +	const char *format =3D "grb";
> +	u32 i;
> +
> +	of_property_read_string(np, "allwinner,pixel-format", &format);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sun50i_a100_ledc_formats); ++i) {
> +		if (!strcmp(format, sun50i_a100_ledc_formats[i])) {
> +			priv->format =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(priv->dev, "Bad pixel format '%s'\n", format);
> +
> +	return -EINVAL;
> +}
> +
> +static void sun50i_a100_ledc_set_format(struct sun50i_a100_ledc *priv)
> +{
> +	u32 val;
> +
> +	val =3D readl(priv->base + LEDC_CTRL_REG);
> +	val &=3D ~LEDC_CTRL_REG_RGB_MODE;
> +	val |=3D priv->format << 6;
> +	writel(val, priv->base + LEDC_CTRL_REG);
> +}
> +
> +static const struct sun50i_a100_ledc_timing sun50i_a100_ledc_default_tim=
ing
> =3D { +	.t0h_ns =3D 336,
> +	.t0l_ns =3D 840,
> +	.t1h_ns =3D 882,
> +	.t1l_ns =3D 294,
> +	.treset_ns =3D 300000,
> +};
> +
> +static int sun50i_a100_ledc_parse_timing(const struct device_node *np,
> +					 struct=20
sun50i_a100_ledc *priv)
> +{
> +	struct sun50i_a100_ledc_timing *timing =3D &priv->timing;
> +
> +	*timing =3D sun50i_a100_ledc_default_timing;
> +
> +	of_property_read_u32(np, "allwinner,t0h-ns", &timing->t0h_ns);
> +	of_property_read_u32(np, "allwinner,t0l-ns", &timing->t0l_ns);
> +	of_property_read_u32(np, "allwinner,t1h-ns", &timing->t1h_ns);
> +	of_property_read_u32(np, "allwinner,t1l-ns", &timing->t1l_ns);
> +	of_property_read_u32(np, "allwinner,treset-ns", &timing-
>treset_ns);
> +
> +	return 0;
> +}
> +
> +static void sun50i_a100_ledc_set_timing(struct sun50i_a100_ledc *priv)
> +{
> +	const struct sun50i_a100_ledc_timing *timing =3D &priv->timing;
> +	unsigned long mod_freq =3D clk_get_rate(priv->mod_clk);
> +	u32 cycle_ns =3D NSEC_PER_SEC / mod_freq;
> +	u32 val;
> +
> +	val =3D (timing->t1h_ns / cycle_ns) << 21 |
> +	      (timing->t1l_ns / cycle_ns) << 16 |
> +	      (timing->t0h_ns / cycle_ns) <<  6 |
> +	      (timing->t0l_ns / cycle_ns);
> +	writel(val, priv->base + LEDC_T01_TIMING_CTRL_REG);
> +
> +	val =3D (timing->treset_ns / cycle_ns) << 16 |
> +	      (priv->num_leds - 1);
> +	writel(val, priv->base + LEDC_RESET_TIMING_CTRL_REG);
> +}
> +
> +static int sun50i_a100_ledc_resume(struct device *dev)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_get_drvdata(dev);
> +	u32 val;
> +	int ret;
> +
> +	ret =3D reset_control_deassert(priv->reset);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_prepare_enable(priv->bus_clk);
> +	if (ret)
> +		goto err_assert_reset;
> +
> +	ret =3D clk_prepare_enable(priv->mod_clk);
> +	if (ret)
> +		goto err_disable_bus_clk;
> +
> +	sun50i_a100_ledc_set_format(priv);
> +	sun50i_a100_ledc_set_timing(priv);
> +
> +	/* The trigger level must be at least the burst length. */
> +	val =3D readl(priv->base + LEDC_DMA_CTRL_REG);
> +	val &=3D ~LEDC_DMA_CTRL_REG_FIFO_TRIG_LEVEL;
> +	val |=3D LEDC_FIFO_DEPTH / 2;
> +	writel(val, priv->base + LEDC_DMA_CTRL_REG);
> +
> +	val =3D LEDC_INT_CTRL_REG_GLOBAL_INT_EN |
> +	      LEDC_INT_CTRL_REG_TRANS_FINISH_INT_EN;
> +	writel(val, priv->base + LEDC_INT_CTRL_REG);
> +
> +	return 0;
> +
> +err_disable_bus_clk:
> +	clk_disable_unprepare(priv->bus_clk);
> +err_assert_reset:
> +	reset_control_assert(priv->reset);
> +
> +	return ret;
> +}
> +
> +static int sun50i_a100_ledc_suspend(struct device *dev)
> +{
> +	struct sun50i_a100_ledc *priv =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(priv->mod_clk);
> +	clk_disable_unprepare(priv->bus_clk);
> +	reset_control_assert(priv->reset);
> +
> +	return 0;
> +}
> +
> +static void sun50i_a100_ledc_dma_cleanup(void *data)
> +{
> +	struct sun50i_a100_ledc *priv =3D data;
> +	struct device *dma_dev =3D dmaengine_get_dma_device(priv->dma_chan);
> +
> +	if (priv->buffer)
> +		dma_free_wc(dma_dev, LEDS_TO_BYTES(priv->num_leds),
> +			    priv->buffer, priv->dma_handle);
> +	dma_release_channel(priv->dma_chan);
> +}
> +
> +static int sun50i_a100_ledc_probe(struct platform_device *pdev)
> +{
> +	const struct device_node *np =3D pdev->dev.of_node;
> +	struct dma_slave_config dma_cfg =3D {};
> +	struct led_init_data init_data =3D {};
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *child;
> +	struct sun50i_a100_ledc *priv;
> +	struct resource *mem;
> +	int count, irq, ret;
> +
> +	count =3D of_get_available_child_count(np);
> +	if (!count)
> +		return -ENODEV;
> +	if (count > LEDC_MAX_LEDS) {
> +		dev_err(dev, "Too many LEDs! (max is %d)\n",=20
LEDC_MAX_LEDS);
> +		return -EINVAL;
> +	}
> +
> +	priv =3D devm_kzalloc(dev, struct_size(priv, leds, count),=20
GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev =3D dev;
> +	priv->num_leds =3D count;
> +	spin_lock_init(&priv->lock);
> +	dev_set_drvdata(dev, priv);
> +
> +	ret =3D sun50i_a100_ledc_parse_format(np, priv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sun50i_a100_ledc_parse_timing(np, priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->base =3D devm_platform_get_and_ioremap_resource(pdev, 0,=20
&mem);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->bus_clk =3D devm_clk_get(dev, "bus");
> +	if (IS_ERR(priv->bus_clk))
> +		return PTR_ERR(priv->bus_clk);
> +
> +	priv->mod_clk =3D devm_clk_get(dev, "mod");
> +	if (IS_ERR(priv->mod_clk))
> +		return PTR_ERR(priv->mod_clk);
> +
> +	priv->reset =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(priv->reset))
> +		return PTR_ERR(priv->reset);
> +
> +	priv->dma_chan =3D dma_request_chan(dev, "tx");
> +	if (IS_ERR(priv->dma_chan))
> +		return PTR_ERR(priv->dma_chan);
> +
> +	ret =3D devm_add_action_or_reset(dev, sun50i_a100_ledc_dma_cleanup,=20
priv);
> +	if (ret)
> +		return ret;
> +
> +	dma_cfg.dst_addr	=3D mem->start + LEDC_DATA_REG;
> +	dma_cfg.dst_addr_width	=3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	dma_cfg.dst_maxburst	=3D LEDC_FIFO_DEPTH / 2;
> +	ret =3D dmaengine_slave_config(priv->dma_chan, &dma_cfg);
> +	if (ret)
> +		return ret;
> +
> +	priv->buffer =3D dma_alloc_wc(dmaengine_get_dma_device(priv-
>dma_chan),
> +				    LEDS_TO_BYTES(priv-
>num_leds),
> +				    &priv->dma_handle,=20
GFP_KERNEL);
> +	if (!priv->buffer)
> +		return -ENOMEM;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, sun50i_a100_ledc_irq,
> +			       0, dev_name(dev), priv);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D sun50i_a100_ledc_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	for_each_available_child_of_node(np, child) {
> +		struct sun50i_a100_ledc_led *led;
> +		struct led_classdev *cdev;
> +		u32 addr, color;
> +
> +		ret =3D of_property_read_u32(child, "reg", &addr);
> +		if (ret || addr >=3D count) {
> +			dev_err(dev, "LED 'reg' values must be from=20
0 to %d\n",
> +				priv->num_leds - 1);
> +			ret =3D -EINVAL;
> +			goto err_put_child;
> +		}
> +
> +		ret =3D of_property_read_u32(child, "color", &color);
> +		if (ret || color !=3D LED_COLOR_ID_RGB) {
> +			dev_err(dev, "LED 'color' must be=20
LED_COLOR_ID_RGB\n");
> +			ret =3D -EINVAL;
> +			goto err_put_child;
> +		}
> +
> +		led =3D &priv->leds[addr];
> +
> +		led->subled_info[0].color_index =3D LED_COLOR_ID_RED;
> +		led->subled_info[0].channel =3D 0;
> +		led->subled_info[1].color_index =3D LED_COLOR_ID_GREEN;
> +		led->subled_info[1].channel =3D 1;
> +		led->subled_info[2].color_index =3D LED_COLOR_ID_BLUE;
> +		led->subled_info[2].channel =3D 2;
> +
> +		led->mc_cdev.num_colors =3D ARRAY_SIZE(led->subled_info);
> +		led->mc_cdev.subled_info =3D led->subled_info;
> +
> +		cdev =3D &led->mc_cdev.led_cdev;
> +		cdev->max_brightness =3D U8_MAX;
> +		cdev->brightness_set =3D sun50i_a100_ledc_brightness_set;
> +
> +		init_data.fwnode =3D of_fwnode_handle(child);
> +
> +		ret =3D devm_led_classdev_multicolor_register_ext(dev,
> +							=09
&led->mc_cdev,
> +							=09
&init_data);
> +		if (ret) {
> +			dev_err(dev, "Failed to register LED %u:=20
%d\n",
> +				addr, ret);
> +			goto err_put_child;
> +		}
> +	}
> +
> +	dev_info(dev, "Registered %d LEDs\n", priv->num_leds);
> +
> +	return 0;
> +
> +err_put_child:
> +	of_node_put(child);
> +	sun50i_a100_ledc_suspend(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int sun50i_a100_ledc_remove(struct platform_device *pdev)
> +{
> +	sun50i_a100_ledc_suspend(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static void sun50i_a100_ledc_shutdown(struct platform_device *pdev)
> +{
> +	sun50i_a100_ledc_suspend(&pdev->dev);
> +}
> +
> +static const struct of_device_id sun50i_a100_ledc_of_match[] =3D {
> +	{ .compatible =3D "allwinner,sun50i-a100-ledc" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sun50i_a100_ledc_of_match);
> +
> +static SIMPLE_DEV_PM_OPS(sun50i_a100_ledc_pm,

SIMPLE_DEV_PM_OPS() is now deprecated in favour of DEFINE_SIMPLE_DEV_PM_OPS=
().=20
With that fixed:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> +			 sun50i_a100_ledc_suspend,=20
sun50i_a100_ledc_resume);
> +
> +static struct platform_driver sun50i_a100_ledc_driver =3D {
> +	.probe		=3D sun50i_a100_ledc_probe,
> +	.remove		=3D sun50i_a100_ledc_remove,
> +	.shutdown	=3D sun50i_a100_ledc_shutdown,
> +	.driver		=3D {
> +		.name		=3D "sun50i-a100-ledc",
> +		.of_match_table	=3D sun50i_a100_ledc_of_match,
> +		.pm		=3D pm_ptr(&sun50i_a100_ledc_pm),
> +	},
> +};
> +module_platform_driver(sun50i_a100_ledc_driver);
> +
> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
> +MODULE_DESCRIPTION("Allwinner A100 LED controller driver");
> +MODULE_LICENSE("GPL");
> --
> 2.37.3


