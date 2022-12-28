Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD06574C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiL1Jie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiL1Jic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:38:32 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA6E0F2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:38:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g13so22886352lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 01:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYtnsrsBFcQTG1av2UWtN0kx27fKyWTq2Zrc2a2wfxM=;
        b=sacrvLygAj1iHwqkRipFn4nMm1FzsvAz9KNrIfMSZ9MjIpXtDAB+M2GtYDI+7/+msD
         XSiqgSfBt15RbckykdF+O84tXQf2G3Sg5Wn22cZ3Pgl8//AhpP5hjXj3QjXN6gH/sbaW
         EVxNvDpmAKGk+jvBkksZMLFUZTWOWW3Dp+vLNpqRh/FX6ZdR0AORLGXqNxj+yXLxXpir
         NJ6qMMyaNw2Obh6GlsdDqhPt2U/7L/wmbT26+EpySXU8oUx89ermqjaZ4nHfqazSugZ+
         D6nriAUICLmQ+TPzs6npcutnq9MqVT4ub9v3qdwk91W4xuB3PC/r15QkQ/n5Roed9U4A
         /s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYtnsrsBFcQTG1av2UWtN0kx27fKyWTq2Zrc2a2wfxM=;
        b=bVND8dLR9MlwsOJJWhlGuI8S8aDq3P99fo8a/k+Dl4e4g0fsI81aBctlfgXM8/Zjdr
         aGDPKc8/DdcWM5J+jJ5XjjZW4pXHWWPtv0l8JaDFvL34gP/bIcBRrGbQakE7KuyxJcM9
         tCyBfgY4byrqIOhDnQYySxXVK2iBfn1RAX8jbzOCGexKIJqneO+KCKNrWsfI9pFBdUW+
         5gUft0UB2bDhMcfI/bOiJcQHgX5P7XjdqHq5ZdCXVLsAWhaejjPqqQX5nQDPIovJPFB2
         1Sb/rifjLGIfK8b32qAkgpWpvdanIi8rGeH5jCCyBbQVoBJIsjqFl2MPp1LOMXh+Ridk
         iOTg==
X-Gm-Message-State: AFqh2krOLMjU+y47gTVKU6Z8HahrDM3QmRmWzHJsXbbyObKqrGiWgWnq
        uXeAHNkUEVwnboTptHv5xggwRmxHp2zlRGBL
X-Google-Smtp-Source: AMrXdXvXtfgms35hvbxnTMlL2x6vX9WQvhB7vGtTELGY8uA2FGUrxGYGG9l/PNJZQecbWUWbkD5EbA==
X-Received: by 2002:a05:6512:3b07:b0:4a4:68b9:60b4 with SMTP id f7-20020a0565123b0700b004a468b960b4mr7211308lfv.63.1672220309826;
        Wed, 28 Dec 2022 01:38:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi7-20020a0565120e8700b004b590c768edsm2582611lfb.1.2022.12.28.01.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 01:38:28 -0800 (PST)
Message-ID: <c0142eb6-aa46-a157-6a9a-9134c7e06ca2@linaro.org>
Date:   Wed, 28 Dec 2022 10:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: align OPP table node name with DT
 schema
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221225115844.55126-1-krzysztof.kozlowski@linaro.org>
 <20221225115844.55126-2-krzysztof.kozlowski@linaro.org>
 <Y6somGn+V0CAxVA5@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6somGn+V0CAxVA5@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 18:17, Johan Hovold wrote:
> On Sun, Dec 25, 2022 at 12:58:42PM +0100, Krzysztof Kozlowski wrote:
>> Bindings expect OPP tables to start with "opp-table".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi | 2 +-
>>  arch/arm64/boot/dts/qcom/sa8540p.dtsi      | 4 ++--
>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi     | 6 +++---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
>>  4 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
>> index 5728583af41e..929bdcd45d02 100644
>  
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 109c9d2b684d..89004cb657e0 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -33,7 +33,7 @@ sleep_clk: sleep-clk {
>>  		};
>>  	};
>>  
>> -	cpu0_opp_table: cpu0-opp-table {
>> +	cpu0_opp_table: opp-table-cpu0 {
>>  		compatible = "operating-points-v2";
>>  		opp-shared;
>>  
>> @@ -123,7 +123,7 @@ opp-2438400000 {
>>  		};
>>  	};
>>  
>> -	cpu4_opp_table: cpu4-opp-table {
>> +	cpu4_opp_table: opp-table-cpu4 {
>>  		compatible = "operating-points-v2";
>>  		opp-shared;
>>  
>> @@ -591,7 +591,7 @@ CLUSTER_PD: cpu-cluster0 {
>>  		};
>>  	};
>>  
>> -	qup_opp_table_100mhz: qup-100mhz-opp-table {
>> +	qup_opp_table_100mhz: opp-table-qup100mhz {
>>  		compatible = "operating-points-v2";
>>  
>>  		opp-75000000 {
> 
> Please also move these nodes after the 'memory' node so that they remain
> sorted by name.

OK

Best regards,
Krzysztof

