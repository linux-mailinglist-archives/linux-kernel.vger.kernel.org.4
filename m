Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA987197FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjFAJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjFAJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:58:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D5188
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:58:40 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f5021faa16so682976e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613519; x=1688205519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqAsn5Q85J3c7XSLh3IAE2t7rNKZWZ7VbEFAEiDLDYA=;
        b=agcTDv9a1g00uH7eoyOcguszWGCywHuqzxV+NZUp012NODJleh9Y5z6ptVNYgSdmtX
         8F+TXH5LNrlnF0kTdnei8T+PE4y7PWFCLJEuvkUrLP7arJe74gH2s9HMVLHopLe/Dm6T
         ixDYDVag5R4OGMb97zZ+Ge2fKkBYBJ+yGZsjG1o6ADwvfq0p+ukMh1frxUVu2Cazdxe/
         CVR1NTMnVnetB8X0HAd548kZ0xJJwf3ioefwC3QKnWw5YpzkGfleyqj8S9PMg6XIGY/j
         ZFuMJ8Gta7UC6Q1k/SNCmPtAC1xAerVi64SWB2ThLqtGQvuZeDicTddV61Vxtxbd44N4
         3M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613519; x=1688205519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqAsn5Q85J3c7XSLh3IAE2t7rNKZWZ7VbEFAEiDLDYA=;
        b=Loj3ehXyRWmGrudDhZvS+kX9Bt8jQcHfvhJ4WZnXX+iqt2t45wGAEDWNYP+RvHhoU5
         y+rM5guAtEcBNBprctJeVGVKHfipLpPcTK5xXzUPDNC5XWM3PzlSsnRZ6XRsH7//6OM3
         e//aDqKsXiE1TAZYKOStbA5bVE1UOF5aK0vBJ+NnQhp0mHBCq+m233QNjI6l4KkA24B8
         OutSgE2kRBzWEcH3BSB7zbMuiqUE7oS0GuJL57Q11c9KfIMBsP1oiickAGLNcWtftAQe
         GAopbiGBp794vOioYzZOUnX0j4Y73wKFvGzPvCn0IJQLQKHTdk5gW4Ife1XUeT55Nv8f
         Az0Q==
X-Gm-Message-State: AC+VfDwEplSDQ+fpzAq4/S0M/PxzxDg5gqcOETHGlEmxPYELk22ZpScb
        2FzLOAOZy1bWTaKbXjQVPpbDWQ==
X-Google-Smtp-Source: ACHHUZ4iFrRTM8PObxaqSl3SWf3yJ3DQfdOVEwYZ4x8BW9seDxRuGv7X4OG8uoX/OTH8pDwEkMWAmg==
X-Received: by 2002:ac2:548e:0:b0:4f2:6656:d602 with SMTP id t14-20020ac2548e000000b004f26656d602mr980878lfk.9.1685613518782;
        Thu, 01 Jun 2023 02:58:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id g8-20020a19ac08000000b004f1400630d3sm1037217lfc.35.2023.06.01.02.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:58:37 -0700 (PDT)
Message-ID: <4c565a7b-3041-e3f3-7174-282348b74575@linaro.org>
Date:   Thu, 1 Jun 2023 11:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550: add display port nodes
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601-topic-sm8550-upstream-dp-v1-0-29efe2689553@linaro.org>
 <20230601-topic-sm8550-upstream-dp-v1-2-29efe2689553@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v1-2-29efe2689553@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 11:52, Neil Armstrong wrote:
> Add the Display Port controller subnode to the MDSS node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 89 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 75cd374943eb..73524afc2e3a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2495,6 +2495,13 @@ dpu_intf2_out: endpoint {
>  							remote-endpoint = <&mdss_dsi1_in>;
>  						};
>  					};
> +
> +					port@2 {
> +						reg = <2>;
> +						dpu_intf0_out: endpoint {
> +							remote-endpoint = <&mdss_dp0_in>;
> +						};
> +					};
>  				};
>  
>  				mdp_opp_table: opp-table {
> @@ -2522,6 +2529,84 @@ opp-514000000 {
>  				};
>  			};
>  
> +			mdss_dp0: displayport-controller@ae90000 {
> +				compatible = "qcom,sm8550-dp", "qcom,sm8350-dp";
> +				reg = <0 0xae90000 0 0x200>,
> +				      <0 0xae90200 0 0x200>,
> +				      <0 0xae90400 0 0xc00>,
> +				      <0 0xae91000 0 0x400>,
> +				      <0 0xae91400 0 0x400>;
> +				interrupt-parent = <&mdss>;
> +				interrupts = <12>;
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +				clock-names = "core_iface",
> +					      "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface",
> +					      "stream_pixel";
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> +
> +				phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +				power-domains = <&rpmhpd SM8550_CX>;
MMCX

> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss_dp0_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						mdss_dp0_out: endpoint {
> +						};
> +					};
> +				};
> +
> +				dp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-162000000 {
> +						opp-hz = /bits/ 64 <162000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
_d1

> +					};
> +
> +					opp-270000000 {
> +						opp-hz = /bits/ 64 <270000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
low_svs

With these fixed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
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
>  			mdss_dsi0: dsi@ae94000 {
>  				compatible = "qcom,sm8550-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>  				reg = <0 0x0ae94000 0 0x400>;
> @@ -2705,8 +2790,8 @@ dispcc: clock-controller@af00000 {
>  				 <&mdss_dsi0_phy 1>,
>  				 <&mdss_dsi1_phy 0>,
>  				 <&mdss_dsi1_phy 1>,
> -				 <0>, /* dp0 */
> -				 <0>,
> +				 <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +				 <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
>  				 <0>, /* dp1 */
>  				 <0>,
>  				 <0>, /* dp2 */
> 
