Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8061C747BDA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 05:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGEDhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 23:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEDhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 23:37:50 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DC1A2;
        Tue,  4 Jul 2023 20:37:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6E85B24E24B;
        Wed,  5 Jul 2023 11:37:41 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Jul
 2023 11:37:41 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Jul
 2023 11:37:40 +0800
Message-ID: <c5027d42-b9be-090d-bd43-86c9b1448c99@starfivetech.com>
Date:   Wed, 5 Jul 2023 11:37:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND v1 1/2] dt-binding: spi: constrain minItems of clocks and
 clock-names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-2-william.qiu@starfivetech.com>
 <1b65e8d1-d5e1-0d6b-1248-d9683be44db8@linaro.org>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <1b65e8d1-d5e1-0d6b-1248-d9683be44db8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/4 17:38, Krzysztof Kozlowski wrote:
> On 04/07/2023 11:21, William Qiu wrote:
>> The SPI controller only need apb_pclk clock to work properly on JH7110 SoC,
>> so there add minItems whose value is equal to 1. Other platforms do not
>> have this constraint.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> 
> I don't get why this is resent, but subject prefix is still wrong. It's
> dt-bindings.
> 
Will update.
>> ---
>>  Documentation/devicetree/bindings/spi/spi-pl022.yaml | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>> index 91e540a92faf..42bb34c39971 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
>> @@ -11,6 +11,7 @@ maintainers:
>> 
>>  allOf:
>>    - $ref: spi-controller.yaml#
>> +  - $ref: /schemas/arm/primecell.yaml#
> 
> This looks unrelated, so keep it as separate commit with its own rationale.
> 
Because "arm,primecell-periphid"  is need in JH7110 SoC, so I added them in
one commit, so do I need to put them in two commit?
>> 
>>  # We need a select here so we don't match all nodes with 'arm,primecell'
>>  select:
>> @@ -34,12 +35,16 @@ properties:
>>      maxItems: 1
>> 
>>    clocks:
>> +    minItems: 1
>>      maxItems: 2
>> 
>>    clock-names:
>> -    items:
>> -      - const: sspclk
>> -      - const: apb_pclk
>> +    oneOf:
>> +      - items:
>> +          - const: apb_pclk
>> +      - items:
>> +          - const: sspclk
>> +          - const: apb_pclk
> 
> Are you sure that your clock is APB pclk in such case?
> 
Yes, in JH7110 SoC is APB pclk in such case.

Thanks for taking time to review this patch series.
> Best regards,
> Krzysztof
> 
