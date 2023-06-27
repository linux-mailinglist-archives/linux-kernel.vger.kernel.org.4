Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD373F625
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjF0Hx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjF0HxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:53:25 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C63D10E4;
        Tue, 27 Jun 2023 00:53:24 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 850D0819B;
        Tue, 27 Jun 2023 15:53:22 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 27 Jun
 2023 15:53:22 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 27 Jun
 2023 15:53:21 +0800
Message-ID: <60338447-db39-5d80-6f88-8d6f5dc3716b@starfivetech.com>
Date:   Tue, 27 Jun 2023 15:53:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230619083517.415597-1-william.qiu@starfivetech.com>
 <20230619083517.415597-2-william.qiu@starfivetech.com>
 <4937f9c4-a0e0-fd37-d71b-e7488b2a1062@linaro.org>
 <fb608232-f44d-21cf-7e0e-28829196e677@starfivetech.com>
 <adc4d83e-5bec-b925-b55e-43ad441ad8ee@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <adc4d83e-5bec-b925-b55e-43ad441ad8ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/21 16:10, Krzysztof Kozlowski wrote:
> On 21/06/2023 08:45, William Qiu wrote:
>> 
>> 
>> On 2023/6/19 20:17, Krzysztof Kozlowski wrote:
>>> On 19/06/2023 10:35, William Qiu wrote:
>>>> The QSPI controller needs three clock items to work properly on StarFive
>>>> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
>>>> platforms do not have this constraint.
>>>>
>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
>>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>>> ---
>>>>  .../bindings/spi/cdns,qspi-nor.yaml           | 20 ++++++++++++++++++-
>>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>>> index b310069762dd..1b83cbb9a086 100644
>>>> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
>>>> @@ -26,6 +26,15 @@ allOf:
>>>>              const: starfive,jh7110-qspi
>>>>      then:
>>>>        properties:
>>>> +        clocks:
>>>> +          maxItems: 3
>>>> +
>>>> +        clock-names:
>>>> +          items:
>>>> +            - const: ref
>>>> +            - const: ahb
>>>> +            - const: apb
>>>
>>> You are duplicating top-level property. Define the items only in one
>>> place. If this list is applicable to everything, then in top-level property.
>>>
>> Only in JH7110 SoC need there clocks, other platforms do not have this constraint.
>> So I need to duplicating top-level property.
> 
> You don't need, why? Why writing something twice is an answer to "JH7110
> needs 3 clocks"? It's not related.
> 
> What is the clock for all other variants?
> 
I'll try to not duplicating top-level property.
>>>> +
>>>>          resets:
>>>>            minItems: 2
>>>>            maxItems: 3
>>>> @@ -38,6 +47,9 @@ allOf:
>>>>  
>>>>      else:
>>>>        properties:
>>>> +        clocks:
>>>> +          maxItems: 1
>>>
>>> clock-names is missing. They must be in sync with clocks. What is the
>>> first clock?
>>>
>> But there are no clock-names before, should I add it?
> 
> Then let's just disallow it. Either you define it or you not allow it.
> 
Fine, I'll keep it disallow.
>>>> +
>>>>          resets:
>>>>            maxItems: 2
>>>>  
>>>> @@ -70,7 +82,13 @@ properties:
>>>>      maxItems: 1
>>>>  
>>>>    clocks:
>>>> -    maxItems: 1
>>>> +    maxItems: 3
>>>
>>>
>>> You did not test it before sending. minItems is missing.
>>>
>> I will add it.
>> As for other platforms, should I use enum to constraint the clocks?
> 
> What is the clock on other platforms?
> 
Other platforms have only one clock.
> Best regards,
> Krzysztof
> 
Thanks for taking time to review this patch series and give usefull
suggestions.

Best Regards,
William
