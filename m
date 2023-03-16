Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63956BCBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCPKFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCPKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:05:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA16A0B3B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:05:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so679083wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678961127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgYCZHGkMxWxLNxSIypAzujsXqtz2VniUuNUBnk+gis=;
        b=VSiX4ak9m2Fbpeodc2znc0DO1Ptd/zIBs8O7Y8ughyQyMMYMUIXgqe1dCOAFuRvVwc
         tWcGRawnoOh+glRb8/e5G2dCJYbzJQIhTEHtu1DqCrAknzoNLoIdH2rm8rIajeqxnlo6
         w1HaoqmMwKg8RkgvbcJjaKu4ocB8AIYT4FQ7MPciNJd3fr1a6oqXK1j/6Z4B74gj97iY
         jxMMlzv+zvU2XLgi2ZO2ok+GmZjqHraissXWmUjI7hRXKw+E5XqJu2Kq+NfD26pb32Ml
         BPVzN5lRw5/lvK3he1qB4E2E6ut7p+wNH9MRoyVXbe3hYObOauKxNU80Kzs19zE8GT8z
         G6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678961127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgYCZHGkMxWxLNxSIypAzujsXqtz2VniUuNUBnk+gis=;
        b=U2eKeh2JKwWoNdInF1iIrYH4KHorKVITe66TsfZvYcrVz41bv3GdJS3wjG4pJXpS6F
         t0NEb5VABVovWxY0sU2MoS5LC+RKZLWUkbh5+fsM9pffxDk2wqfhy0I/i3wni+shk4w0
         g2X0I5+ir5UyzY0MMV8ynLWmeRSfrAvv/OzyHN5QnUIML6hunTM1lla/jFh7ZdVFXs6r
         V0VT3hmvHfXjpSdm21rjttBlAtv+7j/n55+nNPSuLzFD3gGcrAEHY0tIVpPl/Yxi6zZl
         hPia5ZFMban4b8aXnIEhxdKLrwqCsFNHYAKBvV/+Xwv9kNccV6DvZaAfUZoiLkQsJyXJ
         c9Sg==
X-Gm-Message-State: AO0yUKWcVF2Py8e05c4lEER2EMec1A5wcH/ILDbJqYePzWU8KBwhTUCA
        UR8M3u7l8ulx4WF1Ll8OQoXt4A==
X-Google-Smtp-Source: AK7set+ZBAEGyPlBeMSevhv7QLiyPYaj5v7LU+lQDc2C6qWm+uykJB1zOxqDuqALnVB1LKmFbDZYXA==
X-Received: by 2002:a05:600c:4691:b0:3ed:33a1:ba8e with SMTP id p17-20020a05600c469100b003ed33a1ba8emr4766778wmo.1.1678961126625;
        Thu, 16 Mar 2023 03:05:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cd3c:7f23:e93c:fbb4? ([2a05:6e02:1041:c10:cd3c:7f23:e93c:fbb4])
        by smtp.googlemail.com with ESMTPSA id e4-20020a05600c4e4400b003e8f0334db8sm4601879wmq.5.2023.03.16.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 03:05:26 -0700 (PDT)
Message-ID: <bae80282-cb80-462d-e554-1934d090e216@linaro.org>
Date:   Thu, 16 Mar 2023 11:05:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND] [PATCHv3 4/7] thermal: rockchip: Simplify channel id
 logic
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
 <20230308112253.15659-5-sebastian.reichel@collabora.com>
 <6c13708d-d51a-73b8-bf01-d6893eae2af4@linaro.org>
 <ec66d4e7-cb82-46c6-84ae-bd51df7cab7c@mercury.local>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ec66d4e7-cb82-46c6-84ae-bd51df7cab7c@mercury.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Heiko,

On 08/03/2023 19:42, Sebastian Reichel wrote:
> Hi Daniel,
> 
> On Wed, Mar 08, 2023 at 07:13:22PM +0100, Daniel Lezcano wrote:
>> On 08/03/2023 12:22, Sebastian Reichel wrote:
>>> Replace the channel ID lookup table by a simple offset, since
>>> the channel IDs are consecutive.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>
>> As all the other patches are reviewed by Heiko, is the tag missing here?
> 
> Heiko was not happy with this in PATCHv2, when he reviewed most
> of the patches:
> 
> https://lore.kernel.org/all/3601039.e9J7NaK4W3@phil/
> 
> I replied, but never got a response, so I kept it as is:
> 
> https://lore.kernel.org/all/20221206170232.xsm4kcbfwrmlrriw@mercury.elektranox.org/
> 
> FWIW it is essential for the series and cannot be dropped, because
> RK3588 has more than 2 channels.

Do you have a suggestion to improve the proposed change ?

Thanks
    -- Daniel


>>> ---
>>>    drivers/thermal/rockchip_thermal.c | 48 +++++++++++++-----------------
>>>    1 file changed, 21 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
>>> index 9ed45b318344..bcbdd618daae 100644
>>> --- a/drivers/thermal/rockchip_thermal.c
>>> +++ b/drivers/thermal/rockchip_thermal.c
>>> @@ -39,15 +39,6 @@ enum tshut_polarity {
>>>    	TSHUT_HIGH_ACTIVE,
>>>    };
>>> -/*
>>> - * The system has two Temperature Sensors.
>>> - * sensor0 is for CPU, and sensor1 is for GPU.
>>> - */
>>> -enum sensor_id {
>>> -	SENSOR_CPU = 0,
>>> -	SENSOR_GPU,
>>> -};
>>> -
>>>    /*
>>>     * The conversion table has the adc value and temperature.
>>>     * ADC_DECREMENT: the adc value is of diminishing.(e.g. rk3288_code_table)
>>> @@ -82,7 +73,7 @@ struct chip_tsadc_table {
>>>    /**
>>>     * struct rockchip_tsadc_chip - hold the private data of tsadc chip
>>> - * @chn_id: array of sensor ids of chip corresponding to the channel
>>> + * @chn_offset: the channel offset of the first channel
>>>     * @chn_num: the channel number of tsadc chip
>>>     * @tshut_temp: the hardware-controlled shutdown temperature value
>>>     * @tshut_mode: the hardware-controlled shutdown mode (0:CRU 1:GPIO)
>>> @@ -98,7 +89,7 @@ struct chip_tsadc_table {
>>>     */
>>>    struct rockchip_tsadc_chip {
>>>    	/* The sensor id of chip correspond to the ADC channel */
>>> -	int chn_id[SOC_MAX_SENSORS];
>>> +	int chn_offset;
>>>    	int chn_num;
>>>    	/* The hardware-controlled tshut property */
>>> @@ -925,8 +916,8 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
>>>    }
>>>    static const struct rockchip_tsadc_chip px30_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>> +	/* cpu, gpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 2, /* 2 channels for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
>>> @@ -949,7 +940,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> +	/* cpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 1, /* one channel for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>>> @@ -973,7 +965,8 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> +	/* cpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 1, /* one channel for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>>> @@ -997,8 +990,8 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 1, /* cpu sensor is channel 1 */
>>> -	.chn_id[SENSOR_GPU] = 2, /* gpu sensor is channel 2 */
>>> +	/* cpu, gpu */
>>> +	.chn_offset = 1,
>>>    	.chn_num = 2, /* two channels for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>>> @@ -1022,7 +1015,8 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> +	/* cpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 1, /* one channels for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
>>> @@ -1045,8 +1039,8 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>> +	/* cpu, gpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 2, /* two channels for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>>> @@ -1070,8 +1064,8 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>> +	/* cpu, gpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 2, /* two channels for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>>> @@ -1095,8 +1089,8 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>> +	/* cpu, gpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 2, /* two channels for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>>> @@ -1120,8 +1114,8 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>>>    };
>>>    static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
>>> -	.chn_id[SENSOR_CPU] = 0, /* cpu sensor is channel 0 */
>>> -	.chn_id[SENSOR_GPU] = 1, /* gpu sensor is channel 1 */
>>> +	/* cpu, gpu */
>>> +	.chn_offset = 0,
>>>    	.chn_num = 2, /* two channels for tsadc */
>>>    	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>>> @@ -1404,7 +1398,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>>>    	for (i = 0; i < thermal->chip->chn_num; i++) {
>>>    		error = rockchip_thermal_register_sensor(pdev, thermal,
>>>    						&thermal->sensors[i],
>>> -						thermal->chip->chn_id[i]);
>>> +						thermal->chip->chn_offset + i);
>>>    		if (error)
>>>    			return dev_err_probe(&pdev->dev, error,
>>>    				"failed to register sensor[%d].\n", i);
>>
>> -- 
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

