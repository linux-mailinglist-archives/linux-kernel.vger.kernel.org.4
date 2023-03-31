Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0446D2261
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjCaOZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjCaOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:25:02 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813A81EFDF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:24:57 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j2so4556062ila.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272697; x=1682864697;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=id+GR3iqUDi1DUpj2KMsPAnwHrgu9sMNPElpRz2tsnU=;
        b=JSpwWb5zSlSeqGJChV/8WIdrxghOC35J/Oit6vL+r6PDzJ6ojMwuXyXN77xxg9gZbl
         AnTu90S1K57iz1KzYumWIHoOZzqQ7cOaanupwb1sQCiI51cfu+JBITFWuwYvfHRHGi8A
         76n1jPez7cWLijucRM9ZFqNK/jr4dVmOFjqDicsHxuZgyo1N5+Xl4yonUvskdJBTSl9r
         cPQwXHgGcwsmTFnMXtrpnmzd6Bohex0xO8xVJ9tDZL4poo2unK40iZkYg4bTH/kHEUpl
         aOd1mlQbn1Td6o0dGndJRb1EXmy8QHnXasxzeMPidiCBDtHuaLycsEdOwLnvt4Q3hY9v
         c8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272697; x=1682864697;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=id+GR3iqUDi1DUpj2KMsPAnwHrgu9sMNPElpRz2tsnU=;
        b=7XJlKNGx8HMyhHXNbF5aw+Kb0oO0Yka0o3UF+MmmYxBhZGJinrBox+EjMUzyGNle7I
         +RUfbAVlOVfGRlNnsuSkQFNdc7aiM+MJ9e36Z8eK3G7qaylugoi2UngFItIGB2lPuV5+
         VjEar13ApG2bCWXTC2OlUhdaQkaUud13RvMmIix0xcuoAQ/tnPk0V01ZxWEX+stIFhM+
         XEjMHJp7jg2Kfzk+C6pV8HeYXyn+3hHWTyRTiZp5frFZdwe7BzjyeZZIE8NZLQzSYkD8
         LGLmddILPX8hYCMswY/Fdi0II6PuSwauxk7oW2nPy37ILU20hHU9EN7tusoGR22dOutm
         opJQ==
X-Gm-Message-State: AAQBX9cRHoglY0XkQzJxFED5HEkVKXb3veO/5seEfE4qs6uKzuonHP0G
        0qCbZdCWAvgI/ffnJTCqkzxHmw==
X-Google-Smtp-Source: AKy350YYEMfCtuKVVpDekR7oYOlph9QmRnKy6tO/kVqS8ZinY2h8xcsLxXr/BBrwn/Wblo8oy1V7UA==
X-Received: by 2002:a92:7f0c:0:b0:326:4313:db91 with SMTP id a12-20020a927f0c000000b003264313db91mr3051071ild.23.1680272697151;
        Fri, 31 Mar 2023 07:24:57 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056638371200b004051ff71eacsm656394jav.144.2023.03.31.07.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:24:56 -0700 (PDT)
Message-ID: <7a294778-ef61-695f-316a-92017100a88b@linaro.org>
Date:   Fri, 31 Mar 2023 09:24:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 05/26] virt: gunyah: Identify hypervisor version
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-6-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/23 7:06 PM, Elliot Berman wrote:
> Export the version of Gunyah which is reported via the hyp_identify
> hypercall. Increments of the major API version indicate possibly
> backwards incompatible changes.
> 
> Export the hypervisor identity so that Gunyah drivers can act according
> to the major API version.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

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

