Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E99F707D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjERJzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjERJzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:55:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9C1BC3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:55:13 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac82912a59so19416141fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684403712; x=1686995712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4y39yQeXgfshTFx8LmSwMssJPh2RhRz9IxqW/7rapk=;
        b=js8tUXvIUOpLgtCGl0gjJeo7q7Ptbvp9VUWF5RYmreXr0lBQRn0lJ6FfPrczx+njss
         naQGYXPCVNmqgEg/lVmN9Kq3J3x+0tv88V/V9uzoedXHshbooWiY3uATOK+Idn8TG0Qu
         4Uq4wRNyph/Sv9AQZDhfKUomUAZj/egf9D+ozic9g0K1oj+kQt5RkEDQiEIqiH+SRuGb
         8lZLrsO93bEx7pZLHQG5NSJRmaDGGvSVanBw3iT35Mc4aZDd1ZmeNx1mE1t5GyS/DOc7
         wvqbhfwJBz8kBDxG8gavbJlsQmRUjsKOZYarK7OCrpL7tP4XWIcrGVwVkZVjuarQVXJp
         dA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684403712; x=1686995712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4y39yQeXgfshTFx8LmSwMssJPh2RhRz9IxqW/7rapk=;
        b=QcRs39ZDQkmT/PcmC5CKGnQTSpVWseBE4ZvRt5xgozv30C4eKh4jATZoelNx/x+8ql
         6VYDDKQj8QHxyMomrUlJwxH1Ro2gjcKLe9/ZrukY7Nr1eNDY6xxceI2MU/OgNkySGf7P
         6ouZT2hz4fLWjlDcpfp5+DMQGNneDYXPI/XPesksYPs5D1rKU7e2op67grvV7xGQfbJG
         a71WG7GPwkRL2X0F+AxjuLLvJCQm21Myg251I33M7bgCEqP7/J32RMki9w/yljqp1gAG
         7Ptg9C/sLIaQuNmK8VZoxx6FBPi1nxq6hY2EpR6T2t9684b27m/Jq7A9+t5qcuPY15WI
         cNEA==
X-Gm-Message-State: AC+VfDw9pyxD//gLo9aLvlkKkwnKOqG/i5dTHEQMcFeNL6+yUj+xi2o6
        X2/3uCPAhdvphA6Kmjvvlqncpw==
X-Google-Smtp-Source: ACHHUZ5n0ktk0pGSlf8ODuwS2HY5zZGV37C2wJ0GZgPIWg5BKM7dFIJcAX//tvNrRrreST+xVlo2yg==
X-Received: by 2002:a2e:9091:0:b0:2ad:ac93:3c7d with SMTP id l17-20020a2e9091000000b002adac933c7dmr9481189ljg.38.1684403711998;
        Thu, 18 May 2023 02:55:11 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002a93e0605ebsm215873ljh.8.2023.05.18.02.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:55:11 -0700 (PDT)
Message-ID: <f4854178-613c-5ace-5714-d77b7f71a914@linaro.org>
Date:   Thu, 18 May 2023 11:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sc8280xp: Add SDC2 and enable on CRD
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517235217.1728548-1-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230517235217.1728548-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.05.2023 01:52, Bjorn Andersson wrote:
> The CRD has Micro SD slot, introduce the necessary DeviceTree nodes for
> enabling this.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Order of pinctr-N and pinctrl-names
> - Reset GCC_SDCC2_BCR and not sdc4
b4 diff 20230517235217.1728548-1-quic_bjorande@quicinc.com also reveals:

- move cd-gpios
- add interconnect OPP properties

nevertheless:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

> 
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 81 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 43 ++++++++++++
>  2 files changed, 124 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 5b25d54b9591..ff9cebbccfcb 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -308,6 +308,13 @@ vreg_l1c: ldo1 {
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l7c: ldo7 {
>  			regulator-name = "vreg_l7c";
>  			regulator-min-microvolt = <2504000>;
> @@ -318,6 +325,13 @@ vreg_l7c: ldo7 {
>  						   RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> +		vreg_l9c: ldo9 {
> +			regulator-name = "vreg_l9c";
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
>  		vreg_l13c: ldo13 {
>  			regulator-name = "vreg_l13c";
>  			regulator-min-microvolt = <3072000>;
> @@ -600,6 +614,19 @@ &remoteproc_nsp0 {
>  	status = "okay";
>  };
>  
> +&sdc2 {
> +	pinctrl-0 = <&sdc2_default_state>;
> +	pinctrl-1 = <&sdc2_sleep_state>;
> +	pinctrl-names = "default", "sleep";
> +
> +	vmmc-supply = <&vreg_l9c>;
> +	vqmmc-supply = <&vreg_l6c>;
> +
> +	cd-gpios = <&tlmm 131 GPIO_ACTIVE_LOW>;
> +
> +	status = "okay";
> +};
> +
>  &uart17 {
>  	compatible = "qcom,geni-debug-uart";
>  
> @@ -842,6 +869,60 @@ wake-n-pins {
>  		};
>  	};
>  
> +	sdc2_default_state: sdc2-default-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			drive-strength = <16>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		card-detect-pins {
> +			pins = "gpio131";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
> +	sdc2_sleep_state: sdc2-sleep-state {
> +		clk-pins {
> +			pins = "sdc2_clk";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "sdc2_cmd";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "sdc2_data";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +
> +		card-detect-pins {
> +			pins = "gpio131";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +	};
> +
>  	tpad_default: tpad-default-state {
>  		int-n-pins {
>  			pins = "gpio182";
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fa9fbfe5d00..3711f109aeaf 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2815,6 +2815,49 @@ data-pins {
>  			};
>  		};
>  
> +		sdc2: mmc@8804000 {
> +			compatible = "qcom,sc8280xp-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC2_BCR>;
> +			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> +			iommus = <&apps_smmu 0x4e0 0x0>;
> +			power-domains = <&rpmhpd SC8280XP_CX>;
> +			operating-points-v2 = <&sdc2_opp_table>;
> +			bus-width = <4>;
> +			dma-coherent;
> +
> +			status = "disabled";
> +
> +			sdc2_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1800000 400000>;
> +					opp-avg-kBps = <100000 0>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_svs_l1>;
> +					opp-peak-kBps = <5400000 1600000>;
> +					opp-avg-kBps = <200000 0>;
> +				};
> +			};
> +		};
> +
>  		usb_0_qmpphy: phy@88eb000 {
>  			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
>  			reg = <0 0x088eb000 0 0x4000>;
