Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E66F4255
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjEBLML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:12:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A261BF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:12:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f19ab99540so34964065e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683025926; x=1685617926;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=POVYlMSdmDpsDTMGWAJqODW5rahuzC8xt0jz2UbQEBw=;
        b=MPleUp3NmgyL2VWv14JYtROsauZg/sTyWTPNb6mLkWvm7odCnudvJ52E0Rz22XHjaE
         SaCwyzm2q+rMve8kGQ3ub26jJDBf/FwHqPZlZJWJGTE10alEaq4lkNHoa6sKYe+/0M3K
         FNUrzh0FYqeARQrUxaitf/oToNIyXi50eSRNoYGIx8j/IA9FBNzIkHcUMJ9ziw+HLAGO
         aTDTwQtGXyk3630CBGuXeTN0/KSdWGAG0mEzNhYbKEMCN+1yyVy0sbQA4GWPbwxuC+fy
         yENjOlmnNmtZGq/VhvTS+vbBEaeXKHsFks0pqkYi5sUIVaSayoBRLTTBpOAioxhHSYt5
         iR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683025926; x=1685617926;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POVYlMSdmDpsDTMGWAJqODW5rahuzC8xt0jz2UbQEBw=;
        b=JqFDvNVy+6BDB8C82Llz9SvcV/AvdGb2YdMTePQ4/f5jeO8OnLLh64uWCmjzBVrfwb
         kcRZJb1aoU2H4J/3rUgM8V/8YKlj3dUhYU1t+mb8Km9YserQ4wgk1vD4HwGzsrNubv1m
         BmCVsjn5ejpQYIn9VkJtM8D/vl+l+mT+87gVZD+g35Cj669vBWw9C/OkIbFP0nUNg2Yp
         DWuiAHvWzD3CUDQi+akZ0n2KH6SoGermbvQdkAk3tF9DAn4tBA2A8HQsfoIOu0FWUhDw
         CndGAlX0Fz9OB7MTTiWdKnOUocNnP5YXi4tyu75bM9EmWJU6K28DaAp49R/1BZbqLL8b
         0YRQ==
X-Gm-Message-State: AC+VfDys5bJEdBuWYBGrhkVFafo5xLDmwdI90P1qczFx/qKJN3ixRZBw
        dgMpBzD925qQz/cHl9lrHeYSzQ==
X-Google-Smtp-Source: ACHHUZ4VlJHcWFeYH/xtb9cqtUYXmmXEskLUYBbB2TnKPWSkDHmMlB+x6iEGFbEl6cDLFoFHP3ZUTA==
X-Received: by 2002:a5d:58d2:0:b0:2f4:215a:98c5 with SMTP id o18-20020a5d58d2000000b002f4215a98c5mr10590825wrf.70.1683025925792;
        Tue, 02 May 2023 04:12:05 -0700 (PDT)
Received: from [192.168.1.154] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm38271314wmp.5.2023.05.02.04.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 04:12:05 -0700 (PDT)
Message-ID: <9c82a21c-44d2-2916-751d-d2481031cf07@linaro.org>
Date:   Tue, 2 May 2023 12:12:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 3/4] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Content-Language: en-GB, en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org
References: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
 <20230502053534.1240553-4-bhupesh.sharma@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
Organization: Linaro
In-Reply-To: <20230502053534.1240553-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 06:35, Bhupesh Sharma wrote:
> Add USB superspeed qmp phy node to dtsi.
> 
> Make sure that the various board dts files (which include sm4250.dtsi file)
> continue to work as intended.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
>   arch/arm64/boot/dts/qcom/sm6115.dtsi          | 29 +++++++++++++++++--
>   .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
>   3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index a1f0622db5a0..75951fd439df 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -242,6 +242,9 @@ &usb {
>   &usb_dwc3 {
>   	maximum-speed = "high-speed";
>   	dr_mode = "peripheral";
> +
> +	phys = <&usb_hsphy>;
> +	phy-names = "usb2-phy";
>   };
>   
>   &usb_hsphy {
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 631ca327e064..f67863561f3f 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -661,6 +661,31 @@ usb_hsphy: phy@1613000 {
>   			status = "disabled";
>   		};
>   
> +		usb_qmpphy: phy@1615000 {
> +			compatible = "qcom,sm6115-qmp-usb3-phy";
> +			reg = <0x0 0x01615000 0x0 0x1000>;
> +
> +			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "cfg_ahb",
> +				      "ref",
> +				      "com_aux",
> +				      "pipe";
> +
> +			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> +				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> +			reset-names = "phy", "phy_phy";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "usb3_phy_pipe_clk_src";
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>   		qfprom@1b40000 {
>   			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>   			reg = <0x0 0x01b40000 0x0 0x7000>;
> @@ -1111,8 +1136,8 @@ usb_dwc3: usb@4e00000 {
>   				compatible = "snps,dwc3";
>   				reg = <0x0 0x04e00000 0x0 0xcd00>;
>   				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> -				phys = <&usb_hsphy>;
> -				phy-names = "usb2-phy";
> +				phys = <&usb_hsphy>, <&usb_qmpphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
>   				iommus = <&apps_smmu 0x120 0x0>;
>   				snps,dis_u2_susphy_quirk;
>   				snps,dis_enblslpm_quirk;
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> index ea3340d31110..81fdcaf48926 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -306,6 +306,9 @@ &usb {
>   &usb_dwc3 {
>   	maximum-speed = "high-speed";
>   	dr_mode = "peripheral";
> +
> +	phys = <&usb_hsphy>;
> +	phy-names = "usb2-phy";
>   };
>   
>   &usb_hsphy {

-- 
--
Kind Regards,
Caleb (they/them)
