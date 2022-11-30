Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4459263D13F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiK3I7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiK3I7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:59:39 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AEC840901;
        Wed, 30 Nov 2022 00:59:37 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Nov 2022 17:59:36 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DDB52205D901;
        Wed, 30 Nov 2022 17:59:36 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Nov 2022 17:59:36 +0900
Received: from [10.212.156.209] (unknown [10.212.156.209])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 145F8A855B;
        Wed, 30 Nov 2022 17:59:36 +0900 (JST)
Message-ID: <adee56c4-6932-9272-3319-e003ab8413b5@socionext.com>
Date:   Wed, 30 Nov 2022 17:59:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] dt-bindings: soc: socionext: Add UniPhier system
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-2-hayashi.kunihiko@socionext.com>
 <ce1b5859-4ca6-6d2d-19bc-e33e48165093@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <ce1b5859-4ca6-6d2d-19bc-e33e48165093@linaro.org>
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

Thank you for reviewing.

On 2022/11/29 23:41, Krzysztof Kozlowski wrote:
> On 29/11/2022 11:35, Kunihiko Hayashi wrote:
>> Add devicetree binding schema for the system controller implemented on
>> Socionext Uniphier SoCs.
>>
>> This system controller has multiple functions such as clock control,
>> reset control, internal watchdog timer, thermal management, and so on.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext/socionext,uniphier-sysctrl.yaml | 84 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 85 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>> new file mode 100644
>> index 000000000000..e966ce1e4b6c
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-sysctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier system controller
> 
> As Rob's bot pointed, you need to update here examples in other
> bindings, so they will pass. Otherwise it is not bisectable change.

I've got it. I should also update other examples.

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
>> +          - socionext,uniphier-ld6b-sysctrl
>> +          - socionext,uniphier-sld8-sysctrl
>> +          - socionext,uniphier-ld11-sysctrl
>> +          - socionext,uniphier-ld20-sysctrl
>> +          - socionext,uniphier-pxs3-sysctrl
>> +          - socionext,uniphier-nx1-sysctrl
> 
> All of them can have children or only some?

In case of this system controller,
all SoCs has clock-controller, reset-controller and watchdog.

However, some SoCs don't have thermal-sensor and
their register addresses are reserved.

>> +          - socionext,uniphier-sysctrl
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
>> +  "^watchdog(@[0-9a-f]+)?$":
>> +    $ref: /schemas/watchdog/socionext,uniphier-wdt.yaml#
>> +
>> +  "^thermal-sensor(@[0-9a-f]+)?$":
>> +    $ref: /schemas/thermal/socionext,uniphier-thermal.yaml#
>> +
Thank you,

---
Best Regards
Kunihiko Hayashi
