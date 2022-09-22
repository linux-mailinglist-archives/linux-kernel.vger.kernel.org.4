Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC45F5E5B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIVG0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIVG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:26:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E64B6D11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:26:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so13116360lfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=j9o4S3xAPFpmBmxWsJ5oAgRxe68Y0HDCIkMi/9Ynf0E=;
        b=KnhHr0NmUiWCiVlkPmJPCSvk/WwvJ/NRpVNv1DrdMycHjYqRCYm3BXiT9WBf1znGww
         5sw/niP3mcHaSFXVIRl5MFu/wFko0ETxyVO5jBqbZgoMePBChPhCDnxFHkM3oGzc7+Zr
         uRDRP9r4pGB6A3OPL7caTh9eD+Q1lYzffSZ+DU2zBo95rsi7rC9Vj/8GSjYf9BeXnQpZ
         gMyZAdlA1qxB2rOGBlYJFuumPOLptcKyXLzFpNMX0GLVSCkZo8P9Sq6FWJHjLDcj+Ogr
         xMMDg6bw8aSDO7ZMk+0zlw0sCYtw0rksxZChpvaZrGYj1WSC6m7V/ID8aZXyRcBx5k7N
         AJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=j9o4S3xAPFpmBmxWsJ5oAgRxe68Y0HDCIkMi/9Ynf0E=;
        b=M+9f1KqnwjHvOUb6DdLJBSOUXMKDfPmFWcQDSSswIfVrls2YoldQd0psdR4GAkbza5
         5/aOEWu5Dt3ZSoPP8e/5qqpoi5ODjpMOyZNiJ2pxl1ZMjREHmGVndmChG1Nkx9GO32Np
         esPs5k44lGJx3oKeGMxJSZT146P+4e3ce6iZkWoIa+JTuX03prMy0uwWxIN+Ur7ff27n
         w1sJjICG20DhZneioho5mCrOg+yhqy2QwoYNuQkMOInCoNScGhCsJsM0hO3JEexwzE+H
         yfobTHxSHGP/uAFEGXPye+5Bgoh5RzJ34hT1XgtH+mHy482y6Kr201Nt3tU0r8nh04h/
         qPiA==
X-Gm-Message-State: ACrzQf1EWnK8+kq3Mvkl+9HMjawDSAk0TRiXUvSeg6SQvZD6tGsYT5mc
        tRm75yBfqUJ4UjINRnEpFngSoA==
X-Google-Smtp-Source: AMsMyM7KiveS5KCOAc2WDOmn5Dl9stufRrBsuoO4rforSU4OhRZ+XqVxTff1BIdobYEfi8fFzuNKQA==
X-Received: by 2002:a05:6512:224b:b0:49f:9e09:584e with SMTP id i11-20020a056512224b00b0049f9e09584emr654473lfu.524.1663827961590;
        Wed, 21 Sep 2022 23:26:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b24-20020ac24118000000b00497a879e552sm763315lfi.291.2022.09.21.23.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:26:00 -0700 (PDT)
Message-ID: <0d2fce98-6744-69af-44a2-702f4927b626@linaro.org>
Date:   Thu, 22 Sep 2022 08:25:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
Content-Language: en-US
To:     =?UTF-8?B?5pyx6ZO25rOi?= <zhuyinbo@loongson.cn>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
 <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
 <28a78a10.a7dd.1835f5aaf90.Coremail.zhuyinbo@loongson.cn>
 <a44244f2-fb96-0483-b529-d0f2b0b7e5d8@linaro.org>
 <4febe7e4.a96c.18362d997e3.Coremail.zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4febe7e4.a96c.18362d997e3.Coremail.zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 03:39, 朱银波 wrote:
> 
> 
> 
>> -----原始邮件-----
>> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> 发送时间:2022-09-21 17:31:11 (星期三)
>> 收件人: "朱银波" <zhuyinbo@loongson.cn>
>> 抄送: "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zhanghongchen <zhanghongchen@loongson.cn>
>> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>
>> On 21/09/2022 11:22, 朱银波 wrote:
>>>> -----原始邮件-----
>>>> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>>>> 发送时间:2022-09-21 15:05:00 (星期三)
>>>> 收件人: "Yinbo Zhu" <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>>>> 抄送: zhanghongchen <zhanghongchen@loongson.cn>
>>>> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>>>
>>>> On 21/09/2022 03:56, Yinbo Zhu wrote:
>>>>> Convert the loongson2 thermal binding to DT schema format using
>>>>> json-schema.
>>>>
>>>> Incorrect subject and incorrect commit msg. There is no conversion here.
>>> Our soc architecture is the loongson2 series, so we will modify it accordingly.
>>
>> How the soc architecture is related to my comment that you do not
>> perform conversion?
> I got it, and I will aad a conversion.
>>
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Yinbo Zhu <c>
>>>>> ---
>>>>> Change in v2:
>>>>> 		1. Add description and type about the "id".	
>>>>> 		2. Make the filename was based on compatible.
>>>>>
>>>>>  .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
>>>>>  1 file changed, 52 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..2994ae3a56aa
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>
>>>>
>>>> No improvements here. You ignore my comments, so I am going to NAK it.
>>> I don't get your point, that dts compatible is "loongson,loongson2-thermal", so this driver file name is named
>>> loongson2-thermal that according what you said about "Filename based on compatible."
>>> If what I understand is not what you expect, please tell me how to modify it.
>>
>>
>> Filename must match the compatible, so: loongson,loongson2-thermal.yaml
> I got it, and I will add a conversion.
>>
>>>>
>>>>
>>>>> @@ -0,0 +1,52 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/thermal/loongson2-thermal.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Thermal sensors on loongson2 SoCs
>>>>> +
>>>>> +maintainers:
>>>>> +  - zhanghongchen <zhanghongchen@loongson.cn>
>>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: loongson,loongson2-thermal
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  id:
>>>>> +    $ref: '//schemas/types.yaml#/definitions/uint32'
>>>>
>>>> No improvements here, so let me be specific - you need to really justify
>>>> such property or it cannot go to schema.
>>> The loongson2_thermal.c driver need parse this "id" property.
>>
>> This is not reason to add properties to DT. DT describes the hardware,
>> not driver behavior.
>>
>> Why hardware needs arbitrary, additional addressing number instead of
>> standard unit address?
> The loongson2 series soc supports up to four sensors, but the 2K1000 has only one sensor, so the ID must be 0. 
> For the 2K1000, in order to distinguish the differences between different hardware in the Loongson2 SoC series,
> the ID is added to the dts

That's not an explanation at all. All other SoCs have multiple sensors
and we do not have such "id" fields.

>>
>>>>
>>>>> +    description: |
>>>>> +      Specify the thermal sensor id.
>>>>> +    minimum: 0
>>>>> +    maximum: 3
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  "#thermal-sensor-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +required:
>>>>> +  - compatible
>>>>> +  - reg
>>>>> +  - id
>>>>> +  - interrupt-parent
>>>>
>>>> Why?
>>> The interrupts of our dts do not specify an interrupt parent,
>>> eg. interrupts = <7 IRQ_TYPE_LEVEL_LOW>
>>> so we need to add an interrupt parent property.
>>
>> You can add but I am asking why is it required?
> Since there is more than one interrupt controller in the Loongson2 series soc, that need to specify the interrupt 
> controller in the dts, that is, the interrupt parent.   If different interrupt parents are used in dts, the interrupt 
> numbers are different.

You describe now the overall SoC, but this is a schema for a device, not
entire SoC. I still do not see why interrupt-parent is necessary for
this device.

> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it. 

You keep ignoring this one.

Best regards,
Krzysztof

