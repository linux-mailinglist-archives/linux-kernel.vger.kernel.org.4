Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE322616E37
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKBUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKBUDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:03:12 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDD39E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:03:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c15so5098700qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=517spUF1kwfdZsdZ7/2zDcp2hjttlHr/tComnIWdl1M=;
        b=tinB3Gji0G1MZQ/+Z6bdF7M3u1iPSbkrXmozh9/ZKWdCdZ+RTqWc5vkjk9Ts+Y/tri
         uvGW5ulhLUzLaUduzEDPWRsAspkBOpasmmGZbMJF31RSmH6TGdHA6A1xT5lrjwJIb9Zw
         6g9NiVDvjc3GAIUJlcAQQnjvimlA5ysVktrH4mnOV18aNAsG4mqWnouKQO9RoIuIAY6/
         zxy9gUJWKWAF4kwlEhShVD3386a8eza5cIi5n9csfOU87ijw4czLSU466gCm/2ZCUiCo
         QUHafIdEgFRCqBjxb3vjnUQt1P1GufbRNXp3bNeSiXbof+EQHOO9CttQpQuQafXnd/tw
         mA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=517spUF1kwfdZsdZ7/2zDcp2hjttlHr/tComnIWdl1M=;
        b=8FQmakm2V8YzhB27Q7Gt3cltCw/GQErfZ7PEVCt3kQ2O/3FMMImdKoIA0E6K0iyJds
         xzHJbNyZwrJ9Ky5YusjHb7r3eHbP6KHodNoxLyLlOn3az+iwgQfXzfjLMOb8J6ORibFB
         q+EksXpdoGLYk4kGNxK6AbrCekLNQI80YV9+UVqYYYirbOzft9GHwQPAffKhp4upV5t8
         PXxMjSFhqp+RqWntD4wJt0vksQCFtzHB3EpqssV+otb3s4YSNEOkuHET+4044W9LgGTK
         b22Lsm++eoSaePAYee493BVCpLoUkLvdQ7kUmcjnxUJBMiMTWOsRrb5jx5+xHNunMlyH
         L/fg==
X-Gm-Message-State: ACrzQf0j2tJsaPcIgraqIshdvARI13ml44O54rAEtRE7tgRgTwK768a0
        BM5zyCDlaRVKI8KfTbTmH4DnaA==
X-Google-Smtp-Source: AMsMyM71M4tXWg/0+TGpHv1kwjmlS5QW+YALrs4Jc8kAEFVEOejhHclXgDolpirSwzzZUQ6cYdqeog==
X-Received: by 2002:ac8:520c:0:b0:3a5:3ae3:5936 with SMTP id r12-20020ac8520c000000b003a53ae35936mr8078118qtn.529.1667419389237;
        Wed, 02 Nov 2022 13:03:09 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006bc192d277csm9277769qko.10.2022.11.02.13.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:03:08 -0700 (PDT)
Message-ID: <50209486-8f86-c84c-8493-c48a6b57e6c6@linaro.org>
Date:   Wed, 2 Nov 2022 16:03:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: Add MSM8976 device tree
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221101191659.172416-1-a39.skl@gmail.com>
 <20221101191659.172416-2-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221101191659.172416-2-a39.skl@gmail.com>
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

On 01/11/2022 15:16, Adam Skladowski wrote:
> Add a base DT for MSM8976 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 1310 +++++++++++++++++++++++++
>  1 file changed, 1310 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> new file mode 100644
> index 0000000000000..c073f16faa7ee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -0,0 +1,1310 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8976.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	clocks {
> +		xo_board_clk: xo_board_clk {

No underscores in node names.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +		};
> +
> +		sleep_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
> +	};
> +

(...)

> +
> +		tcsr_mutex: hwlock@1905000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x01905000 0x20000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		tcsr: syscon@1937000 {
> +			compatible = "qcom,tcsr-msm8976", "syscon";

Where is the documentation?

> +			reg = <0x01937000 0x30000>;
> +		};
> +
> +		mdss: mdss@1a00000 {
> +			compatible = "qcom,mdss";
> +
> +			reg = <0x01a00000 0x1000>,
> +			      <0x01ab0000 0x1040>;
> +			reg-names = "mdss_phys",
> +				    "vbif_phys";
> +
> +			power-domains = <&gcc MDSS_GDSC>;
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_MDSS_AXI_CLK>,
> +				 <&gcc GCC_MDSS_VSYNC_CLK>,
> +				 <&gcc GCC_MDSS_MDP_CLK>;
> +			clock-names = "iface",
> +				      "bus",
> +				      "vsync",
> +				      "core";
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdp: mdp@1a01000 {

I think other DTSes use different node name...

> +				compatible = "qcom,mdp5";
> +				reg = <0x01a01000 0x89000>;
> +				reg-names = "mdp_phys";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
> +
> +				power-domains = <&gcc MDSS_GDSC>;
> +
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_VSYNC_CLK>,
> +					 <&gcc GCC_MDP_TBU_CLK>,
> +					 <&gcc GCC_MDP_RT_TBU_CLK>;
> +				clock-names = "iface",
> +					      "bus",
> +					      "core",
> +					      "vsync",
> +					      "tbu",
> +					      "tbu_rt";
> +				iommus = <&apps_iommu 0x17>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdp5_intf1_out: endpoint {
> +							remote-endpoint = <&dsi0_in>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdp5_intf2_out: endpoint {
> +							remote-endpoint = <&dsi1_in>;
> +						};
> +					};
> +				};
> +			};
> +
> +			dsi0: dsi@1a94000 {
> +				compatible = "qcom,mdss-dsi-ctrl";
> +				reg = <0x01a94000 0x2d4>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4>;
> +
> +				assigned-clocks = <&gcc GCC_MDSS_BYTE0_CLK_SRC>,
> +						  <&gcc GCC_MDSS_PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&dsi0_phy 0>,
> +							 <&dsi0_phy 1>;
> +
> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
> +					 <&gcc GCC_MDSS_ESC0_CLK>;
> +				clock-names = "mdp_core",
> +					      "iface",
> +					      "bus",
> +					      "byte",
> +					      "pixel",
> +					      "core";
> +
> +				phys = <&dsi0_phy>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dsi0_in: endpoint {
> +							remote-endpoint = <&mdp5_intf1_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dsi0_out: endpoint {
> +						};
> +					};
> +				};
> +			};
> +
> +			dsi0_phy: phy@1a94400 {
> +				compatible = "qcom,dsi-phy-28nm-hpm-fam-b";
> +				reg = <0x01a94400 0x20c>,
> +				      <0x01a94b80 0x2c>,
> +				      <0x01a94a00 0xd4>;
> +				reg-names = "dsi_phy",
> +					    "dsi_phy_regulator",
> +					    "dsi_pll";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +				clock-names = "iface", "ref";
> +
> +				status = "disabled";
> +			};
> +
> +			dsi1: dsi@1a96000 {
> +				compatible = "qcom,mdss-dsi-ctrl";
> +				reg = <0x01a96000 0x2d4>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <5>;
> +
> +				assigned-clocks = <&gcc GCC_MDSS_BYTE1_CLK_SRC>,
> +						  <&gcc GCC_MDSS_PCLK1_CLK_SRC>;
> +				assigned-clock-parents = <&dsi1_phy 0>,
> +							 <&dsi1_phy 1>;
> +
> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
> +					 <&gcc GCC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_MDSS_AXI_CLK>,
> +					 <&gcc GCC_MDSS_BYTE1_CLK>,
> +					 <&gcc GCC_MDSS_PCLK1_CLK>,
> +					 <&gcc GCC_MDSS_ESC1_CLK>;
> +				clock-names = "mdp_core",
> +					      "iface",
> +					      "bus",
> +					      "byte",
> +					      "pixel",
> +					      "core";
> +
> +				phys = <&dsi1_phy>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dsi1_in: endpoint {
> +							remote-endpoint = <&mdp5_intf2_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dsi1_out: endpoint {
> +						};
> +					};
> +				};
> +			};
> +
> +			dsi1_phy: phy@1a96400 {
> +				compatible = "qcom,dsi-phy-28nm-hpm-fam-b";
> +				reg = <0x01a96400 0x20c>,
> +				      <0x01a96b80 0x2c>,
> +				      <0x01a96a00 0xd4>;
> +				reg-names = "dsi_phy",
> +					    "dsi_phy_regulator",
> +					    "dsi_pll";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +				clock-names = "iface", "ref";
> +
> +				status = "disabled";
> +			};
> +		};
> +
> +		apps_iommu: iommu@1e00000 {
> +			compatible = "qcom,msm-iommu-v1";
> +			ranges  = <0 0x01e20000 0x20000>;
> +
> +			clocks = <&gcc GCC_SMMU_CFG_CLK>,
> +				 <&gcc GCC_APSS_TCU_CLK>;
> +			clock-names = "iface", "bus";
> +
> +			qcom,iommu-secure-id = <17>;
> +
> +			#address-cells = <1>;
> +			#iommu-cells = <1>;
> +			#size-cells = <1>;
> +
> +			/* MDP_0 */
> +			iommu-ctx@17000 {
> +				compatible = "qcom,msm-iommu-v1-ns";
> +				reg = <0x17000 0x1000>;
> +				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		spmi_bus: spmi@200f000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x0200f000 0x1000>,
> +			      <0x02400000 0x800000>,
> +			      <0x02c00000 0x800000>,
> +			      <0x03800000 0x200000>,
> +			      <0x0200a000 0x2100>;
> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +			interrupt-names = "periph_irq";
> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,ee = <0>;
> +			qcom,channel = <0>;
> +			interrupt-controller;
> +
> +			#interrupt-cells = <4>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
> +		sdhc_1: mmc@7824900 {
> +			compatible = "qcom,sdhci-msm-v4";
> +
> +			reg = <0x07824900 0x500>, <0x07824000 0x800>;
> +			reg-names = "hc", "core";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "iface", "core", "xo";
> +
> +			power-domains = <&rpmpd MSM8976_VDDCX>;
> +			operating-points-v2 = <&sdhc1_opp_table>;
> +
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on &sdc1_rclk_on>;
> +			pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off &sdc1_rclk_off>;
> +
> +			mmc-hs400-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-ddr-1_8v;
> +			bus-width = <8>;
> +			non-removable;
> +
> +			status = "disabled";
> +
> +			sdhc1_opp_table: opp-table-sdhc1 {

Did you test the DTS with dtbs_check?


Best regards,
Krzysztof

