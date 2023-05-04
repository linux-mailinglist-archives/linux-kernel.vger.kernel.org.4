Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707BD6F71EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEDSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEDSYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:24:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DDD65BA
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 11:24:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13dafd5dcso981190e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683224650; x=1685816650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtqfJG9XZAvYGPjRD2BYn9iYen2bBzRVCEL7vD5oIOE=;
        b=qYuUGcPZsKzfhfCosajjCLQckRnY3Q2lmYbyhRW4xk+fPdHNgW6iQYoGupgZCoOFYV
         b3rP6jOskWZxxg37EkzlzuezizMzZgsrqLv2fyTUz6BBo1yR+TMqcexzCqSPu+wwTJ9L
         3n9p919Cd9VCDk0hTsrn9lu4bKZaaWklrUV8sD3cDuVIsQx99pT22AsWB3aV+plLYj0W
         RKETx3oxFf/ro0xtyfS+ik6sVn0WCEeW5X9QPp8fUaVKVKW9SQBdPxfp1CVa1nzbIovS
         OGQCaaqAQAW6k3w7Zr+xgw4J/P3BrotjLQ3irFqviVj+HL1VHOPE2VGwgjD8GJ4UvrJX
         PI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224650; x=1685816650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtqfJG9XZAvYGPjRD2BYn9iYen2bBzRVCEL7vD5oIOE=;
        b=cBqZq35w5gO0+8M3zziqWrXGbY+ikClB72tUZELs9VJdEFSEkROoa8sfrC8Vnr5X9R
         AUmDQNliWDoYu8bMYpUGb58TnCQF9VjYI/mKOPfar7EhWCDNS7na6XSzhhk+8nv1yN+p
         VJNc9voWbRwhAgakqx4wzaljr01FlnOJw8mWLj50OQmTzYBhO+NINn293wEkZ/3BA+z5
         Q5n8m0QONXYejv8Akzt3Mf9VEndaWOR0qwRyLkxJkviPSQ+izZwaPdxC0xWwDoUOW5ZR
         yq+k4Hb0/C7/nF65ZLzHZZjwwFX5aYatJ5EQcLACZsZRIhnso95seDWzXjqp0oYwvaW8
         ZImw==
X-Gm-Message-State: AC+VfDwKeCX8YbGpQnj0w4sa2v5yAhKqHVRMIFnMw0CQzfZyVV4CL/n/
        sFmNxg2YkC2U1xZ2Xfbaxl/VXg==
X-Google-Smtp-Source: ACHHUZ6w4EngR4UfCtJk7M/VtZ6f2bpSCU5YRXnYuTg544owIPA76YFd8OV6iAZ3qkWcU6GV1gXwBw==
X-Received: by 2002:a05:6512:92d:b0:4db:964:51b5 with SMTP id f13-20020a056512092d00b004db096451b5mr1916286lft.41.1683224650017;
        Thu, 04 May 2023 11:24:10 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i8-20020a056512006800b004edc9da63bdsm6647088lfo.160.2023.05.04.11.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 11:24:09 -0700 (PDT)
Message-ID: <7e82919d-2cfc-67e0-f096-026b259d1960@linaro.org>
Date:   Thu, 4 May 2023 21:24:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20230502160950.1758826-1-robdclark@gmail.com>
 <db8ef06b-a729-a085-8671-2b4d99a8e2b2@linaro.org>
 <CAF6AEGstOTfaKvmaAXbxvoNvs3odJBiASzmip8+x0FNqFoniKg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAF6AEGstOTfaKvmaAXbxvoNvs3odJBiASzmip8+x0FNqFoniKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 21:08, Rob Clark wrote:
> On Thu, May 4, 2023 at 10:41 AM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 2.05.2023 18:09, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> When the special handling of qcom,adreno-smmu was moved into
>>> qcom_smmu_create(), it was overlooked that we didn't have all the
>>> required entries in qcom_smmu_impl_of_match.  So we stopped getting
>>> adreno_smmu_priv on sc7180, breaking per-process pgtables.
>>>
>>> Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>> I believe the issue here is the lack of qcom,sc7180-smmu-v2 instead.
>>
>> qcom,adreno-smmu does not have to imply the "qcom smmu v2" impl
> 
> Yes, but the ordering after "qcom,smmu-500" does.  Currently we just
> need the one missing "qcom,sc7180-smmu-v2" but that seemed kind of
> fragile to me, which is why I went with "qcom,adreno-smmu" as a
> catch-all

I think, the order is not relevant when comparing compatible entries, 
see __of_match_node(). It uses scoring and the more specific compatible 
wins. This way, "qcom,adreno-smmu", "qcom,smmu-500" will always end up 
with the v2 ops instead smmu500. It was not included into the list 
intentionally, rather than being by omission.

Thus I'd also suggest adding "qcom,sc7180-smmu-v2" to the list, as we 
currently do for all SMMU_v2 devices.

> 
> BR,
> -R
> 
>>
>> Konrad
>>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> index d1b296b95c86..88c89424485b 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>> @@ -512,20 +512,25 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>>>        { .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
>>>        { .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
>>>        { .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
>>>        { .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>>>        { .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_500_impl0_data },
>>>        { .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_500_impl0_data },
>>>        { .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
>>>        { .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>>>        { .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
>>>        { .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
>>> +     /*
>>> +      * Should come after the qcom,smmu-500 fallback so smmu-500 variants of
>>> +      * adreno-smmu get qcom_adreno_smmu_500_impl:
>>> +      */
>>> +     { .compatible = "qcom,adreno-smmu", .data = &qcom_smmu_v2_data },
>>>        { }
>>>   };
>>>
>>>   #ifdef CONFIG_ACPI
>>>   static struct acpi_platform_list qcom_acpi_platlist[] = {
>>>        { "LENOVO", "CB-01   ", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU" },
>>>        { "QCOM  ", "QCOMEDK2", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU" },
>>>        { }
>>>   };
>>>   #endif

-- 
With best wishes
Dmitry

