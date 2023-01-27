Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0F67F05B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjA0VYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjA0VYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:24:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358471D919
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:24:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso6203940wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTUfdhlTEOfdl/ldpk9Lhv3WxL8z/CXYcPInfVrR2L0=;
        b=IHiHTzDa+xmRWBUTN2BMRv0XZWZWJtfmRS4o26q9bqJqnSjhzy9i4JvPn4kE4BXlW7
         ZVABm8HHiM4cNmbqlSor7NAfaV5T+wKS4Nyfig6E4OxAqqTf6I2JC3hlpvqU1PZchW8x
         OFYWSdzly27cRGfoAqeCfYWOAgUOOi17U/7FQSbDhVrMe+1BX6c/HoiRSIDSPX0Odnfd
         h1vJ3G7EbpfWoG/07b0CZWNVxrSApfyGcoSrOt9EG8IQ1rk62q6lqiW+3HO8RiSB/ppI
         vi+yqsvKG0lGtXB0Z6u0h7ClZoCiaZBX69OSnCkdeVTztSWf6xj6iPapGTXlq+0jw9m4
         Dm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTUfdhlTEOfdl/ldpk9Lhv3WxL8z/CXYcPInfVrR2L0=;
        b=4q1SWlj0Ii+uSu3yL1M7MWf3+hr0YOUlcD2M5WMdaenHoiHcSkliwTnvkYY+MElass
         D63iLYv6AXwV+Uq6YoFGSAYMzAQl92VkD2Xfq87oISyOtZVGR7Xn93x2Alt2DW3Wu4E5
         3JULYg3kkT1gbOBaojMr6sDkR5b6mI60WlIK2iDAlL1PwdbvjKRKViED2FzlgupQvqYT
         hicNYGIc39+lRJyME5mLjn47cijbZGFCnHf1KGFj2hB3FDprGkIrI+/xGWGdStdJjBZi
         eEYkpIBJOLsXXQqX59HHUaKZfRD2/6O+8vd/DTQVvmd6UmpKExY3lZfG+pu7+DuLV1Oe
         Zo3Q==
X-Gm-Message-State: AFqh2kpDli+uf7UJZEELypXLGvE688UMOv0b545es0+AweN2Y78GcHzp
        SawZY10Jvx6WX/sxK34QIa7woQ==
X-Google-Smtp-Source: AMrXdXtDQFhR45y0gs25bLmrKHWNmHZcMv+Yywf3fqjOffbVdnEGyyV1AKrBw66mrfv9Tb+W/qcBBA==
X-Received: by 2002:a05:600c:1609:b0:3db:12a:5e65 with SMTP id m9-20020a05600c160900b003db012a5e65mr40296129wmn.4.1674854646796;
        Fri, 27 Jan 2023 13:24:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c339200b003dc42d48defsm1369678wmp.6.2023.01.27.13.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 13:24:06 -0800 (PST)
Message-ID: <3fc8863b-a378-1ccd-982d-6e44013d97c8@linaro.org>
Date:   Fri, 27 Jan 2023 22:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFT PATCH v2 3/4] arm64: dts: exynos: add unit address to DWC3
 node wrapper in Exynos5433
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230127211527.260060-1-krzysztof.kozlowski@linaro.org>
 <20230127211527.260060-3-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127211527.260060-3-krzysztof.kozlowski@linaro.org>
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

On 27/01/2023 22:15, Krzysztof Kozlowski wrote:
> Neither simple-bus bindings nor dtc W=1 accept device nodes in soc@ node
> which do not have unit address.  Therefore usethe address space
> of child device (actual DWC3 Controller) as the wrapper's address to
> fix:
> 
>   exynos5433-tm2e.dtb: soc@0: usbdrd: {'compatible': ['samsung,exynos5433-dwusb3'], ...
>     should not be valid under {'type': 'object'}
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 9da24fe958a3..0fca783979f6 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -1742,7 +1742,7 @@ hsi2c_11: i2c@14df0000 {
>  			status = "disabled";
>  		};
>  
> -		usbdrd30: usbdrd {
> +		usbdrd30: usb@15400000 {
>  			compatible = "samsung,exynos5433-dwusb3";
>  			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>,
>  				<&cmu_fsys CLK_SCLK_USBDRD30>,
> @@ -1751,16 +1751,16 @@ usbdrd30: usbdrd {
>  			clock-names = "aclk", "susp_clk", "phyclk", "pipe_pclk";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges;
> +			ranges = <0x0 0x15400000 0x10000>;
>  			status = "disabled";
>  
> -			usbdrd_dwc3: usb@15400000 {
> +			usbdrd_dwc3: usb@0 {
>  				compatible = "snps,dwc3";
>  				clocks = <&cmu_fsys CLK_SCLK_USBDRD30>,
>  					<&cmu_fsys CLK_ACLK_USBDRD30>,
>  					<&cmu_fsys CLK_SCLK_USBDRD30>;
>  				clock-names = "ref", "bus_early", "suspend";
> -				reg = <0x15400000 0x10000>;
> +				reg = <0x0 0x10000>;
>  				interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
>  				phys = <&usbdrd30_phy 0>, <&usbdrd30_phy 1>;
>  				phy-names = "usb2-phy", "usb3-phy";
> @@ -1795,7 +1795,7 @@ usbhost30_phy: phy@15580000 {
>  			status = "disabled";
>  		};
>  
> -		usbhost30: usbhost {
> +		usbhost30: usb@15a00000 {
>  			compatible = "samsung,exynos5433-dwusb3";
>  			clocks = <&cmu_fsys CLK_ACLK_USBHOST30>,
>  				<&cmu_fsys CLK_SCLK_USBHOST30>,
> @@ -1804,16 +1804,16 @@ usbhost30: usbhost {
>  			clock-names = "aclk", "susp_clk", "phyclk", "pipe_pclk";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges;
> +			ranges <0x0 0x15a00000 0x10000>;

This does not even build...

Best regards,
Krzysztof

