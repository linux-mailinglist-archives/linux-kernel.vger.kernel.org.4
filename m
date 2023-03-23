Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A026C6101
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCWHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCWHoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:44:55 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865719C4E;
        Thu, 23 Mar 2023 00:44:50 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0B5F324E1BE;
        Thu, 23 Mar 2023 15:44:43 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Mar
 2023 15:44:43 +0800
Received: from [192.168.125.74] (183.27.97.64) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Mar
 2023 15:44:42 +0800
Message-ID: <5b75161e-3d0d-50e5-fd4e-af92edf62317@starfivetech.com>
Date:   Thu, 23 Mar 2023 15:44:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 11/21] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
 <20230320103750.60295-12-hal.feng@starfivetech.com>
 <b4beb457-8581-4b2f-8655-2e3f82a94f75@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <b4beb457-8581-4b2f-8655-2e3f82a94f75@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 21:53:37 +0000, Conor Dooley wrote:
> Hey Hal,
> 
> On Mon, Mar 20, 2023 at 06:37:40PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Add bindings for the system clock and reset generator (SYSCRG) on the
>> JH7110 RISC-V SoC by StarFive Ltd.
>> 
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../clock/starfive,jh7110-syscrg.yaml         | 104 +++++++++
>>  MAINTAINERS                                   |   8 +-
>>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 203 ++++++++++++++++++
>>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
>>  4 files changed, 454 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> new file mode 100644
>> index 000000000000..84373ae31644
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> @@ -0,0 +1,104 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-syscrg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 System Clock and Reset Generator
>> +
>> +maintainers:
>> +  - Emil Renner Berthing <kernel@esmil.dk>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-syscrg
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    oneOf:
>> +      - items:
>> +          - description: Main Oscillator (24 MHz)
>> +          - description: GMAC1 RMII reference or GMAC1 RGMII RX
>> +          - description: External I2S TX bit clock
>> +          - description: External I2S TX left/right channel clock
>> +          - description: External I2S RX bit clock
>> +          - description: External I2S RX left/right channel clock
>> +          - description: External TDM clock
>> +          - description: External audio master clock
>> +
>> +      - items:
>> +          - description: Main Oscillator (24 MHz)
>> +          - description: GMAC1 RMII reference
>> +          - description: GMAC1 RGMII RX
>> +          - description: External I2S TX bit clock
>> +          - description: External I2S TX left/right channel clock
>> +          - description: External I2S RX bit clock
>> +          - description: External I2S RX left/right channel clock
>> +          - description: External TDM clock
>> +          - description: External audio master clock
>> +
>> +  clock-names:
>> +    oneOf:
>> +      - items:
>> +          - const: osc
>> +          - enum:
>> +              - gmac1_rmii_refin
>> +              - gmac1_rgmii_rxin
>> +          - const: i2stx_bclk_ext
>> +          - const: i2stx_lrck_ext
>> +          - const: i2srx_bclk_ext
>> +          - const: i2srx_lrck_ext
>> +          - const: tdm_ext
>> +          - const: mclk_ext
>> +
>> +      - items:
>> +          - const: osc
>> +          - const: gmac1_rmii_refin
>> +          - const: gmac1_rgmii_rxin
>> +          - const: i2stx_bclk_ext
>> +          - const: i2stx_lrck_ext
>> +          - const: i2srx_bclk_ext
>> +          - const: i2srx_lrck_ext
>> +          - const: tdm_ext
>> +          - const: mclk_ext
> 
> I'm sorry to be a bit of a bore about these bindings, but Emil mentioned
> to me today that he had some doubts about whether any of these audio
> clocks are actually required.
> I've had a bit of a look at the driver, cos the TRM that I have doesn't
> describe the clock tree (from what recall at least) and I think he is
> right.
> For example, the TDM clock:
> +	JH71X0_GATE(JH7110_SYSCLK_TDM_AHB, "tdm_ahb", 0, JH7110_SYSCLK_AHB0),
> +	JH71X0_GATE(JH7110_SYSCLK_TDM_APB, "tdm_apb", 0, JH7110_SYSCLK_APB0),
> +	JH71X0_GDIV(JH7110_SYSCLK_TDM_INTERNAL, "tdm_internal", 0, 64, JH7110_SYSCLK_MCLK),
> +	JH71X0__MUX(JH7110_SYSCLK_TDM_TDM, "tdm_tdm", 2,
> +		    JH7110_SYSCLK_TDM_INTERNAL,
> +		    JH7110_SYSCLK_TDM_EXT),
> 
> Hopefully, I'm not making a balls of something here, but it looks like I
> can choose an internal TDM clock, that is based on JH7110_SYSCLK_MCLK,
> which in turn comes from either an internal or external source.
> If I am following correctly, that'd be:
> +	JH71X0__DIV(JH7110_SYSCLK_MCLK_INNER, "mclk_inner", 64, JH7110_SYSCLK_AUDIO_ROOT),
> 
> Which in turn comes from:
> +	JH71X0__DIV(JH7110_SYSCLK_AUDIO_ROOT, "audio_root", 8, JH7110_SYSCLK_PLL2_OUT),
> 
> This leaves me wondering which clocks are *actually* required for a
> functioning system - is it actually just osc and one of gmac1_rmii_refin
> or gmac1_rgmii_rxin.

As I had mentioned somewhere before, some audio clocks need to change their
parents at different stages of work. I should explain in detail here.

For the i2s*_ext clocks, we should use these external clocks as parents when
the I2S module is working in the slave mode, while we should use the internal
clocks as parents when the I2S module is working in the master mode.

For the tdm_ext clock, we use it as the clock source for an accurate playback
rate. If we use the internal clock as clock source, the TDM can't work
normally, because it can't get a required rate from the internal divider.
By the way, note that we need to use the internal clock as clock source when
we try to reset the tdm clock, otherwise, the reset will fail.

For the mclk_ext clock, which is 12.288MHz, it's used as the clock source
through all the running time, otherwise, the daughter clocks can't get the
required rate from the internal PLL2 clock (1188MHz) through dividers.

So all these audio external clocks (i2s*_ext / tdm_ext / mclk_ext) are
actually required.

Best regards,
Hal

> 
> I really don't want you to have to go and spell out every combination of
> clocks to have some sort of validation here.
> 
> Stephen, Rob or Krzysztof, do you have any guidance on this situation
> (assuming I've not made a fool of myself)? There's probably something
> "obvious" that I'm missing, as I am sure this is not a unique problem.
> 
> Cheers,
> Conor.
> 
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +    description:
>> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +    description:
>> +      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@13020000 {
>> +        compatible = "starfive,jh7110-syscrg";
>> +        reg = <0x13020000 0x10000>;
>> +        clocks = <&osc>, <&gmac1_rmii_refin>,
>> +                 <&gmac1_rgmii_rxin>,
>> +                 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
>> +                 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
>> +                 <&tdm_ext>, <&mclk_ext>;
>> +        clock-names = "osc", "gmac1_rmii_refin",
>> +                      "gmac1_rgmii_rxin",
>> +                      "i2stx_bclk_ext", "i2stx_lrck_ext",
>> +                      "i2srx_bclk_ext", "i2srx_lrck_ext",
>> +                      "tdm_ext", "mclk_ext";
>> +        #clock-cells = <1>;
>> +        #reset-cells = <1>;
>> +    };

