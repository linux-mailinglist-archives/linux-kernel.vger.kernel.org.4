Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17FA6BE8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCQMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCQMKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:10:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0F39CF6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:09:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b10so5001349lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679054997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNiR0NLTuJj+aWp4YB9vTYSgpZApuVfwOdJ5ZUsnGj0=;
        b=YcGwRdgSUFM5T1XagjtlvRNmVe4Jf7NuzX+OWI7+j3ovglq4UV/JKpah/ATZQasTG6
         rwkRVwxVIeG5yVHBjuefiW9ETbkBVgDgpZfTRkQh0m5y+wJFjEitN4kLIEqI2CnC3kxz
         /iuweDgmIkQ7NOR+eVh180t3UrWe4FSPNjUqmafK8JZl6j0pius6GpDc4MS4Dple9BHx
         EdR1BWZYTdUUvJktXdxJoWYsH8HVEB5yL3J3Glp4NxV4eAvL0A8kjJ6sTAG55u108YPz
         XJT4J3p/EW3FWugSjA3LOwOlbLyroTbfHa3YGw5ZLCcFAq5THSe3TeKG5FPScqOw88zA
         2paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679054997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNiR0NLTuJj+aWp4YB9vTYSgpZApuVfwOdJ5ZUsnGj0=;
        b=s4sqeWaar/yPk+lreXm5/nwyoNfo5l77eTfrA0ovJJz3P9flP/Kz9PsZ/ODSfEYo/F
         282ryHn+yCbCIQEnq98bbqMYWhVeXo4HJ60At/sMs/9gKSEZeJc9VaRZb4Kdbuh6Qg61
         /B2wZeub2+7PM+ZvgZCtkIFIrzhrXItBE50IcJllVQQwqtpmzyt/6TIrBSDM2uoS7kFV
         WY/qaTBm+uUdDw7S0RAOaJUWjllNlx1R/Qa47/YYZF0NoUIwvXlyNJ85Gtw7oOwrafT/
         jkew+EPn4UBHPo8TwUEpTffbh2CZbDE0aL6Ohk2MbqycyTDa7EKt4RyE2+5CCg0q4qY4
         QbXQ==
X-Gm-Message-State: AO0yUKWm3FN0Op6PWZ8Pn7g75UNpGQewSUyUm1soKQdI29fE2MdbqbGF
        tJz5R6UujPM50aRFjDVTTp+UWQ==
X-Google-Smtp-Source: AK7set/J4wuWg4OytN80EDGFmX2hbBh16ONc9kAfE7OVJZXwNRrc3IJx9b1HCdYwn/r8MRS+n9Q9cQ==
X-Received: by 2002:a05:6512:406:b0:4e9:59cd:4171 with SMTP id u6-20020a056512040600b004e959cd4171mr1956040lfk.60.1679054996939;
        Fri, 17 Mar 2023 05:09:56 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id r10-20020a056512102a00b004e7b84c6419sm343432lfr.192.2023.03.17.05.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:09:56 -0700 (PDT)
Message-ID: <ab6391c4-ff38-8286-77ff-c781669f5aa0@linaro.org>
Date:   Fri, 17 Mar 2023 14:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: sm8450: switch to usb3/dp combo
 phy
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230206-topic-sm8450-upstream-dp-controller-v5-0-a27f1b26ebe8@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v5-4-a27f1b26ebe8@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v5-4-a27f1b26ebe8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 11:12, Neil Armstrong wrote:
> The QMP PHY is a USB3/DP combo phy, switch to the newly
> documented bindings and register the clocks to the GCC
> and DISPCC controllers.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 42 +++++++++++++-----------------------
>   1 file changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 69695eb83897..0b5a151ce138 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -11,6 +11,7 @@
>   #include <dt-bindings/dma/qcom-gpi.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/interconnect/qcom,sm8450.h>
>   #include <dt-bindings/soc/qcom,gpr.h>
> @@ -748,7 +749,7 @@ gcc: clock-controller@100000 {
>   				 <&ufs_mem_phy_lanes 0>,
>   				 <&ufs_mem_phy_lanes 1>,
>   				 <&ufs_mem_phy_lanes 2>,
> -				 <0>;
> +				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>   			clock-names = "bi_tcxo",
>   				      "sleep_clk",
>   				      "pcie_0_pipe_clk",
> @@ -2034,37 +2035,24 @@ usb_1_hsphy: phy@88e3000 {
>   			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>   		};
>   
> -		usb_1_qmpphy: phy-wrapper@88e9000 {
> -			compatible = "qcom,sm8450-qmp-usb3-phy";
> -			reg = <0 0x088e9000 0 0x200>,
> -			      <0 0x088e8000 0 0x20>;
> -			status = "disabled";
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +		usb_1_qmpphy: phy@88e8000 {
> +			compatible = "qcom,sm8450-qmp-usb3-dp-phy";
> +			reg = <0 0x088e8000 0 0x4000>;

This should be 0x3000 too, like 8350

>   
>   			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
>   				 <&rpmhcc RPMH_CXO_CLK>,
> -				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> -			clock-names = "aux", "ref_clk_src", "com_aux";
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
>   
>   			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
>   				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
>   			reset-names = "phy", "common";
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
>   		};
>   
>   		remoteproc_slpi: remoteproc@2400000 {
> @@ -2972,8 +2960,8 @@ dispcc: clock-controller@af00000 {
>   				 <&mdss_dsi0_phy 1>,
>   				 <&mdss_dsi1_phy 0>,
>   				 <&mdss_dsi1_phy 1>,
> -				 <0>, /* dp0 */
> -				 <0>,
> +				 <&usb_1_qmpphy QMP_USB43DP_DP_LINK_CLK>,
> +				 <&usb_1_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
>   				 <0>, /* dp1 */
>   				 <0>,
>   				 <0>, /* dp2 */
> @@ -4168,7 +4156,7 @@ usb_1_dwc3: usb@a600000 {
>   				iommus = <&apps_smmu 0x0 0x0>;
>   				snps,dis_u2_susphy_quirk;
>   				snps,dis_enblslpm_quirk;
> -				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>   				phy-names = "usb2-phy", "usb3-phy";
>   			};
>   		};
> 

-- 
With best wishes
Dmitry

