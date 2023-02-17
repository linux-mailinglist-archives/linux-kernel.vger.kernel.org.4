Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5169B149
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBQQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:45:48 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A66270F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:45:45 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id k13so1870512ljn.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVlcR3h6+h36cZzj9rEe6pSxdR36N6jX3gc7PvYzj0U=;
        b=g/D55bpcstBNEWJe4ZZN0oCCrZXGUZc39w28Wo1J70cOKSlzqcuF95vXBiIfqFbzyz
         M1e0rjjbN2qqmOA7RBc3SQzhPW5VVbGih2FyIADP07b4Q9T5ol2olkAmRoapS4lWX6i+
         VBjh7CJXGSNoNvi3P4ZBVxkZ+tTypF1rhQ1ftPnBJRXeWYpC+i/8BiUjJWlFBDdG7z/r
         FWDdZ9yUZFNhtSy9QKtEvKbEConUso3VnmXYDUch45HeWNM+7m6uLz1HdfeyvWHakQcm
         G5Ji4+r1mVOK1BmcwmbfcNXoTPv9i+dU91NfHhMM+e09s1g8N57SiAezhDA0lu7PDzCE
         kJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVlcR3h6+h36cZzj9rEe6pSxdR36N6jX3gc7PvYzj0U=;
        b=PfuNwReG4HDEzhgbYuwgLH640WFvQj9NVz8KzYSdNHsN8Pn8Ha4s9K9XFnHh2JbXqN
         5qyDba9ajYwc3VOMiCRbg/cqs5YuzSHhaTkdXHTcakMveSnkt1PYGnrUPx+E9EU0kiSD
         XJUbGcurUtzc8ksBD+RwH/O5avBgQSpJ689i36XO+x8LDfy5qnC4Jfzs+fm9VYhI7xzi
         6Qc4JoZGOWbyU8kEwxgFoY16nXtcdVLCby4aaUnpc1coxoCum5W7KPtyfrzb4xe+CDrW
         +owBM3/Ac4WPGaq1hTUEzyBsUFf2jQaDOLLQb6DKWIOHYDQOfDvaQCL7Q60acIxeVvrl
         AmfA==
X-Gm-Message-State: AO0yUKU49FrNVJFJ+3IdBRh5uMSzQGZQUW2ArCdlnxYOtlCT8X7f1vLS
        jzaJZ07TAgoVMGUmjhR7S/YKow==
X-Google-Smtp-Source: AK7set+skClcydzZ68kU5ppwSH5SYKJp+n6Ctbk4vNZZbeZvDfNOZRJttcRlKzdd4zgNA5n2qwmTQQ==
X-Received: by 2002:a2e:b4a1:0:b0:293:45b9:d188 with SMTP id q1-20020a2eb4a1000000b0029345b9d188mr301607ljm.41.1676652344003;
        Fri, 17 Feb 2023 08:45:44 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id h4-20020a2e3a04000000b0028bcc644e95sm619189lja.60.2023.02.17.08.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 08:45:43 -0800 (PST)
Message-ID: <10c022fa-6400-bc15-12b7-11453bc3eb43@linaro.org>
Date:   Fri, 17 Feb 2023 17:45:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7280: align RPMh regulator nodes
 with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org>
 <20230217155838.848403-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230217155838.848403-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.02.2023 16:58, Krzysztof Kozlowski wrote:
> Device node names should be generic and bindings expect certain pattern
> for RPMh regulator nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> I was fixing these in other boards, but missed SC7280. Previous
> (applied) set:
> https://lore.kernel.org/r/20230127114347.235963-4-krzysztof.kozlowski@linaro.org
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts        | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          | 4 ++--
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi        | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> index 1185141f348e..afae7f46b050 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> @@ -27,7 +27,7 @@ chosen {
>  };
>  
>  &apps_rsc {
> -	pmg1110-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pmg1110-rpmh-regulators";
>  		qcom,pmic-id = "k";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index 4e0b013e25f4..df39a64da923 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -40,7 +40,7 @@ vreg_edp_bl_crd: vreg-edp-bl-crd-regulator {
>  /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
>  
>  &apps_rsc {
> -	pmg1110-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pmg1110-rpmh-regulators";
>  		qcom,pmic-id = "k";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index ba64316b4427..15222e92e3f5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -25,7 +25,7 @@ chosen {
>  };
>  
>  &apps_rsc {
> -	pmr735a-regulators {
> +	regulators-2 {
>  		compatible = "qcom,pmr735a-rpmh-regulators";
>  		qcom,pmic-id = "e";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 8b5293e7fd2a..8ebcf763b3c7 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -184,7 +184,7 @@ codec {
>  };
>  
>  &apps_rsc {
> -	pm7325-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm7325-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -279,7 +279,7 @@ vreg_l19b_1p8: ldo19 {
>  		};
>  	};
>  
> -	pm8350c-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8350c-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> index 88204f794ccb..cb0cc2ba2fa3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -87,7 +87,7 @@ &apps_rsc {
>  	 * are left out of here since they are managed elsewhere.
>  	 */
>  
> -	pm7325-regulators {
> +	regulators-0 {
>  		compatible = "qcom,pm7325-rpmh-regulators";
>  		qcom,pmic-id = "b";
>  
> @@ -188,7 +188,7 @@ vreg_l19b_1p8: ldo19 {
>  		};
>  	};
>  
> -	pm8350c-regulators {
> +	regulators-1 {
>  		compatible = "qcom,pm8350c-rpmh-regulators";
>  		qcom,pmic-id = "c";
>  
