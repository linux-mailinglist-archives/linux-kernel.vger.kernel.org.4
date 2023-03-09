Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA46B1E85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCIIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCIIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:45:54 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A645C13F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:45:51 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s22so1302082lfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F54gfgbPklTu2py/9aI/2w0PbtYlKXXyzesasenBUDk=;
        b=eAJLvRPUzBtGYU3gVMcuZpXJ1nip8dTU5GaESZGJGEBQHC643xrsaNqW3DbxVNcyXO
         fiwg2IomRD+G9OFVlBwPQhTWRtTgxIxPKWnjow3ytIQHBHakBVkZAguW/KmKBhNYvwFN
         4RhEAqjIXH+u2fCEQsX5TzwXmnjsAS9TNRO8E8v6YcvWsJJdnvYLM9AiCzTIYzRo0OFL
         U2wAUTRaAYbdwAOKuCMkMg1+Y/L0VaZGRyFunFOHxXqRcDnKZwTU9oyOb6aYk6tfQ+Lz
         oJb/54/7OygwxGkNBY/6Mehs9Qi0/CNcWwsyswvn1/aSdJS5zXIR5tVUH2cgnwNmCIRJ
         SPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F54gfgbPklTu2py/9aI/2w0PbtYlKXXyzesasenBUDk=;
        b=jxA92SMa/JQE4H8x+3lhIfJLfSgJ1Vl4kyjt0pcyA8eSG5kRShR3StgCI0OzaPmupC
         mYsOmLuj5b/Wd94bK/vNQ9es2EnW1PQwkXiqvDe7c2CjbHWXRpsgost5JoxsCo9DLSof
         iH33YvCmwlnNkk6UoGy9Stn2yzCClZU7UwjQzLyVd4fBfb1wJgfomrimqalK4zpuRS63
         EVafKwCdWQURcGmc/kqzaQcJP5CmkdXc1IN1DIBI4vKe7V5m9uEd6b7FPdNI3hlFJg9E
         IA0IaGOcINX5wSnX5VpCEpWqi6uSytSdFJaLaXDMwtv/8fOP+Vi8UYKvye9gLXRIIVQ6
         wlpA==
X-Gm-Message-State: AO0yUKUgM23jxyugRyt37P4xelbbHGUrodqRZCTAkq598mmgl4uy9Nzl
        K+G5yNErwr+Ozaji5GWWri7bDg==
X-Google-Smtp-Source: AK7set+P8qbsvSgtIi9ZGJk3lgiV250XEvE0beCWF/nX68x45Ulgg1JF/jpy/uRbpDLV8hbro6o3vw==
X-Received: by 2002:a19:7406:0:b0:4db:4fe8:fd0f with SMTP id v6-20020a197406000000b004db4fe8fd0fmr5643476lfe.25.1678351550221;
        Thu, 09 Mar 2023 00:45:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id j9-20020ac253a9000000b004d61af6771dsm2591705lfh.41.2023.03.09.00.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:45:49 -0800 (PST)
Message-ID: <98f20683-bb1d-47c2-18ca-f3de61c9a91f@linaro.org>
Date:   Thu, 9 Mar 2023 10:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] firmware: Add support for Qualcomm Secure
 Execution Environment SCM interface
Content-Language: en-GB
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-3-luzmaximilian@gmail.com>
 <84e6cfd8-ee4b-a5f4-5249-d87df9909246@linaro.org>
 <fa9cfc41-1d6c-1003-e6d9-6a1545487177@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <fa9cfc41-1d6c-1003-e6d9-6a1545487177@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 15:59, Maximilian Luz wrote:
> On 3/7/23 16:32, Dmitry Baryshkov wrote:
>> On 05/03/2023 04:21, Maximilian Luz wrote:
> 
> [...]
> 
>>> +/* -- DMA helpers. 
>>> ---------------------------------------------------------- */
>>> +
>>> +/* DMA requirements for QSEECOM SCM calls. */
>>> +#define QSEECOM_DMA_ALIGNMENT        8
>>> +#define QSEECOM_DMA_ALIGN(ptr)        ALIGN(ptr, QSEECOM_DMA_ALIGNMENT)
>>> +
>>> +/**
>>> + * struct qseecom_dma - DMA memory region.
>>> + * @size: Size of the memory region, in bytes.
>>> + * @virt: Pointer / virtual address to the memory, accessible by the 
>>> kernel.
>>> + * @phys: Physical address of the memory region.
>>> + */
>>> +struct qseecom_dma {
>>> +    unsigned long size;
>>
>> size_t ?
> 
> Will fix.
> 
>>> +    void *virt;
>>> +    dma_addr_t phys;
>>> +};
>>
>> Do we really need this wrapper and the wrappers bellow? They look like 
>> a pure syntax sugar for me, hiding the dma functions from the user.
> 
> The idea was that they take care of proper allocation. The Windows 
> driver that
> I've reverse-engineered this from allocates memory in multiples of 
> PAGE_SIZE,
> so I believe that this might be a requirement (at least on some 
> systems). These
> functions are there to ensure that and with that prevent potential bugs by
> taking that responsibility from the caller.

I see. As I wrote in another comment, it might be better to review the 
whole memory allocation system: pass required sizes, get the data filled.

> 
>>> +
>>> +/**
>>> + * qseecom_dma_alloc() - Allocate a DMA-able memory region suitable 
>>> for QSEECOM
>>> + * SCM calls.
>>> + * @dev:  The device used for DMA memory allocation.
>>> + * @dma:  Where to write the allocated memory addresses and size to.
>>> + * @size: Minimum size of the memory to be allocated.
>>> + * @gfp:  Flags used for allocation.
>>> + *
>>> + * Allocate a DMA-able memory region suitable for interaction with SEE
>>> + * services/applications and the TzOS. The provided size is treated 
>>> as the
>>> + * minimum required size and rounded up, if necessary. The actually 
>>> allocated
>>> + * memory region will be stored in @dma. Allocated memory must be 
>>> freed via
>>> + * qseecom_dma_free().
>>> + *
>>> + * Return: Returns zero on success, -ENOMEM on allocation failure.
>>> + */
>>> +static inline int qseecom_dma_alloc(struct device *dev, struct 
>>> qseecom_dma *dma,
>>> +                    unsigned long size, gfp_t gfp)
>>
>> size_t size
>>
>> gfp is not used
> 
> Right, that should have been passed to dma_alloc_coherent(). Will fix that.
> 
>>> +{
>>> +    size = PAGE_ALIGN(size);
>>> +
>>> +    dma->virt = dma_alloc_coherent(dev, size, &dma->phys, GFP_KERNEL);
>>> +    if (!dma->virt)
>>> +        return -ENOMEM;
>>> +
>>> +    dma->size = size;
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * qseecom_dma_free() - Free a DMA memory region.
>>> + * @dev: The device used for allocation.
>>> + * @dma: The DMA region to be freed.
>>> + *
>>> + * Free a DMA region previously allocated via qseecom_dma_alloc(). 
>>> Note that
>>> + * freeing sub-regions is not supported.
>>> + */
>>> +static inline void qseecom_dma_free(struct device *dev, struct 
>>> qseecom_dma *dma)
>>> +{
>>> +    dma_free_coherent(dev, dma->size, dma->virt, dma->phys);
>>> +}
>>> +
>>> +/**
>>> + * qseecom_dma_realloc() - Re-allocate DMA memory region with the 
>>> requested size.
>>> + * @dev:  The device used for allocation.
>>> + * @dma:  The region descriptor to be updated.
>>> + * @size: The new requested size.
>>> + * @gfp:  Flags used for allocation.
>>> + *
>>> + * Re-allocates a DMA memory region suitable for QSEECOM SCM calls 
>>> to fit the
>>> + * requested amount of bytes, if necessary. Does nothing if the 
>>> provided region
>>> + * already has enough space to store the requested data.
>>> + *
>>> + * See qseecom_dma_alloc() for details.
>>> + *
>>> + * Return: Returns zero on success, -ENOMEM on allocation failure.
>>> + */
>>> +static inline int qseecom_dma_realloc(struct device *dev, struct 
>>> qseecom_dma *dma,
>>> +                      unsigned long size, gfp_t gfp)
>>> +{
>>> +    if (PAGE_ALIGN(size) <= dma->size)
>>> +        return 0;
>>> +
>>> +    qseecom_dma_free(dev, dma);
>>> +    return qseecom_dma_alloc(dev, dma, size, gfp);
>>> +}
>>
>> I'll comment on this function when commenting patch 4.
>>
>>> +
>>> +/**
>>> + * qseecom_dma_aligned() - Create a aligned DMA memory sub-region 
>>> suitable for
>>> + * QSEECOM SCM calls.
>>> + * @base:   Base DMA memory region, in which the new region will 
>>> reside.
>>> + * @out:    Descriptor to store the aligned sub-region in.
>>> + * @offset: The offset inside base region at which to place the new 
>>> sub-region.
>>> + *
>>> + * Creates an aligned DMA memory region suitable for QSEECOM SCM 
>>> calls at or
>>> + * after the given offset. The size of the sub-region will be set to 
>>> the
>>> + * remaining size in the base region after alignment, i.e., the end 
>>> of the
>>> + * sub-region will be equal the end of the base region.
>>> + *
>>> + * Return: Returns zero on success or -EINVAL if the new aligned 
>>> memory address
>>> + * would point outside the base region.
>>> + */
>>> +static inline int qseecom_dma_aligned(const struct qseecom_dma 
>>> *base, struct qseecom_dma *out,
>>> +                      unsigned long offset)
>>> +{
>>> +    void *aligned = (void *)QSEECOM_DMA_ALIGN((uintptr_t)base->virt 
>>> + offset);
>>> +
>>> +    if (aligned - base->virt > base->size)
>>> +        return -EINVAL;
>>> +
>>> +    out->virt = aligned;
>>> +    out->phys = base->phys + (out->virt - base->virt);
>>> +    out->size = base->size - (out->virt - base->virt);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +
>>> +/* -- Common interface. 
>>> ----------------------------------------------------- */
>>> +
>>> +struct qseecom_device {
>>> +    struct device *dev;
>>> +    struct mutex scm_call_lock;    /* Guards QSEECOM SCM calls. */
>>
>> There can be only one instance of the qseecom call infrastructure. 
>> Make this mutex static in the qcom_scm.c
> 
> Right, will do that.
> 
>>> +};
>>> +
>>> +
>>> +/* -- Secure-OS SCM call interface. 
>>> ----------------------------------------- */
>>> +
>>> +#define QSEECOM_TZ_OWNER_TZ_APPS        48
>>> +#define QSEECOM_TZ_OWNER_QSEE_OS        50
>>> +
>>> +#define QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER    0
>>> +#define QSEECOM_TZ_SVC_APP_MGR            1
>>> +
>>> +enum qseecom_scm_result {
>>> +    QSEECOM_RESULT_SUCCESS            = 0,
>>> +    QSEECOM_RESULT_INCOMPLETE        = 1,
>>> +    QSEECOM_RESULT_BLOCKED_ON_LISTENER    = 2,
>>> +    QSEECOM_RESULT_FAILURE            = 0xFFFFFFFF,
>>> +};
>>> +
>>> +enum qseecom_scm_resp_type {
>>> +    QSEECOM_SCM_RES_APP_ID            = 0xEE01,
>>> +    QSEECOM_SCM_RES_QSEOS_LISTENER_ID    = 0xEE02,
>>> +};
>>> +
>>> +/**
>>> + * struct qseecom_scm_resp - QSEECOM SCM call response.
>>> + * @status:    Status of the SCM call. See &enum qseecom_scm_result.
>>> + * @resp_type: Type of the response. See &enum qseecom_scm_resp_type.
>>> + * @data:      Response data. The type of this data is given in 
>>> @resp_type.
>>> + */
>>> +struct qseecom_scm_resp {
>>> +    u64 status;
>>> +    u64 resp_type;
>>> +    u64 data;
>>> +};
>>> +
>>> +int qseecom_scm_call(struct qseecom_device *qsee, const struct 
>>> qcom_scm_desc *desc,
>>> +             struct qseecom_scm_resp *res);
>>> +
>>> +
>>> +/* -- Secure App interface. 
>>> ------------------------------------------------- */
>>> +
>>> +#define QSEECOM_MAX_APP_NAME_SIZE            64
>>> +
>>> +int qseecom_app_get_id(struct qseecom_device *qsee, const char 
>>> *app_name, u32 *app_id);
>>> +int qseecom_app_send(struct qseecom_device *qsee, u32 app_id, struct 
>>> qseecom_dma *req,
>>> +             struct qseecom_dma *rsp);
>>
>> I think that only these calls should be made public / available to 
>> other modules. qseecom_scm_call also is an internal helper.
> 
> So move all calls to qcom_scm and only make these two public? Or move only
> qseecom_scm_call() to qcom_scm (which would require to make it public 
> there,
> however). Or how would you want this to look?

I think we can make it with just these calls being public. Or even with 
just the second one being public and available to other drivers. If the 
app_id is a part of qseecom_app_device, we can pass that device to the 
qseecom_app_send(). And qseecom_app_get_id() becomes a part of app 
registration.

> 
>>> +
>>> +#endif /* _LINUX_QCOM_QSEECOM_H */
>>
> 
> Regards,
> Max

-- 
With best wishes
Dmitry

