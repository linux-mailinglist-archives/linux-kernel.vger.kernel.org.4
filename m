Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68946649E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiLLLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiLLLiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:38:55 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8659FF4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:34:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so18051269lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9GNjVU5sxMe9Q/VIxOWf6Z5lKsfx+IlGPy9pdhxemM=;
        b=O+Lw7JXSyl1E9PjF08XNf+Pcwhrglu/JueODn5sElY3v+LKw1UBjYSYcC/PRwD0akO
         rf1Dxxh25AdujQCMHYdHPvbwS66LMGcjouB2XypXocl6iOfPql7wWw8MoSf+DnkqJNNM
         uGhCHop//yArIYRHvd0fZFkSgFie/LT6aJv6MwaGcMmtYjZQ97aJszY4GrnSYH2Mlhtm
         uf8hV8xzJlGHmPnCeHiP3nXSiPiQMz6W0fZ/1az/op7FZJdsCN7vHNx9MLeXM1eaXCB6
         Ue6TTAd+dVOt6C3trExdA62FVfYRKAcY6dn0Tn0wbIOv4s1Tzs7ffk3FsyCx39k+ykVw
         fGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H9GNjVU5sxMe9Q/VIxOWf6Z5lKsfx+IlGPy9pdhxemM=;
        b=RMutvYQEvMUS0yVWJuDxLn7csLN884AXboHKr9SEs5+z3HwFLgMjTGT5iUn8pGGngT
         WNTftfl6gddivLzqaXuz3nhHjaw+iFZWzTbRaQAiHkpjTOx2OiB1q4jxjiTRFBDb7pFs
         6varKjPJ3jqmwCkNUkTA95RrEvn5Qs/PcqnT8v4QVxqg4Za9sd2fa+5bPpRc+h7FXgQl
         nb53D9UeqHkwv1cDtBMRYgufHFx5PFvPIhaSXsyEeaKWLek0UnNfTKaa69K96EoeNXC+
         nEDIj95rc2mbhn3ohuLEOhUsvoyCTLtBBtPOXsy+B8qDncZdJn4ZITRC0GVo7HKYlL+Y
         OjyA==
X-Gm-Message-State: ANoB5pn+K49lrDB4n5DO68Hnv5oFEYKDg7UsCndVCg0cUhXzWque+pAF
        9kpskoOIhkhni3QQpoMWP/dqvw==
X-Google-Smtp-Source: AA0mqf7+UAOn2V1OdU8uHl/pgi/QO5fTBszZ3Aa+FP8PGlUL1LJJiKOlsa9jZXt8QltRZYcvRHlpkg==
X-Received: by 2002:ac2:4305:0:b0:4b0:25f9:14ea with SMTP id l5-20020ac24305000000b004b025f914eamr3324056lfh.21.1670844836665;
        Mon, 12 Dec 2022 03:33:56 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id u9-20020ac258c9000000b004b59067142bsm1608166lfo.8.2022.12.12.03.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 03:33:56 -0800 (PST)
Message-ID: <aa60fcf8-5663-b2de-9d68-701dceeb493c@linaro.org>
Date:   Mon, 12 Dec 2022 12:33:54 +0100
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
 <72615A58-A0AB-4C3B-A97A-96144E391EBB@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <72615A58-A0AB-4C3B-A97A-96144E391EBB@linaro.org>
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



On 12.12.2022 12:27, Dmitry Baryshkov wrote:
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
> Stupid me, you are right here. This part wasn't changed. Please ignore the comment.
As I mentioned, it was accidentally right, as this doesn't apply
on plain next ^^

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
