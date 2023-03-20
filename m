Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC86C0B68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCTHcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 03:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCTHca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:32:30 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E167923327;
        Mon, 20 Mar 2023 00:32:17 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5D21524E269;
        Mon, 20 Mar 2023 15:32:16 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 15:32:16 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 15:32:15 +0800
Message-ID: <d0b1d44e-6d6e-536c-046e-be6a53f1d240@starfivetech.com>
Date:   Mon, 20 Mar 2023 15:32:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND v6 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-2-william.qiu@starfivetech.com>
 <850bc37e-c6d1-2381-a851-965a4cbee8a0@linaro.org>
 <e38efd81-9c79-553b-7556-7aff30f6ec50@starfivetech.com>
 <f25cc55e-3405-4b17-fb45-5ae5eb36a404@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <f25cc55e-3405-4b17-fb45-5ae5eb36a404@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/20 14:38, Krzysztof Kozlowski wrote:
> On 20/03/2023 06:54, William Qiu wrote:
>> 
>> 
>> On 2023/3/19 20:27, Krzysztof Kozlowski wrote:
>>> On 15/03/2023 06:58, William Qiu wrote:
>>>> Add documentation to describe StarFive System Controller Registers.
>>>>
>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>> ---
>>>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 41 +++++++++++++++++++
>>>>  MAINTAINERS                                   |  5 +++
>>>>  2 files changed, 46 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>> new file mode 100644
>>>> index 000000000000..ae7f1d6916af
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>>> @@ -0,0 +1,41 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: StarFive JH7110 SoC system controller
>>>> +
>>>> +maintainers:
>>>> +  - William Qiu <william.qiu@starfivetech.com>
>>>> +
>>>> +description: |
>>>> +  The StarFive JH7110 SoC system controller provides register information such
>>>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - starfive,jh7110-aon-syscon
>>>> +          - starfive,jh7110-stg-syscon
>>>> +          - starfive,jh7110-sys-syscon
>>>> +      - const: syscon
>>>
>>> Does not look like you tested the bindings. Please run `make
>>> dt_binding_check` (see
>>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>>>
>>> ... or your PLL clock controller was not tested.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi Krzysztof,
>> 
>> I've already done`make dt_binding_check`, and get no error. So maybe PLL clock controller
>> was not tested which I didn't add in this patch series. And PLL clock controller belongs
>> to Xingyu Wu, I would tell him.
> 
> What's confusing you do not allow here clock controller.
> 
> Best regards,
> Krzysztof
> 
I'll add it then.

Best regards
William
