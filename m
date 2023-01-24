Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093826797A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjAXMTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbjAXMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:19:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD51457D5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:19:23 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so11370344pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/7Qu8+3n1M8/9GOtQ5EA0GbOvgIBu69H4oMSLKB4RU=;
        b=gFLiV5tfkgWilYvilc2OjqCiE4ojC5DbptZJ+Z3A23EwAvNvB8V/zwRslyMfz98GQ0
         dCO8BqEEO8/Va3C11xmtci/elCMFrz4GqUqLk/znJwK00v1q6CIxnvtDALHrwsOYmLP9
         YCZpQ/6wjV+K614rz5LhfvOABnrvvALvbYzXrvcHYZLOmfXFWUKW7cCO5G9JuBQvRK7I
         we/+a9kIzzeymeuIj5BUR22uiGzfDff6JYa3s6zHMcLa03yLP+izkwL7tbCje4QoQ+Uh
         GYlC5P5Z5yh4Ph9Xm1GUXnh70l57Wpo3k7WJIStAokegORE1OAV00cQ/IOdqYIzJ+V65
         mmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/7Qu8+3n1M8/9GOtQ5EA0GbOvgIBu69H4oMSLKB4RU=;
        b=RiS29tnYl6BKt6kj8zbEqpAt0TDf9Tuey6BUM4vVjrD2rZE2Zb8ODR871Uew5LcMO/
         7mLGKCtI+KAEXv+RRE56YUSycVqx+qxeRClqekZHU3kPsLFCo1U+YmsJR8EphtDwUK2w
         3wYb78c/hx9DflRTGa+4RX7ni/0bl8qOLjxd8iYVyy9s/DYK5tyFgBWbidWr2lr5jxoz
         WdY5KaXAgeqk9Zbq9Z+N6Ljv+tlQxrMudW9sYUmid/Q/7aoZwlAEInKxxG+L/5Nctb++
         eofibAO7r+tAqt564H7vkV8wBxwksch+/yga2FbXE/Ud0G+00mKm6q+I7Fkj2XyNfRmm
         sugA==
X-Gm-Message-State: AFqh2kop4P68LkqjQxuRK5N+IenNDbkhQKDcO5KlwKGuBj8PvyZhpFiU
        fFIwGFSfr1zManfcwr+su+UL+w==
X-Google-Smtp-Source: AMrXdXtufDumWV+8RAXQ8wsMW2TlQHdMz5dV3ooJEie5JhRJKuPT+qDq47usLgM+OvGgRlC85uh10Q==
X-Received: by 2002:a17:90a:1a41:b0:22b:b82a:f3a6 with SMTP id 1-20020a17090a1a4100b0022bb82af3a6mr14479079pjl.33.1674562763389;
        Tue, 24 Jan 2023 04:19:23 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a1c8800b0020aacde1964sm8182776pjt.32.2023.01.24.04.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 04:19:22 -0800 (PST)
Message-ID: <3993c666-7038-76f8-9216-3db23ca0bffb@9elements.com>
Date:   Tue, 24 Jan 2023 17:49:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] hwmon: (pmbus/tda38640) Add driver for Infineon TDA38640
 Voltage Regulator
Content-Language: en-US
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
 <05947e9f-0667-4565-b481-ca5635da4174@9elements.com>
 <d8fb3c45-435d-f080-6ba4-e9e4595f3638@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <d8fb3c45-435d-f080-6ba4-e9e4595f3638@linaro.org>
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

On 24-01-2023 05:35 pm, Krzysztof Kozlowski wrote:
> On 24/01/2023 12:45, Naresh Solanki wrote:
>> Hi
>>
>> On 24-01-2023 04:40 pm, Krzysztof Kozlowski wrote:
>>> On 24/01/2023 12:01, Naresh Solanki wrote:
>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>
>>>> Add the pmbus driver for the Infineon TDA38640 voltage regulator.
>>>>
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>>    .../devicetree/bindings/trivial-devices.yaml  |  2 +
>>>
>>> Split bindings from driver code.
>> Sure
>>>
>>>>    drivers/hwmon/pmbus/Kconfig                   | 16 ++++
>>>>    drivers/hwmon/pmbus/Makefile                  |  1 +
>>>>    drivers/hwmon/pmbus/tda38640.c                | 78 +++++++++++++++++++
>>>>    4 files changed, 97 insertions(+)
>>>>    create mode 100644 drivers/hwmon/pmbus/tda38640.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> index f5c0a6283e61..a28b02036489 100644
>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>>>> @@ -141,6 +141,8 @@ properties:
>>>>              - infineon,slb9645tt
>>>>                # Infineon SLB9673 I2C TPM 2.0
>>>>              - infineon,slb9673
>>>> +            # Infineon TDA38640 Voltage Regulator
>>>> +          - infineon,tda38640
>>>>                # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
>>>>              - infineon,tlv493d-a1b6
>>>>                # Infineon Multi-phase Digital VR Controller xdpe11280
>>>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>>> index 30448e049486..9f4bbb9c487a 100644
>>>> --- a/drivers/hwmon/pmbus/Kconfig
>>>> +++ b/drivers/hwmon/pmbus/Kconfig
>>>> @@ -395,6 +395,22 @@ config SENSORS_STPDDC60
>>>>    	  This driver can also be built as a module. If so, the module will
>>>>    	  be called stpddc60.
>>>>    
>>>> +config SENSORS_TDA38640
>>>> +	tristate "Infineon TDA38640"
>>>> +	help
>>>> +	  If you say yes here you get hardware monitoring support for Infineon
>>>> +	  TDA38640.
>>>> +
>>>> +	  This driver can also be built as a module. If so, the module will
>>>> +	  be called tda38640.
>>>> +
>>>> +config SENSORS_TDA38640_REGULATOR
>>>> +	bool "Regulator support for TDA38640 and compatibles"
>>>> +	depends on SENSORS_TDA38640 && REGULATOR
>>>> +	help
>>>> +	  If you say yes here you get regulator support for Infineon
>>>> +	  TDA38640 as regulator.
>>>
>>> Drop entire option, why is it needed?
>> You mean regulator option ?
>> This is how other pmbus regulator devices have provided option.
> 
> Hmmm... I wonder why this is of any use.
 From what I can think of. Chip also provide pin to control regulator 
enable. If that is used in the design then the regulator option may not 
be needed.
> 
>>>
>>>> +
>>>>    config SENSORS_TPS40422
>>>>    	tristate "TI TPS40422"
>>>>    	help
> 
> (...)
Yes this doesn't has regulator support in driver.
> 
>>>
>>>> +static const struct of_device_id tda38640_of_match[] = {
>>>> +	{ .compatible = "infineon,tda38640"},
>>>> +	{ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, tda38640_of_match);
>>>
>>> Where is it used? You miss the user.
>> I'm not sure if I get your question right.
>> This chip is used in sbp1 board to power CPU rails.
> 
> No, where is the data structure used (except module autoloading)?
My use case is loading the driver base on DT. Not sure of other uses.
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Naresh
