Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E846C10FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCTLjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:39:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E014EA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:39:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er8so33710688edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679312360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShGrWTqpBYO/SMDmz1FUp9/Cnckjt6bpBWjpINOQBvM=;
        b=U5Ba8vnx02o1jOVTya5gjvxG5eePkXUJIz4BznDZi7oYV1LDrxHQ26lvfzstsTZT4X
         EXuW1gu10S78je91uYVaZUzxMxVGfSn94GBy1g2rcGTjchTCsTjkAROrqX5VOE5CVbO6
         YUPjYluatcvO8hNlU8ymefXUIadav9vsZD64CZAZ9Y7iNidtJyJD+Gw3YAM24e+MUOJp
         BQOezhqfh93cWmi9ORCcfvQRYEC0OkuFw5FVrPemhN3GBKl+XBen5Zw8eTs1WZov9ON3
         9zzPSP6hoZJwq/3Dvtf9dswvnGQXd3FtnZuWQHoVGuUPgpa3QUpDkxt2GR1ae5+u7whg
         Ax7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679312360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShGrWTqpBYO/SMDmz1FUp9/Cnckjt6bpBWjpINOQBvM=;
        b=SR6uEjOO9jgcKbwbGbO9NIGokVfGbCf93P5vAFLiad7VQbzc9WEHtxGr828ONcJbCh
         LHi4uUvKSMfosv8ULbyr0mUhqVwKPMK7VG2ZKRLqJdd/WDrnM2endpE7Ii9QJusARb59
         lZhYWBvSUGfh6mwK+6qSl/bbyioNJf0fzuttVRiO7sI78P0cfzaCGkWQQ2PavsjHH7wY
         QV93+W4/MZxCeJXfv/BvQX8RiA7nqjwv3ylJF99e0kOkRwU+NVkJTdaBSeUxC6V0d9es
         2SQRatw5VCovIKfkwZiI+CxL+Pf3BaL3ttbvSvXHzRe1UVNp6k6RKFl+Xa1/aZfsBBCE
         +sEA==
X-Gm-Message-State: AO0yUKVUxDBp+f5CyAb+7LjFw/3BjSHyuEzflIkRM/jCLYIhJu32UQPl
        muFdOKbgzAWmWQUmKHurLCtViw==
X-Google-Smtp-Source: AK7set9OOcOsno7fRwtj0mHO3kQekqDD2nlgrGFWHIJ62wqI55Bbl2295GpLbftS8sfcz0gn7Gb5dw==
X-Received: by 2002:a17:907:6295:b0:932:f88c:c2ff with SMTP id nd21-20020a170907629500b00932f88cc2ffmr9752264ejc.34.1679312360028;
        Mon, 20 Mar 2023 04:39:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id ch19-20020a170906c2d300b00933d64cd447sm1645621ejb.121.2023.03.20.04.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 04:39:19 -0700 (PDT)
Message-ID: <355d5dde-cc86-018c-85d5-51cf59bdb36a@linaro.org>
Date:   Mon, 20 Mar 2023 12:39:18 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB9417D88E67200F4A74C5CF4888809@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 12:02, Peng Fan wrote:
>> Subject: Re: [PATCH linux-next] dt-bindings: usb: snps,dwc3: correct
>> i.MX8MQ support
>>
>> On 20/03/2023 03:07, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> The previous i.MX8MQ support breaks rockchip,dwc3 support, so use
>>> select to restrict i.MX8MQ support and avoid break others.
>>>
>>> Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 21 ++++++++++++-------
>>>  1 file changed, 14 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index 16c7d06c9172..6347a6769ee3 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -28,15 +28,22 @@ allOf:
>>>      else:
>>>        $ref: usb-xhci.yaml#
>>>
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - fsl,imx8mq-dwc3
>>
>> And what about all snps,dwc3 devices there (without specific compatible)?
>> Previously they were selected and now they are not... so you just disabled
>> schema for all of them.
> [Peng Fan] 
> 
> I am not sure how to address:
> https://lore.kernel.org/all/CAL_Jsq+nrqTX5ND3=+kFUmStx-+b=qpE_WsL_Le-YX8c285-5A@mail.gmail.com/
> 
> Rob suggested use select, but I am not sure how to use it here. Use
> an extra yaml file with select or else.
> 
>>
>>> +  required:
>>> +    - compatible
>>> +
>>>  properties:
>>>    compatible:
>>> -    oneOf:
>>> -      - items:
>>> -          - const: fsl,imx8mq-dwc3
>>
>> I don't understand why you remove your compatible.
> [Peng Fan] 
> 
> My last change drops 'contains' by mistake, and breaks

This I understand.

> rockchip,dwc3, so just bring back the original content

This is not a reason to make your compatible undocumented. You basically
revert your patch. It does not make any sense to me.


Best regards,
Krzysztof

