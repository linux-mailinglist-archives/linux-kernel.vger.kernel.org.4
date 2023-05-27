Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176B371352E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjE0Ond (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjE0Onb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 10:43:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E9BE1;
        Sat, 27 May 2023 07:43:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so1580600a12.2;
        Sat, 27 May 2023 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685198609; x=1687790609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrPrq7jQ13X6gsw0ep79C70R5adI2Y/s+LGq0H1kKqk=;
        b=iQDsw/leakTX3iOvsfVUPhh30Tt08QIClxcPUhbPwGVl6PcYn9sADXnhWYIRlhydvq
         iKUz0FeLjaf2TQYFv658Oka2MxhyHB9LU7mLP24alPgS2QoGat30WWRLL4om4OlxTBmG
         jX7Rs/YS6vbDMYUo9hVKfZFiJM5rzXHTQvJ6KJNvCd7YXgk/sMqtK0Of2YjlFmTS2iYp
         W8NMeXDol+DuJgARXGXBJKNLroTJkZ2OkuLiaV4cjKmIB0BORdlIHfzvKDMexOzzVzKe
         jBXfh3j1K7xqV7pNhawVmj8orw98eulDxHqvuqnlHo4Tlalnqh99yAl+D0GpxpPQ1KsI
         GXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685198609; x=1687790609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrPrq7jQ13X6gsw0ep79C70R5adI2Y/s+LGq0H1kKqk=;
        b=arNsf0vUsR3pBaApPHYVwnnru15GEONSXMdYTOYEVCx98XiUQxNWrvX1/3yZsP7kik
         t2MvwV257VZoNoLtiaT8ggHOZiiCE4Ilfd5+S0unVq18anSHOIeLSDjmw+oZx2Na1LHj
         GglXcL7pj9HpeaUlOLg1APLG7942A9xg73qRPXXpWCG31Rh3LcXY9GWlIVwNigcZ0Cdh
         v/yvP1JAcF7GD3ZqAGkl8u99UZP16ik23JBGlNayZ/p69/Imyg/zGZwOR4k6kaCBHoNZ
         nTj0FVSjAXW4j8DgDzkzEL5MwhzzYkr0olb69E9tLNSbQY5WO65ttHpucEHpkKAM+L9L
         TwUw==
X-Gm-Message-State: AC+VfDySbg9+zN2eFYIxwVYHoZscQaXK6mP1DJpZ4rHGpAtEpr+mTfp2
        Wm+OaTm60ahiHktiZLBptKo=
X-Google-Smtp-Source: ACHHUZ6Jxa09IoXkVA8Cc5fzsx16fCI5JapMIhGEUA8LAgcIO38SBomLsrIZvjk3t4lVvozGNsSS0Q==
X-Received: by 2002:a17:902:da85:b0:1af:f926:a662 with SMTP id j5-20020a170902da8500b001aff926a662mr6195839plx.52.1685198608678;
        Sat, 27 May 2023 07:43:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001ae8587d60csm4981532plj.265.2023.05.27.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 07:43:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 27 May 2023 07:43:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Noah Wang <noahwang.wang@outlook.com>
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: mp2891: add MP2891 driver
Message-ID: <a40eeb84-ae35-460c-9794-7ea3c4768470@roeck-us.net>
References: <TYZPR03MB7130A7F41D61BFB611DDF0C7FA479@TYZPR03MB7130.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYZPR03MB7130A7F41D61BFB611DDF0C7FA479@TYZPR03MB7130.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 05:42:07PM +0800, Noah Wang wrote:
> This driver is designed for MPS VR controller mp2891. The sum
> of input voltage, output voltage, output current, input power,
> output power and temperature of per rail can be obtained from
> hwmon interfaces that the driver provided.
> 
> Firstly, the driver get the vid_step of output voltage and
> current scale(iout_scale) from the mps specific register
> MFR_VOUT_LOOP_CTRL(0xBD) and MFR_SVI3_IOUT_PRT(0x65). These
> two parameters are used to calculate the output voltage and
> output current. Then, if the hwmon interfaces that the driver
> provided are read by the userspace, the driver will obtain
> corresponding data from mp2891 and the data will be submitted
> to the pmbus-core. Finally, userspace can obtain the result.
> 
> Signed-off-by: Noah Wang <noahwang.wang@outlook.com>

After getting some more information:

- POUT is reported in Linear11 mode and should be configured accordingly.
  No driver specific code is required.
- Per-rail PIN is indeed reported in register 0x94 in linear11 mode
  and should be configured accordingly. If rail specific data is
  desired, a comment should be added to the code explaining the
  reason.
- Per-rail IIN is reported in register 0x95 in linear11 mode.
  The standard PMBus command to read the input current does not appear
  to be supported. Since per-rail PIN is reported, per-rail IIN should
  be supported as well.
- Per-rail IOUT is reported in register 0x8c in linear11 mode. There
  is no indication in the datasheet that this value would need to be
  scaled in software. It should be configured as Linear11, and should
  not require special processing.
- VIN is reported in page 0 in Linear11 form. It should be configured
  accordingly and not require any special processing.
- Temperature is reported in Linear11 format. It should be configured
  accordingly and not require any special processing.

This leaves VOUT, which in practice reports values with an LSB as
configured in MFR_VOUT_LOOP_CTRL. Instead of local conversions, the
output voltage should be configured in direct mode, with coefficients
configured to match the step size. Again, there should be no special
processing in the driver.

Additional note:

- PMBUS_PHASE_VIRTUAL only makes sense for chips with per-phase telemetry
  support. Setting the flag in this driver does not provide any value.

Guenter

> ---
>  drivers/hwmon/pmbus/Kconfig  |  10 +
>  drivers/hwmon/pmbus/Makefile |   1 +
>  drivers/hwmon/pmbus/mp2891.c | 371 +++++++++++++++++++++++++++++++++++
>  3 files changed, 382 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/mp2891.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 270b6336b76d..8e930c15aa89 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -326,6 +326,16 @@ config SENSORS_MP5023
>  	  This driver can also be built as a module. If so, the module will
>  	  be called mp5023.
>  
> +config SENSORS_MP2891
> +	tristate "MPS MP2891"
> +	help
> +	  If you say yes here you get hardware monitoring support for MPS
> +	  MP2891 Dual Loop Digital Multi-Phase Controller.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mp2891.
> +
> +
>  config SENSORS_MPQ7932_REGULATOR
>  	bool "Regulator support for MPQ7932"
>  	depends on SENSORS_MPQ7932 && REGULATOR
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 84ee960a6c2d..1a3884fd4b1a 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>  obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>  obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> +obj-$(CONFIG_SENSORS_MP2891)	+= mp2891.o
>  obj-$(CONFIG_SENSORS_MPQ7932)	+= mpq7932.o
>  obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
> diff --git a/drivers/hwmon/pmbus/mp2891.c b/drivers/hwmon/pmbus/mp2891.c
> new file mode 100644
> index 000000000000..07adf5f9871f
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mp2891.c
> @@ -0,0 +1,371 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hardware monitoring driver for MPS Multi-phase Digital VR Controllers(MP2891)
> + *
> + * Copyright (C) 2023 MPS
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include "pmbus.h"
> +
> +/* Vendor specific registers. */
> +#define MFR_VOUT_LOOP_CTRL      0xBD
> +#define MFR_SVI3_IOUT_PRT       0x65
> +#define READ_PIN_EST            0x94
> +
> +#define VID_STEP_POS            14
> +#define VID_STEP_MSK            (0x3 << VID_STEP_POS)
> +#define DAC_2P5MV_POS           13
> +#define DAC_2P5MV_MSK           (0x1 << DAC_2P5MV_POS)
> +#define IOUT_SCALE_POS          0
> +#define IOUT_SCALE_MSK          (0x7 << IOUT_SCALE_POS)
> +
> +#define MP2891_PAGE_NUM			2
> +
> +#define MP2891_RAIL1_FUNC	(PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | \
> +							PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | \
> +							PMBUS_HAVE_POUT | PMBUS_HAVE_PIN | \
> +							PMBUS_PHASE_VIRTUAL)
> +
> +#define MP2891_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | \
> +							PMBUS_HAVE_TEMP | PMBUS_HAVE_POUT | \
> +							PMBUS_PHASE_VIRTUAL)
> +
> +struct mp2891_data {
> +	struct pmbus_driver_info info;
> +	int vid_step[MP2891_PAGE_NUM];
> +	int iout_scale[MP2891_PAGE_NUM];
> +};
> +
> +#define to_mp2891_data(x) container_of(x, struct mp2891_data, info)
> +
> +static int
> +mp2891_read_pout(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret;
> +
> +	ret = pmbus_read_word_data(client, page, phase, reg);
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_read_pin(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret;
> +
> +	ret = pmbus_read_word_data(client, page, phase, reg);
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_read_vin(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret;
> +
> +	ret = pmbus_read_word_data(client, page, phase, reg);
> +	ret = ((ret & 0x7FF) * 1000) >> 5;
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_read_vout(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret;
> +
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2891_data *data = to_mp2891_data(info);
> +
> +	ret = pmbus_read_word_data(client, page, phase, reg);
> +	ret = (ret & 0x7FF) * data->vid_step[page] / 100;
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_read_iout(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret;
> +
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct mp2891_data *data = to_mp2891_data(info);
> +
> +	ret = pmbus_read_word_data(client, page, phase, reg);
> +
> +	if (((ret & 0x8000) >> 15) == 0)
> +		ret = (ret & 0x7FF) * (((ret & 0x7800) >> 11) + 1);
> +	else
> +		ret = (ret & 0x7FF) >> (32 - ((ret & 0xF800) >> 11));
> +
> +	ret = ret * data->iout_scale[page];
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_read_temperature(struct i2c_client *client, int page, int phase, int reg)
> +{
> +	int ret;
> +
> +	ret = pmbus_read_word_data(client, page, phase, reg);
> +
> +	if (((ret & 0x400) >> 10) == 0)
> +		ret = ret & 0x7FF;
> +	else
> +		ret = ~(ret & 0x7FF) + 1;
> +
> +	return ret;
> +}
> +
> +static int mp2891_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_MODE:
> +		/*
> +		 * Enforce VOUT direct format, since device allows to set the
> +		 * different formats for the different rails. Conversion from
> +		 * VID to direct provided by driver internally, in case it is
> +		 * necessary.
> +		 */
> +		ret = PB_VOUT_MODE_DIRECT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int mp2891_read_word_data(struct i2c_client *client, int page, int phase,
> +			      int reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_READ_VIN:
> +		ret = mp2891_read_vin(client, page, phase, reg);
> +		break;
> +	case PMBUS_READ_VOUT:
> +		ret = mp2891_read_vout(client, page, phase, reg);
> +		break;
> +	case PMBUS_READ_IOUT:
> +		ret = mp2891_read_iout(client, page, phase, reg);
> +		break;
> +	case PMBUS_READ_TEMPERATURE_1:
> +		ret = mp2891_read_temperature(client, page, phase, reg);
> +		break;
> +	case PMBUS_READ_PIN:
> +		ret = mp2891_read_pin(client, page, phase, READ_PIN_EST);
> +		break;
> +	case PMBUS_READ_POUT:
> +		ret = mp2891_read_pout(client, page, phase, reg);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_identify_vid(struct i2c_client *client, struct mp2891_data *data,
> +						u32 reg, int page)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Obtain vid_step from the register MFR_VOUT_LOOP_CTRL, bits 15-14,bit 13.
> +	 * If MFR_VOUT_LOOP_CTRL[13] = 1, the vid_step is below:
> +	 * 2.5mV/LSB
> +	 * If MFR_VOUT_LOOP_CTRL[13] = 0, the vid_step is decided by
> +	 * MFR_VOUT_LOOP_CTRL[15:14]:
> +	 * 00b - 6.25mV/LSB, 01b - 5mV/LSB, 10b - 2mV/LSB, 11b - 1mV
> +	 */
> +	if (((ret & DAC_2P5MV_MSK) >> VID_STEP_POS))
> +		data->vid_step[page] = 250;
> +	else {
> +		ret = ((ret & VID_STEP_MSK) >> VID_STEP_POS);
> +		if (ret == 0)
> +			data->vid_step[page] = 625;
> +		else if (ret == 1)
> +			data->vid_step[page] = 500;
> +		else if (ret == 2)
> +			data->vid_step[page] = 200;
> +		else
> +			data->vid_step[page] = 100;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +mp2891_identify_rails_vid(struct i2c_client *client, struct mp2891_data *data)
> +{
> +	int ret;
> +
> +	/* Identify vid_step from register  MFR_VOUT_LOOP_CTRL. */
> +	/* Identify vid_step for rail 1. */
> +	ret = mp2891_identify_vid(client, data, MFR_VOUT_LOOP_CTRL, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Identify vid_step for rail 2. */
> +	ret = mp2891_identify_vid(client, data, MFR_VOUT_LOOP_CTRL, 1);
> +
> +	return ret;
> +}
> +
> +static int
> +mp2891_iout_scale_get(struct i2c_client *client, struct mp2891_data *data,
> +						u32 reg, int page)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_word_data(client, reg);
> +
> +	/*
> +	 * Obtain iout_scale from the register MFR_SVI3_IOUT_PRT, bits 2-0.
> +	 * The value is selected as below:
> +	 * 000b - 1A/LSB, 001b - (1/32)A/LSB, 010b - (1/16)A/LSB,
> +	 * 011b - (1/8)A/LSB, 100b - (1/4)A/LSB, 101b - (1/2)A/LSB
> +	 * 110b - 1A/LSB, 111b - 2A/LSB
> +	 */
> +	ret = (ret & IOUT_SCALE_MSK) >> IOUT_SCALE_POS;
> +	if ((ret == 0) | (ret == 6))
> +		data->iout_scale[page] = 32;
> +	else if (ret == 1)
> +		data->iout_scale[page] = 1;
> +	else if (ret == 2)
> +		data->iout_scale[page] = 2;
> +	else if (ret == 3)
> +		data->iout_scale[page] = 4;
> +	else if (ret == 4)
> +		data->iout_scale[page] = 8;
> +	else if (ret == 5)
> +		data->iout_scale[page] = 16;
> +	else
> +		data->iout_scale[page] = 64;
> +
> +	return 0;
> +}
> +
> +static int
> +mp2891_rails_iout_scale_get(struct i2c_client *client, struct mp2891_data *data)
> +{
> +	int ret;
> +
> +	/* Get iout_scale from register MFR_SVI3_IOUT_PRT. */
> +	/* Get iout_scale for rail 1. */
> +	ret = mp2891_iout_scale_get(client, data, MFR_SVI3_IOUT_PRT, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Get iout_scale for rail 2. */
> +	ret = mp2891_iout_scale_get(client, data, MFR_SVI3_IOUT_PRT, 1);
> +
> +	return ret;
> +}
> +
> +static struct pmbus_driver_info mp2891_info = {
> +	.pages = MP2891_PAGE_NUM,
> +	.format[PSC_VOLTAGE_IN] = direct,
> +	.format[PSC_VOLTAGE_OUT] = direct,
> +	.format[PSC_CURRENT_OUT] = direct,
> +	.format[PSC_TEMPERATURE] = direct,
> +	.format[PSC_POWER] = linear,
> +
> +	.m[PSC_VOLTAGE_IN] = 1,
> +	.m[PSC_VOLTAGE_OUT] = 1,
> +	.m[PSC_CURRENT_OUT] = 32,
> +	.m[PSC_TEMPERATURE] = 1,
> +	.R[PSC_VOLTAGE_IN] = 3,
> +	.R[PSC_VOLTAGE_OUT] = 3,
> +	.R[PSC_CURRENT_OUT] = 0,
> +	.R[PSC_TEMPERATURE] = 0,
> +	.b[PSC_VOLTAGE_IN] = 0,
> +	.b[PSC_VOLTAGE_OUT] = 0,
> +	.b[PSC_CURRENT_OUT] = 0,
> +	.b[PSC_TEMPERATURE] = 0,
> +
> +	.func[0] = MP2891_RAIL1_FUNC,
> +	.func[1] = MP2891_RAIL2_FUNC,
> +	.read_word_data = mp2891_read_word_data,
> +	.read_byte_data = mp2891_read_byte_data,
> +};
> +
> +static int mp2891_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	struct pmbus_driver_info *info;
> +	struct mp2891_data *data;
> +	int ret;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct mp2891_data), GFP_KERNEL);
> +
> +	if (!data)
> +		return -ENOMEM;
> +
> +	memcpy(&data->info, &mp2891_info, sizeof(*info));
> +	info = &data->info;
> +
> +	/* Identify VID setting per rail. */
> +	ret = mp2891_identify_rails_vid(client, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Get iout scale per rail. */
> +	ret = mp2891_rails_iout_scale_get(client, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return pmbus_do_probe(client, info);
> +}
> +
> +static const struct i2c_device_id mp2891_id[] = {
> +	{"mp2891", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mp2891_id);
> +
> +static const struct of_device_id __maybe_unused mp2891_of_match[] = {
> +	{.compatible = "mps,mp2891"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mp2891_of_match);
> +
> +static struct i2c_driver mp2891_driver = {
> +	.driver = {
> +		.name = "mp2891",
> +		.of_match_table = mp2891_of_match,
> +	},
> +	.probe = mp2891_probe,
> +	.id_table = mp2891_id,
> +};
> +
> +module_i2c_driver(mp2891_driver);
> +
> +MODULE_AUTHOR("Noah Wang <noahwang.wang@outlook.com>");
> +MODULE_DESCRIPTION("PMBus driver for MPS MP2891 device");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
