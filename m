Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5F86D225C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjCaOZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjCaOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:24:59 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935191D2E8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:24:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h11so11565097ild.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272692; x=1682864692;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7UOla0WWBKSuWPD+jt6v1jNcZE65f64Cd8+3Cyt28T4=;
        b=ZQzn0r41DfbBuexwb4QrpJ3P3/EEZaHB5J25ktskVK+4134e5PZyHchPEBJ4vi8zuD
         qWGOSoztQZIEd/uGLxc7jBWRf8PywLbamPiclVaQM+OVtKJxjLui2GsPksx4rIZgPNIE
         OWVMtn0nPNMCVDDdsD5tP9Qt1btVOEz2w8lUrKWXcZgIE4jKTRgiE2KYEkRkcfZIUiFx
         SiOE93ipqKxge1jHneow6vdgdLL2fgmTei8FTm8SLDhX0A79CypavE78uEJKJDzR8fFp
         dgL0IeP+dud0GFNOMInwcQsqGPVN8AuRYz0m3JkwppiZNkAUQK/CZxHyFuvS46O8Jze3
         ShLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272692; x=1682864692;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UOla0WWBKSuWPD+jt6v1jNcZE65f64Cd8+3Cyt28T4=;
        b=y/gaj/iYIHs6Owu7ejpea+P9PHGnZBdnHojGtLsjpU73Qw1emrL0oNSWhmuk/mvF/Q
         ZQ8S8e90lAReBwOtvmNPJPZAreeOpdLX+zGxw0/gAyHzRdIddZvYwmqUjpNvhhIpH+9S
         Ku/jJ7dv3x2lYaAuXiO+HQOCB0MxZrGKbHc2/3ZVS33C+4cDt8rswWpGYl5cPx5yG/n9
         0Q7X+yi6/zH/TK1SUYM3rd3kmxuaoBL4//4Vdtps8W3QQDlbtMjKeow7IMx5PDhsRUIJ
         XmAnh1fO6D0ub0P81FivvebIvXAKgRKOwZ13LnG0EYUhKDvg7hnYlEnjuJKiwsZ0UXvd
         KYqg==
X-Gm-Message-State: AAQBX9cnoDLvyJtCxYGVXWRBgS5Xpo3eanAwOQEW0bENG4HufecKjqgG
        +LJubvY2g3YmUx6j95xhxQ6oKw==
X-Google-Smtp-Source: AKy350YPE6T0JCXTtXmBN6sRp7ZvjEg3CiT3exz6KlUGpsF0MHck0+7J3O2rIqUGpL++ZOb94vF5wA==
X-Received: by 2002:a92:d14f:0:b0:326:17e2:bc99 with SMTP id t15-20020a92d14f000000b0032617e2bc99mr11268109ilg.28.1680272692294;
        Fri, 31 Mar 2023 07:24:52 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id bs22-20020a056638451600b004063510ba0esm661259jab.142.2023.03.31.07.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:24:52 -0700 (PDT)
Message-ID: <2be7e47e-22ca-9c6e-63a1-265bdabe7044@linaro.org>
Date:   Fri, 31 Mar 2023 09:24:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 04/26] virt: gunyah: Add hypercalls to identify Gunyah
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-5-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-5-quic_eberman@quicinc.com>
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
> Add hypercalls to identify when Linux is running a virtual machine under
> Gunyah.
> 
> There are two calls to help identify Gunyah:
> 
> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>     hypervisor.
> 2. gh_hypercall_hyp_identify() returns build information and a set of
>     feature flags that are supported by Gunyah.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Two very minor comments below.	-Alex

> ---
>   arch/arm64/Kbuild                    |  1 +
>   arch/arm64/gunyah/Makefile           |  3 ++
>   arch/arm64/gunyah/gunyah_hypercall.c | 64 ++++++++++++++++++++++++++++
>   drivers/virt/Kconfig                 |  2 +
>   drivers/virt/gunyah/Kconfig          | 13 ++++++
>   include/linux/gunyah.h               | 28 ++++++++++++
>   6 files changed, 111 insertions(+)
>   create mode 100644 arch/arm64/gunyah/Makefile
>   create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
>   create mode 100644 drivers/virt/gunyah/Kconfig
> 
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index 5bfbf7d79c99..e4847ba0e3c9 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -3,6 +3,7 @@ obj-y			+= kernel/ mm/ net/
>   obj-$(CONFIG_KVM)	+= kvm/
>   obj-$(CONFIG_XEN)	+= xen/
>   obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
> +obj-$(CONFIG_GUNYAH)	+= gunyah/
>   obj-$(CONFIG_CRYPTO)	+= crypto/
>   
>   # for cleaning
> diff --git a/arch/arm64/gunyah/Makefile b/arch/arm64/gunyah/Makefile
> new file mode 100644
> index 000000000000..84f1e38cafb1
> --- /dev/null
> +++ b/arch/arm64/gunyah/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> new file mode 100644
> index 000000000000..0d14e767e2c8
> --- /dev/null
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/module.h>
> +#include <linux/gunyah.h>
> +#include <linux/uuid.h>
> +
> +static const uuid_t gh_known_uuids[] = {
> +	/* Qualcomm's version of Gunyah {19bd54bd-0b37-571b-946f-609b54539de6} */
> +	UUID_INIT(0x19bd54bd, 0x0b37, 0x571b, 0x94, 0x6f, 0x60, 0x9b, 0x54, 0x53, 0x9d, 0xe6),
> +	/* Standard version of Gunyah {c1d58fcd-a453-5fdb-9265-ce36673d5f14} */
> +	UUID_INIT(0xc1d58fcd, 0xa453, 0x5fdb, 0x92, 0x65, 0xce, 0x36, 0x67, 0x3d, 0x5f, 0x14),
> +};
> +
> +bool arch_is_gh_guest(void)
> +{
> +	struct arm_smccc_res res;
> +	uuid_t uuid;
> +	int i;
> +
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +
> +	((u32 *)&uuid.b[0])[0] = lower_32_bits(res.a0);
> +	((u32 *)&uuid.b[0])[1] = lower_32_bits(res.a1);
> +	((u32 *)&uuid.b[0])[2] = lower_32_bits(res.a2);
> +	((u32 *)&uuid.b[0])[3] = lower_32_bits(res.a3);
> +
> +	for (i = 0; i < ARRAY_SIZE(gh_known_uuids); i++)
> +		if (uuid_equal(&uuid, &gh_known_uuids[i]))
> +			return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(arch_is_gh_guest);
> +
> +#define GH_HYPERCALL(fn)	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
> +						   ARM_SMCCC_OWNER_VENDOR_HYP, \
> +						   fn)
> +
> +#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x8000)
> +
> +/**
> + * gh_hypercall_hyp_identify() - Returns build information and feature flags
> + *                               supported by Gunyah.
> + * @hyp_identity: filled by the hypercall with the API info and feature flags.
> + */
> +void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_HYP_IDENTIFY, &res);
> +
> +	hyp_identity->api_info = res.a0;
> +	hyp_identity->flags[0] = res.a1;
> +	hyp_identity->flags[1] = res.a2;
> +	hyp_identity->flags[2] = res.a3;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_hyp_identify);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Hypervisor Hypercalls");
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index f79ab13a5c28..85bd6626ffc9 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -54,4 +54,6 @@ source "drivers/virt/coco/sev-guest/Kconfig"
>   
>   source "drivers/virt/coco/tdx-guest/Kconfig"
>   
> +source "drivers/virt/gunyah/Kconfig"
> +
>   endif
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> new file mode 100644
> index 000000000000..1a737694c333
> --- /dev/null
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config GUNYAH
> +	tristate "Gunyah Virtualization drivers"
> +	depends on ARM64
> +	depends on MAILBOX
> +	help
> +	  The Gunyah drivers are the helper interfaces that run in a guest VM
> +	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> +	  services such as memory/device sharing, IRQ sharing, and so on.
> +
> +	  Say Y/M here to enable the drivers needed to interact in a Gunyah
> +	  virtual environment.
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 54b4be71caf7..bd080e3a6fc9 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -6,8 +6,10 @@
>   #ifndef _LINUX_GUNYAH_H
>   #define _LINUX_GUNYAH_H
>   
> +#include <linux/bitfield.h>
>   #include <linux/errno.h>
>   #include <linux/limits.h>
> +#include <linux/types.h>
>   
>   /******************************************************************************/
>   /* Common arch-independent definitions for Gunyah hypercalls                  */
> @@ -80,4 +82,30 @@ static inline int gh_remap_error(enum gh_error gh_error)
>   	}
>   }
>   
> +enum gh_api_feature {
> +	GH_FEATURE_DOORBELL = 1,
> +	GH_FEATURE_MSGQUEUE = 2,
> +	GH_FEATURE_VCPU = 5,

Fix alignment in the line above.

> +	GH_FEATURE_MEMEXTENT = 6,
> +};
> +
> +bool arch_is_gh_guest(void);
> +
> +u16 gh_api_version(void);
> +bool gh_api_has_feature(enum gh_api_feature feature);
> +
> +#define GH_API_V1			1
> +
> +#define GH_API_INFO_API_VERSION_MASK	GENMASK_ULL(13, 0)
> +#define GH_API_INFO_BIG_ENDIAN		BIT_ULL(14)
> +#define GH_API_INFO_IS_64BIT		BIT_ULL(15)

Maybe a comment saying "bits 16-55 are reserved"?

> +#define GH_API_INFO_VARIANT_MASK	GENMASK_ULL(63, 56)
> +
> +struct gh_hypercall_hyp_identify_resp {
> +	u64 api_info;
> +	u64 flags[3];
> +};
> +
> +void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
> +
>   #endif

