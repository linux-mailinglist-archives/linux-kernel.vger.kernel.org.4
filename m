Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7F68BAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBFLBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBFLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:01:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230B716AC2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:01:10 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u21so11234205edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwRz4A4hQ/J9QIusp/1jXDk64bWoea7Fqenc5+pmfnE=;
        b=y6vB86/boAJml+m73otGVLoTarM87Pjnj7JSie5PXhii0ogznyY1LDXBtM3uBkReEz
         lLio7FhDIT90pPPo5XrypDG64iZB6oJlPO56tiQUF07UuZu4VR7goz+k8EG0dC8PLT6H
         cPK4YTPzN+sL0gI6joEc3TvrRevOmGiL2m9RT/R97S7y25ZsEUlmlwFYU8l4+FOdd3z2
         3zTfKPsAx/J/V5Ko8ixDEmQcskkn1uIZ1v1QtjkwiyUEwccg66yZxGr1b5L1Z2MYBq/n
         +PevY1avmoEneGws9pGyTPkGIt7sGd8mfXWwDHLJ0FyisGzXCQ+YajK1Dm5MYTz8vZTM
         R4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwRz4A4hQ/J9QIusp/1jXDk64bWoea7Fqenc5+pmfnE=;
        b=nnOg6pF0Ojfc8D24YPi0CVF4S6Ip1K28LzKmL0qU9+K/ixtThX7Jhz/R/L9nQME0dn
         uig3+iovpKRSdVA0QIo6k0ptNISESHA+iBP/+5r/STcgIGF1U8N1sBrHGtWR31H7oGez
         wrwxbS9OeuTAxexCbNujh6HGf48DXkiPxhkMrLvdML/LkrrXf3ykELIeCLU8f1+sCZS4
         FhnY0Q4aORZXLdGliralXnazysIWymYap4HWDJgLPnaXyfGld5vKzCYkVv3XkJV6OWQ7
         xkSgJGYwesUeADmaWTrmJaxSxyUzT0vRKXD7F7q06VOr5VSnbYxjdR8mc5Uj+5QsIw/0
         g3SA==
X-Gm-Message-State: AO0yUKWnkAGj/ntf8f+HWC+jLecQnNdtoGpe8yRdzoRDB8duP0IEFOIZ
        UMYVj/R3eml7LJEgtxu6sh6Kqw==
X-Google-Smtp-Source: AK7set/fY/ZlQZwJV7YWSAn/cECe7mID+2YbEp9fJdmXkb+zQZoxhhIklg46bHsUIgkCchCuox9cow==
X-Received: by 2002:a05:6402:1c07:b0:499:70a8:f915 with SMTP id ck7-20020a0564021c0700b0049970a8f915mr17576170edb.21.1675681268625;
        Mon, 06 Feb 2023 03:01:08 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id f15-20020a50d54f000000b004aac3fd90fbsm222495edj.17.2023.02.06.03.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 03:01:08 -0800 (PST)
Message-ID: <376236b5-9a5d-1c0b-65e4-346cc79e9de6@linaro.org>
Date:   Mon, 6 Feb 2023 12:01:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/5] arm64: dst: qcom: sm8450: add dp controller
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v1-0-f1345872ed19@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v1-5-f1345872ed19@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v1-5-f1345872ed19@linaro.org>
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



On 6.02.2023 11:17, Neil Armstrong wrote:
> Add the Display Port controller subnode to the MDSS node.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts |  4 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi    | 82 +++++++++++++++++++++++++++++++--
>  2 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> index 5bdc2c1159ae..1b4ef79f74b3 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
> @@ -480,7 +480,9 @@ &mdss_dsi0_phy {
>  	status = "okay";
>  };
>  
> -&mdss_mdp {
> +&mdss_dp0 {
> +	data-lanes = <0 1 2 3>;
> +
>  	status = "okay";
>  };
This belongs in a separate patch.

>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 757b7c56d5f5..8d83545d5e4a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2745,13 +2745,20 @@ ports {
>  
>  					port@0 {
>  						reg = <0>;
> -						dpu_intf1_out: endpoint {
> -							remote-endpoint = <&mdss_dsi0_in>;
> +						dpu_intf0_out: endpoint {
> +							remote-endpoint = <&mdss_dp0_in>;
>  						};
>  					};
>  
>  					port@1 {
>  						reg = <1>;
> +						dpu_intf1_out: endpoint {
> +							remote-endpoint = <&mdss_dsi0_in>;
> +						};
> +					};
> +
> +					port@2 {
> +						reg = <2>;
>  						dpu_intf2_out: endpoint {
>  							remote-endpoint = <&mdss_dsi1_in>;
>  						};
> @@ -2789,6 +2796,75 @@ opp-500000000 {
>  				};
>  			};
>  
> +			mdss_dp0: displayport-controller@ae90000 {
> +				compatible = "qcom,sm8350-dp";
> +				reg = <0 0xae90000 0 0x0fc>,
Trim the leading zeroes from the size part, please.

> +				      <0 0xae90200 0 0x0c0>,
> +				      <0 0xae90400 0 0x770>,
> +				      <0 0xae91000 0 0x098>;
> +				interrupt-parent = <&mdss>;
> +				interrupts = <12>;
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +				clock-names = "core_iface", "core_aux",
> +					      "ctrl_link",
> +			                      "ctrl_link_iface", "stream_pixel";
Make this a vertical list, please.

Konrad
> +
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +				assigned-clock-parents = <&usb_1_qmpphy 1>,
> +							 <&usb_1_qmpphy 2>;
> +
> +				phys = <&usb_1_qmpphy 1>;
> +			        phy-names = "dp";
> +
> +			        #sound-dai-cells = <0>;
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +				power-domains = <&rpmhpd SM8450_MMCX>;
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
> +				};
> +
> +				dp_opp_table: opp-table {
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
>  			mdss_dsi0: dsi@ae94000 {
>  				compatible = "qcom,sm8450-dsi-ctrl", "qcom,mdss-dsi-ctrl";
>  				reg = <0 0x0ae94000 0 0x400>;
> @@ -2966,8 +3042,8 @@ dispcc: clock-controller@af00000 {
>  				 <&mdss_dsi0_phy 1>,
>  				 <&mdss_dsi1_phy 0>,
>  				 <&mdss_dsi1_phy 1>,
> -				 <&usb_1_qmpphy 0>,
>  				 <&usb_1_qmpphy 1>,
> +				 <&usb_1_qmpphy 2>,
>  				 <0>, /* dp1 */
>  				 <0>,
>  				 <0>, /* dp2 */
> 
