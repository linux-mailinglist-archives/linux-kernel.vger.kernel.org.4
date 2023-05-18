Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B75D708310
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjERNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjERNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:44:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA32134
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:44:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64d11974b45so621822b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1684417458; x=1687009458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jd+oBsqIBnffM3Ua1/Cw49f5fKwtPjHQK21POnBYC0=;
        b=Hpr6jVLOwD3j+Ul/LSJsic1pBDwPhwSInWqI8soEKKs+lxjBoBRNihQlDOEizSRrlN
         +kWT9vRHrVVybvInEcZZB5gXRZqO3BKNaSwROK7f10Za30x3+z4QwQY9I7AT+O9Tar0n
         9dI9aT9MtTp+ONVmjER7AWXRMbUhLauTmd3Po724nvBMYKAqob8TtUQkFX2zbHcvMh6/
         daY5N+8HVYkALILBKS4Fpxiqy4pB+hzcKbrXK54Z5gjaUb8G+X0S46jKrUpbOffe23zH
         f3iAXehDnhEInRoZ+uQZMIp4ouHl9V1Nh6I+Ckj0EmX8xJQTnkBAZcr9fdWu+XYfVL4e
         KNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684417458; x=1687009458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jd+oBsqIBnffM3Ua1/Cw49f5fKwtPjHQK21POnBYC0=;
        b=MioVMWdxY6aK/PxMtGnWmUUhA+PvSbojusT3Gf0TieIoJYEe7W7/N+KEWvgehusNcL
         FGMd5oW4hvqN4bhC//8quVxdZ3gXlLblz4UZVw8FnPcZDFeI4NFxrL3TfQWbEaYjhGmL
         7jMcbqU1sJcXwIHy7Nbh0c2j266jzI3yZQClBekQq4xxpKx/8vVig4ZhY/niUkkn2bFN
         QcYWHAk5i/R281qeE/ZI29qn9HHQPcJM4A7aGM5ZBzwS/ErJE8QEDs34ZWNCwjrcFj4x
         fF3YMqA4PdRO5MlDd/r4A1TOb68a3iUXGBUel3+CSb+FoF5jTzBLpc5r8p1N+uT/31Ak
         X96A==
X-Gm-Message-State: AC+VfDwHZUY6UM2dfkzMsrW2uauuYn+QRATuXQgI/wFk1/SoNeM0gh39
        4OwGrkNMgqXr2o5Yw7EFix1zzJbkmOKHJ5D7ub4=
X-Google-Smtp-Source: ACHHUZ60lgSXFNiCl/RWO8oKMbqjwK2dr8CPYd9rWPVX+emq5qRdUofDVhaQtydRxk+vgIYS4Rhxhg==
X-Received: by 2002:a05:6a20:72a5:b0:109:c161:704c with SMTP id o37-20020a056a2072a500b00109c161704cmr1329206pzk.28.1684417458002;
        Thu, 18 May 2023 06:44:18 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b0063d24fcc2b7sm1370266pfo.1.2023.05.18.06.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 06:44:17 -0700 (PDT)
Message-ID: <14badbda-9f27-bd5d-bd59-5515c9824886@9elements.com>
Date:   Thu, 18 May 2023 19:14:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
To:     Lee Jones <lee@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
 <20230518101423.GE404509@google.com>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230518101423.GE404509@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 18-05-2023 03:44 pm, Lee Jones wrote:
> On Thu, 27 Apr 2023, Naresh Solanki wrote:
> 
>> The previous version of this driver included wildcards in file names
>> and descriptions. This patch renames the driver to only support MAX5970
>> and MAX5978, which are the only chips that the driver actually supports.
> 
> So multiple devices are supported:
> 
>    MAX5970  ... AND
>    MAX5978  ... thus
>    MAX597X  ... does make sense, no?
>   
>   What are you trying to achieve?
Understood. It is important to note that there are indeed other 
unrelated chips in addition to MAX5970 and MAX5978. Examples include 
MAX5971, which is a Single-Port, 40W, IEEE 802.3af/at PSE Controller 
with Integrated MOSFET, and MAX5974A, an Active-Clamped, 
Spread-Spectrum, Current-Mode PWM Controller, among others.

With this change, the intention is to be specific about the chips the 
driver supports. Instead of using wildcards or a broad "MAX597X" 
designation, the patch aims to exclusively support the MAX5970 and 
MAX5978 chips.

> 
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/mfd/Kconfig                        |  4 ++--
>>   drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
>>   include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
>>   3 files changed, 19 insertions(+), 19 deletions(-)
>>   rename include/linux/mfd/{max597x.h => max5970.h} (92%)
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index e90463c4441c..71231388e03c 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -266,8 +266,8 @@ config MFD_MADERA_SPI
>>   	  Support for the Cirrus Logic Madera platform audio SoC
>>   	  core functionality controlled via SPI.
>>   
>> -config MFD_MAX597X
>> -	tristate "Maxim 597x power switch and monitor"
>> +config MFD_MAX5970
>> +	tristate "Maxim 5970/5978 power switch and monitor"
>>   	depends on (I2C && OF)
>>   	select MFD_SIMPLE_MFD_I2C
>>   	help
>> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
>> index 20782b4dd172..1f1c007560d8 100644
>> --- a/drivers/mfd/simple-mfd-i2c.c
>> +++ b/drivers/mfd/simple-mfd-i2c.c
>> @@ -72,22 +72,22 @@ static const struct simple_mfd_data silergy_sy7636a = {
>>   	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
>>   };
>>   
>> -static const struct mfd_cell max597x_cells[] = {
>> -	{ .name = "max597x-regulator", },
>> -	{ .name = "max597x-iio", },
>> -	{ .name = "max597x-led", },
>> +static const struct mfd_cell max5970_cells[] = {
>> +	{ .name = "max5970-regulator", },
>> +	{ .name = "max5970-iio", },
>> +	{ .name = "max5970-led", },
>>   };
>>   
>> -static const struct simple_mfd_data maxim_max597x = {
>> -	.mfd_cell = max597x_cells,
>> -	.mfd_cell_size = ARRAY_SIZE(max597x_cells),
>> +static const struct simple_mfd_data maxim_max5970 = {
>> +	.mfd_cell = max5970_cells,
>> +	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
>>   };
>>   
>>   static const struct of_device_id simple_mfd_i2c_of_match[] = {
>>   	{ .compatible = "kontron,sl28cpld" },
>>   	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
>> -	{ .compatible = "maxim,max5970", .data = &maxim_max597x},
>> -	{ .compatible = "maxim,max5978", .data = &maxim_max597x},
>> +	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
>> +	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
>> diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max5970.h
>> similarity index 92%
>> rename from include/linux/mfd/max597x.h
>> rename to include/linux/mfd/max5970.h
>> index a850b2e02e6a..762a7d40c843 100644
>> --- a/include/linux/mfd/max597x.h
>> +++ b/include/linux/mfd/max5970.h
>> @@ -7,25 +7,25 @@
>>    * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
>>    */
>>   
>> -#ifndef _MFD_MAX597X_H
>> -#define _MFD_MAX597X_H
>> +#ifndef _MFD_MAX5970_H
>> +#define _MFD_MAX5970_H
>>   
>>   #include <linux/regmap.h>
>>   
>>   #define MAX5970_NUM_SWITCHES 2
>>   #define MAX5978_NUM_SWITCHES 1
>> -#define MAX597X_NUM_LEDS     4
>> +#define MAX5970_NUM_LEDS     4
>>   
>> -struct max597x_data {
>> +struct max5970_data {
>>   	int num_switches;
>>   	u32 irng[MAX5970_NUM_SWITCHES];
>>   	u32 mon_rng[MAX5970_NUM_SWITCHES];
>>   	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
>>   };
>>   
>> -enum max597x_chip_type {
>> -	MAX597x_TYPE_MAX5978 = 1,
>> -	MAX597x_TYPE_MAX5970,
>> +enum max5970_chip_type {
>> +	TYPE_MAX5978 = 1,
>> +	TYPE_MAX5970,
>>   };
>>   
>>   #define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
>> @@ -93,4 +93,4 @@ enum max597x_chip_type {
>>   #define MAX_REGISTERS			0x49
>>   #define ADC_MASK			0x3FF
>>   
>> -#endif				/* _MFD_MAX597X_H */
>> +#endif				/* _MFD_MAX5970_H */
>>
>> base-commit: b4c288cfd2f84c44994330c408e14645d45dee5b
>> -- 
>> 2.39.1
>>
> 

Regards,
Naresh
