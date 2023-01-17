Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D650966E7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjAQUj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjAQUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:35:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745269025
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:21:06 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 203so4708150iou.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vIhLbztM/35vA7EkIuAply1n/gr+A/gxbpqqXiig2iI=;
        b=YP+80c+2+bfoYeiZ+D1yzWG17y1TcDmCjHAYIhLZGs8SbY8IBQDmKipU/+qp4L/535
         w0ROGb6RPVmzWDWi/e4YRTh3nc3BTTNaXGe2eaWAvdJ/PHhULvTEZRs8D2y9qpAgO6RU
         mPRbqTqErqmdMjrDB7L7RfjE1S3uxEAxLKj0D/uZRoJKyZWNZygUMbXecu5y1VEA8o9Z
         Iez6RU0Axj8nF/4Uph0kWRNrqBKKIWDENddHW5swPZc6yvVztB2uGSWtxtgfCWzcJxf7
         7a9OZn4AHbKznPrxibwOSCZF0GxIV20YK5hDFlszP5A+3kJYLxGCnfIBlFf5kJhbZesl
         CDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIhLbztM/35vA7EkIuAply1n/gr+A/gxbpqqXiig2iI=;
        b=xWa4QQx/M9AjPfZaXdL14336clD/23Zl19SEbdcD2uRxHCIB4HHhhs7cbxdRJl6ybc
         nHqcitKEvs+y2OjdbavDIz0FEYAQGSUE6g9w2WoPk2JilBsGBOJ0enhrbZCa/1wEqNhU
         /+j4vKsacIw9hn9Lnjow3CB9yvT4ZQoAj3EfFwCTUwruH2Z9HwkjEK+7Fqpj68/uOMx/
         Sk1FcQ71qw05Lh0NiQoPg1nnUnLyffvIGTjnOEwx5R2AnL8ZRU9yNBTy0gexExeIi7cN
         Srp84QrVvYuhlBk75SpE1YElrfEhVra51/S6/Og68Ybgoed4s7ZppD6aUb/C4agJSSsO
         X2Lg==
X-Gm-Message-State: AFqh2kpWFJ4+8JgaB966qv+1Cm2e6Ibrc6U+MrZTl9QM+sJ7q2ajff8B
        Myiln2DK+kpWW+ue+1+1YjmlDw==
X-Google-Smtp-Source: AMrXdXvti7xeVV7pmm8Zfx//nkzZJfwvn79rWHBkxkJlJi6po1MareStbTQ9fQeaQIevteonHQwCrA==
X-Received: by 2002:a5d:9d49:0:b0:704:ca73:1758 with SMTP id k9-20020a5d9d49000000b00704ca731758mr2808575iok.9.1673983265774;
        Tue, 17 Jan 2023 11:21:05 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id x20-20020a0566022c5400b006bc039e3224sm10641525iov.17.2023.01.17.11.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 11:21:05 -0800 (PST)
Message-ID: <9109de9d-17f2-f1b2-b758-c9df0e562a20@linaro.org>
Date:   Tue, 17 Jan 2023 13:21:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 06/28] virt: gunyah: Identify hypervisor version
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-7-quic_eberman@quicinc.com>
 <51c36831-19c1-dd67-9e31-87733c190a9c@linaro.org>
 <7e64039a-55ce-d79d-8501-10de09269afb@quicinc.com>
Content-Language: en-US
In-Reply-To: <7e64039a-55ce-d79d-8501-10de09269afb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 11:56 AM, Elliot Berman wrote:
> 
> 
> On 1/9/2023 1:34 PM, Alex Elder wrote:
>> On 12/19/22 4:58 PM, Elliot Berman wrote:
>>> Export the version of Gunyah which is reported via the hyp_identify
>>> hypercall. Increments of the major API version indicate possibly
>>> backwards incompatible changes.
>>>
>>> Export the hypervisor identity so that Gunyah drivers can act according
>>> to the major API version.
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>>   drivers/virt/Makefile        |  1 +
>>>   drivers/virt/gunyah/Makefile |  1 +
>>>   drivers/virt/gunyah/gunyah.c | 46 ++++++++++++++++++++++++++++++++++++
>>>   include/linux/gunyah.h       |  6 +++++
>>>   4 files changed, 54 insertions(+)
>>>   create mode 100644 drivers/virt/gunyah/Makefile
>>>   create mode 100644 drivers/virt/gunyah/gunyah.c
>>>
>>> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
>>> index 093674e05c40..92b7e5311548 100644
>>> --- a/drivers/virt/Makefile
>>> +++ b/drivers/virt/Makefile
>>> @@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)    += nitro_enclaves/
>>>   obj-$(CONFIG_ACRN_HSM)        += acrn/
>>>   obj-$(CONFIG_EFI_SECRET)    += coco/efi_secret/
>>>   obj-$(CONFIG_SEV_GUEST)       += coco/sev-guest/
>>> +obj-y                += gunyah/
>>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>>> new file mode 100644
>>> index 000000000000..2ac4ee64b89d
>>> --- /dev/null
>>> +++ b/drivers/virt/gunyah/Makefile
>>> @@ -0,0 +1 @@
>>> +obj-$(CONFIG_GUNYAH) += gunyah.o
>>> diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
>>> new file mode 100644
>>> index 000000000000..c34c9046fc08
>>> --- /dev/null
>>> +++ b/drivers/virt/gunyah/gunyah.c
>>> @@ -0,0 +1,46 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>>> reserved.
>>> + */
>>> +
>>> +#define pr_fmt(fmt) "gunyah: " fmt
>>> +
>>> +#include <linux/gunyah.h>
>>> +#include <linux/init.h>
>>> +#include <linux/module.h>
>>> +#include <linux/printk.h>
>>> +
>>> +struct gh_hypercall_hyp_identify_resp gunyah_api;
>>> +EXPORT_SYMBOL_GPL(gunyah_api);
>>> +
>>> +static const uint32_t gunyah_known_uuids[][4] = {
>>> +    {0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /*QC_HYP 
>>> (Qualcomm's build) */
>>> +    {0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /*GUNYAH (open 
>>> source build) */
>>> +};
>>> +
>>> +static int __init gunyah_init(void)
>>> +{
>>> +    u32 uid[4];
>>> +    int i;
>>> +
>>> +    gh_hypercall_get_uid(uid);
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
>>> +        if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
>>> +            break;
>>> +
>>> +    if (i == ARRAY_SIZE(gunyah_known_uuids))
>>> +        return -ENODEV;
>>> +
>>> +    gh_hypercall_hyp_identify(&gunyah_api);
>>> +
>>> +    pr_info("Running under Gunyah hypervisor %llx/v%u\n",
>>> +        FIELD_GET(GH_API_INFO_VARIANT_MASK, gunyah_api.api_info),
>>> +        gh_api_version());
>>> +
>>> +    return 0;
>>> +}
>>> +arch_initcall(gunyah_init);
>>> +
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
>>> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
>>> index 2765d2b40198..166156f69df9 100644
>>> --- a/include/linux/gunyah.h
>>> +++ b/include/linux/gunyah.h
>>> @@ -92,6 +92,12 @@ struct gh_hypercall_hyp_identify_resp {
>>>       u64 api_info;
>>>       u64 flags[3];
>>>   };
>>> +extern struct gh_hypercall_hyp_identify_resp gunyah_api;
>>
>> Must this global variable be exposed?  Can't you hide it--as
>> well as its interpretation--inside "gunyah.c"?
>>  >> +
>>> +static inline u16 gh_api_version(void)
>>> +{
>>> +    return FIELD_GET(GH_API_INFO_API_VERSION_MASK, 
>>> gunyah_api.api_info);
>>> +}
>>
>> If you don't make the above function inline, can you hide the
>> definition of gunyah_api?
>>
> 
> This seems like a good idea to me. I'm thinking to have the following 
> functions:
> 
> enum gh_api_feature {
>      GH_API_FEATURE_DOORBELL,
>      GH_API_FEATURE_MSGQUEUE,
>      GH_API_FEATURE_VIC,
>      GH_API_FEATURE_VPM,
>      GH_API_FEATURE_VCPU,
>      GH_API_FEATURE_MEMEXTENT,
>      GH_API_FEATURE_TRACE_CTRL,
> };

My point wasn't necessarily to expose all of that.  Already
"gunyah.h" defines the bit positions in which these things
are recorded in the identify response.  My main point was
about (not) exposing that global variable.

I support your suggestion of abstracting the feature
interface that way, but I suggest waiting until it's
actually needed before you add it.  I don't see any
code that uses GH_IDENTIFY_PARTITION_CSPACE (and the
rest) currently.

Oh, and interestingly enough I see GH_API_INFO_BIG_ENDIAN
defined in the API info...

					-Alex

> 
> u16 gh_api_version(void);
> bool gh_api_has_feature(enum gh_api_feature feature);
> 
> Thanks,
> Elliot

