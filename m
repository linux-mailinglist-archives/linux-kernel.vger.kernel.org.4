Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E106E40E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDQH21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDQH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:28:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8881F4690
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:27:36 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ec8133c698so5565953e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716452; x=1684308452;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fj4QJ3uVhrqGQC/NP/5zPvqRaEzHkcJjyJMjk/q668o=;
        b=ad2kVqY03y+4vVoHqgkb/3e5bnTwBPOadEwGwTsY5w/LKESYJemjrT6sTf7gt/LE+o
         m4viWQZ24uFDCvL1pKcQGfiYufNyV4Lwc5fXZUsb/K6U0P+6OgqtNj72YB9TICd6XyYs
         7oVW3wTwLl5VI9dY6uf1KTyJbh+pAki8DnRTr3JspJGnmOS14aS8fArqAnCcI4nYnohn
         XdjTq6PtxTzOKUn1suu5kZrg0WZrmYnuqufH/MrXZYu45wOrYXHldRCsUHusybPUK+iJ
         mihqebJ1ZPUq1V+YGmFBV6GODgJs71PVYX3744Ssa81N00JKzQeTQf+2WpAe/FmArdyj
         nCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716452; x=1684308452;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fj4QJ3uVhrqGQC/NP/5zPvqRaEzHkcJjyJMjk/q668o=;
        b=YwUEcsz7x7+F4WL4s2Lu4OQNBxTix2NZpBTNuG+V82i9OiveL1hErWj34ieZbQzJr+
         hVqctCalp6YFqrLt2iSVGoqrW3Xcta1QWPy0CHRE15unpxT+mHUq9bgLk9V8Q7DttJ/H
         IUYhy7cN8cPAj4en/cHrWCv7KqH0ysudPyO6ylShS4vx8EewgCM1zg9HewzUodkFk5L2
         Ui8ilAEcs/zT6V+4/EkxcQ/Ecn1WYIJTu5IkSoBLSS1EynZXcfaFE8U4xee5Uz9iwHx5
         6VvTfcMs8rUPKQbg73vxJoBtB03pmL0n6hicXZ27ETS/Jg4HWCkI9AA7eRUc8QHYSdh1
         dL5g==
X-Gm-Message-State: AAQBX9dbse1bPhu2MuABZP16jCAdAS97yYTIJV0jFjxllA6ONbErKiuW
        IgzficpE5cnqmQEGJa5MlIsLIw==
X-Google-Smtp-Source: AKy350Yn2q6Qv8yBFMAx5LY3BfEDstNdd2zofsFnyr0p7Ur1nhzPNymMKak0DbIVGRWFho2D1K/kqQ==
X-Received: by 2002:ac2:4f8a:0:b0:4ec:ae17:81d9 with SMTP id z10-20020ac24f8a000000b004ecae1781d9mr1355266lfs.32.1681716452357;
        Mon, 17 Apr 2023 00:27:32 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id n8-20020ac242c8000000b004ec89c94f04sm1946004lfl.155.2023.04.17.00.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:27:32 -0700 (PDT)
Message-ID: <bfb7fb32-d915-dfdc-120a-cc45b06193f5@linaro.org>
Date:   Mon, 17 Apr 2023 09:27:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/4] ARM: dts: qcom: add missing cache properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
 <20230416101134.95686-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416101134.95686-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 12:11, Krzysztof Kozlowski wrote:
> Add required cache-unified properties to fix warnings like:
> 
>   qcom-ipq4019-ap.dk01.1-c1.dtb: l2-cache: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 1 +
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 1 +
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 1 +
>  arch/arm/boot/dts/qcom-msm8660.dtsi | 1 +
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 1 +
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 1 +
>  7 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 672b246afbba..d2289205ff81 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -83,6 +83,7 @@ CPU3: cpu@3 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  
>  		idle-states {
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index b653ea40c441..83839e1ec4d1 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -74,6 +74,7 @@ cpu@3 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  			qcom,saw = <&saw_l2>;
>  		};
>  
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index dfcfb3339c23..f0ef86fadc9d 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -102,6 +102,7 @@ cpu@3 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  			qcom,saw = <&saw_l2>;
>  		};
>  	};
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index bcdc37bfef54..621edf508a88 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -45,6 +45,7 @@ cpu1: cpu@1 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> index f601b40ebcf4..78023ed2fdf7 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -36,6 +36,7 @@ cpu@1 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 2a668cd535cc..616fef2ea682 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -42,6 +42,7 @@ cpu@1 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 38d3ee152dcb..a22616491dc0 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -80,6 +80,7 @@ CPU3: cpu@3 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  			qcom,saw = <&saw_l2>;
>  		};
>  
