Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C256DDBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjDKNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDKNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:16:27 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC24228
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:16:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r27so10406814lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681218982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcUTTOUcMW0dZnIqgtsXXko3U+fcNkeoSkY3ZJOPmXE=;
        b=LYUd4gN0uvXVwbiLe+XaMSfZYrd+SwcY14tzEW5bLYbnCvbOjB/IB4sP6F1LfgFC7q
         BSefua8JuXbOq7EDzM3b9LBcTQGaMqZAjneiOHp8G/rdIR43GAt4B6ZchiceXSFwWa07
         xv+hX5RZbZpq5DoIIPl9x5aHvqBhYh1TbFKpe0gKwjKLVQcy+A+Yp6MCFft43Xuzk53a
         8TBiENf2cer2zEgRynfAzy+gC6VszB9hwZCbV6aJjdGuQcA9Z1XfpgeNHciFodlwRcBr
         HHzjrhwHuXKETo6CNUblAQs9jRzsoD8XM6zqjI7vlCIFUY2AqEi0T1Lx3sRC3Bk1szZ0
         /eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcUTTOUcMW0dZnIqgtsXXko3U+fcNkeoSkY3ZJOPmXE=;
        b=scyCIX1l7SA44BjXaQMON6Y2gSSlyXYvDAFFPN9MryI7wleN+WQazNFlI5YYv0xpto
         cbJA32tHNDOvkJIgFgiv6KBRTUZj5ue/tEjiRrbS1tOgT1NE4VStsianv8lhcXKM5Tce
         oVFp4PguWktphcaesoS+FuHoPfvBs6g9ISwyy5ImiH1UD0DuTDeKItJcQqC6neHujLNJ
         JHJVwj2fBU9NWTtH41dY/WyZEeeweL1crPDU3v4kgZi5Nnl4J1Xz0LMFNwH7okeTe/ph
         2LbXnVOC7v9zl+LnFtntnTLoyEaqr3tqU98ei2VwxYm9rvEeDe97is7owwiTXBBbfr11
         uL0A==
X-Gm-Message-State: AAQBX9eO0x0QdVAqrvsCnS1/1iXeDIrYtEhI7+0vklSOOk2PErW4fTXA
        PDPP+q98Rpm3Ey+ddYYs8+19ig==
X-Google-Smtp-Source: AKy350blhLpXLllc5IUc17Ff5DabLr3YrfUjg7JsGcKpnIEbMfXx9pu1SF8NEN24gpwptlidkj7IFg==
X-Received: by 2002:ac2:414a:0:b0:4d5:978e:8bcf with SMTP id c10-20020ac2414a000000b004d5978e8bcfmr3481121lfi.33.1681218982568;
        Tue, 11 Apr 2023 06:16:22 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id r26-20020ac252ba000000b004eb09820adbsm2557794lfm.105.2023.04.11.06.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 06:16:22 -0700 (PDT)
Message-ID: <6c75d434-bb5d-278f-a125-d096fd6b387d@linaro.org>
Date:   Tue, 11 Apr 2023 15:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sa8775p: add the GPU IOMMU node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230411125910.401075-1-brgl@bgdev.pl>
 <20230411125910.401075-8-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411125910.401075-8-brgl@bgdev.pl>
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



On 11.04.2023 14:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the Adreno GPU IOMMU for sa8775p-based platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 191b510b5a1a..11f3d80dd869 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +#include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -605,6 +606,42 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,sa8775p-smmu-500", "qcom,adreno-smmu",
> +				     "arm,mmu-500";
Err.. does it even boot like this? You dropped the qcom,smmu-500 compatible
which means it's getting bound to the generic SMMU driver (without
QC quirks). If that was a mistake, you should have had all 4

"qcom,sa8775p-smmu-500", qcom,adreno-smmu, "qcom,smmu-500", "arm,mmu-500"

Without falling into the qc-specific codepaths, the Adreno compat does
nothing.

Konrad
> +			reg = <0x0 0x03da0000 0x0 0x20000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +			dma-coherent;
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +			clocks = <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
> +				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
> +				 <&gpucc GPU_CC_AHB_CLK>,
> +				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
> +				 <&gpucc GPU_CC_CX_GMU_CLK>,
> +				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
> +				 <&gpucc GPU_CC_HUB_AON_CLK>;
> +			clock-names = "gcc_gpu_memnoc_gfx_clk",
> +				      "gcc_gpu_snoc_dvm_gfx_clk",
> +				      "gpu_cc_ahb_clk",
> +				      "gpu_cc_hlos1_vote_gpu_smmu_clk",
> +				      "gpu_cc_cx_gmu_clk",
> +				      "gpu_cc_hub_cx_int_clk",
> +				      "gpu_cc_hub_aon_clk";
> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x30000>,
