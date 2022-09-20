Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAB05BE0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiITI5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiITI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:57:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660758DCA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:57:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f193so1946052pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=62nVa40ZgGMYjJOOlAI4o87s1b9LqZFjm9xnCLFUbvc=;
        b=NEMmqTq31r2QpI2ZRcIyZyhgXAHH9l4S3mGhKI8c/Q8b66B2u814setloKdYDaPIGc
         WwLEgcDZNVlVJqsIo3Jopr29HIJJVDoKV/fAUtsyr3U9c2kkQW06VfQ9PojhS4KfnN6w
         3zIUSUPQiVT3cbyoc74+eKYH86N/DH2iH4f/X7xHzid5td8ruG3joOR6eP3FF8G7Ij8x
         rIjmth3R2ScdLU88OapbZC2e/u+RmoBH3jT6Q+pB9tbCpHqGTdqmY0OVslKMyW9l/caq
         eY31xBb2B8w4RFGCnosC6lxthUstlQ/ctbkD0m5I8t727FBgJqodqdYZ2jg/sFNjeJ83
         8OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=62nVa40ZgGMYjJOOlAI4o87s1b9LqZFjm9xnCLFUbvc=;
        b=35kPvfcdYSG/K5IUxyUcKKHPtLUsJiYZqMPNXGJZwOL8GxOsBoxk4tSB20n3kp03Tt
         qJgMKJmF4MZWUZWnOxXvRfZKh8la1QK0S3+1iTaluN7LUowOMEMgY7Y2NkSWrKAgFmcT
         ESHbIXFD+/3wsL1iMoo5paes4cW9oHUi2rYgW+TE+nTCKBnTufL019jVFOxzsJ1az7jq
         FxxoRmPtBPiw7RCKED1WWwXqQda7FTfP9JHVvJiRHbAZVA8lKwoOlaEryy9j5RkH3Q0m
         rAKo0U8xbA0luuIgGXeb2gj0fLb1OzR88spspo3mZPoBmkeauM32MvUo+uo6fHNL3BY4
         ja2g==
X-Gm-Message-State: ACrzQf2UQkFUp+rTBPO6CHnBvfsmZsiy8Mz3Y793a5g/+mrcUFf+mHH9
        FPJDrM5iNcMg418O88W+WRfNGw==
X-Google-Smtp-Source: AMsMyM7Rr/Tecs9HYOp6ZvDf4OofcbojhnBBOkN9Z0yk1HDWy8EfRKnztxVftinUplcBgYX4yC5UOw==
X-Received: by 2002:a05:6a00:2290:b0:541:f19:5197 with SMTP id f16-20020a056a00229000b005410f195197mr22914753pfe.42.1663664246714;
        Tue, 20 Sep 2022 01:57:26 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c61:6535:ca5f:67d1:670d:e188? ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b0017837d30a8csm847720plb.254.2022.09.20.01.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:57:26 -0700 (PDT)
Message-ID: <00dd028f-d636-0cda-40ce-01d5addcbec9@linaro.org>
Date:   Tue, 20 Sep 2022 14:27:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 1/4 RESEND] ARM: dts: qcom: Use new compatibles for
 crypto nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, Jordan Crouse <jorcrous@amazon.com>
References: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
 <20220919221509.1057574-2-bhupesh.sharma@linaro.org>
 <bb577304-f048-8fd5-fc7a-47a0897ba792@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <bb577304-f048-8fd5-fc7a-47a0897ba792@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/22 12:55 PM, Krzysztof Kozlowski wrote:
> On 20/09/2022 00:15, Bhupesh Sharma wrote:
>> Since we are using soc specific qce crypto IP compatibles
>> in the bindings now, use the same in the device tree files
>> which include the crypto nodes.
>>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-ipq4019.dtsi   | 2 +-
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
>>   arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi  | 2 +-
>>   5 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> index b23591110bd2..9c40714562d5 100644
>> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
>> @@ -314,7 +314,7 @@ cryptobam: dma-controller@8e04000 {
>>   		};
>>   
>>   		crypto: crypto@8e3a000 {
>> -			compatible = "qcom,crypto-v5.1";
>> +			compatible = "qcom,ipq4019-qce";
> 
> There are few issues here:
> 1. Compatible is not documented.

Its documented here: 
https://lore.kernel.org/linux-arm-msm/30756e6f-952f-ccf2-b493-e515ba4f0a64@linaro.org/

[as mentioned in the dependency section in the cover letter :)]

> 2. Compatible is not supported by old kernel - ABI break.
> 3. Everything won't be bisectable...

I think its a question of dependencies b/w the patchsets intended for
separate areas. Let me think more on how, I can resolve it in newer
versions.

Thanks,
Bhupesh



> The same in other places.
> 
> Best regards,
> Krzysztof
