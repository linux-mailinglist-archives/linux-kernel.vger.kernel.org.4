Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85485637249
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKXGRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKXGRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:17:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6007654FA;
        Wed, 23 Nov 2022 22:16:58 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3AB2624E20A;
        Thu, 24 Nov 2022 14:16:57 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Nov
 2022 14:16:57 +0800
Received: from [192.168.125.106] (183.27.97.81) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Nov
 2022 14:16:56 +0800
Message-ID: <049f07d3-3e1c-3f52-e125-671f66bc432e@starfivetech.com>
Date:   Thu, 24 Nov 2022 14:17:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 7/8] riscv: dts: starfive: Add StarFive JH7110
 VisionFive2 board device tree
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-8-hal.feng@starfivetech.com>
 <CAJM55Z-rdicV69otq=YFsTSUNsg==Svf18b+3w-cMfb_BYcbGg@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z-rdicV69otq=YFsTSUNsg==Svf18b+3w-cMfb_BYcbGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 01:55:40 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:17, Hal Feng <hal.feng@starfivetech.com> wrote:
>>
>> From: Emil Renner Berthing <kernel@esmil.dk>
>>
>> Add a minimal device tree for StarFive JH7110 VisionFive2 board.
> Missing space between VisionFive and 2.

Will fix accordingly.

> 
>> Support booting and basic clock/reset/pinctrl/uart drivers.
>>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  arch/riscv/boot/dts/starfive/Makefile         |   1 +
>>  .../jh7110-starfive-visionfive-v2.dts         | 116 ++++++++++++++++++
>>  2 files changed, 117 insertions(+)
>>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>>
>> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
>> index 0ea1bc15ab30..e1237dbc6aac 100644
>> --- a/arch/riscv/boot/dts/starfive/Makefile
>> +++ b/arch/riscv/boot/dts/starfive/Makefile
>> @@ -1,2 +1,3 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  dtb-$(CONFIG_SOC_STARFIVE) += jh7100-beaglev-starlight.dtb
>> +dtb-$(CONFIG_SOC_STARFIVE) += jh7110-starfive-visionfive-v2.dtb
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> new file mode 100644
>> index 000000000000..c8946cf3a268
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>> +/*
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + */
>> +
>> +/dts-v1/;
>> +#include "jh7110.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
>> +
>> +/ {
>> +       model = "StarFive VisionFive V2";
>> +       compatible = "starfive,visionfive-v2", "starfive,jh7110";
> 
> Again, please consult your colleagues if you're calling the board
> "VisionFive 2" or "VisionFive V2" and name the file, model and board
> accordingly.

Will fix accordingly. Please see the record of patch 1.

> 
>> +       aliases {
>> +               serial0 = &uart0;
>> +       };
>> +
>> +       chosen {
>> +               linux,initrd-start = <0x46100000>;
>> +               linux,initrd-end = <0x4c000000>;
> 
> These two lines don't belong here. They're added by the bootloader dynamically.

OK, will delete. Thanks.

> 
>> +               stdout-path = "serial0:115200";
> 
> You're missing a n8.

Will fix.

> 
>> +       };
>> +
>> +       cpus {
>> +               timebase-frequency = <4000000>;
>> +       };
>> +
>> +       memory@40000000 {
>> +               device_type = "memory";
>> +               reg = <0x0 0x40000000 0x1 0x0>;
>> +       };
>> +
>> +       gpio-restart {
>> +               compatible = "gpio-restart";
>> +               gpios = <&gpio 35 GPIO_ACTIVE_HIGH>;
>> +               priority = <224>;
>> +       };
>> +};
>> +
>> +&osc {
>> +       clock-frequency = <24000000>;
>> +};
>> +
>> +&clk_rtc {
>> +       clock-frequency = <32768>;
>> +};
>> +
>> +&gmac0_rmii_refin {
>> +       clock-frequency = <50000000>;
>> +};
>> +
>> +&gmac0_rgmii_rxin {
>> +       clock-frequency = <125000000>;
>> +};
>> +
>> +&gmac1_rmii_refin {
>> +       clock-frequency = <50000000>;
>> +};
>> +
>> +&gmac1_rgmii_rxin {
>> +       clock-frequency = <125000000>;
>> +};
>> +
>> +&i2stx_bclk_ext {
>> +       clock-frequency = <12288000>;
>> +};
>> +
>> +&i2stx_lrck_ext {
>> +       clock-frequency = <192000>;
>> +};
>> +
>> +&i2srx_bclk_ext {
>> +       clock-frequency = <12288000>;
>> +};
>> +
>> +&i2srx_lrck_ext {
>> +       clock-frequency = <192000>;
>> +};
>> +
>> +&tdm_ext {
>> +       clock-frequency = <49152000>;
>> +};
>> +
>> +&mclk_ext {
>> +       clock-frequency = <12288000>;
>> +};
>> +
>> +&gpio {
>> +       uart0_pins: uart0-0 {
>> +               tx-pins {
>> +                       pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX, GPOEN_ENABLE, GPI_NONE)>;
>> +                       bias-disable;
>> +                       drive-strength = <12>;
>> +                       input-disable;
>> +                       input-schmitt-disable;
>> +                       slew-rate = <0>;
>> +               };
>> +
>> +               rx-pins {
>> +                       pinmux = <GPIOMUX(6, GPOUT_LOW, GPOEN_DISABLE, GPI_SYS_UART0_RX)>;
>> +                       bias-pull-up;
> 
> There are external pull-ups, so maybe change this line to
> 
> bias-disable; /* external pull-up */

Good job. Will fix it later.

Best regards,
Hal

> 
>> +                       drive-strength = <2>;
>> +                       input-enable;
>> +                       input-schmitt-enable;
>> +                       slew-rate = <0>;
>> +               };
>> +       };
>> +};
>> +
>> +&uart0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&uart0_pins>;
>> +       status = "okay";
>> +};

