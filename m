Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93AE6D98DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbjDFOAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbjDFN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:59:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5743ABC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:59:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q16so50921672lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680789586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahOtErsAZTwjnxvLm+Q7vFYLyLF4PgdNHJFRQu9gQIE=;
        b=kmt4M8Hx4w/t+axa3WrnxHX+1XcH/Csa7PEULn+hnUQNZeqU1vfcpgKvdXbL/8QOxC
         I1CSGA2cglCL00n+FGfB5L0fcO2hL22Yf4raMBmrht4fzO7lZx72TZ55IOAhsFlDWsEl
         wY2xiymIVcZbMRlKj+rEtpruZhTtBq7467tW7PkvpEfGqTaTc4gbg9ANzsRsvHSFEm3S
         djbk4UQmDvDn1WJY9vBvFaCT6Rv265DYIRwtkH4Z/IS9IXtb8PG6GHTaIDtV9bWJxRkt
         o70V7sNMM8ZdRx2IVfykopTkjF86wDJOWIPRg8b/b3NsJW4DKwT9fQfwgTjDolpf4zD/
         7x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahOtErsAZTwjnxvLm+Q7vFYLyLF4PgdNHJFRQu9gQIE=;
        b=YzREYLYVfeoFwo6unpluA89pemGT3bx+UdqlKRI335F93yAGC87LvngyNYz2ZgZ9XL
         ZL2Bp97/CkpJ7qR6dM2DX/QnWktjj5+RCTAAJ0OHOflaJFMPjrdeuEbdDqBsoX8lQFSR
         JeLd8A0WhqBBj9gwvX5TGos4L4XDPQa2yC4iASV880ZY+LlF3b7QaV4gBMT2dp+PL3Do
         Z5LlASP/imZU/n3rHe+5AZN2c16ECtv87nGHzkulNVqZx2BvQI7sJcBBIIjjQtIvNnrz
         4KXFpiOk0cpcVmirYB3J8shDt6x3wfb8zknwd+CzqHpPAGZeuJWv9eNta0+bbsw7CXSX
         vpJA==
X-Gm-Message-State: AAQBX9fabVwmNgUQ1PhgubUwSXF0WPJeg86Y2uZMFomBoEw3DZixn/5Q
        Q6lt53ZR5o31r9WhF91prxM//A==
X-Google-Smtp-Source: AKy350aoUklCC061oW2drNDEOT/plxqF0kMjER+zJgHC6nWb/WxYQP5DpTC1JTzNFAyC748GebfEYg==
X-Received: by 2002:a05:6512:503:b0:4e7:fa9a:4d3c with SMTP id o3-20020a056512050300b004e7fa9a4d3cmr2374207lfb.16.1680789585933;
        Thu, 06 Apr 2023 06:59:45 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id z1-20020a2e8e81000000b00295a8c68585sm299658ljk.56.2023.04.06.06.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:59:45 -0700 (PDT)
Message-ID: <af22628c-e54b-f7e1-16a6-6534f4526cd5@linaro.org>
Date:   Thu, 6 Apr 2023 15:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 09/11] arm64: dts: qcom: sm8250: Add Crypto Engine
 support
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-10-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405072836.1690248-10-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 09:28, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm8250.dtsi'.
> 
> Co-developed-by and Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 7b78761f2041..2f6b8d4a2d41 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2222,6 +2222,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
>  			};
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0 0x01dc4000 0 0x24000>;
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			iommus = <&apps_smmu 0x594 0x0011>,
> +				 <&apps_smmu 0x596 0x0011>;
> +		};
> +
> +		crypto: crypto@1dfa000 {
> +			compatible = "qcom,sm8250-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0 0x01dfa000 0 0x6000>;
> +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x594 0x0011>,
> +				 <&apps_smmu 0x596 0x0011>;
> +			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
> +			interconnect-names = "memory";
Shouldn't we also attach the contexts from qcom_cedev_ns_cb{}?

Konrad
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x40000>;
