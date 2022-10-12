Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC35FCD50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJLVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJLVbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:31:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6CF1BEAE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:31:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d6so27590835lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vtsL+SJW5+Z8e/Kz7maN7WMp4/x7JXeXSoVKvjOpbw=;
        b=G5aCYdEbuv1EYUsVsGqOuNHw3Cbhvd0hMPjf1I3EgBMwk3Wbc5WVXN4EsjLeeKoOUm
         s2s0AC53B8ePOA2bvtFQWCQ3vhkRC6YRBsCDOIuazE6qbeF3EtVsF8nBhYNte6JF5PMX
         d47sqTrLZBJNJe4me9u3O0t5ZF6F7YFFgqWeYr2fCSJo45opEHdNEe3fbZ2vTJ48b2Nu
         FOsu3KXoaGPv1g2tnm52KHJbq9O3KKfzodHn82M/sF1XJAwAolsfYYObLDObi0Hn3N1L
         ymsB3OXO+QckKfDqQaYw6L0PsVmJXpwcpfwQrYMeB2FtA6+Ii/FvZLgPA/5td2G0KcBL
         faSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vtsL+SJW5+Z8e/Kz7maN7WMp4/x7JXeXSoVKvjOpbw=;
        b=TKOcO3g7dykVMLFfxLE9b7hjYzrBqN64pRefnvm2b+xFDOuVH3oB7ajEinmG79LjaX
         ID9CJkdi2dxToEOx6Y7KAbE4pOG5BwQq58oSzvHSur5S0VoT7HmqNQDZq6NtEpdqA/Pc
         3iRYT39NVumLYlTdqWEw4LhdFRwwPmA8qdtmpVUCk/1MgPgdGShtEXXd47alQSW8SmMV
         yLt6WlnWG0jIiNOTjsAMAlrG/jXBCtBzLWMKd3Gwn6KjQ/YjHrY5SKs5dxtGmXVaRpDI
         lHishd3AbvI+uqLjXje+Rex28JN6kaaheFvcS9qRiWHwVF/fqvRf/ETt6WHAmsyCapmV
         7Bow==
X-Gm-Message-State: ACrzQf0JUY8u+EHCOnTQ/4AkxeTk/hbql0OdCn/T4fIZ/NjPp/Qux10m
        bOe4Ak+ZhVx3F9ajQrlC9YXP4Q==
X-Google-Smtp-Source: AMsMyM4QY82LO0GQ02CQAhrVMgcMaWmZZnVEd3KSEcOD6+H6kGFu/NgT0e9K1tVCDFBPfd4pHHaGhw==
X-Received: by 2002:ac2:4c82:0:b0:4a0:5825:a0ac with SMTP id d2-20020ac24c82000000b004a05825a0acmr10686645lfl.660.1665610270742;
        Wed, 12 Oct 2022 14:31:10 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512202800b00498f3ebffb2sm121400lfs.25.2022.10.12.14.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 14:31:10 -0700 (PDT)
Message-ID: <5d5a4127-cf5e-3fd4-6583-fbeab94b5327@linaro.org>
Date:   Thu, 13 Oct 2022 00:31:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 05/13] virt: gunyah: Add hypercalls to identify Gunyah
Content-Language: en-GB
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-6-quic_eberman@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011000840.289033-6-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 03:08, Elliot Berman wrote:
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
> ---
>   MAINTAINERS                   |  2 +
>   arch/arm64/Kbuild             |  1 +
>   arch/arm64/gunyah/Makefile    |  2 +
>   arch/arm64/gunyah/hypercall.c | 71 +++++++++++++++++++++++++++++++++++
>   drivers/virt/Kconfig          |  1 +
>   drivers/virt/gunyah/Kconfig   | 13 +++++++
>   include/asm-generic/gunyah.h  | 36 ++++++++++++++++++
>   7 files changed, 126 insertions(+)
>   create mode 100644 arch/arm64/gunyah/Makefile
>   create mode 100644 arch/arm64/gunyah/hypercall.c
>   create mode 100644 drivers/virt/gunyah/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fe8cec61551..ed2bc98c3818 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8886,6 +8886,8 @@ L:	linux-arm-msm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>   F:	Documentation/virt/gunyah/
> +F:	arch/arm64/gunyah/
> +F:	drivers/virt/gunyah/
>   F:	include/asm-generic/gunyah.h
>   
>   HABANALABS PCI DRIVER
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
> index 000000000000..f71a9533c266
> --- /dev/null
> +++ b/arch/arm64/gunyah/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
> +gunyah_hypercall-y += hypercall.o

You don't have to do this. Just rename your source file to 
gunyah_hypercall.c

> diff --git a/arch/arm64/gunyah/hypercall.c b/arch/arm64/gunyah/hypercall.c
> new file mode 100644
> index 000000000000..5b08c9d80de0
> --- /dev/null
> +++ b/arch/arm64/gunyah/hypercall.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/module.h>
> +#include <asm-generic/gunyah.h>
> +
> +#define GH_CALL_TYPE_PLATFORM_CALL		0
> +#define GH_CALL_TYPE_HYPERCALL			2
> +#define GH_CALL_TYPE_SERVICE			3
> +#define GH_CALL_TYPE_SHIFT			14
> +#define GH_CALL_FUNCTION_NUM_MASK		0x3fff
> +
> +#define GH_SERVICE(fn)		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> +						   ARM_SMCCC_OWNER_VENDOR_HYP, \
> +						   (GH_CALL_TYPE_SERVICE << GH_CALL_TYPE_SHIFT) \
> +							| ((fn) & GH_CALL_FUNCTION_NUM_MASK))

Add a #define for (GH_CALL_TYPE_SERVICE << GH_CALL_TYPE_SHIFT) | ((fn) & 
GH_CALL_FUNCTION_NUM_MASK)), then use it here and below.

> +
> +#define GH_HYPERCALL_CALL_UID			GH_SERVICE(0x3f01)
> +
> +#define GH_HYPERCALL(fn)	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
> +						   ARM_SMCCC_OWNER_VENDOR_HYP, \
> +						   (GH_CALL_TYPE_HYPERCALL << GH_CALL_TYPE_SHIFT) \
> +							| ((fn) & GH_CALL_FUNCTION_NUM_MASK))
> +
> +#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)
> +
> +/**
> + * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor.
> + * @uid: An array of 4 u32's (u32 uid[4];)
> + *
> + * The UID will be either QC_HYP_UID or GUNYAH_UID defined in include/asm-generic/gunyah.h.
> + * QC_HYP_UID is returned on platforms using Qualcomm's version of Gunyah.
> + * GUNYAH_UID is returned on platforms using open source version of Gunyah.
> + * If the uid is not one of the above two UIDs, then it is assumed that the hypervisor or firmware
> + * is not Gunyah.
> + */
> +void gh_hypercall_get_uid(u32 *uid)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_CALL_UID, &res);
> +
> +	uid[0] = res.a0;
> +	uid[1] = res.a1;
> +	uid[2] = res.a2;
> +	uid[3] = res.a3;
> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_get_uid);
> +
> +/**
> + * gh_hypercall_hyp_identify() - Returns build information and feature flags supported by Gunyah.
> + * @hyp_identify: filled by the hypercall with the API info and feature flags.
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
> index 87ef258cec64..259dc2be6cad 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -52,4 +52,5 @@ source "drivers/virt/coco/efi_secret/Kconfig"
>   
>   source "drivers/virt/coco/sev-guest/Kconfig"
>   
> +source "drivers/virt/gunyah/Kconfig"
>   endif
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> new file mode 100644
> index 000000000000..7ac917e0aa3f
> --- /dev/null
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config GUNYAH
> +	tristate "Gunyah Virtualization drivers"
> +	depends on ARM64
> +	select AUXILIARY_BUS
> +	help
> +	  The Gunyah drivers are the helper interfaces that runs in a guest VM
> +	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> +	  services such as memory/device sharing, IRQ sharing, and so on.
> +
> +	  Say Y/M here to enable the drivers needed to interact in a Gunyah
> +	  virtual environment.
> diff --git a/include/asm-generic/gunyah.h b/include/asm-generic/gunyah.h
> index 64a02dd3b5ad..86eb59e203ef 100644
> --- a/include/asm-generic/gunyah.h
> +++ b/include/asm-generic/gunyah.h
> @@ -71,4 +71,40 @@ static inline int gh_remap_error(int gh_error)
>   	}
>   }
>   
> +#define QC_HYP_UID0 0x19bd54bd
> +#define QC_HYP_UID1 0x0b37571b
> +#define QC_HYP_UID2 0x946f609b
> +#define QC_HYP_UID3 0x54539de6
> +
> +#define GUNYAH_UID0 0x673d5f14
> +#define GUNYAH_UID1 0x9265ce36
> +#define GUNYAH_UID2 0xa4535fdb
> +#define GUNYAH_UID3 0xc1d58fcd

It would be better to define them as arrays

> +
> +#define gh_uid_matches(prefix, uid)	\
> +	((uid)[0] == prefix ## _UID0 && (uid)[1] == prefix ## _UID1 && \
> +	 (uid)[2] == prefix ## _UID2 && (uid)[3] == prefix ## _UID3)

... then you could do memcmp() here.

> +
> +#define GH_API_INFO_API_VERSION(x)	(((x) >> 0) & 0x3fff)

No need to >> 0. And also you can use FIELD_GET to ease review.

> +#define GH_API_INFO_BIG_ENDIAN(x)	(((x) >> 14) & 1)
> +#define GH_API_INFO_IS_64BIT(x)		(((x) >> 15) & 1)
> +#define GH_API_INFO_VARIANT(x)		(((x) >> 56) & 0xff)

Use FIELD_GET here.

> +
> +#define GH_IDENTIFY_PARTITION_CSPACE(flags)	(((flags)[0] >> 0) & 1)
> +#define GH_IDENTIFY_DOORBELL(flags)		(((flags)[0] >> 1) & 1)
> +#define GH_IDENTIFY_MSGQUEUE(flags)		(((flags)[0] >> 2) & 1)
> +#define GH_IDENTIFY_VIC(flags)			(((flags)[0] >> 3) & 1)
> +#define GH_IDENTIFY_VPM(flags)			(((flags)[0] >> 4) & 1)
> +#define GH_IDENTIFY_VCPU(flags)			(((flags)[0] >> 5) & 1)
> +#define GH_IDENTIFY_MEMEXTENT(flags)		(((flags)[0] >> 6) & 1)
> +#define GH_IDENTIFY_TRACE_CTRL(flags)		(((flags)[0] >> 7) & 1)

Ugh. #define GH_IDENTIFY_DOORBELLflags)  (flags & BIT(1)), etc.

> +
> +struct gh_hypercall_hyp_identify_resp {
> +	u64 api_info;
> +	u64 flags[3];
> +};
> +
> +void gh_hypercall_get_uid(u32 *uid);
> +void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
> +
>   #endif

-- 
With best wishes
Dmitry

