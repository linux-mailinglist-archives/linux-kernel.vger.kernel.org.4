Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7528F6EF2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbjDZKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbjDZKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:56 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E715260;
        Wed, 26 Apr 2023 03:49:49 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id A396D5FD7C;
        Wed, 26 Apr 2023 13:49:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682506187;
        bh=IH3YamOzLQv1Nj0YgkBPSG4+d92jT6kWcYeExBHgq9g=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=nADzFakiFOt9+0UeJf3hyK3Bt7ErYNmtKAmIsI6Sgjucb6p/yzwzFVWQRT9u4qKPl
         maSM5dv99oqUHnveu7gy9A3twHRFoj2QfawshslPa8Bau5QK0lSHReLap0wBlxdnAb
         5PUyRX3To3FpdSA5erZrKkw9EpcI0VDA0TAjg3sr2vwHBHcQ25fmrNV+3fkGZEAwp2
         GffMsyn9HGldNL6PbJuTDMXvtBTXxjzkPObPloRC2cccfgHxsVJcMB5mAOW4dnouJn
         LH+ZhzL2p185R7us/KS9PVl7oxteYCN/q07iJg9DGhmc1CMrqotayP1vdk4V4Y4+X5
         FCJkkiIETNfVQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 13:49:47 +0300 (MSK)
Date:   Wed, 26 Apr 2023 13:49:46 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Yu Tu <yu.tu@amlogic.com>
CC:     <linux-clk@vger.kernel.org>,
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
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>
Subject: Re: [PATCH V7 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Message-ID: <20230426104946.xiwsdjxris2faf7x@CAB-WSD-L081021>
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-3-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230417065005.24967-3-yu.tu@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/26 04:45:00 #21166225
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yu,

Thank you for the patch series! Please find my comments below.

On Mon, Apr 17, 2023 at 02:50:03PM +0800, Yu Tu wrote:
> Add the S4 peripherals clock controller dt-bindings in the s4 SoC
> family.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>  .../clock/amlogic,s4-peripherals-clkc.yaml    |  97 +++++++++++++
>  .../clock/amlogic,s4-peripherals-clkc.h       | 131 ++++++++++++++++++
>  2 files changed, 228 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
> new file mode 100644
> index 000000000000..46b969a16a7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson S serials Peripherals Clock Controller

As per my understanding, Meson is no longer applicable.
As Neil and Martin suggested in other reviews, the term 'Amlogic' should
be used instead or 'Meson' should be removed altogether.

> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Yu Tu <yu.tu@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,s4-peripherals-clkc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: input fixed pll div2
> +      - description: input fixed pll div2p5
> +      - description: input fixed pll div3
> +      - description: input fixed pll div4
> +      - description: input fixed pll div5
> +      - description: input fixed pll div7
> +      - description: input hifi pll
> +      - description: input gp0 pll
> +      - description: input mpll0
> +      - description: input mpll1
> +      - description: input mpll2
> +      - description: input mpll3
> +      - description: input hdmi pll
> +      - description: input oscillator (usually at 24MHz)
> +      - description: input external 32kHz reference (optional)
> +
> +  clock-names:
> +    items:
> +      - const: fclk_div2
> +      - const: fclk_div2p5
> +      - const: fclk_div3
> +      - const: fclk_div4
> +      - const: fclk_div5
> +      - const: fclk_div7
> +      - const: hifi_pll
> +      - const: gp0_pll
> +      - const: mpll0
> +      - const: mpll1
> +      - const: mpll2
> +      - const: mpll3
> +      - const: hdmi_pll
> +      - const: xtal
> +      - const: ext_32k
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
> +
> +    clkc_periphs: clock-controller@fe000000 {
> +      compatible = "amlogic,s4-peripherals-clkc";
> +      reg = <0xfe000000 0x49c>;

I was under the impression that reg as MMIO address should have four
cells on ARM64 architecture. Are you sure it only needs two cells?

> +      clocks = <&clkc_pll 3>,
> +              <&clkc_pll 13>,
> +              <&clkc_pll 5>,
> +              <&clkc_pll 7>,
> +              <&clkc_pll 9>,
> +              <&clkc_pll 11>,
> +              <&clkc_pll 17>,
> +              <&clkc_pll 15>,
> +              <&clkc_pll 25>,
> +              <&clkc_pll 27>,
> +              <&clkc_pll 29>,
> +              <&clkc_pll 31>,
> +              <&clkc_pll 20>,
> +              <&xtal>,
> +              <&ext_32k>;
> +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
> +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
> +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
> +                    "ext_32k";
> +      #clock-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> new file mode 100644
> index 000000000000..073396a76957
> --- /dev/null
> +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + * Author: Yu Tu <yu.tu@amlogic.com>
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
> +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
> +
> +/*
> + * CLKID index values
> + */
> +
> +#define CLKID_RTC_CLK			4

I believe that the CLK suffix is unnecessary since it is already clear
that the object in question is a clock. Additionally, it is redundant
to use the GATE suffix.

> +#define CLKID_SYS_CLK_B_GATE		7
> +#define CLKID_SYS_CLK_A_GATE		10
> +#define CLKID_SYS_CLK			11
> +#define CLKID_CECA_32K_CLKOUT		16
> +#define CLKID_CECB_32K_CLKOUT		21
> +#define CLKID_SC_CLK_GATE		24
> +#define CLKID_12_24M_CLK_SEL		27
> +#define CLKID_VID_PLL			30
> +#define CLKID_VCLK			37
> +#define CLKID_VCLK2			38
> +#define CLKID_VCLK_DIV1			39
> +#define CLKID_VCLK2_DIV1		44
> +#define CLKID_VCLK_DIV2			49
> +#define CLKID_VCLK_DIV4			50
> +#define CLKID_VCLK_DIV6			51
> +#define CLKID_VCLK_DIV12		52
> +#define CLKID_VCLK2_DIV2		53
> +#define CLKID_VCLK2_DIV4		54
> +#define CLKID_VCLK2_DIV6		55
> +#define CLKID_VCLK2_DIV12		56
> +#define CLKID_CTS_ENCI			61
> +#define CLKID_CTS_ENCP			62
> +#define CLKID_CTS_VDAC			63
> +#define CLKID_HDMI			67
> +#define CLKID_TS_CLK_GATE		69
> +#define CLKID_MALI_0			72
> +#define CLKID_MALI_1			75
> +#define CLKID_MALI			76
> +#define CLKID_VDEC_P0			79
> +#define CLKID_VDEC_P1			82
> +#define CLKID_VDEC_SEL			83
> +#define CLKID_HEVCF_P0			86
> +#define CLKID_HEVCF_P1			89
> +#define CLKID_HEVCF_SEL			90
> +#define CLKID_VPU_0			93
> +#define CLKID_VPU_1			96
> +#define CLKID_VPU			97
> +#define CLKID_VPU_CLKB_TMP		100
> +#define CLKID_VPU_CLKB			102
> +#define CLKID_VPU_CLKC_P0		105
> +#define CLKID_VPU_CLKC_P1		108
> +#define CLKID_VPU_CLKC_SEL		109
> +#define CLKID_VAPB_0			112
> +#define CLKID_VAPB_1			115
> +#define CLKID_VAPB			116
> +#define CLKID_GE2D			117
> +#define CLKID_VDIN_MEAS_GATE		120
> +#define CLKID_SD_EMMC_C_CLK		123
> +#define CLKID_SD_EMMC_A_CLK		126
> +#define CLKID_SD_EMMC_B_CLK		129
> +#define CLKID_SPICC0_GATE		132
> +#define CLKID_PWM_A_GATE		135
> +#define CLKID_PWM_B_GATE		138
> +#define CLKID_PWM_C_GATE		141
> +#define CLKID_PWM_D_GATE		144
> +#define CLKID_PWM_E_GATE		147
> +#define CLKID_PWM_F_GATE		150
> +#define CLKID_PWM_G_GATE		153
> +#define CLKID_PWM_H_GATE		156
> +#define CLKID_PWM_I_GATE		159
> +#define CLKID_PWM_J_GATE		162
> +#define CLKID_SARADC_GATE		165
> +#define CLKID_GEN_GATE			168
> +#define CLKID_DDR			169
> +#define CLKID_DOS			170
> +#define CLKID_ETHPHY			171
> +#define CLKID_MALI_GATE			172
> +#define CLKID_AOCPU			173
> +#define CLKID_AUCPU			174
> +#define CLKID_CEC			175
> +#define CLKID_SD_EMMC_A			176
> +#define CLKID_SD_EMMC_B			177
> +#define CLKID_NAND			178
> +#define CLKID_SMARTCARD			179
> +#define CLKID_ACODEC			180
> +#define CLKID_SPIFC			181
> +#define CLKID_MSR_CLK			182
> +#define CLKID_IR_CTRL			183
> +#define CLKID_AUDIO			184
> +#define CLKID_ETH			185
> +#define CLKID_UART_A			186
> +#define CLKID_UART_B			187
> +#define CLKID_UART_C			188
> +#define CLKID_UART_D			189
> +#define CLKID_UART_E			190
> +#define CLKID_AIFIFO			191
> +#define CLKID_TS_DDR			192
> +#define CLKID_TS_PLL			193
> +#define CLKID_G2D			194
> +#define CLKID_SPICC0			195
> +#define CLKID_SPICC1			196
> +#define CLKID_USB			197
> +#define CLKID_I2C_M_A			198
> +#define CLKID_I2C_M_B			199
> +#define CLKID_I2C_M_C			200
> +#define CLKID_I2C_M_D			201
> +#define CLKID_I2C_M_E			202
> +#define CLKID_HDMITX_APB		203
> +#define CLKID_I2C_S_A			204
> +#define CLKID_USB1_TO_DDR		205
> +#define CLKID_HDCP22			206
> +#define CLKID_MMC_APB			207
> +#define CLKID_RSA			208
> +#define CLKID_CPU_DEBUG			209
> +#define CLKID_VPU_INTR			210
> +#define CLKID_DEMOD			211
> +#define CLKID_SAR_ADC			212
> +#define CLKID_GIC			213
> +#define CLKID_PWM_AB			214
> +#define CLKID_PWM_CD			215
> +#define CLKID_PWM_EF			216
> +#define CLKID_PWM_GH			217
> +#define CLKID_PWM_IJ			218
> +#define CLKID_HDCP22_ESMCLK_GATE	221
> +#define CLKID_HDCP22_SKPCLK_GATE	224
> +
> +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
> -- 
> 2.33.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
