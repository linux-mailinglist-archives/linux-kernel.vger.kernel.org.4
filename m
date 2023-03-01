Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CFB6A6590
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCACfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCACfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:35:18 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19DD32CE2;
        Tue, 28 Feb 2023 18:35:13 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 52CF324E348;
        Wed,  1 Mar 2023 10:35:11 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Mar
 2023 10:35:11 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Mar
 2023 10:35:10 +0800
Message-ID: <a8173cc6-e484-a264-2257-48c1677abce0@starfivetech.com>
Date:   Wed, 1 Mar 2023 10:35:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: PWM: Add StarFive PWM module
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230228091345.70515-1-william.qiu@starfivetech.com>
 <20230228091345.70515-2-william.qiu@starfivetech.com>
 <af5fa75b-1831-67cc-f644-33adfd2e1031@linaro.org>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <af5fa75b-1831-67cc-f644-33adfd2e1031@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/28 22:07, Krzysztof Kozlowski wrote:
> On 28/02/2023 10:13, William Qiu wrote:
>> Add documentation to describe StarFive Pulse Width Modulation
>> controller driver.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-starfive.yaml | 54 +++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-starfive.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-starfive.yaml b/Documentation/devicetree/bindings/pwm/pwm-starfive.yaml
>> new file mode 100644
>> index 000000000000..4ba2a8cc5344
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-starfive.yaml
> 
> Filename based on compatible, so starfive,jh7110-pwm.yaml
> 
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/pwm-starfive.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive PWM controller
>> +
>> +maintainers:
>> +  - William Qiu <william.qiu@starfivetech.com>
>> +
>> +description:
>> +  StarFive SoCs contain PWM and when operating in PWM mode, the PTC core generates
>> +  binary signal with user-programmable low and high periods. Clock source for the
>> +  PWM can be either system clockor external clock. Each PWM timer block provides 8
>> +  PWM channels.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> Drop items, not a list in your case.
> 

Will drop. Thanks for taking time reviewing this patch series.

Best regards
William
>> +      - const: starfive,jh7110-pwm
>> +
> 
> 
> Best regards,
> Krzysztof
> 
