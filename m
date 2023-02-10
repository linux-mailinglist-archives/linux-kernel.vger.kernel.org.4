Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF769206D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjBJOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjBJOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:04:18 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F46BD08
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:04:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cq19so2088178edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qReh4amMw5PfvkiwnDv2ICM+tFClbn0Zri7uBykIprY=;
        b=iI27E+A+upQ0K9PmlzsGlQpVmdtpZW+6VZ3H1tdOJuFUBVrpdr9OlV7ApMAc6NGsQg
         MbVwkia5LUkq7W6K9HN5yj/UCwaa4DpNeFhZ+fbd/kQD+ZHFVdn4tA4CiIBjETWf35BB
         AycCruh6X5pfQuytq404rpUpSTBBThATIAM2GF3Q/wlfxn2seo8myX7PkcYpyXY3Fta5
         gIw+6unY4khWrfx3E88Q/gdNJLHK8+eMLe81cs4j9gBzsojU+PJdrXKxeg7Gg2pCODkW
         j4nk+qZjoHAFPdDkrHDtRZzoKX3KuHzzcAOdFs4spI3AUV5OVC1727zNCGh7tEMGXIMC
         /pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qReh4amMw5PfvkiwnDv2ICM+tFClbn0Zri7uBykIprY=;
        b=yYQqJlszIlf4dh6UsqqlcCDiiCLV97/kBi1BXcZ37o96jpnIoXHJstihkbn8RHGRFm
         SCPUtBz0Jt4VJpYTUgjMuap7CQXi2Fo+b3xbNU0OezGKqhyXgF49mcZNwuX8DCfSrSA2
         6UDRiW7TYN/JL9/qAqDpSlzUT5Ze0TU+TaN+Z16KWshYc7gAvhdx/mEhGxC3GBPhl+/0
         TbGXILLLNmiWOUqLXNjPa0EpS3+k3GDXA4hQYU1hweQkbX/2xVgq7SviZf1T8dRQ/HaM
         O5Bxe0gFSHmEukzw39sTsXpg0fJrjO2c8aDD/QgBYuTuHlIgeAl7rIe4sYlWtvLyz+Td
         aRgA==
X-Gm-Message-State: AO0yUKWTFPuA4fy5/OAm208VWfXzOTfgQL/zJsYLhArA1wWkcum3bXur
        IUAVnLz/lG3CMyGfAbi+XVc28g==
X-Google-Smtp-Source: AK7set9G9qlOr+y/KrQGdHpU03hYMn7ynYX8nh+VahFcw2Aqz1XL28XPdbvbVpLevgKb581DOj3lSQ==
X-Received: by 2002:a50:c306:0:b0:4ab:4c36:463c with SMTP id a6-20020a50c306000000b004ab4c36463cmr1890828edb.16.1676037854453;
        Fri, 10 Feb 2023 06:04:14 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id z36-20020a509e27000000b004ab1f97ca2csm2021939ede.60.2023.02.10.06.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:04:13 -0800 (PST)
Message-ID: <771cba9d-6c88-b7fb-64a8-f560b1e19eba@linaro.org>
Date:   Fri, 10 Feb 2023 15:04:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: Add USB-C-related DP
 blocks
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
 <20230208034620.2048744-2-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208034620.2048744-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.02.2023 04:46, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add the two DisplayPort controllers that are attached to QMP phys for
> providing display output on USB Type-C.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 170 ++++++++++++++++++++++++-
>  1 file changed, 166 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index dceb7eb3106b..fcd393444f47 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3155,6 +3155,20 @@ ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> +					port@0 {
> +						reg = <0>;
Generally, there should be a newline between properties and child
nodes.

> +						mdss0_intf0_out: endpoint {
> +							remote-endpoint = <&mdss0_dp0_in>;
> +						};
> +					};
> +
> +					port@4 {
> +						reg = <4>;
> +						mdss0_intf4_out: endpoint {
> +							remote-endpoint = <&mdss0_dp1_in>;
> +						};
> +					};
> +
>  					port@5 {
>  						reg = <5>;
>  						mdss0_intf5_out: endpoint {
> @@ -3199,6 +3213,154 @@ opp-600000000 {
>  				};
>  			};
>  
> +			mdss0_dp0: displayport-controller@ae90000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0xae90000 0 0x200>,
> +				      <0 0xae90200 0 0x200>,
> +				      <0 0xae90400 0 0x600>,
> +				      <0 0xae91000 0 0x400>,
> +				      <0 0xae91400 0 0x400>;
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <12>;
> +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
I overlooked this previously, but please turn this into a vertical list.

With these fixed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc0 DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> +
> +				phys = <&usb_0_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				operating-points-v2 = <&mdss0_dp0_opp_table>;
> +				power-domains = <&rpmhpd SC8280XP_CX>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss0_dp0_in: endpoint {
> +							remote-endpoint = <&mdss0_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss0_dp0_opp_table: opp-table {
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
> +			mdss0_dp1: displayport-controller@ae98000 {
> +				compatible = "qcom,sc8280xp-dp";
> +				reg = <0 0xae98000 0 0x200>,
> +				      <0 0xae98200 0 0x200>,
> +				      <0 0xae98400 0 0x600>,
> +				      <0 0xae99000 0 0x400>,
> +				      <0 0xae99400 0 0x400>;
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <13>;
> +				clocks = <&dispcc0 DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX1_AUX_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
> +					 <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +
> +				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
> +						  <&dispcc0 DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +							 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
> +
> +				phys = <&usb_1_qmpphy QMP_USB43DP_DP_PHY>;
> +				phy-names = "dp";
> +
> +				#sound-dai-cells = <0>;
> +
> +				operating-points-v2 = <&mdss0_dp1_opp_table>;
> +				power-domains = <&rpmhpd SC8280XP_CX>;
> +
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdss0_dp1_in: endpoint {
> +							remote-endpoint = <&mdss0_intf4_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +
> +				mdss0_dp1_opp_table: opp-table {
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
>  			mdss0_dp2: displayport-controller@ae9a000 {
>  				compatible = "qcom,sc8280xp-dp";
>  				reg = <0 0xae9a000 0 0x200>,
> @@ -3387,10 +3549,10 @@ dispcc0: clock-controller@af00000 {
>  			clocks = <&gcc GCC_DISP_AHB_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK>,
>  				 <&sleep_clk>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> -				 <0>,
> +				 <&usb_0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +				 <&usb_0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
> +				 <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +				 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
>  				 <&mdss0_dp2_phy 0>,
>  				 <&mdss0_dp2_phy 1>,
>  				 <&mdss0_dp3_phy 0>,
