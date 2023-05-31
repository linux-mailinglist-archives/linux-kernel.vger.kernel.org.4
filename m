Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC61717FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjEaMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjEaMfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:35:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F77123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:35:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f61530506aso60228025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685536508; x=1688128508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/p7ECP6vbOUSRpDQ4zGbI0opvEIKsa5wfjANKgfREI=;
        b=c6Nv9dZX4P6RZw491nYo5S8MFkFF6PZ8XS6B2MdLMYDgbDpYXn37Sg7NMhddYI099J
         /sJagQS+Tm3aSCGZgETp2AaWJpBvPdM/UVEJD5SIzU6Ge4kjmLq2MeiiGxwn0QesILOE
         oO5NrzIYaMjECx+Tdd+WjWUAfeXqR7LNkyokWSakdShpUNgcHIPlqda96PrtoNrHsupa
         8M8nYEncrcCnHLgTi0JhKjnaWq9xXXO222tdi29ibwHNBAoTP4YUiPKJEMbrLxvkCsi+
         dmd/Xf7Kpwq1d2JwgXTQ6vHR2/03IpDg4zjQPTFxSC/+hezTj31WAWeZDoe8Q40s9+Hk
         /QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685536508; x=1688128508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/p7ECP6vbOUSRpDQ4zGbI0opvEIKsa5wfjANKgfREI=;
        b=MAVFyp4v4krRbnbp3o/F3y5u2gkgAR/LS8G+mmw6iQToNrhSJ0OL8BL8gB5FY7rYXX
         HwDVdq7ZzCejnV5ydXNlRALrOieaT3nlc1vl64YL5CZOK76K4sujOPNwS9/S0DVmqdIF
         RD5BF5Cn2H5uAxdg2+SvbzMppNFOPs/zHC3anqK7ygG9naVKG9tRausSWvnxo0Txa/tF
         cX17F02LtOQsOfFtIqjK5s47/na6i7rGHDHor29CFCC7BnLKiyf5eVl7DBtirnFQ//oW
         f+aecxx54p6+G6WKeTN16oDcnCnOq3kPBg87/rUkZagliR/g2G/9pYq+Qs8Nc/67Yzrw
         yn+Q==
X-Gm-Message-State: AC+VfDyvIz+GgQ7vB1EgwtN04JiJGWTSPhDxvxfnGxIcRTfnlxfMNPZA
        fUnD+gm8CFhzwPi4Ij/RvKb2LA==
X-Google-Smtp-Source: ACHHUZ4Y/hsGX+eAM7uTya8Hltas36c2LDSH9jAHp6Wh9Vog4GauPL7E0LTHt1HW4XYoYm9XOgq9WQ==
X-Received: by 2002:a05:600c:210e:b0:3f6:906:b659 with SMTP id u14-20020a05600c210e00b003f60906b659mr4174220wml.33.1685536508111;
        Wed, 31 May 2023 05:35:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7a1b:d710:7226:da18? ([2a05:6e02:1041:c10:7a1b:d710:7226:da18])
        by smtp.googlemail.com with ESMTPSA id o5-20020a1c7505000000b003f6f6a6e769sm14324599wmc.17.2023.05.31.05.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 05:35:07 -0700 (PDT)
Message-ID: <01197bb8-da0d-f726-79bc-d8ab7d3ea992@linaro.org>
Date:   Wed, 31 May 2023 14:35:06 +0200
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <PA4PR04MB94165217C8C0D9E8E0087AF988489@PA4PR04MB9416.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 14:05, Peng Fan wrote:
>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
>> sensors
>>
>> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> There are MAX 16 sensors, but not all of them supported. Such as
>>> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will touch
>>> reserved bits from i.MX8MQ reference mannual, and TMU will stuck,
>>> temperature will not update anymore.
>>>
>>> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
>>> registering them")
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>    drivers/thermal/qoriq_thermal.c | 30 +++++++++++++++++++-----------
>>>    1 file changed, 19 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>> b/drivers/thermal/qoriq_thermal.c index b806a0929459..53748c4a5be1
>>> 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -31,7 +31,6 @@
>>>    #define TMR_DISABLE	0x0
>>>    #define TMR_ME		0x80000000
>>>    #define TMR_ALPF	0x0c000000
>>> -#define TMR_MSITE_ALL	GENMASK(15, 0)
>>>
>>>    #define REGS_TMTMIR	0x008	/* Temperature measurement
>> interval Register */
>>>    #define TMTMIR_DEFAULT	0x0000000f
>>> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
>> thermal_zone_device *tz, int *temp)
>>>    	 * within sensor range. TEMP is an 9 bit value representing
>>>    	 * temperature in KelVin.
>>>    	 */
>>> +
>>> +	regmap_read(qdata->regmap, REGS_TMR, &val);
>>> +	if (!(val & TMR_ME))
>>> +		return -EAGAIN;
>>
>> How is this change related to what is described in the changelog?
> 
> devm_thermal_zone_of_sensor_register will invoke get temp,
> since we reverted the 45038e03d633 did, we need to check TMR_ME
> to avoid return invalid temperature.


 From a higher perspective if the sensor won't be enabled, then the 
thermal zone should not be registered, the get_temp won't happen on a 
disabled sensor and this test won't be necessary, no ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

