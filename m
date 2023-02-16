Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF96991C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBPKjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBPKjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:39:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882525454F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:38:43 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u27so1437445ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXCBw7G9VuSG/ngojEw3pNHsZ/bJYitaim5VMT2tvs8=;
        b=U7wjH2fHaAHFVcnj4i8SdiogChJjwk6Z9/LGKcEUXRaVAnyCThwybpsmdjxIFuxL2s
         mSJh6V9QAd0J8SN119GqVehbF8iOJp0oJKndXJRQqJbnNFnlv+NaMnNgmY20WG4R/W9C
         D5GgyOpP+dxeb2UBxdA2ThUAdJEpvOqtIYjKQTOS/I1e6K5K+P6/7megaai1BeWkeb31
         QOb/R3/ghySLgK0o87xdhVZAzRS3PAhsd2/QA8J05wsvuIu/R6iKNtGDJxuISTuYT2Gv
         B4YV6QSBaBO+AiojHDXJFW2A4qHyt6ra0o6F7Hj3AS8Bq8N01FotLN0fDaLYsPs0wlJg
         uX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXCBw7G9VuSG/ngojEw3pNHsZ/bJYitaim5VMT2tvs8=;
        b=UzPJ2u0z4D5twOBOSm6HGB6zkdITUarNkae86PKtTakdxNFXTqpoumqJkC/BZYq0u9
         FE6mgaGIXaa5ZZ/BZ35cSsiJkBsqev3u8ys8u6cW6YhxV/wci+pwc3WWwjFDlqM97K6r
         DqoHf/ec1VRvINys0JEORjD1H8Fcm+XXhJM9ryOm5dxZlLtSc++P/cslmCOUMMdfz167
         X27NUYKBIetMXU0wzpwTMwnF/qilcduBlxXf/Ie8oZkSaEDtt16ZkWSUEzV6jZNICa4n
         1nbtr65o2jRs121206gM7adbzCmX/AWf+dvggEAmxxhjUP2RaAcxNjkKNbm7T94vMoR4
         Ip/w==
X-Gm-Message-State: AO0yUKXAcVMPIODOzXwUhTnpXmfmxd4wp3CPK0AW55tpk76fQwyVyAn6
        OcEgpTCMfn3Bvhr1RYNVC/IBzQ==
X-Google-Smtp-Source: AK7set/Wh95woympb18XB5PdGTPAO1sJ+4dF+Jvq+QyTRhzA9lApTfddm1TGkafBT7qHvSJ3Ny5P5g==
X-Received: by 2002:a2e:968e:0:b0:290:5547:8c7a with SMTP id q14-20020a2e968e000000b0029055478c7amr1397708lji.45.1676543900629;
        Thu, 16 Feb 2023 02:38:20 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id bg27-20020a05651c0b9b00b002907f6fba4dsm136762ljb.62.2023.02.16.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:38:20 -0800 (PST)
Message-ID: <83a768ea-28bd-144d-a74b-2a6278b40d33@linaro.org>
Date:   Thu, 16 Feb 2023 11:38:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 06/12] arm64: dts: qcom: qdu1000: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-7-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-7-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.02.2023 08:03, Manivannan Sadhasivam wrote:
> Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply clocks
> to the CPU cores. But this relationship is not represented in DTS so far.
> 
> So let's make cpufreq node as the clock provider and CPU nodes as the
> consumers. The clock index for each CPU node is based on the frequency
> domain index.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index f234159d2060..98a859ad5229 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -27,6 +27,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD0>;
>  			power-domain-names = "psci";
> @@ -45,6 +46,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD1>;
>  			power-domain-names = "psci";
> @@ -60,6 +62,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD2>;
>  			power-domain-names = "psci";
> @@ -75,6 +78,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a55";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			power-domains = <&CPU_PD3>;
>  			power-domain-names = "psci";
> @@ -1312,6 +1316,7 @@ cpufreq_hw: cpufreq@17d90000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>  			clock-names = "xo", "alternate";
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  
>  		gem_noc: interconnect@19100000 {
