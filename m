Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E0565D0D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjADKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjADKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:42:56 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D8E1EC5A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:42:54 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so26081157wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AAKl3DMrZ4Gwgy8OLDKJDMbEwmclSunKDvS5ndyJBrg=;
        b=hYLNJktfMll8tHsnv9hMbOP4mcTy84BuNBHmd9lhcchlHb+4YYdNHkp3Xqwzo++XAI
         LoWDbfCp2v1hQ8WRbvB2Aeqi2W7ysB2CE1dq0O0+jXVkO7pUdU7OCTe4SDiHoFWqTMfi
         T5phA3r+dXDSusk7icduXHdxeZGIcrn4cahzya8b9/Vsi5TztRaUJeMZqvDRmNYeV6d+
         lnKURSMIiOv4LMp7R965r+TcjEMLQx4DWlREY4cxmK9VUTP9/Gi2uNK1lPBx+s/j40Uk
         Ib2/I1V9GsTQDFNYYtYRaX7k4Z/hMDInNrV6ATwrMpezaRp9IPupSMFeBkKl5MtXyV1L
         AVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AAKl3DMrZ4Gwgy8OLDKJDMbEwmclSunKDvS5ndyJBrg=;
        b=zvni8J5spPtn7LTSDNOS1L7U0v5KIhoHEnIQU0gg5aNOumbUTiZJ9o/28nuMYYPw6a
         RRWgc54NPKkMGDihIt7Wmd3LtXKtyVr1V3Dh4OrLOsaBqj931SRxA2/ObQgzxAVUEYSw
         a4ChuifdxS72aRbcD/1G8XxG4ldrTCi/OTjeSAIiiUSUWwJFaVY+6pnLChJ8rfy2g4as
         oxxUQg/TKc5glzrbMn6nFw21ISCHoACFD+T2tF8Hh8ynUBgMFvACcLUmBLc8BFGIrzq3
         9Vct6TW4ChbcPFj5neJa1LsNJWMYqVT5vhT8yxlJMzL4zeUBQ14I1EP7X6k7llOyKGO6
         lzBw==
X-Gm-Message-State: AFqh2krJD8IJwffzKUkPBOUBzweQ+oj1hKG8i8++yZnoAwBFF0rCm7mx
        XJnrkiQvoobdrvHAH+2RlBUHmg==
X-Google-Smtp-Source: AMrXdXuD4xkQdNdSJAScSoEkA+qIjVRny5pWOGtdIdbL744IQGbqO9hl/E3+Yh3hllwkWJtlOeP7Xw==
X-Received: by 2002:a1c:720e:0:b0:3d1:f629:6b56 with SMTP id n14-20020a1c720e000000b003d1f6296b56mr33263410wmc.20.1672828973241;
        Wed, 04 Jan 2023 02:42:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:102f:89e:4a9f:68c? ([2a01:e0a:982:cbb0:102f:89e:4a9f:68c])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003d34faca949sm44373136wms.39.2023.01.04.02.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 02:42:52 -0800 (PST)
Message-ID: <8c0b8794-b9ff-3435-7afa-769e6967b57f@linaro.org>
Date:   Wed, 4 Jan 2023 11:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8550: add display hardware
 devices
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230104-topic-sm8550-upstream-dts-display-v1-0-aeab9751928f@linaro.org>
 <20230104-topic-sm8550-upstream-dts-display-v1-1-aeab9751928f@linaro.org>
 <583369fd-f48b-e29c-49bb-866258557697@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <583369fd-f48b-e29c-49bb-866258557697@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 11:24, Konrad Dybcio wrote:
> 
> 
> On 4.01.2023 10:18, Neil Armstrong wrote:
>> Add devices tree nodes describing display hardware on SM8550:
>> - Display Clock Controller
>> - MDSS
>> - MDP
>> - two DSI controllers and DSI PHYs
>>
>> This does not provide support for DP controllers present on the SM8550.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 295 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 295 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index f1760eea3d6b..3b68bba81473 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi

I just saw I forgot to include the dispcc bindings header, I wonder how it got dropped...

>> @@ -1425,6 +1425,301 @@ opp-202000000 {
>>   			};
>>   		};
>>   
>> +		mdss: mdss@ae00000 {
> display-subsystem@

Ack

> 
>> +			compatible = "qcom,sm8550-mdss";
>> +			reg = <0 0x0ae00000 0 0x1000>;
> We settled on 0x0 being prefered instead of decimal zero for reg,
> though I think I personally asked Abel to make it '0' in 8550 a few
> months ago.. Thoughts, Krzysztof, Bjorn?

Indeed, Abel switched the entire sm8550 to 0, I'll update to what's prefered.

> 
>> +			reg-names = "mdss";
>> +
>> +			interconnects = <&mmss_noc MASTER_MDP 0 &gem_noc SLAVE_LLCC 0>,
>> +				        <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
>> +			interconnect-names = "mdp0-mem", "mdp1-mem";
>> +
>> +			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
>> +
>> +			power-domains = <&dispcc MDSS_GDSC>;
>> +
>> +			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +				 <&gcc GCC_DISP_AHB_CLK>,
>> +				 <&gcc GCC_DISP_HF_AXI_CLK>,
>> +				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
>> +
>> +			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +
>> +			iommus = <&apps_smmu 0x1c00 0x2>;
>> +
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
> We recently started an endless quest to try and regulate the property
> order [1], please shuffle these around:
> 
> compat
> reg
> reg-names
> interrupt*
> clocks
> clock-names
> resets
> reset-names
> power-domains
> interconnects
> interconnect-names

Ack

> 
> The rest (iommus #-cells, ranges) we still haven't quite agreed
> on, so I guess they may stay where they are..
> 
> Please do the same for other nodes. Otherwise this looks good!

Thanks,
Neil

> 
> Konrad
> 
> [1] https://github.com/konradybcio-work/dt_review/blob/master/README.md

I was looking for this, I forgot were you shared it, thanks :-)

>> +
>> +			status = "disabled";
>> +
>> +			mdss_mdp: display-controller@ae01000 {
>> +				compatible = "qcom,sm8550-dpu";
>> +				reg = <0 0x0ae01000 0 0x8f000>,
>> +				      <0 0x0aeb0000 0 0x2008>;
>> +				reg-names = "mdp", "vbif";
>> +
>> +				clocks = <&gcc GCC_DISP_AHB_CLK>,
>> +					<&gcc GCC_DISP_HF_AXI_CLK>,
>> +					<&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					<&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
>> +					<&dispcc DISP_CC_MDSS_MDP_CLK>,
>> +					<&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>> +				clock-names = "bus",
>> +					      "nrt_bus",
>> +					      "iface",
>> +					      "lut",
>> +					      "core",
>> +					      "vsync";
>> +
>> +				assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>> +				assigned-clock-rates = <19200000>;
>> +
>> +				operating-points-v2 = <&mdp_opp_table>;
>> +				power-domains = <&rpmhpd SM8550_MMCX>;
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <0>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						dpu_intf1_out: endpoint {
>> +							remote-endpoint = <&mdss_dsi0_in>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						dpu_intf2_out: endpoint {
>> +							remote-endpoint = <&mdss_dsi1_in>;
>> +						};
>> +					};
>> +				};
>> +
>> +				mdp_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-200000000 {
>> +						opp-hz = /bits/ 64 <200000000>;
>> +						required-opps = <&rpmhpd_opp_low_svs>;
>> +					};
>> +
>> +					opp-325000000 {
>> +						opp-hz = /bits/ 64 <325000000>;
>> +						required-opps = <&rpmhpd_opp_svs>;
>> +					};
>> +
>> +					opp-375000000 {
>> +						opp-hz = /bits/ 64 <375000000>;
>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>> +					};
>> +
>> +					opp-514000000 {
>> +						opp-hz = /bits/ 64 <514000000>;
>> +						required-opps = <&rpmhpd_opp_nom>;
>> +					};
>> +				};
>> +			};
>> +
>> +			mdss_dsi0: dsi@ae94000 {
>> +				compatible = "qcom,mdss-dsi-ctrl";
>> +				reg = <0 0x0ae94000 0 0x400>;
>> +				reg-names = "dsi_ctrl";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <4>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_ESC0_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					<&gcc GCC_DISP_HF_AXI_CLK>;
>> +				clock-names = "byte",
>> +					      "byte_intf",
>> +					      "pixel",
>> +					      "core",
>> +					      "iface",
>> +					      "bus";
>> +
>> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
>> +				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
>> +
>> +				operating-points-v2 = <&mdss_dsi_opp_table>;
>> +				power-domains = <&rpmhpd SM8550_MMCX>;
>> +
>> +				phys = <&mdss_dsi0_phy>;
>> +				phy-names = "dsi";
>> +
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				status = "disabled";
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdss_dsi0_in: endpoint {
>> +							remote-endpoint = <&dpu_intf1_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						mdss_dsi0_out: endpoint {
>> +						};
>> +					};
>> +				};
>> +
>> +				mdss_dsi_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					opp-187500000 {
>> +						opp-hz = /bits/ 64 <187500000>;
>> +						required-opps = <&rpmhpd_opp_low_svs>;
>> +					};
>> +
>> +					opp-300000000 {
>> +						opp-hz = /bits/ 64 <300000000>;
>> +						required-opps = <&rpmhpd_opp_svs>;
>> +					};
>> +
>> +					opp-358000000 {
>> +						opp-hz = /bits/ 64 <358000000>;
>> +						required-opps = <&rpmhpd_opp_svs_l1>;
>> +					};
>> +				};
>> +			};
>> +
>> +			mdss_dsi0_phy: phy@ae95000 {
>> +				compatible = "qcom,dsi-phy-4nm-8550";
>> +				reg = <0 0x0ae95000 0 0x200>,
>> +				      <0 0x0ae95200 0 0x280>,
>> +				      <0 0x0ae95500 0 0x400>;
>> +				reg-names = "dsi_phy",
>> +					    "dsi_phy_lane",
>> +					    "dsi_pll";
>> +
>> +				#clock-cells = <1>;
>> +				#phy-cells = <0>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&rpmhcc RPMH_CXO_CLK>;
>> +				clock-names = "iface", "ref";
>> +
>> +				status = "disabled";
>> +			};
>> +
>> +			mdss_dsi1: dsi@ae96000 {
>> +				compatible = "qcom,mdss-dsi-ctrl";
>> +				reg = <0 0x0ae96000 0 0x400>;
>> +				reg-names = "dsi_ctrl";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <5>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_PCLK1_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_ESC1_CLK>,
>> +					 <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_DISP_HF_AXI_CLK>;
>> +				clock-names = "byte",
>> +					      "byte_intf",
>> +					      "pixel",
>> +					      "core",
>> +					      "iface",
>> +					      "bus";
>> +
>> +				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
>> +				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
>> +
>> +				operating-points-v2 = <&mdss_dsi_opp_table>;
>> +				power-domains = <&rpmhpd SM8550_MMCX>;
>> +
>> +				phys = <&mdss_dsi1_phy>;
>> +				phy-names = "dsi";
>> +
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				status = "disabled";
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdss_dsi1_in: endpoint {
>> +							remote-endpoint = <&dpu_intf2_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						mdss_dsi1_out: endpoint {
>> +						};
>> +					};
>> +				};
>> +			};
>> +
>> +			mdss_dsi1_phy: phy@ae97000 {
>> +				compatible = "qcom,dsi-phy-4nm-8550";
>> +				reg = <0 0x0ae97000 0 0x200>,
>> +				      <0 0x0ae97200 0 0x280>,
>> +				      <0 0x0ae97500 0 0x400>;
>> +				reg-names = "dsi_phy",
>> +					    "dsi_phy_lane",
>> +					    "dsi_pll";
>> +
>> +				#clock-cells = <1>;
>> +				#phy-cells = <0>;
>> +
>> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>> +					 <&rpmhcc RPMH_CXO_CLK>;
>> +				clock-names = "iface", "ref";
>> +
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		dispcc: clock-controller@af00000 {
>> +			compatible = "qcom,sm8550-dispcc";
>> +			reg = <0 0x0af00000 0 0x20000>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&rpmhcc RPMH_CXO_CLK_A>,
>> +				 <&gcc GCC_DISP_AHB_CLK>,
>> +				 <&sleep_clk>,
>> +				 <&mdss_dsi0_phy 0>,
>> +				 <&mdss_dsi0_phy 1>,
>> +				 <&mdss_dsi1_phy 0>,
>> +				 <&mdss_dsi1_phy 1>,
>> +				 <0>, /* dp0 */
>> +				 <0>,
>> +				 <0>, /* dp1 */
>> +				 <0>,
>> +				 <0>, /* dp2 */
>> +				 <0>,
>> +				 <0>, /* dp3 */
>> +				 <0>;
>> +			power-domains = <&rpmhpd SM8550_MMCX>;
>> +			required-opps = <&rpmhpd_opp_low_svs>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +			status = "disabled";
>> +		};
>> +
>>   		pdc: interrupt-controller@b220000 {
>>   			compatible = "qcom,sm8550-pdc", "qcom,pdc";
>>   			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
>>

