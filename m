Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D2704D52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjEPMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjEPMFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:05:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D443583
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:05:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso16827909e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684238715; x=1686830715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRsFkWQdRztNUEVr5b1qEyPiJ5e054yVlq4FCkoAX7A=;
        b=HbU7Vc1GdA8WTZkAGCmYqdLFayXBcTZzSxnuAaGkrynx2D20BBb7+WsmmQdD3xFEd3
         R6Jd16ME3b8U2P3S3IDZApftGRWRSHZRu1FnuKz4UbKliQcWo82jPRx2zDJn+uCTP1gA
         x/mA5jzA3mLbB1Q+xsVidaFrnmQeiOhfOzljZJfckZmPOlIlxMAe6pTiEAStpbX8j54t
         niXakkpaoROJBHtV/1BE+afKBBPpzDtgax1jFWEfONmvKeZhQr2a6mln0ipiFNW9+6sN
         u+2K8itsie9l1T5Vdvtg2ybdk81HghMKZBHJlLymLX90rSSRTApY6i7B6Q9B5tjy33IW
         zIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238715; x=1686830715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRsFkWQdRztNUEVr5b1qEyPiJ5e054yVlq4FCkoAX7A=;
        b=dZfzoouZtEnIoA7uvzdcjF4Q0/a9EOMdy7b3uJKvOlomtUwXIxa6xNg0CVPmUkkN0M
         psIGpoCqm/Gu9/fY7RGEUgMBDoCKZKURHKFXx8gRMcElhvXfaaFVWSLpBE2LLaoP7fbm
         5CjF6AaT+kEVqibGlZB++12ff6ga4xj5kE/hYNtOLQ/YVU+lo8yDc5Y9lm61PRc+UInJ
         QPyCLjI1s43brIdApq2YkzLRH8qeo+70jjXo7Shzp3tv1ejewn8D9Kuau2SHTjmDFbYi
         jy8hL8rFqJtmWrgM0opNdJcLKQ+kDSeiNHYVIxn8k5LHrte3hs/kCGnEOHWRSPsBgEeV
         /ppQ==
X-Gm-Message-State: AC+VfDzEhrlgKkUofuTt+VYAwvHfSMtf9iIqVCoIxH9cXgLglfKFsM8V
        SafhEgJJud3vYbwGQCho2OZbqQ==
X-Google-Smtp-Source: ACHHUZ7+Yoo9sdUMFiE9OTFOqeFzd6VNnni/6f5lk1zZYWWBjCfcYaD/eQhRgkAdSwu2kTB4WyGS9w==
X-Received: by 2002:a19:701a:0:b0:4f2:62aa:986a with SMTP id h26-20020a19701a000000b004f262aa986amr5384931lfc.21.1684238715067;
        Tue, 16 May 2023 05:05:15 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q22-20020ac24a76000000b004f2509b87cesm2948907lfp.107.2023.05.16.05.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:05:14 -0700 (PDT)
Message-ID: <8deef09d-236b-e25a-ad5f-fe75e272541d@linaro.org>
Date:   Tue, 16 May 2023 14:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Move wifi node to correct place
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230516-sm6350-order-v1-1-5c3b7c4cd761@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230516-sm6350-order-v1-1-5c3b7c4cd761@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.05.2023 08:56, Luca Weiss wrote:
> Somehow wifi was placed further up in the file than where it should be.
> Move it down so the nodes are sorted by reg again.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 44 ++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 18c4616848ce..4dffd7974fa3 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1891,28 +1891,6 @@ frame@17c2d000 {
>  			};
>  		};
>  
> -		wifi: wifi@18800000 {
> -			compatible = "qcom,wcn3990-wifi";
> -			reg = <0 0x18800000 0 0x800000>;
> -			reg-names = "membase";
> -			memory-region = <&wlan_fw_mem>;
> -			interrupts = <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
> -			iommus = <&apps_smmu 0x20 0x1>;
> -			qcom,msa-fixed-perm;
> -			status = "disabled";
> -		};
> -
>  		apps_rsc: rsc@18200000 {
>  			compatible = "qcom,rpmh-rsc";
>  			label = "apps_rsc";
> @@ -2010,6 +1988,28 @@ cpufreq_hw: cpufreq@18323000 {
>  			#freq-domain-cells = <1>;
>  			#clock-cells = <1>;
>  		};
> +
> +		wifi: wifi@18800000 {
> +			compatible = "qcom,wcn3990-wifi";
> +			reg = <0 0x18800000 0 0x800000>;
> +			reg-names = "membase";
> +			memory-region = <&wlan_fw_mem>;
> +			interrupts = <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
> +			iommus = <&apps_smmu 0x20 0x1>;
> +			qcom,msa-fixed-perm;
> +			status = "disabled";
> +		};
>  	};
>  
>  	timer {
> 
> ---
> base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> change-id: 20230516-sm6350-order-f9a836dc7247
> 
> Best regards,
