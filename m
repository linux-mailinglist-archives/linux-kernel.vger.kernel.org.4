Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B41624089
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiKJK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiKJK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:58:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F83B175B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:58:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id b2so3996209eja.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 02:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9v0NQl0KfKBC4DHwYquqtrofNZ7QFlryD3QBLl4KBs=;
        b=NLw6Q54kJJe7lJBpU95vDKD1QE5G5OIihBBLqMEU8o5BhHkjLWipkMTy6xunEplxFn
         6VqGf9qkVB1pmYN6tcBKHzjy+vDzcWulz3zeWb0AIQ1p9+vOxj/Op2FCsvcUg7okQl5z
         uvc7ODsb6nEUyErFOj8hohKPQYaU1scFgampmcHgqJL09zoVJoShFqukjP4ol7BuWZcL
         /vJJWtCP3vNlL6dRKgUHzdERHwTzRnhyf9g5aLmCWm2X2ubW8V8u1gK/fKQFcgc2lG/O
         Fa94hLCp5vc/pMJz+Cy0v0ofCDGiLirGSpzHBUeDCpBELDtmpgwMTQiaPtaReaqmtVoK
         h5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j9v0NQl0KfKBC4DHwYquqtrofNZ7QFlryD3QBLl4KBs=;
        b=fad2ZWB73CeXa82iL/Q+TT4ugJRvr7c7gDvKTWwTk/RUCRTG8f+Y89d8yAl5YxDa9e
         tJeh+J4vMwOtyBlG+yLYPubSRtg643hurrUI1WJie9GuV7lt5knHnzscJXdvWImN+lZv
         v8mll4Zoy0uXSjNNL5EkblrXGm/XFf8BdLq/+LZgvego5kFWA/IZx2J70C2qGUFHA2Q9
         WYe3R25/WE0/ZsQVeVofMv/nSCipUc3swpyIik7SzeEJ085Zfkrzxv9z/mKoHLqBuFOq
         XBu3mFw7DtZban+Y/ptXPl3a1F5xThsTtLVfVSoLA+XfM+q3aZgSmNo3Pidys2Jp2X0V
         7QaA==
X-Gm-Message-State: ACrzQf0N4qev5GGXWOCvWajb3+dmS8977kPy2Fq/LIRbVUWhPLusZ+jr
        kVOLbPnSMiI+ajfS/LqZX4ZKJQ==
X-Google-Smtp-Source: AMsMyM5hdouEf+WKGGMUdkcAlH8i4BPCBdmIjJAflPa89gqw+sEiFzlUwb57sefzp7H815Yd9torGA==
X-Received: by 2002:a17:906:846d:b0:7ad:90dd:4b6 with SMTP id hx13-20020a170906846d00b007ad90dd04b6mr58411135ejc.492.1668077930775;
        Thu, 10 Nov 2022 02:58:50 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id n20-20020aa7c794000000b00459012e5145sm8327840eds.70.2022.11.10.02.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 02:58:50 -0800 (PST)
Message-ID: <8fc72b74-80b5-1e9c-2341-4e9c4d78c4e9@linaro.org>
Date:   Thu, 10 Nov 2022 11:58:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110103558.12690-1-johan+linaro@kernel.org>
 <20221110103558.12690-2-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221110103558.12690-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 10/11/2022 11:35, Johan Hovold wrote:
> The SC8280XP platform has seven PCIe controllers:
>
> 	PCIe0	USB4
> 	PCIe1	USB4
> 	PCIe2A	4-lane
> 	PCIe2B	2-lane
> 	PCIe3A	4-lane
> 	PCIe3B	2-lane
> 	PCIe4	1-lane
>
> while SA8540P only has five (PCIe2-4).
>
> Add devicetree nodes for the PCIe2-4 controllers and their PHYs.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>   arch/arm64/boot/dts/qcom/sa8540p.dtsi  |  59 +++
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 493 ++++++++++++++++++++++++-
>   2 files changed, 547 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> index 8ea2886fbab2..01a24b6a5e6d 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> @@ -128,6 +128,65 @@ opp-2592000000 {
>   	};
>   };
>   
> +&pcie2a {
> +	compatible = "qcom,pcie-sa8540p";
> +
> +	linux,pci-domain = <0>;
> +
> +	interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "msi";
> +};
> +
> +&pcie2b {
> +	compatible = "qcom,pcie-sa8540p";
> +
> +	linux,pci-domain = <1>;
> +
> +	interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "msi";
> +};
> +
> +&pcie3a {
> +	compatible = "qcom,pcie-sa8540p";
> +	reg = <0x0 0x01c10000 0x0 0x3000>,
> +	      <0x0 0x40000000 0x0 0xf1d>,
> +	      <0x0 0x40000f20 0x0 0xa8>,
> +	      <0x0 0x40001000 0x0 0x1000>,
> +	      <0x0 0x40100000 0x0 0x100000>;
> +	reg-names = "parf", "dbi", "elbi", "atu", "config";
> +
> +	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
> +		 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1d00000>;
> +
> +	linux,pci-domain = <2>;
> +
> +	interrupts =  <GIC_SPI 567 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "msi";
> +
> +	interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 541 IRQ_TYPE_LEVEL_HIGH>,
> +			<0 0 0 2 &intc 0 0 GIC_SPI 542 IRQ_TYPE_LEVEL_HIGH>,
> +			<0 0 0 3 &intc 0 0 GIC_SPI 543 IRQ_TYPE_LEVEL_HIGH>,
> +			<0 0 0 4 &intc 0 0 GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&pcie3b {
> +	compatible = "qcom,pcie-sa8540p";
> +
> +	linux,pci-domain = <3>;
> +
> +	interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "msi";
> +};
> +
> +&pcie4 {
> +	compatible = "qcom,pcie-sa8540p";
> +
> +	linux,pci-domain = <4>;
> +
> +	interrupts = <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "msi";
> +};
> +
>   &rpmhpd {
>   	compatible = "qcom,sa8540p-rpmhpd";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 6bc12e507d21..27f5c2f82338 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -729,11 +729,11 @@ gcc: clock-controller@100000 {
>   				 <0>,
>   				 <0>,
>   				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&pcie2a_phy>,
> +				 <&pcie2b_phy>,
> +				 <&pcie3a_phy>,
> +				 <&pcie3b_phy>,
> +				 <&pcie4_phy>,
>   				 <0>,
>   				 <0>;
>   			power-domains = <&rpmhpd SC8280XP_CX>;
> @@ -839,6 +839,489 @@ qup1: geniqup@ac0000 {
>   			status = "disabled";
>   		};
>   
> +		pcie4: pcie@1c00000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sc8280xp";
> +			reg = <0x0 0x01c00000 0x0 0x3000>,
> +			      <0x0 0x30000000 0x0 0xf1d>,
> +			      <0x0 0x30000f20 0x0 0xa8>,
> +			      <0x0 0x30001000 0x0 0x1000>,
> +			      <0x0 0x30100000 0x0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x30200000 0x0 0x30200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x30300000 0x0 0x30300000 0x0 0x1d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			linux,pci-domain = <6>;
> +			num-lanes = <1>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
> +				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_4_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_4_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_4_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>,
> +				 <&gcc GCC_CNOC_PCIE4_QX_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr_4",
> +				      "noc_aggr_south_sf",
> +				      "cnoc_qx";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_4_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&aggre2_noc MASTER_PCIE_4 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_4 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			resets = <&gcc GCC_PCIE_4_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_4_GDSC>;
> +
> +			phys = <&pcie4_phy>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
> +
> +		pcie4_phy: phy@1c06000 {
> +			compatible = "qcom,sc8280xp-qmp-gen3x1-pcie-phy";
> +			reg = <0x0 0x01c06000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
> +				 <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_4_CLKREF_CLK>,
> +				 <&gcc GCC_PCIE4_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_4_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_4_PIPEDIV2_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> +				      "pipe", "pipediv2";
> +
> +			assigned-clocks = <&gcc GCC_PCIE4_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_4_GDSC>;
> +
> +			resets = <&gcc GCC_PCIE_4_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_4_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie3b: pcie@1c08000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sc8280xp";
> +			reg = <0x0 0x01c08000 0x0 0x3000>,
> +			      <0x0 0x32000000 0x0 0xf1d>,
> +			      <0x0 0x32000f20 0x0 0xa8>,
> +			      <0x0 0x32001000 0x0 0x1000>,
> +			      <0x0 0x32100000 0x0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x32300000 0x0 0x32300000 0x0 0x1d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			linux,pci-domain = <5>;
> +			num-lanes = <2>;
> +
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 526 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_3B_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3B_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_3B_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3B_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3B_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr_4",
> +				      "noc_aggr_south_sf";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_3B_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&aggre2_noc MASTER_PCIE_3B 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_3B 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			resets = <&gcc GCC_PCIE_3B_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_3B_GDSC>;
> +
> +			phys = <&pcie3b_phy>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
> +
> +		pcie3b_phy: phy@1c0e000 {
> +			compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy";
> +			reg = <0x0 0x01c0e000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_3B_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3B_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_3A3B_CLKREF_CLK>,
> +				 <&gcc GCC_PCIE3B_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_3B_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_3B_PIPEDIV2_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> +				      "pipe", "pipediv2";
> +
> +			assigned-clocks = <&gcc GCC_PCIE3B_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_3B_GDSC>;
> +
> +			resets = <&gcc GCC_PCIE_3B_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_3b_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie3a: pcie@1c10000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sc8280xp";
> +			reg = <0x0 0x01c10000 0x0 0x3000>,
> +			      <0x0 0x34000000 0x0 0xf1d>,
> +			      <0x0 0x34000f20 0x0 0xa8>,
> +			      <0x0 0x34001000 0x0 0x1000>,
> +			      <0x0 0x34100000 0x0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x34200000 0x0 0x34200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x34300000 0x0 0x34300000 0x0 0x1d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			linux,pci-domain = <4>;
> +			num-lanes = <4>;
> +
> +			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 GIC_SPI 542 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 GIC_SPI 543 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_3A_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3A_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_3A_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3A_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_3A_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr_4",
> +				      "noc_aggr_south_sf";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_3A_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&aggre2_noc MASTER_PCIE_3A 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_3A 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			resets = <&gcc GCC_PCIE_3A_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_3A_GDSC>;
> +
> +			phys = <&pcie3a_phy>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
> +
> +		pcie3a_phy: phy@1c14000 {
> +			compatible = "qcom,sc8280xp-qmp-gen3x4-pcie-phy";
> +			reg = <0x0 0x01c14000 0x0 0x2000>,
> +			      <0x0 0x01c16000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_3A_AUX_CLK>,
> +				 <&gcc GCC_PCIE_3A_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_3A3B_CLKREF_CLK>,
> +				 <&gcc GCC_PCIE3A_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_3A_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_3A_PIPEDIV2_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> +				      "pipe", "pipediv2";
> +
> +			assigned-clocks = <&gcc GCC_PCIE3A_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_3A_GDSC>;
> +
> +			resets = <&gcc GCC_PCIE_3A_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			qcom,4ln-config-sel = <&tcsr 0xa044 1>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_3a_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie2b: pcie@1c18000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sc8280xp";
> +			reg = <0x0 0x01c18000 0x0 0x3000>,
> +			      <0x0 0x38000000 0x0 0xf1d>,
> +			      <0x0 0x38000f20 0x0 0xa8>,
> +			      <0x0 0x38001000 0x0 0x1000>,
> +			      <0x0 0x38100000 0x0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x38200000 0x0 0x38200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x38300000 0x0 0x38300000 0x0 0x1d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			linux,pci-domain = <3>;
> +			num-lanes = <2>;
> +
> +			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 GIC_SPI 434 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 GIC_SPI 435 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_2B_AUX_CLK>,
> +				 <&gcc GCC_PCIE_2B_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_2B_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_2B_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_2B_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr_4",
> +				      "noc_aggr_south_sf";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_2B_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&aggre2_noc MASTER_PCIE_2B 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_2B 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			resets = <&gcc GCC_PCIE_2B_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_2B_GDSC>;
> +
> +			phys = <&pcie2b_phy>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
> +
> +		pcie2b_phy: phy@1c1e000 {
> +			compatible = "qcom,sc8280xp-qmp-gen3x2-pcie-phy";
> +			reg = <0x0 0x01c1e000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_2B_AUX_CLK>,
> +				 <&gcc GCC_PCIE_2B_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_2A2B_CLKREF_CLK>,
> +				 <&gcc GCC_PCIE2B_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_2B_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_2B_PIPEDIV2_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> +				      "pipe", "pipediv2";
> +
> +			assigned-clocks = <&gcc GCC_PCIE2B_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_2B_GDSC>;
> +
> +			resets = <&gcc GCC_PCIE_2B_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_2b_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie2a: pcie@1c20000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-sc8280xp";
> +			reg = <0x0 0x01c20000 0x0 0x3000>,
> +			      <0x0 0x3c000000 0x0 0xf1d>,
> +			      <0x0 0x3c000f20 0x0 0xa8>,
> +			      <0x0 0x3c001000 0x0 0x1000>,
> +			      <0x0 0x3c100000 0x0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
> +			bus-range = <0x00 0xff>;
> +
> +			linux,pci-domain = <2>;
> +			num-lanes = <4>;
> +
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0", "msi1", "msi2", "msi3";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 0 GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 0 GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 0 GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
> +				 <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_2A_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_2A_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_2A_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "ddrss_sf_tbu",
> +				      "noc_aggr_4",
> +				      "noc_aggr_south_sf";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_2A_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			interconnects = <&aggre2_noc MASTER_PCIE_2A 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_2A 0>;
> +			interconnect-names = "pcie-mem", "cpu-pcie";
> +
> +			resets = <&gcc GCC_PCIE_2A_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_2A_GDSC>;
> +
> +			phys = <&pcie2a_phy>;
> +			phy-names = "pciephy";
> +
> +			status = "disabled";
> +		};
> +
> +		pcie2a_phy: phy@1c24000 {
> +			compatible = "qcom,sc8280xp-qmp-gen3x4-pcie-phy";
> +			reg = <0x0 0x01c24000 0x0 0x2000>,
> +			      <0x0 0x01c26000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
> +				 <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_2A2B_CLKREF_CLK>,
> +				 <&gcc GCC_PCIE2A_PHY_RCHNG_CLK>,
> +				 <&gcc GCC_PCIE_2A_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_2A_PIPEDIV2_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> +				      "pipe", "pipediv2";
> +
> +			assigned-clocks = <&gcc GCC_PCIE2A_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_2A_GDSC>;
> +
> +			resets = <&gcc GCC_PCIE_2A_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			qcom,4ln-config-sel = <&tcsr 0xa044 0>;
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "pcie_2a_pipe_clk";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>   		ufs_mem_hc: ufs@1d84000 {
>   			compatible = "qcom,sc8280xp-ufshc", "qcom,ufshc",
>   				     "jedec,ufs-2.0";
