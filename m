Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82026E40D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjDQH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjDQH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:27:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224D840F7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:27:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so11721881fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716424; x=1684308424;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJ/Pk7d+EFQ6gO+/4rv6mU1gKpnQwfZ+BqprNXpNncU=;
        b=ocWLSkBSzPwMx65zp+UeL5u5ufR72vtZzgzrOT0JDI8JKI59OPBKIa3UIDnoVkw2bL
         o/suCNYt9QnuqkqxMjPuCjx9WXn68eBHXa883os93jBMYFMbZW8FHyy+xyRx0L2Xv5g2
         FRcI3ypt6Aj4jQuy/N9vAbK8yGIWkqpzuvsK5DzbUmr/4dfD+yHHEov8fiIsFazlpEfQ
         aT6d9vziMKNRS6uKmAHcnVDrJU1pkz/gnohaH3fMJXt/y+dow876nGqXZK3Jbo9G8KFg
         hdm8tZldk1Gsj6tb3C6SBeP8aZM16gglJaprY5r/ZA02EHILBaYPkuJKlRVo1U1+Djff
         WawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716424; x=1684308424;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ/Pk7d+EFQ6gO+/4rv6mU1gKpnQwfZ+BqprNXpNncU=;
        b=WR+OI4EQAzu1zOXLxhM+SxtjGAdS2HOfv5liqG1rJbrajeNEdORr2BjO0U1mIoGDHE
         yUowEntqTi7bKOYMKKq8y3V6UcVm4pBYtrWDx3dQZ5WCfolX9kRIf/AJHB2qb2GdyEbe
         sluRu8HJMyRRSJotmDugDtxndbwpcMT6XWUO/j6QAqYNohOIp1qKtxCPWKFOwmO9VBIs
         Vl/zWbjoriD+rDxbeu+X3LUYPoInL+8sVnLyUBAvMdRvoh066w/wNR1/RgAl9/K9WlL9
         mCVxxko16YteZYsTaLjjk+RZ7GlMMpTkDTp31JYZKpviaLnOR9k0/SCG81iaOoC06WQ4
         900g==
X-Gm-Message-State: AAQBX9eaOWvTcemg1sCUnzdrsEY6WP1E6eoGeW39leX7mY17zH5hoqWL
        A2zRmJnulIHhdiIAxeukl8TfTg==
X-Google-Smtp-Source: AKy350YPGUDGLbiE7ix363ZPcuUmIMCIoi33nV+ru8U4vtfHYRCuEkZfp+TLTEAtML/xlXD4HAdiug==
X-Received: by 2002:a05:6512:3767:b0:4eb:18d:91df with SMTP id z7-20020a056512376700b004eb018d91dfmr1600099lft.27.1681716423880;
        Mon, 17 Apr 2023 00:27:03 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id j25-20020ac25519000000b004d8580b2470sm1935470lfk.225.2023.04.17.00.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:27:03 -0700 (PDT)
Message-ID: <6ec9d6b8-24b6-50e8-9e83-414fb39bf92f@linaro.org>
Date:   Mon, 17 Apr 2023 09:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: add missing cache properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230416101134.95686-1-krzysztof.kozlowski@linaro.org>
 <20230416101134.95686-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416101134.95686-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 12:11, Krzysztof Kozlowski wrote:
> Add required cache-level and cache-unified properties to fix warnings
> like:
> 
>   qdu1000-idp.dtb: l3-cache: 'cache-unified' is a required property
>   qdu1000-idp.dtb: l2-cache: 'cache-level' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/msm8916.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/msm8953.dtsi  |  2 ++
>  arch/arm64/boot/dts/qcom/msm8976.dtsi  |  2 ++
>  arch/arm64/boot/dts/qcom/msm8994.dtsi  |  2 ++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi  |  2 ++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi  |  2 ++
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi  |  1 +
>  arch/arm64/boot/dts/qcom/qcs404.dtsi   |  1 +
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi  | 10 ++++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi  | 20 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi   |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi   |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sdm630.dtsi   |  2 ++
>  arch/arm64/boot/dts/qcom/sdm670.dtsi   | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi   |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sm6115.dtsi   |  2 ++
>  arch/arm64/boot/dts/qcom/sm6125.dtsi   |  2 ++
>  arch/arm64/boot/dts/qcom/sm6350.dtsi   |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sm6375.dtsi   | 18 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi   |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sm8350.dtsi   |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sm8450.dtsi   |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi   |  9 +++++++++
>  28 files changed, 170 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 12e0e179e139..af4d97143bcf 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -73,6 +73,7 @@ CPU3: cpu@3 {
>  		L2_0: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index ece652a0728a..f531797f2619 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -84,6 +84,7 @@ CPU3: cpu@3 {
>  		L2_0: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> index 4056ce59d43f..5b2c1986c8f4 100644
> --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> @@ -67,6 +67,7 @@ CPU3: cpu@3 {
>  		L2_0: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 3bb7435f5e7f..0ed19fbf7d87 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -72,6 +72,7 @@ CPU3: cpu@3 {
>  		L2_0: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 7e0fa37a3adf..834e0b66b7f2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -180,6 +180,7 @@ CPU3: cpu@3 {
>  		L2_0: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  
>  		idle-states {
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 602cb188a635..d44cfa0471e9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -153,11 +153,13 @@ core3 {
>  		L2_0: l2-cache-0 {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  
>  		L2_1: l2-cache-1 {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 1f0bd24a074a..f47fb8ea71e2 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -193,11 +193,13 @@ big_cpu_sleep_1: cpu-sleep-1-1 {
>  		l2_0: l2-cache0 {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  
>  		l2_1: l2-cache1 {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index 2831966be960..bdc3f2ba1755 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -52,6 +52,7 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> @@ -88,6 +89,7 @@ CPU4: cpu@100 {
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 2c5780008c84..30257c07e127 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -55,6 +55,7 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> @@ -85,6 +86,7 @@ CPU2: cpu@100 {
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index b150437a8355..3ec941fed14f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -146,6 +146,7 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> @@ -190,6 +191,7 @@ CPU4: cpu@100 {
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index ae5abc76bcc7..b29bc4e4b837 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -51,6 +51,7 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index eefed585738c..972f753847e1 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -95,6 +95,7 @@ CPU3: cpu@103 {
>  		L2_0: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  
>  		idle-states {
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 734438113bba..fb553f0bb17a 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -35,9 +35,13 @@ CPU0: cpu@0 {
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
> +					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -54,6 +58,8 @@ CPU1: cpu@100 {
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -70,6 +76,8 @@ CPU2: cpu@200 {
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -86,6 +94,8 @@ CPU3: cpu@300 {
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 2343df7e0ea4..c3310caf9f68 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -42,9 +42,13 @@ CPU0: cpu@0 {
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
> +					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -58,6 +62,8 @@ CPU1: cpu@100 {
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -71,6 +77,8 @@ CPU2: cpu@200 {
>  			next-level-cache = <&L2_2>;
>  			L2_2: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -84,6 +92,8 @@ CPU3: cpu@300 {
>  			next-level-cache = <&L2_3>;
>  			L2_3: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -97,9 +107,13 @@ CPU4: cpu@10000 {
>  			next-level-cache = <&L2_4>;
>  			L2_4: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_1>;
>  				L3_1: l3-cache {
>  					compatible = "cache";
> +					cache-level = <3>;
> +					cache-unified;
>  				};
>  
>  			};
> @@ -114,6 +128,8 @@ CPU5: cpu@10100 {
>  			next-level-cache = <&L2_5>;
>  			L2_5: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_1>;
>  			};
>  		};
> @@ -127,6 +143,8 @@ CPU6: cpu@10200 {
>  			next-level-cache = <&L2_6>;
>  			L2_6: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_1>;
>  			};
>  		};
> @@ -140,6 +158,8 @@ CPU7: cpu@10300 {
>  			next-level-cache = <&L2_7>;
>  			L2_7: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_1>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index ea1ffade1aa1..f479cab8ab45 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -92,10 +92,12 @@ &LITTLE_CPU_SLEEP_1
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -120,6 +122,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -144,6 +147,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -168,6 +172,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -192,6 +197,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -216,6 +222,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -240,6 +247,7 @@ &BIG_CPU_SLEEP_1
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -264,6 +272,7 @@ &BIG_CPU_SLEEP_1
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 31728f461422..2fd1d3c0eb34 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -182,10 +182,12 @@ &LITTLE_CPU_SLEEP_1
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -208,6 +210,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -230,6 +233,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -252,6 +256,7 @@ &LITTLE_CPU_SLEEP_1
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -274,6 +279,7 @@ &BIG_CPU_SLEEP_1
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -296,6 +302,7 @@ &BIG_CPU_SLEEP_1
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -318,6 +325,7 @@ &BIG_CPU_SLEEP_1
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -340,6 +348,7 @@ &BIG_CPU_SLEEP_1
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fb766f9e8e0..6d3780a75024 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -58,10 +58,12 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -83,6 +85,7 @@ CPU1: cpu@100 {
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -104,6 +107,7 @@ CPU2: cpu@200 {
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -125,6 +129,7 @@ CPU3: cpu@300 {
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -146,6 +151,7 @@ CPU4: cpu@400 {
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -167,6 +173,7 @@ CPU5: cpu@500 {
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -188,6 +195,7 @@ CPU6: cpu@600 {
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -209,6 +217,7 @@ CPU7: cpu@700 {
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 37e72b1c56dc..eaead2f7beb4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -63,6 +63,7 @@ &PERF_CLUSTER_SLEEP_1
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> @@ -127,6 +128,7 @@ &PWR_CLUSTER_SLEEP_1
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> index 49c07cb76b20..b61e13db89bd 100644
> --- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
> @@ -41,8 +41,12 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				next-level-cache = <&L3_0>;
> +				cache-level = <2>;
> +				cache-unified;
>  				L3_0: l3-cache {
>  					compatible = "cache";
> +					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -57,6 +61,8 @@ CPU1: cpu@100 {
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -71,6 +77,8 @@ CPU2: cpu@200 {
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -85,6 +93,8 @@ CPU3: cpu@300 {
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -99,6 +109,8 @@ CPU4: cpu@400 {
>  			next-level-cache = <&L2_400>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -113,6 +125,8 @@ CPU5: cpu@500 {
>  			next-level-cache = <&L2_500>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -127,6 +141,8 @@ CPU6: cpu@600 {
>  			next-level-cache = <&L2_600>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -141,6 +157,8 @@ CPU7: cpu@700 {
>  			next-level-cache = <&L2_700>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index ae0510e687b4..cdeb05e95674 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -108,10 +108,12 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -135,6 +137,7 @@ CPU1: cpu@100 {
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -158,6 +161,7 @@ CPU2: cpu@200 {
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -181,6 +185,7 @@ CPU3: cpu@300 {
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -204,6 +209,7 @@ CPU4: cpu@400 {
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -227,6 +233,7 @@ CPU5: cpu@500 {
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -250,6 +257,7 @@ CPU6: cpu@600 {
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -273,6 +281,7 @@ CPU7: cpu@700 {
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 631ca327e064..43f31c1b9d5a 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -50,6 +50,7 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> @@ -102,6 +103,7 @@ CPU4: cpu@100 {
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 9484752fb850..2aa093d16858 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -47,6 +47,7 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> @@ -87,6 +88,7 @@ CPU4: cpu@100 {
>  			L2_1: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  			};
>  		};
>  
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 18c4616848ce..ad34301f6cdd 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -60,10 +60,12 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -86,6 +88,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -108,6 +111,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -130,6 +134,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -152,6 +157,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -174,6 +180,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -196,6 +203,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -218,6 +226,7 @@ &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ACTIVE_ONLY>,
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index 4e8b99e7cf66..f8d9c34d3b2f 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -49,9 +49,13 @@ CPU0: cpu@0 {
>  			#cooling-cells = <2>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
> +					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -69,6 +73,8 @@ CPU1: cpu@100 {
>  			#cooling-cells = <2>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -86,6 +92,8 @@ CPU2: cpu@200 {
>  			#cooling-cells = <2>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -103,6 +111,8 @@ CPU3: cpu@300 {
>  			#cooling-cells = <2>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -120,6 +130,8 @@ CPU4: cpu@400 {
>  			#cooling-cells = <2>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -137,6 +149,8 @@ CPU5: cpu@500 {
>  			#cooling-cells = <2>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -154,6 +168,8 @@ CPU6: cpu@600 {
>  			#cooling-cells = <2>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -171,6 +187,8 @@ CPU7: cpu@700 {
>  			#cooling-cells = <2>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> +				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 1a229caad8aa..27dcda0d4288 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -63,10 +63,12 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -90,6 +92,7 @@ CPU1: cpu@100 {
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -113,6 +116,7 @@ CPU2: cpu@200 {
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -136,6 +140,7 @@ CPU3: cpu@300 {
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -159,6 +164,7 @@ CPU4: cpu@400 {
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -182,6 +188,7 @@ CPU5: cpu@500 {
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -205,6 +212,7 @@ CPU6: cpu@600 {
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -228,6 +236,7 @@ CPU7: cpu@700 {
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index ebe59bd7bcc7..3efdc03ed0f1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -60,10 +60,12 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -82,6 +84,7 @@ CPU1: cpu@100 {
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -100,6 +103,7 @@ CPU2: cpu@200 {
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -118,6 +122,7 @@ CPU3: cpu@300 {
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -136,6 +141,7 @@ CPU4: cpu@400 {
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -154,6 +160,7 @@ CPU5: cpu@500 {
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -172,6 +179,7 @@ CPU6: cpu@600 {
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -190,6 +198,7 @@ CPU7: cpu@700 {
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index b15b585f3548..d59ea8ee7111 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -59,10 +59,12 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -81,6 +83,7 @@ CPU1: cpu@100 {
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -99,6 +102,7 @@ CPU2: cpu@200 {
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -117,6 +121,7 @@ CPU3: cpu@300 {
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -135,6 +140,7 @@ CPU4: cpu@400 {
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -153,6 +159,7 @@ CPU5: cpu@500 {
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -171,6 +178,7 @@ CPU6: cpu@600 {
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -189,6 +197,7 @@ CPU7: cpu@700 {
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6e9bad8f6f33..43192ef21aec 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -80,10 +80,12 @@ CPU0: cpu@0 {
>  			L2_0: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  				L3_0: l3-cache {
>  					compatible = "cache";
>  					cache-level = <3>;
> +					cache-unified;
>  				};
>  			};
>  		};
> @@ -104,6 +106,7 @@ CPU1: cpu@100 {
>  			L2_100: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -124,6 +127,7 @@ CPU2: cpu@200 {
>  			L2_200: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -144,6 +148,7 @@ CPU3: cpu@300 {
>  			L2_300: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -164,6 +169,7 @@ CPU4: cpu@400 {
>  			L2_400: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -184,6 +190,7 @@ CPU5: cpu@500 {
>  			L2_500: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -204,6 +211,7 @@ CPU6: cpu@600 {
>  			L2_600: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
> @@ -224,6 +232,7 @@ CPU7: cpu@700 {
>  			L2_700: l2-cache {
>  				compatible = "cache";
>  				cache-level = <2>;
> +				cache-unified;
>  				next-level-cache = <&L3_0>;
>  			};
>  		};
