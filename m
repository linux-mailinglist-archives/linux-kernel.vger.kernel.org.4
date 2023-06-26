Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971E573D829
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjFZG6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFZG6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:58:34 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC47FA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:58:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69f1570b2so11504751fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687762700; x=1690354700;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R61KK43lTSdAQv3Arhvv0Qb6uDZ5LvY9B2fbntc2XDg=;
        b=WeeQtApVlpf7kbYUUEvk4fOUJ7bRlkFugLX+F91AVSQVYjUhqTvbdE3WIrsg9jJg3T
         3wCigyLxcJflzuRu8xlqRturZ1RXn8B14ibE5Cw5G0olGQJzQCBZS+L1Jop8y334wUGh
         nf5I0jDx1TIkOvSBCxo/hziZ9Y0BZ8gzqNUHr97FyPsJN+GYgUNO6yXY01PHnYba83Yi
         DWyrNl5ZjGRXo7Gh3j+L8s1BI/YgNS1UkXsRGVZ2Y0zY7sIjE4tltoWwpxKCE+ZJFtSr
         /gPIUM2r+iCCcbQXieaKnb/vwuRG0JYNBqyBvXqwtKmb9pvTbJYtfqW8/LTvViMw+x1Z
         /N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687762700; x=1690354700;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R61KK43lTSdAQv3Arhvv0Qb6uDZ5LvY9B2fbntc2XDg=;
        b=M1VE/9zuK4xeLAvcF+aO/b6rBuOf8F/wE3IwBElWVaVLoCOPzYyEAzjkButMiPxsRn
         jKj/Ge05cZ+3SmWxG6H8FEhaLWkQopzROAE7fdtw6cZ1rgDjxOc/jq9BVHdzmeHPbeyr
         8LEYCBJTmuVRqSJNoKkex2WJW6U6nWXJEZoZsmxI5LpPxB0mJiATp792KrKX9Lm0+yXi
         VfG2b0EYuaOSkltagTL86hinfNgopPZUB/YrTG3ju6ixkEVPKqc30h+qnsi4VEUMNai8
         oCmllbDP3l9oUPFhZTmChcEdbM0TkX3+FwhNHRV5dSQuT9GrryDA/kMzf749bVLIuaeb
         6b5A==
X-Gm-Message-State: AC+VfDxWmzx2Z3ZXSrjSRN80+2zVhBiZmlU0d4Ip/kubP+d/jNxFJLJI
        EcmXoZTqZ+h4Gy0v2HviDW872A==
X-Google-Smtp-Source: ACHHUZ7F/5gXkoO0TOzPhr/jjAWY3ZTwIeUlHEr17cznGxLAeyqbltCsjVkc0SuOEkzLvLbF1Wqj5g==
X-Received: by 2002:a2e:8014:0:b0:2b4:7c90:c7b8 with SMTP id j20-20020a2e8014000000b002b47c90c7b8mr13750527ljg.45.1687762699932;
        Sun, 25 Jun 2023 23:58:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:9a76:3d38:5d1f:60c? ([2a01:e0a:982:cbb0:9a76:3d38:5d1f:60c])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f9b2c602c0sm9624002wmh.37.2023.06.25.23.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 23:58:19 -0700 (PDT)
Message-ID: <9da5b3f3-af65-c751-4371-bdd2d96c8c65@linaro.org>
Date:   Mon, 26 Jun 2023 08:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/4] input: touchscreen: add I2C support for Goodix
 Berlin Touchscreen IC
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v3-3-f0577cead709@linaro.org>
 <ZJiS37RV4ApshVxs@nixie71>
Organization: Linaro Developer Services
In-Reply-To: <ZJiS37RV4ApshVxs@nixie71>
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

Hi Jeff,

On 25/06/2023 21:17, Jeff LaBundy wrote:
> Hi Neil,
> 
> On Thu, Jun 22, 2023 at 04:29:01PM +0200, Neil Armstrong wrote:
>> Add initial support for the new Goodix "Berlin" touchscreen ICs
>> over the I2C interface.
>>
>> This initial driver is derived from the Goodix goodix_ts_berlin
>> available at [1] and [2] and only supports the GT9916 IC
>> present on the Qualcomm SM8550 MTP & QRD touch panel.
>>
>> The current implementation only supports BerlinD, aka GT9916.
>>
>> [1] https://github.com/goodix/goodix_ts_berlin
>> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> Just one comment below, then feel free to add:
> 
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> 
>>   drivers/input/touchscreen/Kconfig             | 14 ++++++
>>   drivers/input/touchscreen/Makefile            |  1 +
>>   drivers/input/touchscreen/goodix_berlin_i2c.c | 69 +++++++++++++++++++++++++++
>>   3 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
>> index 1a6f6f6da991..5e21cca6025d 100644
>> --- a/drivers/input/touchscreen/Kconfig
>> +++ b/drivers/input/touchscreen/Kconfig
>> @@ -421,6 +421,20 @@ config TOUCHSCREEN_GOODIX_BERLIN_CORE
>>   	depends on REGMAP
>>   	tristate
>>   
>> +config TOUCHSCREEN_GOODIX_BERLIN_I2C
>> +	tristate "Goodix Berlin I2C touchscreen"
>> +	depends on I2C
>> +	depends on REGMAP_I2C
> 
> select REGMAP_I2C
> 
> (keep "depends on I2C")

Good point,

Thanks,
Neil

> 
>> +	select TOUCHSCREEN_GOODIX_BERLIN_CORE
>> +	help
>> +	  Say Y here if you have a Goodix Berlin IC connected to
>> +	  your system via I2C.
>> +
>> +	  If unsure, say N.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called goodix_berlin_i2c.
>> +
>>   config TOUCHSCREEN_HIDEEP
>>   	tristate "HiDeep Touch IC"
>>   	depends on I2C
>> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
>> index 29cdb042e104..921a2da0c2be 100644
>> --- a/drivers/input/touchscreen/Makefile
>> +++ b/drivers/input/touchscreen/Makefile
>> @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
>>   obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>>   obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>>   obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
>> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
>>   obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>>   obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>>   obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
>> diff --git a/drivers/input/touchscreen/goodix_berlin_i2c.c b/drivers/input/touchscreen/goodix_berlin_i2c.c
>> new file mode 100644
>> index 000000000000..6407b2258eb1
>> --- /dev/null
>> +++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Goodix Berlin Touchscreen Driver
>> + *
>> + * Copyright (C) 2020 - 2021 Goodix, Inc.
>> + * Copyright (C) 2023 Linaro Ltd.
>> + *
>> + * Based on goodix_ts_berlin driver.
>> + */
>> +#include <linux/i2c.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "goodix_berlin.h"
>> +
>> +#define I2C_MAX_TRANSFER_SIZE		256
>> +
>> +static const struct regmap_config goodix_berlin_i2c_regmap_conf = {
>> +	.reg_bits = 32,
>> +	.val_bits = 8,
>> +	.max_raw_read = I2C_MAX_TRANSFER_SIZE,
>> +	.max_raw_write = I2C_MAX_TRANSFER_SIZE,
>> +};
>> +
>> +/* vendor & product left unassigned here, should probably be updated from fw info */
>> +static const struct input_id goodix_berlin_i2c_input_id = {
>> +	.bustype = BUS_I2C,
>> +};
>> +
>> +static int goodix_berlin_i2c_probe(struct i2c_client *client)
>> +{
>> +	struct regmap *regmap;
>> +
>> +	regmap = devm_regmap_init_i2c(client, &goodix_berlin_i2c_regmap_conf);
>> +	if (IS_ERR(regmap))
>> +		return PTR_ERR(regmap);
>> +
>> +	return goodix_berlin_probe(&client->dev, client->irq,
>> +				   &goodix_berlin_i2c_input_id, regmap);
>> +}
>> +
>> +static const struct i2c_device_id goodix_berlin_i2c_id[] = {
>> +	{ "gt9916", 0 },
>> +	{ }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, goodix_berlin_i2c_id);
>> +
>> +static const struct of_device_id goodix_berlin_i2c_of_match[] = {
>> +	{ .compatible = "goodix,gt9916", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, goodix_berlin_i2c_of_match);
>> +
>> +static struct i2c_driver goodix_berlin_i2c_driver = {
>> +	.driver = {
>> +		.name = "goodix-berlin-i2c",
>> +		.of_match_table = goodix_berlin_i2c_of_match,
>> +		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
>> +	},
>> +	.probe = goodix_berlin_i2c_probe,
>> +	.id_table = goodix_berlin_i2c_id,
>> +};
>> +module_i2c_driver(goodix_berlin_i2c_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Goodix Berlin I2C Touchscreen driver");
>> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
>>
>> -- 
>> 2.34.1
>>
> 
> Kind regards,
> Jeff LaBundy

