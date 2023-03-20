Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CD6C0CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCTJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjCTJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:16:38 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC17E13DFE;
        Mon, 20 Mar 2023 02:16:36 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9508024E1B5;
        Mon, 20 Mar 2023 17:16:29 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 17:16:29 +0800
Received: from [192.168.125.128] (183.27.97.64) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 17:16:28 +0800
Message-ID: <e3604902-2b7d-6ca5-9523-04dc09c920ed@starfivetech.com>
Date:   Mon, 20 Mar 2023 17:16:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/6] dt-bindings: soc: starfive: syscon: Add optional
 patternProperties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>
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
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
 <20230316030514.137427-4-xingyu.wu@starfivetech.com>
 <1f352445-4677-e33b-be14-c76bd7ffa188@linaro.org>
 <45221a1c-dc01-2759-3e32-658636625529@starfivetech.com>
 <a6b9bab2-4151-c811-85ff-2424866e21d8@linaro.org>
 <ce674ea9-41ec-2862-c39c-207f0b6c45a2@starfivetech.com>
 <a65697f4-0a75-23e2-517c-2784b0c382bc@linaro.org>
 <2eb0380e-bbb7-83fd-3916-9bdd8b068334@starfivetech.com>
 <8c5a7421-2948-674d-91a0-9cafe336401b@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <8c5a7421-2948-674d-91a0-9cafe336401b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/20 16:36, Krzysztof Kozlowski wrote:
> On 20/03/2023 09:26, Xingyu Wu wrote:
>> On 2023/3/20 15:40, Krzysztof Kozlowski wrote:
>>> On 20/03/2023 08:29, Xingyu Wu wrote:
>>>> On 2023/3/20 14:37, Krzysztof Kozlowski wrote:
>>>>> On 20/03/2023 04:54, Xingyu Wu wrote:
>>>>>> On 2023/3/19 20:28, Krzysztof Kozlowski wrote:
>>>>>>> On 16/03/2023 04:05, Xingyu Wu wrote:
>>>>>>>> Add optional compatible and patternProperties.
>>>>>>>>
>>>>>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>>>>> ---
>>>>>>>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 39 ++++++++++++++++---
>>>>>>>>  1 file changed, 33 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>>>>> index ae7f1d6916af..b61d8921ef42 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>>>>> @@ -15,16 +15,31 @@ description: |
>>>>>>>>  
>>>>>>>>  properties:
>>>>>>>>    compatible:
>>>>>>>> -    items:
>>>>>>>> -      - enum:
>>>>>>>> -          - starfive,jh7110-aon-syscon
>>>>>>>> -          - starfive,jh7110-stg-syscon
>>>>>>>> -          - starfive,jh7110-sys-syscon
>>>>>>>> -      - const: syscon
>>>>>>>> +    oneOf:
>>>>>>>> +      - items:
>>>>>>>> +          - enum:
>>>>>>>> +              - starfive,jh7110-aon-syscon
>>>>>>>> +              - starfive,jh7110-stg-syscon
>>>>>>>> +              - starfive,jh7110-sys-syscon
>>>>>>>> +          - const: syscon
>>>>>>>> +      - items:
>>>>>>>> +          - enum:
>>>>>>>> +              - starfive,jh7110-aon-syscon
>>>>>>>> +              - starfive,jh7110-stg-syscon
>>>>>>>> +              - starfive,jh7110-sys-syscon
>>>>>>>> +          - const: syscon
>>>>>>>> +          - const: simple-mfd
>>>
>>> BTW, this also looks wrong. You just said that clock controller exists
>>> only in few variants. Also, why sometimes the same device  goes with
>>> simple-mfd and sometimies without? It's the same device.
>> 
>> Oh yes, If modified to:
>> 
>> oneOf:
>>       - items:
>>           - enum:
>>               - starfive,jh7110-aon-syscon
>>               - starfive,jh7110-stg-syscon
>>           - const: syscon
>>       - items:
>>           - const: starfive,jh7110-sys-syscon
>>           - const: syscon
>>           - const: simple-mfd
>> 
>> Or:
>> 
>>      - minItems: 2
>>        items:
>>          - enum:
>>              - starfive,jh7110-aon-syscon
>>              - starfive,jh7110-stg-syscon
>>              - starfive,jh7110-sys-syscon
>>          - const: syscon
>>          - const: simple-mfd
>> 
>> 
>> Which one is better?
> 
> If aon and stg are not supposed to have children, then only the first is
> correct. It's not which is better, the second is not really correct in
> such case.
> 

OK, will modify it in next version. Thanks.

Best regards,
Xingyu Wu

