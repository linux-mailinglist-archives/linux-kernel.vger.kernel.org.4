Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D618A679643
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjAXLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjAXLKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:10:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC612873
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:10:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t18so688863wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXedPZUzvmpRax44TR36pQBVZZnvRJjFRluQuQKM+QE=;
        b=fY7TM5NiOP5YFJ1l01jIGUeV6RHxVdh7Q92sDqC+8or0Sm2//MiTsY1WdscTLkke/b
         dR2uSZgMowtEQdYmSga+Tg8VHXcYZ2PsN850+tZm5RXQA/eEDJd61AkK/aAKEs8bTyXZ
         9w2YnC+M8sba2nwSeb4D70VOsQFdYrnWfxChWjazPikwmvSgF5NskOGN6aVi++bWcB04
         mkGZJQrv1bGGolRKGo5D0VlJ4c27SRYw9sRAMJPbnyDSg+/xLCDHnLm8T7/fD+UIzGSa
         41Pht3TgvoLUX4TLOMOJRjcm5Py2fbW0Ry7AhhT01WYVd5YsXE/Vk1EKiQHZQw8ZL/O1
         1wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXedPZUzvmpRax44TR36pQBVZZnvRJjFRluQuQKM+QE=;
        b=NFjbXmdhuRVMezz8zXL5cvG5Xp9FD7ktaZqPMUNY61ck0iGzJdalUxZ45uvfyAmkGI
         JAp7CKm75v3V2NH9IxD5wNi1pwWookAL70zW+fBRQpxDxVl9peTqQfc+V82gfQEcEack
         4Og0RVZ/sdBNH0xaM1PZGny3aqe5alQo89oKsCtfO9GH0fo7lYOcTKgUWm2z0LrVpcxM
         N5NNVttOieApvxZHdtK7CKRI1vM9KdoO91SuyrQPGOFZAf0mZkUl8VfJTzHGLShPeuyR
         LktK8QaZHpubStmsowFF9r7dJ6PEUaYNWK4HQnaalSnXfOLzdkHYnTEocuR+PPbC+gol
         V3mA==
X-Gm-Message-State: AFqh2koUjcEv4c69wjLkOkUOdGf/IW+8jZHCOlaZTBTBnlQ8GhDL74ok
        U5PJreeNQbYKo2Bebfehw8vxgg==
X-Google-Smtp-Source: AMrXdXulPHEEQgYIOrWZ3fdFI3BgCzZvJ9Web0nW6DxJBAR73XfX5mzg1VJqM4M2H61l1gx1O0dmjg==
X-Received: by 2002:a5d:6b85:0:b0:2bd:d782:c2bc with SMTP id n5-20020a5d6b85000000b002bdd782c2bcmr24583154wrx.33.1674558611482;
        Tue, 24 Jan 2023 03:10:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d4e0f000000b002bdc39849d1sm1634610wrt.44.2023.01.24.03.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 03:10:11 -0800 (PST)
Message-ID: <b4b11836-5a4b-a2b7-18e2-89ca26f19817@linaro.org>
Date:   Tue, 24 Jan 2023 12:10:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640
 Voltage Regulator
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124110111.3965317-1-Naresh.Solanki@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124110111.3965317-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 12:01, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add the pmbus driver for the Infineon TDA38640 voltage regulator.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  .../devicetree/bindings/trivial-devices.yaml  |  2 +

Split bindings from driver code.

>  drivers/hwmon/pmbus/Kconfig                   | 16 ++++
>  drivers/hwmon/pmbus/Makefile                  |  1 +
>  drivers/hwmon/pmbus/tda38640.c                | 78 +++++++++++++++++++
>  4 files changed, 97 insertions(+)
>  create mode 100644 drivers/hwmon/pmbus/tda38640.c
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index f5c0a6283e61..a28b02036489 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -141,6 +141,8 @@ properties:
>            - infineon,slb9645tt
>              # Infineon SLB9673 I2C TPM 2.0
>            - infineon,slb9673
> +            # Infineon TDA38640 Voltage Regulator
> +          - infineon,tda38640
>              # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>            - infineon,tlv493d-a1b6
>              # Infineon Multi-phase Digital VR Controller xdpe11280
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 30448e049486..9f4bbb9c487a 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -395,6 +395,22 @@ config SENSORS_STPDDC60
>  	  This driver can also be built as a module. If so, the module will
>  	  be called stpddc60.
>  
> +config SENSORS_TDA38640
> +	tristate "Infineon TDA38640"
> +	help
> +	  If you say yes here you get hardware monitoring support for Infineon
> +	  TDA38640.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called tda38640.
> +
> +config SENSORS_TDA38640_REGULATOR
> +	bool "Regulator support for TDA38640 and compatibles"
> +	depends on SENSORS_TDA38640 && REGULATOR
> +	help
> +	  If you say yes here you get regulator support for Infineon
> +	  TDA38640 as regulator.

Drop entire option, why is it needed?

> +
>  config SENSORS_TPS40422
>  	tristate "TI TPS40422"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index d9d2fa4bd6f7..3ae019916267 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
>  obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
> +obj-$(CONFIG_SENSORS_TDA38640)	+= tda38640.o
>  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_TPS546D24)	+= tps546d24.o
> diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
> new file mode 100644
> index 000000000000..31e17a936b8c
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/tda38640.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Hardware monitoring driver for Infineon TDA38640
> + *
> + * Copyright (c) 2023 9elements GmbH
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/driver.h>
> +#include "pmbus.h"
> +
> +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
> +static const struct regulator_desc tda38640_reg_desc[] = {
> +	PMBUS_REGULATOR("vout", 0),
> +};
> +#endif /* CONFIG_SENSORS_TDA38640_REGULATOR */
> +
> +static struct pmbus_driver_info tda38640_info = {
> +	.pages = 1,
> +	.format[PSC_VOLTAGE_IN] = linear,
> +	.format[PSC_VOLTAGE_OUT] = linear,
> +	.format[PSC_CURRENT_OUT] = linear,
> +	.format[PSC_CURRENT_IN] = linear,
> +	.format[PSC_POWER] = linear,
> +	.format[PSC_TEMPERATURE] = linear,
> +
> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> +	    | PMBUS_HAVE_IIN
> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> +	    | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN,
> +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
> +	.num_regulators = 1,
> +	.reg_desc = tda38640_reg_desc,
> +#endif
> +};
> +
> +static int tda38640_probe(struct i2c_client *client)
> +{
> +	return pmbus_do_probe(client, &tda38640_info);
> +}
> +
> +static const struct i2c_device_id tda38640_id[] = {
> +	{"tda38640", 0},
> +	{}
> +};
> +

Drop blank line

> +MODULE_DEVICE_TABLE(i2c, tda38640_id);
> +
> +#ifdef CONFIG_OF

Drop ifdefs and use __maybe_unused

> +static const struct of_device_id tda38640_of_match[] = {
> +	{ .compatible = "infineon,tda38640"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tda38640_of_match);

Where is it used? You miss the user.

> +#endif
> +
> +/* This is the driver that will be inserted */
> +static struct i2c_driver tda38640_driver = {
> +	.driver = {
> +		   .name = "tda38640",
> +		   },
> +	.probe_new = tda38640_probe,
> +	.id_table = tda38640_id,
> +};

Best regards,
Krzysztof

