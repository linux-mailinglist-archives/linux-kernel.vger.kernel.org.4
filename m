Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60525637B94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiKXOl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKXOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:41:55 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA8EC68BE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:41:49 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b9so2201695ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1501m/pV3I2YFjC6545ugxV+pZKwmEXspIUwDQHylu8=;
        b=QviQSPMY7NLByd4ymW67yvSNaKAStoNc02Y22x30l3KGFw4xdTJMiKBVtwDd3q6Vuk
         9wJpx0MyBFxvWQfs6hqMwBe7c7NBRXzorNRyl/macmEr/+fJFj+kk5SHn/50hOpKmMBj
         OJwoouFRr1ZVKJkxCpGnkJOUysCEONMbC4yTkZNfbCG6EMNk0i/HnCQQRsV32aSrym7E
         2JILI8LnuWbCWlJd3EcQCRP9Nka2ek5w/xafyMu1jEvpuxX5JVAPVu8HGrdRf17EAtim
         oBUc2/U+bHS/Hm4Tgt5dUQcKw+jCjlFOw6Ou+96sZKncvogQSRRSIjhSR/zIlrEwdTHb
         kd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1501m/pV3I2YFjC6545ugxV+pZKwmEXspIUwDQHylu8=;
        b=RKU7HWA6gVm2PAxhKFC31via/FvWeL6Mm08M+Tezma5iKaZK9jqSASztQisc4mycPi
         4EZzwsfMLqW+uIqCf8jwVr9u/4SXrrmJd9LrT5vNVSiBf5RLOD+yNrMcTTfnjxB4sz7J
         YGSi3pnZjL6+w3i4YCVG25TiPX7MOfBlyjk6mcYrgUt77+Ed9PVpOIskc5Y6Rc1zoG7P
         aD8ZRKpuaqxRmPPaQqZn9WXgsxb1eG4MQRZ0kPZ5mzLejglI4Bq5We1xM2Fevxsm2J8k
         Xh2XNrFdIiFtE62L/XuNw2Bcwgaglcw7W8LB0L2kZPBF586boO7LQjVGtX9zBkR3OzA0
         WgFw==
X-Gm-Message-State: ANoB5pmUXAEiFXXDdyeAWZDUIyt0SrHSo+V+2VPgJwZrNoYhTKN0Whfu
        ShuTGJdjJmBNwy2QqCjlkISMjA==
X-Google-Smtp-Source: AA0mqf6Y7CzwQt31av4VbTZbcOC08FcUE2XeKcinCHJppnxp7nxmHNN7YEI/yuhAeMEfQapEqEQFOg==
X-Received: by 2002:a2e:321a:0:b0:279:7974:4471 with SMTP id y26-20020a2e321a000000b0027979744471mr2540317ljy.495.1669300907861;
        Thu, 24 Nov 2022 06:41:47 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id w10-20020ac25d4a000000b004a8f824466bsm138637lfd.188.2022.11.24.06.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:41:47 -0800 (PST)
Message-ID: <16acb2c7-cbaf-b8e0-9f3e-846672b29e14@linaro.org>
Date:   Thu, 24 Nov 2022 15:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 02/10] arm64: dts: qcom: Add base SM8550 dtsi
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221124135646.1952727-1-abel.vesa@linaro.org>
 <20221124135646.1952727-3-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221124135646.1952727-3-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.2022 14:56, Abel Vesa wrote:
> Add base dtsi for SM8550 SoC and includes base description of
> CPUs, GCC, RPMHCC, UART, interrupt controller, TLMM, reserved
> memory, RPMh PD, TCSRCC, ITS, IPCC, AOSS QMP, LLCC, cpufreq,
> interconnect, thermal sensor, cpu cooling maps and SMMU nodes
> which helps boot to shell with console on boards with this SoC.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
[...]

> +	reserved_memory: reserved-memory {
> +		ranges;
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
#address-cells = <2>;
#size-cells = <2>;
ranges;


> +
> +		hyp_mem: hyp-region@80000000 {
> +			reg = <0x0 0x80000000 0x0 0xa00000>;
> +			no-map;
> +		};
> +

> +
> +		sdhc_2: mmc@8804000 {
> +			compatible = "qcom,sm8550-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x0 0x08804000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			iommus = <&apps_smmu 0x540 0x0>;
> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +			power-domains = <&rpmhpd SM8550_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
> +
> +			/* Forbid SDR104/SDR50 - broken hw! */
> +			sdhci-caps-mask = <0x3 0x0>;
> +
> +			status = "disabled";
> +
8450 needs `dma-coherent` there - I don't have any downstream for 8550
to cross reference, could you check if this is the case here too?


> +			sdhc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-19200000 {
> +					opp-hz = /bits/ 64 <19200000>;
> +					required-opps = <&rpmhpd_opp_min_svs>;
> +				};
> +
> +				opp-50000000 {
> +					opp-hz = /bits/ 64 <50000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +				};
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_svs>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +				};
> +			};
> +		};
> +
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sm8550-pdc", "qcom,pdc";
> +			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
> +			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
> +					  <125 63 1>, <126 716 12>,
> +					  <138 251 5>;
> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
> +		tsens0: thermal-sensor@c271000 {
> +			compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c271000 0 0x1000>, /* TM */
> +			      <0 0x0c222000 0 0x1000>; /* SROT */
> +			#qcom,sensors = <16>;
> +			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@c272000 {
> +			compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c272000 0 0x1000>, /* TM */
> +			      <0 0x0c223000 0 0x1000>; /* SROT */
> +			#qcom,sensors = <16>;
> +			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens2: thermal-sensor@c273000 {
> +			compatible = "qcom,sm8550-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c273000 0 0x1000>, /* TM */
> +			      <0 0x0c224000 0 0x1000>; /* SROT */
> +			#qcom,sensors = <16>;
> +			interrupts = <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow", "critical";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		aoss_qmp: power-controller@c300000 {
> +			compatible = "qcom,sm8550-aoss-qmp", "qcom,aoss-qmp";
> +			reg = <0 0x0c300000 0 0x400>;
> +			interrupt-parent = <&ipcc>;
> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
> +						     IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +			#clock-cells = <0>;
> +		};
> +
> +		sram@c3f0000 {
> +			compatible = "qcom,rpmh-stats";
> +			reg = <0x0 0x0c3f0000 0x0 0x400>;
> +		};
> +
> +		spmi_bus: spmi@c400000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x0 0x0c400000 0x0 0x3000>,
> +			      <0x0 0x0c500000 0x0 0x4000000>,
> +			      <0x0 0x0c440000 0x0 0x80000>,
> +			      <0x0 0x0c4c0000 0x0 0x20000>,
> +			      <0x0 0x0c42d000 0x0 0x4000>;
You use 0 and 0x0 inconsistently in reg. I propose to use 0 everywhere.


> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +			interrupt-names = "periph_irq";
> +			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			qcom,bus-id = <0>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +		};
> +

[...]

> +
> +		pmu@24091000 {
> +			compatible = "qcom,sm8550-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
> +			reg = <0x0 0x24091000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
> +
> +			operating-points-v2 = <&llcc_bwmon_opp_table>;
> +
> +			llcc_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-0 {
> +					opp-peak-kBps = <2086000>;
> +				};
Please insert a newline after each node.

> +				opp-1 {
> +					opp-peak-kBps = <2929000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <5931000>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <6515000>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <7980000>;
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <10437000>;
> +				};
> +				opp-6 {
> +					opp-peak-kBps = <12157000>;
> +				};
> +				opp-7 {
> +					opp-peak-kBps = <14060000>;
> +				};
> +				opp-8 {
> +					opp-peak-kBps = <16113000>;
> +				};
> +			};
> +		};
> +
> +		pmu@240b6400 {
> +			compatible = "qcom,sm8550-cpu-bwmon", "qcom,msm8998-bwmon";
> +			reg = <0x0 0x240b6400 0x0 0x600>;
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
> +
> +			operating-points-v2 = <&cpu_bwmon_opp_table>;
> +
> +			cpu_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-0 {
> +					opp-peak-kBps = <4577000>;
> +				};
And here.

> +				opp-1 {
> +					opp-peak-kBps = <7110000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <9155000>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <12298000>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <14236000>;
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <16265000>;
> +				};
> +			};
> +		};
> +

The rest looks good!

Konrad
