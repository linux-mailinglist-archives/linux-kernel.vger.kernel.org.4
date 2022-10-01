Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA65F1B35
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJAJWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJAJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:22:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697B16DDE5
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:22:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a10so7137716ljq.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ALTKi4uCfPu90E8f9xwYaylx6ltvk2Sqp6lOA1ez2t0=;
        b=yW2ROdsGfjO/aPznTtnFFEcNijMAks8bh/A1vmfoCK534cCI0PJJD//tLxv0xjn6lQ
         gTTwELz6A+18evQ1Xi/Od56cbB1D/lAxOSP7J73WpNWqShWretwDiJBp3xE3hF5Vrpfg
         Ln9HCb5kocl7pfdqQaCAupe5H62SQjG5vqBUbjJG6kMUsCFl4DWT44hQSalOwP739PLo
         NDg/ZQgQMmOie/X2IF7395/dPszkLBV5m09YwhvzOupuCkhlanXKaWLZ0XqCtiglhQEw
         obUWxqzUvo5y0q9cFzg+SLq7LXOHU1Hkv4Kz5QpsId7TbHny5HCLZQhLL6Hk8tI+7l83
         31Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ALTKi4uCfPu90E8f9xwYaylx6ltvk2Sqp6lOA1ez2t0=;
        b=oYXbPsX9AsvqA//lPEsiJZRbMoMxEYgjO3gw7zXCLlEDG5TcCyWUm7m7B8BG8nmcUg
         EH4BPzd2XKdCk8LuV/Eyv26xTiN0i1YHkuhAtxrULQHVkSGPOdA8eTcVJGAFRdT+S8Fm
         2dp/iJGDIJNzXkhdrsU4fdi4nCPs3dYcekgIHOYYnyx7z/7pSILvGFznAiOS3ZxcIY9M
         B1q6pzUQ2pVwk2HMbrhopSWbGW1FoZZg8fcJn14z/ugveoQ3der+/UxOL0WBertGsO0c
         Xg1OjH+kcFJJ3q/RpIyIsL5owfWvEqD69kPYd6D4zPPXYXFL+99z6MtD6Oo+UwmoZk7N
         r6Gw==
X-Gm-Message-State: ACrzQf0Wp6lELXBFh/Ah3s0jn8k6Y8dUEs0PUYg1chuZ09CbWV+SFDPi
        7DaTzFt3oWn1HSrpgIFnRpCo/w==
X-Google-Smtp-Source: AMsMyM6klguCYz0yi2+H3baZv6kHrQXvxco8WnaSVZLyFPVZ2lAPCw93zyda0MGVBxNytbS4Uc5Pjw==
X-Received: by 2002:a2e:9114:0:b0:26b:e3a2:3f89 with SMTP id m20-20020a2e9114000000b0026be3a23f89mr4062058ljg.132.1664616156944;
        Sat, 01 Oct 2022 02:22:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p20-20020a2eb994000000b0026c297a9e11sm382898ljp.133.2022.10.01.02.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:22:36 -0700 (PDT)
Message-ID: <b0061b6d-56de-2003-ab25-da6cf1c78084@linaro.org>
Date:   Sat, 1 Oct 2022 11:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030546.28220-1-quic_molvera@quicinc.com>
 <20221001030546.28220-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030546.28220-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:05, Melody Olvera wrote:
> Add pin control driver for the TLMM block found in the QDU1000
> and QRU1000 SoC.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../pinctrl/qcom,qdru1000-pinctrl.yaml        |  177 +-
>  drivers/pinctrl/qcom/Kconfig                  |   10 +
>  drivers/pinctrl/qcom/Makefile                 |    1 +
>  drivers/pinctrl/qcom/pinctrl-qdru1000.c       |   59 +
>  drivers/pinctrl/qcom/pinctrl-qdru1000.h       | 1896 +++++++++++++++++
>  5 files changed, 2050 insertions(+), 93 deletions(-)
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.c
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> index e8d938303231..42176247862c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml

Nope, drivers cannot be mixed with bindings in one patch.

> @@ -10,7 +10,11 @@ maintainers:
>    - Melody Olvera <quic_molvera@quicinc.com>
>  
>  description: |
> -  This binding describes the Top Level Mode Multiplexer block.
> +  This binding describes the Top Level Mode Multiplexer block (TLMM) found
> +  in the QDU1000 and QRU1000 platforms.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>  
>  properties:
>    compatible:
> @@ -19,105 +23,92 @@ properties:
>        - const: qcom,qru1000-tlmm
>  
>    reg:
> -    items:
> -      - description: Base address of TLMM register space
> -      - description: Size of TLMM register space
> -
> -  interrupts:
> -    minItems: 0
>      maxItems: 1
> -    items:
> -      - const: TLMM summary IRQ
> -
> +  interrupts: true
>    interrupt-controller: true
> -
> -  '#interrupt-cells':
> -    const: 2
> -
> +  '#interrupt-cells': true
>    gpio-controller: true
> +  '#gpio-cells': true
> +  wakeup-parent: true
>  
> -  '#gpio-cells':
> -    const: 2
> -
> -  wakeup-parent:
> -    maxItems: 1
> -    description:
> -      Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
> -      a general description of GPIO and interrupt bindings.
> -
> -      Please refer to pinctrl-bindings.txt in this directory for details of the
> -      common pinctrl bindings used by client devices, including the meaning of the
> -      phrase "pin configuration node".
> -
> -      The pin configuration nodes act as a container for an arbitrary number of
> -      subnodes. Each of these subnodes represents some desired configuration for a
> -      pin, a group, or a list of pins or groups. This configuration can include the
> -      mux function to select on those pin(s)/group(s), and various pin configuration
> -      parameters, such as pull-up, drive strength, etc.
> +required:
> +  - compatible
> +  - reg
>  
> +additionalProperties: false
>  
>  # PIN CONFIGURATION NODES
> -patternPropetries:
> -  '^.*$':
> -    if:
> -      type: object
> -    then:
> -      properties:
> -        pins:
> -          description:
> -            List of gpio pins affected by the properties specified in
> -            this subnode.
> -          items:
> -            oneOf:
> -              - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])"
> -              - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
> -            minItems: 1
> -            maxItems: 36
> -        function:
> -          description:
> -            Specify the alternative function to be configured for the
> -            specified pins. Functions are only valid for gpio pins.
> -          enum: [gpio, aon_cam, atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
> -            atest_usb0, atest_usb00, atest_usb01, atest_usb02, atest_usb03, audio_ref, cam_mclk,
> -            cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
> -            cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, coex_uart2, cri_trng, cri_trng0,
> -            cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1,
> -            gcc_gp2, gcc_gp3, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
> -            mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s2_data0, mi2s2_data1,
> -            mi2s2_sck, mi2s2_ws, mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
> -            mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6, mss_grfc7, mss_grfc8, mss_grfc9,
> -            nav_0, nav_1, nav_2, pcie0_clkreqn, pcie1_clkreqn, phase_flag0, phase_flag1,
> -            phase_flag10, phase_flag11, phase_flag12, phase_flag13, phase_flag14, phase_flag15,
> -            phase_flag16, phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
> -            phase_flag21, phase_flag22, phase_flag23, phase_flag24, phase_flag25, phase_flag26,
> -            phase_flag27, phase_flag28, phase_flag29, phase_flag3, phase_flag30, phase_flag31,
> -            phase_flag4, phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9, pll_bist,
> -            pll_clk, pri_mi2s, prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio,
> -            qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
> -            qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7,
> -            qdss_gpio8, qdss_gpio9, qlink0_enable, qlink0_request, qlink0_wmss, qlink1_enable,
> -            qlink1_request, qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
> -            qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15,
> -            qup16, qup17, qup18, qup19, qup2, qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8,
> -            qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk, sdc4_cmd,
> -            sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
> -            tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
> -            uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset, usb2phy_ac, usb_phy, vfr_0,
> -            vfr_1, vsense_trigger]
> -        drive-strength:
> -          enum: [2, 4, 6, 8, 10, 12, 14, 16]
> -          default: 2
> -          description:
> -            Selects the drive strength for the specified pins, in mA.
> -        bias-pull-down: true
> -        bias-pull-up: true
> -        bias-disable: true
> -        output-high: true
> -        output-low: true
> -      required:
> -        - pins
> -        - function
> -      additionalProperties: false
> +patternProperties:
> +  '-state$':
> +    oneOf:
> +      - $ref: "#/$defs/qcom-qdru1000-tlmm-state"
> +      - patternProperties:
> +          ".*":
> +            $ref: "#/$defs/qcom-qdru1000-tlmm-state"

Review your patches before sending...

> +
> +$defs:
> +  qcom-qdru1000-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl nodes' client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in
> +          this subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])"
> +            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
> +        minItems: 1
> +        maxItems: 36
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the
> +          specified pins. Functions are only valid for gpio pins.
> +        enum: [gpio, aon_cam, atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
> +          atest_usb0, atest_usb00, atest_usb01, atest_usb02, atest_usb03, audio_ref, cam_mclk,
> +          cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
> +          cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, coex_uart2, cri_trng, cri_trng0,
> +          cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1,
> +          gcc_gp2, gcc_gp3, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
> +          mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s2_data0, mi2s2_data1,
> +          mi2s2_sck, mi2s2_ws, mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
> +          mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6, mss_grfc7, mss_grfc8, mss_grfc9,
> +          nav_0, nav_1, nav_2, pcie0_clkreqn, pcie1_clkreqn, phase_flag0, phase_flag1,
> +          phase_flag10, phase_flag11, phase_flag12, phase_flag13, phase_flag14, phase_flag15,
> +          phase_flag16, phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
> +          phase_flag21, phase_flag22, phase_flag23, phase_flag24, phase_flag25, phase_flag26,
> +          phase_flag27, phase_flag28, phase_flag29, phase_flag3, phase_flag30, phase_flag31,
> +          phase_flag4, phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9, pll_bist,
> +          pll_clk, pri_mi2s, prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio,
> +          qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
> +          qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7,
> +          qdss_gpio8, qdss_gpio9, qlink0_enable, qlink0_request, qlink0_wmss, qlink1_enable,
> +          qlink1_request, qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
> +          qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15,
> +          qup16, qup17, qup18, qup19, qup2, qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8,
> +          qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk, sdc4_cmd,
> +          sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
> +          tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
> +          uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset, usb2phy_ac, usb_phy, vfr_0,
> +          vfr_1, vsense_trigger]
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
>  
>  examples:
>    - |
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index f415c13caae0..c8a7d6e44a81 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -390,6 +390,16 @@ config PINCTRL_SM8450
>  	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
>  	  Technologies Inc SM8450 platform.
>  
> +config PINCTRL_QDRU1000

Order alphabetically.

> +	tristate "Qualcomm Tehcnologies Inc QDU1000/QRU1000 pin controller driver"
> +	depends on GPIOLIB && OF
> +	depends on PINCTRL_MSM
> +	help
> +	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +	  Technologies Inc QDU1000 and QRU1000 platforms.
> +
> +

No need for multiple line breaks.

>  config PINCTRL_LPASS_LPI
>  	tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
>  	select PINMUX
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index fbd64853a24d..431a845b4e2d 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -45,4 +45,5 @@ obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>  obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
>  obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>  obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
> +obj-$(CONFIG_PINCTRL_QDRU1000) += pinctrl-qdru1000.o

Wrong order.

>  obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.c b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
> new file mode 100644
> index 000000000000..8b931ff80bb4
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-msm.h"
> +#include "pinctrl-qdru1000.h"
> +
> +static const struct msm_pinctrl_soc_data qdru1000_tlmm = {
> +	.pins = qdru1000_pins,
> +	.npins = ARRAY_SIZE(qdru1000_pins),
> +	.functions = qdru1000_functions,
> +	.nfunctions = ARRAY_SIZE(qdru1000_functions),
> +	.groups = qdru1000_groups,
> +	.ngroups = ARRAY_SIZE(qdru1000_groups),
> +	.ngpios = 151,
> +};
> +
> +static int qdru1000_tlmm_probe(struct platform_device *pdev)
> +{
> +	return msm_pinctrl_probe(pdev, &qdru1000_tlmm);
> +}
> +
> +static const struct of_device_id qdru1000_tlmm_of_match[] = {
> +	{ .compatible = "qcom,qdu1000-tlmm", },
> +	{ .compatible = "qcom,qru1000-tlmm", },
> +	{ },
> +};
> +
> +static struct platform_driver qdru1000_tlmm_driver = {
> +	.driver = {
> +		.name = "qdru1000-tlmm",
> +		.of_match_table = qdru1000_tlmm_of_match,
> +	},
> +	.probe = qdru1000_tlmm_probe,
> +	.remove = msm_pinctrl_remove,
> +};
> +
> +static int __init qdru1000_tlmm_init(void)
> +{
> +	return platform_driver_register(&qdru1000_tlmm_driver);
> +}
> +arch_initcall(qdru1000_tlmm_init);
> +
> +static void __exit qdru1000_tlmm_exit(void)
> +{
> +	platform_driver_unregister(&qdru1000_tlmm_driver);
> +}
> +module_exit(qdru1000_tlmm_exit);
> +
> +MODULE_DESCRIPTION("QTI QDRU1000 TLMM driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DEVICE_TABLE(of, qdru1000_tlmm_of_match);
> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.h b/drivers/pinctrl/qcom/pinctrl-qdru1000.h
> new file mode 100644
> index 000000000000..3c1f703ae53b
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.h
> @@ -0,0 +1,1896 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define FUNCTION(fname)			                \
> +	[msm_mux_##fname] = {		                \
> +		.name = #fname,				\
> +		.groups = fname##_groups,               \
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +#define REG_BASE 0x100000
> +#define REG_SIZE 0x1000
> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
> +	{					        \
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),	\
> +		.funcs = (int[]){			\
> +			msm_mux_gpio, /* gpio mode */	\
> +			msm_mux_##f1,			\
> +			msm_mux_##f2,			\
> +			msm_mux_##f3,			\
> +			msm_mux_##f4,			\
> +			msm_mux_##f5,			\
> +			msm_mux_##f6,			\
> +			msm_mux_##f7,			\
> +			msm_mux_##f8,			\
> +			msm_mux_##f9			\
> +		},				        \
> +		.nfuncs = 10,				\
> +		.ctl_reg = REG_BASE + REG_SIZE * id,			\
> +		.io_reg = REG_BASE + 0x4 + REG_SIZE * id,		\
> +		.intr_cfg_reg = REG_BASE + 0x8 + REG_SIZE * id,		\
> +		.intr_status_reg = REG_BASE + 0xc + REG_SIZE * id,	\
> +		.intr_target_reg = REG_BASE + 0x8 + REG_SIZE * id,	\
> +		.mux_bit = 2,			\
> +		.pull_bit = 0,			\
> +		.drv_bit = 6,			\
> +		.oe_bit = 9,			\
> +		.in_bit = 0,			\
> +		.out_bit = 1,			\
> +		.intr_enable_bit = 0,		\
> +		.intr_status_bit = 0,		\
> +		.intr_target_bit = 5,		\
> +		.intr_target_kpss_val = 3,	\
> +		.intr_raw_status_bit = 4,	\
> +		.intr_polarity_bit = 1,		\
> +		.intr_detection_bit = 2,	\
> +		.intr_detection_width = 2,	\
> +	}
> +
> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
> +	{					        \
> +		.name = #pg_name,			\
> +		.pins = pg_name##_pins,			\
> +		.npins = (unsigned int)ARRAY_SIZE(pg_name##_pins),	\
> +		.ctl_reg = REG_BASE + ctl,				\
> +		.io_reg = 0,				\
> +		.intr_cfg_reg = 0,			\
> +		.intr_status_reg = 0,			\
> +		.intr_target_reg = 0,			\
> +		.mux_bit = -1,				\
> +		.pull_bit = pull,			\
> +		.drv_bit = drv,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = -1,				\
> +		.intr_enable_bit = -1,			\
> +		.intr_status_bit = -1,			\
> +		.intr_target_bit = -1,			\
> +		.intr_raw_status_bit = -1,		\
> +		.intr_polarity_bit = -1,		\
> +		.intr_detection_bit = -1,		\
> +		.intr_detection_width = -1,		\
> +	}
> +
> +#define UFS_RESET(pg_name, offset)				\
> +	{					        \
> +		.name = #pg_name,			\
> +		.pins = pg_name##_pins,			\
> +		.npins = (unsigned int)ARRAY_SIZE(pg_name##_pins),	\
> +		.ctl_reg = offset,			\
> +		.io_reg = offset + 0x4,			\
> +		.intr_cfg_reg = 0,			\
> +		.intr_status_reg = 0,			\
> +		.intr_target_reg = 0,			\
> +		.mux_bit = -1,				\
> +		.pull_bit = 3,				\
> +		.drv_bit = 0,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = 0,				\
> +		.intr_enable_bit = -1,			\
> +		.intr_status_bit = -1,			\
> +		.intr_target_bit = -1,			\
> +		.intr_raw_status_bit = -1,		\
> +		.intr_polarity_bit = -1,		\
> +		.intr_detection_bit = -1,		\
> +		.intr_detection_width = -1,		\
> +	}
> +
> +#define QUP_I3C(qup_mode, qup_offset)			\
> +	{						\
> +		.mode = qup_mode,			\
> +		.offset = qup_offset,			\
> +	}
> +
> +static const struct pinctrl_pin_desc qdru1000_pins[] = {
> +	PINCTRL_PIN(0, "GPIO_0"),
> +	PINCTRL_PIN(1, "GPIO_1"),
> +	PINCTRL_PIN(2, "GPIO_2"),
> +	PINCTRL_PIN(3, "GPIO_3"),

Nope. Header is not a place for this stuff.

Best regards,
Krzysztof

