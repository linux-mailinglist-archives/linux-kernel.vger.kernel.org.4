Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA006E775F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjDSK14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDSK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:27:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116605FDA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:27:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8a59daec5so24617381fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681900070; x=1684492070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDd5mN3VS3Vj6X7xMYUn4KLaHr63M/aDSb54e2lT7f8=;
        b=v4CgfFB1KweWmKC8lOdb58VUuOwsPnAbxhAOIoQnz9aNlCnwMnwema+HRDhueWBkIg
         x9s1xhDkZwAla+lt3d1IawWzOlz4g2ivzYXsdzaDZA8mCmeuNp7LSk4McmBatz6eJewn
         g6A8IryRDR24HAQAnbt84ypyaDHwcNMyhq2lkwvVOhWdbG1gFACv1aa/IJCEEdict8xE
         iuvCwghsBhiNh8JOqjqElgSv33QRB0GGKQVRqZN4oHb0QNgiYamLW65OgXAt171LGOCy
         Og9CPQR7DLrFNt2xXPmmT8+IZTKxtK6fzd/lq7f0eecDy3zsiTtQpqMRgWOiVDkrDDyS
         jcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681900070; x=1684492070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDd5mN3VS3Vj6X7xMYUn4KLaHr63M/aDSb54e2lT7f8=;
        b=YMrdSwmyFLu9/XGgbqhKGnoW0jkVLPMADLNnlS7G0+UORvTz6qviypKl0j87srWKUA
         poKtsnvjoe1siRiuQvog/OawEywWqCywIE3VkuN7qHMKp2yE2YTZ7X+EFwksAMOR3p2M
         H1d8NmDzYT2jEmQFIhLsDRE3989WrBzf44pW/ALrfML6Sgm8Tgi2oYcTjMmPuVPIJrRE
         8eRKrU8fDCetLtLnu+2heVVgjU+NaCA0gA/UrhbsIItNtEFrb0pb+J5hP/Cgu0NzfUcc
         7PQ+2Ac4rek2wdiM0AzQT1rDnsdaHSGCDyMqaNaOL1xeAmDbnLFrXKGMQMb8GwRekGyb
         GJvA==
X-Gm-Message-State: AAQBX9eHieKJFzDBoCg1yetqaU29iE/Vl5/nmpmFisVGGiuGCsCA9w2y
        U1G1w7uwTHGDtFMKrqI/5uZR9w==
X-Google-Smtp-Source: AKy350ZXceJp19cd10eLZOEKjNw4HzTu4LLGCryZVainNTw/H44zmT24et4GhMQFSDQOHtTm7nclAA==
X-Received: by 2002:ac2:488f:0:b0:4e8:5e39:6238 with SMTP id x15-20020ac2488f000000b004e85e396238mr3105494lfc.42.1681900070268;
        Wed, 19 Apr 2023 03:27:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id q12-20020ac25fcc000000b004eafa77e435sm2636220lfg.146.2023.04.19.03.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 03:27:49 -0700 (PDT)
Message-ID: <deabba9d-5f6c-06c0-22d0-9bebeef3ad15@linaro.org>
Date:   Wed, 19 Apr 2023 12:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: Add PMI632 PMIC
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
 <20230414-pmi632-v2-6-98bafa909c36@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230414-pmi632-v2-6-98bafa909c36@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 18:43, Luca Weiss wrote:
> The PMI632, commonly found on SoCs with SDM632 has various standard
> functions like ADC, GPIOs, LPG and more.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Looks good!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pmi632.dtsi | 165 +++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
> new file mode 100644
> index 000000000000..4eb79e0ce40a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (C) 2023 Luca Weiss <luca@z3ntu.xyz>
> + */
> +
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +	thermal-zones {
> +		pmi632-thermal {
> +			polling-delay-passive = <100>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pmi632_temp>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <95000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +
> +				trip2 {
> +					temperature = <125000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&spmi_bus {
> +	pmic@2 {
> +		compatible = "qcom,pmi632", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmi632_temp: temp-alarm@2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0x2 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pmi632_adc: adc@3100 {
> +			compatible = "qcom,spmi-adc5";
> +			reg = <0x3100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#io-channel-cells = <1>;
> +			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +
> +			channel@0 {
> +				reg = <ADC5_REF_GND>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "ref_gnd";
> +			};
> +
> +			channel@1 {
> +				reg = <ADC5_1P25VREF>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "vref_1p25";
> +			};
> +
> +			channel@6 {
> +				reg = <ADC5_DIE_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "die_temp";
> +			};
> +
> +			channel@7 {
> +				reg = <ADC5_USB_IN_I>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "usb_in_i_uv";
> +			};
> +
> +			channel@8 {
> +				reg = <ADC5_USB_IN_V_16>;
> +				qcom,pre-scaling = <1 16>;
> +				label = "usb_in_v_div_16";
> +			};
> +
> +			channel@9 {
> +				reg = <ADC5_CHG_TEMP>;
> +				qcom,pre-scaling = <1 1>;
> +				label = "chg_temp";
> +			};
> +
> +			channel@4b {
> +				reg = <ADC5_BAT_ID_100K_PU>;
> +				qcom,hw-settle-time = <200>;
> +				qcom,pre-scaling = <1 1>;
> +				qcom,ratiometric;
> +				label = "bat_id";
> +			};
> +
> +			channel@83 {
> +				reg = <ADC5_VPH_PWR>;
> +				qcom,pre-scaling = <1 3>;
> +				label = "vph_pwr";
> +			};
> +
> +			channel@84 {
> +				reg = <ADC5_VBAT_SNS>;
> +				qcom,pre-scaling = <1 3>;
> +				label = "vbat_sns";
> +			};
> +		};
> +
> +		pmi632_adc_tm: adc-tm@3500 {
> +			compatible = "qcom,spmi-adc-tm5";
> +			reg = <0x3500>;
> +			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		pmi632_sdam_7: nvram@b600 {
> +			compatible = "qcom,spmi-sdam";
> +			reg = <0xb600>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0xb600 0x100>;
> +		};
> +
> +		pmi632_gpios: gpio@c000 {
> +			compatible = "qcom,pmi632-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			gpio-ranges = <&pmi632_gpios 0 0 8>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmic@3 {
> +		compatible = "qcom,pmi632", "qcom,spmi-pmic";
> +		reg = <0x3 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmi632_lpg: pwm {
> +			compatible = "qcom,pmi632-lpg";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			#pwm-cells = <2>;
> +
> +			status = "disabled";
> +		};
> +	};
> +};
> 
