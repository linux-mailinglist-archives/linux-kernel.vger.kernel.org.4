Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4DD665B0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAKMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjAKMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:10:20 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA8F1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:10:18 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id bp15so23167325lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hhqb0JQoNMGiGSyLmcbNsOwcfGTQYrFo1LJuCMGsatM=;
        b=WH0RtN2HSOrLTHw9N+y0JwXL2CRSkWpfvUB0p8Wa2POFiL/bCUotpgy2QxgNAWBmUI
         00c+tIo5Nt5U1/opYVnZT0SBX9g1LHx5L4YKIBgbDw9BQfKO52I4+pWL2R33BjbQDSbc
         cqUVvhQyPb/MAq7H/5ciUFm1oKOFjETtjljQQ4SUJOd5hAFusmE/y14Rk39K+7F70B1V
         J0ut8YE6KCPW43hb2eHw2JUQKeddkbdf7Pn3lWCz6s9y03XbVY3EGsFM/1UZkrkB9xte
         m522bw/G/+LNqRn5Gbyck0XfMwlWoHkSWpLIDdj6s8ByqQPSG05X5GBndYcCzKI6rpse
         2/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhqb0JQoNMGiGSyLmcbNsOwcfGTQYrFo1LJuCMGsatM=;
        b=e7jCwPiO6RgvGWRtuSiIhvGG0/NuHWMUoCuVV2v1OvCgAK6/fxOShSvWmBXM6AnjHI
         pF3br6oWP8NGepFMDfD/1fD+wrQFy2t9tS05bywk1DKZsdsIyD9W4XjfJf7FIWoFvOLG
         7EcibfVJLuXFGgDwKiN7fMUzmWqnR3agwZiIVvb7qXi9THz+yW5UsmtEt2KXGHWcbD5e
         S1FDHm/2O1XtCOhvpPtPiNnyWeBlaK6eL1MtqO9RCl1eDLZxABNBPxXWlt19VPS9pmrL
         BENPma6LEXvXllw/vVbNjmRXsQ7NgjmcnPncEyMbNwRpGr3TPjjCGTcAdTaAGHNWkEN3
         +kGw==
X-Gm-Message-State: AFqh2kpmdugSyTK6kypL/1Zb+rjZQt+FF5OVQdQB49ssYnmv18UzGcNd
        aNMqDBl4okyNwoREH/RUo3CYV+ksq6JdxL/7
X-Google-Smtp-Source: AMrXdXvmFWW/8s0iEAvAejVZ4zzjvv9/hxdFrXFGCifNzBNDdQDN6BUY/pfGrq6vQfuaT76sip1XVQ==
X-Received: by 2002:a05:6512:169e:b0:4ca:f58f:1960 with SMTP id bu30-20020a056512169e00b004caf58f1960mr2858203lfb.33.1673439016675;
        Wed, 11 Jan 2023 04:10:16 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id e27-20020a05651c039b00b0027fde521991sm1721651ljp.40.2023.01.11.04.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 04:10:15 -0800 (PST)
Message-ID: <aeb36dc7-0d27-760a-db9b-52d2758c6441@linaro.org>
Date:   Wed, 11 Jan 2023 13:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 1/4] arm64: dts: qcom: sc8280xp: Define some of the
 display blocks
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
 <20230111035906.2975494-2-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230111035906.2975494-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 04:59, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Define the display clock controllers, the MDSS instances, the DP phys
> and connect these together.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v6:
> - Dropped assigned-clock-rate on MDP_CLK
> - Rearranged the properties in all nodes
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 811 +++++++++++++++++++++++++
>  1 file changed, 811 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 0ea2f19d471b..2ed17baf50d3 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2022, Linaro Limited
>   */
>  
> +#include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
> @@ -2097,6 +2098,42 @@ usb_1_qmpphy: phy@8903000 {
>  			status = "disabled";
>  		};
>  
> +		mdss1_dp0_phy: phy@8909a00 {
> +			compatible = "qcom,sc8280xp-dp-phy";
> +			reg = <0 0x08909a00 0 0x19c>,
> +			      <0 0x08909200 0 0xec>,
> +			      <0 0x08909600 0 0xec>,
> +			      <0 0x08909000 0 0x1c8>;
> +
> +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> +			clock-names = "aux", "cfg_ahb";
> +			power-domains = <&rpmhpd SC8280XP_MX>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		mdss1_dp1_phy: phy@890ca00 {
> +			compatible = "qcom,sc8280xp-dp-phy";
> +			reg = <0 0x0890ca00 0 0x19c>,
> +			      <0 0x0890c200 0 0xec>,
> +			      <0 0x0890c600 0 0xec>,
> +			      <0 0x0890c000 0 0x1c8>;
> +
> +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> +			clock-names = "aux", "cfg_ahb";
> +			power-domains = <&rpmhpd SC8280XP_MX>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		pmu@9091000 {
>  			compatible = "qcom,sc8280xp-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
>  			reg = <0 0x9091000 0 0x1000>;
> @@ -2303,6 +2340,314 @@ usb_1_dwc3: usb@a800000 {
>  			};
>  		};
>  
> +		mdss0: display-subsystem@ae00000 {
> +			compatible = "qcom,sc8280xp-mdss";
> +			reg = <0 0x0ae00000 0 0x1000>;
> +			reg-names = "mdss";
> +
> +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> +				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +				 <&dispcc0 DISP_CC_MDSS_MDP_CLK>;
> +			clock-names = "iface",
> +				      "ahb",
> +				      "core";
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "mdp0-mem", "mdp1-mem";
> +			iommus = <&apps_smmu 0x1000 0x402>;
> +			power-domains = <&dispcc0 MDSS_GDSC>;
> +			resets = <&dispcc0 DISP_CC_MDSS_CORE_BCR>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdss0_mdp: display-controller@ae01000 {
> +				compatible = "qcom,sc8280xp-dpu";
> +				reg = <0 0x0ae01000 0 0x8f000>,
> +				      <0 0x0aeb0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&gcc GCC_DISP_SF_AXI_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <0>;
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;
> +				operating-points-v2 = <&mdss0_mdp_opp_table>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@5 {
> +						reg = <5>;
> +						mdss0_intf5_out: endpoint {
> +							remote-endpoint = <&mdss0_dp3_in>;
> +						};
> +					};
> +
> +					port@6 {
> +						reg = <6>;
> +						mdss0_intf6_out: endpoint {
> +							remote-endpoint = <&mdss0_dp2_in>;
> +						};
> +					};
> +				};
> +
> +				mdss0_mdp_opp_table: opp-table {
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
> +					opp-375000000 {
> +						opp-hz = /bits/ 64 <375000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-500000000 {
> +						opp-hz = /bits/ 64 <500000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +					opp-600000000 {
> +						opp-hz = /bits/ 64 <600000000>;
> +						required-opps = <&rpmhpd_opp_turbo_l1>;
> +					};
> +				};
> +			};
> +
> +			mdss0_dp2: displayport-controller@ae9a000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0xae9a000 0 0x200>,
> +				      <0 0xae9a200 0 0x200>,
> +				      <0 0xae9a400 0 0x600>,
> +				      <0 0xae9b000 0 0x400>;
> +
> +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <14>;
> +				phys = <&mdss0_dp2_phy>;
> +				phy-names = "dp";
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
> +						  <&dispcc0 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss0_dp2_phy 0>, <&mdss0_dp2_phy 1>;
> +				operating-points-v2 = <&mdss0_dp2_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss0_dp2_in: endpoint {
> +							remote-endpoint = <&mdss0_intf6_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss0_dp2_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
> +			mdss0_dp3: displayport-controller@aea0000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0xaea0000 0 0x200>,
> +				      <0 0xaea0200 0 0x200>,
> +				      <0 0xaea0400 0 0x600>,
> +				      <0 0xaea1000 0 0x400>;
> +
> +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_INTF_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <15>;
> +				phys = <&mdss0_dp3_phy>;
> +				phy-names = "dp";
> +				power-domains = <&dispcc0 MDSS_GDSC>;
> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
> +						  <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss0_dp3_phy 0>, <&mdss0_dp3_phy 1>;
> +				operating-points-v2 = <&mdss0_dp3_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss0_dp3_in: endpoint {
> +							remote-endpoint = <&mdss0_intf5_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss0_dp3_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +		};
> +
> +		mdss0_dp2_phy: phy@aec2a00 {
> +			compatible = "qcom,sc8280xp-dp-phy";
> +			reg = <0 0x0aec2a00 0 0x19c>,
> +			      <0 0x0aec2200 0 0xec>,
> +			      <0 0x0aec2600 0 0xec>,
> +			      <0 0x0aec2000 0 0x1c8>;
> +
> +			clocks = <&dispcc0 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> +				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
> +			clock-names = "aux", "cfg_ahb";
> +			power-domains = <&rpmhpd SC8280XP_MX>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		mdss0_dp3_phy: phy@aec5a00 {
> +			compatible = "qcom,sc8280xp-dp-phy";
> +			reg = <0 0x0aec5a00 0 0x19c>,
> +			      <0 0x0aec5200 0 0xec>,
> +			      <0 0x0aec5600 0 0xec>,
> +			      <0 0x0aec5000 0 0x1c8>;
> +
> +			clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> +				 <&dispcc0 DISP_CC_MDSS_AHB_CLK>;
> +			clock-names = "aux", "cfg_ahb";
> +			power-domains = <&rpmhpd SC8280XP_MX>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		dispcc0: clock-controller@af00000 {
> +			compatible = "qcom,sc8280xp-dispcc0";
> +			reg = <0 0x0af00000 0 0x20000>;
> +
> +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&sleep_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <&mdss0_dp2_phy 0>,
> +				 <&mdss0_dp2_phy 1>,
> +				 <&mdss0_dp3_phy 0>,
> +				 <&mdss0_dp3_phy 1>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +			#reset-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sc8280xp-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
> @@ -2925,6 +3270,472 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  				qcom,remote-pid = <12>;
>  			};
>  		};
> +
> +		mdss1: display-subsystem@22000000 {
> +			compatible = "qcom,sc8280xp-mdss";
> +			reg = <0 0x22000000 0 0x1000>;
> +			reg-names = "mdss";
> +
> +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_MDP_CLK>;
> +			clock-names = "iface",
> +				      "ahb",
> +				      "core";
> +			interconnects = <&mmss_noc MASTER_MDP_CORE1_0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&mmss_noc MASTER_MDP_CORE1_1 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "mdp0-mem", "mdp1-mem";
> +			interrupts = <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +
> +			iommus = <&apps_smmu 0x1800 0x402>;
> +			power-domains = <&dispcc1 MDSS_GDSC>;
> +			resets = <&dispcc1 DISP_CC_MDSS_CORE_BCR>;
> +
> +			#interrupt-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdss1_mdp: display-controller@22001000 {
> +				compatible = "qcom,sc8280xp-dpu";
> +				reg = <0 0x22001000 0 0x8f000>,
> +				      <0 0x220b0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&gcc GCC_DISP_SF_AXI_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +				interrupt-parent = <&mdss1>;
> +				interrupts = <0>;
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;
> +				operating-points-v2 = <&mdss1_mdp_opp_table>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss1_intf0_out: endpoint {
> +							remote-endpoint = <&mdss1_dp0_in>;
> +						};
> +					};
> +
> +					port@4 {
> +						reg = <4>;
> +						mdss1_intf4_out: endpoint {
> +							remote-endpoint = <&mdss1_dp1_in>;
> +						};
> +					};
> +
> +					port@5 {
> +						reg = <5>;
> +						mdss1_intf5_out: endpoint {
> +							remote-endpoint = <&mdss1_dp3_in>;
> +						};
> +					};
> +
> +					port@6 {
> +						reg = <6>;
> +						mdss1_intf6_out: endpoint {
> +							remote-endpoint = <&mdss1_dp2_in>;
> +						};
> +					};
> +				};
> +
> +				mdss1_mdp_opp_table: opp-table {
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
> +					opp-375000000 {
> +						opp-hz = /bits/ 64 <375000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-500000000 {
> +						opp-hz = /bits/ 64 <500000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +					opp-600000000 {
> +						opp-hz = /bits/ 64 <600000000>;
> +						required-opps = <&rpmhpd_opp_turbo_l1>;
> +					};
> +				};
> +			};
> +
> +			mdss1_dp0: displayport-controller@22090000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0x22090000 0 0x200>,
> +				      <0 0x22090200 0 0x200>,
> +				      <0 0x22090400 0 0x600>,
> +				      <0 0x22091000 0 0x400>;
> +
> +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss1>;
> +				interrupts = <12>;
> +				phys = <&mdss1_dp0_phy>;
> +				phy-names = "dp";
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc1 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss1_dp0_phy 0>, <&mdss1_dp0_phy 1>;
> +				operating-points-v2 = <&mdss1_dp0_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss1_dp0_in: endpoint {
> +							remote-endpoint = <&mdss1_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss1_dp0_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +
> +			};
> +
> +			mdss1_dp1: displayport-controller@22098000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0x22098000 0 0x200>,
> +				      <0 0x22098200 0 0x200>,
> +				      <0 0x22098400 0 0x600>,
> +				      <0 0x22099000 0 0x400>;
> +
> +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX1_AUX_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss1>;
> +				interrupts = <13>;
> +				phys = <&mdss1_dp1_phy>;
> +				phy-names = "dp";
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
> +						  <&dispcc1 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss1_dp1_phy 0>, <&mdss1_dp1_phy 1>;
> +				operating-points-v2 = <&mdss1_dp1_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss1_dp1_in: endpoint {
> +							remote-endpoint = <&mdss1_intf4_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss1_dp1_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
> +			mdss1_dp2: displayport-controller@2209a000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0x2209a000 0 0x200>,
> +				      <0 0x2209a200 0 0x200>,
> +				      <0 0x2209a400 0 0x600>,
> +				      <0 0x2209b000 0 0x400>;
> +
> +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_INTF_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss1>;
> +				interrupts = <14>;
> +				phys = <&mdss1_dp2_phy>;
> +				phy-names = "dp";
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_LINK_CLK_SRC>,
> +						  <&dispcc1 DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss1_dp2_phy 0>, <&mdss1_dp2_phy 1>;
> +				operating-points-v2 = <&mdss1_dp2_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss1_dp2_in: endpoint {
> +							remote-endpoint = <&mdss1_intf6_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss1_dp2_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
> +			mdss1_dp3: displayport-controller@220a0000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0x220a0000 0 0x200>,
> +				      <0 0x220a0200 0 0x200>,
> +				      <0 0x220a0400 0 0x600>,
> +				      <0 0x220a1000 0 0x400>;
> +
> +				clocks = <&dispcc1 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_INTF_CLK>,
> +					 <&dispcc1 DISP_CC_MDSS_DPTX3_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				interrupt-parent = <&mdss1>;
> +				interrupts = <15>;
> +				phys = <&mdss1_dp3_phy>;
> +				phy-names = "dp";
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +				assigned-clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
> +						  <&dispcc1 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss1_dp3_phy 0>, <&mdss1_dp3_phy 1>;
> +				operating-points-v2 = <&mdss1_dp3_opp_table>;
> +
> +				#sound-dai-cells = <0>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss1_dp3_in: endpoint {
> +							remote-endpoint = <&mdss1_intf5_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss1_dp3_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-160000000 {
> +						opp-hz = /bits/ 64 <160000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-540000000 {
> +						opp-hz = /bits/ 64 <540000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-810000000 {
> +						opp-hz = /bits/ 64 <810000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +		};
> +
> +		mdss1_dp2_phy: phy@220c2a00 {
> +			compatible = "qcom,sc8280xp-dp-phy";
> +			reg = <0 0x220c2a00 0 0x19c>,
> +			      <0 0x220c2200 0 0xec>,
> +			      <0 0x220c2600 0 0xec>,
> +			      <0 0x220c2000 0 0x1c8>;
> +
> +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX2_AUX_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> +			clock-names = "aux", "cfg_ahb";
> +			power-domains = <&rpmhpd SC8280XP_MX>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		mdss1_dp3_phy: phy@220c5a00 {
> +			compatible = "qcom,sc8280xp-dp-phy";
> +			reg = <0 0x220c5a00 0 0x19c>,
> +			      <0 0x220c5200 0 0xec>,
> +			      <0 0x220c5600 0 0xec>,
> +			      <0 0x220c5000 0 0x1c8>;
> +
> +			clocks = <&dispcc1 DISP_CC_MDSS_DPTX3_AUX_CLK>,
> +				 <&dispcc1 DISP_CC_MDSS_AHB_CLK>;
> +			clock-names = "aux", "cfg_ahb";
> +			power-domains = <&rpmhpd SC8280XP_MX>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		dispcc1: clock-controller@22100000 {
> +			compatible = "qcom,sc8280xp-dispcc1";
> +			reg = <0 0x22100000 0 0x20000>;
> +
> +			clocks = <&gcc GCC_DISP_AHB_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <0>,
> +				 <&mdss1_dp0_phy 0>,
> +				 <&mdss1_dp0_phy 1>,
> +				 <&mdss1_dp1_phy 0>,
> +				 <&mdss1_dp1_phy 1>,
> +				 <&mdss1_dp2_phy 0>,
> +				 <&mdss1_dp2_phy 1>,
> +				 <&mdss1_dp3_phy 0>,
> +				 <&mdss1_dp3_phy 1>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			power-domains = <&rpmhpd SC8280XP_MMCX>;
> +
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +			#reset-cells = <1>;
> +
> +			status = "disabled";
> +		};
>  	};
>  
>  	sound: sound {
