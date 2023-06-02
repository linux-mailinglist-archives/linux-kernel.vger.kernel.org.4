Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3371E7202CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjFBNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbjFBNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:12:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51AE5B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:11:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f60bc818d7so2005787e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711499; x=1688303499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdOza1gLCalLSXkYNY4mfvWYzR4Q4eTY/qnCdvd8TFI=;
        b=OQG6NkGTY8w1iNprv3qIaPBF7ojyVzw2L0LdKDBQuojwW4n/Gwj2GkpkFfrtl4V2gI
         2xrnUG/TogFtedY6rDXNS9MtJyr9C4KFoLSZayqrqdEBTj0RfS7YeAeJoCCQsmW8cjvs
         sdMhxEWwbQS0bFCJS/YJCKpxNoQdOEJpHnxSRuzLH2mw4e8rUaP775d897/oBebWdnN9
         Ads0I/oo/n2vkWTkKmowPFMhpxThhbO5bXQIZZVINcEGx8MQX8qbaz9MGEUjpqhsdOE+
         tJrzXcx+lLit2xsTI9zZ/hUIMESUEPdWE29IcxYRFqHYh6NpZlTpRY8wRhcxGzuRfQst
         OYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711499; x=1688303499;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdOza1gLCalLSXkYNY4mfvWYzR4Q4eTY/qnCdvd8TFI=;
        b=bwCxCL1MZIsXvwWhPFsyyTkHLlWetU061X4JU+aRodBt4zKDfDkfGcJoWCLorC4caA
         EXM4hQjCedhl0KV7zlJCAky9fH6nWId72ZFB5tcQNPi8gZ4Dm/W31DPbXs2vNpJqoF/n
         ZzPUw7/eTCRklYhSLQvPqlmWkkfEZYRL8PnYOb5+/IebxAqaqKEN0ID2Wt2QCyk8AY9F
         5IEa2RP3/m2V7TbpqMG7wELnWRevpQJpwuKOiKQPEKL28jsPVq8wRdHmxgg+NZUpXVoC
         UBfikoyKISGpqNGLjoy3uC0dvS1cyrhnQkgolsOPcnakUDL5NjUMhb2x74/aZ/tmPwld
         9hLw==
X-Gm-Message-State: AC+VfDxJJ98aS6DtJzUmkiGMPmxDjl6OgMa/kUpTFK3ZJocB+pQe8Vqb
        /idt9HdxC8zM/BzxrRa8WAVBhA==
X-Google-Smtp-Source: ACHHUZ6pzMnLSLO1Ama3yhQyeYIg1fA+OJjI4CJNmdzdAHVyE5wYPdc1sGelcxVvpPlfy2h5ZJCI+w==
X-Received: by 2002:a19:7014:0:b0:4f3:982a:8be1 with SMTP id h20-20020a197014000000b004f3982a8be1mr1894490lfc.69.1685711498965;
        Fri, 02 Jun 2023 06:11:38 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:40f6:d082:aa42:96f0? ([2a05:6e02:1041:c10:40f6:d082:aa42:96f0])
        by smtp.googlemail.com with ESMTPSA id 24-20020a05600c22d800b003f3e50eb606sm1931739wmg.13.2023.06.02.06.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:11:38 -0700 (PDT)
Message-ID: <0eb717ac-82b1-8a76-58a2-394167e69b28@linaro.org>
Date:   Fri, 2 Jun 2023 15:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <20230516083746.63436-3-peng.fan@oss.nxp.com>
 <3c59c4e0-68eb-b778-6b12-9f9e331f81dd@linaro.org>
 <PA4PR04MB94165217C8C0D9E8E0087AF988489@PA4PR04MB9416.eurprd04.prod.outlook.com>
 <01197bb8-da0d-f726-79bc-d8ab7d3ea992@linaro.org>
 <DU0PR04MB9417D9020578083527FC16C888489@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <DU0PR04MB9417D574603B54AEF76480AE88499@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <DU0PR04MB9417D574603B54AEF76480AE88499@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 11:52, Peng Fan wrote:
> Hi Daniel,
> 
>> Subject: RE: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
>> sensors
>>
>>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
>>> sensors
>>>
>>> On 31/05/2023 14:05, Peng Fan wrote:
>>>>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable
>>>>> supported sensors
>>>>>
>>>>> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>
>>>>>> There are MAX 16 sensors, but not all of them supported. Such as
>>>>>> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
>>>>>> touch reserved bits from i.MX8MQ reference mannual, and TMU will
>>>>>> stuck, temperature will not update anymore.
>>>>>>
>>>>>> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
>>>>>> registering them")
>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>>> ---
>>>>>>     drivers/thermal/qoriq_thermal.c | 30 +++++++++++++++++++----------
>> -
>>>>>>     1 file changed, 19 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>>>>> b/drivers/thermal/qoriq_thermal.c index
>> b806a0929459..53748c4a5be1
>>>>>> 100644
>>>>>> --- a/drivers/thermal/qoriq_thermal.c
>>>>>> +++ b/drivers/thermal/qoriq_thermal.c
>>>>>> @@ -31,7 +31,6 @@
>>>>>>     #define TMR_DISABLE	0x0
>>>>>>     #define TMR_ME		0x80000000
>>>>>>     #define TMR_ALPF	0x0c000000
>>>>>> -#define TMR_MSITE_ALL	GENMASK(15, 0)
>>>>>>
>>>>>>     #define REGS_TMTMIR	0x008	/* Temperature measurement
>>>>> interval Register */
>>>>>>     #define TMTMIR_DEFAULT	0x0000000f
>>>>>> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
>>>>> thermal_zone_device *tz, int *temp)
>>>>>>     	 * within sensor range. TEMP is an 9 bit value representing
>>>>>>     	 * temperature in KelVin.
>>>>>>     	 */
>>>>>> +
>>>>>> +	regmap_read(qdata->regmap, REGS_TMR, &val);
>>>>>> +	if (!(val & TMR_ME))
>>>>>> +		return -EAGAIN;
>>>>>
>>>>> How is this change related to what is described in the changelog?
>>>>
>>>> devm_thermal_zone_of_sensor_register will invoke get temp, since we
>>>> reverted the 45038e03d633 did, we need to check TMR_ME to avoid
>>> return
>>>> invalid temperature.
>>>
>>>
>>>   From a higher perspective if the sensor won't be enabled, then the
>>> thermal zone should not be registered, the get_temp won't happen on a
>>> disabled sensor and this test won't be necessary, no ?
> 
> After thinking more, I'd prefer current logic.
> 
> We rely on devm_thermal_of_zone_register's return value to know
> whether there is a valid zone, then set sites bit, and after collected
> all site bits, we enable the thermal IP.
> 
> If move the enabling thermal IP before devm_thermal_of_zone_register,
> We need check dtb thermal zone, to know which zone is valid for current
> thermal IP. This would complicate the design.
> 
> So just checking the enabling bit in get temperature would be much
> simpler, and there just a small window before enabling thermal IP.


If the thermal zone is not described, then the thermal zone won't be 
created as it fails with -ENODEV and thus get_temp won't be called on a 
disabled site, right?

Having test in the get_temp() ops is usually the sign there is something 
wrong with the driver initialization.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

