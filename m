Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4419F5FBBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJKUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiJKUFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:05:15 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EA2326F2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:05:11 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i9so9692477qvo.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPO4XlqzFNEEuUvuT47J7MQv98p+hAf/JykVWgYe0Ts=;
        b=PwK2Db43vED7EIV9pIGJu2x3IpzqMoUC/gKzv3/y1fyGrH3/J3343CBD2GWQBKlwdf
         ebfRNws7rUqsUZqNt7uRrmWQHsYsB6yotQOGUsu7aELf0AmYcf8Bh5xc2tt5d4B9en9h
         qV2VrILthP2A1j+jh7N3PxDJ/a6/hbpVgCI/TbCcokBjXif+WnZ7m//n5PHxIhriJ99o
         Ox3DJSgRlQpQJCFqAdwj7ZCimrJUJp7W66BCXP/4YWp9l9j7zcNU05O7sfGrwuYmBUva
         a3FfuCvyC3CCmWpPr6f7lbPpEFYuH18AreNMZcRexLVaay42V5qq9N/C7ihHughYfT5N
         RSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPO4XlqzFNEEuUvuT47J7MQv98p+hAf/JykVWgYe0Ts=;
        b=ijjFZF6H5yZGYcmseuSFN4ru220rsZcS7AzcTRxCbXKCvFZZG2U265wsLhAvuyGfup
         Hp4AQIzoU5QzKxK8ONcT24yWH2cYoNT3dkc417LgkI/9PKV2lUcDCQmo4swwU3ni5fh8
         uLDuwUKn74bog/N0ujymT2YavZBmq+665KyW9kyoA5Sa+p0ZVnb6UK3JWK9jjpGI5XPD
         TOcSSAydjAokuq9P00y8/HN46eVYlmhxpuYIQA/FxSImDeOii+paRZxHOj6b6rbg8pQP
         o2G5qsaXT0eyqd0LpTLBgCJbTT2fyt/SieQPL9o/teNXS4SCMsThyBkQUr1E+1FT0oyG
         2UvQ==
X-Gm-Message-State: ACrzQf375QR5GXR3KTmMiKueCvuZ/sZSMHDsxk+I3eD38bKGIQvZslA1
        K+AOfF+hD4UgZ/TlGP2iGqaf8A==
X-Google-Smtp-Source: AMsMyM4x84lw4i8Qm0cFEVwMt5uZtBxJKOnmAKJwFWQ+J3r+vjGGbGZ+h8jvEVDSbA6YJ/CV+bt5iQ==
X-Received: by 2002:ad4:5961:0:b0:4af:b7e2:b463 with SMTP id eq1-20020ad45961000000b004afb7e2b463mr20360569qvb.105.1665518710081;
        Tue, 11 Oct 2022 13:05:10 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a408e00b006bb83c2be40sm4842201qko.59.2022.10.11.13.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 13:05:09 -0700 (PDT)
Message-ID: <c6ab6116-5d92-132e-48fc-b731fd244d72@linaro.org>
Date:   Tue, 11 Oct 2022 16:05:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/5] soc: hpe: add support for HPE GXP Programmable
 Register Driver
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-2-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011185525.94210-2-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 14:55, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP SoC is interfaced with a programmable logic device that takes
> inputs/outputs from the server board. All these inputs/outputs are
> presented in register form to the SoC. The Programmable Register Driver
> enables access to these registers and provides a standard way to
> provide access across the HPE portfolio.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  drivers/soc/Kconfig          |    1 +
>  drivers/soc/Makefile         |    1 +
>  drivers/soc/hpe/Kconfig      |   19 +
>  drivers/soc/hpe/Makefile     |    7 +
>  drivers/soc/hpe/gxp-plreg.c  | 1207 ++++++++++++++++++++++++++++++++++
>  drivers/soc/hpe/gxp-soclib.c |   19 +
>  drivers/soc/hpe/gxp-soclib.h |   15 +
>  include/linux/soc/hpe/gxp.h  |   15 +
>  8 files changed, 1284 insertions(+)
>  create mode 100644 drivers/soc/hpe/Kconfig
>  create mode 100644 drivers/soc/hpe/Makefile
>  create mode 100644 drivers/soc/hpe/gxp-plreg.c
>  create mode 100644 drivers/soc/hpe/gxp-soclib.c
>  create mode 100644 drivers/soc/hpe/gxp-soclib.h
>  create mode 100644 include/linux/soc/hpe/gxp.h
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index e461c071189b..e4fed449d619 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -10,6 +10,7 @@ source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/canaan/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
>  source "drivers/soc/fujitsu/Kconfig"
> +source "drivers/soc/hpe/Kconfig"
>  source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
>  source "drivers/soc/litex/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 69ba6508cf2c..ebdab9bcbe79 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
>  obj-y				+= fsl/
>  obj-y				+= fujitsu/
>  obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
> +obj-$(CONFIG_ARCH_HPE)		+= hpe/
>  obj-y				+= imx/
>  obj-y				+= ixp4xx/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
> diff --git a/drivers/soc/hpe/Kconfig b/drivers/soc/hpe/Kconfig
> new file mode 100644
> index 000000000000..2bdc9785fe83
> --- /dev/null
> +++ b/drivers/soc/hpe/Kconfig
> @@ -0,0 +1,19 @@
> +config SOC_VENDOR_HPE
> +	bool "HPE SoC drivers"
> +	default y
> +	depends on ARCH_HPE 

|| COMPILE_TEST
(and test it)

> +
> +if SOC_VENDOR_HPE
> +
> +config HPE_GXP_SOCLIB
> +	bool
> +	default n
> +
> +config HPE_GXP_PLREG
> +	bool "GXP Programmable logic register support"
> +	depends on ARCH_HPE_GXP
> +	select HPE_GXP_SOCLIB

|| COMPILE_TEST
(and test it)

> +	select GPIOLIB_IRQCHIP
> +	help
> +	  Say yes here to add support for the PLREG.
> +endif
> diff --git a/drivers/soc/hpe/Makefile b/drivers/soc/hpe/Makefile
> new file mode 100644
> index 000000000000..f304fe0192c9
> --- /dev/null
> +++ b/drivers/soc/hpe/Makefile
> @@ -0,0 +1,7 @@
> +obj-$(CONFIG_HPE_GXP_SOCLIB) += gxp-soclib.o
> +obj-$(CONFIG_HPE_GXP_PLREG) += gxp-plreg.o
> +obj-$(CONFIG_HPE_GXP_FN2) += gxp-fn2.o
> +obj-$(CONFIG_HPE_GXP_CSM) += gxp-csm.o
> +obj-$(CONFIG_HPE_GXP_SROM) += gxp-srom.o
> +obj-$(CONFIG_HPE_GXP_CHIF) += gxp-chif.o
> +obj-$(CONFIG_HPE_GXP_DBG) += gxp-dbg.o

Where are all these CONFIGs defined?

> diff --git a/drivers/soc/hpe/gxp-plreg.c b/drivers/soc/hpe/gxp-plreg.c
> new file mode 100644
> index 000000000000..c2b038a3f4ba
> --- /dev/null
> +++ b/drivers/soc/hpe/gxp-plreg.c
> @@ -0,0 +1,1207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/device.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/soc/hpe/gxp.h>
> +#include "gxp-soclib.h"
> +
> +#define IOP_LED1 0
> +#define IOP_LED2 1
> +#define IOP_LED3 2
> +#define IOP_LED4 3
> +#define IOP_LED5 4
> +#define IOP_LED6 5
> +#define IOP_LED7 6
> +#define IOP_LED8 7
> +#define FAN1_INST 8
> +#define FAN2_INST 9
> +#define FAN3_INST 10
> +#define FAN4_INST 11
> +#define FAN5_INST 12
> +#define FAN6_INST 13
> +#define FAN7_INST 14
> +#define FAN8_INST 15
> +#define FAN9_INST 16
> +#define FAN10_INST 17
> +#define FAN11_INST 18
> +#define FAN12_INST 19
> +#define FAN13_INST 20
> +#define FAN14_INST 21
> +#define FAN15_INST 22
> +#define FAN16_INST 23
> +#define FAN1_FAIL 24
> +#define FAN2_FAIL 25
> +#define FAN3_FAIL 26
> +#define FAN4_FAIL 27
> +#define FAN5_FAIL 28
> +#define FAN6_FAIL 29
> +#define FAN7_FAIL 30
> +#define FAN8_FAIL 31
> +#define FAN9_FAIL 32
> +#define FAN10_FAIL 33
> +#define FAN11_FAIL 34
> +#define FAN12_FAIL 35
> +#define FAN13_FAIL 36
> +#define FAN14_FAIL 37
> +#define FAN15_FAIL 38
> +#define FAN16_FAIL 39
> +#define FAN1_ID 40
> +#define FAN2_ID 41
> +#define FAN3_ID 42
> +#define FAN4_ID 43
> +#define FAN5_ID 44
> +#define FAN6_ID 45
> +#define FAN7_ID 46
> +#define FAN8_ID 47
> +#define FAN9_ID 48
> +#define FAN10_ID 49
> +#define FAN11_ID 50
> +#define FAN12_ID 51
> +#define FAN13_ID 52
> +#define FAN14_ID 53
> +#define FAN15_ID 54
> +#define FAN16_ID 55
> +#define LED_IDENTIFY 56
> +#define LED_HEALTH_RED 57
> +#define LED_HEALTH_AMBER 58
> +#define PWR_BTN_INT 59
> +#define UID_PRESS_INT 60
> +#define SLP_INT 61
> +#define PME_INT 62
> +#define RESV0 63
> +#define RESV1 64
> +#define RESV2 65
> +#define ACM_FORCE_OFF 70
> +#define ACM_REMOVED 71
> +#define ACM_REQ_N 72
> +
> +#define PLREG_INT_GRP5_PIN_BASE	59
> +
> +#define MAX_FAN 16
> +#define IOP_LED_QUANTITY 8
> +#define BYTE 0
> +#define MASK 1
> +#define VALUE 2
> +
> +struct fan_access {
> +	u32 inst;
> +	u32 fail;
> +	u32 id;
> +	u32 bit;
> +};
> +
> +struct iop_led_access {
> +	u32 iop_led[2];
> +};
> +
> +struct health_led_access {
> +	u32 red[2];
> +	u32 amber[2];
> +	u32 green[2];
> +};
> +
> +struct identify_led_access {
> +	u32 off[2];
> +	u32 on[2];
> +};
> +
> +struct acm_access {
> +	int exists;
> +	u32 force_off[2];
> +	u32 removed[2];
> +	u32 unlatch_req[2];
> +};
> +
> +struct server_id_access {
> +	u32 upper[2];
> +	u32 lower[2];
> +};
> +
> +struct sideband_access {
> +	u32 disabled[2];
> +	u32 embedded[2];
> +	u32 adaptive[2];
> +};
> +
> +struct grp5_intr_flag_access {
> +	u32 ack[2];
> +	u32 pwrbtn[2];
> +	u32 uidpress[2];
> +	u32 slpintr[2];
> +};
> +
> +struct grp5_intr_mask_access {
> +	u32 pwrbtn[2];
> +	u32 slpintr[2];
> +};
> +
> +struct grp_intr_masks_access {
> +	u32 grp5[2];
> +};
> +
> +struct grp_intr_flags_access {
> +	u32 grp5[2];
> +};
> +
> +struct pwrbtn_access {
> +	u32 latch[3];
> +};
> +
> +struct gxp_plreg_drvdata {
> +	void __iomem *base;
> +	struct regmap *plreg_map;
> +	struct gpio_chip gpio_chip;
> +	int irq;
> +	struct fan_access fan[16];
> +	struct health_led_access health_led;
> +	struct iop_led_access iop_led[8];
> +	struct identify_led_access identify_led;
> +	struct acm_access acm;
> +	struct server_id_access server_id;
> +	struct sideband_access sideband;
> +	struct grp5_intr_flag_access grp5_intr_flag;
> +	struct grp5_intr_mask_access grp5_intr_mask;
> +	struct grp_intr_masks_access grp_intr_masks;
> +	struct grp_intr_flags_access grp_intr_flags;
> +	struct pwrbtn_access pwrbtn;
> +};
> +
> +struct gxp_plreg_drvdata client_data;

Global? Nope. Even if it were static - drop it.

> +
> +static void address_translation(u32 desired_offset, u32 *offset, u32 *bit_shift)
> +{
> +	*offset = (desired_offset & 0xffc);
> +	*bit_shift = (desired_offset - *offset) * 8;
> +}
> +
> +int gxp_plreg_get_fan_inst(int fan)
> +{
> +	struct gxp_plreg_drvdata *drvdata = &client_data;
> +	u32 trans_offset;
> +	u32 trans_shift;
> +	u32 val;
> +
> +	address_translation(drvdata->fan[fan].inst,
> +			    &trans_offset,
> +			    &trans_shift);
> +
> +	regmap_read(drvdata->plreg_map, trans_offset, &val);
> +	val = (val >> trans_shift) & drvdata->fan[fan].bit;
> +	if (val == drvdata->fan[fan].bit)
> +		return 1;
> +	else
> +		return 0;
> +}
> +EXPORT_SYMBOL(gxp_plreg_get_fan_inst);

No export - there is no user. And then you will see warning to make it
static... and then you will notice it is not used. Drop entire function.
Dead code (unused) is not accepted.

What is more - there is no possibility anything could call it, so it is
pure dead code.

> +
> +int gxp_plreg_get_fan_fail(int fan)
> +{
> +	struct gxp_plreg_drvdata *drvdata = &client_data;
> +	u32 trans_offset;
> +	u32 trans_shift;
> +	u32 val;
> +
> +	address_translation(drvdata->fan[fan].fail,
> +			    &trans_offset,
> +			    &trans_shift);
> +
> +	regmap_read(drvdata->plreg_map, trans_offset, &val);
> +	val = (val >> trans_shift) & drvdata->fan[fan].bit;
> +	if (val == drvdata->fan[fan].bit)
> +		return 1;
> +	else
> +		return 0;
> +}
> +EXPORT_SYMBOL(gxp_plreg_get_fan_fail);

Ditto

> +
> +int gxp_plreg_get_fan_id(int fan)
> +{
> +	struct gxp_plreg_drvdata *drvdata = &client_data;
> +	u32 trans_offset;
> +	u32 trans_shift;
> +	u32 val;
> +
> +	address_translation(drvdata->fan[fan].id,
> +			    &trans_offset,
> +			    &trans_shift);
> +
> +	regmap_read(drvdata->plreg_map, trans_offset, &val);
> +	val = (val >> trans_shift) & drvdata->fan[fan].bit;
> +	if (val == drvdata->fan[fan].bit)
> +		return 1;
> +	else
> +		return 0;
> +}
> +EXPORT_SYMBOL(gxp_plreg_get_fan_id);

More of these...

> +
> +void gxp_plreg_do_virt_pwr_btn_latch(void)
> +{
> +	struct gxp_plreg_drvdata *drvdata = &client_data;
> +	u32 trans_offset;
> +	u32 trans_shift;
> +
> +	address_translation(drvdata->pwrbtn.latch[BYTE],
> +			    &trans_offset,
> +			    &trans_shift);
> +
> +	regmap_update_bits(drvdata->plreg_map, trans_offset,
> +			   drvdata->pwrbtn.latch[MASK] << trans_shift,
> +			   drvdata->pwrbtn.latch[VALUE] << trans_shift);
> +}
> +EXPORT_SYMBOL(gxp_plreg_do_virt_pwr_btn_latch);

Ditto...

> +
> +static ssize_t server_id_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(dev);
> +	int value_upper;
> +	int value_lower;
> +	ssize_t ret;
> +	u32 trans_offset;
> +	u32 trans_shift;
> +
> +	/* read upper first */
> +	address_translation(drvdata->server_id.upper[BYTE],
> +			    &trans_offset,
> +			    &trans_shift);
> +	regmap_read(drvdata->plreg_map, trans_offset, &value_upper);
> +	value_upper = value_upper >> trans_shift;
> +	value_upper = value_upper & drvdata->server_id.upper[MASK];
> +
> +	/* read lower last */
> +	address_translation(drvdata->server_id.lower[BYTE],
> +			    &trans_offset,
> +			    &trans_shift);
> +	regmap_read(drvdata->plreg_map, trans_offset, &value_lower);
> +	value_lower = value_lower >> trans_shift;
> +	value_lower = value_lower & drvdata->server_id.lower[MASK];
> +
> +	ret = sprintf(buf, "0x%04x", value_upper | value_lower);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RO(server_id);

Missing sysfs documentation.

(...)

> +
> +static void gxp_gpio_irq_ack(struct irq_data *d)
> +{
> +	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> +	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(chip->parent);
> +	unsigned int val;
> +	u32 trans_offset;
> +	u32 trans_shift;
> +
> +	// Read latched interrupt
> +	address_translation(drvdata->grp5_intr_flag.ack[BYTE],
> +			    &trans_offset,
> +			    &trans_shift);
> +	regmap_read(drvdata->plreg_map, trans_offset, &val);
> +
> +	//Clear latched interrupt

Keep consistent style. Earlier comments were //_. This one lacks
space... Don't do things differently.

Comments go with /*

> +	regmap_update_bits(drvdata->plreg_map, trans_offset,
> +			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift,
> +			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift);
> +}
> +
> +static void gxp_gpio_irq_set_mask(struct irq_data *d, bool set)
> +{
> +	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
> +	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(chip->parent);
> +	u32 trans_offset;
> +	u32 trans_shift;
> +
> +	address_translation(drvdata->grp5_intr_flag.ack[BYTE],
> +			    &trans_offset,
> +			    &trans_shift);
> +
> +	regmap_update_bits(drvdata->plreg_map, trans_offset,
> +			   (drvdata->grp5_intr_flag.pwrbtn[MASK] |
> +			   drvdata->grp5_intr_flag.slpintr[MASK]) << trans_shift,
> +			   set == 1 ? 0 : (drvdata->grp5_intr_flag.pwrbtn[MASK] |
> +			   drvdata->grp5_intr_flag.slpintr[MASK]) << trans_shift);
> +
> +	regmap_update_bits(drvdata->plreg_map, trans_offset,
> +			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift,
> +			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift);
> +}
> +
> +static void gxp_gpio_irq_mask(struct irq_data *d)
> +{
> +	gxp_gpio_irq_set_mask(d, false);
> +}
> +
> +static void gxp_gpio_irq_unmask(struct irq_data *d)
> +{
> +	gxp_gpio_irq_set_mask(d, true);
> +}
> +
> +static int gxp_gpio_set_type(struct irq_data *d, unsigned int type)
> +{
> +	if (type & IRQ_TYPE_LEVEL_MASK)
> +		irq_set_handler_locked(d, handle_level_irq);
> +	else
> +		irq_set_handler_locked(d, handle_edge_irq);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t gxp_plreg_irq_handle(int irq, void *_drvdata)
> +{
> +	struct gxp_plreg_drvdata *drvdata = (struct gxp_plreg_drvdata *)_drvdata;
> +	unsigned int val, girq, i;
> +
> +	/* handle plreg interrupt group5 */
> +	val = readb(drvdata->base + drvdata->grp5_intr_flag.ack[BYTE]);
> +
> +	for_each_set_bit(i, (unsigned long *)&val, 3) {
> +		girq = irq_find_mapping(drvdata->gpio_chip.irq.domain,
> +					i + PLREG_INT_GRP5_PIN_BASE);
> +		generic_handle_irq(girq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct gpio_chip plreg_chip = {
> +	.label			= "gxp-plreg",
> +	.owner			= THIS_MODULE,
> +	.get			= gxp_gpio_plreg_get,
> +	.set			= gxp_gpio_plreg_set,
> +	.get_direction = gxp_gpio_plreg_get_direction,

Keep code consistent.

> +	.direction_input = gxp_gpio_plreg_direction_input,
> +	.direction_output = gxp_gpio_plreg_direction_output,
> +	.base = -1,
> +	//.can_sleep		= true,

No dead code in the kernel.

> +};
> +
> +static struct irq_chip gxp_gpio_irqchip = {
> +	.name		= "gxp-plreg",
> +	.irq_ack	= gxp_gpio_irq_ack,
> +	.irq_mask	= gxp_gpio_irq_mask,
> +	.irq_unmask	= gxp_gpio_irq_unmask,
> +	.irq_set_type	= gxp_gpio_set_type,
> +};
> +
> +static const struct of_device_id gxp_plreg_of_match[] = {
> +	{ .compatible = "hpe,gxp-plreg" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, gxp_plreg_of_match);
> +
> +static int gxp_plreg_probe(struct platform_device *pdev)
> +{
> +	int i;
> +	int j;
> +	int ret;
> +	struct gxp_plreg_drvdata *drvdata;
> +	struct resource *res;
> +	struct gpio_irq_chip *girq;
> +	struct device_node *np;
> +	char name_buf[10];
> +	u32 trans_offset;
> +	u32 trans_shift;
> +
> +	drvdata = devm_kzalloc(&pdev->dev,
> +			       sizeof(struct gxp_plreg_drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drvdata->base))
> +		return PTR_ERR(drvdata->base);
> +
> +	drvdata->plreg_map = syscon_regmap_lookup_by_compatible("hpe,gxp-plreg");
> +	if (IS_ERR(drvdata->plreg_map)) {
> +		dev_err(&pdev->dev, "Unable to find plreg regmap\n");
> +		return PTR_ERR(drvdata->plreg_map);
> +	}
> +
> +	/* Supply driver with information to access specific offsets in plreg */
> +	for (i = 0; i < MAX_FAN; i++) {
> +		/* Find Fan Children */
> +		snprintf(name_buf, sizeof(name_buf), "fan%d", i + 1);
> +		np = of_get_child_by_name(pdev->dev.of_node, name_buf);
> +
> +		if (np) {
> +		/* For each child there should be 3 fan properties */
> +			if (of_property_read_u32(np, "inst",
> +						 &drvdata->fan[i].inst)) {
> +				dev_err(&pdev->dev, "%s is missing its 'inst' property\n",
> +					name_buf);
> +				return -ENODEV;
> +			}
> +
> +			if (of_property_read_u32(np, "fail",
> +						 &drvdata->fan[i].fail)) {
> +				dev_err(&pdev->dev, "%s is missing its 'fail' property\n",
> +					name_buf);
> +				return -ENODEV;
> +			}
> +			if (of_property_read_u32(np, "id",
> +						 &drvdata->fan[i].id)) {
> +				dev_err(&pdev->dev, "%s is missing its 'id' property\n",
> +					name_buf);
> +				return -ENODEV;
> +			}
> +			if (of_property_read_u32(np, "bit",
> +						 &drvdata->fan[i].bit)) {
> +				dev_err(&pdev->dev, "%s is missing its 'bit' property\n",
> +					name_buf);
> +				return -ENODEV;
> +			}
> +		} else {
> +			dev_warn(&pdev->dev, "%pOF is missing its '%s' node\n", np, name_buf);
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "healthled");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'healthled' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "red", i,
> +					       &drvdata->health_led.red[i])) {
> +			dev_err(&pdev->dev, "healthled is missing its 'red' property index %d\n",
> +				i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "amber", i,
> +					       &drvdata->health_led.amber[i])) {
> +			dev_err(&pdev->dev, "healthled is missing its 'amber' property index %d\n",
> +				i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "green", i,
> +					       &drvdata->health_led.green[i])) {
> +			dev_err(&pdev->dev, "healthled is missing its 'green' property index %d\n",
> +				i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i < IOP_LED_QUANTITY; i++) {
> +		/* Find iopLed Children */
> +		snprintf(name_buf, sizeof(name_buf), "iopled%d", i + 1);
> +		np = of_get_child_by_name(pdev->dev.of_node, name_buf);
> +
> +		if (np) {
> +		/* For each child there should be 1 property */
> +			for (j = 0; j <= MASK; j++) {
> +				if (of_property_read_u32_index(np, "on", j,
> +							       &drvdata->iop_led[i].iop_led[j]
> +							       )) {
> +					dev_err(&pdev->dev, "%s is missing its 'on' property index %d\n",
> +						name_buf, j);
> +					return -ENODEV;
> +				}
> +			}
> +		} else {
> +			dev_err(&pdev->dev, "%pOF is missing its '%s' node\n", np, name_buf);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "identifyled");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'identifyled' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "on", i, &drvdata->identify_led.on[i])) {
> +			dev_err(&pdev->dev, "identifyled is missing its 'on' property index %d\n",
> +				i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "off", i, &drvdata->identify_led.off[i])) {
> +			dev_err(&pdev->dev, "identifyled is missing its 'off' property index %d\n",
> +				i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "acm");
> +	if (!np) {
> +		dev_warn(&pdev->dev, "%pOF is missing its 'acm' node\n", np);
> +	} else {
> +		for (i = 0; i <= MASK; i++) {
> +			if (of_property_read_u32_index(np, "forceoff", i,
> +						       &drvdata->acm.force_off[i])) {
> +				dev_err(&pdev->dev,
> +					"acm is missing its 'forceoff' property index %d\n", i);
> +				return -ENODEV;
> +			}
> +		}
> +
> +		for (i = 0; i <= MASK; i++) {
> +			if (of_property_read_u32_index(np, "removed", i,
> +						       &drvdata->acm.removed[i])) {
> +				dev_err(&pdev->dev,
> +					"acm is missing its 'removed' property index %d\n", i);
> +				return -ENODEV;
> +			}
> +		}
> +
> +		for (i = 0; i <= MASK; i++) {
> +			if (of_property_read_u32_index(np, "unlatchreq", i,
> +						       &drvdata->acm.unlatch_req[i])) {
> +				dev_err(&pdev->dev,
> +					"acm is missing its 'unlatchreq' property index %d\n", i);
> +				return -ENODEV;
> +			}
> +		}
> +		drvdata->acm.exists = 1;
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "serverid");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'serverid' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "upper", i,
> +					       &drvdata->server_id.upper[i])) {
> +			dev_err(&pdev->dev,
> +				"serverid is missing its 'upper' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "lower", i, &drvdata->server_id.lower[i])) {
> +			dev_err(&pdev->dev,
> +				"serverid is missing its 'lower' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "sideband");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'sideband' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "disabled", i,
> +					       &drvdata->sideband.disabled[i])) {
> +			dev_err(&pdev->dev,
> +				"sideband is missing its 'disabled' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "embedded", i,
> +					       &drvdata->sideband.embedded[i])) {
> +			dev_err(&pdev->dev,
> +				"sideband is missing its 'embedded' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "adaptive", i,
> +					       &drvdata->sideband.adaptive[i])) {
> +			dev_err(&pdev->dev,
> +				"sideband is missing its 'adaptive' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "grp5intflag");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'grp5intflag' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "ack", i, &drvdata->grp5_intr_flag.ack[i])) {
> +			dev_err(&pdev->dev,
> +				"grp5intflag is missing its 'ack' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "pwrbtn", i,
> +					       &drvdata->grp5_intr_flag.pwrbtn[i])) {
> +			dev_err(&pdev->dev,
> +				"grp5intflag is missing its 'pwrbtn' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "uidpress", i,
> +					       &drvdata->grp5_intr_flag.uidpress[i])) {
> +			dev_err(&pdev->dev,
> +				"grp5intflag is missing its 'uid' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "slpint", i,
> +					       &drvdata->grp5_intr_flag.slpintr[i])) {
> +			dev_err(&pdev->dev,
> +				"grp5intflag is missing its 'slpint' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "grp5intmask");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'grp5intmask' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "pwrbtn", i,
> +					       &drvdata->grp5_intr_mask.pwrbtn[i])) {
> +			dev_err(&pdev->dev,
> +				"grp5intmask is missing its 'pwrbtn' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "slpint", i,
> +					       &drvdata->grp5_intr_mask.slpintr[i])) {
> +			dev_err(&pdev->dev,
> +				"grp5intmask is missing its 'slpint' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "grpintsmasks");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'grpintsmasks' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "grp5", i,
> +					       &drvdata->grp_intr_masks.grp5[i])) {
> +			dev_err(&pdev->dev,
> +				"grpintsmasks is missing its 'grp5' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "grpintsflags");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'grpintsflags' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= MASK; i++) {
> +		if (of_property_read_u32_index(np, "grp5", i,
> +					       &drvdata->grp_intr_flags.grp5[i])) {
> +			dev_err(&pdev->dev,
> +				"grp5intsflags is missing its 'grp5' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	np = of_get_child_by_name(pdev->dev.of_node, "pwrbtn");
> +	if (!np) {
> +		dev_err(&pdev->dev, "%pOF is missing its 'pwrbtn' node\n", np);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i <= VALUE; i++) {
> +		if (of_property_read_u32_index(np, "latch", i, &drvdata->pwrbtn.latch[i])) {

Undocumented properties. NAK.

> +			dev_err(&pdev->dev, "pwrbtn is missing its 'latch' property index %d\n", i);
> +			return -ENODEV;
> +		}
> +	}
> +
> +	drvdata->gpio_chip = plreg_chip;
> +	drvdata->gpio_chip.ngpio = 100;
> +	drvdata->gpio_chip.parent = &pdev->dev;
> +
> +	girq = &drvdata->gpio_chip.irq;
> +	girq->chip = &gxp_gpio_irqchip;
> +	/* This will let us handle the parent IRQ in the driver */
> +	girq->parent_handler = NULL;
> +	girq->num_parents = 0;
> +	girq->parents = NULL;
> +	girq->default_type = IRQ_TYPE_NONE;
> +	girq->handler = handle_edge_irq;
> +	/* Set up interrupt from PLREG Group 5 Mask */

Please read Linux coding style. There is a chapter about size of
functions. Read it. Actually, read the rest as well... It's ok if
probe() grows above our limit, but this is huge. Really too big.

> +	address_translation(drvdata->grp_intr_flags.grp5[BYTE],
> +			    &trans_offset,
> +			    &trans_shift);
> +	regmap_update_bits(drvdata->plreg_map, trans_offset,
> +			   drvdata->grp_intr_flags.grp5[MASK] << trans_shift,
> +			   drvdata->grp_intr_flags.grp5[MASK] << trans_shift);
> +	address_translation(drvdata->grp_intr_masks.grp5[BYTE],
> +			    &trans_offset,
> +			    &trans_shift);
> +	regmap_update_bits(drvdata->plreg_map, trans_offset,
> +			   drvdata->grp_intr_masks.grp5[MASK] << trans_shift,
> +			   0x00);
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Get irq from platform fail - %d\n", ret);

dev_err_probe

> +		return ret;
> +	}
> +	drvdata->irq = ret;
> +
> +	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_plreg_irq_handle, IRQF_SHARED,
> +			       "gxp-plreg", drvdata);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "IRQ handler failed - %d\n", ret);

dev_err_probe

> +		return ret;
> +	}
> +
> +	ret = sysfs_register(&pdev->dev, drvdata);
> +	if (ret < 0) {
> +		dev_warn(&pdev->dev, "Unable to register sysfs\n");

Missing sysfs documentation

> +		return ret;
> +	}
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->gpio_chip, NULL);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "Could not register gpiochip for plreg, %d\n", ret);

dev_err_probe

> +
> +	client_data = *drvdata;
> +
> +	dev_info(&pdev->dev, "HPE GXP PLREG driver loaded.\n");

Drop probe confirmations.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver gxp_plreg_driver = {
> +	.probe = gxp_plreg_probe,
> +	.driver = {
> +		.name = "gxp-plreg",
> +		.of_match_table = of_match_ptr(gxp_plreg_of_match),

Compile test and you will see here unused/mismatched pairing. Drop
of_match_ptr or add maybe_unused.

> +	},
> +};
> +module_platform_driver(gxp_plreg_driver);
> +
> +MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
> +MODULE_DESCRIPTION("HPE GXP Programmable Logic Registers Driver");

Missing module license.

> diff --git a/drivers/soc/hpe/gxp-soclib.c b/drivers/soc/hpe/gxp-soclib.c
> new file mode 100644
> index 000000000000..e32aa346e770
> --- /dev/null
> +++ b/drivers/soc/hpe/gxp-soclib.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +
> +struct class *soc_class;
> +
> +static int __init gxp_soclib_init(void)
> +{
> +	soc_class = class_create(THIS_MODULE, "soc");
> +	if (IS_ERR(soc_class))
> +		return PTR_ERR(soc_class);
> +	return 0;
> +}
> +
> +module_init(gxp_soclib_init);
> +
> diff --git a/drivers/soc/hpe/gxp-soclib.h b/drivers/soc/hpe/gxp-soclib.h
> new file mode 100644
> index 000000000000..583902969ad5
> --- /dev/null
> +++ b/drivers/soc/hpe/gxp-soclib.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Copyright (C) 2019 Hewlett-Packard Development Company, L.P.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Drop it.

> + */
> +
> +#ifndef __GXP_SOCLIB_H__
> +#define __GXP_SOCLIB_H__
> +
> +extern struct class *soc_class;

Drop entire file... what is the logic behind?

> +
> +#endif
> diff --git a/include/linux/soc/hpe/gxp.h b/include/linux/soc/hpe/gxp.h
> new file mode 100644
> index 000000000000..3573c391ec5a
> --- /dev/null
> +++ b/include/linux/soc/hpe/gxp.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0=or-later */
> +/* Copyright (C) 2022 Hewlett-Packard Development Company, L.P. */
> +
> +#ifndef _LINUX_SOC_HPE_GXP_
> +#define _LINUX_SOC_HPE_GXP_H_
> +
> +#define PLREG_SIDEBAND_UNKNOWN 0x00
> +#define PLREG_SIDEBAND_DISABLED 0x01
> +#define PLREG_SIDEBAND_EMBEDDED 0x02
> +#define PLREG_SIDEBAND_ADAPTIVE 0x03
> +
> +#define GPIO_DIR_OUT 0
> +#define GPIO_DIR_IN  1

Keep all defines prefixed with your device or move it better to
drivers/soc/hpe

> +
> +#endif /* _LINUX_SOC_HPE_GXP_H_ */

Best regards,
Krzysztof

