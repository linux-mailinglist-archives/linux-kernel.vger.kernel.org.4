Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FEF73507B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjFSJi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFSJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:38:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF41DAF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:38:21 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f762b3227dso3886309e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687167500; x=1689759500;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rugDm0dMU0xcU1aTHP1bZXuxWxxa/gPqPcYcDAQmccg=;
        b=pV0++kMKqUT6x/WWcBPiTjVF6C6E2XclywmLiC6ZzWssMFmOcPzIxDIZ4OTsQpTTea
         I2CJMNBLiSKpfBLtkwuBf2/ZIRe2PKVwOGIZaLpm/M9TW56LtYXBH61DygdUqrzgfaFY
         5Rib8IF7aLqaL+YPU10dieIFKE9cmS+aVrAVvWoDB65iDhDRgYjMFcI5VfjW+NpXJgEw
         tH6Q7S1x5RjXPc9hilrxjxyJgsageQHOaiKR3VA76sMAkpaZH8JFuYNSMXyWmFSxvEjK
         gySpPo7LYZ8X/XpkOKO7BoUUbkQR2qUUcVOg0+s91kKucOZc1t4fbsVqQ6LMC6WIzDlY
         WjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687167500; x=1689759500;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rugDm0dMU0xcU1aTHP1bZXuxWxxa/gPqPcYcDAQmccg=;
        b=Sx5znh0CdTbp0lUDVdkert5NCKVf8L9Lg49LAlvCvNa8tfS+ilcZ7uj6G7v1ROWuEu
         opS7RkjRMrcRP1KTzgpkTqfuEFyHtwbqibzAzEzs0PZVomKXMCKbPdtrew4fsMvrs+kq
         Klpv4hk3fWVrvJwRdn8erdBugdNlMM5ZYWM8MqoEKulpcoQjltXrcPyKhmPQirUwXSCv
         0XSi060WXEi+AQxmIULrMGhBFQMkP+HfZKM5TdOiyGhXlbto3g6Hb/Y1Zh3pDvLCPSV4
         76P+hhOU+2Z7H46Kc92vEValN4JZjMBQo6Gp9dLYvfue6aKMEPrjmHyFtunpo2iCI8Qp
         bpUw==
X-Gm-Message-State: AC+VfDwqtdikfcJDg3BsGCJP2TsZs+TfoAMn3GT8M0hVMCh3K9mgS5ZV
        g9DOvXpGtfDPrgAv35y8PmZcbw==
X-Google-Smtp-Source: ACHHUZ5pvMK/bobufw4bGws/g5M4JArSHINT15YV3AgtgAONQ/R/s0lYT40mV4MjxFlwmSlJCvUJIQ==
X-Received: by 2002:a05:6512:1308:b0:4eb:4258:bf62 with SMTP id x8-20020a056512130800b004eb4258bf62mr5447097lfu.8.1687167500039;
        Mon, 19 Jun 2023 02:38:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id m30-20020a056512015e00b004f8472df107sm987264lfo.64.2023.06.19.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:38:19 -0700 (PDT)
Message-ID: <7c190401-8f47-aa8d-9a1c-f54090a6aad3@linaro.org>
Date:   Mon, 19 Jun 2023 11:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8150: Fix OSM L3 interconnect
 cells
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617204118.61959-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617204118.61959-1-krzysztof.kozlowski@linaro.org>
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

On 17.06.2023 22:41, Krzysztof Kozlowski wrote:
> Qualcomm Operating State Manager (OSM) L3 Interconnect does not take
> path (third) argument.  This was introduced by commit 97c289026c62
> ("arm64: dts: qcom: sm8150: Use 2 interconnect cells") which probably
> wanted to use 2 cells only for RPMh interconnects.
> 
>   sm8150-microsoft-surface-duo.dtb: interconnect@18321000: #interconnect-cells:0:0: 1 was expected
> 
> Fixes: 97c289026c62 ("arm64: dts: qcom: sm8150: Use 2 interconnect cells")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Ouch that's an oversight

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

On a note, the L3 interconnect has per-CPU (or realistically, per-cluster)
voting buckets, but we don't use them as it just seems like an
overcomplication with no immediately obvious benefits.

Konrad
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 18c822abdb88..b46e55bb8bde 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -56,7 +56,7 @@ CPU0: cpu@0 {
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD0>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -85,7 +85,7 @@ CPU1: cpu@100 {
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD1>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -109,7 +109,7 @@ CPU2: cpu@200 {
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD2>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -133,7 +133,7 @@ CPU3: cpu@300 {
>  			qcom,freq-domain = <&cpufreq_hw 0>;
>  			operating-points-v2 = <&cpu0_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD3>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -157,7 +157,7 @@ CPU4: cpu@400 {
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD4>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -181,7 +181,7 @@ CPU5: cpu@500 {
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD5>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -205,7 +205,7 @@ CPU6: cpu@600 {
>  			qcom,freq-domain = <&cpufreq_hw 1>;
>  			operating-points-v2 = <&cpu4_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD6>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -229,7 +229,7 @@ CPU7: cpu@700 {
>  			qcom,freq-domain = <&cpufreq_hw 2>;
>  			operating-points-v2 = <&cpu7_opp_table>;
>  			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &mc_virt SLAVE_EBI_CH0 0>,
> -					<&osm_l3 MASTER_OSM_L3_APPS 0 &osm_l3 SLAVE_OSM_L3 0>;
> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>  			power-domains = <&CPU_PD7>;
>  			power-domain-names = "psci";
>  			#cooling-cells = <2>;
> @@ -4342,7 +4342,7 @@ osm_l3: interconnect@18321000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>  			clock-names = "xo", "alternate";
>  
> -			#interconnect-cells = <2>;
> +			#interconnect-cells = <1>;
>  		};
>  
>  		cpufreq_hw: cpufreq@18323000 {
