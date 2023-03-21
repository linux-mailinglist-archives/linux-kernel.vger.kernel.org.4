Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4DD6C3630
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjCUPtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCUPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:49:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921D4DE20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:49:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eh3so61436408edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679413739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzDFIymbRjbLhmlcc42BiXxJve1ZLr1cxA94sUeeuDQ=;
        b=xOT3dQErkNbyGneftJFjSnjdfjvRXh/wgUVE5YAfSTsdLMTa+oockgRQBPsMclLUqB
         U4IIkytzklFq3jHOSyH/KRiUUMWFL904rv+e2yYFdLIGSSxwYfEn66IwA+O/FKnkH9iK
         OJK3kwJMjNqVkvLoIjBC6FS9mNN4Ll7JAfWxkUWqChVcMIXFTR5NbWlFd0yD13vIyBxI
         uAKdjSajzGq8sZ6BxflLceYT/1OTdUELaqxWhf+6s70Re59N2OD/PhlyfVbBfXF4GO6g
         nH4567gpkoZS/JXECrwQYFmnNnPF7Aat07MoTwnRh/gCm8hQ+LrxqJqlp9XGSbdaAFlx
         NpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzDFIymbRjbLhmlcc42BiXxJve1ZLr1cxA94sUeeuDQ=;
        b=HCXMcyQv0HDmz77kYH04srtlLatS/Wwlqb38AuJXwFsukLrqEGRnCiZpPJM6sIEWSN
         jBdyK/KMSjSVhgE3CX62M9NAQXWNvejjc//uCdb5WCsnXIeN4rJShSQFW7fvVZ3CHEMs
         yMQVBOrhkanteTF5j1zRYeZrlFY7uWhg4Ao1IO7JJplGitGAjiwXYrXd0Bcz23EzwGrd
         Sdi6GKNkjWzUnI5QfSvXSYOx9XChR9lpaNfDTOl+OtBerts+7PJWXuOy1Qpk6qW1ArZL
         518nn0AFPuydq0m/QTiK7IejSjkew3zic03cOUnERx0RKclU5TbBu4VDVrXjRE+StdHM
         7ErA==
X-Gm-Message-State: AO0yUKXOGCv7QOxWuUWLE+/39STbE4uB76Qd5YuBkJcs+e2BTaYGEXRv
        o0WNdh2kjp3IG71tjqrsSQkZgg==
X-Google-Smtp-Source: AK7set9vvgE0/AZT5nETWstzcgB/WJjjvy5BXgYV3f+XN39lD7CIun132siBk0Fq/T5DQE94TJZWlQ==
X-Received: by 2002:a17:906:6d13:b0:925:f542:1a3d with SMTP id m19-20020a1709066d1300b00925f5421a3dmr3383284ejr.25.1679413739616;
        Tue, 21 Mar 2023 08:48:59 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm5958260ejq.3.2023.03.21.08.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:48:58 -0700 (PDT)
Message-ID: <fcffc785-42b0-0312-daa3-f927f18cd43e@linaro.org>
Date:   Tue, 21 Mar 2023 15:48:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 05/26] virt: gunyah: Identify hypervisor version
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-6-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230304010632.2127470-6-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2023 01:06, Elliot Berman wrote:
> Export the version of Gunyah which is reported via the hyp_identify
> hypercall. Increments of the major API version indicate possibly
> backwards incompatible changes.
> 
> Export the hypervisor identity so that Gunyah drivers can act according
> to the major API version.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
> ---
>   drivers/virt/Makefile        |  1 +
>   drivers/virt/gunyah/Makefile |  3 ++
>   drivers/virt/gunyah/gunyah.c | 57 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 61 insertions(+)
>   create mode 100644 drivers/virt/gunyah/Makefile
>   create mode 100644 drivers/virt/gunyah/gunyah.c
> 
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index e9aa6fc96fab..a5817e2d7d71 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_ACRN_HSM)		+= acrn/
>   obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
>   obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
>   obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
> +obj-y				+= gunyah/
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> new file mode 100644
> index 000000000000..34f32110faf9
> --- /dev/null
> +++ b/drivers/virt/gunyah/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
> new file mode 100644
> index 000000000000..4b7e6f3edaff
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gunyah: " fmt
> +
> +#include <linux/gunyah.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +
> +static struct gh_hypercall_hyp_identify_resp gh_api;
> +
> +u16 gh_api_version(void)
> +{
> +	return FIELD_GET(GH_API_INFO_API_VERSION_MASK, gh_api.api_info);
> +}
> +EXPORT_SYMBOL_GPL(gh_api_version);
> +
> +bool gh_api_has_feature(enum gh_api_feature feature)
> +{
> +	switch (feature) {
> +	case GH_FEATURE_DOORBELL:
> +	case GH_FEATURE_MSGQUEUE:
> +	case GH_FEATURE_VCPU:
> +	case GH_FEATURE_MEMEXTENT:
> +		return !!(gh_api.flags[0] & BIT_ULL(feature));
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(gh_api_has_feature);
> +
> +static int __init gh_init(void)
> +{
> +	if (!arch_is_gh_guest())
> +		return -ENODEV;
> +
> +	gh_hypercall_hyp_identify(&gh_api);
> +
> +	pr_info("Running under Gunyah hypervisor %llx/v%u\n",
> +		FIELD_GET(GH_API_INFO_VARIANT_MASK, gh_api.api_info),
> +		gh_api_version());
> +
> +	/* We might move this out to individual drivers if there's ever an API version bump */
> +	if (gh_api_version() != GH_API_V1) {
> +		pr_info("Unsupported Gunyah version: %u\n", gh_api_version());
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(gh_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Hypervisor Driver");
