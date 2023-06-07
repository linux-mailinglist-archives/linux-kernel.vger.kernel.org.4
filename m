Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEADB7257A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbjFGI3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbjFGI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:29:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE4E60
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:29:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso69402135e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686126541; x=1688718541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JX1WfNJ60BsXwbkPoGDQCsTAjpWhBPAf/CRfk+6wEPQ=;
        b=lvAAUMvrMu07Tc2ZuENDkCq0JyGqf6J81FOfMfcTcn7YYsp0OO6jh38TaMJCbaPuvg
         NlKCUiUFowZCkeFVjFy6vVcGeYSgzny4OB7V1UJ5yr2xH1oTO0hfLliS1oaqFncsU3Kk
         IX/UJWwvF5fMU2/Qg8rtds8DJpEJe+Hmr0u3Wrj2WrHpSy6gFyBYOBd1GevuCwq7LSM5
         0rP7ukPRHSpldOicMCMdzO34vJEFsdw4c+gO4uE507rgaSWpKZXWsPakbSNIg+2qohDe
         EKu+zIgULVzD8jfJARYdL0HvxpfPUL4VdwzRMy8ATx+cNzx+ZJWeCMXtsx4BDH7GkpGi
         sDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126541; x=1688718541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JX1WfNJ60BsXwbkPoGDQCsTAjpWhBPAf/CRfk+6wEPQ=;
        b=iwqBn6ILmqaKHHiOSbQGar0OzgR8Ui6FP+t+K6EU7NGbr+4Jon4Q6952qhj2m5CGVr
         WQ9UtOy6CbLZAOum2mtVNbe7z8hvBNljph2JIpIgC460Ox9qNj17rUWoZysiHvQn2r4G
         2lyIQizlH6DBt6A6YTZWgPJInXJC1hcGHcEjpNaVWRYOlfx2Z9eAPRwysTNRUncQvwpp
         rifoTvcChjDAYSKCC2p93Q7Nj0kqiAs4BhnEx3Rt9VIgHwhUAZvoJHPQTpDHXb3M/eGw
         OEW7iKyDiCFv3b02nFKo4/yFNQ8PPUFimmEUVeFRqz9ZJNkzNXw8qXhrair9CA3cHURI
         JrzA==
X-Gm-Message-State: AC+VfDyX1PH4nGGgK39zTGEvnQ0KDiiYsojeqWuuo2g0P8hHZq7Z7yw4
        U40HJSVmyZx7O1CNTzYnrFUkzQ==
X-Google-Smtp-Source: ACHHUZ740NDR4ReBgqQ+C8X3Doc2SIZebw1Wapr2hkx9MuGk4ICNYhpwJOuMd7HVgJ6D4jDxX3lNMw==
X-Received: by 2002:a05:600c:254:b0:3f7:e7a5:5bc5 with SMTP id 20-20020a05600c025400b003f7e7a55bc5mr3780415wmj.24.1686126541370;
        Wed, 07 Jun 2023 01:29:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id g9-20020a7bc4c9000000b003f6129d2e30sm1374174wmk.1.2023.06.07.01.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:29:00 -0700 (PDT)
Message-ID: <3120c2d5-4473-5b72-29bf-d841e806878f@linaro.org>
Date:   Wed, 7 Jun 2023 10:28:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Peng Fan <peng.fan@nxp.com>,
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
 <DU0PR04MB9417D574603B54AEF76480AE88499@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <0eb717ac-82b1-8a76-58a2-394167e69b28@linaro.org>
 <21914890.EfDdHjke4D@pliszka>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <21914890.EfDdHjke4D@pliszka>
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

On 07/06/2023 08:01, Sebastian Krzyszkowiak wrote:
> On piątek, 2 czerwca 2023 15:11:37 CEST Daniel Lezcano wrote:
>> On 01/06/2023 11:52, Peng Fan wrote:
>>> Hi Daniel,
>>>
>>>> Subject: RE: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
>>>> sensors
>>>>
>>>>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
>>>>> sensors
>>>>>
>>>>> On 31/05/2023 14:05, Peng Fan wrote:
>>>>>>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable
>>>>>>> supported sensors
>>>>>>>
>>>>>>> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
>>>>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>>>>
>>>>>>>> There are MAX 16 sensors, but not all of them supported. Such as
>>>>>>>> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
>>>>>>>> touch reserved bits from i.MX8MQ reference mannual, and TMU will
>>>>>>>> stuck, temperature will not update anymore.
>>>>>>>>
>>>>>>>> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
>>>>>>>> registering them")
>>>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>      drivers/thermal/qoriq_thermal.c | 30
>>>>>>>>      +++++++++++++++++++----------
>>>>
>>>> -
>>>>
>>>>>>>>      1 file changed, 19 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>>>>>>> b/drivers/thermal/qoriq_thermal.c index
>>>>
>>>> b806a0929459..53748c4a5be1
>>>>
>>>>>>>> 100644
>>>>>>>> --- a/drivers/thermal/qoriq_thermal.c
>>>>>>>> +++ b/drivers/thermal/qoriq_thermal.c
>>>>>>>> @@ -31,7 +31,6 @@
>>>>>>>>
>>>>>>>>      #define TMR_DISABLE	0x0
>>>>>>>>      #define TMR_ME		0x80000000
>>>>>>>>      #define TMR_ALPF	0x0c000000
>>>>>>>>
>>>>>>>> -#define TMR_MSITE_ALL	GENMASK(15, 0)
>>>>>>>>
>>>>>>>>      #define REGS_TMTMIR	0x008	/* Temperature measurement
>>>>>>>
>>>>>>> interval Register */
>>>>>>>
>>>>>>>>      #define TMTMIR_DEFAULT	0x0000000f
>>>>>>>>
>>>>>>>> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
>>>>>>>
>>>>>>> thermal_zone_device *tz, int *temp)
>>>>>>>
>>>>>>>>      	 * within sensor range. TEMP is an 9 bit value representing
>>>>>>>>      	 * temperature in KelVin.
>>>>>>>>      	 */
>>>>>>>>
>>>>>>>> +
>>>>>>>> +	regmap_read(qdata->regmap, REGS_TMR, &val);
>>>>>>>> +	if (!(val & TMR_ME))
>>>>>>>> +		return -EAGAIN;
>>>>>>>
>>>>>>> How is this change related to what is described in the changelog?
>>>>>>
>>>>>> devm_thermal_zone_of_sensor_register will invoke get temp, since we
>>>>>> reverted the 45038e03d633 did, we need to check TMR_ME to avoid
>>>>>
>>>>> return
>>>>>
>>>>>> invalid temperature.
>>>>>>
>>>>>    From a higher perspective if the sensor won't be enabled, then the
>>>>>
>>>>> thermal zone should not be registered, the get_temp won't happen on a
>>>>> disabled sensor and this test won't be necessary, no ?
>>>
>>> After thinking more, I'd prefer current logic.
>>>
>>> We rely on devm_thermal_of_zone_register's return value to know
>>> whether there is a valid zone, then set sites bit, and after collected
>>> all site bits, we enable the thermal IP.
>>>
>>> If move the enabling thermal IP before devm_thermal_of_zone_register,
>>> We need check dtb thermal zone, to know which zone is valid for current
>>> thermal IP. This would complicate the design.
>>>
>>> So just checking the enabling bit in get temperature would be much
>>> simpler, and there just a small window before enabling thermal IP.
>>
>> If the thermal zone is not described, then the thermal zone won't be
>> created as it fails with -ENODEV and thus get_temp won't be called on a
>> disabled site, right?
> 
> That's not what the problem is. It's about zones that *will* be created -
> since the driver only knows that a thermal zone isn't described in the device
> tree after it fails registering, it can't enable the site *before* the zone
> gets registered - so it happens afterwards. That's why it needs this check to
> not return a bogus initial value before the site gets actually enabled later
> in qoriq_tmu_register_tmu_zone.

Sorry, I get the point but I don't see how that can happen:

qoriq_tmu_register_tmu_zone() calls devm_thermal_of_zone_register() for 
*all* sites regardless if they really exists or not.

Under the hood, the function devm_thermal_of_zone_register() calls 
thermal_of_zone_register(). This one fails when calling 
of_thermal_zone_find() because it does not exist and returns -ENODEV.

Hence, the thermal_zone_device_register_with_trips() is not called, the 
thermal zone is not created neither updated.

So I don't understand why the test:

+	regmap_read(qdata->regmap, REGS_TMR, &val);
+	if (!(val & TMR_ME))
+		return -EAGAIN;

is needed in the get_temp() ops as the thermal zone for this disabled 
site should not exist.

I'm not putting in question the series, just wanting to avoid a 
potential pointless check in an ops.


[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

