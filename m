Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F56F3B51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjEBASa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:18:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737EF1
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 17:18:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso3917890e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 17:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682986704; x=1685578704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0KH7PrTyqIakLJHa4OE7SkEBnSW+9Gc8LTx1FKiD9A=;
        b=jRJtlARzzOFJ7dZjVWdprwLXYlniLT4F4G63wNFKX54kHOyyhXxP17Yu/RI43Yk9Vs
         8tXPfd1w9Ubn88Wv7aU2YhP6M8nTsaSLZPIoQYoKpw+BJhdmFCaX1+y7ynFgML9aGB7p
         hY2HsDYiIQIP6lCYivLcCvGZJWz8E5vb5XQZGj7IWX11rmxLaDeDROlyh7oPUKqupFYj
         5l7tVz2UTqeTmF89iqNAda4sB47jNKBlqlDZFAU17fRYPb/zqvXOEEWrfHXEGxeJ1dAj
         lVnJLdz0Xo3tS19wIeX2iDjXM2e9q8SgVK/uC1jyXYkMDOIS3Rexc3Dol2yqsjqoi4ay
         MIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682986704; x=1685578704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0KH7PrTyqIakLJHa4OE7SkEBnSW+9Gc8LTx1FKiD9A=;
        b=b8JgVAImKB/6I4z5m7cG66X9c0WuZBmg1QpC/BlQOGmVH2SpdkLkEIo57GEptg57/w
         iQHu/NdVDll3otMjcz8Lxi6B31IISrL89EnCqE4QMeVIzahf8sTpAW/HGno/Pg+VHylL
         ar9/9T32mCkhwdK02fSIaqfYtTM02COy9dykuP8Sp88782XCv8mNb9BBnm7yfAKh/tWY
         zE7dHQnvm4arWp04ztr2x5uOcB6rHQDc0YIJOvuS4ABeEOqO52tyUADKJGLbqXwKkYL2
         2lRpErgpQYYfCgnctbY4IJBhhiuCp4OyfhKeJppqrDHhCz1YsvZi47/1XWG3r2WZ/Ny0
         /sdw==
X-Gm-Message-State: AC+VfDzx7koEngxL/rsayZabRLxR5unlhpyZa1EfTlNy9AwrCIWaoLZS
        ZniDV6YOveYafGbdThFKYYQOXify6FiAuOR3dDQ=
X-Google-Smtp-Source: ACHHUZ5Teo45WCl2GPwJFhVFP2cBsMeFY0S4HCU1zQ08cS5w4XptLFpKequThz/vVtRAA7fOrqAMNQ==
X-Received: by 2002:ac2:515e:0:b0:4ef:f6c9:b977 with SMTP id q30-20020ac2515e000000b004eff6c9b977mr3837302lfd.49.1682986704534;
        Mon, 01 May 2023 17:18:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id j6-20020ac24546000000b004ed4fa5f20fsm5045572lfm.25.2023.05.01.17.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 17:18:24 -0700 (PDT)
Message-ID: <82e61752-dc76-9714-d2e1-13962c4217ee@linaro.org>
Date:   Tue, 2 May 2023 03:18:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 3/4] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230501192432.1220727-1-bhupesh.sharma@linaro.org>
 <20230501192432.1220727-4-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230501192432.1220727-4-bhupesh.sharma@linaro.org>
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

On 01/05/2023 22:24, Bhupesh Sharma wrote:
> Add USB superspeed qmp phy node to dtsi.
> 
> Make sure that the various board dts files (which include sm4250.dtsi file)
> continue to work as intended.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
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
> index 631ca327e064..21d00b0295a1 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -661,6 +661,31 @@ usb_hsphy: phy@1613000 {
>   			status = "disabled";
>   		};
>   
> +		usb_qmpphy: phy@1615000 {
> +			compatible = "qcom,sm6115-qmp-usb3-phy";
> +			reg = <0x0 0x01615000 0x0 0x200>;

I replied with R-B, but then I noticed that the length of the region is 
bad. What is the maximum offset that is used by the driver? I know that 
it is bigger than 0x200.

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
With best wishes
Dmitry

