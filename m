Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A16991BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBPKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBPKjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:39:02 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668954568
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:38:30 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h38so242472lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxMdyDI6D0KMu5lr8AIvoXQgNrR3gz0L+12TF60RCV0=;
        b=L01Ff9grT9wD8UaeHPdOgFJfL0EjyEA0dPBF7LP4T+HDJ+zoeY87RP3uQsWh/FFfry
         jhSaWneu90rBxiqq3psvfTMnQSCD5THoLyo4J+12u8U0lq+RvMcMzf3wCdAVGcoQe+2i
         8f32eW/B/FTXRqFwqbn1uqiVh0rve+L89z3RnyzfNp9dOZ4yq6Yfr5mjy/JrCGT4QtXg
         y4AbZ7JsGZ4/sxPYwvY4NtR4fJKEbbOdGZlPbyvZhcdG7um6iNF9rsleAQce2tT8REJu
         qLQI4dj4To803VyCr/WT456y+4raV4Fgsa+fsFpC4RfltlJNwYC/TXHLgtBuMNfQcXwc
         j/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxMdyDI6D0KMu5lr8AIvoXQgNrR3gz0L+12TF60RCV0=;
        b=jwz5g/HDRAsaubm66ndJfp/sW8LgYUTrW/R5fpSg+tSRRiKg0b3wCXY6xiDrhwXwPv
         9KOm4TuD3TXLmWyTZ8KxCKoaY6I1LmMY96TQtCv9sUmomvWiY6pVs2tL5dYBMQ1Y3x8h
         QUkyAz92aJQUSUbZ/ANI5xzuF2HtPUh9jvQBrRTpIULXoKhoNASzFbnhLGv5YsckT4TH
         Bf3MThkvB3gUPQ4S81fbF6sluFgtn4BA5aZFrq/UQHEEJ15ku7fvv2e9pBYgrlv4BZ0X
         BvgikkK8PQdfyr/B6JXMjcZXX7LSjJgw0Nn3qPF0QbcU8WJDD7A2/6Hxb5bufJRMvYBY
         9kEA==
X-Gm-Message-State: AO0yUKUyVcqseD6UQjA1OMnmcJHxaSAqt/zuf6EG0MaCH9a44pU/3YLa
        vipemEAerBh5OiujT4h9MVdaKw==
X-Google-Smtp-Source: AK7set87pO+FJOWq8JAChpvFzm/hlfbaf7Tufr/c9pkmJeii7m1cnVc1pyURG5BpHZv17UvdI9gfEw==
X-Received: by 2002:ac2:48b0:0:b0:4db:38aa:a2f4 with SMTP id u16-20020ac248b0000000b004db38aaa2f4mr1292545lfg.14.1676543891627;
        Thu, 16 Feb 2023 02:38:11 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004b57162edfasm242416lfo.117.2023.02.16.02.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:38:11 -0800 (PST)
Message-ID: <17df2e00-1779-5b7d-1772-a878739ef770@linaro.org>
Date:   Thu, 16 Feb 2023 11:38:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 05/12] arm64: dts: qcom: sm8250: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-6-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-6-manivannan.sadhasivam@linaro.org>
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
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 2f0e460acccd..44c8851178eb 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -97,6 +97,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
> @@ -127,6 +128,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
> @@ -151,6 +153,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
> @@ -175,6 +178,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <448>;
>  			dynamic-power-coefficient = <205>;
> @@ -199,6 +203,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <379>;
> @@ -223,6 +228,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x500>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <379>;
> @@ -248,6 +254,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <379>;
> @@ -272,6 +279,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo485";
>  			reg = <0x0 0x700>;
> +			clocks = <&cpufreq_hw 2>;
>  			enable-method = "psci";
>  			capacity-dmips-mhz = <1024>;
>  			dynamic-power-coefficient = <444>;
> @@ -5481,6 +5489,7 @@ cpufreq_hw: cpufreq@18591000 {
>  				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  	};
>  
