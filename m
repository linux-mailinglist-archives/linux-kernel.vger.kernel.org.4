Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34066E407F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjDQHQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDQHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:16:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FD3C39
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:16:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4edc114c716so739383e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681715800; x=1684307800;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncCyAwta9nHbO/C/KZoS3rqUTMJqHj/I67Tlzw8Yh38=;
        b=zAJPtpzaQ6umd3y8lKiND2yPE+l/Sb1QQ876mfUQ0lbHvAGUszk64bwCdb8X6LCTVQ
         NhQ4RjdCgj3k/Aee5OukzqsjgXv0fCNf2xgvFHdORNKEiubmm/4V12XwueurIuGGs8a5
         FL3YTbPY450t0bEmVpT2SryQEpZ/UlIB37KFTRFYrFiB3J//k25bQ+Yn5eyy1bIUxX+Z
         /TzxMF+YCJ6+8AGMwlnEL/HWXHPkWIvArvp7E+gDMzfhobuluy1s99M5HRSsve8NQTzV
         F3wxoedbhDclN6DkgcV9EBbbCnIZ7fAvmZ/Y8814jMvb7ajmi6spBFcT89ofAC8sTbwk
         MvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715800; x=1684307800;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncCyAwta9nHbO/C/KZoS3rqUTMJqHj/I67Tlzw8Yh38=;
        b=Eq9CMU3kGaVpu1iRFeOocFtIrN4y4VwKGIwv7Se/FQyMjeD/wnREhwdvCufitaHG8V
         bFau4wLwmKi8zdtuiibK5tnW5qy7aAJCwqYRLQl2j/zMN/Ghuqgcwkq/g36ciSL1NWK4
         PpekEWl061k1oFbN+rox2EK46dqRIAL1uHnp2yXJxMvIV7eTFTjPh93yHfEYREmy4HRD
         6geuHkryNoaNO1meTznQXhdks+UnHsl/R1CmBVQmimpwJkVFg4qjo9KH4qZyjmqcb6GY
         4TsAcdRJeCAi9kNpPkH1wEyc8oR4HkhS4nPOxYJtnsFeXP78DTgBI6LfKTkHlP8GdPhB
         XXDA==
X-Gm-Message-State: AAQBX9fbLzIqD2xChZtuRM4QCYJrAzcGLGbIOmdy9SX3ImAWPl6zCMqe
        zCP85JdcoXfE+zU/aJZfQjoi5w==
X-Google-Smtp-Source: AKy350avB30YoattXoLHhrlT+mj5mqjMfUqUQtQsTTrS3OYAXgdyLwoY6efT8qar9QRgp3Qbdjl2FQ==
X-Received: by 2002:ac2:52bc:0:b0:4d7:44c9:9f4c with SMTP id r28-20020ac252bc000000b004d744c99f4cmr1438871lfm.4.1681715800189;
        Mon, 17 Apr 2023 00:16:40 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id x28-20020ac25ddc000000b004d863fa8681sm1959890lfq.173.2023.04.17.00.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:16:39 -0700 (PDT)
Message-ID: <00b18b59-0ecd-316f-41f5-05ee34e599b7@linaro.org>
Date:   Mon, 17 Apr 2023 09:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm8150: add missing qcom,smmu-500
 fallback
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
 <20230416151311.346596-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416151311.346596-2-krzysztof.kozlowski@linaro.org>
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



On 16.04.2023 17:13, Krzysztof Kozlowski wrote:
> Since commit 6c84bbd103d8 ("dt-bindings: arm-smmu: Add generic
> qcom,smmu-500 bindings") the SMMU is supposed to use qcom,smmu-500
> compatible fallback:
> 
>   ['qcom,sm8150-smmu-500', 'qcom,adreno-smmu', 'qcom,smmu-500', 'arm,mmu-500'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 3846f5e0f656..024b3c79ea11 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -3983,7 +3983,7 @@ spmi_bus: spmi@c440000 {
>  		};
>  
>  		apps_smmu: iommu@15000000 {
Are you..

> -			compatible = "qcom,sm8150-smmu-500", "arm,mmu-500";
> +			compatible = "qcom,sm8150-smmu-500",

"qcom,adreno-smmu", "arm,mmu-500";
..sure about that?

Konrad
>  			reg = <0 0x15000000 0 0x100000>;
>  			#iommu-cells = <2>;
>  			#global-interrupts = <1>;
