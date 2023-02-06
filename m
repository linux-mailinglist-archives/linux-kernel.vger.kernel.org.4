Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950B868BAE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBFLD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBFLD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:03:27 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C84199E7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:03:20 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m2so33024490ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 03:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r46kwHvPKE8Px9ZiS/xnYK0EPgLQiTPTfjFiyC1D1lc=;
        b=n4ZLojagyh2idCX10gQdGqNty036l66vbIydottcRCLjJ424NEtb2qRX2+Juv7iSJ/
         bjp48RgQ52+opyYT2RlQADpKMj6tPLVPdAjB8+zmOkg/3rKN1sLYA9eh90gI4QhWtT7o
         hVHv7yKbQ8OvVk1jf8sBO7sdIk/MP6HKNYjvGyFDCINoGuuVoJHjJd5YcFINhxQZMfop
         O6XTZKeUBBAJl0obKonjRzwLx1FAn9lgXy5JiwYUrW1c8HVYoiOm2YEnnJOym2Km8ewM
         DV7ZwJi4MX/DKRcLkH19J8GpE0btE02ls1Jd1d5t2bHJsdlb3A1JJWunTqKdcr7M3mNZ
         q5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r46kwHvPKE8Px9ZiS/xnYK0EPgLQiTPTfjFiyC1D1lc=;
        b=AW/xE7PWERF/hF3NbHbJDtp7UNdHz1ifMkxXz92qYqkOf9Rrvf8USHC/BK7YNFSq3u
         RGPZGw39xpnpCx04mUi6Tau4TcaCnaZ/OKydpjO8WMyyYBA8iwb7wYC5QqYidy58s9bn
         wmKtTXXjpbCzLccTYoIFNOQW0LfUiIbI+DB7bQJd8XPdEt9ukcIQ9zDeANb9hocvQ3zP
         6lczGh9NysptbWNXIFI0Hon5GLUdhgZQ5HZ9dW1vzsWkEdtGbJg0eDodD6XYi21c0bW2
         NsIvC6F248Ei+2jEo8IeD94lh4UapR/K2Ow9gYYQ3lMIYVJL8zoYzaHWP2rMNskjmsfn
         rS8Q==
X-Gm-Message-State: AO0yUKV4AFLj0aqKH//VN34j+ZoiekeFVmMCML/3JokGNx0fZTfsLZOH
        f3GYlV64cjmy14jjovrrgMEmlA==
X-Google-Smtp-Source: AK7set+YdZnL+f48weeelNcGbGXE0glbzkIvqdl18mZf7i07CH/EKsdWggKbRZNvM7syo13PzUWaPw==
X-Received: by 2002:a17:906:7c88:b0:879:2a5:dc40 with SMTP id w8-20020a1709067c8800b0087902a5dc40mr20746955ejo.76.1675681398790;
        Mon, 06 Feb 2023 03:03:18 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id ka6-20020a170907920600b0080345493023sm5246275ejb.167.2023.02.06.03.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 03:03:18 -0800 (PST)
Message-ID: <9e6be00e-305e-b4d1-049d-5205ac77f576@linaro.org>
Date:   Mon, 6 Feb 2023 12:03:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/5] arm64: dst: qcom: sm8450: switch to usb3/dp combo phy
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
 <20230206-topic-sm8450-upstream-dp-controller-v1-4-f1345872ed19@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v1-4-f1345872ed19@linaro.org>
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

subject: s/dst/dts here and in 5/5

On 6.02.2023 11:17, Neil Armstrong wrote:
> The QMP PHY is a USB3/DP combo phy, switch to the newly
> documented bindings and register the clocks to the GCC
> and DISPCC controllers.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 38 +++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index d66dcd8fe61f..757b7c56d5f5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -748,7 +748,7 @@ gcc: clock-controller@100000 {
>  				 <&ufs_mem_phy_lanes 0>,
>  				 <&ufs_mem_phy_lanes 1>,
>  				 <&ufs_mem_phy_lanes 2>,
> -				 <0>;
> +				 <&usb_1_qmpphy 0>;
>  			clock-names = "bi_tcxo",
>  				      "sleep_clk",
>  				      "pcie_0_pipe_clk",
> @@ -2038,37 +2038,27 @@ usb_1_hsphy: phy@88e3000 {
>  			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>  		};
>  
> -		usb_1_qmpphy: phy-wrapper@88e9000 {
> -			compatible = "qcom,sm8450-qmp-usb3-phy";
> -			reg = <0 0x088e9000 0 0x200>,
> -			      <0 0x088e8000 0 0x20>;
> -			status = "disabled";
> +		usb_1_qmpphy: phy@88e8000 {
> +			compatible = "qcom,sm8450-qmp-usb3-dp-phy";
> +			reg = <0 0x088e8000 0 0x4000>;

>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
These can go since you're removing the subnode, I think..
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
>  		remoteproc_slpi: remoteproc@2400000 {
> @@ -2976,8 +2966,8 @@ dispcc: clock-controller@af00000 {
>  				 <&mdss_dsi0_phy 1>,
>  				 <&mdss_dsi1_phy 0>,
>  				 <&mdss_dsi1_phy 1>,
> -				 <0>, /* dp0 */
> -				 <0>,
> +				 <&usb_1_qmpphy 0>,
> +				 <&usb_1_qmpphy 1>,
>  				 <0>, /* dp1 */
>  				 <0>,
>  				 <0>, /* dp2 */
> @@ -4157,7 +4147,7 @@ usb_1_dwc3: usb@a600000 {
>  				iommus = <&apps_smmu 0x0 0x0>;
>  				snps,dis_u2_susphy_quirk;
>  				snps,dis_enblslpm_quirk;
> -				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phys = <&usb_1_hsphy>, <&usb_1_qmpphy 0>;
>  				phy-names = "usb2-phy", "usb3-phy";
BTW msm-5.10 marks the dwc3 subdevice dma-coherent, maybe we should too?

Konrad
>  			};
>  		};
> 
