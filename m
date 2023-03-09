Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE216B2ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCIUoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCIUof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:44:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4AE4D9A;
        Thu,  9 Mar 2023 12:44:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso4561828wmi.4;
        Thu, 09 Mar 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678394672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVtA0szOzlSxA7hBFXlpEM2woHDqUenX5IOAizRgRcs=;
        b=GlwsIP48uDQWtfvn9cNPbIr8U26dC6/9nKd4Lop3RM5EYAUP0TI3oYUHo5FDYOQsjQ
         0l173tWlpaeO2DPJNWpQd5tvHN02KJ1HxZ3DZPg0GylQOl8wzXJkGWDjDajUzBLbOz2F
         2YYwlEZhtYU/p5PbX8JQSFxiF29OXWuxwESAWCuquscfdRkdjxLJlFlUVPH0LTVV7qYC
         VKrsyPJn4KZJ/M9TDlYjxCN0vKJYTeWwWe8tq63s0xYz+aVTZf+edbrn9qsLhPfkJKCr
         u9QuN6MfcJssO9z/uQz3WlZuOkLHMhYVzU1bcnhqdozhzgBWLhR04WwsAWkl2yQQz7DM
         +hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678394672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVtA0szOzlSxA7hBFXlpEM2woHDqUenX5IOAizRgRcs=;
        b=15Pf1pfLydQ7MiNfbPkK3JSWck1MWxFCa1YLz8HR1e4boLo9LOrYCEfq11Jqydhs5/
         tM5W51/1XQOh3m7iEXlcW0slOJbQ0htPIScQv3sJ/DZS9b7+H4CPHMg/fOpalAy+pTQ5
         JWZMBPt3TtxGK+8RwC9/EZWtcsXhtkPi5z2YgQmxsCxoPlzNaD0bFBKXjDqEJQf5Rk4P
         vmHcBddhPbSqcT/kMm5XlVGWjKdy6v0NmcBUxgmVFX+Of1nHfRx3UAZy/HW9SqcAQloq
         bqlnPxHOlabX3vxiLs+X9JzkbF/N0/fpy4vFFlUV4v8wuiIgPThhcNZMek9UM4O/oFGo
         yhIA==
X-Gm-Message-State: AO0yUKXFCkIVqtXNXL29sQPsClAf7DjYNR6wdXDaOTuQUiGPCaH5pXZc
        FTtPBPr+/gxq6bUNoawkpOE=
X-Google-Smtp-Source: AK7set8ZvUun/jOFrgcVnN+Ls6q+Pz4VHUrmMb5DZUfmZrtZQeUCyh7o+0GMuGm7CRQLhDcpD+bOdA==
X-Received: by 2002:a05:600c:1d9b:b0:3eb:39e2:9156 with SMTP id p27-20020a05600c1d9b00b003eb39e29156mr512721wms.5.1678394672147;
        Thu, 09 Mar 2023 12:44:32 -0800 (PST)
Received: from [10.23.0.3] ([194.126.177.54])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b003e214803343sm915319wmq.46.2023.03.09.12.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 12:44:31 -0800 (PST)
Message-ID: <657738b5-ef8e-fc38-8708-c7c26f146a7d@gmail.com>
Date:   Thu, 9 Mar 2023 21:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/4] firmware: Add support for Qualcomm UEFI Secure
 Application
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
 <20230305022119.1331495-5-luzmaximilian@gmail.com>
 <2eb4abde-579f-94ef-b6c3-81ef197329d0@linaro.org>
 <ff2eee7b-e683-9a7a-ea22-eff0f6b59900@gmail.com>
 <1583219b-61ad-ba57-470e-0a8202cbe277@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <1583219b-61ad-ba57-470e-0a8202cbe277@linaro.org>
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

On 3/9/23 09:36, Dmitry Baryshkov wrote:
> On 08/03/2023 17:02, Maximilian Luz wrote:
>> On 3/7/23 16:51, Dmitry Baryshkov wrote:
>>> On 05/03/2023 04:21, Maximilian Luz wrote:
>>>> On platforms using the Qualcomm UEFI Secure Application (uefisecapp),

[...]

>>
>> As I've elaborated on a previous version: I'm a bit wary of using
>> qseecom_app_get_id() in this way, since the Windows driver I've got this from
>> expects the app to be present when calling that function. So I don't know much
>> about the failure cases, especially when it isn't present.
>>
>> At this point, I'm just assuming that "res.status != QSEECOM_RESULT_SUCCESS"
>> means the app isn't present, but I don't know whether this can fail in other
>> ways. For a proper detection system I'd prefer if we can differentiate between
>> "some internal failure" and "not-present" cases.
> 
> Please take a look at https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/KERNEL.PLATFORM.1.0.r1-13000-kernel.0/drivers/misc/qseecom.c#L2683
> 
> Note, the driver supports loading and unloading applications, we can ignore that for now.
>

Thanks! That looks quite helpful.

[...]

>>>> +static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const efi_char16_t *name,
>>>> +                       const efi_guid_t *guid, u32 *attributes,
>>>> +                       unsigned long *data_size, void *data)
>>>> +{
>>>> +    struct qsee_req_uefi_get_variable *req_data;
>>>> +    struct qsee_rsp_uefi_get_variable *rsp_data;
>>>> +    struct qseecom_dma dma_req;
>>>> +    struct qseecom_dma dma_rsp;
>>>> +    unsigned long name_size = utf16_strsize(name);
>>>> +    unsigned long buffer_size = *data_size;
>>>> +    unsigned long size;
>>>> +    efi_status_t efi_status;
>>>> +    int status;
>>>> +
>>>> +    /* Validation: We need a name and GUID. */
>>>> +    if (!name || !guid)
>>>> +        return EFI_INVALID_PARAMETER;
>>>> +
>>>> +    /* Validation: We need a buffer if the buffer_size is nonzero. */
>>>> +    if (buffer_size && !data)
>>>> +        return EFI_INVALID_PARAMETER;
>>>> +
>>>> +    /* Compute required size (upper limit with alignments). */
>>>> +    size = sizeof(*req_data) + sizeof(*guid) + name_size  /* Inputs. */
>>>> +           + sizeof(*rsp_data) + buffer_size              /* Outputs. */
>>>> +           + 2 * (QSEECOM_DMA_ALIGNMENT - 1)              /* Input parameter alignments. */
>>>> +           + 1 * (QSEECOM_DMA_ALIGNMENT - 1);             /* Output parameter alignments. */
>>>
>>> Do we need to pack everything into a single DMA buffer? Otherwise it would be better to add qseecom_dma_alloc_aligned function, which will take care of the alignment for a single data piece.
>>
>> It may be possible to split this into two buffers, one for input and one for
>> output, but packing of input parameters would still be required (see the
>> assignments to req_data below).
>>
>> For the input, you essentially provide one buffer (address) to qseecom,
>> starting with req_data describing the layout in it. This description is
>> offset-based, so there's no way to specify multiple addresses/buffers as input.
>> The output behaves similarly, it's just the secure OS that does the packing.
>>
>> And since we already have to take care of aligning the input parameters, I'm
>> not sure that it makes sense to split this into two.
> 
> I see, thanks for the explanation. Maybe you can add a wrapping call that will take the sizes of required arguments (as a variadic array?) and will return prepared req and all the pointers and/or offsets? I think that having to specify these alignment 'extras' is errror prone.

I'll give that a try.

[...]

>>>> +static int qcom_uefisecapp_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct qcuefi_client *qcuefi;
>>>> +    int status;
>>>> +
>>>> +    /* Allocate driver data. */
>>>> +    qcuefi = devm_kzalloc(&pdev->dev, sizeof(*qcuefi), GFP_KERNEL);
>>>> +    if (!qcuefi)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    qcuefi->dev = &pdev->dev;
>>>> +
>>>> +    /* We expect the parent to be the QSEECOM device. */
>>>> +    qcuefi->qsee = dev_get_drvdata(pdev->dev.parent);
>>>> +    if (!qcuefi->qsee)
>>>> +        return -EINVAL;
>>>> +
>>>> +    /* Get application id for uefisecapp. */
>>>> +    status = qseecom_app_get_id(qcuefi->qsee, QSEE_UEFISEC_APP_NAME, &qcuefi->app_id);
>>>> +    if (status) {
>>>> +        dev_err(&pdev->dev, "failed to query app ID: %d\n", status);
>>>> +        return status;
>>>> +    }
>>>> +
>>>> +    /* Set up DMA. One page should be plenty to start with. */
>>>
>>> one page?
>>
>> The driver I've reverse-engineered this from allocates the DMA memory for
>> interaction with qseecom in multiples of PAGE_SIZE. I'm following that in this
>> driver, as I don't know whether that's a hard requirement (at least on some
>> platforms) or not. So I pre-allocate one page (1x PAGE_SIZE bytes) here. But as
>> you've mentioned above, it might be better to allocate this on-demand in each
>> call.
> 
> Probably the comment was misplaced. It talks about 1 page, but it is placed right before a call to dma_set_mask rather than dma_alloc.

Ah, it was intended for both the dma_set_mask() and the qseecom_dma_alloc()
below. I see how that is a bit confusing, will fix that.

>>>> +    if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
>>>> +        dev_warn(&pdev->dev, "no suitable DMA available\n");
>>>> +        return -EFAULT;
>>>> +    }
>>>> +
>>>> +    status = qseecom_dma_alloc(&pdev->dev, &qcuefi->dma, PAGE_SIZE, GFP_KERNEL);
>>>> +    if (status)
>>>> +        return status;
>>>> +

[...]

Regards
Max
