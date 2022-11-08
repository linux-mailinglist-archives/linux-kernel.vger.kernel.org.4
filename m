Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E462169C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiKHOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiKHOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:30:39 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60BA20F58;
        Tue,  8 Nov 2022 06:30:08 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Nov 2022 23:30:08 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id EC8A72059027;
        Tue,  8 Nov 2022 23:30:07 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Nov 2022 23:30:07 +0900
Received: from [10.212.157.169] (unknown [10.212.157.169])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1D870B62A4;
        Tue,  8 Nov 2022 23:30:07 +0900 (JST)
Message-ID: <3fcebf71-bdcb-8592-020c-4aa240a9e9a7@socionext.com>
Date:   Tue, 8 Nov 2022 23:30:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: uniphier: Add system controller
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
 <20221107103410.3443-2-hayashi.kunihiko@socionext.com>
 <48988a50-3c3d-7a85-af28-66f7842e5893@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <48988a50-3c3d-7a85-af28-66f7842e5893@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2022/11/08 20:09, Krzysztof Kozlowski wrote:
> On 07/11/2022 11:34, Kunihiko Hayashi wrote:
>> Add DT binding schema for system controller implemented in UniPhier SoCs.
>> This describes that the nodes defined here are treated as "syscon".
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext/socionext,uniphier-sysctrl.yaml | 92 +++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml
>> b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml
>> new file mode 100644
>> index 000000000000..be7cf72c232e
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-sysctrl.yaml
> 
> arm is only for top-level stuff. System controllers go to soc.

Okay. I wondered if I should put it here.
I'll make vendor's directory on "soc" and move it.


>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> http://devicetree.org/schemas/arm/socionext/socionext,uniphier-sysctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier system controller
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +description: |+
>> +  This describes the devicetree bindings for system controller
>> +  implemented on Socionext UniPhier SoCs.
> 
> Drop "This describes the devicetree bindings for" and instead describe
> the hardware.

Surely I think the system controller's description itself is insufficient.
This description contains multiple controllers, so add descriptions for each.


>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
> 
> You do not have more than one entry, so no need for oneOf.

Got it.

>> +      - items:
>> +          - enum:
>> +              # sysctrl
>> +              - socionext,uniphier-ld4-sysctrl
>> +              - socionext,uniphier-pro4-sysctrl
>> +              - socionext,uniphier-pro5-sysctrl
>> +              - socionext,uniphier-pxs2-sysctrl
>> +              - socionext,uniphier-ld6b-sysctrl
>> +              - socionext,uniphier-sld8-sysctrl
>> +              - socionext,uniphier-ld11-sysctrl
>> +              - socionext,uniphier-ld20-sysctrl
>> +              - socionext,uniphier-pxs3-sysctrl
>> +              - socionext,uniphier-nx1-sysctrl
>> +              - socionext,uniphier-sysctrl
>> +              # soc-glue
>> +              - socionext,uniphier-ld4-soc-glue
>> +              - socionext,uniphier-pro4-soc-glue
>> +              - socionext,uniphier-pro5-soc-glue
>> +              - socionext,uniphier-pxs2-soc-glue
>> +              - socionext,uniphier-ld6b-soc-glue
>> +              - socionext,uniphier-sld8-soc-glue
>> +              - socionext,uniphier-ld11-soc-glue
>> +              - socionext,uniphier-ld20-soc-glue
>> +              - socionext,uniphier-pxs3-soc-glue
>> +              - socionext,uniphier-nx1-soc-glue
>> +              - socionext,uniphier-soc-glue
>> +              # perictrl
>> +              - socionext,uniphier-ld4-perictrl
>> +              - socionext,uniphier-pro4-perictrl
>> +              - socionext,uniphier-pro5-perictrl
>> +              - socionext,uniphier-pxs2-perictrl
>> +              - socionext,uniphier-ld6b-perictrl
>> +              - socionext,uniphier-sld8-perictrl
>> +              - socionext,uniphier-ld11-perictrl
>> +              - socionext,uniphier-ld20-perictrl
>> +              - socionext,uniphier-pxs3-perictrl
>> +              - socionext,uniphier-nx1-perictrl
>> +              - socionext,uniphier-perictrl
>> +              # sdctrl
>> +              - socionext,uniphier-ld4-sdctrl
>> +              - socionext,uniphier-pro4-sdctrl
>> +              - socionext,uniphier-pro5-sdctrl
>> +              - socionext,uniphier-pxs2-sdctrl
>> +              - socionext,uniphier-ld6b-sdctrl
>> +              - socionext,uniphier-sld8-sdctrl
>> +              - socionext,uniphier-ld11-sdctrl
>> +              - socionext,uniphier-ld20-sdctrl
>> +              - socionext,uniphier-pxs3-sdctrl
>> +              - socionext,uniphier-nx1-sdctrl
>> +              - socionext,uniphier-sdctrl
>> +              # mioctrl
>> +              - socionext,uniphier-ld4-mioctrl
>> +              - socionext,uniphier-pro4-mioctrl
>> +              - socionext,uniphier-sld8-mioctrl
>> +              - socionext,uniphier-ld11-mioctrl
>> +              - socionext,uniphier-mioctrl
>> +              # adamv
>> +              - socionext,uniphier-ld11-adamv
>> +              - socionext,uniphier-ld20-adamv
>> +              - socionext,uniphier-adamv
>> +          - const: simple-mfd
>> +          - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties:
>> +  type: object
> 
> No, instead you should describe the children. This must me
> additionalProperties: false

Each controller has different children, so need to define children
for each controller using "if".

> You also miss example.
> 
> Start from example-schema as your template or guidance.

I see. I'll add example.

Thank you,

---
Best Regards
Kunihiko Hayashi
