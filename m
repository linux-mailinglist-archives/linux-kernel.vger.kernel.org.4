Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC2699156
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBPKdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9101042E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:12 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o20so2207172lfk.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G28TAuy/6oFk/suK4dD0fVgYuOSi6iwQbnKbW0IjYhs=;
        b=fQq4rkcz+L115UYJbdYTul6ajjgtT8qDegn+dhmI5X/Vt7lsw2szYwaC+e+FoWzVzS
         UqnjA+aDLU4Hu0G1ujtKt3OiD9t9bbRmthTvyxQxFytX3bij9mu8+X6Y1T5ek6z9MDTe
         dWl0WNVTyeCnQa4+2gFyZu2F7m4GPY54nXa8BUeWWiyI+brJDfqzsNZ8k2lH2MtcDiGq
         nrjmRc5Vp3P0r50THhPSDvH69ViYPzsqDnCwszmXC3Q+SPNgsncu7kZuKKOJNMOv+yQM
         11W4u57Otb3je3SCTBfjqFGkZVFasqzpNUnwGyA5lDUZ3J9jm+0SNJllNF2SR0L90nZF
         kz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G28TAuy/6oFk/suK4dD0fVgYuOSi6iwQbnKbW0IjYhs=;
        b=XHwgUDOvJPabD0qGVLMCRb7EJpE4NwiqqobaNJNML5KIV/H156NYlgALhaL6mI4otz
         BWqTeo/CuF9I8vQ+yAtuSWOb7/feayhMFvnBhJ+6oh0ShDXklAZlpw842EE4HJvTXyyI
         z8v3PytwMYAPR4EGxq7NGdM2dYtzmyzwnNzv/sOik8oDQnCh4dKujKmgAisO2zmxOIVt
         3zhgJbUSdOc+MNO2vyrPiOmtlVO3LmXl8x6qw3qiojDFEwz1wsIdk8vUUr0UtuKgdy8U
         gyC3sdfNulqQ+dpgNNtOEh2yHJEZRbfuqJrHwo75BxhgFqSAfD17eXGWeJ5onoJg8wnj
         f0cg==
X-Gm-Message-State: AO0yUKUATaMfo2vYvZzvkZ/K7rkDXDBlacVzLviCOTcSktJBVLizm4cQ
        RAeswbQK+zpNY/tlcnx8ABe2cg==
X-Google-Smtp-Source: AK7set+ny/k21yqV1u4cmjdixiAmB7aht5jerIGcbd4dSjACtG8rjnomZdynpsWysY5VscuIlYDr3g==
X-Received: by 2002:ac2:44b9:0:b0:4b5:1545:222b with SMTP id c25-20020ac244b9000000b004b51545222bmr1416421lfm.47.1676543591151;
        Thu, 16 Feb 2023 02:33:11 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id y14-20020ac24e6e000000b004db00415a1asm242534lfs.248.2023.02.16.02.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:33:10 -0800 (PST)
Message-ID: <e8f1110e-7f60-3031-25d4-d4993fa04cb9@linaro.org>
Date:   Thu, 16 Feb 2023 11:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 01/12] arm64: dts: qcom: sdm845: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-2-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-2-manivannan.sadhasivam@linaro.org>
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
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 479859bd8ab3..1d5e6ade8ae7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -92,6 +92,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
> @@ -118,6 +119,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
> @@ -140,6 +142,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
> @@ -162,6 +165,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <611>;
>  			dynamic-power-coefficient = <290>;
> @@ -184,6 +188,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <442>;
> @@ -206,6 +211,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x500>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <442>;
> @@ -228,6 +234,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <442>;
> @@ -250,6 +257,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x700>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <442>;
> @@ -5232,6 +5240,7 @@ cpufreq_hw: cpufreq@17d43000 {
>  			clock-names = "xo", "alternate";
>  
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  
>  		wifi: wifi@18800000 {
