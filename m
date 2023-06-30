Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B844743254
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF3Bmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjF3Bmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:42:50 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7198230DF;
        Thu, 29 Jun 2023 18:42:44 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 419057FD3;
        Fri, 30 Jun 2023 09:42:32 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 30 Jun
 2023 09:42:32 +0800
Received: from [192.168.125.93] (183.27.97.206) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 30 Jun
 2023 09:42:31 +0800
Message-ID: <ebb6c688-1a96-5167-2e50-ee18ebd0a5d7@starfivetech.com>
Date:   Fri, 30 Jun 2023 09:42:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: Add StarFive JH7110 dummy
 PWM-DAC transmitter
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-2-hal.feng@starfivetech.com>
 <92171465-d2ba-c3ba-aa55-0f705e924a0f@linaro.org>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <92171465-d2ba-c3ba-aa55-0f705e924a0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.206]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 17:32:04 +0200, Krzysztof Kozlowski wrote:
> On 26/06/2023 13:09, Hal Feng wrote:
>> Add bindings for StarFive JH7110 dummy PWM-DAC transmitter.
>> 
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../sound/starfive,jh7110-pwmdac-dit.yaml     | 38 +++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
>> new file mode 100644
>> index 000000000000..bc43e3b1e9d2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/starfive,jh7110-pwmdac-dit.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/starfive,jh7110-pwmdac-dit.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 Dummy PWM-DAC Transmitter
>> +
>> +maintainers:
>> +  - Hal Feng <hal.feng@starfivetech.com>
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-pwmdac-dit
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +  sound-name-prefix: true
> 
> Drop

Will fix it.

> 
>> +
>> +required:
>> +  - compatible
>> +  - "#sound-dai-cells"
>> +
>> +additionalProperties: false
> 
> Instead: unevaluatedProperties: false

Will fix. Thanks.

>> +
>> +examples:
>> +  - |
>> +    pwmdac-dit {
> 
> pwmdac?

No. For a similar implementation, you can refer to "spdif-dit" in

arch/arm64/boot/dts/rockchip/rk3328-rock64.dts

Best regards,
Hal
