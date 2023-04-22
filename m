Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054406EB926
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDVMUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjDVMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 08:20:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA031992
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 05:20:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8baeac4d1so24246951fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682166018; x=1684758018;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbDC/ViUiQ09TaRrRepbHTTbvIE8/HYr1vg91d/EXqs=;
        b=QOOQ3lGE1xpwVOv/8LU5bKXuEYTPBcUl9NjaZ+707t8rGSYsXMdHA8NWbdAvL8NRhI
         tPShEa1646PQGg5DIsPzu4Z5at8XnQWNEErogRBre1zQqkvkjHQSlZ196puZVW4jNxBl
         32qit/urhHTLYYJLdf+qr2kc5GfT389B384uzyvw4uD+82y1Nc6Q5kZ9vupkiVzjpGj6
         F9vEctjrs6Hu1MkL+C18C9EgGFnQoLSDUlrxvafPCbPxkpSqzq3BVTP/gMvjETPhc0xa
         2Xtav/CF6lUSWuO6JXFGEyZEHa3brbyQsYVmnFXyMdbDbalET14vAnd9tBD8lpx4IYLh
         r9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682166018; x=1684758018;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbDC/ViUiQ09TaRrRepbHTTbvIE8/HYr1vg91d/EXqs=;
        b=bfP4JhoRX5764+Hjv+Vkds0u57MiJpHdNV5mAdlOPKWFSdtFldHVpuASZPGliUzL2M
         7htwZuJPDVUhh/vzstfQmpC61xkRAxtmIi2MT3CRnssO9fZQhL2KRpdJurYXnXUqpCAi
         VPYOX9urPmIm1ms9q8tvtPi/mN6Y6mZof2Y9qwe5mRt9KcGuuV2gGPq53/LCQunPtKHi
         QEm4RYf7vAEgD7VV2XXZwarUM6wFYvMrzE/3P0r1vFcYPKb2JfONfm6QJUogvZLui+16
         67L7IkqlYR9UCwsSU1rFNxkDf/n6LkxDA5K2gL2nVSt8IiIkMd4HjymrIrSvxg7V2H4i
         7/ag==
X-Gm-Message-State: AAQBX9eCYntsUKHIyRSbaEPHhBXkkjH+i9Iu/+L1Ff855XxztH1k8KSI
        TKzugkKO805J/ON/UI0q0+6Hcg==
X-Google-Smtp-Source: AKy350ZLtiNjfBDqwuoCFA6CkoTMhuWea78JYwUYJmE/MD3HxnAcvMpsDvgrrLUmDA2KnT9v4GDTcQ==
X-Received: by 2002:a2e:b61a:0:b0:2a7:ac9d:a64 with SMTP id r26-20020a2eb61a000000b002a7ac9d0a64mr1252533ljn.43.1682166018260;
        Sat, 22 Apr 2023 05:20:18 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id z17-20020a2e8e91000000b002a8a77f4d03sm971651ljk.59.2023.04.22.05.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 05:20:17 -0700 (PDT)
Message-ID: <99b71397-9d51-4cfa-533b-992369b74541@linaro.org>
Date:   Sat, 22 Apr 2023 14:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8992-libra: drop duplicated
 reserved memory
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420180746.860934-1-krzysztof.kozlowski@linaro.org>
 <20230420180746.860934-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420180746.860934-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 20:07, Krzysztof Kozlowski wrote:
> There are two entries for similar reserved memory: qseecom@cb400000 and
> audio@cb400000.  Keep the qseecom as it is longer.
> 
>   Warning (unique_unit_address_if_enabled): /reserved-memory/audio@cb400000: duplicate unit-address (also used in node /reserved-memory/qseecom@cb400000)
> 
> Fixes: 69876bc6fd4d ("arm64: dts: qcom: msm8992-libra: Fix the memory map")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Maybe the original intention was to use different address for audio res.
> memory?
> ---
Similar story to patch 2, I'll recheck on a device
soon(tm)

Konrad
>  arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> index 501e05efbef4..133f9c2540bc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
> @@ -110,11 +110,6 @@ rmtfs_mem: rmtfs@ca100000 {
>  			qcom,client-id = <1>;
>  		};
>  
> -		audio_mem: audio@cb400000 {
> -			reg = <0 0xcb000000 0 0x400000>;
> -			no-mem;
> -		};
> -
>  		qseecom_mem: qseecom@cb400000 {
>  			reg = <0 0xcb400000 0 0x1c00000>;
>  			no-mem;
