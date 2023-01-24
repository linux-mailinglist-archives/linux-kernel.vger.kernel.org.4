Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA876796F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbjAXLqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjAXLp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:45:57 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A23D0BC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:45:55 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s3so10987971pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C999FwRzmG6xgSAmN5RaHaFeT5++tBFM3K6nE6gR9kQ=;
        b=MoIu6dEpxAc7v6NG9qDlkjD5VG8dNzCd1gq2NdqSiC1Jb9EffiqLLPHC4jaCERrpmH
         3B/n22ADDhlWio/1HgnHzoQa5YudgTv8QGXAhspqVq0OlUs+VOIyPoBR4Pd8VQPbVjrc
         +aIShkW+EnpmCOBR4hP2GUeymyCUiCD5QmKPwpZ8lwdRyQ72G3LON7klhOmZmgmTyIsh
         ErHZ394KZG7aDGIEg5kjDQNGzNDCcliLfcgm3EwzG+4YJd+eeXtN7YCZ3TAJe3LEItHI
         lTAdOEzElueEfY4igULvTyADrT/UsGfr3JDA6x8Q8OevLLO8UJWC6swfru6yVvEDiVMv
         V70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C999FwRzmG6xgSAmN5RaHaFeT5++tBFM3K6nE6gR9kQ=;
        b=rbqbRSeKDMM3lYZpYcv0syGes2oR2aiYIJafsi6vLxULYFyh5LLeRjWtENZFRQLqJh
         H7SsYiScQA7bdNV/wKEQZAsXV14fegYJVBrSJ6ljrT2jwpZJSveCyPQIMTKP6z50orkE
         7HPO1ytTrp+YyiELDm1IA9G4r8pF0tCfGsBq3BAM5LEAYtNOSPee3dU0G/rkQB8h4NkC
         sGt9306s8/3WOVFEIDjeVYTqlXqJNqI0+/9u3lqah7+aw/zZuZospQGTbwOyAqw+SP10
         yBqaxAAGSyKDpiDgNDcsijfXzEbmy3/kJs4f887dFsZjaFYXHXKf8x+gEsTpfcOIDr6R
         3fRA==
X-Gm-Message-State: AFqh2kr87Bg/+UXVngzEhYclmVVc0aC8MYDF6SRBZs+oysIFpC7j9tlA
        pbL0qtkH7fVI0tSTW0WwzrWvow==
X-Google-Smtp-Source: AMrXdXvfg2tuDxNrx7qnAFNJY/BpELo24XreajkdeWYqeU89AAQF0hM7X61io/Yz+JTaA+bHzFT6Cg==
X-Received: by 2002:a05:6a00:1887:b0:58c:b0a:e504 with SMTP id x7-20020a056a00188700b0058c0b0ae504mr37927015pfh.18.1674560754594;
        Tue, 24 Jan 2023 03:45:54 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id 76-20020a62164f000000b0058882b59d22sm1371528pfw.219.2023.01.24.03.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 03:45:54 -0800 (PST)
Message-ID: <05947e9f-0667-4565-b481-ca5635da4174@9elements.com>
Date:   Tue, 24 Jan 2023 17:15:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640
 Voltage Regulator
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124110111.3965317-1-Naresh.Solanki@9elements.com>
 <b4b11836-5a4b-a2b7-18e2-89ca26f19817@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <b4b11836-5a4b-a2b7-18e2-89ca26f19817@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 24-01-2023 04:40 pm, Krzysztof Kozlowski wrote:
> On 24/01/2023 12:01, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Add the pmbus driver for the Infineon TDA38640 voltage regulator.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../devicetree/bindings/trivial-devices.yaml  |  2 +
> 
> Split bindings from driver code.
Sure
> 
>>   drivers/hwmon/pmbus/Kconfig                   | 16 ++++
>>   drivers/hwmon/pmbus/Makefile                  |  1 +
>>   drivers/hwmon/pmbus/tda38640.c                | 78 +++++++++++++++++++
>>   4 files changed, 97 insertions(+)
>>   create mode 100644 drivers/hwmon/pmbus/tda38640.c
>>
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index f5c0a6283e61..a28b02036489 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -141,6 +141,8 @@ properties:
>>             - infineon,slb9645tt
>>               # Infineon SLB9673 I2C TPM 2.0
>>             - infineon,slb9673
>> +            # Infineon TDA38640 Voltage Regulator
>> +          - infineon,tda38640
>>               # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>>             - infineon,tlv493d-a1b6
>>               # Infineon Multi-phase Digital VR Controller xdpe11280
>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>> index 30448e049486..9f4bbb9c487a 100644
>> --- a/drivers/hwmon/pmbus/Kconfig
>> +++ b/drivers/hwmon/pmbus/Kconfig
>> @@ -395,6 +395,22 @@ config SENSORS_STPDDC60
>>   	  This driver can also be built as a module. If so, the module will
>>   	  be called stpddc60.
>>   
>> +config SENSORS_TDA38640
>> +	tristate "Infineon TDA38640"
>> +	help
>> +	  If you say yes here you get hardware monitoring support for Infineon
>> +	  TDA38640.
>> +
>> +	  This driver can also be built as a module. If so, the module will
>> +	  be called tda38640.
>> +
>> +config SENSORS_TDA38640_REGULATOR
>> +	bool "Regulator support for TDA38640 and compatibles"
>> +	depends on SENSORS_TDA38640 && REGULATOR
>> +	help
>> +	  If you say yes here you get regulator support for Infineon
>> +	  TDA38640 as regulator.
> 
> Drop entire option, why is it needed?
You mean regulator option ?
This is how other pmbus regulator devices have provided option.
> 
>> +
>>   config SENSORS_TPS40422
>>   	tristate "TI TPS40422"
>>   	help
>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>> index d9d2fa4bd6f7..3ae019916267 100644
>> --- a/drivers/hwmon/pmbus/Makefile
>> +++ b/drivers/hwmon/pmbus/Makefile
>> @@ -40,6 +40,7 @@ obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>>   obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>>   obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
>>   obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
>> +obj-$(CONFIG_SENSORS_TDA38640)	+= tda38640.o
>>   obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>>   obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>>   obj-$(CONFIG_SENSORS_TPS546D24)	+= tps546d24.o
>> diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
>> new file mode 100644
>> index 000000000000..31e17a936b8c
>> --- /dev/null
>> +++ b/drivers/hwmon/pmbus/tda38640.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Hardware monitoring driver for Infineon TDA38640
>> + *
>> + * Copyright (c) 2023 9elements GmbH
>> + *
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/regulator/driver.h>
>> +#include "pmbus.h"
>> +
>> +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
>> +static const struct regulator_desc tda38640_reg_desc[] = {
>> +	PMBUS_REGULATOR("vout", 0),
>> +};
>> +#endif /* CONFIG_SENSORS_TDA38640_REGULATOR */
>> +
>> +static struct pmbus_driver_info tda38640_info = {
>> +	.pages = 1,
>> +	.format[PSC_VOLTAGE_IN] = linear,
>> +	.format[PSC_VOLTAGE_OUT] = linear,
>> +	.format[PSC_CURRENT_OUT] = linear,
>> +	.format[PSC_CURRENT_IN] = linear,
>> +	.format[PSC_POWER] = linear,
>> +	.format[PSC_TEMPERATURE] = linear,
>> +
>> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>> +	    | PMBUS_HAVE_IIN
>> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
>> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
>> +	    | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN,
>> +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
>> +	.num_regulators = 1,
>> +	.reg_desc = tda38640_reg_desc,
>> +#endif
>> +};
>> +
>> +static int tda38640_probe(struct i2c_client *client)
>> +{
>> +	return pmbus_do_probe(client, &tda38640_info);
>> +}
>> +
>> +static const struct i2c_device_id tda38640_id[] = {
>> +	{"tda38640", 0},
>> +	{}
>> +};
>> +
> 
> Drop blank line
Sure
> 
>> +MODULE_DEVICE_TABLE(i2c, tda38640_id);
>> +
>> +#ifdef CONFIG_OF
> 
> Drop ifdefs and use __maybe_unused
> 
>> +static const struct of_device_id tda38640_of_match[] = {
>> +	{ .compatible = "infineon,tda38640"},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, tda38640_of_match);
> 
> Where is it used? You miss the user.
I'm not sure if I get your question right.
This chip is used in sbp1 board to power CPU rails.
> 
>> +#endif
>> +
>> +/* This is the driver that will be inserted */
>> +static struct i2c_driver tda38640_driver = {
>> +	.driver = {
>> +		   .name = "tda38640",
>> +		   },
>> +	.probe_new = tda38640_probe,
>> +	.id_table = tda38640_id,
>> +};
> 
> Best regards,
> Krzysztof
> 

Best regards,
Naresh
