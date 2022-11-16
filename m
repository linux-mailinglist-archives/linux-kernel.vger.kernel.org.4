Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253FF62BF26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKPNNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKPNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:13:17 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9129F3FB82
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:13:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ft34so43877985ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aVpr67nkvgGNhxaceuuhsEtIRCHf7EhQZe5/KHUx4I=;
        b=bwZFyV7TShFxQa26cIZ5w6gJxDKIyv4b6l09CuArTXd4+hr8vyguKmxnrG54mfPvrY
         2qNTjcqjLQ1oF+lHE9PfmeGnPkOBeHBm7Ys6Rmq4xWZCzZdLpSZVAYkgV27zBsFeQ7If
         UVgbbQcP0PQS6N/wSyjr4Z3zPdQoytIIiH2mWbUL6EpZP2vuwH6NHpRseGs9rXfDzC/+
         abv1mQJ75vqasW8N+NQs1xXcwqbnD9ls8lUJqNaGMd/Ms2R3CDKSEH4zArGD0hHzPztn
         3NTNeYF8GqDnF7NOd53S5gx/1MmN5V9D7FZ8jwfP/jogvtexf880MHa4gdHxf0kWvVya
         0OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1aVpr67nkvgGNhxaceuuhsEtIRCHf7EhQZe5/KHUx4I=;
        b=18sRb1FiNmPQXm9cCgEs4kcZ63Tr93lOC800kWmkBMmEhi090PR0JIBdkQq2X+7DW4
         F6GMdg9Xkm6UdflRhmbqBaTzLkU+aDQubqacpaJs0y+N1z7LPHtTQj2WAEp6dN5qfktW
         QUhO5VtRnHyFg4v9nt7BJZV4P7IRjAV3DrERxm6EeF5shm4EvOHrHQaDE7nfWe7DPsY8
         h4kl5nMg2IH5zMURpuWnBUdvQZ7eQobkk4lsR9dNEchV4JTHJ+tmP+x5RJjk05VJK3h+
         dUnHqbF6ZML4PylZYJ9Uhu2yk09SUHPz3T8vJ3dzZfHlO5ZcV7zWQENLNXGZhi+vFFPo
         LIjA==
X-Gm-Message-State: ANoB5pkovX/ZwNwuvXyr2fCvrFpn9KryYJTI/0iyhH9L7+ctHV0ei1Lg
        VDohDacmZr3XxygD97f1QeqJvntagxiDIyog
X-Google-Smtp-Source: AA0mqf4Zd80kII6SgxOHcrWHz9gvuwLNLDQHcycKT6kqdTeJh/Bz0XSVV5xJTgs5PWpyfFd3FFklGw==
X-Received: by 2002:a17:907:9d05:b0:7ae:3684:2118 with SMTP id kt5-20020a1709079d0500b007ae36842118mr18145603ejc.127.1668604394013;
        Wed, 16 Nov 2022 05:13:14 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b007aed2057ea1sm6262737eju.167.2022.11.16.05.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:13:13 -0800 (PST)
Message-ID: <20acabbd-6de9-c0d3-98fe-9a4c4a5ec2dc@linaro.org>
Date:   Wed, 16 Nov 2022 14:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221116130430.2812173-1-abel.vesa@linaro.org>
 <20221116130430.2812173-2-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221116130430.2812173-2-abel.vesa@linaro.org>
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



On 16/11/2022 14:04, Abel Vesa wrote:
> Add PCIe controllers and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 245 +++++++++++++++++++++++++++
>   1 file changed, 245 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 07ba709ca35f..5c274d0372ad 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -648,12 +648,16 @@ gcc: clock-controller@100000 {
>   			#reset-cells = <1>;
>   			#power-domain-cells = <1>;
>   			clock-names = "bi_tcxo", "sleep_clk",
> +				      "pcie_0_pipe_clk",
> +				      "pcie_1_pipe_clk",
>   				      "pcie_1_phy_aux_clk",
>   				      "ufs_phy_rx_symbol_0_clk",
>   				      "ufs_phy_rx_symbol_1_clk",
>   				      "ufs_phy_tx_symbol_0_clk",
>   				      "usb3_phy_wrapper_gcc_usb30_pipe_clk";
Is gcc not going to use index-based matching? clock-names is redundant 
in that case.

>   			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>,
> +				 <&pcie0_lane>,
> +				 <&pcie1_lane>,
>   				 <&pcie_1_phy_aux_clk>,
>   				 <&ufs_phy_rx_symbol_0_clk>,
>   				 <&ufs_phy_rx_symbol_1_clk>,
> @@ -1372,6 +1376,247 @@ mmss_noc: interconnect@1780000 {
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-sm8550-pcie0";
> +			reg = <0 0x01c00000 0 0x3000>,
> +			      <0 0x60000000 0 0xf1d>,
> +			      <0 0x60000f20 0 0xa8>,
> +			      <0 0x60001000 0 0x1000>,
> +			      <0 0x60100000 0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> +
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			interconnect-names = "icc_path";
> +			interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
> +				 <&pcie0_lane>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
> +			clock-names = "pipe",
> +					"pipe_mux",
> +					"phy_pipe",
> +					"ref",
> +					"aux",
> +					"cfg",
> +					"bus_master",
> +					"bus_slave",
> +					"slave_q2a",
> +					"ddrss_sf_tbu",
> +					"aggre0";
> +
> +			iommus = <&apps_smmu 0x1400 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1400 0x1>,
> +				    <0x100 &apps_smmu 0x1401 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_0_BCR>;
> +			reset-names = "pci";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +			power-domain-names = "gdsc";
> +
> +			phys = <&pcie0_lane>;
> +			phy-names = "pciephy";
> +
> +			perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +			wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie0_default_state>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie0_phy: phy@1c06000 {
> +			compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy";
> +			reg = <0 0x01c06000 0 0x200>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&tcsr TCSR_PCIE_0_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>;
> +			reset-names = "phy";
> +
> +			assigned-clocks = <&gcc GCC_PCIE_0_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_0_PHY_GDSC>;
> +			power-domain-names = "gdsc";
> +
> +			status = "disabled";
> +
> +			pcie0_lane: phy@1c06200 {
> +				reg = <0 0x1c06e00 0 0x200>, /* tx0 */
> +				      <0 0x1c07000 0 0x200>, /* rx0 */
> +				      <0 0x1c06200 0 0x200>, /* pcs */
> +				      <0 0x1c07600 0 0x200>, /* tx1 */
> +				      <0 0x1c07800 0 0x200>, /* rx1 */
> +				      <0 0x1c06600 0 0x200>; /* pcs_pcie */
> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> +				clock-names = "pipe0";
> +
> +				#clock-cells = <0>;
> +				#phy-cells = <0>;
> +				clock-output-names = "pcie_0_pipe_clk";
> +			};
> +		};
> +
> +		pcie1: pci@1c08000 {
> +			compatible = "qcom,pcie-sm8550-pcie1";
> +			reg = <0x0 0x01c08000 0x0 0x3000>,
> +			      <0x0 0x40000000 0x0 0xf1d>,
> +			      <0x0 0x40000f20 0x0 0xa8>,
> +			      <0x0 0x40001000 0x0 0x1000>,
> +			      <0x0 0x40100000 0x0 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;
> +			num-lanes = <2>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
> +
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +					<0 0 0 3 &intc 0 0 0 438 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +					<0 0 0 4 &intc 0 0 0 439 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
> +				 <&pcie1_lane>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
> +				 <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
> +				 <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
> +			clock-names = "pipe",
> +					"pipe_mux",
> +					"phy_pipe",
> +					"ref",
> +					"aux",
> +					"cfg",
> +					"bus_master",
> +					"bus_slave",
> +					"slave_q2a",
> +					"ddrss_sf_tbu",
> +					"aggre1",
> +					"cnoc_pcie_sf_axi";
> +
> +			interconnect-names = "icc_path";
> +			interconnects = <&pcie_noc MASTER_PCIE_1 0 &mc_virt SLAVE_EBI1 0>;
> +
> +			iommus = <&apps_smmu 0x1480 0x7f>;
> +			iommu-map = <0x0   &apps_smmu 0x1480 0x1>,
> +				    <0x100 &apps_smmu 0x1481 0x1>;
> +
> +			resets = <&gcc GCC_PCIE_1_BCR>,
> +				<&gcc GCC_PCIE_1_LINK_DOWN_BCR>;
> +			reset-names = "pci",
> +				"pcie_1_link_down_reset";
> +
> +			power-domains = <&gcc PCIE_1_GDSC>;
> +			power-domain-names = "gdsc";
> +
> +			phys = <&pcie1_lane>;
> +			phy-names = "pciephy";
> +
> +			perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +			enable-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pcie1_default_state>;
> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
> +			assigned-clock-rates = <19200000>;
> +
> +			status = "disabled";
> +		};
> +
> +		pcie1_phy: phy@1c0f000 {
> +			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
> +			reg = <0x0 0x01c0f000 0x0 0x200>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
> +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> +				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
> +				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
> +			clock-names = "aux", "aux_phy", "cfg_ahb", "ref", "refgen";
> +
> +			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
> +				<&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
Indentation seems off.

> +			reset-names = "phy",
> +				"pcie_1_nocsr_com_phy_reset";
Identation is off. Won't these two fit in a single 100char line?

Konrad
> +
> +			assigned-clocks = <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>;
> +			assigned-clock-rates = <100000000>;
> +
> +			power-domains = <&gcc PCIE_1_PHY_GDSC>;
> +			power-domain-names = "phy_gdsc";
> +
> +			status = "disabled";
> +
> +			pcie1_lane: phy@1c0e000 {
> +				reg = <0x0 0x1c0e000 0x0 0x200>, /* tx */
> +				      <0x0 0x1c0e200 0x0 0x300>, /* rx */
> +				      <0x0 0x1c0f200 0x0 0x200>, /* pcs */
> +				      <0x0 0x1c0e800 0x0 0x200>, /* tx */
> +				      <0x0 0x1c0ea00 0x0 0x300>, /* rx */
> +				      <0x0 0x1c0f400 0x0 0xc00>, /* pcs_pcie */
> +				      <0x0 0x1c0ee00 0x0 0x0a0>; /* ln_shrd */
> +				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
> +				clock-names = "pipe0";
> +
> +				#clock-cells = <0>;
> +				#phy-cells = <0>;
> +				clock-output-names = "pcie_1_pipe_clk";
> +			};
> +		};
> +
>   		tcsr_mutex: hwlock@1f40000 {
>   			compatible = "qcom,tcsr-mutex";
>   			reg = <0x0 0x01f40000 0x0 0x20000>;
