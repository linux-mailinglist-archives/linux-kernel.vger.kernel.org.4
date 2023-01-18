Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1117B671EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjAROAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjARN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:59:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF911630A2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:33:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 18so49615267edw.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6YsBCiUdWHXbO8fGSyRMt7kg0zwtJIGOYXspzO4lbo=;
        b=GtmEidBEuF4DHsR9BEnJQKamXAs7Pbt5m8KOrWtyq/dOR/Pkd4XZCz3vJWaGNXKDJT
         jbpBef/EeWRA2jlWtdQxq6833ydQi/Ou4NT8IzsBj+lwbe41B/r7PicEVU2Uy5XVpqqB
         rZOpUZWWHFlZVQ6Ot88PizzJXz4b3T3POu4SpQha644cllnuaeAw5+T29fx0kLxL64bd
         Y9uH9S2c26LXf9aQxu/Dxf8y8yEo78JW2NCwcGQFDfQxPxnD4vAhWwQTyuCcDeJuakFD
         +y0F9ABs4cW/toNsE4vRhyhH17WnLdTIpz0RvTJQcqGKyXniv+QqUdghF+ffTZjpN7z9
         Rchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6YsBCiUdWHXbO8fGSyRMt7kg0zwtJIGOYXspzO4lbo=;
        b=4cT0wJuZOGmKxn60Fkd6uwkMLW7OLgZeQrNMpDz7p9cezV74nuBV0gnFCkFbgmFe57
         DFON1diqfuKAjPy2geozl0TfF7FUghvT4z75UJU4I/QOyxMhMO43sgXopa+cwAldNAX3
         nfJURCxmUI7U22wz7XeEavUiwAqWL6GQrh458wRyfKFCAdJGskV3nvnan1qhhqLgL4Tv
         LZ82/lRFiMk8DA6XDe/X/T3QJG7ZDuERZHwQZjtqu3A00SrncMqIVvhQMteYwA9azqsV
         TPh09HV6z3ziScmj/vwf/WiauxC0pwhGJ1axyt0jZ6u9UAZ3x9TvI71i2taS/7v63EvN
         Vaig==
X-Gm-Message-State: AFqh2kqLGt6Fkc171ZzgC2XmegwZD45cvbRmPDM8jT7kccqQFQeaptea
        bevYyZBzY5tX6jb71csUMT+l7w==
X-Google-Smtp-Source: AMrXdXsHmxTgFdAi77OZNHUeoWs/efYqbQdZBoc7Kc1hERAXW1nufHROSxQf8x85ZV/I9Rpo7DldWQ==
X-Received: by 2002:a05:6402:360d:b0:46c:2c94:d30b with SMTP id el13-20020a056402360d00b0046c2c94d30bmr7830919edb.33.1674048827252;
        Wed, 18 Jan 2023 05:33:47 -0800 (PST)
Received: from [192.168.1.101] (abxh252.neoplus.adsl.tpnet.pl. [83.9.1.252])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7cd8d000000b0047e6fdbf81csm14246381edv.82.2023.01.18.05.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 05:33:46 -0800 (PST)
Message-ID: <a84dfe63-1dff-f697-effb-96842221e174@linaro.org>
Date:   Wed, 18 Jan 2023 14:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sm8550: add display hardware
 devices
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230104-topic-sm8550-upstream-dts-display-v3-0-46f0d4e57752@linaro.org>
 <20230104-topic-sm8550-upstream-dts-display-v3-1-46f0d4e57752@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v3-1-46f0d4e57752@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.01.2023 09:55, Neil Armstrong wrote:
> Add devices tree nodes describing display hardware on SM8550:
> - Display Clock Controller
> - MDSS
> - MDP
> - two DSI controllers and DSI PHYs
> 
> This does not provide support for DP controllers present on the SM8550.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 299 +++++++++++++++++++++++++++++++++++
>  1 file changed, 299 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 3d47281a276b..a76ee4e50854 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sm8550-gcc.h>
>  #include <dt-bindings/clock/qcom,sm8550-tcsr.h>
> +#include <dt-bindings/clock/qcom,sm8550-dispcc.h>
>  #include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -1727,6 +1728,304 @@ opp-202000000 {
>  			};
>  		};
>  
> +		mdss: display-subsystem@ae00000 {
> +			compatible = "qcom,sm8550-mdss";
> +			reg = <0 0x0ae00000 0 0x1000>;
> +			reg-names = "mdss";
> +
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_DISP_AHB_CLK>,
> +				 <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +
> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +
> +			power-domains = <&dispcc MDSS_GDSC>;
> +
> +			interconnects = <&mmss_noc MASTER_MDP 0 &gem_noc SLAVE_LLCC 0>,
> +				        <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "mdp0-mem", "mdp1-mem";
> +
> +			iommus = <&apps_smmu 0x1c00 0x2>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdss_mdp: display-controller@ae01000 {
> +				compatible = "qcom,sm8550-dpu";
> +				reg = <0 0x0ae01000 0 0x8f000>,
> +				      <0 0x0aeb0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
> +
> +				clocks = <&gcc GCC_DISP_AHB_CLK>,
> +					<&gcc GCC_DISP_HF_AXI_CLK>,
> +					<&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					<&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +					<&dispcc DISP_CC_MDSS_MDP_CLK>,
> +					<&dispcc DISP_CC_MDSS_VSYNC_CLK>;
I think it's misindented..


> +				clock-names = "bus",
> +					      "nrt_bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +
> +				power-domains = <&rpmhpd SM8550_MMCX>;
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;
> +
> +				operating-points-v2 = <&mdp_opp_table>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dpu_intf1_out: endpoint {
> +							remote-endpoint = <&mdss_dsi0_in>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dpu_intf2_out: endpoint {
> +							remote-endpoint = <&mdss_dsi1_in>;
> +						};
> +					};
> +				};
> +
> +				mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-200000000 {
> +						opp-hz = /bits/ 64 <200000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-325000000 {
> +						opp-hz = /bits/ 64 <325000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-375000000 {
> +						opp-hz = /bits/ 64 <375000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-514000000 {
> +						opp-hz = /bits/ 64 <514000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +				};
> +			};
> +
> +			mdss_dsi0: dsi@ae94000 {
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
> +				power-domains = <&rpmhpd SM8550_MMCX>;
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
Please wrap here and in dsi1


With these 2:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> +
> +				operating-points-v2 = <&mdss_dsi_opp_table>;
> +
> +				phys = <&mdss_dsi0_phy>;
> +				phy-names = "dsi";
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
> +						mdss_dsi0_in: endpoint {
> +							remote-endpoint = <&dpu_intf1_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdss_dsi0_out: endpoint {
> +						};
> +					};
> +				};
> +
> +				mdss_dsi_opp_table: opp-table {
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
> +
> +			mdss_dsi0_phy: phy@ae95000 {
> +				compatible = "qcom,sm8550-dsi-phy-4nm";
> +				reg = <0 0x0ae95000 0 0x200>,
> +				      <0 0x0ae95200 0 0x280>,
> +				      <0 0x0ae95500 0 0x400>;
> +				reg-names = "dsi_phy",
> +					    "dsi_phy_lane",
> +					    "dsi_pll";
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&rpmhcc RPMH_CXO_CLK>;
> +				clock-names = "iface", "ref";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				status = "disabled";
> +			};
> +
> +			mdss_dsi1: dsi@ae96000 {
> +				compatible = "qcom,mdss-dsi-ctrl";
> +				reg = <0 0x0ae96000 0 0x400>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <5>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
> +					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_PCLK1_CLK>,
> +					 <&dispcc DISP_CC_MDSS_ESC1_CLK>,
> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&gcc GCC_DISP_HF_AXI_CLK>;
> +				clock-names = "byte",
> +					      "byte_intf",
> +					      "pixel",
> +					      "core",
> +					      "iface",
> +					      "bus";
> +
> +				power-domains = <&rpmhpd SM8550_MMCX>;
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
> +				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
> +
> +				operating-points-v2 = <&mdss_dsi_opp_table>;
> +
> +				phys = <&mdss_dsi1_phy>;
> +				phy-names = "dsi";
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
> +						mdss_dsi1_in: endpoint {
> +							remote-endpoint = <&dpu_intf2_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdss_dsi1_out: endpoint {
> +						};
> +					};
> +				};
> +			};
> +
> +			mdss_dsi1_phy: phy@ae97000 {
> +				compatible = "qcom,sm8550-dsi-phy-4nm";
> +				reg = <0 0x0ae97000 0 0x200>,
> +				      <0 0x0ae97200 0 0x280>,
> +				      <0 0x0ae97500 0 0x400>;
> +				reg-names = "dsi_phy",
> +					    "dsi_phy_lane",
> +					    "dsi_pll";
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&rpmhcc RPMH_CXO_CLK>;
> +				clock-names = "iface", "ref";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				status = "disabled";
> +			};
> +		};
> +
> +		dispcc: clock-controller@af00000 {
> +			compatible = "qcom,sm8550-dispcc";
> +			reg = <0 0x0af00000 0 0x20000>;
> +			clocks = <&bi_tcxo_div2>,
> +				 <&bi_tcxo_ao_div2>,
> +				 <&gcc GCC_DISP_AHB_CLK>,
> +				 <&sleep_clk>,
> +				 <&mdss_dsi0_phy 0>,
> +				 <&mdss_dsi0_phy 1>,
> +				 <&mdss_dsi1_phy 0>,
> +				 <&mdss_dsi1_phy 1>,
> +				 <0>, /* dp0 */
> +				 <0>,
> +				 <0>, /* dp1 */
> +				 <0>,
> +				 <0>, /* dp2 */
> +				 <0>,
> +				 <0>, /* dp3 */
> +				 <0>;
> +			power-domains = <&rpmhpd SM8550_MMCX>;
> +			required-opps = <&rpmhpd_opp_low_svs>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			status = "disabled";
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sm8550-pdc", "qcom,pdc";
>  			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
> 
