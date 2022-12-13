Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7C64B26E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234960AbiLMJet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbiLMJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:34:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE30FAD2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:34:38 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x28so3958050lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7P5vBZVqDTpTHPohSutqwjBezarGBknMBBPdddGlLE=;
        b=TyQ+NzxoZVz+1B8d1sqOFHHBNZGBkgxagwusiD5RDmpoM5rDEST5txNk9DARD0zPKy
         TTrvUQB2r4l0G5a/8YlOqjjcgBMkggBb5G0zBtscrYcuwNf8GOmRsZUVrIcR71aFNkeG
         /JheUFrN5t1pq174L2GdKf9Mj+sSGhijxJD7Dae1cbBj8znrG9bpechHNVDWwiaLVP9z
         Wr/WwM+E/563jIA3ws3SOZyHbEhsTfxi/Gt/u+ItEY2vGywlicq9e3FUi0fJ4659WuMa
         pGPBMm+TwYmQzXrOhOuK4RlagbeAkLiD2fAKAobe04AYglOg/VYyMcS9940uN1XjnRdw
         jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7P5vBZVqDTpTHPohSutqwjBezarGBknMBBPdddGlLE=;
        b=wFrK6cIdECKmoED7nb4pkgDsH2/hRNbEB3AN3+6uZlTWlPQbLAbLdINNkZe9dhOos3
         PeBrTdIH4g+I/BfjpmABN/m64f9aH1ZvsExC5d3+zXHI4qhd6BtDYDgh+b9Bpu/xBPEy
         v1HCVflvhcc/+B56Om1oE/s0I85lX7WrsOCRoBaLu0IF5WehKj7vGd0nWEm+4DeiTYAZ
         YIoYALNw5YRlMHn6Pir8S6rwUVbrLmWL7oMmoueMfjE9yyq7FxmSDAo38lSWhizkELhy
         ceejaV2HNF/w2mbvB8KCBt9cG+N7iEGTEQ5W4J+LARaQwNct+9euALzlqsJ4JoCrVkDB
         P4qw==
X-Gm-Message-State: ANoB5pkw8ECExZPO26ysgrcgMu3HDXZjpKYjvSuOf4VZdez9piNOxoBd
        HTbeoMUqfamY5Ag0TaEGZCgWYg==
X-Google-Smtp-Source: AA0mqf41ho1m2qeBH/FRCNwye22r6xK+zyFu4pKVBmBSpOUA/niIzfGNeNmRAN1rJ8EnEFPU7W/CnA==
X-Received: by 2002:a05:6512:1082:b0:4a4:68b7:f884 with SMTP id j2-20020a056512108200b004a468b7f884mr8729652lfg.40.1670924077650;
        Tue, 13 Dec 2022 01:34:37 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id h10-20020ac24d2a000000b004949a8df775sm292446lfk.33.2022.12.13.01.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 01:34:37 -0800 (PST)
Message-ID: <4a2d5411-77ae-d415-2ab5-5c6b8630a65c@linaro.org>
Date:   Tue, 13 Dec 2022 10:34:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 11/12] ARM: dts: qcom: msm8960: drop second clock
 frequency from timer
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-11-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212163532.142533-11-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.2022 17:35, Krzysztof Kozlowski wrote:
> Keep only one clock frequency for timer, because:
> 1. DT schema does not allow multiple frequencies in such property,
> 2. The Linux timer driver reads only first frequency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 63c3c40fe9a2..a0369b38fe07 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -109,8 +109,7 @@ timer@200a000 {
>  				     <GIC_PPI 2 0x301>,
>  				     <GIC_PPI 3 0x301>;
>  			reg = <0x0200a000 0x100>;
> -			clock-frequency = <27000000>,
> -					  <32768>;
> +			clock-frequency = <27000000>;
>  			cpu-offset = <0x80000>;
>  		};
>  
