Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10147118F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjEYVWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjEYVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:21:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70D7194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:21:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso2971746e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685049712; x=1687641712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qwF+6YmhKpd5O4hzeSwiBSwVBweFBRgPhoIl5cxfrA=;
        b=VluUz2iOOvo54ViyCpuvxDxaH48t843g64OULxgvGffC1LYxFpH91VShPBfP/VllSk
         GCgWSeSumTDYja7CKhYPv013Bi1IC3Rxv/P/8xo3JYbmTJT7Jq6NXf7OcBkeWFd1HMLg
         HUErYh6VjQaHIfI2UIV6DM8ednqT7l+4mljra6RSjzUB2ZT52DR5Z2LHUuoPk4hGjqch
         iJ0kUfwVLtys7/5YElCFAU6j+0fkPHpqT/A44Hj79ISlpuhkwzB7gcPtEtx2s01jrrvl
         V4mEOdiLGnq0kqNiNEdvrCvxjBSQmMAYpDAduryKOdvpdKCUGmVJXy0S4FNzhqeeHsBJ
         IZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685049712; x=1687641712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qwF+6YmhKpd5O4hzeSwiBSwVBweFBRgPhoIl5cxfrA=;
        b=J4b7qR89yyfSzZYUSat0UEZjCQ23LrFu7b7GHkwz9l/zuOz+vq0OWTyQCSrWwc5hau
         P+RtQ+hdEjgesSlsI1WAC78pChtKVoH95QxA3uzIDGB8LfnCFylgpBptQXktM/2NnGGi
         ppnZml7rBd8LFWBNEKIlhrxBLe0gDgJHrI2CG2Hh0l3rYsMYDcDkovNk75U5sKB3AXDL
         DceuUMse7h4TUywymDPFHKIysOhNnDlXKVGyd7If8uCH4YmVw5LhRmR2IOtOf31b8Lmu
         8G3DrTq+13RGa4M/6v4AGBvbcP+bXb/k3woB3vzEt5ybBHTRYy79K7Zg8rWMAm04SxiV
         KU0w==
X-Gm-Message-State: AC+VfDxcRswMJwUHxRgAUGp+MUGHs8ECrOhIbcBkMNSw8uWbfhUMaDks
        Jk4GG/7VITZs0RLRYAdQQpPJRQ==
X-Google-Smtp-Source: ACHHUZ51LLNtO14cSOcOqaN20tEI/aWs3buyxUaer4TFc/SL4yS+BO5rCkvIdsms6wfjf87pIb+2lg==
X-Received: by 2002:ac2:4c90:0:b0:4f1:95cf:11eb with SMTP id d16-20020ac24c90000000b004f195cf11ebmr5878506lfl.6.1685049711871;
        Thu, 25 May 2023 14:21:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id i4-20020a056512006400b004f13b59307asm334592lfo.232.2023.05.25.14.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 14:21:51 -0700 (PDT)
Message-ID: <af6f2b60-49f6-3622-7868-a2b3a6bd462f@linaro.org>
Date:   Thu, 25 May 2023 23:21:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/5] soc: qcom: smem: introduce qcom_smem_get_msm_id()
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, ilia.lin@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
References: <20230525120956.3095317-1-robimarko@gmail.com>
 <20230525120956.3095317-3-robimarko@gmail.com>
 <c4a50acd-2c0a-7c18-95d8-e9145fa1ff24@quicinc.com>
 <CAOX2RU72PFrdJoJfCGB-Q=V781WD6jEJomjkBeY9jsVPG6MOPQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAOX2RU72PFrdJoJfCGB-Q=V781WD6jEJomjkBeY9jsVPG6MOPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.05.2023 17:03, Robert Marko wrote:
> On Thu, 25 May 2023 at 14:59, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>>
>>
>> On 5/25/2023 5:39 PM, Robert Marko wrote:
>>> Introduce a helper to return the SoC SMEM ID, which is used to identify the
>>> exact SoC model as there may be differences in the same SoC family.
>>>
>>> Currently, cpufreq-nvmem does this completely in the driver and there has
>>> been more interest expresed for other drivers to use this information so
>>> lets expose a common helper to prevent redoing it in individual drivers
>>> since this field is present on every SMEM table version.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>> Changes in v3:
>>> * Change export to EXPORT_SYMBOL_GPL
>>> * Use an argument for returning SoC ID
>>> * Update kerneldoc
>>> ---
>>>   drivers/soc/qcom/smem.c       | 24 ++++++++++++++++++++++++
>>>   include/linux/soc/qcom/smem.h |  2 ++
>>>   2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>>> index bc98520c4969..185ed0da11a1 100644
>>> --- a/drivers/soc/qcom/smem.c
>>> +++ b/drivers/soc/qcom/smem.c
>>> @@ -14,6 +14,7 @@
>>>   #include <linux/sizes.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/soc/qcom/smem.h>
>>> +#include <linux/soc/qcom/socinfo.h>
>>>
>>>   /*
>>>    * The Qualcomm shared memory system is a allocate only heap structure that
>>> @@ -772,6 +773,29 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>>>   }
>>>   EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>>>
>>> +/**
>>> + * qcom_smem_get_msm_id() - return the SoC ID
>>> + * @id:      On success, we return the SoC ID here.
>>> + *
>>> + * Look up SoC ID from HW/SW build ID and return it.
>>> + *
>>> + * Return: 0 on success, negative errno on failure.
>>> + */
>>> +int qcom_smem_get_msm_id(u32 *id)
>>
>>
>> I think, MSM  is not the only platform which will leverage this API.
>> qcom_smem_get_soc_id() / qcom_smem_get_cpu_id() would make more sense
>> than qcom_smem_get_msm_id() ?
> 
> I agree, qcom_smem_get_soc_id() sounds better to me as its not just MSM parts.
>>
>>
>>> +{
>>> +     size_t len;
>>> +     struct socinfo *info;
>>> +
>>> +     info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
>>
>>
>> len is unused after this, can we just pass NULL? Did a quick check on
>> the code, if we pass the address, size of the item will be updated, else no.
> 
> Yes, indeed passing NULL works here for the simple case this helper is handling.
> Will address in v4.
Please also consider Bjorn's suggestion of using PTR_ERR

Konrad
> 
> Regards,
> Robert
>>
>>
>>> +     if (IS_ERR(info))
>>> +             return PTR_ERR(info);
>>> +
>>> +     *id = info->id;
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(qcom_smem_get_msm_id);
>>> +
>>>   static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>>>   {
>>>       struct smem_header *header;
>>> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
>>> index 86e1b358688a..cb204ad6373c 100644
>>> --- a/include/linux/soc/qcom/smem.h
>>> +++ b/include/linux/soc/qcom/smem.h
>>> @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
>>>
>>>   phys_addr_t qcom_smem_virt_to_phys(void *p);
>>>
>>> +int qcom_smem_get_msm_id(u32 *id);
>>> +
>>>   #endif
