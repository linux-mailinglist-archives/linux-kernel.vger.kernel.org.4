Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5066BA66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjAPJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjAPJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:32:39 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531A6A50;
        Mon, 16 Jan 2023 01:31:46 -0800 (PST)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 16 Jan
 2023 17:31:44 +0800
Message-ID: <7c0133a2-ea4d-645e-3df2-2bb832bbd498@amlogic.com>
Date:   Mon, 16 Jan 2023 17:31:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V6 1/3] dt-bindings: clock: document Amlogic S4 SoC PLL &
 peripheral clock controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-2-yu.tu@amlogic.com>
 <02b6b3a6-e2ad-8cbc-fa15-fbd2db6ada64@linaro.org>
Content-Language: en-US
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <02b6b3a6-e2ad-8cbc-fa15-fbd2db6ada64@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
	Thank you for your quick reply.

On 2023/1/16 16:29, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 16/01/2023 08:42, Yu Tu wrote:
>> Add the S4 PLL & peripheral clock controller dt-bindings in the s4 SoC
>> family.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   .../clock/amlogic,s4-peripherals-clkc.yaml    | 104 ++++++++++++++
>>   .../bindings/clock/amlogic,s4-pll-clkc.yaml   |  50 +++++++
>>   MAINTAINERS                                   |   1 +
>>   .../clock/amlogic,s4-peripherals-clkc.h       | 131 ++++++++++++++++++
>>   .../dt-bindings/clock/amlogic,s4-pll-clkc.h   |  30 ++++
>>   5 files changed, 316 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>>   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>>   create mode 100644 include/dt-bindings/clock/amlogic,s4-pll-clkc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> new file mode 100644
>> index 000000000000..2deeff497754
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>> @@ -0,0 +1,104 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Meson S serials Peripherals Clock Controller
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Yu Tu <yu.tu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,s4-peripherals-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: input fixed pll div2
>> +      - description: input fixed pll div2p5
>> +      - description: input fixed pll div3
>> +      - description: input fixed pll div4
>> +      - description: input fixed pll div5
>> +      - description: input fixed pll div7
>> +      - description: input hifi pll
>> +      - description: input gp0 pll
>> +      - description: input mpll0
>> +      - description: input mpll1
>> +      - description: input mpll2
>> +      - description: input mpll3
>> +      - description: input hdmi pll
>> +      - description: input oscillator (usually at 24MHz)
>> +      - description: input external 32kHz reference (optional)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: fclk_div2
>> +      - const: fclk_div2p5
>> +      - const: fclk_div3
>> +      - const: fclk_div4
>> +      - const: fclk_div5
>> +      - const: fclk_div7
>> +      - const: hifi_pll
>> +      - const: gp0_pll
>> +      - const: mpll0
>> +      - const: mpll1
>> +      - const: mpll2
>> +      - const: mpll3
>> +      - const: hdmi_pll
>> +      - const: xtal
>> +      - const: ext_32k
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>> +
>> +    /* 32KHz reference crystal */
>> +    ext_32k: ref32k {
>> +        compatible = "fixed-clock";
>> +        #clock-cells = <0>;
>> +        clock-frequency = <32000>;
>> +    };
> 
> This wasn't here before. Drop it. It is trivial and it is not needed to
> illustrate your device bindings. All clock bindings use it...
> 

I'm fine with that. I don't know if Jerome agrees with that. Wait for 
him. See what he says.

>> +
>> +    clkc_periphs: clock-controller@fe000000 {
>> +      compatible = "amlogic,s4-peripherals-clkc";
>> +      reg = <0xfe000000 0x49c>;
>> +      clocks = <&clkc_pll 3>,
>> +              <&clkc_pll 13>,
>> +              <&clkc_pll 5>,
>> +              <&clkc_pll 7>,
>> +              <&clkc_pll 9>,
>> +              <&clkc_pll 11>,
>> +              <&clkc_pll 17>,
>> +              <&clkc_pll 15>,
>> +              <&clkc_pll 25>,
>> +              <&clkc_pll 27>,
>> +              <&clkc_pll 29>,
>> +              <&clkc_pll 31>,
>> +              <&clkc_pll 20>,
>> +              <&xtal>,
>> +              <&ext_32k>;
>> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
>> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
>> +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
>> +                    "ext_32k";
>> +      #clock-cells = <1>;
>> +    };
>> +...
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>> new file mode 100644
>> index 000000000000..aeda4861cebe
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/amlogic,s4-pll-clkc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Amlogic Meson S serials PLL Clock Controller
>> +
>> +maintainers:
>> +  - Neil Armstrong <neil.armstrong@linaro.org>
>> +  - Jerome Brunet <jbrunet@baylibre.com>
>> +  - Yu Tu <yu.tu@amlogic.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,s4-pll-clkc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xtal
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#clock-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clkc_pll: clock-controller@fe008000 {
>> +      compatible = "amlogic,s4-pll-clkc";
>> +      reg = <0xfe008000 0x1e8>;
>> +      clocks = <&xtal>;
>> +      clock-names = "xtal";
>> +      #clock-cells = <1>;
>> +    };
>> +
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f61eb221415b..26c82beeffda 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1897,6 +1897,7 @@ L:	linux-amlogic@lists.infradead.org
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/clock/amlogic*
>>   F:	drivers/clk/meson/
>> +F:	include/dt-bindings/clock/amlogic*
>>   F:	include/dt-bindings/clock/gxbb*
>>   F:	include/dt-bindings/clock/meson*
>>   
>> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> new file mode 100644
>> index 000000000000..bbec5094d5c3
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
>> @@ -0,0 +1,131 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 
> Unusual license... are you sure to license the bindings under GPLv4 or
> GPLv5? Fine by me.
> 

Yes.

> Best regards,
> Krzysztof
> 
