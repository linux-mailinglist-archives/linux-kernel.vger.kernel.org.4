Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA40066338E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbjAIVyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbjAIVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:35:29 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20313C0DE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:31 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id bp26so5550826ilb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a1R5NegFtyt7BiRu9LrE11oUbwJtWrpgEmQDhJTqcL4=;
        b=W30pWR/fDeuMc28cxqwAUyEcl3lwthxgiPcl3H6DaYFbuTqJVZl5jLLYYAz8lZmuld
         sCnbwdkYPJMOEhGp+rsdulWydIKyA/xaGXCyjYzcn1GQL8CQzyaVkcGsj+oAmxAHSEtJ
         AfB59rSSE1mnCMvY0/GrnbnUPlQmishbl6NQ1qT0k4LhZ2q1R3+OFemkP/ezOKV4cgl4
         Bp/AYQzxKfyot3TqxP4Qv8VOO98I4i5v83bgL3gSLh059MXIxE4xl6IilhoXw11JXlr0
         W55pypnZXNMzyWsDgd5Wz3n8M/QZtuZyVaBcZAu97mcHu3syzQhRgYqFcCSw8r4KmBZL
         Orjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1R5NegFtyt7BiRu9LrE11oUbwJtWrpgEmQDhJTqcL4=;
        b=5SCKlfkt2I+7tDJV3U7D5Fwbs7e42jUigTmrr6/hRL6SuDNoP74fMHF3dhyqYP9VSy
         T2MlHk1lU+QZahbz9yvaCp8pLWDoavn9FCTOvgagezlaxReF9x1fkczSkCcCzA3uH0oL
         ZIjk2XHFq28mqzeFNIFLC8S9rqkNUo4clyB/1cYEPNVZJIrp+SyMudIBj0VgcvMDrt3t
         kdx4wlWel6I5gY9tkZ6iDGKmzb4SrNHkme30Icjx2knG58CAHoMTOLUtQw5a2N9tbB/P
         kP3ELD6/9/WR5ZpcP8+bDGSMjf9SB4p+1UeqSRHeR09W4hKfQA123AZ82EIPeg7HGmMq
         /2eA==
X-Gm-Message-State: AFqh2koPc/Yl0qFrnNo7taAUlXYvcRer8ssWhcDEBcmXRBoVbdua389f
        4ePQlkx9tZIGGwjZ9NiChxxxbA==
X-Google-Smtp-Source: AMrXdXtzovTRG3btR0PcWwnt8UL6HPzM2bYHasqyZn2liQXDKC/kYwVv2NGPwn6JY7awoOUG2fRz0Q==
X-Received: by 2002:a05:6e02:c2e:b0:302:9921:2ee2 with SMTP id q14-20020a056e020c2e00b0030299212ee2mr55448641ilg.25.1673300071328;
        Mon, 09 Jan 2023 13:34:31 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id f15-20020a056638118f00b0038a183cb719sm3129187jas.141.2023.01.09.13.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:30 -0800 (PST)
Message-ID: <51c36831-19c1-dd67-9e31-87733c190a9c@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 06/28] virt: gunyah: Identify hypervisor version
To:     Elliot Berman <quic_eberman@quicinc.com>,
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
Content-Language: en-US
In-Reply-To: <20221219225850.2397345-7-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/19/22 4:58 PM, Elliot Berman wrote:
> Export the version of Gunyah which is reported via the hyp_identify
> hypercall. Increments of the major API version indicate possibly
> backwards incompatible changes.
> 
> Export the hypervisor identity so that Gunyah drivers can act according
> to the major API version.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/Makefile        |  1 +
>   drivers/virt/gunyah/Makefile |  1 +
>   drivers/virt/gunyah/gunyah.c | 46 ++++++++++++++++++++++++++++++++++++
>   include/linux/gunyah.h       |  6 +++++
>   4 files changed, 54 insertions(+)
>   create mode 100644 drivers/virt/gunyah/Makefile
>   create mode 100644 drivers/virt/gunyah/gunyah.c
> 
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index 093674e05c40..92b7e5311548 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>   obj-$(CONFIG_ACRN_HSM)		+= acrn/
>   obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
>   obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
> +obj-y				+= gunyah/
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> new file mode 100644
> index 000000000000..2ac4ee64b89d
> --- /dev/null
> +++ b/drivers/virt/gunyah/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
> new file mode 100644
> index 000000000000..c34c9046fc08
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gunyah: " fmt
> +
> +#include <linux/gunyah.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +
> +struct gh_hypercall_hyp_identify_resp gunyah_api;
> +EXPORT_SYMBOL_GPL(gunyah_api);
> +
> +static const uint32_t gunyah_known_uuids[][4] = {
> +	{0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /* QC_HYP (Qualcomm's build) */
> +	{0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /* GUNYAH (open source build) */
> +};
> +
> +static int __init gunyah_init(void)
> +{
> +	u32 uid[4];
> +	int i;
> +
> +	gh_hypercall_get_uid(uid);
> +
> +	for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
> +		if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
> +			break;
> +
> +	if (i == ARRAY_SIZE(gunyah_known_uuids))
> +		return -ENODEV;
> +
> +	gh_hypercall_hyp_identify(&gunyah_api);
> +
> +	pr_info("Running under Gunyah hypervisor %llx/v%u\n",
> +		FIELD_GET(GH_API_INFO_VARIANT_MASK, gunyah_api.api_info),
> +		gh_api_version());
> +
> +	return 0;
> +}
> +arch_initcall(gunyah_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 2765d2b40198..166156f69df9 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -92,6 +92,12 @@ struct gh_hypercall_hyp_identify_resp {
>   	u64 api_info;
>   	u64 flags[3];
>   };
> +extern struct gh_hypercall_hyp_identify_resp gunyah_api;

Must this global variable be exposed?  Can't you hide it--as
well as its interpretation--inside "gunyah.c"?

> +
> +static inline u16 gh_api_version(void)
> +{
> +	return FIELD_GET(GH_API_INFO_API_VERSION_MASK, gunyah_api.api_info);
> +}

If you don't make the above function inline, can you hide the
definition of gunyah_api?

					-Alex

>   void gh_hypercall_get_uid(u32 uid[4]);
>   void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);

