Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE396BBD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjCOTrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjCOTrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:47:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369D68F70A;
        Wed, 15 Mar 2023 12:47:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y12so6748818ilq.4;
        Wed, 15 Mar 2023 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678909637;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXcrE3e461cnOsmKH1Km1i1DilozhsQj5OClY6H5haQ=;
        b=pVvGrydhpdjLXIOnCqOEguCurwfLEzNeHwUXZygFFZN4Rn7NBqmfvSwbNpA+imLMUX
         tYIH+KaCnAzPn+D7DHx8HlyM40o7kCAciPOt2KLp65PonpAqaeIr6BB4i52xi7sR2PKh
         LGGgQN1WFzM7W63+hmUXDREccE0sMsDGUqckFbRqiurGwdZN5iOulJ+UncTzVjQPNqSs
         16RIMbqthjQbLXJfwXCPZnrK66/lOJ/6BztSl6gMJcdP7/896W27sSiAhi9/Q/mEXyIg
         1Gyj6zC1SlvblWsYhTWq/BCSArlAgYDSn60/y9rNolkjV1r2djYzX5LYdxd1QJ73LgGh
         4jDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909637;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXcrE3e461cnOsmKH1Km1i1DilozhsQj5OClY6H5haQ=;
        b=VqfikeBfcu7j6SMGtOBbLVIt0ieFwNUqS8AZLbxvye1n/z0+fE+Yc05tsjx2wsP5Wk
         DgOesdZB0fL1q8+79RBgs1XasbFmm/U2MVdVmPsZZaTlNqbCsE2wQN5NMUUUGK5XvF7d
         S8Jn0oYda7nDMteUL3Ek0k1hXAZEnDjJFtrPpi0ohnoZxXVdQumQdK6g8YlZAYtUpWKr
         saYR9ygVE/Wpv0nrQef3QGdg9Tc/KBOhSfEsKAvWpgAsnI9/1ddiy7OlBVj8tChnfnnw
         5e25YZ8YScAKyc7MkJqYyq5OUMWMYuqQQeZaa6Xr6BbvAB3aL/N3iGZuLslJJ4YYDlx2
         Qycw==
X-Gm-Message-State: AO0yUKXJeRmENpRURmg6DnaFKWul1Q1GFM2v0fdzs5hWzt4i8qHQxhTX
        SoylHaY4VSwFVpda8UBpAUg=
X-Google-Smtp-Source: AK7set9N4Uox7g9tO4wczIu24HjgudaEJ0PqD1G+Mxu/sl8/gJGMOx8AEseWVFaK3SDmolTTvzWKNQ==
X-Received: by 2002:a05:6e02:1294:b0:323:140f:a72e with SMTP id y20-20020a056e02129400b00323140fa72emr5549951ilq.1.1678909637142;
        Wed, 15 Mar 2023 12:47:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c950000000b00403089c2a1dsm1905721jao.108.2023.03.15.12.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 12:47:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c09de53e-dfae-e646-2099-b892ea354060@roeck-us.net>
Date:   Wed, 15 Mar 2023 12:47:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20230315185303.960368-1-lakshmiy@us.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/4] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply
 driver
In-Reply-To: <20230315185303.960368-1-lakshmiy@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 11:53, Lakshmi Yadlapati wrote:
> Add the driver to support Acbel CRPS power supply.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>   drivers/hwmon/pmbus/Kconfig      |   9 +
>   drivers/hwmon/pmbus/Makefile     |   1 +
>   drivers/hwmon/pmbus/acbel-crps.c | 311 +++++++++++++++++++++++++++++++

Documentation/hwmon/acbel-crps.rst is missing.

>   3 files changed, 321 insertions(+)
>   create mode 100644 drivers/hwmon/pmbus/acbel-crps.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 59d9a7430499..9fe7ac94cfa2 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -27,6 +27,15 @@ config SENSORS_PMBUS
>   	  This driver can also be built as a module. If so, the module will
>   	  be called pmbus.
>   
> +config SENSORS_ACBEL_CRPS
> +	tristate "ACBEL CRPS Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for the ACBEL
> +	  CRPS power supply.
> +

This is way too generic. This company has lots of power supplies solde under
"CRPS" (whatever that means). It seems highly unlikely that this driver works
for all of them.

Besides, terms like "CRPS" really need to be explained.

> +	  This driver can also be built as a module. If so, the module will
> +	  be called acbel-crps.
> +
>   config SENSORS_ADM1266
>   	tristate "Analog Devices ADM1266 Sequencer"
>   	select CRC8
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 3ae019916267..39aef0cb9934 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -5,6 +5,7 @@
>   
>   obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>   obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
> +obj-$(CONFIG_SENSORS_ACBEL_CRPS) += acbel-crps.o
>   obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>   obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>   obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> diff --git a/drivers/hwmon/pmbus/acbel-crps.c b/drivers/hwmon/pmbus/acbel-crps.c
> new file mode 100644
> index 000000000000..f7779f0fbb2d
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/acbel-crps.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 IBM Corp.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/fs.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pmbus.h>
> +#include <linux/hwmon-sysfs.h>
> +#include "pmbus.h"
> +
> +#define CRPS_MFG_ID_CMD                 0x99
> +#define CRPS_MFG_MODEL_CMD              0x9A
> +#define CRPS_MFG_REVISION_CMD           0x9B
> +#define CRPS_MFG_LOCATION_CMD           0x9C
> +#define CRPS_MFG_SERIAL_CMD             0x9E
> +#define CRPS_CCIN_CMD                   CRPS_MFG_SERIAL_CMD
> +
> +/* STATUS_VOUT */
> +#define CRPS_STATUS_UV_FAULT            BIT(4)
> +#define CRPS_STATUS_OV_FAULT            BIT(7)
> +
> +/* STATUS_IOUT */
> +#define CRPS_STATUS_OP_WARNING          BIT(0)
> +#define CRPS_STATUS_OP_FAULT            BIT(1)
> +#define CRPS_STATUS_OC_WARNING          BIT(5)
> +#define CRPS_STATUS_OC_FAULT            BIT(7)
> +
> +/* STATUS_TEMP */
> +#define CRPS_STATUS_OT_WARNING          BIT(6)
> +#define CRPS_STATUS_OT_FAULT            BIT(7)
> +
> +/* STATUS_FAN12 */
> +#define CRPS_FAN1_SPEED_OVERRIDE        BIT(2)
> +#define CRPS_FAN1_WARNING               BIT(5)
> +#define CRPS_FAN1_FAULT                 BIT(7)
> +
> +enum {
> +	CRPS_DEBUGFS_MFG_ID,
> +	CRPS_DEBUGFS_MFG_MODEL,
> +	CRPS_DEBUGFS_MFG_REVISION,
> +	CRPS_DEBUGFS_MFG_LOCATION,
> +	CRPS_DEBUGFS_MFG_SERIAL,
> +	CRPS_DEBUGFS_CCIN,
> +	CRPS_DEBUGFS_NUM_ENTRIES
> +};
> +
> +struct acbel_crps {
> +	struct i2c_client *client;
> +	int debugfs_entries[CRPS_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +static const struct i2c_device_id acbel_crps_id[] = {
> +	{ "acbel_crps" },
> +	{ }
> +};
> +#define to_psu(x, y) container_of((x), struct acbel_crps, debugfs_entries[(y)])
> +
> +static ssize_t acbel_crps_debugfs_read(struct file *file, char __user *buf,
> +				       size_t count, loff_t *ppos)
> +{
> +	u8 cmd;
> +	int rc;
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct acbel_crps *psu = to_psu(idxp, idx);
> +	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +
> +	pmbus_set_page(psu->client, 0, 0xff);
> +
> +	switch (idx) {
> +	case CRPS_DEBUGFS_MFG_ID:
> +		cmd = ;
> +		break;
> +	case CRPS_DEBUGFS_MFG_MODEL:
> +		cmd = CRPS_MFG_MODEL_CMD;
> +		break;
> +	case CRPS_DEBUGFS_MFG_REVISION:
> +		cmd = CRPS_MFG_REVISION_CMD;
> +		break;
> +	case CRPS_DEBUGFS_MFG_LOCATION:
> +		cmd = CRPS_MFG_LOCATION_CMD;
> +		break;
> +	case CRPS_DEBUGFS_MFG_SERIAL:
> +		cmd = CRPS_MFG_SERIAL_CMD;
> +		break;
> +	case CRPS_DEBUGFS_CCIN:
> +		cmd = CRPS_CCIN_CMD;
> +		rc = i2c_smbus_read_block_data(psu->client, cmd, data);
> +		if (rc < 0)
> +			return rc;
> +		data[4] = '\n';
> +		data[5] = '\0';
> +		rc = 6;

Needs explanation. Why not report the ret os the data ?
Also, what if rc < 4 ?

> +		goto done;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = i2c_smbus_read_block_data(psu->client, cmd, data);
> +	if (rc < 0)
> +		return rc;
> +	data[rc] = '\n';
> +	rc += 2;
> +done:
> +	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +}
> +
> +static const struct file_operations acbel_crps_fops = {
> +	.llseek = noop_llseek,
> +	.read = acbel_crps_debugfs_read,
> +	.open = simple_open,
> +};
> +
> +static int acbel_crps_read_word_data(struct i2c_client *client, int page,
> +				     int phase, int reg)
> +{
> +	int ret = 0;
> +
> +	if (page > 0)
> +		return -ENXIO;
> +

The driver only supports a single page, so all page command handling is unnecessary.

> +	switch (reg) {
> +	case PMBUS_VOUT_OV_FAULT_LIMIT:
> +	case PMBUS_VOUT_UV_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_FAULT_LIMIT:
> +	case PMBUS_IOUT_OC_WARN_LIMIT:
> +	case PMBUS_OT_WARN_LIMIT:
> +	case PMBUS_IIN_OC_FAULT_LIMIT:
> +	case PMBUS_IIN_OC_WARN_LIMIT:
> +	case PMBUS_POUT_OP_FAULT_LIMIT:
> +	case PMBUS_POUT_OP_WARN_LIMIT:
> +	case PMBUS_MFR_VIN_MIN:
> +	case PMBUS_MFR_VIN_MAX:
> +	case PMBUS_MFR_IIN_MAX:
> +	case PMBUS_MFR_PIN_MAX:
> +	case PMBUS_MFR_VOUT_MIN:
> +	case PMBUS_MFR_VOUT_MAX:
> +	case PMBUS_MFR_IOUT_MAX:
> +	case PMBUS_MFR_POUT_MAX:
> +	case PMBUS_PIN_OP_WARN_LIMIT:
> +	case PMBUS_READ_VIN:
> +	case PMBUS_READ_IIN:
> +	case PMBUS_READ_VOUT:
> +	case PMBUS_READ_IOUT:
> +	case PMBUS_READ_TEMPERATURE_1:
> +	case PMBUS_READ_TEMPERATURE_2:
> +	case PMBUS_READ_TEMPERATURE_3:
> +	case PMBUS_READ_FAN_SPEED_1:
> +	case PMBUS_READ_POUT:
> +	case PMBUS_READ_PIN:
> +		ret = pmbus_read_word_data(client, page, 0xff, reg);
> +		break;

Needs explanation. What happens if unsupported registers/commands
are executed ?

> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static int acbel_crps_read_byte_data(struct i2c_client *client, int page,
> +				     int reg)
> +{
> +	int ret = 0;
> +	int mfg_status;
> +
> +	if (page >= 0) {
> +		ret = pmbus_set_page(client, page, 0xff);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	switch (reg) {
> +	case PMBUS_STATUS_VOUT:
> +	case PMBUS_STATUS_IOUT:
> +	case PMBUS_STATUS_TEMPERATURE:
> +	case PMBUS_STATUS_FAN_12:

Needs explanation. Why not use standard commands ?

> +		mfg_status = pmbus_read_word_data(client, 0, 0xff,
> +						  PMBUS_STATUS_MFR_SPECIFIC);
> +		if (mfg_status < 0)
> +			return mfg_status;
> +
> +		if (reg == PMBUS_STATUS_VOUT) {
> +			if (mfg_status & CRPS_STATUS_OV_FAULT)
> +				ret |= PB_VOLTAGE_OV_FAULT;
> +			else if (mfg_status & CRPS_STATUS_UV_FAULT)
> +				ret |= PB_VOLTAGE_UV_FAULT;
> +		} else if (reg == PMBUS_STATUS_IOUT) {
> +			if (mfg_status & CRPS_STATUS_OC_FAULT)
> +				ret |= PB_IOUT_OC_FAULT;
> +			else if (mfg_status & CRPS_STATUS_OC_WARNING)
> +				ret |= PB_IOUT_OC_WARNING;
> +			else if (mfg_status & CRPS_STATUS_OP_FAULT)
> +				ret |= PB_POUT_OP_FAULT;
> +			else if (mfg_status & CRPS_STATUS_OP_WARNING)
> +				ret |= PB_POUT_OP_WARNING;
> +		} else if (reg == PMBUS_STATUS_TEMPERATURE) {
> +			if (mfg_status & CRPS_STATUS_OT_FAULT)
> +				ret |= PB_TEMP_OT_FAULT;
> +			else if (mfg_status & CRPS_STATUS_OT_WARNING)
> +				ret |= PB_TEMP_OT_WARNING;
> +		} else if (reg == PMBUS_STATUS_FAN_12) {

Unnecessary else.

> +			if (mfg_status & CRPS_FAN1_FAULT)
> +				ret |= PB_FAN_FAN1_FAULT;
> +			else if (mfg_status & CRPS_FAN1_WARNING)
> +				ret |= PB_FAN_FAN1_WARNING;
> +			else if (mfg_status & CRPS_FAN1_SPEED_OVERRIDE)
> +				ret |= PB_FAN_FAN1_SPEED_OVERRIDE;
> +		}
> +		break;
> +	default:
> +		ret = -ENODATA;

Needs explanation. Executing other potentially unsupported byte commands
is ok, but not executing unsupported word commands ?

> +		break;
> +	}
> +	return ret;
> +}
> +
> +static struct pmbus_driver_info acbel_crps_info = {
> +        .pages = 1,
> +        .func[0] =  PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +                    PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
> +                    PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +                    PMBUS_HAVE_FAN12 |
> +                    PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT |
> +                    PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_STATUS_INPUT |
> +                    PMBUS_HAVE_STATUS_FAN12 | PMBUS_MFR_IIN_MAX,

PMBUS_MFR_IIN_MAX is wrong. This is a register/command name, not a flag.

> +        .read_word_data = acbel_crps_read_word_data,
> +        .read_byte_data = acbel_crps_read_byte_data,
> +};
> +
> +
> +static int acbel_crps_probe(struct i2c_client *client)
> +{
> +	struct dentry *acbel_crps_dir;
> +	struct dentry *debugfs;
> +	struct acbel_crps *psu;
> +	int rc, i;
> +
There is no validation that this is indeed a supported power supply.
Please add such a validation.

> +	rc = pmbus_do_probe(client, &acbel_crps_info);
> +        if (rc)
> +                return rc;
> +	/*
> +         * Don't fail the probe if there isn't enough memory for debugfs.
> +         */

Formatting. That made me run checkpatch --strict, and I get:

total: 14 errors, 15 warnings, 2 checks, 333 lines checked

Please check your patches for coding style, and please consider reading
and following Documentation/hwmon/submitting-patches.rst.

> +	psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
> +	if (!psu)
> +		return 0;
> +
> +	psu->client = client;
> +
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return 0;
> +

Please handle debugfs initialization in a separate function.

> +	acbel_crps_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!acbel_crps_dir)
> +		return 0;
> +
Please explain why you don't use pmbus_get_debugfs_dir().
Anyway, I am at loss why you don't use the already existing
debugfs support, which does report exactly the same information
(and more). Please explain.

> +	for (i = 0; i < CRPS_DEBUGFS_NUM_ENTRIES; ++i)
> +		psu->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("mfg_id", 0444, acbel_crps_dir,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_ID],
> +			    &acbel_crps_fops);
> +
> +	debugfs_create_file("part_number", 0444, acbel_crps_dir,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_MODEL],
> +			    &acbel_crps_fops);
> +
> +	debugfs_create_file("fw_version", 0444, acbel_crps_dir,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_REVISION],
> +			    &acbel_crps_fops);
> +
> +	debugfs_create_file("mfg_location", 0444, acbel_crps_dir,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_LOCATION],
> +			    &acbel_crps_fops);
> +
> +	debugfs_create_file("serial_number", 0444, acbel_crps_dir,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_MFG_SERIAL],
> +			    &acbel_crps_fops);
> +
> +	debugfs_create_file("ccin", 0444, acbel_crps_dir,
> +			    &psu->debugfs_entries[CRPS_DEBUGFS_CCIN],
> +			    &acbel_crps_fops);
> +	return 0;
> +}
> +
> +static const struct of_device_id acbel_crps_of_match[] = {
> +	{ .compatible = "acbel,crps"},
> +	{}

This suggests that the driver is expected to be used in systems using devicetree.
"acbel,crps" must be documented, either as trivial device or with an appropriate
devicetree description file.

> +};
> +MODULE_DEVICE_TABLE(of, acbel_crps_of_match);
> +
> +static struct i2c_driver acbel_crps_driver = {
> +	.driver = {
> +		.name = "acbel-crps",
> +		.of_match_table = acbel_crps_of_match,
> +	},
> +	.probe_new = acbel_crps_probe,
> +	.id_table = acbel_crps_id,
> +};
> +
> +module_i2c_driver(acbel_crps_driver);
> +
> +MODULE_AUTHOR("Lakshmi Yadlapati");
> +MODULE_DESCRIPTION("PMBus driver for AcBel Power System power supplies");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);

