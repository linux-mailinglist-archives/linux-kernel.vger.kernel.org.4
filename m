Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC36DAAE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjDGJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjDGJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:30:41 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50A902D;
        Fri,  7 Apr 2023 02:30:35 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 319A924E245;
        Fri,  7 Apr 2023 17:30:33 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 17:30:33 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 17:30:32 +0800
Message-ID: <2ce35d68-ae6c-129f-588e-9b292de3a654@starfivetech.com>
Date:   Fri, 7 Apr 2023 17:30:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
References: <20230406103308.1280860-1-william.qiu@starfivetech.com>
 <20230406103308.1280860-2-william.qiu@starfivetech.com>
 <833b68a5-263d-d293-4910-2ca50b43e60d@linaro.org>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <833b68a5-263d-d293-4910-2ca50b43e60d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/7 2:30, Krzysztof Kozlowski wrote:
> On 06/04/2023 12:33, William Qiu wrote:
>> Add documentation to describe StarFive System Controller Registers.
> 
> Subject: drop second/last, redundant "doc". The "dt-bindings" prefix is
> already stating that these are documentation files.
> 
Will fix.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 56 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 ++
>>  2 files changed, 61 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> new file mode 100644
>> index 000000000000..0d0319426b67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 SoC system controller
>> +
>> +maintainers:
>> +  - William Qiu <william.qiu@starfivetech.com>
>> +
>> +description: |
>> +  The StarFive JH7110 SoC system controller provides register information such
>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - starfive,jh7110-aon-syscon
>> +              - starfive,jh7110-sys-syscon
>> +          - const: syscon
>> +          - const: simple-mfd
>> +      - items:
>> +          - const: starfive,jh7110-stg-syscon
>> +          - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clock-controller:
>> +    type: object
> 
> This should be rather specific schema, so $ref.
> 

This would be $ref: /schemas/clock/starfive,jh7110-pll.yaml#, but this file is not
available at present,  so I would like to ask if I should submit the documents
instead of Xingyu


>> +
>> +  power-controller:
>> +    type: object
> 
Will fix, it would be $ref: /schemas/power/starfive,jh7110-pmu.yaml#.

Best regards,
William
> Same problem.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    syscon@10240000 {
>> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
>> +        reg = <0x10240000 0x1000>;
>> +    };
>> +
>> +    syscon@13030000 {
>> +        compatible = "starfive,jh7110-sys-syscon", "syscon", "simple-mfd";
>> +        reg = <0x13030000 0x1000>;
>> +    };
> Best regards,
> Krzysztof
> 
