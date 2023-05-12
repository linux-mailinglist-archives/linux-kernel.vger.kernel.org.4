Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C9570051E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbjELKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240745AbjELKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:22:35 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2D7CE;
        Fri, 12 May 2023 03:22:23 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7A34424E22D;
        Fri, 12 May 2023 18:22:22 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 18:22:22 +0800
Received: from [192.168.125.108] (113.72.146.187) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 18:22:21 +0800
Message-ID: <d4de3b1b-31b6-c257-29a5-f404ff0fbe99@starfivetech.com>
Date:   Fri, 12 May 2023 18:22:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: cdns,usb3: Add clock and reset
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
References: <20230510132816.108820-1-minda.chen@starfivetech.com>
 <20230510132816.108820-2-minda.chen@starfivetech.com>
 <9cf5965a-8290-dfff-9f92-07ed2df66650@linaro.org>
 <05057f6d-cb38-8e4a-5d30-82863e0cda44@kernel.org>
 <028fb8ac-d6cc-6fee-f50b-b965e69e7d0c@linaro.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <028fb8ac-d6cc-6fee-f50b-b965e69e7d0c@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/11 22:49, Krzysztof Kozlowski wrote:
> On 11/05/2023 14:16, Roger Quadros wrote:
>> 
>> 
>> On 11/05/2023 12:26, Krzysztof Kozlowski wrote:
>>> On 10/05/2023 15:28, Minda Chen wrote:
>>>> To support generic clock and reset init in Cadence USBSS
>>>> controller, add clock and reset dts configuration.
>>>>
>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>> ---
>>>>  .../devicetree/bindings/usb/cdns,usb3.yaml         | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>> index cae46c4982ad..623c6b34dee3 100644
>>>> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>> @@ -42,6 +42,18 @@ properties:
>>>>        - const: otg
>>>>        - const: wakeup
>>>>  
>>>> +  clocks:
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>> +    description:
>>>> +      USB controller clocks.
>>>
>>> You need to list the items. And why is it variable? Your clock choice in
>>> the example is poor, I doubt it is real.
>>>
>>>> +
>>>> +  resets:
>>>> +    minItems: 1
>>>> +    maxItems: 8
>>>> +    description:
>>>> +      USB controller generic resets.
>>>
>>> Here as well.
>>>
>>> You had one clock last time, thus the review was - drop the names. Now
>>> you changed it to 8 clocks... I don't understand.
>>>
>> 
>> Different platforms may have different number of clocks/resets or none.
>> So I don't think minItems/maxItems should be specified.
> 
> Yeah, but we want the clocks to be specific per platform. Not anything
> anywhere.
> 
> Best regards,
> Krzysztof
> 

I can change like these. Are these changes can be approved?
lpm , bus clock and "pwrup" reset can be specific cases. (The changes are from snps,dwc3.yaml.)

  clocks:
    description:
      In general the core supports two types of clocks. bus is a SoC Bus
      Clock(AHB/AXI/APB). lpm is a link power management clock. But particular
      cases may differ from that having less or more clock sources with
      another names.

  clock-names:
    contains:
      anyOf:
        - enum: [bus, lpm]
        - true

  resets:
    description:
      In general the core supports controller power-up reset. Also clock and
      other resets can be added. Particular cases may differ from that having
      less or more resets with another names.

  reset-names:
    contains:
      anyOf:
        - const: pwrup
        - true
