Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F8B6F02CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243152AbjD0Iwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbjD0Iwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:52:32 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3099F30FC;
        Thu, 27 Apr 2023 01:52:30 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 8F16C5FD0D;
        Thu, 27 Apr 2023 11:52:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682585548;
        bh=PZBkLq4gz/aT4V/nTAF4Lk9FELeD2AlDnCcQ0XnKUtE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=d3R6kx3J0mDEc2w0MRapPnYElMqgyzwOH66bB3bxRgUkqR5+ssewewB9Ddm2MwAtJ
         7Rwns7b1sIqYZPNKCrRIcVjKZ57hWrL4vWOeu+YzT8EEhiAkR1H1+HG89Hc9YYUkgu
         oP6ZvMrEawhNC+dlakLr2VOzqJ0Jgk/sO36ZE8cT9mEdx0h3nAjm4L8JVAzR8WpMC/
         zGRwWl20GrW98szSqosxFlXv7HP2lcL38VCN4ArvLpSiKAC5nxZxSnY/72yA1l6qxy
         yFrEfhUj+WMg8+8kYcNqKqsYSTPcglYXEw4lHLVXGN68J9LLSAtkPYHxUKNPvN8htm
         I884thkr62eXg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 27 Apr 2023 11:52:28 +0300 (MSK)
Date:   Thu, 27 Apr 2023 11:52:28 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Yu Tu <yu.tu@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <kelvin.zhang@amlogic.com>, <qi.duan@amlogic.com>
Subject: Re: [PATCH V7 2/4] dt-bindings: clock: document Amlogic S4 SoC
 peripherals clock controller
Message-ID: <20230427085228.vktptr76wbcdcksq@CAB-WSD-L081021>
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-3-yu.tu@amlogic.com>
 <20230426104946.xiwsdjxris2faf7x@CAB-WSD-L081021>
 <98fdedba-2715-23e7-1d2b-2d9334f0c674@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98fdedba-2715-23e7-1d2b-2d9334f0c674@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/27 05:34:00 #21173123
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 04:03:41PM +0800, Yu Tu wrote:
> 
> 
> On 2023/4/26 18:49, Dmitry Rokosov wrote:
> > [ EXTERNAL EMAIL ]
> > 
> > Hello Yu,
> > 
> > Thank you for the patch series! Please find my comments below.
> > 
> 
> Hi Dmitry，
> 	Thank you for your review.
> 
> > On Mon, Apr 17, 2023 at 02:50:03PM +0800, Yu Tu wrote:
> > > Add the S4 peripherals clock controller dt-bindings in the s4 SoC
> > > family.
> > > 
> > > Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> > > ---
> > >   .../clock/amlogic,s4-peripherals-clkc.yaml    |  97 +++++++++++++
> > >   .../clock/amlogic,s4-peripherals-clkc.h       | 131 ++++++++++++++++++
> > >   2 files changed, 228 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
> > >   create mode 100644 include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
> > > new file mode 100644
> > > index 000000000000..46b969a16a7c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/amlogic,s4-peripherals-clkc.yaml
> > > @@ -0,0 +1,97 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/amlogic,s4-peripherals-clkc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Amlogic Meson S serials Peripherals Clock Controller
> > 
> > As per my understanding, Meson is no longer applicable.
> > As Neil and Martin suggested in other reviews, the term 'Amlogic' should
> > be used instead or 'Meson' should be removed altogether.
> > 
> 
> No. This was all agreed upon a long time ago. Corporate drivers and dtsi are
> named after this.
> 

Okay, it seems like there may be a misunderstanding here.
Now might be a good time to ask Neil about the correct behavior.

Neil, could you please provide the specific naming rules for the new
Amlogic drivers? Where should we use the 'meson' keyword, and where
should we not use it?

> > > +
> > > +maintainers:
> > > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > > +  - Jerome Brunet <jbrunet@baylibre.com>
> > > +  - Yu Tu <yu.tu@amlogic.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: amlogic,s4-peripherals-clkc
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: input fixed pll div2
> > > +      - description: input fixed pll div2p5
> > > +      - description: input fixed pll div3
> > > +      - description: input fixed pll div4
> > > +      - description: input fixed pll div5
> > > +      - description: input fixed pll div7
> > > +      - description: input hifi pll
> > > +      - description: input gp0 pll
> > > +      - description: input mpll0
> > > +      - description: input mpll1
> > > +      - description: input mpll2
> > > +      - description: input mpll3
> > > +      - description: input hdmi pll
> > > +      - description: input oscillator (usually at 24MHz)
> > > +      - description: input external 32kHz reference (optional)
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: fclk_div2
> > > +      - const: fclk_div2p5
> > > +      - const: fclk_div3
> > > +      - const: fclk_div4
> > > +      - const: fclk_div5
> > > +      - const: fclk_div7
> > > +      - const: hifi_pll
> > > +      - const: gp0_pll
> > > +      - const: mpll0
> > > +      - const: mpll1
> > > +      - const: mpll2
> > > +      - const: mpll3
> > > +      - const: hdmi_pll
> > > +      - const: xtal
> > > +      - const: ext_32k
> > > +
> > > +  "#clock-cells":
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - clocks
> > > +  - clock-names
> > > +  - "#clock-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
> > > +
> > > +    clkc_periphs: clock-controller@fe000000 {
> > > +      compatible = "amlogic,s4-peripherals-clkc";
> > > +      reg = <0xfe000000 0x49c>;
> > 
> > I was under the impression that reg as MMIO address should have four
> > cells on ARM64 architecture. Are you sure it only needs two cells?
> 
> Yes. Maybe you can check out the clock file for other yaml.The two cells and
> four cells all are ok.
> 
> It's not a problem even in real DTS. How many cells are needed to look at
> the parent address-cells and size-cells definitions.
> 

AFAIR, it depends on which OF API you will call for retreive address
and size values (u32 or u64).

> > 
> > > +      clocks = <&clkc_pll 3>,
> > > +              <&clkc_pll 13>,
> > > +              <&clkc_pll 5>,
> > > +              <&clkc_pll 7>,
> > > +              <&clkc_pll 9>,
> > > +              <&clkc_pll 11>,
> > > +              <&clkc_pll 17>,
> > > +              <&clkc_pll 15>,
> > > +              <&clkc_pll 25>,
> > > +              <&clkc_pll 27>,
> > > +              <&clkc_pll 29>,
> > > +              <&clkc_pll 31>,
> > > +              <&clkc_pll 20>,
> > > +              <&xtal>,
> > > +              <&ext_32k>;
> > > +      clock-names = "fclk_div2", "fclk_div2p5", "fclk_div3", "fclk_div4",
> > > +                    "fclk_div5", "fclk_div7", "hifi_pll", "gp0_pll",
> > > +                    "mpll0", "mpll1", "mpll2", "mpll3", "hdmi_pll", "xtal",
> > > +                    "ext_32k";
> > > +      #clock-cells = <1>;
> > > +    };
> > > +...
> > > diff --git a/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> > > new file mode 100644
> > > index 000000000000..073396a76957
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/amlogic,s4-peripherals-clkc.h
> > > @@ -0,0 +1,131 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > +/*
> > > + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> > > + * Author: Yu Tu <yu.tu@amlogic.com>
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
> > > +#define _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H
> > > +
> > > +/*
> > > + * CLKID index values
> > > + */
> > > +
> > > +#define CLKID_RTC_CLK                        4
> > 
> > I believe that the CLK suffix is unnecessary since it is already clear
> > that the object in question is a clock. Additionally, it is redundant
> > to use the GATE suffix.
> 
> No. These prefixes and suffixes are very friendly to the people who write
> and read the code.
> 

Jerome has already pointed this out in another review for the
A1 clock driver, there are redundant suffixes:

https://lore.kernel.org/linux-amlogic/1j359y82fn.fsf@starbuckisacylon.baylibre.com/

> > 
> > > +#define CLKID_SYS_CLK_B_GATE         7
> > > +#define CLKID_SYS_CLK_A_GATE         10
> > > +#define CLKID_SYS_CLK                        11
> > > +#define CLKID_CECA_32K_CLKOUT                16
> > > +#define CLKID_CECB_32K_CLKOUT                21
> > > +#define CLKID_SC_CLK_GATE            24
> > > +#define CLKID_12_24M_CLK_SEL         27
> > > +#define CLKID_VID_PLL                        30
> > > +#define CLKID_VCLK                   37
> > > +#define CLKID_VCLK2                  38
> > > +#define CLKID_VCLK_DIV1                      39
> > > +#define CLKID_VCLK2_DIV1             44
> > > +#define CLKID_VCLK_DIV2                      49
> > > +#define CLKID_VCLK_DIV4                      50
> > > +#define CLKID_VCLK_DIV6                      51
> > > +#define CLKID_VCLK_DIV12             52
> > > +#define CLKID_VCLK2_DIV2             53
> > > +#define CLKID_VCLK2_DIV4             54
> > > +#define CLKID_VCLK2_DIV6             55
> > > +#define CLKID_VCLK2_DIV12            56
> > > +#define CLKID_CTS_ENCI                       61
> > > +#define CLKID_CTS_ENCP                       62
> > > +#define CLKID_CTS_VDAC                       63
> > > +#define CLKID_HDMI                   67
> > > +#define CLKID_TS_CLK_GATE            69
> > > +#define CLKID_MALI_0                 72
> > > +#define CLKID_MALI_1                 75
> > > +#define CLKID_MALI                   76
> > > +#define CLKID_VDEC_P0                        79
> > > +#define CLKID_VDEC_P1                        82
> > > +#define CLKID_VDEC_SEL                       83
> > > +#define CLKID_HEVCF_P0                       86
> > > +#define CLKID_HEVCF_P1                       89
> > > +#define CLKID_HEVCF_SEL                      90
> > > +#define CLKID_VPU_0                  93
> > > +#define CLKID_VPU_1                  96
> > > +#define CLKID_VPU                    97
> > > +#define CLKID_VPU_CLKB_TMP           100
> > > +#define CLKID_VPU_CLKB                       102
> > > +#define CLKID_VPU_CLKC_P0            105
> > > +#define CLKID_VPU_CLKC_P1            108
> > > +#define CLKID_VPU_CLKC_SEL           109
> > > +#define CLKID_VAPB_0                 112
> > > +#define CLKID_VAPB_1                 115
> > > +#define CLKID_VAPB                   116
> > > +#define CLKID_GE2D                   117
> > > +#define CLKID_VDIN_MEAS_GATE         120
> > > +#define CLKID_SD_EMMC_C_CLK          123
> > > +#define CLKID_SD_EMMC_A_CLK          126
> > > +#define CLKID_SD_EMMC_B_CLK          129
> > > +#define CLKID_SPICC0_GATE            132
> > > +#define CLKID_PWM_A_GATE             135
> > > +#define CLKID_PWM_B_GATE             138
> > > +#define CLKID_PWM_C_GATE             141
> > > +#define CLKID_PWM_D_GATE             144
> > > +#define CLKID_PWM_E_GATE             147
> > > +#define CLKID_PWM_F_GATE             150
> > > +#define CLKID_PWM_G_GATE             153
> > > +#define CLKID_PWM_H_GATE             156
> > > +#define CLKID_PWM_I_GATE             159
> > > +#define CLKID_PWM_J_GATE             162
> > > +#define CLKID_SARADC_GATE            165
> > > +#define CLKID_GEN_GATE                       168
> > > +#define CLKID_DDR                    169
> > > +#define CLKID_DOS                    170
> > > +#define CLKID_ETHPHY                 171
> > > +#define CLKID_MALI_GATE                      172
> > > +#define CLKID_AOCPU                  173
> > > +#define CLKID_AUCPU                  174
> > > +#define CLKID_CEC                    175
> > > +#define CLKID_SD_EMMC_A                      176
> > > +#define CLKID_SD_EMMC_B                      177
> > > +#define CLKID_NAND                   178
> > > +#define CLKID_SMARTCARD                      179
> > > +#define CLKID_ACODEC                 180
> > > +#define CLKID_SPIFC                  181
> > > +#define CLKID_MSR_CLK                        182
> > > +#define CLKID_IR_CTRL                        183
> > > +#define CLKID_AUDIO                  184
> > > +#define CLKID_ETH                    185
> > > +#define CLKID_UART_A                 186
> > > +#define CLKID_UART_B                 187
> > > +#define CLKID_UART_C                 188
> > > +#define CLKID_UART_D                 189
> > > +#define CLKID_UART_E                 190
> > > +#define CLKID_AIFIFO                 191
> > > +#define CLKID_TS_DDR                 192
> > > +#define CLKID_TS_PLL                 193
> > > +#define CLKID_G2D                    194
> > > +#define CLKID_SPICC0                 195
> > > +#define CLKID_SPICC1                 196
> > > +#define CLKID_USB                    197
> > > +#define CLKID_I2C_M_A                        198
> > > +#define CLKID_I2C_M_B                        199
> > > +#define CLKID_I2C_M_C                        200
> > > +#define CLKID_I2C_M_D                        201
> > > +#define CLKID_I2C_M_E                        202
> > > +#define CLKID_HDMITX_APB             203
> > > +#define CLKID_I2C_S_A                        204
> > > +#define CLKID_USB1_TO_DDR            205
> > > +#define CLKID_HDCP22                 206
> > > +#define CLKID_MMC_APB                        207
> > > +#define CLKID_RSA                    208
> > > +#define CLKID_CPU_DEBUG                      209
> > > +#define CLKID_VPU_INTR                       210
> > > +#define CLKID_DEMOD                  211
> > > +#define CLKID_SAR_ADC                        212
> > > +#define CLKID_GIC                    213
> > > +#define CLKID_PWM_AB                 214
> > > +#define CLKID_PWM_CD                 215
> > > +#define CLKID_PWM_EF                 216
> > > +#define CLKID_PWM_GH                 217
> > > +#define CLKID_PWM_IJ                 218
> > > +#define CLKID_HDCP22_ESMCLK_GATE     221
> > > +#define CLKID_HDCP22_SKPCLK_GATE     224
> > > +
> > > +#endif /* _DT_BINDINGS_CLOCK_AMLOGIC_S4_PERIPHERALS_CLKC_H */
> > > --
> > > 2.33.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-amlogic mailing list
> > > linux-amlogic@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-amlogic
> > 
> > --
> > Thank you,
> > Dmitry

-- 
Thank you,
Dmitry
