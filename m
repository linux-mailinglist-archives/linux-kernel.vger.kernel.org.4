Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F373673584C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjFSNQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFSNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:16:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B461726
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:16:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso41491941fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180568; x=1689772568;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sM3CcPFP4F9FIEm4Nxl2/Ir6TV9n1Rj9wbe9m/rfRB4=;
        b=C5wwai1SzyHLAKvLpHjBqHiKKm6Xsh5biXqHQo52GV8Vi8UqNe8y126fuestXCwnaB
         ImqAQb8VzFDlWRhu4Jeu4mLdGZ3Vsu3XU+bvL/kBol4vwTRZjTvL4RuJz5DnDq3Ped/9
         qnuyvkQUPpW0VSgUAXm01g7k+j0rij3p8+M0gNCnq0J2+3SzPF85s8G615dCCDr4m3b7
         7baDr2m+sPT8LCAqh2QrrFhY+kJaInDoIHEazDiroCwDLcDLrqU8BUe1uX1TOnuBiu8e
         vcEaIfgsrcAj3IrXJOH8jMbim65MsTGfI3c5L0mTJ6GGniNh2GtnS7c1sv+TDdv7/+a4
         LxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180568; x=1689772568;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM3CcPFP4F9FIEm4Nxl2/Ir6TV9n1Rj9wbe9m/rfRB4=;
        b=TbdFjpRUIt++yGhKMALoOQsyAi5IyDPgkEl68j6YagMfnDFvX+s2qCIcX0W8YFB5kV
         TshQrjEmyWXN0zdkVj6sq6Xw0foAY5e6AfCzASxFtpZnhKzshQvC/Idaiks/IOLCTAEv
         vPpG7rUNW8QNXSaBFjUuPMTkCC5KDJySK/D+nW0q707WrSKF5qdwK4wR7ZLGWAwXQP5b
         nWuiDbvPQCil7Sl+gl39RZj8rspePciYk8BgwHWTNUbca5qK0roV+8iYGqPULzCKa0cG
         3HfCUYQupjdiw6X+caDHbOG4CkXeqBcvVJTsalkjG0KECIWtzvkGCbye01EnTDqfJGb3
         7oCw==
X-Gm-Message-State: AC+VfDwL395X+TwBd1zENozqXNW5tcSOOegTZFSueGn0AQmnvkAbBGA9
        lGQZY/vgKbjID1XydHbgU8zjgA==
X-Google-Smtp-Source: ACHHUZ6bxSvaL7N5L7pY/7PGaWewZkr+jl+V5AXuMGjWDiBywlhOyfzJuEOgLTooQfGQMb6PsRxV0Q==
X-Received: by 2002:a2e:8746:0:b0:2b4:66bb:4f2d with SMTP id q6-20020a2e8746000000b002b466bb4f2dmr2954807ljj.19.1687180568604;
        Mon, 19 Jun 2023 06:16:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id n23-20020a2e86d7000000b002ac78893a9csm5181698ljj.72.2023.06.19.06.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:16:08 -0700 (PDT)
Message-ID: <4c71208b-5621-2495-a5de-3622a44d05d4@linaro.org>
Date:   Mon, 19 Jun 2023 15:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFT PATCH] arm64: dts: qcom: sdm850-c630: add missing panel
 supply
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
References: <20230617171512.286795-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171512.286795-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> Panel bindings (boe,nv133fhm-n61) require supply which here actually can
> be turned on/off via GPIO control:
> 
>   sdm850-lenovo-yoga-c630.dtb: panel: 'power-supply' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Not tested on hardware
> ---
+Steev

Konrad
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index cfbc4fc1eba9..3d871567cf81 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -87,6 +87,25 @@ sn65dsi86_refclk: sn65dsi86-refclk {
>  		clock-frequency = <19200000>;
>  	};
>  
> +	vph_pwr: regulator-vph-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vph_pwr";
> +		regulator-min-microvolt = <3700000>;
> +		regulator-max-microvolt = <3700000>;
> +	};
> +
> +	vlcm_3v3: regulator-vlcm-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vlcm_3v3";
> +
> +		vin-supply = <&vph_pwr>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	backlight: backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&sn65dsi86 1000000>;
> @@ -419,6 +438,7 @@ aux-bus {
>  			panel: panel {
>  				compatible = "boe,nv133fhm-n61";
>  				backlight = <&backlight>;
> +				power-supply = <&vlcm_3v3>;
>  
>  				port {
>  					panel_in_edp: endpoint {
