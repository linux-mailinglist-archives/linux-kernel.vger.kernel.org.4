Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F5670B2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjEVBQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 21:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjEVBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:16:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F67CF
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:16:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3a99b9177so4118932e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684718182; x=1687310182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EC0A0nIZ7bBuaMQGMrJ90me0dKvx0C1Iy/LxkfWb3Y8=;
        b=WbttrPY7kY3P3JMYOgr6WLfGkeUmRF0kyQoG1PXJenuWb+i1kxyany7euay41Eu3AA
         ChJkyv64sAaslZ/KgGSCJU4DSz+ENijSP4H7jrp9ufPMD79ryvAUpZ9/s9OfljCcOsNo
         YTx6u4o+UlLwbUyB2fhYr/kvvHmAXi+BXFDoGJjb3JcoDT5WfMhQ2llJOlAmItujCV+z
         btpB35SZ9cRHdp2vfiAsLwDhopbTLy6F0PkGENSDZeylpdoGzgPL8U4Pji9kHw3HKAhq
         Lg7WPoRFLyouso796E5gjzue68+LZe2zBPIq4ODX4C5mryQu0x62QsGcNPvyJqG97aq2
         cbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684718182; x=1687310182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EC0A0nIZ7bBuaMQGMrJ90me0dKvx0C1Iy/LxkfWb3Y8=;
        b=TIPY5hK3Ej6I0A0cge73PqHJ4b1L/TV6eZHl1B60lTBc6lWNAerczbGt7J8YCwtZoE
         EUKT1Qu0TKHTFd6abajHpZ+UGR3LTszSZU/U9fe29da8N+Egg+9B5iXOF1p+YDZoAsCV
         rc7YTwgFIeTkDDer1+WClHybL8shdQENmy7AzfZCnU7Oj3raX0uN3TwRv+ArikwXUn/i
         rO6mZcpTcakQec80v3th18UHXZoPD11pqIFjGKO5DGIZwuiku5qDYcCWnOMgm01hphAS
         zXPmsDYl1O69ZmLSun8OtvbP7jkov5Pm5xNgNSsSN+L/7T764xZNKtPJ7KYocsFklaZz
         NV6w==
X-Gm-Message-State: AC+VfDyfBKOeltg3hlmKtI5dra2NNdCUhw1nUhYJCoeC/OV2+RNoGx3k
        qUxd9zDfthM20TGNEajyXurTaZw/gPdNbL+Hqdo=
X-Google-Smtp-Source: ACHHUZ6MrijlI9JmHmeJPIqxK1dDYiL+EFvzSdypHRYTIyjc56vs+lhuvHipxiMlFzZO7l8TkNsdAw==
X-Received: by 2002:ac2:54ba:0:b0:4f3:b61a:a941 with SMTP id w26-20020ac254ba000000b004f3b61aa941mr1836046lfk.51.1684718181793;
        Sun, 21 May 2023 18:16:21 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x16-20020ac24890000000b004a6f66eed7fsm778895lfc.165.2023.05.21.18.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 18:16:21 -0700 (PDT)
Message-ID: <ccc97880-8e74-b85b-9679-9c12c44c4b99@linaro.org>
Date:   Mon, 22 May 2023 04:16:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 03/10] drm/panel: Add LGD panel driver for Sony Xperia
 XZ3
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230521-drm-panels-sony-v1-3-541c341d6bee@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 00:23, Marijn Suijten wrote:
> Sony provides an unlabeled LGD + Atmel maXTouch assembly in its Xperia
> XZ3 (tama akatsuki) phone, with custom DCS commands to match.
> 
> This panel features Display Stream Compression 1.1.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                   |  11 +
>   drivers/gpu/drm/panel/Makefile                  |   1 +
>   drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c | 362 ++++++++++++++++++++++++
>   3 files changed, 374 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 67ef898d133f2..18bd116e78a71 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -706,6 +706,17 @@ config DRM_PANEL_SONY_ACX565AKM
>   	  Say Y here if you want to enable support for the Sony ACX565AKM
>   	  800x600 3.5" panel (found on the Nokia N900).
>   
> +config DRM_PANEL_SONY_AKATSUKI_LGD
> +	tristate "Sony Xperia XZ3 LGD panel"
> +	depends on GPIOLIB && OF
> +	depends on DRM_MIPI_DSI
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	help
> +	  Say Y here if you want to enable support for the Sony Xperia XZ3
> +	  1440x2880@60 6.0" OLED DSI cmd mode panel produced by LG Display.
> +
> +	  This panel uses Display Stream Compression 1.1.
> +
>   config DRM_PANEL_SONY_TD4353_JDI
>   	tristate "Sony TD4353 JDI panel"
>   	depends on GPIOLIB && OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index ff169781e82d7..85133f73558f3 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
>   obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) += panel-sitronix-st7703.o
>   obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
>   obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) += panel-sony-acx565akm.o
> +obj-$(CONFIG_DRM_PANEL_SONY_AKATSUKI_LGD) += panel-sony-akatsuki-lgd.o
>   obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) += panel-sony-td4353-jdi.o
>   obj-$(CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521) += panel-sony-tulip-truly-nt35521.o
>   obj-$(CONFIG_DRM_PANEL_TDO_TL070WSH30) += panel-tdo-tl070wsh30.o
> diff --git a/drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c b/drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c
> new file mode 100644
> index 0000000000000..f55788f963dab
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-sony-akatsuki-lgd.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Marijn Suijten <marijn.suijten@somainline.org>
> + *
> + * Based on Sony Downstream's "Atmel LGD ID5" Akatsuki panel dtsi.
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/display/drm_dsc.h>
> +#include <drm/display/drm_dsc_helper.h>
> +
> +struct sony_akatsuki_lgd {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct regulator *vddio;
> +	struct gpio_desc *reset_gpio;
> +	bool prepared;
> +};
> +
> +static inline struct sony_akatsuki_lgd *to_sony_akatsuki_lgd(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct sony_akatsuki_lgd, panel);
> +}
> +
> +static int sony_akatsuki_lgd_on(struct sony_akatsuki_lgd *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq(dsi, 0x7f, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf1, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf2, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0x02, 0x01);
> +	mipi_dsi_dcs_write_seq(dsi, 0x59, 0x01);
> +	/* Enable backlight control */
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, BIT(5));
> +	mipi_dsi_dcs_write_seq(dsi, 0x57, 0x20, 0x80, 0xde, 0x60, 0x00);
> +
> +	ret = mipi_dsi_dcs_set_column_address(dsi, 0, 1440 - 1);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set column address: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mipi_dsi_dcs_set_page_address(dsi, 0, 2880 - 1);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set page address: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
> +
> +	ret = mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set tear on: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mipi_dsi_dcs_write_seq(dsi, 0x7f, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf1, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf2, 0x5a, 0x5a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x03);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf6, 0x04);
> +	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x05);
> +	mipi_dsi_dcs_write_seq(dsi, 0xf6, 0x01, 0x7f, 0x00);
> +
> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +		return ret;
> +	}
> +	msleep(120);
> +
> +	mipi_dsi_dcs_write_seq(dsi, 0xe3, 0xac, 0x19, 0x34, 0x14, 0x7d);
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to turn display on: %d\n", ret);
> +		return ret;
> +	}

My usual question: should the mipi_dsi_dcs_exit_sleep_mode() / 
mipi_dsi_dcs_set_display_on() be moved from prepare() to enable() part?

> +
> +	return 0;
> +}
> +
> +static int sony_akatsuki_lgd_off(struct sony_akatsuki_lgd *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_off(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to turn display off: %d\n", ret);
> +		return ret;
> +	}
> +	msleep(20);
> +
> +	ret = mipi_dsi_dcs_set_tear_off(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set tear off: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> +		return ret;
> +	}
> +	msleep(100);
> +
> +	return 0;
> +}
> +
> +static int sony_akatsuki_lgd_prepare(struct drm_panel *panel)
> +{
> +	struct sony_akatsuki_lgd *ctx = to_sony_akatsuki_lgd(panel);
> +	struct drm_dsc_picture_parameter_set pps;
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	if (ctx->prepared)
> +		return 0;
> +
> +	ret = regulator_enable(ctx->vddio);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable vddio regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	msleep(100);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(5000, 5100);
> +
> +	ret = sony_akatsuki_lgd_on(ctx);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to power on panel: %d\n", ret);
> +		goto fail;
> +	}
> +
> +	if (ctx->dsi->dsc) {

dsi->dsc is always set, thus this condition can be dropped.

> +		drm_dsc_pps_payload_pack(&pps, ctx->dsi->dsc);
> +
> +		ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
> +		if (ret < 0) {
> +			dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
> +			goto fail;
> +		}
> +		ret = mipi_dsi_compression_mode(ctx->dsi, true);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable compression mode: %d\n", ret);
> +			goto fail;
> +		}
> +
> +		msleep(28);
> +	}
> +
> +	ctx->prepared = true;
> +	return 0;
> +
> +fail:
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	regulator_disable(ctx->vddio);
> +	return ret;
> +}
> +
> +static int sony_akatsuki_lgd_unprepare(struct drm_panel *panel)
> +{
> +	struct sony_akatsuki_lgd *ctx = to_sony_akatsuki_lgd(panel);
> +	struct device *dev = &ctx->dsi->dev;
> +	int ret;
> +
> +	if (!ctx->prepared)
> +		return 0;
> +
> +	ret = sony_akatsuki_lgd_off(ctx);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to power off panel: %d\n", ret);
> +
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	regulator_disable(ctx->vddio);
> +
> +	usleep_range(5000, 5100);
> +
> +	ctx->prepared = false;
> +	return 0;
> +}
> +
> +static const struct drm_display_mode sony_akatsuki_lgd_mode = {
> +	.clock = (1440 + 312 + 8 + 8) * (2880 + 48 + 8 + 8) * 60 / 1000,
> +	.hdisplay = 1440,
> +	.hsync_start = 1440 + 312,
> +	.hsync_end = 1440 + 312 + 8,
> +	.htotal = 1440 + 312 + 8 + 8,
> +	.vdisplay = 2880,
> +	.vsync_start = 2880 + 48,
> +	.vsync_end = 2880 + 48 + 8,
> +	.vtotal = 2880 + 48 + 8 + 8,
> +	.width_mm = 68,
> +	.height_mm = 136,
> +};
> +
> +static int sony_akatsuki_lgd_get_modes(struct drm_panel *panel,
> +				   struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &sony_akatsuki_lgd_mode);
> +}
> +
> +static const struct drm_panel_funcs sony_akatsuki_lgd_panel_funcs = {
> +	.prepare = sony_akatsuki_lgd_prepare,
> +	.unprepare = sony_akatsuki_lgd_unprepare,
> +	.get_modes = sony_akatsuki_lgd_get_modes,
> +};
> +
> +static int sony_akatsuki_lgd_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +
> +	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +}
> +
> +static int sony_akatsuki_lgd_bl_get_brightness(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness;
> +	int ret;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness_large(dsi, &brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	return brightness & 0x3ff;
> +}
> +
> +static const struct backlight_ops sony_akatsuki_lgd_bl_ops = {
> +	.update_status = sony_akatsuki_lgd_bl_update_status,
> +	.get_brightness = sony_akatsuki_lgd_bl_get_brightness,
> +};
> +
> +static int sony_akatsuki_lgd_probe(struct mipi_dsi_device *dsi)
> +{
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 100,
> +		.max_brightness = 1023,
> +	};
> +	struct device *dev = &dsi->dev;
> +	struct sony_akatsuki_lgd *ctx;
> +	struct drm_dsc_config *dsc;
> +	int ret;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->vddio = devm_regulator_get(dev, "vddio");
> +	if (IS_ERR(ctx->vddio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->vddio),
> +				     "Failed to get vddio\n");
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	ctx->dsi = dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +	drm_panel_init(&ctx->panel, dev, &sony_akatsuki_lgd_panel_funcs,
> +		       DRM_MODE_CONNECTOR_DSI);
> +
> +	ctx->panel.backlight = devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +					      &sony_akatsuki_lgd_bl_ops, &props);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	/* This panel only supports DSC; unconditionally enable it */
> +	dsi->dsc = dsc = devm_kzalloc(&dsi->dev, sizeof(*dsc), GFP_KERNEL);

I think double assignments are frowned upon.

> +	if (!dsc)
> +		return -ENOMEM;
> +
> +	dsc->dsc_version_major = 1;
> +	dsc->dsc_version_minor = 1;
> +
> +	dsc->slice_height = 32;
> +	dsc->slice_count = 2;
> +	// TODO: Get hdisplay from the mode

Would you like to fix the TODO?

> +	WARN_ON(1440 % dsc->slice_count);
> +	dsc->slice_width = 1440 / dsc->slice_count;
> +	dsc->bits_per_component = 8;
> +	dsc->bits_per_pixel = 8 << 4; /* 4 fractional bits */
> +	dsc->block_pred_enable = true;
> +
> +	ret = mipi_dsi_attach(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
> +		drm_panel_remove(&ctx->panel);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sony_akatsuki_lgd_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct sony_akatsuki_lgd *ctx = mipi_dsi_get_drvdata(dsi);
> +	int ret;
> +
> +	ret = mipi_dsi_detach(dsi);
> +	if (ret < 0)
> +		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id sony_akatsuki_lgd_of_match[] = {
> +	{ .compatible = "sony,akatsuki-lgd" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sony_akatsuki_lgd_of_match);
> +
> +static struct mipi_dsi_driver sony_akatsuki_lgd_driver = {
> +	.probe = sony_akatsuki_lgd_probe,
> +	.remove = sony_akatsuki_lgd_remove,
> +	.driver = {
> +		.name = "panel-sony-akatsuki-lgd",
> +		.of_match_table = sony_akatsuki_lgd_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(sony_akatsuki_lgd_driver);
> +
> +MODULE_AUTHOR("Marijn Suijten <marijn.suijten@somainline.org>");
> +MODULE_DESCRIPTION("DRM panel driver for an unnamed LGD OLED panel found in the Sony Xperia XZ3");
> +MODULE_LICENSE("GPL");
> 

-- 
With best wishes
Dmitry

