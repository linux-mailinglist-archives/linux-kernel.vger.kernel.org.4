Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CC64B558
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiLMMlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiLMMkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:40:55 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9661F62B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:39:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id cf42so4709945lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hUr7FZEDFGX4ApwwkadvNdgk7btCuzU4oXDTJnctuE=;
        b=a2+pV2nP6odjnwkrP+T75Lo+hB11K4UsPJ6USnAI6bayp83qhyYovNVL+Ez1Memn6p
         QbjTD15BojBHI7Vs1dbhdbniwnrXc4O/YUpLyd1xBz2FsZoDWhJjzP2Cq5vlZrxcdGev
         5l0+kZcv5c4/nwIqMd2TJzHTJQVOWOq+YF05loi4v1sKdx12/d7LFgtcAsWvFarUWvV9
         XyHSNTOdFh6VLgLKIIkJ6e1SqtLFrKWPe2i5qFSyhXktPtxyOGnMVxvcKv9OcM9KMBKv
         5gtyu8tNLGnQbyQLrMBYR9KYuBsz9MSLy1sZrCjiQaxB8r53p7034h2G7B03lbZKmx9d
         kv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hUr7FZEDFGX4ApwwkadvNdgk7btCuzU4oXDTJnctuE=;
        b=H4k7vw8kHsS2bjTNSQYkieoQYmcZpeiTX/Cx9vpdSBAlYciPLFU+65pyM8eT0BiYHJ
         AesvDoRqK8S18YXX50MZelV2AieAs0hfPkRg1oZpPR7Kg4DE1LcobzWEiVWUMOp+XAgF
         jfmvX9s6LjbTVfeREOS88TsLOM8jBkIJ8ZRxKGE+xujSt6edh5/BgeeMGSAP8tmdaU7t
         mDagvxPrsDAD313FgoWOBQUnLnxa83W22ANSLYOEK/dT3+MqzScbAQP06RHwxzxueeyh
         MWWENxG5qxuHTyehcc0MMg+4vg8lfHxPOPnw59anIACD+4ztBNAIzyYR3k0JVk86RpQb
         VspA==
X-Gm-Message-State: ANoB5pnQb+tBfDY2Kt0Fb1FDz+NCE50jOFnaf7MEDqw54QMIDOzteb/C
        1u+aZrwefu0lEBNFhWMkmbnwfg==
X-Google-Smtp-Source: AA0mqf7QBrHwuTWYkyaTlujJ5o7iekzXF5KKimynvhPeE6TZ0W7Z5AVlyWabPb3rwOfaglNs0TP0cA==
X-Received: by 2002:ac2:5288:0:b0:4b6:e4c8:8a48 with SMTP id q8-20020ac25288000000b004b6e4c88a48mr2742278lfm.63.1670935194698;
        Tue, 13 Dec 2022 04:39:54 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id p8-20020ac24ec8000000b004b4e4671212sm348193lfr.232.2022.12.13.04.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 04:39:54 -0800 (PST)
Message-ID: <8aa0ee9f-46e1-7022-4728-7e09eadfee6c@linaro.org>
Date:   Tue, 13 Dec 2022 13:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm6115: Cleanup USB node names
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
 <20221213123823.455731-2-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221213123823.455731-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.2022 13:38, Bhupesh Sharma wrote:
> There is only one USB controller present on SM6115 / SM4250
> Qualcomm SoC, so drop the numbering used with USB nodes
> in the dtsi and the related sm4250-oneplus-billie2.dts.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts | 4 ++--
>  arch/arm64/boot/dts/qcom/sm6115.dtsi                | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index a3f1c7c41fd73..fa57f4bf58256 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -225,11 +225,11 @@ &ufs_mem_phy {
>  	status = "okay";
>  };
>  
> -&usb_1 {
> +&usb {
>  	status = "okay";
>  };
>  
> -&usb_1_hsphy {
> +&usb_hsphy {
>  	vdd-supply = <&vreg_l4a>;
>  	vdda-pll-supply = <&vreg_l12a>;
>  	vdda-phy-dpdm-supply = <&vreg_l15a>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 572bf04adf906..b5f7480c2e713 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -565,7 +565,7 @@ gcc: clock-controller@1400000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> -		usb_1_hsphy: phy@1613000 {
> +		usb_hsphy: phy@1613000 {
>  			compatible = "qcom,sm6115-qusb2-phy";
>  			reg = <0x01613000 0x180>;
>  			#phy-cells = <0>;
> @@ -991,7 +991,7 @@ spi5: spi@4a94000 {
>  			};
>  		};
>  
> -		usb_1: usb@4ef8800 {
> +		usb: usb@4ef8800 {
>  			compatible = "qcom,sm6115-dwc3", "qcom,dwc3";
>  			reg = <0x04ef8800 0x400>;
>  			#address-cells = <1>;
> @@ -1019,11 +1019,11 @@ usb_1: usb@4ef8800 {
>  			qcom,select-utmi-as-pipe-clk;
>  			status = "disabled";
>  
> -			usb_1_dwc3: usb@4e00000 {
> +			usb_dwc3: usb@4e00000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x04e00000 0xcd00>;
>  				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> -				phys = <&usb_1_hsphy>;
> +				phys = <&usb_hsphy>;
>  				phy-names = "usb2-phy";
>  				iommus = <&apps_smmu 0x120 0x0>;
>  				snps,dis_u2_susphy_quirk;
