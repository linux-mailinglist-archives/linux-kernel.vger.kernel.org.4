Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42F69E62F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjBURpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjBURpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:45:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36FB22798
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:44:59 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l8so5246597ljq.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbC5sP3V4tvxg8poITPffqeiBSYf5mTki8iUVO0MfTU=;
        b=YTuHJO/cT2gzfESi8zNm1cF+ovCWeN4ypblfk5i+cUWaymjSHjwTVGENfflTPwgw/T
         2jCWWzKseuNBuyC/Tk9vhGo1dUvXleGiFQ95CIiy6BnFeEvyWHFAJRycHFVRIr4Y6JsI
         AHsKo6s8kWq/nYKntu4cod1qq2zjgp+OEW1IJBPaRIycWp1M+iPr7edsvTf5ZYkj8onV
         eaQK3aMZ+FlgS/E9/ixd/Hn/2fS8tI7Vz4vaHoX9Vl9pVW3XR/WF64sF8YnyJd+TJRHo
         jSOERGvg8xMKmHWzB+xmBmQJoIAOaC0P92nl51T18x7P0XfK3jsXExOBFmc5Ske5Gt+Y
         YaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbC5sP3V4tvxg8poITPffqeiBSYf5mTki8iUVO0MfTU=;
        b=lDUe3iuCz2UIExECUslNgzfOwacdAW4MFkB/ljbkhUmMkBIDlD2nS8T4ddBj/uzVEB
         5rtwozySmimB7nY94uR5YtV79l+jKzfBpgLGsUzlVcTJJGf9ZaAv/vm3i/ZxumLHQ8PC
         cfVshjF9eOSMNhWAd6y4KL4nDR95LXjzPs/+h4xwuOLXz5VOazPJC6XOFFbfjL6wu//y
         Xp7fsh3L6GKY4aoiQ+Vawz9HsE8l1zngvnNHV/GogFwuDHwHpRQYCDtfEs9bDEtj3jaX
         b6RVb/91kcYl7DjKE1Wx93lFa4Eha6SLWpTXliR5l3BGErUusw4vbCtDg2lQLlGi6p2C
         DrAg==
X-Gm-Message-State: AO0yUKXF4qF0YtFlkKuJ2J3023aYsYUguNHCWRBAWl4OBjCaekf7jrb5
        57HkZIuB+Xj+pWEIIryVQHWUrg==
X-Google-Smtp-Source: AK7set879K1Vi+y3/+uZVasOTDhk1xxr/cHP8DNMLeLPuEKpxk6lQ/H0S5WhJxZ4r3G8sI0qOtKB7g==
X-Received: by 2002:a05:651c:b0d:b0:293:7bce:2374 with SMTP id b13-20020a05651c0b0d00b002937bce2374mr2608864ljr.33.1677001497854;
        Tue, 21 Feb 2023 09:44:57 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651c10b000b00290517c661asm203301ljn.40.2023.02.21.09.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:44:57 -0800 (PST)
Message-ID: <9a3e9c76-ba70-6ccc-3ade-fa08cdff571e@linaro.org>
Date:   Tue, 21 Feb 2023 18:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p: add cpufreq node
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230221150543.283487-1-brgl@bgdev.pl>
 <20230221150543.283487-3-brgl@bgdev.pl>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230221150543.283487-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.02.2023 16:05, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a node for the cpufreq engine and specify the frequency domains for
> all CPUs.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index ce5976e36aee..5e2bc67b3178 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -37,6 +37,7 @@ CPU0: cpu@0 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -52,6 +53,7 @@ CPU1: cpu@100 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_1>;
>  			L2_1: l2-cache {
>  				compatible = "cache";
> @@ -64,6 +66,7 @@ CPU2: cpu@200 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_2>;
>  			L2_2: l2-cache {
>  				compatible = "cache";
> @@ -76,6 +79,7 @@ CPU3: cpu@300 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_3>;
>  			L2_3: l2-cache {
>  				compatible = "cache";
> @@ -88,6 +92,7 @@ CPU4: cpu@10000 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x10000>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_4>;
>  			L2_4: l2-cache {
>  				compatible = "cache";
> @@ -104,6 +109,7 @@ CPU5: cpu@10100 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x10100>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_5>;
>  			L2_5: l2-cache {
>  				compatible = "cache";
> @@ -116,6 +122,7 @@ CPU6: cpu@10200 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x10200>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_6>;
>  			L2_6: l2-cache {
>  				compatible = "cache";
> @@ -128,6 +135,7 @@ CPU7: cpu@10300 {
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x10300>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_7>;
>  			L2_7: l2-cache {
>  				compatible = "cache";
> @@ -731,6 +739,19 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		cpufreq_hw: cpufreq@18591000 {
> +			compatible = "qcom,sa8775p-cpufreq-epss",
> +				     "qcom,cpufreq-epss";
That's some very aggressive wrapping! :P

Nevertheless,

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +			reg = <0x0 0x18591000 0x0 0x1000>,
> +			      <0x0 0x18593000 0x0 0x1000>;
> +			reg-names = "freq-domain0", "freq-domain1";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> +			clock-names = "xo", "alternate";
> +
> +			#freq-domain-cells = <1>;
> +		};
> +
>  		tlmm: pinctrl@f000000 {
>  			compatible = "qcom,sa8775p-tlmm";
>  			reg = <0x0 0xf000000 0x0 0x1000000>;
