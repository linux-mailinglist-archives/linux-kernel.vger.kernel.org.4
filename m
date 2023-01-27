Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF1B67E462
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjA0L7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjA0L66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:58:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0F8325B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:55:11 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m2so12570284ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wL+J3vKYyO+ixLbcMrHJZAkGHMLmqvXASaXe1XTQm3U=;
        b=qYrX9xtj725wH91EBMszKoq6++kEMjJIDAnfvh+L9m8BWeLgr0DBJZ2yiuVyftkBs7
         LLqYox8H/r9bVwGwDseRqYIDmsdrkKy9wNQgspauEfs8HTgcli8CFLtzo8cyrfAPEQ3Z
         8zafjQBzNB+bUDpM/GSJl7xzqrbqX042k2nNMrq0coNz46XX/O4OmCcf2LiWZmxUGL1m
         cU0GKvrJ1SwG4m3OAYm1UoCf3A1jovkXoizFdmavHwkxKrTROsLSyslN4s9QV09NrOzm
         YfTL6tgrqmRkolYJBP8pt25OAln7jGu9wlQV52YWo6AkU18ZkB+6CZ8rjmRoZx7gx9NR
         8nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wL+J3vKYyO+ixLbcMrHJZAkGHMLmqvXASaXe1XTQm3U=;
        b=Xbp3pqzCX9ApXw8TaQuzIhjHehte3cX5FmbSNfxGcu6pmojzuhzgTqDlW5OucW50Mf
         zsJsBVCPqG2YCbh1xsUmrte5zkEkTL+rR8cjcOTNoaNG85rRl/J1ztElaevmEefMPQUS
         k3YRv+sWtOCtf+AyUUf+5IIBqWqKYf1ebsbaXQQ4TCxI0QYAK5o5ChRI6u+eMZV294Nb
         JhCXvDv9lYI1kWyZRvt6xrNC1soqsKK4qbO9w60SizXVRcERWYM+JeTVyIPnC2Axn3Hh
         BTqJ7bqrdISk7Or/fUN4QovbTts85qE4eBazlzDBRS4GneZ4/rEwvM5ZMl0314MspNnv
         WIfw==
X-Gm-Message-State: AO0yUKXxCY3+fI8AfQYYi1megxjUd+6mry7PuDwkmVZMtGu8DSe4TaJB
        clLVO4JokCUqAPeHFqw0Av8b7g==
X-Google-Smtp-Source: AK7set91156TC39iSwiRedB6cy/jTgu1zwxjij0qO4zKpVUjk6BsHEsrC9CX7nr7VjPlx7fKNMEM8A==
X-Received: by 2002:a17:907:94cf:b0:878:5d33:c0ec with SMTP id dn15-20020a17090794cf00b008785d33c0ecmr8277785ejc.40.1674820406166;
        Fri, 27 Jan 2023 03:53:26 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id fu17-20020a170907b01100b008536ff0bb44sm2108296ejc.109.2023.01.27.03.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 03:53:25 -0800 (PST)
Message-ID: <5a70dfce-fd97-3cc1-1932-6be14130540c@linaro.org>
Date:   Fri, 27 Jan 2023 12:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 06/11] arm64: dts: qcom: sdm845: align RPMh regulator
 nodes with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
 <20230127114347.235963-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230127114347.235963-6-krzysztof.kozlowski@linaro.org>
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



On 27.01.2023 12:43, Krzysztof Kozlowski wrote:
> Device node names should be generic and bindings expect certain pattern
> for RPMh regulator nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                  | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts                  | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi              | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts                     | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi         | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts     | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts           | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi       | 6 +++---
>  .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts          | 6 +++---
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts        | 2 +-
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts            | 2 +-
>  12 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> index e19178c1ec44..f2b48241d15c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> @@ -339,7 +339,7 @@ flash@0 {
>  
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -621,7 +621,7 @@ src_pp1800_lvs2: lvs2 {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index 9c9a587ea7a9..0b7940c130af 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -270,7 +270,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  		vdd-s1-supply = <&vph_pwr>;
> @@ -395,7 +395,7 @@ vreg_lvs2a_1p8: lvs2 {
>  		};
>  	};
>  
> -	pmi8998-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmi8998-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> index 36f291d4d691..f942c5afea9b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
> @@ -166,7 +166,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -419,7 +419,7 @@ vreg_lvs2a_1p8: lvs2 {
>  		};
>  	};
>  
> -	pmi8998-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmi8998-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -433,7 +433,7 @@ vreg_bob: bob {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 482f43fe0151..d1440b790fa6 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -117,7 +117,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -382,7 +382,7 @@ vreg_lvs2a_1p8: lvs2 {
>  		};
>  	};
>  
> -	pmi8998-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmi8998-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -396,7 +396,7 @@ vreg_bob: bob {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 548e34632de2..601f6467146d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -145,7 +145,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -281,7 +281,7 @@ vreg_l28a_3p0: ldo28 {
>  		};
>  	};
>  
> -	pmi8998-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmi8998-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -295,7 +295,7 @@ vreg_bob: bob {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index e742c27fe91f..d37a433130b9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -73,7 +73,7 @@ memory@a1300000 {
>  
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -332,7 +332,7 @@ vreg_lvs2a_1p8: lvs2 {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 5d0509f61fe8..b54e304abf71 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -111,7 +111,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -376,7 +376,7 @@ vreg_lvs2a_1p8: lvs2 {
>  		};
>  	};
>  
> -	pmi8998-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmi8998-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -390,7 +390,7 @@ vreg_bob: bob {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> index 85ff0a0789ea..4984c7496c31 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -99,7 +99,7 @@ ramoops@ffc00000 {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -329,7 +329,7 @@ vreg_lvs2a_1p8: lvs2 {
>  		};
>  	};
>  
> -	pmi8998-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmi8998-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -340,7 +340,7 @@ src_vreg_bob: bob {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> index 0d19506dc54c..8de01a84f8a0 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> @@ -124,7 +124,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> index 40185eda28a8..a08d9c97e414 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
> @@ -144,7 +144,7 @@ vreg_s4a_1p8: vreg-s4a-1p8 {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> @@ -344,7 +344,7 @@ vreg_lvs2a_1p8: lvs2 {
>  		};
>  	};
>  
> -	pmi8998-rpmh-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pmi8998-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -356,7 +356,7 @@ vreg_bob: bob {
>  		};
>  	};
>  
> -	pm8005-rpmh-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pm8005-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> index e9e960b1ad9f..25f88215986b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> @@ -100,7 +100,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index eae696f0dbe4..b650fa846d23 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -130,7 +130,7 @@ &adsp_pas {
>  };
>  
>  &apps_rsc {
> -	pm8998-rpmh-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm8998-rpmh-regulators";
>  		qcom,pmic-id = "a";
>  
