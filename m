Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3A647285
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiLHPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLHPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:10:02 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 400D3A13D3;
        Thu,  8 Dec 2022 07:10:01 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 09 Dec 2022 00:10:00 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 9C9F92059054;
        Fri,  9 Dec 2022 00:10:00 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Dec 2022 00:10:00 +0900
Received: from [10.212.157.17] (unknown [10.212.157.17])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id D16E71DA8;
        Fri,  9 Dec 2022 00:09:59 +0900 (JST)
Message-ID: <f17ea2c8-d100-2152-34a1-f0d30fb93bd8@socionext.com>
Date:   Fri, 9 Dec 2022 00:09:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 08/16] dt-bindings: soc: socionext: Add UniPhier system
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-9-hayashi.kunihiko@socionext.com>
 <801c95b0-1157-632f-f9ed-9d526f54dc6c@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <801c95b0-1157-632f-f9ed-9d526f54dc6c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/08 17:15, Krzysztof Kozlowski wrote:
> On 07/12/2022 06:53, Kunihiko Hayashi wrote:
>> Add devicetree binding schema for the system controller implemented on
>> Socionext Uniphier SoCs.
>>
>> This system controller has multiple functions such as clock control,
>> reset control, internal watchdog timer, thermal management, and so on.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext/socionext,uniphier-sysctrl.yaml | 105 ++++++++++++++++++
>>   MAINTAINERS                                   |   1 +
>>   2 files changed, 106 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>> new file mode 100644
>> index 000000000000..c1b7cec8def4
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>> @@ -0,0 +1,105 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-sysctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier system controller
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +description: |+
>> +  System controller implemented on Socionext UniPhier SoCs has multiple
>> +  functions such as clock control, reset control, internal watchdog
>> timer,
>> +  thermal management, and so on.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - socionext,uniphier-ld4-sysctrl
>> +          - socionext,uniphier-pro4-sysctrl
>> +          - socionext,uniphier-pro5-sysctrl
>> +          - socionext,uniphier-pxs2-sysctrl
>> +          - socionext,uniphier-sld8-sysctrl
>> +          - socionext,uniphier-ld11-sysctrl
>> +          - socionext,uniphier-ld20-sysctrl
>> +          - socionext,uniphier-pxs3-sysctrl
>> +          - socionext,uniphier-nx1-sysctrl
>> +      - const: simple-mfd
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^clock-controller(@[0-9a-f]+)?$":
> 
> I don't remember if we talked about this but: why do you include here
> unit address? All your bindings expect these take regmap from the parent
> and they do not have separate MMIO address space, so these should be
> properties, not pattern properties.

I thought this unit address was an option, however, there is no example
of the existing devicetree. It is no longer necessary.

> Same in places below.
 >
>> +    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
>> +
>> +  "^reset-controller(@[0-9a-f]+)?$":
>> +    $ref: /schemas/reset/socionext,uniphier-reset.yaml#
>> +
>> +  "^watchdog(@[0-9a-f]+)?$":
>> +    $ref: /schemas/watchdog/socionext,uniphier-wdt.yaml#
>> +
>> +  "^thermal-sensor(@[0-9a-f]+)?$":
>> +    $ref: /schemas/thermal/socionext,uniphier-thermal.yaml#

I'll drop the address patterns.

Thank you,

---
Best Regards
Kunihiko Hayashi
