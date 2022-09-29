Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA55EF54D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiI2MX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbiI2MXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:23:45 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48355153EC6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:23:43 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a14so1341633ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=n/5/pYQpRGDy2mv9ns/n156cTdp3Mvzokxp6QAwl6m4=;
        b=kp7iXbx6QGFrgrN1vA9EgOBqg/sUm837+39JYAcBsA5PMFphWdd/2v1l4ZSQgJ1wIO
         ybxuN87nDkipKDHYXzucCcR52nKXQV0UwpRkk6MJBfNEDaDYqRCzAPsHqtIBywGyrGbv
         jZZuGykqL2lpcnxgIMO5RrykpeNamk/c4wHvzYPgECM+eW93c2ozoEo1prY0DX6MH0EX
         O5RnXYUrrH8TTZlBE9RcOZmvh7F+HCFPQPakdIBzihuW5mRqDFUfOU96UukkkvaxdyQh
         +iCrYbcdEI8g4Az3x/bEVT6SjiFtnuUCGCvY9UTiVmYqSrrQwcnlJr38IYFP4Gfi771D
         rOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n/5/pYQpRGDy2mv9ns/n156cTdp3Mvzokxp6QAwl6m4=;
        b=HPCZk6l3Ft6TZqKfNeN3mqj0e78y2wSo2VnjnT6XsovEKCu59I+ZhX6rh9hCt3gFxg
         /+SgDAECQ7CauDL8M9bUafzDXVjS4uwjZ3MIPARfwi0xjVgzAQPTVksTYG4+2OFbCgXg
         ENiyriU7saPcacipWnYjPtzHDFclcE3hIt5B6xxdHELMlHfHQ9xL2ySZ6htHb9tv8BHg
         QO1XidEfnA1mvc7gvn4v8keXneGw0qpHqika0LHGAHuqcr7BQjA2kzZVwrJPxGYiNvxg
         Mn48yNa4vnsAlocJJ3vLC1RnLy/D3Si4rk40gyXzRlGH8tMBObicU/R8CUZzi0ocxsiD
         pxyQ==
X-Gm-Message-State: ACrzQf33nmDvgGY7E/MrE0gHcnFl7e/aoi7W8Vkd+pc5LwvlxNWgdpFb
        W6wkNOOCvhILqFz+OmRp67oxSQ==
X-Google-Smtp-Source: AMsMyM68JPDf/S7zrLziS3/7lBhQxFHfddZz9Wtu8Qa4Mqk65aMutbBZ8LAzIbWyz+iRSI4JkjeHkQ==
X-Received: by 2002:a05:651c:1508:b0:26c:622e:abe1 with SMTP id e8-20020a05651c150800b0026c622eabe1mr1061707ljf.228.1664454221567;
        Thu, 29 Sep 2022 05:23:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f15-20020a056512360f00b004a03e7e8019sm768712lfs.289.2022.09.29.05.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:23:40 -0700 (PDT)
Message-ID: <5b326c52-90e4-6779-8b76-6137309c6f20@linaro.org>
Date:   Thu, 29 Sep 2022 14:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] leds: flash: add driver to support flash LED
 module in QCOM PMICs
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     collinsd@codeaurora.org, subbaram@codeaurora.org
References: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
 <20220929121544.1064279-2-quic_fenglinw@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929121544.1064279-2-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 14:15, Fenglin Wu wrote:
> Add initial driver to support flash LED module found in Qualcomm
> Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
> and each channel can be controlled indepedently and support full scale
> current up to 1.5 A. It also supports connecting two channels together
> to supply one LED component with full scale current up to 2 A. In that
> case, the current will be split on each channel symmetrically and the
> channels will be enabled and disabled at the same time.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  drivers/leds/flash/Kconfig           |  14 +
>  drivers/leds/flash/Makefile          |   1 +
>  drivers/leds/flash/leds-qcom-flash.c | 707 +++++++++++++++++++++++++++
>  3 files changed, 722 insertions(+)
>  create mode 100644 drivers/leds/flash/leds-qcom-flash.c
> 
> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
> index d3eb689b193c..92773fa872dc 100644
> --- a/drivers/leds/flash/Kconfig
> +++ b/drivers/leds/flash/Kconfig
> @@ -61,6 +61,20 @@ config LEDS_MT6360
>  	  Independent current sources supply for each flash LED support torch
>  	  and strobe mode.
>  
> +config LEDS_QCOM_FLASH
> +	tristate "LED support for flash module inside Qualcomm Technologies, Inc. PMIC"
> +	depends on MFD_SPMI_PMIC

|| COMPILE_TEST

(and actually test it, e.g. you might need here "select REGMAP")

> +	depends on LEDS_CLASS && OF
> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> +	help
> +	  This option enables support for the flash module found in Qualcomm
> +	  Technologies, Inc. PMICs. The flash module can have 3 or 4 flash LED
> +	  channels and each channel is programmable to support up to 1.5 A full
> +	  scale current. It also supports connecting two channels' output together
> +	  to supply one LED component to achieve current up to 2 A. In such case,
> +	  the total LED current will be split symmetrically on each channel and
> +	  they will be enabled/disabled at the same time.
> +

>  config LEDS_RT4505
>  	tristate "LED support for RT4505 flashlight controller"
>  	depends on I2C && OF
> diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
> index 0acbddc0b91b..8a60993f1a25 100644
> --- a/drivers/leds/flash/Makefile
> +++ b/drivers/leds/flash/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_LEDS_AS3645A)	+= leds-as3645a.o
>  obj-$(CONFIG_LEDS_KTD2692)	+= leds-ktd2692.o
>  obj-$(CONFIG_LEDS_LM3601X)	+= leds-lm3601x.o
>  obj-$(CONFIG_LEDS_MAX77693)	+= leds-max77693.o
> +obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
>  obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
>  obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
>  obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
> diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
> new file mode 100644
> index 000000000000..7b941eb769fe
> --- /dev/null
> +++ b/drivers/leds/flash/leds-qcom-flash.c
> @@ -0,0 +1,707 @@
> +//SPDX-License-Identifier: GPL-2.0-only

Missing space after //

> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/leds.h>
> +#include <linux/led-class-flash.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <media/v4l2-flash-led-class.h>
> +
> +/* registers definitions */
> +#define FLASH_TYPE_REG			0x04
> +#define FLASH_TYPE_VAL			0x18
> +
> +#define FLASH_SUBTYPE_REG		0x05
> +#define FLASH_SUBTYPE_3CH_VAL		0x04
> +#define FLASH_SUBTYPE_4CH_VAL		0x07
> +
> +#define FLASH_MODULE_EN_BIT		BIT(7)
> +
> +#define FLASH_TIMER_EN_BIT		BIT(7)
> +#define FLASH_TIMER_VAL_MASK		GENMASK(6, 0)
> +#define FLASH_TIMER_STEP_MS		10
> +
> +#define FLASH_ITARGET_CURRENT_MASK	GENMASK(6, 0)
> +
> +#define FLASH_STROBE_HW_SW_SEL_BIT	BIT(2)
> +#define SW_STROBE_VAL			0
> +#define HW_STROBE_VAL			1
> +#define FLASH_HW_STROBE_TRIGGER_SEL_BIT	BIT(1)
> +#define STROBE_LEVEL_TRIGGER_VAL	0
> +#define STROBE_EDGE_TRIGGER_VAL		1
> +#define FLASH_STROBE_POLARITY_BIT	BIT(0)
> +#define STROBE_ACTIVE_HIGH_VAL		1
> +
> +#define FLASH_IRES_MASK_4CH		BIT(0)
> +#define FLASH_IRES_MASK_3CH		GENMASK(1, 0)
> +#define FLASH_IRES_12P5MA_VAL		0
> +#define FLASH_IRES_5MA_VAL_4CH		1
> +#define FLASH_IRES_5MA_VAL_3CH		3
> +
> +/* constants */
> +#define FLASH_CURRENT_MAX_UA		1500000
> +#define TORCH_CURRENT_MAX_UA		500000
> +#define FLASH_TOTAL_CURRENT_MAX_UA	2000000
> +#define FLASH_CURRENT_DEFAULT_UA	1000000
> +#define TORCH_CURRENT_DEFAULT_UA	200000
> +
> +#define TORCH_IRES_UA			5000
> +#define FLASH_IRES_UA			12500
> +
> +#define FLASH_TIMEOUT_MAX_US		1280000
> +#define FLASH_TIMEOUT_STEP_US		10000
> +
> +enum hw_type {
> +	QCOM_MVFLASH_3CH,
> +	QCOM_MVFLASH_4CH,
> +};
> +
> +enum led_mode {
> +	FLASH_MODE,
> +	TORCH_MODE,
> +};
> +
> +enum led_strobe {
> +	SW_STROBE,
> +	HW_STROBE,
> +};
> +
> +struct qcom_flash_reg {
> +	u8 module_en;
> +	u8 chan_timer;
> +	u8 itarget;
> +	u8 iresolution;
> +	u8 chan_strobe;
> +	u8 chan_en;
> +	u8 status1;
> +	u8 status2;
> +	u8 status3;
> +};
> +
> +struct qcom_flash_led {
> +	struct qcom_flash_chip		*chip;
> +	struct led_classdev_flash	flash;
> +	struct v4l2_flash		*v4l2_flash;
> +	u32				max_flash_current_ma;
> +	u32				max_torch_current_ma;
> +	u32				max_timeout_ms;
> +	u32				flash_current_ma;
> +	u32				flash_timeout_ms;
> +	u8				*chan_id;
> +	u8				chan_count;
> +	bool				enabled;
> +};
> +
> +struct qcom_flash_chip {
> +	struct qcom_flash_led		*leds;
> +	const struct qcom_flash_reg	*reg;
> +	struct device			*dev;
> +	struct regmap			*regmap;
> +	struct mutex			lock;
> +	enum hw_type			hw_type;
> +	u32				reg_base;
> +	u8				leds_count;
> +	u8				max_channels;
> +	u8				chan_en_bits;
> +};
> +
> +static const struct qcom_flash_reg mvflash_3ch_reg = {
> +	.chan_timer	= 0x40,
> +	.itarget	= 0x43,
> +	.module_en	= 0x46,
> +	.iresolution	= 0x47,
> +	.chan_strobe	= 0x49,
> +	.chan_en	= 0x4c,
> +	.status1	= 0x08,
> +	.status2	= 0x09,
> +	.status3	= 0x0a,
> +};
> +
> +static const struct qcom_flash_reg mvflash_4ch_reg = {
> +	.chan_timer	= 0x3e,
> +	.itarget	= 0x42,
> +	.module_en	= 0x46,
> +	.iresolution	= 0x49,
> +	.chan_strobe	= 0x4a,
> +	.chan_en	= 0x4e,
> +	.status1	= 0x06,
> +	.status2	= 0x07,
> +	.status3	= 0x09,

Don't reinvent the wheel. Use regmap fields.

> +};
> +
> +static int __set_flash_module_en(struct qcom_flash_led *led, bool en)

Drop __ prefix here and in other functions.

(...)

> +
> +static int qcom_flash_led_remove(struct platform_device *pdev)
> +{
> +	struct qcom_flash_chip *chip = platform_get_drvdata(pdev);
> +
> +	while (chip->leds_count--)
> +		v4l2_flash_release(chip->leds[chip->leds_count].v4l2_flash);
> +
> +	mutex_destroy(&chip->lock);
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_flash_led_match_table[] = {
> +	{ .compatible = "qcom,spmi-flash-led" },

Only this one is needed. Remove the rest:

> +	{ .compatible = "qcom,pm8150c-flash-led" },
> +	{ .compatible = "qcom,pm8150l-flash-led" },
> +	{ .compatible = "qcom,pm8350c-flash-led" },



Best regards,
Krzysztof

