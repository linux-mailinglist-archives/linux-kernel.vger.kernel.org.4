Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192935F1B05
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJAJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJAJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:12:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0615C1F5
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:12:03 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o7so2910801lfk.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MYzDYTu+y365Di0iY2do9967QJR+w59HugDfWIvDR38=;
        b=iCkghzZ0px+bJEBeBpvkcO4sYiA6PztM77nIBZqG1MOw38Zz5oXX0P4SD8KHkX/Ass
         0Wlk/3wbQQSI+1bBFJIiOyMN2aC9d8+Yc+G6ggmrNE5tdmeu5bck/JwNHk6fW62IjuMM
         orOnjYDu/fuJ9EkgE6VLvz8svz91O3CsxZnb7VZRjNnYfEsF2UlkUYxWmf2ZKWbOTF6E
         SGLbWMqMLu4X69mq9t1pd1rYZhMA2NzXsox4w1HxxXXVngty500BM99Tbj5ru2ssYgJI
         OI6CU2bv8dFfYG7L2tWUGgLuSqI6fQiDeNykp8+2ra5kQMVSDAd/CzVbXjumE7SIvyls
         Sy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MYzDYTu+y365Di0iY2do9967QJR+w59HugDfWIvDR38=;
        b=KZP4ovM/Tb8m/tgBMuWLeEbWZZ8juOe8ujHEHZnG+R7P8E1rZNlEUFdLU9JL8Rp990
         zvHl/1TS44dJj7LCTM3KLIM5amm8snFZq5ilfL9Vnm0m92hUzEkpnAsISeIu2u7d+Bt6
         o6XCoY0bRYuqNXCCmIZA5Y4848J4C7TVYBUZiMvt/Bkj5Y1+KtX9MVPkk6uc46PPiFS4
         FND2zsk1f9vT6NuzeK9d4w9IZwxYB/nohfIN/bzgi5pdp2HW1VywU6eljEpX+0eMmxZj
         2KOH/uH8CNlfXEuiBSvEOZFskCdzy7tgbHnaytNZF0i4gEdHfaaAIaGbHkj6IUU5DdXQ
         eh9Q==
X-Gm-Message-State: ACrzQf3DYyZjzZwdvixZZVvfVHd4AVQhFqdUvzXt7HelXCzfGWw1ss+E
        hN3Mr92IgG813Z2IK3aMU5aekw==
X-Google-Smtp-Source: AMsMyM68rfI7wKCocKZP6aPR8JcWSv1CQpPTOVoRT5alpv+lZHj6hrJwC9YnHCHdXjMMVeSVj+OAdQ==
X-Received: by 2002:a05:6512:3f0e:b0:4a0:45b7:a8dc with SMTP id y14-20020a0565123f0e00b004a045b7a8dcmr4406695lfa.368.1664615521597;
        Sat, 01 Oct 2022 02:12:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h12-20020a2ea48c000000b0026c2e0258bcsm384753lji.42.2022.10.01.02.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:12:01 -0700 (PDT)
Message-ID: <a40d7e71-f7c7-0410-7a92-0718f45de2d2@linaro.org>
Date:   Sat, 1 Oct 2022 11:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 01/19] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030656.29365-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
> descriptions of CPUs, GCC, RPMHCC, UART, and interrupt-controller to
> boot to shell with console on these SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdru1000.dtsi | 370 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi  |  10 +
>  arch/arm64/boot/dts/qcom/qru1000.dtsi  |  10 +
>  3 files changed, 390 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdru1000.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> new file mode 100644
> index 000000000000..3610f94bef35
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
> @@ -0,0 +1,370 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-qdru1000.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen: chosen { };
> +
> +

No need for double blank line.

> +	clocks {
> +		xo_board: xo_board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <19200000>;
> +			clock-output-names = "xo_board";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +

(...)

> +		CPU_PD3: cpu-pd3 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +			domain-idle-states = <&SILVER_OFF>;
> +		};
> +
> +		CLUSTER_PD: cluster-pd {
> +			#power-domain-cells = <0>;
> +			domain-idle-states = <&CLUSTER_PWR_DN &APSS_OFF>;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0 0 0 0 0x10 0>;
> +		dma-ranges = <0 0 0 0 0x10 0>;
> +		compatible = "simple-bus";
> +
> +		gcc: clock-controller@80000 {
> +			compatible = "qcom,gcc-qdu1000", "qcom,gcc-qru1000", "syscon";

Did you document the compatibles?

> +			reg = <0x0 0x80000 0x0 0x1f4200>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
> +			clock-names = "bi_tcxo", "sleep_clk";
> +		};
> +
> +		qupv3_id_0: geniqup@9c0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0x9c0000 0x0 0x2000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				<&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			status = "disabled";
> +
> +			uart7: serial@99c000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0x0 0x99c000 0x0 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +

(...)

> +		arch_timer: timer {
> +			compatible = "arm,armv8-timer";
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +				     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +			clock-frequency = <19200000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> new file mode 100644
> index 000000000000..ba195e7ffc38
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "qdru1000.dtsi"
> +
> +/ {
> +	qcom,msm-id = <545 0x10000>, <587 0x10000>;

NAK.

> +};
> diff --git a/arch/arm64/boot/dts/qcom/qru1000.dtsi b/arch/arm64/boot/dts/qcom/qru1000.dtsi
> new file mode 100644
> index 000000000000..1639a4b3c1fb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qru1000.dtsi
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: BSD-3-Clause-Clear
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "qdru1000.dtsi"
> +
> +/ {
> +	qcom,msm-id = <539 0x10000>, <588 0x10000>, <589 0x10000>, <590 0x10000>;

Nope, property is not documented and not accepted. Efforts in
documenting this property were apparently also not accepted, therefore I
am not agreeing in bringing DTS with these.

> +};

Best regards,
Krzysztof

