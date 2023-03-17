Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118F96BE8B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCQL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQL5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:57:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9CBCBBD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:57:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p16so3156513wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679054250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgvWbwsyEB+gGG8DJc2B/pZSZJeuWMK+G3i6ZsnIT1k=;
        b=pxUX4MkdHQrAtuiOU3oXvUpzKVpIKtpaMMepwzt+mpVsB7GCPRsfv47EH36hQItV/e
         zxXZEtzjMErI5HFo+2ONrE+ieAKTzu6r0jczVNF8EGi8pa0De1tvzjUD58ctdtF0lDSs
         49JEnyexq4t0pL1bKHB9BjlMp9XKjEBv7+UBzhksVxxJh7Ty87ji28arijtidYnSmh/2
         qNwct20R8zF/DNDBoFgRJjzGk4tmol1E1RN9T9gerJPfd13UYLRqTNCoXUSPU9D8TTgD
         7dMLfNIMQiz1cshss/dOWca4cdfiJk9/srojK3ZpF6Xm6WW1GIIg8rZfrQXlD1lORDSI
         GF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679054250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgvWbwsyEB+gGG8DJc2B/pZSZJeuWMK+G3i6ZsnIT1k=;
        b=sIVbeCwsVZzbFtgE2VFT2oK3SkxgbRr7SPsfeBFDbT94i5H0slIFseS0I0gH3VRKUM
         k/nWu2u+2wxFnfghSwKwOsnxM+Pspz6bf0Gm9BKWEqMK+devVgw+dXWaUDzvcvuheGuV
         QAbRrqh31Wv91blFcOdzGedcmPHTs4mzKQeix2uv8yVVn1oGWUiwA+XEJ4fFLIGaH8fe
         DRdLa7dKApDn1OF1i3grEez8/hcnDbPcxpHfJKsohqdieMIJFCm56Jgc4zgt4yECH8jQ
         6KTGOADIBnKEOJ4nZYDjG6K7i31L6zqz/OkrA2ML7Sx0Q/Hy1maF/k5wb8PYCYNRpw0x
         rC9g==
X-Gm-Message-State: AO0yUKVAGV0sK8c620hTZEJbF9pfHBPD3CmAIj+5qXaDDZhJETkXV8ub
        1dtwdcJDoaliJmRu/9ZeknkCHw==
X-Google-Smtp-Source: AK7set8GSaMaBFVqOeBLDlwhD3HnE+PH9ZmLeqoREQYjdYbOiuC3GMqSxbZGn33oQJQV0LXhpudmNQ==
X-Received: by 2002:a05:600c:198e:b0:3eb:2f3b:4477 with SMTP id t14-20020a05600c198e00b003eb2f3b4477mr23903615wmq.28.1679054249817;
        Fri, 17 Mar 2023 04:57:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1dfd:dcd7:94d3:86b3? ([2a05:6e02:1041:c10:1dfd:dcd7:94d3:86b3])
        by smtp.googlemail.com with ESMTPSA id n13-20020a05600c3b8d00b003e8dcc67bdesm8058955wms.30.2023.03.17.04.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 04:57:29 -0700 (PDT)
Message-ID: <59fc344b-4d1a-e0b2-92b5-2341b014ae11@linaro.org>
Date:   Fri, 17 Mar 2023 12:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS
 thermal controllers for mt8195
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, bchihi@baylibre.com,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230307154524.118541-1-bchihi@baylibre.com>
 <20230307154524.118541-2-bchihi@baylibre.com>
 <CAGXv+5FUrWEF4SZ6DKjoF8Oai--JGFffzQ3_DyzQrUrThVEQ7Q@mail.gmail.com>
 <e5959cb5-af8c-9410-9530-b3e19e9b647a@linaro.org>
 <20230316223543.GA4008428-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230316223543.GA4008428-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

On 16/03/2023 23:35, Rob Herring wrote:
> On Thu, Mar 09, 2023 at 11:39:13AM +0100, Daniel Lezcano wrote:
>> On 09/03/2023 05:40, Chen-Yu Tsai wrote:
>>> On Wed, Mar 8, 2023 at 12:46 AM <bchihi@baylibre.com> wrote:
>>>>
>>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>>
>>>> Add AP Domain to LVTS thermal controllers dt-binding definition for mt8195.
>>>>
>>>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>>>> ---
>>>>    include/dt-bindings/thermal/mediatek,lvts-thermal.h | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>>>> index c09398920468..8fa5a46675c4 100644
>>>> --- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>>>> +++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
>>>> @@ -16,4 +16,14 @@
>>>>    #define MT8195_MCU_LITTLE_CPU2  6
>>>>    #define MT8195_MCU_LITTLE_CPU3  7
>>>>
>>>> +#define MT8195_AP_VPU0  8
>>>
>>> Can't this start from 0? This is a different hardware block. The index
>>> namespace is separate. Same question for MT8192.
>>
>> The ID is used to differentiate the thermal zone identifier in the device
>> tree from the driver.
>>
>> +		vpu0-thermal {
>> +			polling-delay = <0>;
>> +			polling-delay-passive = <0>;
>> +			thermal-sensors = <&lvts_ap MT8195_AP_VPU0>;
>> +
>> +			trips {
>> +				vpu0_crit: trip-crit {
>> +					temperature = <100000>;
>> +					hysteresis = <2000>;
>> +					type = "critical";
>> +				};
>> +			};
>> +		};
>>
>> If MT8195_AP_VPU0 is 0, then the code won't be able to differentiate
>> MT8195_AP_VPU0 and MT8195_MCU_BIG_CPU0
>>
>> The LVTS driver will call devm_thermal_of_zone_register() with the sensor
>> id. If MT8195_MCU_BIG_CPU0 and MT8195_AP_VPU0 have the same id, then at the
>> moment of registering the MT8195_AP_VPU0, the underlying OF thermal
>> framework code will use MT8195_MCU_BIG_CPU0 description instead because it
>> will be the first to be find in the DT.
>>
>> If MT8195_AP_VPU0 is described in DT before, then the same will happen when
>> registering MT8195_MCU_BIG_CPU0, MT8195_AP_VPU0 will be registered instead.
>>
>> IOW all ids must be different.
> 
> That's broken for how producer/consumer phandle+args bindings work.

Do you mean this is broken for thermal zone description in the DT in 
general ?

What would be the correct approach ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

