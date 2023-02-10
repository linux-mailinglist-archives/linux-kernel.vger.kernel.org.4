Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62D691D77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjBJLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjBJLA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:00:59 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600570721
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:00:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eq11so4427740edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB1OYQZVG8OLqpTp+fXEkB8+PqKD9vdmFhelUczRsh4=;
        b=SUvrG5J/DfoTMuh+maWLM1dvf+iSEVQ8TW/ZpzSVAqtyZmkZEK3XQ3174F209dIC6c
         nZ+mNboevjsvgBDaZcuJIVu/AMKsanDKspKGAKZlDo0EddtuvnevGWJbSH35WVWoXEvW
         Ifmf33HzzwNpK9wKK6JbAlWZu1fhZIDn/YUsN5l/oWxr86AXXjAw5sibv6lmDTPYNOnG
         qtQ255W7wXrQ8ZcXzDSbyBlEA2bdHEQd6ANgyFZHDDqIUbYxWU90ntfZls2k/O+FnGCl
         6VmYCD7C4tOmUqfAyNGLl1I5UGl37br3r+ReBPvz38zZGNyAU5Gd4XNzabJOxbJay7ht
         Dggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB1OYQZVG8OLqpTp+fXEkB8+PqKD9vdmFhelUczRsh4=;
        b=op9bUzwzU2Odwk2lS5tyiOzUA71RV5yASizYXCeF0Tixw4pfWszBXqgBma5jKwnxtS
         bpvn3jzFejh7x+bFNnKVv1OXdllSqwFSUpmjEVnrEWGk1kptImqkA9zIgk0DP2lPNr9X
         +lkj8Th9axg1ULrk+z9e63kkZKF599cClI+U2tQHShjEC5Q/wFiBEutBcrfUKMLeAdO4
         3R05GHWTDO0t4IDQ74eXwclLzBV11FD2lEgMViPLB+9NC4rb/GGCuzIGQbyjGtcPZp1b
         uxf7oTfkEbqORPQ3Tm5mjPLLMXHLnOGL9264y145H28TAyefpNaddsGAN77uxskC07C4
         CEKQ==
X-Gm-Message-State: AO0yUKU6qoXtXRrX09NA36Cx/YXdGEKc3PJSCMCJHWoihOMu3DzDmV3c
        IM5tGrOvmzKvlSkWp7/p5bndmg==
X-Google-Smtp-Source: AK7set/QBspTB7GmXObNLkHG58t7jXg5pr3WL6IjkXG7nDSUNRwwFdCFst4DHzBImkd7bstb5OZaig==
X-Received: by 2002:a50:d548:0:b0:4a2:223d:4514 with SMTP id f8-20020a50d548000000b004a2223d4514mr15861524edj.8.1676026854881;
        Fri, 10 Feb 2023 03:00:54 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id q17-20020a50c351000000b004aacd6b88ccsm2016167edb.90.2023.02.10.03.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:00:54 -0800 (PST)
Message-ID: <30c8c24b-4ae1-2623-a547-6dcb16b3974b@linaro.org>
Date:   Fri, 10 Feb 2023 12:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/5] arm64: dts: qcom: sm8350: switch to combo usb3/dp
 phy
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
References: <20230206-topic-sm8450-upstream-dp-controller-v2-0-529da2203659@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v2-2-529da2203659@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v2-2-529da2203659@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.02.2023 11:34, Neil Armstrong wrote:
> The first QMP PHY is an USB3/DP combo phy, switch to the newly
> documented bindings and register the clocks to the GCC
> and DISPCC controllers.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 40 ++++++++++++------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 04bb838189a6..d490ce84a022 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -652,7 +652,7 @@ gcc: clock-controller@100000 {
>  				 <&ufs_mem_phy_lanes 0>,
>  				 <&ufs_mem_phy_lanes 1>,
>  				 <&ufs_mem_phy_lanes 2>,
> -				 <0>,
> +				 <&usb_1_qmpphy 0>,
Please use the defines from include/dt-bindings/phy/phy-qcom-qmp.h

>  				 <0>;
>  		};
>  
> @@ -2601,37 +2601,24 @@ usb_2_hsphy: phy@88e4000 {
>  			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
>  		};
>  
> -		usb_1_qmpphy: phy-wrapper@88e9000 {
> -			compatible = "qcom,sm8350-qmp-usb3-phy";
> -			reg = <0 0x088e9000 0 0x200>,
> -			      <0 0x088e8000 0 0x20>;
> -			status = "disabled";
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +		usb_1_qmpphy: phy@88e9000 {
> +			compatible = "qcom,sm8350-qmp-usb3-dp-phy";
> +			reg = <0 0x088e8000 0 0x3000>;
>  
>  			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK>,
> -				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> -			clock-names = "aux", "ref_clk_src", "com_aux";
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
>  
>  			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
>  				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
>  			reset-names = "phy", "common";
>  
> -			usb_1_ssphy: phy@88e9200 {
> -				reg = <0 0x088e9200 0 0x200>,
> -				      <0 0x088e9400 0 0x200>,
> -				      <0 0x088e9c00 0 0x400>,
> -				      <0 0x088e9600 0 0x200>,
> -				      <0 0x088e9800 0 0x200>,
> -				      <0 0x088e9a00 0 0x100>;
> -				#phy-cells = <0>;
> -				#clock-cells = <0>;
> -				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> -				clock-names = "pipe0";
> -				clock-output-names = "usb3_phy_pipe_clk_src";
> -			};
> +			#clock-cells = <1>;
> +			#phy-cells = <1>;
> +
> +			status = "disabled";
>  		};
>  
>  		usb_2_qmpphy: phy-wrapper@88eb000 {
> @@ -2727,7 +2714,7 @@ usb_1_dwc3: usb@a600000 {
>  				iommus = <&apps_smmu 0x0 0x0>;
>  				snps,dis_u2_susphy_quirk;
>  				snps,dis_enblslpm_quirk;
> -				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phys = <&usb_1_hsphy>, <&usb_1_qmpphy 0>;
And here too.

Otherwise LGTM!

Konrad
>  				phy-names = "usb2-phy", "usb3-phy";
>  			};
>  		};
> @@ -3092,8 +3079,7 @@ dispcc: clock-controller@af00000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
>  				 <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>,
>  				 <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>,
> -				 <0>,
> -				 <0>;
> +				 <&usb_1_qmpphy 1>, <&usb_1_qmpphy 2>;
>  			clock-names = "bi_tcxo",
>  				      "dsi0_phy_pll_out_byteclk",
>  				      "dsi0_phy_pll_out_dsiclk",
> 
