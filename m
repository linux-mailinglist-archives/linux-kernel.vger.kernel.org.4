Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F3D6D28DF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjCaTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjCaTzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:55:05 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32BE1FD2A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:55:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h9so24275724ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680292503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOMcoQFSkWIySigpw65oRdlyB2wMDMaHYKBxC1qWQqM=;
        b=VkNSZr2mOAHKOcAG9VE6tMt63eVoLh8ecw1/u1gxD6IDCpGY8GZdhXsI0hg0hGC+O3
         jczJ/PeqiYaLlVwlcvYYWgH2wLtCvCjhX5R2W9k1rvmcWSwDK75nb656N6S/ZM18hHoe
         rriOfXV2bY4n0wlgEgscjYUYvz51CG8C5MaaOHz533EDG5eYAZ8469mJbRQlXFMqOIC9
         yVL74+I8kfmoImdm/1WfXxdk0YxRCtlQzQ+BjpyQ+47vUyvGJnnY67w/8QPnQnKt1fI+
         uInCdSnHvDGXmH7jNyGsdVvAjVDkOQBMhBnUq/9Dc/jZZ0k4APBNS/UCPALn/sR0ldaC
         wzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOMcoQFSkWIySigpw65oRdlyB2wMDMaHYKBxC1qWQqM=;
        b=cTOqVH5zBWo+Mu4cimyjsy37dyGdRxwPmGFw684GoDwJ30Ufaak3tJvkMd5d0El2y2
         VUiesmT+UpJckRp3h4tPPFLYOIr3QmdZFahYEYdgVGPE0S8PPQToRzwfYnd49sMMZtbf
         WOmvEgudlRm8wyZcfAvzCkBYJkw1kqSuBMkcTPjDGHQ4IMZd0FNaXRAF7bQpgWpib5TG
         1SYJTeAqhI4/5qFaL9qHLXrSVDlgvORjuAAjAP4z1zhCYhhWg99QviLtoH4DHp0+5N7L
         HSFr1jQS40LH/PfwzCp/kbUS6oSeGg96pbLVSCpSOylJG9pW5e0RVwrtzB9ZFu5pnEvT
         cDbg==
X-Gm-Message-State: AAQBX9c1+Ir91KS8YpHawfxcLYD2zpS8jndsb1g6+scdeWLxUkAZDju7
        hlh/pajak+HSSFz1cW513qlDMQ==
X-Google-Smtp-Source: AKy350YAPaRJRZBDs1Lve1FOBrg2hkyAPTUJF+YIBzinY99phCuglBf/iMrWhggu02oH8g3z/DxolQ==
X-Received: by 2002:a2e:930c:0:b0:29f:3e2e:fbd0 with SMTP id e12-20020a2e930c000000b0029f3e2efbd0mr2913518ljh.15.1680292502952;
        Fri, 31 Mar 2023 12:55:02 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id y18-20020a2e95d2000000b002986d9bdecesm494911ljh.129.2023.03.31.12.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 12:55:02 -0700 (PDT)
Message-ID: <be20c226-317f-9c4b-858b-8d551eb7acaf@linaro.org>
Date:   Fri, 31 Mar 2023 21:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 04/11] arm64: dts: qcom: sdm845: Fix the slimbam DMA
 engine compatible string
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
 <20230331164323.729093-5-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230331164323.729093-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.03.2023 18:43, Bhupesh Sharma wrote:
> As per documentation, Qualcomm SDM845 SoC supports SLIMBAM DMA
> engine v1.7.4, so use the correct compatible strings.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2f32179c7d1b..17a29184884c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -5152,7 +5152,7 @@ msi-controller@17a40000 {
>  		};
>  
>  		slimbam: dma-controller@17184000 {
> -			compatible = "qcom,bam-v1.7.0";
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>  			qcom,controlled-remotely;
>  			reg = <0 0x17184000 0 0x2a000>;
>  			num-channels = <31>;
