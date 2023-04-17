Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFE6E40F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDQHaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDQH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:29:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A934F4497
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:18 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso1157514e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716557; x=1684308557;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYf4khS1BYPxHVUrxQfBZXjEtB8qzfrt2AReM2TSrUw=;
        b=iFgXGfILZEgcQzjy1rTAJxa2yLf734MtMNkrSsb/yo4DgMc43CbKbCqlUe0cU6adB5
         Glrmg5uq9iIQY3e/bnXxLxcOGwaTQbuXh3XyusekJspJeNRdCG0ByP08JOTXukPg4SLC
         p4NiBCLg5gGWtealNv9MX2VHb2MS85JBv7aibOpx0pamuE6OwFZ5ww20Q8Uy5IWFbsKM
         4p7ZFjzzuhWZgxIae6PimDvjZPdE+7wy/RQBTn5pHaxnOlL/ooAnalvmgd0LhVxs+Pll
         bjY1G3LKUOl3W07O3G1DgsgEG6RzJnlITwPC26bVUpenOp6hHBzDItLdVWJSXPseyPgI
         mV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716557; x=1684308557;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYf4khS1BYPxHVUrxQfBZXjEtB8qzfrt2AReM2TSrUw=;
        b=dE3HWVKCQipHjh/NgZGjzqQsNT5CM/c2eLGP23a3ZH6N4vCKUVzM7vf1w+padwFVVU
         jfxa+X66/cfQM4RUkMuewtm+ccFLxEgBQh20sus7x3Fnbcr1e/5dEXujWG7/q5AjZ/gk
         TjEomeM19rpLazf5rVLu0wJNI5ru1Z4vbOG8isSY4NHZstiJLjkf/d65BBSlSDk3gioX
         BHp1iB3fZu4qID3fBOMUt+N+Fs5acxI7Ss8B7zkItpCyVsqrusP6uvYE1YaAIVAwrNKm
         aky47ijyOugUINBVAsafyaBG76kqRf5Iq/FWb46VXXODYREvKP0qsrgJlc3r3UHveawD
         o/Jw==
X-Gm-Message-State: AAQBX9dFeMz2ARnETep/8jqey559wmXARsVmAvhZ3fZ6fcYt2lWTXDTs
        dyBWE5nKhVLwxqUdddB7HIs6dg==
X-Google-Smtp-Source: AKy350ZzuFYF0pHnLJQhFhsN0lbrQk3XifTK5igpvZ0kA0e4X7/Ce7/Q3Pi+zKN6cxCsBPVOJBToaw==
X-Received: by 2002:a19:f80a:0:b0:4db:28ce:e600 with SMTP id a10-20020a19f80a000000b004db28cee600mr1633955lff.1.1681716556795;
        Mon, 17 Apr 2023 00:29:16 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id c24-20020ac25318000000b004e8508899basm1961878lfh.86.2023.04.17.00.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:29:16 -0700 (PDT)
Message-ID: <6e743c83-70a8-0bf2-75f5-0e5910572cd5@linaro.org>
Date:   Mon, 17 Apr 2023 09:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: fix indentation
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
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
> Correct indentation to use only tabs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8996.dtsi  |  8 ++--
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  4 +-
>  arch/arm64/boot/dts/qcom/sdm670.dtsi   |  2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi   |  4 +-
>  arch/arm64/boot/dts/qcom/sm6375.dtsi   | 34 ++++++++---------
>  arch/arm64/boot/dts/qcom/sm8150.dtsi   |  4 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi   | 52 +++++++++++++-------------
>  arch/arm64/boot/dts/qcom/sm8450.dtsi   | 52 +++++++++++++-------------
>  8 files changed, 80 insertions(+), 80 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 2b35cb3f5292..2c5780008c84 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -53,8 +53,8 @@ CPU0: cpu@0 {
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> +				compatible = "cache";
> +				cache-level = <2>;
>  			};
>  		};
>  
> @@ -83,8 +83,8 @@ CPU2: cpu@100 {
>  			#cooling-cells = <2>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> +				compatible = "cache";
> +				cache-level = <2>;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index ef9bd6ab577d..8fb766f9e8e0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -60,8 +60,8 @@ L2_0: l2-cache {
>  				cache-level = <2>;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
> -				      compatible = "cache";
> -				      cache-level = <3>;
> +					compatible = "cache";
> +					cache-level = <3>;
>  				};
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> index c5f839dd1c6e..49c07cb76b20 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -42,7 +42,7 @@ L2_0: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
> -				      compatible = "cache";
> +					compatible = "cache";
>  				};
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 90424442bb4a..ae0510e687b4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -110,8 +110,8 @@ L2_0: l2-cache {
>  				cache-level = <2>;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
> -				      compatible = "cache";
> -				      cache-level = <3>;
> +					compatible = "cache";
> +					cache-level = <3>;
>  				};
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index ae9b6bc446cb..4e8b99e7cf66 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -48,10 +48,10 @@ CPU0: cpu@0 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_0: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
> -				      compatible = "cache";
> +					compatible = "cache";
>  				};
>  			};
>  		};
> @@ -68,8 +68,8 @@ CPU1: cpu@100 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_100: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -85,8 +85,8 @@ CPU2: cpu@200 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_200: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -102,8 +102,8 @@ CPU3: cpu@300 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_300: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -119,8 +119,8 @@ CPU4: cpu@400 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_400: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -136,8 +136,8 @@ CPU5: cpu@500 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_500: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -153,8 +153,8 @@ CPU6: cpu@600 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_600: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -170,8 +170,8 @@ CPU7: cpu@700 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_700: l2-cache {
> -			      compatible = "cache";
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 2273fa571988..1a229caad8aa 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -65,8 +65,8 @@ L2_0: l2-cache {
>  				cache-level = <2>;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
> -				      compatible = "cache";
> -				      cache-level = <3>;
> +					compatible = "cache";
> +					cache-level = <3>;
>  				};
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index ebcb481571c2..ebe59bd7bcc7 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -58,12 +58,12 @@ CPU0: cpu@0 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_0: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
> -				      compatible = "cache";
> -				      cache-level = <3>;
> +					compatible = "cache";
> +					cache-level = <3>;
>  				};
>  			};
>  		};
> @@ -80,9 +80,9 @@ CPU1: cpu@100 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_100: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -98,9 +98,9 @@ CPU2: cpu@200 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_200: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -116,9 +116,9 @@ CPU3: cpu@300 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_300: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -134,9 +134,9 @@ CPU4: cpu@400 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_400: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -152,9 +152,9 @@ CPU5: cpu@500 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_500: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -170,9 +170,9 @@ CPU6: cpu@600 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_600: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -188,9 +188,9 @@ CPU7: cpu@700 {
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
>  			L2_700: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 595533aeafc4..b15b585f3548 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -57,12 +57,12 @@ CPU0: cpu@0 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 0>;
>  			L2_0: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
> -				      compatible = "cache";
> -				      cache-level = <3>;
> +					compatible = "cache";
> +					cache-level = <3>;
>  				};
>  			};
>  		};
> @@ -79,9 +79,9 @@ CPU1: cpu@100 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 0>;
>  			L2_100: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -97,9 +97,9 @@ CPU2: cpu@200 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 0>;
>  			L2_200: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -115,9 +115,9 @@ CPU3: cpu@300 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 0>;
>  			L2_300: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -133,9 +133,9 @@ CPU4: cpu@400 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 1>;
>  			L2_400: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -151,9 +151,9 @@ CPU5: cpu@500 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 1>;
>  			L2_500: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -169,9 +169,9 @@ CPU6: cpu@600 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 1>;
>  			L2_600: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
> @@ -187,9 +187,9 @@ CPU7: cpu@700 {
>  			#cooling-cells = <2>;
>  			clocks = <&cpufreq_hw 2>;
>  			L2_700: l2-cache {
> -			      compatible = "cache";
> -			      cache-level = <2>;
> -			      next-level-cache = <&L3_0>;
> +				compatible = "cache";
> +				cache-level = <2>;
> +				next-level-cache = <&L3_0>;
>  			};
>  		};
>  
