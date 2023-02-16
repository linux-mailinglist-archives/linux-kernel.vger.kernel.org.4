Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5A6991DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBPKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjBPKkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:40:39 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F5A55E45
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:40:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x40so2181195lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dgt4gnpSx+P+yjPZOjswOx/oG7NC2ghxmvXcNqiSA8c=;
        b=Ks6suIAKWsFL0gXZyPNWvj59kwFVH60DTHjRflVjnkZrGrxulIijO4sPS97jisnCVO
         39kzv1w9YX8bKvHrkJPGqHiLeilnUroEYqfZPyK7P0Xlb58a1E8kksUmmt0L7IiMyBUt
         bJPtHhMtJ4Gk7AeTEVdQeeI6q1SD4EbScRoHUmMlmiSWHhtz1T08g5fOu9FlLn/WG4SI
         mHARrr8qv7Eu8eqWzO0k5AacywAcZvQuNa2LGjXn5ecgqSTQPbpGLnQti34EBvdyMqvj
         iHFhlKGuqxOtMhc7zeTUs/eFR7QESM/Vf0WLg4r2uwiKxLzTlXrMNiBieS/QDkd0qK3f
         xRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgt4gnpSx+P+yjPZOjswOx/oG7NC2ghxmvXcNqiSA8c=;
        b=J79Sfnbq/N2zk4mzmY85fgHXl+HpB9NqBL+rZtYVRdErBLYbwBlLsN4sJ0VQrCKfVQ
         TLwOty1deHD0mDTGLRC8OTRauF8OlsNUQGh7DXaOnWgxv5oei9rJ+BjYE/v/7VG42hDy
         vBLm8EcOXZrt/Dg/w2ui+zJIYraruwdI53fEx3PTqsmwX/1WvyEeo6usBDlbzs0Iq/LM
         /EQ+73eYWZVbWDDdk9Ix5beL+a6Zl2KIbYrm2IYJqGk9sPj7H2AJg6zGRslUEIEXEwWE
         LG4km3SRlL/8fKAj6ZFa2jesR3VXkzYuduRamWtDnQ6RnORjdL5dX8PWdodvV6N+STk0
         3N+w==
X-Gm-Message-State: AO0yUKU75OYibHddXxNjj+gUx42D6yhacZp/Cq/fm7TPoyBWkFdmJFRv
        rFtlO2O+tPnL8M4m6wEDbCC7Wg==
X-Google-Smtp-Source: AK7set9VxOLSGny9zEbqeFFD0C9GKfYCEIAd1G5pnkC4lIjA6lvWNmYpGuTzjtqOThx3t7wW8EyhxQ==
X-Received: by 2002:ac2:43b9:0:b0:4d2:551e:3838 with SMTP id t25-20020ac243b9000000b004d2551e3838mr1324845lfl.29.1676544002082;
        Thu, 16 Feb 2023 02:40:02 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id x25-20020ac24899000000b004d61af6771dsm248023lfc.41.2023.02.16.02.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:40:01 -0800 (PST)
Message-ID: <83e71d32-417b-a343-4a3e-aa7cf0fa6857@linaro.org>
Date:   Thu, 16 Feb 2023 11:40:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH 11/12] arm64: dts: qcom: sm6375: Supply clock from
 cpufreq node to CPUs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
References: <20230215070400.5901-1-manivannan.sadhasivam@linaro.org>
 <20230215070400.5901-12-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230215070400.5901-12-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
>  arch/arm64/boot/dts/qcom/sm6375.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index 31b88c738510..58d3b4785401 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -39,6 +39,7 @@ CPU0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x0>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -58,6 +59,7 @@ CPU1: cpu@100 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x100>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_100>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -74,6 +76,7 @@ CPU2: cpu@200 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x200>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_200>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -90,6 +93,7 @@ CPU3: cpu@300 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x300>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_300>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -106,6 +110,7 @@ CPU4: cpu@400 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x400>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_400>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -122,6 +127,7 @@ CPU5: cpu@500 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x500>;
> +			clocks = <&cpufreq_hw 0>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_500>;
>  			qcom,freq-domain = <&cpufreq_hw 0>;
> @@ -139,6 +145,7 @@ CPU6: cpu@600 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x600>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_600>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -155,6 +162,7 @@ CPU7: cpu@700 {
>  			device_type = "cpu";
>  			compatible = "qcom,kryo660";
>  			reg = <0x0 0x700>;
> +			clocks = <&cpufreq_hw 1>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_700>;
>  			qcom,freq-domain = <&cpufreq_hw 1>;
> @@ -1383,6 +1391,7 @@ cpufreq_hw: cpufreq@fd91000 {
>  				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1";
>  			#freq-domain-cells = <1>;
> +			#clock-cells = <1>;
>  		};
>  	};
>  
