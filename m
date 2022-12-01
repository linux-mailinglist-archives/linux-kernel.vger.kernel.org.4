Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546D63F412
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiLAPfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiLAPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:34:46 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA2BC6E69;
        Thu,  1 Dec 2022 07:34:11 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1442977d77dso1419386fac.6;
        Thu, 01 Dec 2022 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJ2JTHDAMAbJS/ADBzNEQn0w/E4tOp8FnOKHhN2ooXA=;
        b=EI9spUqtgaHMkmnx+ii+oviWWd7HOSDI7rNeVmdg2z4gZbP9dJP52B1gyL90PsKbD2
         rMPiU5FKw4klv/2pN0LOHju2+piSvHytvWyGlOTun3X3Iq6DzkquM2xHDRtXuBwTpSO1
         PY8P7g7Ch1ImWwttR4DstyjA4DnDZOmlNfmjT35GqsdVhu/KdnDWu/yGJaGoV/FcnOtq
         2y5R+HRQ15GvJ7E7X35fM7e1TSK2TXzIYAUMjJR/l3aYVJiIuEGzp8rMJ8G3Ek3loDQJ
         rAkkTl9jFPoRcspnCdiPVcu4JVmo1ZrANRA6Lb0WDVIoJuy7QWZRQ8nbdpxxUDx0Q6hh
         jlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ2JTHDAMAbJS/ADBzNEQn0w/E4tOp8FnOKHhN2ooXA=;
        b=t3fgGw4I4bE2OFH+h4K/Cb+bjELkaxPoCm4J+zZNkW8Kmsp+GGdh6iFSO3gPgK7iRU
         eUYitoR1U5n7Z/LK7dtbqC29NRv1F8D/aY5LoPOPCMDMCiDdvKFsbYM9y8JMV8vMgCct
         BP26iVgw8swTNAIpeWttwdlxppw4X7z76pUz4cswAMjhYJCjHv82Yc+DI2ynCIW0N0kT
         EDlr939VNRwpPkFzEt4YjoNYHvce9i9DQM/kX2JpW0GQ11oc/LQakWTciA+zmri5ROxh
         tzHG0mFOJPQ+Zc6QkoZcvEc4broS2PchvMsLj+5EMkmCLZ5/SoKLlM9BOr0W0jMHIK1U
         GJ9w==
X-Gm-Message-State: ANoB5pn4GhqEbRmpXPJvMS0qrC15Jk6Wx9sZXk76HcyRkQ8Qm0Sv2bBV
        v6wPhM7dRlZ5FHIo4apICEI=
X-Google-Smtp-Source: AA0mqf6+DRNjIpXvT/ZKK2NF9d2O3gRdlWBYaRGmf5VZGlvw7ZLbmDqQDUe5v1uSFuSV4Jj4KZPdvg==
X-Received: by 2002:a05:6870:f78d:b0:13d:3bb4:479b with SMTP id fs13-20020a056870f78d00b0013d3bb4479bmr38222977oab.68.1669908850713;
        Thu, 01 Dec 2022 07:34:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12-20020a056870560c00b001417f672787sm2766678oao.36.2022.12.01.07.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 07:34:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <00de62b2-51dc-2a72-6659-3425d5e1b72c@roeck-us.net>
Date:   Thu, 1 Dec 2022 07:34:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-4-saravanan@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 3/4] hwmon: (pmbus/mpq7932) Add a support for mpq7932
 Power Management IC
In-Reply-To: <20221201044643.1150870-4-saravanan@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 20:46, Saravanan Sekar wrote:
> The MPQ7932 is a power management IC designed to operate from 5V buses to
> power a variety of Advanced driver-assistance system SOCs. Six integrated
> buck converters with hardware monitoring capability powers a variety of
> target rails configurable over PMBus interface.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>   drivers/hwmon/pmbus/Kconfig   |  10 +++
>   drivers/hwmon/pmbus/Makefile  |   1 +
>   drivers/hwmon/pmbus/mpq7932.c | 144 ++++++++++++++++++++++++++++++++++
>   3 files changed, 155 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/mpq7932.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 89668af67206..4a1538949a73 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -317,6 +317,16 @@ config SENSORS_MP5023
>   	  This driver can also be built as a module. If so, the module will
>   	  be called mp5023.
>   
> +config SENSORS_MPQ7932
> +	tristate "MPS MPQ7932"

As written, a dependency on REGULATOR is missing. However, we want the driver
enabled even if CONFIG_REGULATOR is not enabled. I would suggest to follow the
approach used by other drivers: add a second configuration option
SENSORS_MPQ7932_REGULATOR which depends on SENSORS_MPQ7932 and REGULATOR
and enables regulator functionality, and use that in the driver to
make regulator support optional.

> +	help
> +	  If you say yes here you get six integrated buck converter regulator
> +	  with hardware monitoring functionality support for power management
> +	  IC MPS MPQ7932.

That description is more appropriate for the second configuration option.
Primarily one gets hardware monitoring support for the chip.

> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mpq7932.
> +
>   config SENSORS_PIM4328
>   	tristate "Flex PIM4328 and compatibles"
>   	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 0002dbe22d52..28a534629cc3 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
>   obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
>   obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>   obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
> +obj-$(CONFIG_SENSORS_MPQ7932_REGULATOR) += mpq7932.o
>   obj-$(CONFIG_SENSORS_PLI1209BC)	+= pli1209bc.o
>   obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>   obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
> diff --git a/drivers/hwmon/pmbus/mpq7932.c b/drivers/hwmon/pmbus/mpq7932.c
> new file mode 100644
> index 000000000000..3747d7862afd
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/mpq7932.c
> @@ -0,0 +1,144 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0+

The SPDX license must be in the first line and be a C++ style comment.
Please run checkpatch --strict and fix what it reports (including the
various continuation line misalignments and unnecessary empty lines).

> + *
> + * mpq7932.c  - regulator driver for mps mpq7932
> + * Copyright 2022 Monolithic Power Systems, Inc

This is a hwmon driver with optional regulator functionality.

> + *
> + * Author: Saravanan Sekar <saravanan@linumiz.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pmbus.h>
> +#include "pmbus.h"
> +
> +#define MPQ7932_BUCK_UV_MIN		206250
> +#define MPQ7932_UV_STEP			6250
> +#define MPQ7932_N_VOLTAGES		0xFF
> +#define MPQ7932_NUM_PAGES		6
> +
> +#define MPQ7932_TON_DELAY		0x60
> +#define MPQ7932_VOUT_STARTUP_SLEW	0xA3
> +#define MPQ7932_VOUT_SHUTDOWN_SLEW	0xA5
> +#define MPQ7932_VOUT_SLEW_MASK		GENMASK(1, 0)
> +#define MPQ7932_TON_DELAY_MASK		GENMASK(4, 0)

Please include the appropriate include file defining GENMASK.

> +
> +struct mpq7932_data {
> +	struct pmbus_driver_info info;
> +	struct pmbus_platform_data pdata;
> +};
> +
> +static struct regulator_desc mpq7932_regulators_desc[] = {
> +	PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
> +				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 1, MPQ7932_N_VOLTAGES,
> +				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 2, MPQ7932_N_VOLTAGES,
> +				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 3, MPQ7932_N_VOLTAGES,
> +				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 4, MPQ7932_N_VOLTAGES,
> +				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +	PMBUS_REGULATOR_STEP("buck", 5, MPQ7932_N_VOLTAGES,
> +				MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
> +};
> +
> +static int mpq7932_write_word_data(struct i2c_client *client, int page, int reg,
> +			       u16 word)
> +{
> +
> +	switch (reg) {
> +	case PMBUS_VOUT_COMMAND:

This needs a comment explaining why it is needed.

> +		return pmbus_write_byte_data(client, page, reg, (u8)word);

word should be clamped to [0, 255], not cut off.

> +
> +	default:
> +		return -ENODATA;
> +	}
> +}
> +
> +static int mpq7932_read_word_data(struct i2c_client *client, int page,
> +				  int phase, int reg)
> +{
> +
> +	switch (reg) {
> +	case PMBUS_MFR_VOUT_MIN:
> +		return 0;
> +
> +	case PMBUS_MFR_VOUT_MAX:
> +		return MPQ7932_N_VOLTAGES;

The above need comments. Also, MPQ7932_N_VOLTAGES is inappropriate. This is not the
number of voltages, it is the maximum voltage. Even if the values happen to be the
same, the content is different.

Also, with PMBUS_MFR_VOUT_MIN=0 and PMBUS_MFR_VOUT_MAX=0xff, the number of voltages
would actually be 256, not 255.

> +
> +	case PMBUS_READ_VOUT:
> +		return pmbus_read_byte_data(client, page, PMBUS_VOUT_COMMAND);
> +
Needs same comment as above.

> +	default:
> +		return -ENODATA;
> +	}
> +}
> +
> +static int mpq7932_probe(struct i2c_client *client)
> +{
> +	struct mpq7932_data *data;
> +	struct pmbus_driver_info *info;
> +	struct device *dev = &client->dev;
> +	int i;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_WORD_DATA))

Unnecessary check. This code doesn't use it, and pmbus_do_probe()
does its own check.

> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(struct mpq7932_data),

Use dev.

> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	info = &data->info;
> +	info->pages = MPQ7932_NUM_PAGES;
> +	info->num_regulators = ARRAY_SIZE(mpq7932_regulators_desc);
> +	info->reg_desc = mpq7932_regulators_desc;
> +	info->format[PSC_VOLTAGE_OUT] = direct;
> +	info->m[PSC_VOLTAGE_OUT] = 160;
> +	info->b[PSC_VOLTAGE_OUT] = -33;
> +	for (i = 0; i < info->pages; i++) {
> +		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +				| PMBUS_HAVE_STATUS_TEMP;

I think I already asked: Is this really all telemetry supported by the chip ?
I keep asking because that would be highly unusual.

> +	}
> +
> +	info->read_word_data = mpq7932_read_word_data;
> +	info->write_word_data = mpq7932_write_word_data;
> +
> +	data->pdata.flags = PMBUS_NO_CAPABILITY;
> +	dev->platform_data = &data->pdata;
> +
> +	return pmbus_do_probe(client, info);
> +}
> +
> +static const struct of_device_id mpq7932_of_match[] = {
> +	{ .compatible = "mps,mpq7932"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mpq7932_of_match);
> +
> +static const struct i2c_device_id mpq7932_id[] = {
> +	{ "mpq7932", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, mpq7932_id);
> +
> +static struct i2c_driver mpq7932_regulator_driver = {
> +	.driver = {
> +		.name = "mpq7932",
> +		.of_match_table = mpq7932_of_match,
> +	},
> +	.probe_new = mpq7932_probe,
> +	.id_table = mpq7932_id,
> +};
> +module_i2c_driver(mpq7932_regulator_driver);
> +
> +MODULE_AUTHOR("Saravanan Sekar <saravanan@linumiz.com>");
> +MODULE_DESCRIPTION("MPQ7932 PMIC regulator driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);

