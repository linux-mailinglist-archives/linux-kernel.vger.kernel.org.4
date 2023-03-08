Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840FE6B0A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjCHOBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjCHOBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:01:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03D4559CC;
        Wed,  8 Mar 2023 05:59:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p26so9851904wmc.4;
        Wed, 08 Mar 2023 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678283980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26JRsQbm8LklpGgTHZk/N66FsR+GeBLWZuEGhgsGUwk=;
        b=p5uzC325NbrV4IPvJDKa8wbAU5VpPu77CJW86xuFYddoyuzih6rHfOxP5ioMHhPBA0
         tBHFwJR0+fpLqjJMN6SpZahgJV4cZImJt7P99kNYHt7iWSybuIPQf99Rke5kLtitSQQu
         IwmrHq0cAab45bjb5447GBdBgqzyUprsRfK+2Bvp0fIx3MqrB8uM3gyVE1WGmgdoVEtA
         W8NxD5WVIgIDafCvp6QyVR5bsgxG6NuHEyCvtZX6rx+6kI9YorSZkmf1cXhgiwda7ncs
         A0XoYOfUq0INkqNJC8vprAC9Ll1JZTQUrTwiz6EqUDQQcEAdSzwe5Yvdy8fSnvsm6vwj
         NvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26JRsQbm8LklpGgTHZk/N66FsR+GeBLWZuEGhgsGUwk=;
        b=qRIs/v7ErRe81bbJbtmwDvodkRli3y1Twdb8g+p9ChWWdi4AKMbRM/k2i3nhwQIpn+
         CY/TjGvxhEAmxNaFiNE/FdpwPY4orq421C6DazP9K4bWzLDVpuGgjsY9+rU+9J0DhqUE
         R915CoKM5bpy/roJCpyvLOVkQdRj9newkU+FYy/f5Wj5XV88LYw5jKZPz3NhOuM6p3fb
         J0YEzFXY94uwsdf4aUQgVSrYcd8Djrv4cXg6yuNED4kpfHqd4/RS+4RLmasi88GNW2ye
         pronJH91YiOzBmwzF2aPm7tVo92jdt+rVfJJg0b0CLEwCN8xQV0sKp72f8E9mfPtjkVf
         VUqw==
X-Gm-Message-State: AO0yUKV8wn29gEQAjU3ncFloswGWA/NTgF1XT2P6ZXBNgQ+193vISOFq
        u427p78OG6wCY4iXQpdDb4I=
X-Google-Smtp-Source: AK7set9jWxQwohKUg0VMQGvHSKNeuRt3lE+H+gDDIqupEr1qrzG0tc2S1P2gagh5jGICDfIUvTvdmQ==
X-Received: by 2002:a05:600c:46ce:b0:3eb:383c:187d with SMTP id q14-20020a05600c46ce00b003eb383c187dmr16485464wmo.27.1678283980349;
        Wed, 08 Mar 2023 05:59:40 -0800 (PST)
Received: from [10.28.0.5] ([194.126.177.75])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b002c7066a6f77sm15144142wri.31.2023.03.08.05.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:59:39 -0800 (PST)
Message-ID: <fa9cfc41-1d6c-1003-e6d9-6a1545487177@gmail.com>
Date:   Wed, 8 Mar 2023 14:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] firmware: Add support for Qualcomm Secure
 Execution Environment SCM interface
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <84e6cfd8-ee4b-a5f4-5249-d87df9909246@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/23 16:32, Dmitry Baryshkov wrote:
> On 05/03/2023 04:21, Maximilian Luz wrote:

[...]

>> +/* -- DMA helpers. ---------------------------------------------------------- */
>> +
>> +/* DMA requirements for QSEECOM SCM calls. */
>> +#define QSEECOM_DMA_ALIGNMENT        8
>> +#define QSEECOM_DMA_ALIGN(ptr)        ALIGN(ptr, QSEECOM_DMA_ALIGNMENT)
>> +
>> +/**
>> + * struct qseecom_dma - DMA memory region.
>> + * @size: Size of the memory region, in bytes.
>> + * @virt: Pointer / virtual address to the memory, accessible by the kernel.
>> + * @phys: Physical address of the memory region.
>> + */
>> +struct qseecom_dma {
>> +    unsigned long size;
> 
> size_t ?

Will fix.

>> +    void *virt;
>> +    dma_addr_t phys;
>> +};
> 
> Do we really need this wrapper and the wrappers bellow? They look like a pure syntax sugar for me, hiding the dma functions from the user.

The idea was that they take care of proper allocation. The Windows driver that
I've reverse-engineered this from allocates memory in multiples of PAGE_SIZE,
so I believe that this might be a requirement (at least on some systems). These
functions are there to ensure that and with that prevent potential bugs by
taking that responsibility from the caller.

>> +
>> +/**
>> + * qseecom_dma_alloc() - Allocate a DMA-able memory region suitable for QSEECOM
>> + * SCM calls.
>> + * @dev:  The device used for DMA memory allocation.
>> + * @dma:  Where to write the allocated memory addresses and size to.
>> + * @size: Minimum size of the memory to be allocated.
>> + * @gfp:  Flags used for allocation.
>> + *
>> + * Allocate a DMA-able memory region suitable for interaction with SEE
>> + * services/applications and the TzOS. The provided size is treated as the
>> + * minimum required size and rounded up, if necessary. The actually allocated
>> + * memory region will be stored in @dma. Allocated memory must be freed via
>> + * qseecom_dma_free().
>> + *
>> + * Return: Returns zero on success, -ENOMEM on allocation failure.
>> + */
>> +static inline int qseecom_dma_alloc(struct device *dev, struct qseecom_dma *dma,
>> +                    unsigned long size, gfp_t gfp)
> 
> size_t size
> 
> gfp is not used

Right, that should have been passed to dma_alloc_coherent(). Will fix that.

>> +{
>> +    size = PAGE_ALIGN(size);
>> +
>> +    dma->virt = dma_alloc_coherent(dev, size, &dma->phys, GFP_KERNEL);
>> +    if (!dma->virt)
>> +        return -ENOMEM;
>> +
>> +    dma->size = size;
>> +    return 0;
>> +}
>> +
>> +/**
>> + * qseecom_dma_free() - Free a DMA memory region.
>> + * @dev: The device used for allocation.
>> + * @dma: The DMA region to be freed.
>> + *
>> + * Free a DMA region previously allocated via qseecom_dma_alloc(). Note that
>> + * freeing sub-regions is not supported.
>> + */
>> +static inline void qseecom_dma_free(struct device *dev, struct qseecom_dma *dma)
>> +{
>> +    dma_free_coherent(dev, dma->size, dma->virt, dma->phys);
>> +}
>> +
>> +/**
>> + * qseecom_dma_realloc() - Re-allocate DMA memory region with the requested size.
>> + * @dev:  The device used for allocation.
>> + * @dma:  The region descriptor to be updated.
>> + * @size: The new requested size.
>> + * @gfp:  Flags used for allocation.
>> + *
>> + * Re-allocates a DMA memory region suitable for QSEECOM SCM calls to fit the
>> + * requested amount of bytes, if necessary. Does nothing if the provided region
>> + * already has enough space to store the requested data.
>> + *
>> + * See qseecom_dma_alloc() for details.
>> + *
>> + * Return: Returns zero on success, -ENOMEM on allocation failure.
>> + */
>> +static inline int qseecom_dma_realloc(struct device *dev, struct qseecom_dma *dma,
>> +                      unsigned long size, gfp_t gfp)
>> +{
>> +    if (PAGE_ALIGN(size) <= dma->size)
>> +        return 0;
>> +
>> +    qseecom_dma_free(dev, dma);
>> +    return qseecom_dma_alloc(dev, dma, size, gfp);
>> +}
> 
> I'll comment on this function when commenting patch 4.
> 
>> +
>> +/**
>> + * qseecom_dma_aligned() - Create a aligned DMA memory sub-region suitable for
>> + * QSEECOM SCM calls.
>> + * @base:   Base DMA memory region, in which the new region will reside.
>> + * @out:    Descriptor to store the aligned sub-region in.
>> + * @offset: The offset inside base region at which to place the new sub-region.
>> + *
>> + * Creates an aligned DMA memory region suitable for QSEECOM SCM calls at or
>> + * after the given offset. The size of the sub-region will be set to the
>> + * remaining size in the base region after alignment, i.e., the end of the
>> + * sub-region will be equal the end of the base region.
>> + *
>> + * Return: Returns zero on success or -EINVAL if the new aligned memory address
>> + * would point outside the base region.
>> + */
>> +static inline int qseecom_dma_aligned(const struct qseecom_dma *base, struct qseecom_dma *out,
>> +                      unsigned long offset)
>> +{
>> +    void *aligned = (void *)QSEECOM_DMA_ALIGN((uintptr_t)base->virt + offset);
>> +
>> +    if (aligned - base->virt > base->size)
>> +        return -EINVAL;
>> +
>> +    out->virt = aligned;
>> +    out->phys = base->phys + (out->virt - base->virt);
>> +    out->size = base->size - (out->virt - base->virt);
>> +
>> +    return 0;
>> +}
>> +
>> +
>> +/* -- Common interface. ----------------------------------------------------- */
>> +
>> +struct qseecom_device {
>> +    struct device *dev;
>> +    struct mutex scm_call_lock;    /* Guards QSEECOM SCM calls. */
> 
> There can be only one instance of the qseecom call infrastructure. Make this mutex static in the qcom_scm.c

Right, will do that.

>> +};
>> +
>> +
>> +/* -- Secure-OS SCM call interface. ----------------------------------------- */
>> +
>> +#define QSEECOM_TZ_OWNER_TZ_APPS        48
>> +#define QSEECOM_TZ_OWNER_QSEE_OS        50
>> +
>> +#define QSEECOM_TZ_SVC_APP_ID_PLACEHOLDER    0
>> +#define QSEECOM_TZ_SVC_APP_MGR            1
>> +
>> +enum qseecom_scm_result {
>> +    QSEECOM_RESULT_SUCCESS            = 0,
>> +    QSEECOM_RESULT_INCOMPLETE        = 1,
>> +    QSEECOM_RESULT_BLOCKED_ON_LISTENER    = 2,
>> +    QSEECOM_RESULT_FAILURE            = 0xFFFFFFFF,
>> +};
>> +
>> +enum qseecom_scm_resp_type {
>> +    QSEECOM_SCM_RES_APP_ID            = 0xEE01,
>> +    QSEECOM_SCM_RES_QSEOS_LISTENER_ID    = 0xEE02,
>> +};
>> +
>> +/**
>> + * struct qseecom_scm_resp - QSEECOM SCM call response.
>> + * @status:    Status of the SCM call. See &enum qseecom_scm_result.
>> + * @resp_type: Type of the response. See &enum qseecom_scm_resp_type.
>> + * @data:      Response data. The type of this data is given in @resp_type.
>> + */
>> +struct qseecom_scm_resp {
>> +    u64 status;
>> +    u64 resp_type;
>> +    u64 data;
>> +};
>> +
>> +int qseecom_scm_call(struct qseecom_device *qsee, const struct qcom_scm_desc *desc,
>> +             struct qseecom_scm_resp *res);
>> +
>> +
>> +/* -- Secure App interface. ------------------------------------------------- */
>> +
>> +#define QSEECOM_MAX_APP_NAME_SIZE            64
>> +
>> +int qseecom_app_get_id(struct qseecom_device *qsee, const char *app_name, u32 *app_id);
>> +int qseecom_app_send(struct qseecom_device *qsee, u32 app_id, struct qseecom_dma *req,
>> +             struct qseecom_dma *rsp);
> 
> I think that only these calls should be made public / available to other modules. qseecom_scm_call also is an internal helper.

So move all calls to qcom_scm and only make these two public? Or move only
qseecom_scm_call() to qcom_scm (which would require to make it public there,
however). Or how would you want this to look?

>> +
>> +#endif /* _LINUX_QCOM_QSEECOM_H */
> 

Regards,
Max
