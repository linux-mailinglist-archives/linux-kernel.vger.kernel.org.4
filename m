Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932E464728A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLHPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLHPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:11:25 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C16FA13D5;
        Thu,  8 Dec 2022 07:11:23 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Dec 2022 00:11:22 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DE89A2058B4F;
        Fri,  9 Dec 2022 00:11:22 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Dec 2022 00:11:22 +0900
Received: from [10.212.157.17] (unknown [10.212.157.17])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 56E9E1DA8;
        Fri,  9 Dec 2022 00:11:22 +0900 (JST)
Message-ID: <b46238ab-427c-aa87-1de9-8f9857801772@socionext.com>
Date:   Fri, 9 Dec 2022 00:11:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/16] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic debug part
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-11-hayashi.kunihiko@socionext.com>
 <5b930984-4593-b70e-ba49-04e87700527c@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <5b930984-4593-b70e-ba49-04e87700527c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/08 17:18, Krzysztof Kozlowski wrote:
> On 07/12/2022 06:53, Kunihiko Hayashi wrote:
>> Add devicetree binding schema for the SoC-glue logic debug part
>> implemented on Socionext Uniphier SoCs.
>>
>> This SoC-glue logic debug part is a set of miscellaneous function
>> registers handling signals for specific devices outside system
>> components, and also has multiple functions such as efuse, debug unit,
>> several monitors for specific SoC, and so on.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext,uniphier-soc-glue-debug.yaml    | 73 +++++++++++++++++++
>>   1 file changed, 73 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
>>
>> diff --git
>> a/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
>> new file mode 100644
>> index 000000000000..db13c56b77b6
>> --- /dev/null
>> +++
>> b/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
>> @@ -0,0 +1,73 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id:
>> http://devicetree.org/schemas/soc/socionext/socionext,uniphier-soc-glue-debug.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Socionext UniPhier SoC-glue logic debug part
>> +
>> +maintainers:
>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> +
>> +description: |+
>> +  SoC-glue logic debug part implemented on Socionext UniPhier SoCs is
>> +  a collection of miscellaneous function registers handling signals
>> outside
>> +  system components for debug and monitor use.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - socionext,uniphier-ld4-soc-glue-debug
>> +          - socionext,uniphier-pro4-soc-glue-debug
>> +          - socionext,uniphier-pro5-soc-glue-debug
>> +          - socionext,uniphier-pxs2-soc-glue-debug
>> +          - socionext,uniphier-sld8-soc-glue-debug
>> +          - socionext,uniphier-ld11-soc-glue-debug
>> +          - socionext,uniphier-ld20-soc-glue-debug
>> +          - socionext,uniphier-pxs3-soc-glue-debug
>> +          - socionext,uniphier-nx1-soc-glue-debug
>> +      - const: simple-mfd
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +patternProperties:
>> +  "^efuse(@[0-9a-f]+)?$":
> 
> Unit addresses are not optional.

In this case, the unit addresses are mandatory, so I'll fix it.

Thank you,

---
Best Regards
Kunihiko Hayashi
