Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD16C1175
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCTMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjCTMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:05:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E2A5CF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:05:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so45749909edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679313935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fedWdOIXJsNBKS4RtVOA7U0PbI5IbSCYkI9M2Yv/QEg=;
        b=Ei7LNCBt7McN/imVovbkYW70ZdaAZlmUX8ZXfNVOiyuG80+m+jPF+4TTKyLfGbGxPp
         8KDJrFMHjzGQKXFKnQMAtFSMWyVAZyKydtmXHp+FUa/SuXAvLz4GtwUW1wGEWxf5QgL1
         X5Sse5ymSooYAKa5IHVye7AgsKjR2sTzNzuiYem0c4qANN6L0z8VJPKcHFLJzzd4xA4n
         ghFsMCMu8x1oKFxXELHIjUPk6cyQxLre3HZeSjJtwK1IJUWhsFNGS7BxLV3A/Q5CYfvh
         n5OHJt+xLZQdZuAGzxYt/I3J7kdwB39ZW2bZqYwDXQd2ihwWQu7dq7MJHcDqpLWa5P8R
         qOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679313935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fedWdOIXJsNBKS4RtVOA7U0PbI5IbSCYkI9M2Yv/QEg=;
        b=l6x574WzG+DY2LgDdWEeTdiDzzVtsy4HbIc8Ngt3CB7IhWUut7+hLkGlyjKzMwe2fC
         zK4lxyxfX8y/gxhX8OnWjhAmaEv/smKyK1TYGPt/iz5dbxpklx7AUAxMuEc4d0urxwas
         qpJqobLPhXWk9e9AGe82b5d8jgWHeItt5jxf8qtCzc83eZ31XfIxGnh/A/93MHBDXUol
         wYkWOcrluzEUpuV3d+ksuYQg3Q3hAOTYCsMQBwkjpU1b6RWwYyzJxiMuRNWI8Nj7f6VE
         grzhwk4BBRN7f+ubhy2DzSTOrOVusFutwEHvhpsESTeS5EtRY8XXZqtQjovLWxI8aMdx
         JxtA==
X-Gm-Message-State: AO0yUKXu9kiMs6vACArbH+CJuizAOXuIftuGNTdbAGUOQAc/+8x9WUyl
        b3O7+NXe+j7buc9fAo3mFM3I9w==
X-Google-Smtp-Source: AK7set9+EEqEhfmet3QUBcm61u82chev994J+/ophV6+5EzW4nCrCF0i2u8CUkU7H7xrhP9w+C8hRA==
X-Received: by 2002:a05:6402:1353:b0:4fa:ba31:6c66 with SMTP id y19-20020a056402135300b004faba316c66mr12438314edw.42.1679313934876;
        Mon, 20 Mar 2023 05:05:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id u2-20020a50a402000000b004c4eed3fe20sm4825654edb.5.2023.03.20.05.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:05:34 -0700 (PDT)
Message-ID: <e98f0068-dfd0-0402-8089-3ca53870263d@linaro.org>
Date:   Mon, 20 Mar 2023 13:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct i.MX8MQ
 support
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
References: <20230320020714.955800-1-peng.fan@oss.nxp.com>
 <8efe78d3-ff50-1970-3a90-28bab4992bad@linaro.org>
 <DU0PR04MB9417D88E67200F4A74C5CF4888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <355d5dde-cc86-018c-85d5-51cf59bdb36a@linaro.org>
 <DU0PR04MB9417FBDEC58F46C069A359B888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417FBDEC58F46C069A359B888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 12:44, Peng Fan wrote:
>> Subject: Re: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct
>> i.MX8MQ support
>>
>> On 20/03/2023 12:02, Peng Fan wrote:
>>>> Subject: Re: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct
>>>> i.MX8MQ support
>>>>
>>>> On 20/03/2023 03:07, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> The previous i.MX8MQ support breaks rockchip,dwc3 support, so use
>>>>> select to restrict i.MX8MQ support and avoid break others.
>>>>>
>>>>> Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 21 ++++++++++++-------
>>>>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>> b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>> index 16c7d06c9172..6347a6769ee3 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>> @@ -28,15 +28,22 @@ allOf:
>>>>>      else:
>>>>>        $ref: usb-xhci.yaml#
>>>>>
>>>>> +select:
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      contains:
>>>>> +        enum:
>>>>> +          - fsl,imx8mq-dwc3
>>>>
>>>> And what about all snps,dwc3 devices there (without specific compatible)?
>>>> Previously they were selected and now they are not... so you just
>>>> disabled schema for all of them.
>>> [Peng Fan]
>>>
>>> I am not sure how to address:
>>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
>>> .kernel.org%2Fall%2FCAL_Jsq%2BnrqTX5ND3%3D%2BkFUmStx-
>> %2Bb%3DqpE_WsL_Le
>>> -YX8c285-
>> 5A%40mail.gmail.com%2F&data=05%7C01%7Cpeng.fan%40nxp.com%7C1e
>>>
>> 67df79692243f058fa08db2937befd%7C686ea1d3bc2b4c6fa92cd99c5c30163
>> 5%7C0%
>>>
>> 7C0%7C638149091586933618%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
>> 4wLjAwMDAiL
>>>
>> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
>> data=r1
>>> fesB1c%2B3YxohCGM36xySFucVU25WVYIMlpgGkdoWk%3D&reserved=0
>>>
>>> Rob suggested use select, but I am not sure how to use it here. Use an
>>> extra yaml file with select or else.
>>>
>>>>
>>>>> +  required:
>>>>> +    - compatible
>>>>> +
>>>>>  properties:
>>>>>    compatible:
>>>>> -    oneOf:
>>>>> -      - items:
>>>>> -          - const: fsl,imx8mq-dwc3
>>>>
>>>> I don't understand why you remove your compatible.
>>> [Peng Fan]
>>>
>>> My last change drops 'contains' by mistake, and breaks
>>
>> This I understand.
>>
>>> rockchip,dwc3, so just bring back the original content
>>
>> This is not a reason to make your compatible undocumented. You basically
>> revert your patch. It does not make any sense to me.
> [Peng Fan] 
> 
> ok, let me think more. Honestly not have good idea (:
> If you have any guidance, that would be helpful.

You should only need a select, however most likely selecting also
snps,dwc3 (without specific compatible). Anyway this binding - including
how it is referenced by others - is getting unmanagable. I think I
commented about this on some other occasion. The point is that no one
refactors it thus it grows and grows leading to more of such tricky
scenarios.

How it should be refactored? Probably just like all other with re-usable
components: common part and device specific bindings including it. While
snps,dwc3 alone should not be allowed anymore.

Best regards,
Krzysztof

