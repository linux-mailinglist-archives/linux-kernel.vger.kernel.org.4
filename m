Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776166E4265
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDQITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDQITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:19:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A4346AF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:19:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec8399e963so1203124e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681719581; x=1684311581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCV9YQWwOPoNz2PC8xauyXSDP80VylpMrAIhfiDnJnU=;
        b=sjoH0hjmSRVB7asVFZVT0rcweofB4rY0ABT8sts71nERCue8q/VYm0HwSsYXlMBtpE
         o856JQzNtw4cJjhPsI5HbYrXjK/OBldeK20NrUWXZ/9sAEKXfF3wEz7kWwYETeOaODLh
         cTDLPZX336rbCpj9Zy9pOWClqlMctxK+NcBytzc8pr6zlvxxF+810NGy3BRfQ/oG2lMA
         8X3TJRl/9jUNtUX8WNM3hJk+LJe3cdGOdbzMCVNkZrf2vRxAD2ZCgwBN6p4GSFv75vUT
         Xq/6ZNgaTDcoIanearAsBqpx2CbRFPUHCnWB65vhxiHjriGjPteE1TnyyZ7hFYnSYn3y
         ju9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681719581; x=1684311581;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCV9YQWwOPoNz2PC8xauyXSDP80VylpMrAIhfiDnJnU=;
        b=YsVSxG9dj7rtN/t/M1A8sI3qwHf8ztTGn4n8hyIYH9ybXx9scaAHVkgrATY59dgh/z
         mnKAvW0jeCR5PNYQG2HbaVm5LwNukqETz7WH1kqXWcJsGNDf02rJHMhya82HDqGyHC2G
         4MB/A3kaflGoLxwPMRK1iho4EBuCtGlmgz2aqEFOpxi1GW6kqNtXKNBQgW2+SB8uVCvd
         EQzQZJzcIrPEuMmtnNVm7QLVBWcogKAoR0DXC7RZTygppdliUZzSLNf285HI8PqpeRDe
         vxL3WypxfUANSk3ODCWpIOwuEsZ7a5U0RpxT8Iw5lrPHqrkV3HpPDs0VjtfN7EOHnunw
         SU4g==
X-Gm-Message-State: AAQBX9frBTwA0kIM5U8F9/jFW+XUtPnhqzLto7+oKrz42dTJZQEhpUyx
        EXsoIQ+yESHHe8+P9VNG60jc/w==
X-Google-Smtp-Source: AKy350ZVecKi8xwxoZPYB9RerCRzYMuUkpVdUqcTVVMMtHjZEG0wd68WrWQjGSYqTO5GZQ9orqwrbQ==
X-Received: by 2002:ac2:530c:0:b0:4e0:fe29:9313 with SMTP id c12-20020ac2530c000000b004e0fe299313mr1612479lfh.15.1681719580842;
        Mon, 17 Apr 2023 01:19:40 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id m16-20020ac24250000000b004ec8b5891e2sm1972028lfl.226.2023.04.17.01.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 01:19:40 -0700 (PDT)
Message-ID: <6769c392-1589-1178-d8e3-8c14292a5a39@linaro.org>
Date:   Mon, 17 Apr 2023 10:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/4] arm64: dts: qcom: sm8150: add missing
 qcom,smmu-500 fallback
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
 <20230417080939.28648-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230417080939.28648-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 10:09, Krzysztof Kozlowski wrote:
> Since commit 6c84bbd103d8 ("dt-bindings: arm-smmu: Add generic
> qcom,smmu-500 bindings") the SMMU is supposed to use qcom,smmu-500
> compatible fallback.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. Correct compatible and commit msg (Konrad).
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 3846f5e0f656..25085621ef49 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3983,7 +3983,7 @@ spmi_bus: spmi@c440000 {
>  		};
>  
>  		apps_smmu: iommu@15000000 {
> -			compatible = "qcom,sm8150-smmu-500", "arm,mmu-500";
> +			compatible = "qcom,sm8150-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x100000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <1>;
