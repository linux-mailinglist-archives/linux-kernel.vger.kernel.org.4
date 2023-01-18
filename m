Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0C671CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjARNFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjARNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:05:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03DECFD17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:26:08 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mg12so10488909ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bw53AePccz141YFg2y0xxMG1R3GQx44WWI8acJWu1V8=;
        b=dzE60I79dcT2fVcg07c9ozKfm21j4Y/OcNMocl5P1TGzPV6jiqy/YIlqUhazeG8CHe
         N1TRz1yg89pIIj2TPuNdLdBd/2aXTTmsy62SrDoNlu/ha9BEVwHjmbmhBF30Ycwn6H2f
         Xi+kCiw8ChwTyVoOXCG7X0B5WlQUQDYAETrID0RPZx9F535Diabo/UPplxhnpW2ugvrQ
         XboVWyA5cErJWH0w7Z0wYQibcfwTjT8NXUQJm/0ePlCB812Lr9h7i0/pRTncs8viDh7N
         QD8GblIsWTk4bw5boWKmN1l6RwmCeRNkcDkcY7L7lOK1myFYoCXnVg1Fl6t1JHWh3tLw
         bt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw53AePccz141YFg2y0xxMG1R3GQx44WWI8acJWu1V8=;
        b=7Cr0BjHEW6fQiYEx3XIbeMD47FzgRUqi/QIA8UPpEb4qEpdsLmvDLdyuMql+2H771j
         Z5aUJWjx5zT6+V4L6RDnz9USZ519hXA/hMJz92dZwfB78n1/4BvfNNsGCNrici+6VLse
         iTxQ5qbRiUXiU6Yt9e9SaVHd7QC0E/6NTWJy699kqPf7C1VLPbzzHW/VtydQkRZ/sbbZ
         U9mDsqq4PfrKmTom73LabYTXwaWStfzfYZaTwrcJgWOZwoH6M5do2zytHlw4ItWwHwsP
         8poXqc/pVBsITo5RqFXBvqcmMSsgJ64FCxAVJ3uF4RsHFkvuxuIo4cdzsSfVPB56LSf1
         SvUQ==
X-Gm-Message-State: AFqh2kpbH1BxRZTKNZSrUr4IpBNLJbj8dfXMt8US4/vINzSXQAK2xD9s
        wuwa+5QmOE7WBsBtK9plfahGRA==
X-Google-Smtp-Source: AMrXdXusewrCLzYwnhOUkGVXsQgkPA/UUWIvvLrXMJ7BEodfXCEli+MoD1BHBQ/LVa5gBtfALs3z1Q==
X-Received: by 2002:a17:907:918f:b0:871:65a3:1726 with SMTP id bp15-20020a170907918f00b0087165a31726mr5903442ejb.42.1674044767229;
        Wed, 18 Jan 2023 04:26:07 -0800 (PST)
Received: from [192.168.1.101] (abxh252.neoplus.adsl.tpnet.pl. [83.9.1.252])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b00781dbdb292asm14582253ejc.155.2023.01.18.04.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:26:06 -0800 (PST)
Message-ID: <1dbfb913-95c3-c9c6-1797-e4d8387552ac@linaro.org>
Date:   Wed, 18 Jan 2023 13:26:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] regulator: dt-bindings: qcom-labibb: Allow
 regulator-common properties
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230116092502.71146-1-konrad.dybcio@linaro.org>
 <ee9ef65b-38c6-2283-b1e7-abf49abdccd6@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ee9ef65b-38c6-2283-b1e7-abf49abdccd6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.01.2023 09:51, Krzysztof Kozlowski wrote:
> On 16/01/2023 10:25, Konrad Dybcio wrote:
>> Allow regulator-common properties on lab/ibb regulators, such as
>> regulator-always-on, etc.
> 
> Are these proper regulators? If so this looks sensible. Why calling it
> RFC? What is here questionable?
I really had no idea if this was the proper way to do it, but
dt_bindings_check and CHECK_DTBS+example dt were happy..

> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/regulator/qcom-labibb-regulator.yaml           | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
>> index f97b8083678f..c0be7d5a6d40 100644
>> --- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
>> @@ -20,7 +20,8 @@ properties:
>>  
>>    lab:
>>      type: object
>> -    additionalProperties: false
>> +    $ref: "regulator.yaml#"
> 
> Drop quotes.
> 
>> +    unevaluatedProperties: false
>>  
>>      properties:
>>        qcom,soft-start-us:
>> @@ -46,7 +47,8 @@ properties:
>>  
>>    ibb:
>>      type: object
>> -    additionalProperties: false
>> +    $ref: "regulator.yaml#"
> 
> Drop quotes.
Ack x2

Konrad
> 
>> +    unevaluatedProperties: false
>>  
>>      properties:
>>        qcom,discharge-resistor-kohms:
> 
> Best regards,
> Krzysztof
> 
