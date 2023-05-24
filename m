Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6BD70FF80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjEXUyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEXUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:54:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770BE12F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:54:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3bb395e69so1489064e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684961642; x=1687553642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RghDh28+7g+TaguFQxnhYvL8i8BlC9jxTCIf1i/XiNU=;
        b=jm1uPR4NGQIKoPJlqVurWr93RpffzLVO8sirXr/usFhSwkmA2UR7Hyvx6vDagsOCdj
         8GPQxhuBS4l7I4KuG2msHW/8wBLGLzHlbhscsiKYDE63YhH6TtmuVS3Kf2Aji1Ww+25e
         aK5N3bjKrEgf2oklTSuSYKL2pwIGL8x6VitXDweQp1ybzjh3cXotbkFRz2y08NMTS77e
         Q2Q8r+SiDRzxVhSaFKXuzQLwOm+nHtdGzFdpssKTosxNh7tU9FW9jHLv5MSABegmBsjE
         g/xsLKHuRDXGrrHfYFySIqOmJfsizpPpM0sVclvPjc7nht/qUTqrxSSdVhb+rK/Pigs7
         wFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684961642; x=1687553642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RghDh28+7g+TaguFQxnhYvL8i8BlC9jxTCIf1i/XiNU=;
        b=B15j8IOEh8p7Cty3NEeo65a+bCHN8FmvHyCCxQn3j+dBxu2x/maFCqynxe2TJcFxKY
         q9VnaMcAjRMzPA3kC82K8xHvzsE4PeKC5GieaxEh1uZ19/fENFIIwrANNjTJMWzPy19F
         reJQQNzdlwPuPx0PE/8CiFabTFJryE1uIZFwCwyBDgcag/jc/e+8REw6cutBhbHvvgDp
         vGtl/UvuGLoTqd/wiTTIF1+kGohHawhNN9mx6ovYlb25WTdvRtl/eP45303BFbZ4cW+3
         j1Iprdz2huF71tArQiJuAPTxtKodnStlTmK/XWnvMh3ZyhzyWvDtQdS2qhVwxZSSknrx
         S2Rw==
X-Gm-Message-State: AC+VfDx+X910DdR3JLp9NIZcixvQe55kO7TNCa/UwKaekI1y0nW/YkNL
        lppnomfa7t5jfgWstWgJpbC4Hw==
X-Google-Smtp-Source: ACHHUZ6ykTSJV1djGpNWri0xeikO1g6KbWvJrrnGQsinyvFLuwSwswDJLWUnUa92++AD9z6FWaMkSw==
X-Received: by 2002:ac2:4118:0:b0:4ef:d742:4dfe with SMTP id b24-20020ac24118000000b004efd7424dfemr5119019lfi.65.1684961641679;
        Wed, 24 May 2023 13:54:01 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id p15-20020ac246cf000000b004f0c9120a41sm1824882lfo.214.2023.05.24.13.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 13:54:01 -0700 (PDT)
Message-ID: <d50f56c0-96a3-356b-3027-961108532109@linaro.org>
Date:   Wed, 24 May 2023 22:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] soc: qcom: smem: introduce qcom_smem_get_msm_id()
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230524162329.819770-1-robimarko@gmail.com>
 <20230524162329.819770-2-robimarko@gmail.com>
 <47c0faf0-f855-d3c4-6825-e51a1a1a7c83@quicinc.com>
 <d9406953-6452-2394-ab3f-4ce1d8986fce@linaro.org>
 <646e6c18.050a0220.12e7c.6043@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <646e6c18.050a0220.12e7c.6043@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.05.2023 21:57, Christian Marangi wrote:
> On Wed, May 24, 2023 at 08:27:03PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 24.05.2023 20:16, Trilok Soni wrote:
>>> On 5/24/2023 9:23 AM, Robert Marko wrote:
>>>> Introduce a helper to return the SoC SMEM ID, which is used to identify the
>>>> exact SoC model as there may be differences in the same SoC family.
>>>>
>>>> Currently, cpufreq-nvmem does this completely in the driver and there has
>>>> been more interest expresed for other drivers to use this information so
>>>> lets expose a common helper to prevent redoing it in individual drivers
>>>> since this field is present on every SMEM table version.
>>>>
>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>> ---
>>>>   drivers/soc/qcom/smem.c       | 19 +++++++++++++++++++
>>>>   include/linux/soc/qcom/smem.h |  2 ++
>>>>   2 files changed, 21 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>>>> index 6be7ea93c78c..0d6ba9bce8cb 100644
>>>> --- a/drivers/soc/qcom/smem.c
>>>> +++ b/drivers/soc/qcom/smem.c
>>>> @@ -14,6 +14,7 @@
>>>>   #include <linux/sizes.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/soc/qcom/smem.h>
>>>> +#include <linux/soc/qcom/socinfo.h>
>>>>     /*
>>>>    * The Qualcomm shared memory system is a allocate only heap structure that
>>>> @@ -772,6 +773,24 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>>>>   }
>>>>   EXPORT_SYMBOL(qcom_smem_virt_to_phys);
>>>>   +/**
>>>> + * qcom_smem_get_msm_id() - return the SoC ID
>>>> + *
>>>> + * Look up SoC ID from HW/SW build ID and return it.
>>>> + */
>>>> +int qcom_smem_get_msm_id(void)
>> On top of Trilok's point, this should return le32, or at least unsigned int.
>>
> 
> Mhhh why unsigned? We would lose error and qcom_smem_get can return all
> sort of errors. Also I think le32 is problematic as we are converting
> the value with __le32_to_cpu.
Hm right.. Qcom didn't really think this through then, but hopefully
they don't randomly jump from e.g. 547 to 1<<31

Konrad
> 
>>>> +{
>>>> +    size_t len;
>>>> +    struct socinfo *info;
>>>> +
>>>> +    info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
>>>> +    if (IS_ERR(info))
>>>> +        return PTR_ERR(info);
>>>> +
>>>> +    return __le32_to_cpu(info->id);
>>>> +}
>>>> +EXPORT_SYMBOL(qcom_smem_get_msm_id);
>>>
>>> EXPORT_SYMBOL_GPL please?
>>>
>>> Please change it for other symbols in the driver as well w/ separate patch.
>>>
>>> ---Trilok Soni
>>>
>>>
> 
