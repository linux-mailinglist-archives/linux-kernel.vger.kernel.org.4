Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836A6DFA45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjDLPdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjDLPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:33:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969E5BA0;
        Wed, 12 Apr 2023 08:33:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p8so11845920plk.9;
        Wed, 12 Apr 2023 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681313601; x=1683905601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+I+BkK88saPfQ4NI6f6baJd0LfyYvQ7yABMz5aGWDU=;
        b=INVSlDtd44zEUtZ3d5zo+oLxVZFMwUUQiwKBAuc9Z4Pa1nAXWQZpjrbXdpdflvODrZ
         O7CbpT00ewJ0t0sEXpBQ3R5hPAGfMlOqoSOW1QjtJZPJaG319xwsERB088Z6jx4uC9BW
         PfQtP5idCc67K2uUKsfM3djV7KyI5i4q/Wma1DRhvRLU05U1KusykLb16tEB11xaAc1g
         jItF3VTUGEs3AYfVpr+CJujnZLX7ZoGAlxedODCep3vcl4TU+ZsQeO6mLBcyBWEznYl0
         bQ8dV1ZFI6bUrIJXqGbYPQ+XfynnGeERLYLz0P1wU/z3v08oK+f53Sn6xV3UHmluSTMR
         vj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681313601; x=1683905601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+I+BkK88saPfQ4NI6f6baJd0LfyYvQ7yABMz5aGWDU=;
        b=oBCDANi2Tdct5UcJIRAsN2sTB3+qEO4EsI7CNDvM/OndgZojiclRANrshFirqi/mqc
         u20Rgfy/+9eLOR+/zvJsV5Za3XA+FY0NbTL+x187fCkGBg/TEJJVHRJsMVmhQU+p+E1C
         WMmJ/cCmsFFvFzjN7fY5xvx49i1SS2m+R/Dj2ACruyKXHvKusOcO/FqUX2Di0mL6IiI7
         eR2AQKEA6X4CAI0ziMOgnW4DQJ4urZ/mNFCnD08v14t6nap7+atkkLEbNIOraF1hL1om
         KXywreETium6BcoFlgNcHBcaUjTq8gDagIaOrAuZHxBnKIW+dPadM0Kei/8q5rSIfcbe
         krkA==
X-Gm-Message-State: AAQBX9dOSOrrb5MZb1KpcNOBO1ztT4z7LXC2A1PPbkFKE12fJ0biy2dF
        7I8WwMe6hvL4iVQX3cTOvZM=
X-Google-Smtp-Source: AKy350b05dL6SBPRrvLyJspW9POGw+QNcUjzoQpunL3WSpCkGduptTKUTdzZPNsQ/pG3tQSqY4zTRw==
X-Received: by 2002:a17:90b:48c9:b0:246:57f6:44b5 with SMTP id li9-20020a17090b48c900b0024657f644b5mr3455515pjb.12.1681313601373;
        Wed, 12 Apr 2023 08:33:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jw6-20020a170903278600b0019682e27995sm11797888plb.223.2023.04.12.08.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:33:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Apr 2023 08:33:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Message-ID: <31bff772-b005-4aeb-85b8-ecd5b6847907@roeck-us.net>
References: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
 <20230412052305.1369521-4-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412052305.1369521-4-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 12:23:03AM -0500, Lakshmi Yadlapati wrote:
> Add the driver to support ACBEL FSG032 power supply.
> 
> Change-Id: Ief984325fe3fa0ed042e1d00e34ff579b45e1c81
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>  drivers/hwmon/pmbus/Kconfig        |  9 +++
>  drivers/hwmon/pmbus/Makefile       |  1 +
>  drivers/hwmon/pmbus/acbel-fsg032.c | 95 ++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 59d9a7430499..270b6336b76d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -27,6 +27,15 @@ config SENSORS_PMBUS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pmbus.
>  
> +config SENSORS_ACBEL_FSG032
> +	tristate "ACBEL FSG032 Power Supply"
> +	help
> +	  If you say yes here you get hardware monitoring support for the ACBEL
> +	  FSG032 Power Supply.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called acbel-fsg032.
> +
>  config SENSORS_ADM1266
>  	tristate "Analog Devices ADM1266 Sequencer"
>  	select CRC8
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 3ae019916267..84ee960a6c2d 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
> +obj-$(CONFIG_SENSORS_ACBEL_FSG032) += acbel-fsg032.o
>  obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
> diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c b/drivers/hwmon/pmbus/acbel-fsg032.c
> new file mode 100644
> index 000000000000..f160f45c7ac5
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/acbel-fsg032.c
> @@ -0,0 +1,95 @@
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
> +static const struct i2c_device_id acbel_fsg032_id[] = {
> +	{ "acbel_fsg032" },
> +	{}
> +};
> +
> +static struct pmbus_driver_info acbel_fsg032_info = {
> +	.pages = 1,
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
> +		   PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_POUT |
> +		   PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3 |
> +		   PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_VOUT |
> +		   PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_TEMP |
> +		   PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_FAN12,
> +};
> +
> +static int acbel_fsg032_probe(struct i2c_client *client)
> +{
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 1];
> +	struct device *dev = &client->dev;
> +	struct dentry *debugfs;
> +	int rc;
> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read PMBUS_MFR_ID\n");
> +		return rc;
> +	}
> +	if (strncmp(buf, "ACBEL", 5)) {
> +		buf[rc] = '\0';
> +		dev_err(dev, "Manufacturer '%s' not supported\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	rc = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
> +	if (rc < 0) {
> +		dev_err(dev, "Failed to read PMBUS_MFR_MODEL\n");
> +		return rc;
> +	}
> +
> +	if (strncmp(buf, "FSG032", 6)) {
> +		buf[rc] = '\0';
> +		dev_err(dev, "Model '%s' not supported\n", buf);
> +		return -ENODEV;
> +	}
> +
> +	rc = pmbus_do_probe(client, &acbel_fsg032_info);
> +	if (rc)
> +		return rc;
> +
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return rc;
> +
> +	/* ccin is not available, create a symlink from the
> +	 * mfr_serial to ccin as required by hwmon */

There is no such hwmon requirement (hwmon neither knows nor
cares about "ccin"), and this is not a valid multi-line comment.
Please drop this change.

If some userspace code is looking for a debugfs file named "ccin",
change it to read "mfr_serial" instead of "ccin" if "ccin" is
not available. Hacking a kernel driver to meet some arbitrary
userspace requirement is not acceptable.

Thanks,
Guenter

> +	debugfs_create_symlink("ccin", debugfs, "mfr_serial");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id acbel_fsg032_of_match[] = {
> +	{ .compatible = "acbel,fsg032" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, acbel_fsg032_of_match);
> +
> +static struct i2c_driver acbel_fsg032_driver = {
> +	.driver = {
> +		.name = "acbel-fsg032",
> +		.of_match_table = acbel_fsg032_of_match,
> +	},
> +	.probe_new = acbel_fsg032_probe,
> +	.id_table = acbel_fsg032_id,
> +};
> +
> +module_i2c_driver(acbel_fsg032_driver);
> +
> +MODULE_AUTHOR("Lakshmi Yadlapati");
> +MODULE_DESCRIPTION("PMBus driver for AcBel Power System power supplies");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(PMBUS);
> -- 
> 2.37.2
> 
