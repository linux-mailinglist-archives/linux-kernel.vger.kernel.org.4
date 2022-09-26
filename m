Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10A65E9965
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiIZGWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiIZGV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:21:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464027FCB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:21:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c7so6218028ljm.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QgZtE+HAhOfAZ/Q5/MPPrGpgpaNuAG0IuIzDtviaY9E=;
        b=s+ioEfKOaPLsp9qIiOpg5Jb4Qu5Jfy8AxzBkB7zQKgIVAYU7k04SGWcA2lJ4/oTvkc
         TTxHVXsnIgUG2FXLs/wFlg58OkJ8qAVoswG96ehUTFSQeICDfK8fKU0CaOLZ/espPC81
         YpgkM1HH1CIJ2OBA7A5EZzHXwTcOSljUYm8lAsZb7/nbjI4Er6W51QGFOBLa/ev/N0XE
         zt3SZXXjaF1KYU4UvBpIW6hn1rnsPRBB6YEiQ/AOdoSFUy2NS5pGWITRCMX58VQto64+
         iiPlFJSswGpqCl7nQWrLOz9B3TytSNi8lIjIOscYyvnm4j3o/jFVa5rkS9q4HzhHmSaZ
         4pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QgZtE+HAhOfAZ/Q5/MPPrGpgpaNuAG0IuIzDtviaY9E=;
        b=mG1j8wIBB8PgoXFBlM9+CFfgMIz/FEmZ3KKEMMPXh1MlG+/gIfSpyRgWA0zK/eiPd5
         iXNQff3XXgP/ZZCU0qH6Ses6q6CTR4n2NEo6PguXVnCaoB7j74BbnPtBxwefaf+Yezqj
         HvM8jh0my7iy4WGJKErtcAgwDfpWh/ODzFPQAcQx6e0im0K/SsgRG5RV24lZNX73O1xH
         bVmKE8u//gpjPqCcag3S0nT+lpaQuByMEMZGiNsnsgUvCmC1BIUj6SzcTzSt7yssOTbJ
         Ey7IM0oN08tqzhJqWECM7lkHj2gwHUSDSkBu4yVT148ssu4o5o9goWMOshweVLchBu5x
         cRXg==
X-Gm-Message-State: ACrzQf3NPe6rFbYw2fLfL3/UD7fbl3U+yf3ct+zC6xeZj+lonSkRcJFw
        FCJ0VeAaAax+TWQ/B72PXykDZg==
X-Google-Smtp-Source: AMsMyM4TAUtnG57my52vrguMzTQwJZ8hPZlV7iwa5zgLd1yuBL0mHQ1J88ikw8AnLlV/ac5XOf3OkA==
X-Received: by 2002:a2e:7310:0:b0:26c:657e:57d4 with SMTP id o16-20020a2e7310000000b0026c657e57d4mr6761543ljc.422.1664173303698;
        Sun, 25 Sep 2022 23:21:43 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 8-20020a2eb948000000b00261e7244887sm2196312ljs.60.2022.09.25.23.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 23:21:42 -0700 (PDT)
Message-ID: <1f3e153b-da8a-43fa-162f-9bea2ed3ef78@linaro.org>
Date:   Mon, 26 Sep 2022 08:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to
 json-schema
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        =?UTF-8?B?5YiY5L2p5a6d?= <liupeibao@loongson.cn>
References: <20220921015605.17078-1-zhuyinbo@loongson.cn>
 <20220921015605.17078-2-zhuyinbo@loongson.cn>
 <fb901889-d769-ba56-d4cb-2d9d8b50f74f@linaro.org>
 <28a78a10.a7dd.1835f5aaf90.Coremail.zhuyinbo@loongson.cn>
 <a44244f2-fb96-0483-b529-d0f2b0b7e5d8@linaro.org>
 <4febe7e4.a96c.18362d997e3.Coremail.zhuyinbo@loongson.cn>
 <20220924174258.GA1011284-robh@kernel.org>
 <4ce14e3c.bf79.18377f44118.Coremail.zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4ce14e3c.bf79.18377f44118.Coremail.zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 06:00, Yinbo Zhu wrote:
> 
> 
> 
>> -----原始邮件-----
>> 发件人: "Rob Herring" <robh@kernel.org>
>> 发送时间:2022-09-25 01:42:58 (星期日)
>> 收件人: "朱银波" <zhuyinbo@loongson.cn>
>> 抄送: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zhanghongchen <zhanghongchen@loongson.cn>
>> 主题: Re: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>
>> On Thu, Sep 22, 2022 at 09:39:30AM +0800, 朱银波 wrote:
>>>
>>>
>>>
>>>> -----原始邮件-----
>>>> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>>>> 发送时间:2022-09-21 17:31:11 (星期三)
>>>> 收件人: "朱银波" <zhuyinbo@loongson.cn>
>>>> 抄送: "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zhanghongchen <zhanghongchen@loongson.cn>
>>>> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>>>
>>>> On 21/09/2022 11:22, 朱银波 wrote:
>>>>>> -----原始邮件-----
>>>>>> 发件人: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>>>>>> 发送时间:2022-09-21 15:05:00 (星期三)
>>>>>> 收件人: "Yinbo Zhu" <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>>>>>> 抄送: zhanghongchen <zhanghongchen@loongson.cn>
>>>>>> 主题: Re: [PATCH v2 2/3] dt-bindings: thermal: Convert loongson2 to json-schema
>>>>>>
>>>>>> On 21/09/2022 03:56, Yinbo Zhu wrote:
>>>>>>> Convert the loongson2 thermal binding to DT schema format using
>>>>>>> json-schema.
>>>>>>
>>>>>> Incorrect subject and incorrect commit msg. There is no conversion here.
>>>>> Our soc architecture is the loongson2 series, so we will modify it accordingly.
>>>>
>>>> How the soc architecture is related to my comment that you do not
>>>> perform conversion?
>>> I got it, and I will aad a conversion.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Yinbo Zhu <c>
>>>>>>> ---
>>>>>>> Change in v2:
>>>>>>> 		1. Add description and type about the "id".	
>>>>>>> 		2. Make the filename was based on compatible.
>>>>>>>
>>>>>>>  .../bindings/thermal/loongson2-thermal.yaml   | 52 +++++++++++++++++++
>>>>>>>  1 file changed, 52 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..2994ae3a56aa
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/thermal/loongson2-thermal.yaml
>>>>>>
>>>>>>
>>>>>> No improvements here. You ignore my comments, so I am going to NAK it.
>>>>> I don't get your point, that dts compatible is "loongson,loongson2-thermal", so this driver file name is named
>>>>> loongson2-thermal that according what you said about "Filename based on compatible."
>>>>> If what I understand is not what you expect, please tell me how to modify it.
>>>>
>>>>
>>>> Filename must match the compatible, so: loongson,loongson2-thermal.yaml
>>> I got it, and I will add a conversion.
>>>>
>>>>>>
>>>>>>
>>>>>>> @@ -0,0 +1,52 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/thermal/loongson2-thermal.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: Thermal sensors on loongson2 SoCs
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - zhanghongchen <zhanghongchen@loongson.cn>
>>>>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    const: loongson,loongson2-thermal
>>>>>>> +
>>>>>>> +  reg:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  id:
>>>>>>> +    $ref: '//schemas/types.yaml#/definitions/uint32'
>>>>>>
>>>>>> No improvements here, so let me be specific - you need to really justify
>>>>>> such property or it cannot go to schema.
>>>>> The loongson2_thermal.c driver need parse this "id" property.
>>>>
>>>> This is not reason to add properties to DT. DT describes the hardware,
>>>> not driver behavior.
>>>>
>>>> Why hardware needs arbitrary, additional addressing number instead of
>>>> standard unit address?
>>> The loongson2 series soc supports up to four sensors, but the 2K1000 has only one sensor, so the ID must be 0. 
>>> For the 2K1000, in order to distinguish the differences between different hardware in the Loongson2 SoC series,
>>> the ID is added to the dts
>>
>> Differences in SoCs is what 'compatible' is for. If 'loongson2' is not a 
>> specific SoC, then your compatible string is not specific enough.
> If other loongson2 platforms are different from the thermal sensor, I will add compatible
> "loongson,loongson2-thermal-xxx", please you note.

No, this compatible looks wrong then. What is your SoC model number? You
called loongson2 a "series", so that's not appropriate. Compatible
should be specific.

> 
>>
>>>>
>>>>>>
>>>>>>> +    description: |
>>>>>>> +      Specify the thermal sensor id.
>>>>>>> +    minimum: 0
>>>>>>> +    maximum: 3
>>>>>>> +
>>>>>>> +  interrupts:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  "#thermal-sensor-cells":
>>>>>>> +    const: 1
>>
>> If one SoC only has 1 sensor, then this could be 0. However, you don't 
>> have to do that, but it's another way to distinguish differences.
> okay ,I got it.
>>
>>>>>>> +
>>>>>>> +required:
>>>>>>> +  - compatible
>>>>>>> +  - reg
>>>>>>> +  - id
>>>>>>> +  - interrupt-parent
>>>>>>
>>>>>> Why?
>>>>> The interrupts of our dts do not specify an interrupt parent,
>>>>> eg. interrupts = <7 IRQ_TYPE_LEVEL_LOW>
>>>>> so we need to add an interrupt parent property.
>>>>
>>>> You can add but I am asking why is it required?
>>> Since there is more than one interrupt controller in the Loongson2 series soc, that need to specify the interrupt 
>>> controller in the dts, that is, the interrupt parent.   If different interrupt parents are used in dts, the interrupt 
>>> numbers are different.
>>
>> It is perfectly valid for the 'interrupt-parent' to be in *any* parent 
>> node. So it is never required by any binding.
> I don't get your meaning, You mean I can add it in the dts, but I don't need to add it in the binding file, right?

You should not add it to the binding because it is not related to the
device itself.

>>
>> Rob
> 
> 
> 本邮件及其附件含有龙芯中科的商业秘密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制或散发）本邮件及其附件中的信息。如果您错收本邮件，请您立即电话或邮件通知发件人并删除本邮件。 
> This email and its attachments contain confidential information from Loongson Technology , which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this email in error, please notify the sender by phone or email immediately and delete it. 

Don't include such footers. We cannot talk over confidential emails and
you clearly state that here.

Best regards,
Krzysztof

