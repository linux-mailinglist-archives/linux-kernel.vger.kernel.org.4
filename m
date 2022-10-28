Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0455611396
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJ1NvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJ1Nuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:50:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B05543C5;
        Fri, 28 Oct 2022 06:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D710B82A38;
        Fri, 28 Oct 2022 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24F6C433C1;
        Fri, 28 Oct 2022 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666965013;
        bh=1mwCU2l86oW+AY5ci8JrwkgzX5tLCXsSWvdV74cxsfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ee96sRInjDDIEir+DRfuN80SY76K3Ji7PDdAeYsDEB5noFsmhcjMARzlBmrUKsToF
         dQ4a3oO9v7XxXdbPDJrDzE2jrSYgJtsJqqjctSranRA2RbuduacYCBYFYIOEon45SK
         tJvDYxMXXUzNcGfXcAleudeHeRY4GQGR9oQvkU18jzb5wsediD3gMNks6v56eOeDcJ
         gQP/NQi8qe+3+9WKBbQnbnXbZyk2hxquCvDtOCDNSrschxBLAhVpPsRByFq9i/ho2C
         O5m7A182DdZu/XYF/hFb5ryheuYpxE/QtV0bgIGArjKFOorzMpyDXxQp8qHGPKky+3
         zjHiseXOypC0g==
Date:   Fri, 28 Oct 2022 08:50:09 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH v1 7/9] arm64: dts: qcom: sm8350: Add display system nodes
Message-ID: <20221028135009.t4zaypnfoymmao6j@baldur>
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-8-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028120812.339100-8-robert.foss@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:08:10PM +0200, Robert Foss wrote:
> Add mdss, mdss_mdp, dsi0, dsi0_phy nodes. With these
> nodes the display subsystem is configured to support
> one DSI output.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 196 ++++++++++++++++++++++++++-
>  1 file changed, 192 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index b6e44cd3b394..eaa3cdee1860 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2020, Linaro Limited
>   */
>  
> +#include <dt-bindings/interconnect/qcom,sm8350.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,dispcc-sm8350.h>
>  #include <dt-bindings/clock/qcom,gcc-sm8350.h>
> @@ -2535,14 +2536,200 @@ usb_2_dwc3: usb@a800000 {
>  			};
>  		};
>  
> +		mdss: mdss@ae00000 {

display-subsystem@ae00000 please.

> +			compatible = "qcom,sm8350-mdss";
> +			reg = <0 0x0ae00000 0 0x1000>;
> +			reg-names = "mdss";
> +
> +			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "mdp0-mem", "mdp1-mem";
> +
> +			power-domains = <&dispcc MDSS_GDSC>;
> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +
> +			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&gcc GCC_DISP_SF_AXI_CLK>,
> +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +			clock-names = "iface", "bus", "nrt_bus", "core";
> +
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			status = "ok";

You want "disabled" here, and then "okay" in the .dts.

> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			mdss_mdp: mdp@ae01000 {

display-controller@ae01000 please.

> +				compatible = "qcom,sm8350-dpu";
> +				reg = <0 0x0ae01000 0 0x8f000>,
> +				      <0 0x0aeb0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +				iommus = <&apps_smmu 0x820 0x402>;
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					<&gcc GCC_DISP_SF_AXI_CLK>,
> +					<&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					<&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +					<&dispcc DISP_CC_MDSS_MDP_CLK>,
> +					<&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;
> +
> +				operating-points-v2 = <&mdp_opp_table>;
> +				power-domains = <&rpmhpd SM8350_MMCX>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
> +
> +				status = "ok";

"okay", but this is the default, so you can skip it in the .dtsi

> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dpu_intf1_out: endpoint {
> +							remote-endpoint = <&dsi0_in>;
> +						};
> +					};
> +				};
> +
> +				mdp_opp_table: mdp-opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-200000000 {
> +						opp-hz = /bits/ 64 <200000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-300000000 {
> +						opp-hz = /bits/ 64 <300000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-345000000 {
> +						opp-hz = /bits/ 64 <345000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-460000000 {
> +						opp-hz = /bits/ 64 <460000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
> +			dsi0: dsi@ae94000 {
> +				compatible = "qcom,mdss-dsi-ctrl";
> +				reg = <0 0x0ae94000 0 0x400>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
> +					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
> +					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_DISP_HF_AXI_CLK>;
> +				clock-names = "byte",
> +					      "byte_intf",
> +					      "pixel",
> +					      "core",
> +					      "iface",
> +					      "bus";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&dsi0_phy 0>,
> +							 <&dsi0_phy 1>;
> +
> +				operating-points-v2 = <&dsi_opp_table>;
> +				power-domains = <&rpmhpd SM8350_MMCX>;
> +
> +				phys = <&dsi0_phy>;
> +				phy-names = "dsi";
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
> +							remote-endpoint = <&dpu_intf1_out>;
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
> +			dsi0_phy: dsi-phy@ae94400 {
> +				compatible = "qcom,dsi-phy-5nm-8350";
> +				reg = <0 0x0ae94400 0 0x200>,
> +				      <0 0x0ae94600 0 0x280>,
> +				      <0 0x0ae94900 0 0x260>;
> +				reg-names = "dsi_phy",
> +					    "dsi_phy_lane",
> +					    "dsi_pll";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&rpmhcc RPMH_CXO_CLK>;
> +				clock-names = "iface", "ref";
> +
> +				status = "disabled";
> +
> +				dsi_opp_table: dsi-opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-187500000 {
> +						opp-hz = /bits/ 64 <187500000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-300000000 {
> +						opp-hz = /bits/ 64 <300000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-358000000 {
> +						opp-hz = /bits/ 64 <358000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +				};
> +			};
> +		};
> +
>  		dispcc: clock-controller@af00000 {
>  			compatible = "qcom,sm8350-dispcc";
>  			reg = <0 0x0af00000 0 0x10000>;
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&dsi0_phy 0>, <&dsi0_phy 1>,
> +				 <0>, <0>,
>  				 <0>,
>  				 <0>;
>  			clock-names = "bi_tcxo",
> @@ -2557,6 +2744,7 @@ dispcc: clock-controller@af00000 {
>  			#power-domain-cells = <1>;
>  
>  			power-domains = <&rpmhpd SM8350_MMCX>;
> +			required-opps = <&rpmhpd_opp_turbo>;

That seems a little bit aggressive, is the opp-based voting from within
the mdss/dpu not sufficient?

Regards,
Bjorn

>  		};
>  
>  		adsp: remoteproc@17300000 {
> -- 
> 2.34.1
> 
