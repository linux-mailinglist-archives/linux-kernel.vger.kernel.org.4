Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4F64B584
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiLMM4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiLMM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:56:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856E1CFE8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:56:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so4749759lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDRj4WOJbdPREIb749HQ13QxtWlONFuq1JzJNUeCNpg=;
        b=ZuxwNkHLhVTyZ+XWGzpS4XUn5GkDdTwsn1UUUqZAkdeppV42d4iiQ4FRASXlz+kXOm
         JCSGK66De/Iab54DK4uSgVwabKTt8UPksrkd5dZLs5FSj8fIapmgV81+5HgRvFc7PkaA
         XQRfT6ZxKL6f1tgRNvx9+DEi+vDXINQ0PAcKtFs8m+Rw/ICfyjiijtDWNKWIt94N5gwq
         qX2kl19sNyG3zrAKxOBC1Fl+RInNIM2m2pLbOxoLeJ6A4AAXb2e/zHlOtto/YDJw0P4b
         6juNPTYJdETjVs7JYgtAiLJJ1mRB6OOmsVZw8xG5W/NoRep3/+aosohbPRjakWwyG26x
         Uvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDRj4WOJbdPREIb749HQ13QxtWlONFuq1JzJNUeCNpg=;
        b=TEJpVOFHYTKi25bpUPpuTVW3+kVwrwMyFQbWIGSjrV59sIEl0K/4GiubM9ssIx0poO
         efqWHcdIzOJIHuKpbHooZC6pJmTUT2x7w5x6F9i+4gQel7RFBJKOvJl8wvQkXLJWv62O
         7E2r2W3qVTY9kgbcCj6HBq5S7PFqkQ0Goq1lpTNm2H4gXeQsHmhT7FQD7NE85ojbUNlg
         7DqBzhS8XvPaEL4Nljinube+C0wyDITyHKO9pBiN37aISBs0ZU5K2dmuBJ3A1n0Oi4IK
         f0bqJa9VTpE2UYVz8tWdhL9mGXC4k1+2f6TZ/3ZB7Fnu74QYUrg7tnIcYNWG5Lzelxhk
         ygCA==
X-Gm-Message-State: ANoB5pkT6QBCU9XBN0jO4JmHmbHCB4gJs6vK3+TEYG6pY8eJx+92bMAW
        jUYbWDNfvTstb+KWJu63RZSDNw==
X-Google-Smtp-Source: AA0mqf7tAGagkXyfYUWEQTPUGp7HeBrp1ETg+KFiqpiNIBrJzlVTmS8z4SbTF9vzXQsDugimHZXx0w==
X-Received: by 2002:ac2:5fc1:0:b0:4aa:54a:3a6e with SMTP id q1-20020ac25fc1000000b004aa054a3a6emr5018196lfg.41.1670936170600;
        Tue, 13 Dec 2022 04:56:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b00492e3a8366esm361281lfr.9.2022.12.13.04.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 04:56:10 -0800 (PST)
Message-ID: <39ff2174-6d04-ec21-b762-377ed28088cb@linaro.org>
Date:   Tue, 13 Dec 2022 13:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
References: <20221213123823.455731-1-bhupesh.sharma@linaro.org>
 <20221213123823.455731-4-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213123823.455731-4-bhupesh.sharma@linaro.org>
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

On 13/12/2022 13:38, Bhupesh Sharma wrote:
> Add USB superspeed qmp phy node to dtsi.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 38 ++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index e4ce135264f3d..9c5c024919f92 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		usb_qmpphy: phy@1615000 {
> +			compatible = "qcom,sm6115-qmp-usb3-phy";
> +			reg = <0x01615000 0x200>;
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_AHB2PHY_USB_CLK>;
> +			clock-names = "com_aux",
> +				      "ref",
> +				      "cfg_ahb";
> +			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> +				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> +			reset-names = "phy", "phy_phy";
> +			status = "disabled";

Hm, you add a disabled PHY which is used by existing controller. The
controller is enabled in board DTS, but new PHY node isn't. Aren't you
now breaking it?

> +
> +			usb_ssphy: phy@1615200 {
> +				reg = <0x01615200 0x200>,
> +				      <0x01615400 0x200>,
> +				      <0x01615c00 0x400>,
> +				      <0x01615600 0x200>,
> +				      <0x01615800 0x200>,
> +				      <0x01615a00 0x100>;
> +				#phy-cells = <0>;
> +				#clock-cells = <1>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
> +

Just one blank line.

>  		qfprom@1b40000 {
>  			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>  			reg = <0x01b40000 0x7000>;
> @@ -1023,8 +1057,8 @@ usb_dwc3: usb@4e00000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x04e00000 0xcd00>;
>  				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> -				phys = <&usb_hsphy>;
> -				phy-names = "usb2-phy";
> +				phys = <&usb_hsphy>, <&usb_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
>  				iommus = <&apps_smmu 0x120 0x0>;
>  				snps,dis_u2_susphy_quirk;
>  				snps,dis_enblslpm_quirk;

Best regards,
Krzysztof

