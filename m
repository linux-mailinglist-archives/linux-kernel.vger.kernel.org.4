Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637C66F4175
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjEBKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjEBKWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:22:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CB85FC5
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:21:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso4457653e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683022906; x=1685614906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6iWdYn1dcUhTIsj5RYFdeRghsw/Iy67Uv3eHtIWqsQ=;
        b=GBXf7uJqRLVgCEQuhaqRbNLu2HX5JOFlcjoxgxBs8ihGDi6buL35TwEMuyyQlgboep
         PFQ3LwtZk0hMF2twx754tB/mO6hmHp2FFn+Mcs5/oQ4MSfgIDSgLfy0Y/2pcTqMG7YC1
         3pz0Dp3D5sI/twmNGV5dX2DYb/F79clUhPePJo+8KkfGSimTeuZKQzd27fESVmt/nHPV
         F4y8wZdIUbHU3ZH1kk572Gl1Tz34RIqHUdhTZbqaUzuThIs/ZiowKDNzMWKzBru7Ryny
         ezME+pwUjVJ6w+x4XttVwEoSsEs1VrNHS0J4zcDqxPQ3kQQCNvSJ95EryWKSbjvl+vMT
         cgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683022906; x=1685614906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6iWdYn1dcUhTIsj5RYFdeRghsw/Iy67Uv3eHtIWqsQ=;
        b=f+bde56D23H9akBFygf/HnM8o/lEoBaVgBvtI3KLSznp72EEeNMqFUVmxmzdxopRrh
         ZyKYtp+xbFCvcyDipBk5xpujdEgKrRxEntdYfFMcAqDuIJOiIdSu12P5IueSFayX9ZzF
         kRZfmInIWqz8NgSG22z8GGlS+n2966axN9npanYv5hc2itGc6f7IciuHRbUR2QYg8xiz
         GZ17E/62DpuEMqfE+p9RMvk+XKEoxraaN2CNpBJ071Uqnz4Sk8wR8KMBUj4SRjL+yp0Q
         ETHso6AH9nV4im/Mw2nadI2FqmSevw5wg0mSaAvnqz56Wavr14pAWcqEGgxjSnRQVmsw
         hK2A==
X-Gm-Message-State: AC+VfDybORDdHnAtqnNiGqCmCK3DjbThznwyGxFJ2jAIniIsmm7AZlfK
        Kz34+dmYyNRb2cN0wmpJSgiZkw==
X-Google-Smtp-Source: ACHHUZ7Dr3yuZVF+v4zq2mUOzL+pDisjYi+394uEAnNsl3ACAjNZM3ankYHN3yOfvhJyTSu2lSuWZQ==
X-Received: by 2002:ac2:53b5:0:b0:4e8:485c:6a13 with SMTP id j21-20020ac253b5000000b004e8485c6a13mr4372301lfh.21.1683022906512;
        Tue, 02 May 2023 03:21:46 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id u5-20020ac243c5000000b004f012977b65sm2374584lfl.249.2023.05.02.03.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:21:46 -0700 (PDT)
Message-ID: <efacbaab-3d47-8b6f-9804-6009373396e1@linaro.org>
Date:   Tue, 2 May 2023 12:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 5/5] ARM: dts: qcom: apq8026-huawei-sturgeon: Add vibrator
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
 <20230430-drv260x-improvements-v1-5-1fb28b4cc698@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230430-drv260x-improvements-v1-5-1fb28b4cc698@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.04.2023 20:20, Luca Weiss wrote:
> The watch has a DRV2605 for haptics. Add a node for it based on the
> values found in the downstream board file.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> index d64096028ab1..eb73b992a696 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-huawei-sturgeon.dts
> @@ -7,6 +7,7 @@
>  
>  #include "qcom-msm8226.dtsi"
>  #include "qcom-pm8226.dtsi"
> +#include <dt-bindings/input/ti-drv260x.h>
>  
>  /delete-node/ &adsp_region;
>  
> @@ -68,6 +69,26 @@ &adsp {
>  	status = "okay";
>  };
>  
> +&blsp1_i2c2 {
> +	clock-frequency = <384000>;
> +
> +	status = "okay";
> +
> +	vibrator@5a {
> +		compatible = "ti,drv2605";
> +		reg = <0x5a>;
> +		enable-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
> +
> +		mode = <DRV260X_ERM_MODE>;
> +		library-sel = <DRV260X_ERM_LIB_D>;
> +		vib-rated-mv = <2765>;
> +		vib-overdrive-mv = <3525>;
> +
> +		pinctrl-0 = <&vibrator_default_state>;
> +		pinctrl-names = "default";
> +	};
> +};
> +
>  &blsp1_i2c5 {
>  	clock-frequency = <384000>;
>  
> @@ -347,6 +368,13 @@ reset-pins {
>  		};
>  	};
>  
> +	vibrator_default_state: vibrator-default-state {
> +		pins = "gpio59", "gpio60";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
>  	wlan_hostwake_default_state: wlan-hostwake-default-state {
>  		pins = "gpio66";
>  		function = "gpio";
> 
