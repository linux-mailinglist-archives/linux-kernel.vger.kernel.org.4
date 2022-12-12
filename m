Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172F649D7B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiLLLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiLLLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:22:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A990A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:21:56 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so17947123lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glTvLRuHC4ZX/EsgPrtjqzGC7be65qHZLQLtVcgtfKE=;
        b=pjU6j75Dgm4RKGxIji8QeCGgIVlHl3X9VAPJf5VvKd4eR0fVmP/9l73xwbirrMqKun
         /p7Q1ETyZIHgzg0D90mr+T8mCdoDEbeUr6ZwhvIQ0JssdUlhV8Z/S/9D+KD37mIwfm25
         0buyzJSfiq+EUspLwgY817cYeGdTUsv/7VZm9yJt3NFPTTetcAzOQREQFucuFI2eNgg3
         8UFc304tzX6W7ALm3Bpj07cawN498+2gLk/30pzkNzkA46+tYe0HXRg8J9TY51+dBsel
         wgU+rOZM3PgURWQIZQ0kerdoFvFShqeno/1zmQvfIB2yK54wQGbNmnTBnmlAIaJ4K/p5
         qY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glTvLRuHC4ZX/EsgPrtjqzGC7be65qHZLQLtVcgtfKE=;
        b=zsU8bdz73hZMC3/yjON21Kyl3fkCE1RabGbq0TFdFvEKeOaIqfLhJn/ByNoykzKWqn
         iUpkLakH9h8bJox6hBHLYTNbQPd6PAuZr7BD6iJozKrm/S4x6hzoeGHDda9zIos7r4Zn
         /ZXt6Wk5q7Oa19k6pADylDKpyM7Aqhh0zBWgs/P39mlzsWUimqQ7k1IFG7poxGp45oCl
         NYa3dGYeYEYG+KC54l1w6PtHXeM5jbYtLg121vLpAvvybcHvUStLei4a1I76C2Tdzxau
         NzmdV+NNfohGyvDsgafkPF4KdwOlGUf7BokOipn5Oiru+k6YLeGM2lff9pA+OsCOZyDi
         Yd8w==
X-Gm-Message-State: ANoB5pntWAmNuEVwctNJj3N3LKpxxfPKCGWzcGA/lflTfIU8mn927vJi
        5T/7+pVYPfi413J1lw7KCFDqMK0p8duXU/qz
X-Google-Smtp-Source: AA0mqf4xh1Suym2+rM2PZHE1O5sparKm3e/R6efWN5I9I4+nFbvi3+H7dif7UWMb1bOBaNGfbvaxPQ==
X-Received: by 2002:ac2:4950:0:b0:4b5:7925:870d with SMTP id o16-20020ac24950000000b004b57925870dmr3819266lfi.12.1670844114618;
        Mon, 12 Dec 2022 03:21:54 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id g14-20020a0565123b8e00b004b4fefacd89sm1586129lfv.139.2022.12.12.03.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 03:21:54 -0800 (PST)
Message-ID: <c0145eca-5cdd-4600-89e1-00c0fd8b22ef@linaro.org>
Date:   Mon, 12 Dec 2022 12:21:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221212100617.18190-1-konrad.dybcio@linaro.org>
 <552EFDD5-4BBE-408D-90EA-C96F4A0876B7@linaro.org>
 <57d3ba20-f1de-d7f3-d689-b25a02174379@linaro.org>
 <CAC2A315-5861-4324-849D-3EBF793146EA@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAC2A315-5861-4324-849D-3EBF793146EA@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.12.2022 12:20, Dmitry Baryshkov wrote:
> 
> 
> On 12 December 2022 14:00:10 GMT+03:00, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>> On 12.12.2022 11:58, Dmitry Baryshkov wrote:
>>>
>>>
>>> On 12 December 2022 13:06:16 GMT+03:00, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>> From: Marijn Suijten <marijn.suijten@somainline.org>
>>>>
>>>> Add the SM8150 DPU compatible to clients compatible list, as it also
>>>> needs the workarounds.
>>>
>>> Please rebase on top of linux-next, this part was rewritten.
>> This one wasn't, but yeah it is based on some local changes
>> (see 6350/6375)..
> 
> It was,
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c?h=next-20221208#n498
We're not looking at the same thing, this patch adds a compatible
for 8150's mdss so that it can be matched as a client, not a
compatible for the SMMU itself (which itself has been merged
dinosaur years ago).

Konrad
> 
>>
>> Konrad
>>>
>>>
>>>>
>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> Depends on the binding here:
>>>>
>>>> [1] https://lore.kernel.org/linux-arm-msm/20221212093315.11390-1-konrad.dybcio@linaro.org/T/#t
>>>>
>>>> drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index 6610f5d2877d..cd74c1efcfde 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>>> 	{ .compatible = "qcom,sdm845-mss-pil" },
>>>> 	{ .compatible = "qcom,sm6350-mdss" },
>>>> 	{ .compatible = "qcom,sm6375-mdss" },
>>>> +	{ .compatible = "qcom,sm8150-mdss" },
>>>> 	{ .compatible = "qcom,sm8250-mdss" },
>>>> 	{ }
>>>> };
>>>
> 
