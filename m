Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22665D094
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjADKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbjADKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:24:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9581A3B9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:24:46 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so49779384lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ui9nzR8C5HYqN6kh1zihWaiETeSD3tLBps1XKEmeDQM=;
        b=HlF/Chm+9tq2cdWvWilsXF8YYB2TnJmjljy9qeymwURnWrReNhMtEW8itcDcXcYub1
         IfHR20BLvpiW/N9piAzuAurFEvp6Mt40+p92mT2DqlF5EMsHJiZZzLjpfAonHNA4Uv8S
         gkoV7BSeEYfot+yAw28C8ds38aBIrVpwbjx1hfxyGEEy83dO8Lw4gCWHBBpDKHiTVu8Q
         d+VivLStO9dciMiRWXgJzuQX4SADExvoNGho1MVBnvUqKnG3W/VBFE6BO1BlooUGznGV
         jRh7u8Kc2KuyNhhEmJ5/XOqKVV4PN9d0AA2zz4QeJ2NETRIZr0AdMoF7jo31ynMA6Utc
         Qt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ui9nzR8C5HYqN6kh1zihWaiETeSD3tLBps1XKEmeDQM=;
        b=5ayGfvQQ84j9CtX/xMbF8YnPwPje+fhmBe7HblOTqHBP4zfQgv+EzZiYE1ZYoWGFwQ
         evtIvFYz6ellN0XV7OUSydVdc2tC7O0gUHvajMUxucVToqXyeBT1cH9dL9//OnveGA3a
         b55IIxBK/12KtHNBQQHsr+XeLv2EhziJCtXQ/45T9dP4mvf5ja4K0PVL87wc+SVNmVO2
         VfhUvqoPGf2hIpeY1a4cmMoggQHu6XXzJ9A5dt5KM36UTdyyN2LG1w1zyWx0B9cKURnY
         aQw9ghlDBmN1mTbSBUDHzaAYJrJXJ+HInI0cTcOVPiGShmtgCHj9TyIjaFF5CKxleLkV
         d4Ew==
X-Gm-Message-State: AFqh2kqfmhUHYsZCUBEGkKatX/gkmHJI/mzCDI+4+J+b/6MdPGE4GSik
        9LKTTithGmQjHcru97jCtwUmMQ==
X-Google-Smtp-Source: AMrXdXtWVSCyK4w78yd0cOn3ZrhhnL37LOsl8dVbddyDFcfg27rPGo5pq7B0h4HmP8j0bNi748iX7w==
X-Received: by 2002:ac2:52ba:0:b0:4cb:445c:dc7d with SMTP id r26-20020ac252ba000000b004cb445cdc7dmr632983lfm.26.1672827885002;
        Wed, 04 Jan 2023 02:24:45 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id z17-20020a056512371100b004cb3df9b23esm700584lfr.160.2023.01.04.02.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 02:24:44 -0800 (PST)
Message-ID: <583369fd-f48b-e29c-49bb-866258557697@linaro.org>
Date:   Wed, 4 Jan 2023 11:24:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8550: add display hardware
 devices
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230104-topic-sm8550-upstream-dts-display-v1-0-aeab9751928f@linaro.org>
 <20230104-topic-sm8550-upstream-dts-display-v1-1-aeab9751928f@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v1-1-aeab9751928f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.01.2023 10:18, Neil Armstrong wrote:
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
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 295 +++++++++++++++++++++++++++++++++++
>  1 file changed, 295 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index f1760eea3d6b..3b68bba81473 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1425,6 +1425,301 @@ opp-202000000 {
>  			};
>  		};
>  
> +		mdss: mdss@ae00000 {
display-subsystem@

> +			compatible = "qcom,sm8550-mdss";
> +			reg = <0 0x0ae00000 0 0x1000>;
We settled on 0x0 being prefered instead of decimal zero for reg,
though I think I personally asked Abel to make it '0' in 8550 a few
months ago.. Thoughts, Krzysztof, Bjorn?

> +			reg-names = "mdss";
> +
> +			interconnects = <&mmss_noc MASTER_MDP 0 &gem_noc SLAVE_LLCC 0>,
> +				        <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "mdp0-mem", "mdp1-mem";
> +
> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
> +
> +			power-domains = <&dispcc MDSS_GDSC>;
> +
> +			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_DISP_AHB_CLK>,
> +				 <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +
> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			iommus = <&apps_smmu 0x1c00 0x2>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
We recently started an endless quest to try and regulate the property
order [1], please shuffle these around:

compat
reg
reg-names
interrupt*
clocks
clock-names
resets
reset-names
power-domains
interconnects
interconnect-names

The rest (iommus #-cells, ranges) we still haven't quite agreed
on, so I guess they may stay where they are..

Please do the same for other nodes. Otherwise this looks good!

Konrad

[1] https://github.com/konradybcio-work/dt_review/blob/master/README.md
> +
> +			status = "disabled";
> +
> +			mdss_mdp: display-controller@ae01000 {
> +				compatible = "qcom,sm8550-dpu";
> +				reg = <0 0x0ae01000 0 0x8f000>,
> +				      <0 0x0aeb0000 0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_AHB_CLK>,
> +					<&gcc GCC_DISP_HF_AXI_CLK>,
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
> +				power-domains = <&rpmhpd SM8550_MMCX>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
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
> +					<&gcc GCC_DISP_HF_AXI_CLK>;
> +				clock-names = "byte",
> +					      "byte_intf",
> +					      "pixel",
> +					      "core",
> +					      "iface",
> +					      "bus";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> +
> +				operating-points-v2 = <&mdss_dsi_opp_table>;
> +				power-domains = <&rpmhpd SM8550_MMCX>;
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
> +				compatible = "qcom,dsi-phy-4nm-8550";
> +				reg = <0 0x0ae95000 0 0x200>,
> +				      <0 0x0ae95200 0 0x280>,
> +				      <0 0x0ae95500 0 0x400>;
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
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
> +				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
> +
> +				operating-points-v2 = <&mdss_dsi_opp_table>;
> +				power-domains = <&rpmhpd SM8550_MMCX>;
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
> +				compatible = "qcom,dsi-phy-4nm-8550";
> +				reg = <0 0x0ae97000 0 0x200>,
> +				      <0 0x0ae97200 0 0x280>,
> +				      <0 0x0ae97500 0 0x400>;
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
> +			};
> +		};
> +
> +		dispcc: clock-controller@af00000 {
> +			compatible = "qcom,sm8550-dispcc";
> +			reg = <0 0x0af00000 0 0x20000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK_A>,
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
