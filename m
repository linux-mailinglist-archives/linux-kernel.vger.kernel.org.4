Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA863D14B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiK3JAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiK3JAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:00:18 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8530C421B9;
        Wed, 30 Nov 2022 01:00:15 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Nov 2022 18:00:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 951C8205D901;
        Wed, 30 Nov 2022 18:00:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Nov 2022 18:00:14 +0900
Received: from [10.212.156.209] (unknown [10.212.156.209])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 44F7AA855B;
        Wed, 30 Nov 2022 18:00:14 +0900 (JST)
Message-ID: <8739afc1-47c9-3950-e449-ff424820bec9@socionext.com>
Date:   Wed, 30 Nov 2022 18:00:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/8] dt-bindings: soc: socionext: Add UniPhier peripheral
 block
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-4-hayashi.kunihiko@socionext.com>
 <b910e717-86a6-6123-e8a3-9fdf0618fca2@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <b910e717-86a6-6123-e8a3-9fdf0618fca2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/11/29 23:46, Krzysztof Kozlowski wrote:
> On 29/11/2022 11:35, Kunihiko Hayashi wrote:
>> Add devicetree binding schema for the peripheral block implemented on
>> Socionext Uniphier SoCs.
>>
>> Peripheral block implemented on Socionext UniPhier SoCs is an integrated
>> component of the peripherals including UART, I2C/FI2C, and SCSSI.
>>
>> Peripheral block has some function logics to control the component.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext,uniphier-perictrl.yaml          | 67 +++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
>> new file mode 100644
>> index 000000000000..080b6ab3ea1a
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-perictrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier peripheral block controller
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +description: |+
>> +  Peripheral block implemented on Socionext UniPhier SoCs is an
>> integrated
>> +  component of the peripherals including UART, I2C/FI2C, and SCSSI.
>> +  Peripheral block controller is a logic to control the component.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - socionext,uniphier-ld4-perictrl
>> +          - socionext,uniphier-pro4-perictrl
>> +          - socionext,uniphier-pro5-perictrl
>> +          - socionext,uniphier-pxs2-perictrl
>> +          - socionext,uniphier-ld6b-perictrl
>> +          - socionext,uniphier-sld8-perictrl
>> +          - socionext,uniphier-ld11-perictrl
>> +          - socionext,uniphier-ld20-perictrl
>> +          - socionext,uniphier-pxs3-perictrl
>> +          - socionext,uniphier-nx1-perictrl
>> +          - socionext,uniphier-perictrl
>> +      - const: simple-mfd
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^clock-controller(@[0-9a-f]+)?$":
>> +    $ref: /schemas/clock/socionext,uniphier-clock.yaml#
>> +
>> +  "^reset-controller(@[0-9a-f]+)?$":
>> +    $ref: /schemas/reset/socionext,uniphier-reset.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    syscon@59820000 {
>> +        compatible = "socionext,uniphier-ld20-perictrl",
>> +                     "simple-mfd", "syscon";
>> +        reg = <0x59820000 0x200>;
>> +
>> +        clock-controller {
> 
> None of your children in examples and in DTS have unit addresses.
> However you explicitly mentioned them in the patternProperties. Do you
> expect adding unit addresses?

Currently, children's registers are partially mixed and it's hard
to specify the unit address.

The address pattern was added as option for the future, however,
not needed for the current implementation. I'll remove them in next.

Thank you,

---
Best Regards
Kunihiko Hayashi
