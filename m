Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42A26C0980
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCTDyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTDyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:54:40 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36A1CAD7;
        Sun, 19 Mar 2023 20:54:36 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8D4D524E2B0;
        Mon, 20 Mar 2023 11:54:34 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 11:54:34 +0800
Received: from [192.168.125.128] (183.27.97.64) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 11:54:33 +0800
Message-ID: <45221a1c-dc01-2759-3e32-658636625529@starfivetech.com>
Date:   Mon, 20 Mar 2023 11:54:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: starfive: syscon: Add optional
 patternProperties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
 <20230316030514.137427-4-xingyu.wu@starfivetech.com>
 <1f352445-4677-e33b-be14-c76bd7ffa188@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <1f352445-4677-e33b-be14-c76bd7ffa188@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/19 20:28, Krzysztof Kozlowski wrote:
> On 16/03/2023 04:05, Xingyu Wu wrote:
>> Add optional compatible and patternProperties.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 39 ++++++++++++++++---
>>  1 file changed, 33 insertions(+), 6 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> index ae7f1d6916af..b61d8921ef42 100644
>> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> @@ -15,16 +15,31 @@ description: |
>>  
>>  properties:
>>    compatible:
>> -    items:
>> -      - enum:
>> -          - starfive,jh7110-aon-syscon
>> -          - starfive,jh7110-stg-syscon
>> -          - starfive,jh7110-sys-syscon
>> -      - const: syscon
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - starfive,jh7110-aon-syscon
>> +              - starfive,jh7110-stg-syscon
>> +              - starfive,jh7110-sys-syscon
>> +          - const: syscon
>> +      - items:
>> +          - enum:
>> +              - starfive,jh7110-aon-syscon
>> +              - starfive,jh7110-stg-syscon
>> +              - starfive,jh7110-sys-syscon
>> +          - const: syscon
>> +          - const: simple-mfd
>>  
>>    reg:
>>      maxItems: 1
>>  
>> +patternProperties:
>> +  # Optional children
>> +  "pll-clock-controller":
> 
> It's not a pattern.

Does it use 'properties' instead of 'patternProperties'?

> 
> Anyway should be clock-controller

Will fix.

> 
>> +    type: object
>> +    $ref: /schemas/clock/starfive,jh7110-pll.yaml#
>> +    description: Clock provider for PLL.
>> +
> 
> You just added these bindings! So the initial submission was incomplete
> on purpose?
> 
> No, add complete bindings.

Does you mean that it should drop the 'description', or add complete 'description',
or add 'compatible', 'clocks' and 'clock-cells' of complete clock-controller bindings?

> 
>>  required:
>>    - compatible
>>    - reg
>> @@ -38,4 +53,16 @@ examples:
>>          reg = <0x10240000 0x1000>;
>>      };
>>  
>> +  - |
>> +    syscon@13030000 {
> 
> No need for new example... Just put it in existing one.
> 

Actually, the PLL clock-controller are just set in sys-syscon resgisters. The stg-syscon and
aon-syscon don't need it. So PLL clock-controller node only is added in sys-syscon node.

Best regards,
Xingyu Wu
