Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A00663EB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLAIaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLAIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:30:01 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B02111F;
        Thu,  1 Dec 2022 00:29:59 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Dec 2022 17:29:59 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 82BD72059054;
        Thu,  1 Dec 2022 17:29:59 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 1 Dec 2022 17:29:59 +0900
Received: from [10.212.157.157] (unknown [10.212.157.157])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 26B31A855D;
        Thu,  1 Dec 2022 17:29:59 +0900 (JST)
Message-ID: <411af198-d4ef-52a7-b3fd-15e9c35021b4@socionext.com>
Date:   Thu, 1 Dec 2022 17:29:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/8] dt-bindings: soc: socionext: Add UniPhier SoC-glue
 logic
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-3-hayashi.kunihiko@socionext.com>
 <4e90944a-1200-4619-f977-590fe2919017@linaro.org>
 <efa90f10-db67-bb9f-03fd-e99695a5bdf5@socionext.com>
 <24add13e-5339-cc79-525a-098c2d61e8c1@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <24add13e-5339-cc79-525a-098c2d61e8c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/01 0:27, Krzysztof Kozlowski wrote:
> On 30/11/2022 09:59, Kunihiko Hayashi wrote:
>> Hi Krzysztof,
>>
>> On 2022/11/29 23:43, Krzysztof Kozlowski wrote:
>>> On 29/11/2022 11:35, Kunihiko Hayashi wrote:
>>>> Add devicetree binding schema for the SoC-glue logic implemented on
>>>> Socionext Uniphier SoCs.
>>>>
>>>> This SoC-glue logic is a set of miscellaneous function registers
>>>> handling signals for specific devices outside system components,
>>>> and also has multiple functions such as I/O pinmux, usb-phy, debug,
>>>> clock-mux for a specific SoC, and so on.
>>>>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>    .../socionext,uniphier-soc-glue.yaml          | 94 +++++++++++++++++++
>>>>    1 file changed, 94 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>>> new file mode 100644
>>>> index 000000000000..3f571e3e1339
>>>> --- /dev/null
>>>> +++
>>>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
>>>> @@ -0,0 +1,94 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id:
>>>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Socionext UniPhier SoC-glue logic
>>>> +
>>>> +maintainers:
>>>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> +
>>>> +description: |+
>>>> +  SoC-glue logic implemented on Socionext UniPhier SoCs is a collection
>>>> of
>>>> +  miscellaneous function registers handling signals outside system
>>>> components.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - socionext,uniphier-ld4-soc-glue
>>>> +          - socionext,uniphier-pro4-soc-glue
>>>> +          - socionext,uniphier-pro5-soc-glue
>>>> +          - socionext,uniphier-pxs2-soc-glue
>>>> +          - socionext,uniphier-ld6b-soc-glue
>>>> +          - socionext,uniphier-sld8-soc-glue
>>>> +          - socionext,uniphier-ld11-soc-glue
>>>> +          - socionext,uniphier-ld20-soc-glue
>>>> +          - socionext,uniphier-pxs3-soc-glue
>>>> +          - socionext,uniphier-nx1-soc-glue
>>>> +          - socionext,uniphier-soc-glue
>>>
>>> This one looks generic - why having it next to specific ones?
>>
>> SoC-glue has the same register set, but different implementations
>> for each SoC.
> 
> Sure, but you did not model it as a compatible fallback, but like one of
> variants. It is not tied to specific SoC, thus too generic.

I understand. It should be placed in parallel with enum.

item:
   - enum:
       - ...
       - ...
   - const: socionext,uniphier-soc-glue

>> I thought of defining the same register set as a common specs,
>> but each compatibles are sufficient. I'll remove it.

So currently drop it.

>>
>>> Same question for your previous patch - socionext,uniphier-sysctrl.
>>>
>>> And similarly to previous patch, do you expect child nodes everywhere?
>>
>> In case of this SoC-glue logic, all SoCs has pinctrl, however,
>> only SoCs with USB2 host has usb-controller (phy-hub).
>> And only legacy SoCs implement clock-controller (clk-mux) here.
>>
>> Should child nodes that exist only in a specific "compatible" be defined
>> conditionally?
> 
> No, rather define them in top level but disallow for specific compatibles:
> 
> allOf:
>   - if:
>    ....
>     then:
>       patternProperties:
>         ...: false
> 
> Assuming that this does not over-complicate schema.

OK. Some properties are applied for a few compatibles, so I think it is
available to use "else:".

allOf:
   - if:
       ...
     else:
       patternProperties:
         ...: false

Thank you,

---
Best Regards
Kunihiko Hayashi
