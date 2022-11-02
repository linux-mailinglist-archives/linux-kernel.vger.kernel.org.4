Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28C16158FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiKBDCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiKBDCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:02:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819B23173;
        Tue,  1 Nov 2022 20:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C693B82064;
        Wed,  2 Nov 2022 03:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602D2C433D7;
        Wed,  2 Nov 2022 03:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667358106;
        bh=dwIT5rypTjwiCTFmzBS1psRiHB9iznS6Jcp2NjpTzLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cgofEyXqLJpTj+TWJN/d/2yGPJDSKZ05VpGiyukXasp3OA/b742nzRqMpzTer+t3M
         REhsA4+FXiXlJ0l9f86RTBEhQjPMTVlUdXQOPLCysAZ6ySHIp4B133efK2Nr42kTEz
         bR2Ms4y8GiOR5Fj2QPgUxnRUzyJJ0h8Evc1npFW3bidB8iKbOH4aZT15OQpNe+yIrN
         wdfy2h6blScuYRpC8fsTO8URRg5NYJbYWy7OfNxmtbbXpVUe2TfkI8nBmkVRT1RJfz
         1aA0Vxs0SnWc3WvqeRIO1hosOSPPr9t6XxeQmLjCkUn//525Dh52J2ZUfcX5WQZLQ6
         mEGTGYmBuP21g==
Date:   Tue, 1 Nov 2022 22:01:43 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: Add MSM8976 device tree
Message-ID: <20221102030143.o7vl6ieqm3ptz3x2@builder.lan>
References: <20221101191659.172416-1-a39.skl@gmail.com>
 <20221101191659.172416-2-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101191659.172416-2-a39.skl@gmail.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 08:16:20PM +0100, Adam Skladowski wrote:
> Add a base DT for MSM8976 SoC.
> 

Please send this together with some device dts, so that it's actually
being built.

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

No underscore in node names please (xo-board-clk sounds good).

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
[..]
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		cont_splash_mem: memory@83000000 {

"memory" is reserved, so please don't do what we've been doing
everywhere else, but instead use descriptive names.

> +			reg = <0x0 0x83000000 0x0 0x2800000>;
> +		};
> +
[..]
> +
> +		mba_mem: mba_mem@d5a00000 {

No underscores in node names please.

> +			reg = <0x0 0xd5a00000 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
[..]
> +	soc: soc@0 {
[..]
> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,msm8976-pinctrl";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			gpio-ranges = <&tlmm 0 0 158>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			mdss_te_default: mdss-te-default-state {
> +				pins = "gpio24";
> +				function = "mdp_vsync";
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			sdc1_clk_on: sdc1-clk-on-state {

I do like when related configuration is lumped together in a single
state:

	sdc1-default-state {
		clk-pins {
			...;
		};

		cmd-pins {
			...;
		};

		...
	};

> +				pins = "sdc1_clk";
> +				bias-disable;
> +				drive-strength = <16>;
> +			};
> +
> +			sdc1_clk_off: sdc1-clk-off-state {
> +				pins = "sdc1_clk";
> +				bias-disable;
> +				drive-strength = <2>;
> +			};
> +
[..]
> +
> +			gpio_key_default: gpio-key-default-state {

This looks like a state that should go in the board-specific .dts.

> +				pins = "gpio113";
> +				function = "gpio";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
[..]
> +		};
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,gcc-msm8976-v1.1";
> +			reg = <0x01800000 0x80000>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> +				 <&rpmcc RPM_SMD_XO_A_CLK_SRC>,
> +				 <&dsi0_phy 1>,
> +				 <&dsi0_phy 0>,
> +				 <&dsi1_phy 1>,
> +				 <&dsi1_phy 0>;
> +			clock-names = "xo",
> +				      "xo_a",
> +				      "dsi0pll",
> +				      "dsi0pllbyte",
> +				      "dsi1pll",
> +				      "dsi1pllbyte";
> +		};
> +
> +		tcsr_mutex: hwlock@1905000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x01905000 0x20000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		tcsr: syscon@1937000 {
> +			compatible = "qcom,tcsr-msm8976", "syscon";
> +			reg = <0x01937000 0x30000>;
> +		};
> +
> +		mdss: mdss@1a00000 {

display-subsystem@ please.

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

display-controller@ please

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

If you label this mdss_dsi0 (and similar for other mdss nodes) it will
sort nicely in the dts

> +				compatible = "qcom,mdss-dsi-ctrl";
> +				reg = <0x01a94000 0x2d4>;
> +				reg-names = "dsi_ctrl";
[..]

Generally, please try to use make dtbs_check

Thanks,
Bjorn
