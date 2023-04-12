Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B066DFF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDLUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDLUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:22:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4D7EEC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:22:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id e11so16209288lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681330955; x=1683922955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zH39dSpR93llkezhktYBePhA8Ym9X0Jd/tyZvpZhuYU=;
        b=twUQSGZg8sqC9hXDT26qGZO7omesHMKMHQPvPLgpRGDlmFCX/sSQDoybvlf+2yrNU8
         Pp7ScoRLUfIb4mZgMgH7nbHxG45zrL19tu4FrP5VDmejF5CfWm5q15v4lJSBY78CYmZr
         5kCZIg+NckD5xrstN1EKcN0BD6ZySdLxlZFLrGc17G7BA97L6UKdC5WtVtCAesm1MqVc
         FztyEKs435MavLWTMmJA6GhH/ZfZMe+oJuw9+R/Me+xSHhwXvXD4L3pblqhIKSjFpokA
         0ZjwkE/SV1lmuty868400ANljKNMMxza6YhHCRKNbK8/gzj8KotTrm3y/z8MOLP6l52r
         vhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681330955; x=1683922955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zH39dSpR93llkezhktYBePhA8Ym9X0Jd/tyZvpZhuYU=;
        b=aAubZIffuvJFgLKX3U8AKovjnalp5QEI7JJKnOrSrxRQQeN1em/ynGqYKPyxoaX5va
         oOt+DMe8LFUu0WrBCZUlT7uIrwn5JGJ6AN8RGK4+bk5WqBadf46QmFZ8aVNevf6NAfFX
         M5Qc0eVJlaIu0vGAmzugNtSXt3+qCHQIRLTVYKEZVQ5XjwRREsk3OwDDi9zSuWf6ZdRi
         VdHnaItuTqMrz8o2y+kUWPPZrK3qjkWHB8mfzzuJLNhXFaFyUCpIGJef74qxmjgnaQIu
         5502sVl11t+Bz1EK2S2ltgwg3zLsDPNpyHGnuGMDnGjGzUO3TOL1N+GI+nSuKNDYFsN1
         3D4w==
X-Gm-Message-State: AAQBX9e2x3/aEH2ITgqnnTiYsaR1sZ9H3JgyfpC+V3YWGNFP0a44rCu9
        kZ0gBw4eR9pY8dlhuF8j9qyAFA==
X-Google-Smtp-Source: AKy350aDhIahttGsulsWYdQICvLZlWjlOesHD+6AbyegszmCj8jWg2NmCkFu/g+0eC4q+aRuD4wfKw==
X-Received: by 2002:a05:6512:41d:b0:4de:3f1e:cdc4 with SMTP id u29-20020a056512041d00b004de3f1ecdc4mr38253lfk.13.1681330954755;
        Wed, 12 Apr 2023 13:22:34 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id w17-20020ac25991000000b004ec9fe9feadsm421498lfn.281.2023.04.12.13.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 13:22:34 -0700 (PDT)
Message-ID: <66851ec3-b797-6b40-865c-ec375b5ded68@linaro.org>
Date:   Wed, 12 Apr 2023 22:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-elish-*: Fix panel compatibles
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230412-topic-elish_compat-v1-1-4e03f95d5410@linaro.org>
 <ec2rxutblwlm2wxm6e4zlu3v5d3f6l2eqxjafq2emky6t2kvgt@3u2lo4e53ixs>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ec2rxutblwlm2wxm6e4zlu3v5d3f6l2eqxjafq2emky6t2kvgt@3u2lo4e53ixs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 22:20, Marijn Suijten wrote:
> On 2023-04-12 21:47:20, Konrad Dybcio wrote:
>> The fallback compatible was missing, resulting in dtbs_check failing.
>> Fix it.
>>
>> Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> As usual: Krzysztof already sent these:
> 
>     https://lore.kernel.org/linux-arm-msm/20230408130809.52319-2-krzysztof.kozlowski@linaro.org/T/#u
Right.

> 
>> ---
>> foo b4 requires i put something here
> 
> What?
git checkout linux-next/master
<craft a single patch>
b4 prep -e $(cat localversion-next| cut -c 2-)
b4 prep --edit-cover
/* you get a bunch of EDITMEs that b4 really insists you fill out */

Konrad
> 
>> ---
>>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts  | 2 +-
>>  arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
>> index 8b2ae39950ff..de6101ddebe7 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
>> @@ -13,6 +13,6 @@ / {
>>  };
>>  
>>  &display_panel {
>> -	compatible = "xiaomi,elish-boe-nt36523";
>> +	compatible = "xiaomi,elish-boe-nt36523", "novatek,nt36523";
>>  	status = "okay";
>>  };
>> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
>> index a4d5341495cf..4cffe9c703df 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-csot.dts
>> @@ -13,6 +13,6 @@ / {
>>  };
>>  
>>  &display_panel {
>> -	compatible = "xiaomi,elish-csot-nt36523";
>> +	compatible = "xiaomi,elish-csot-nt36523", "novatek,nt36523";
>>  	status = "okay";
>>  };
>>
>> ---
>> base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
>> change-id: 20230412-topic-elish_compat-73c4511957a5
>>
>> Best regards,
>> -- 
>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>
