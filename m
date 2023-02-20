Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295D169CE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjBTOAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjBTOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:00:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C651E9F0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:59:37 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id p8so1448531wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UFqX1xpzYfRr7XRliTwmy4fXdKDRsTPOMhc3mSTdFn8=;
        b=G4oRXIYSs+SlkgF23wiiS6B970a1AG5cpTPGFK0KISLr8+FwieCoiC17HwabV1bHrW
         x7t2+4ZnkiOWPuNdRq7vn+gm+L6l0gYtaM00FfYvSZ/oBXBzc6Gc8D8ew/a6T/BrhwRy
         neZBg/1LDW+GewojvsYzfzr84S8d5t6u21+j4PsMSk2g9JMOhfhk+D2l5jplLJlnZr3a
         euesCry+y1p2x+VHSY7c8kai+vE82hXCjRTTflqK1Aum/K9eP8FcodkavHBC5lNvZAql
         EiX7ID3SqOIsJcXJNy3/svkAPsYt5Oa7uzDt1EA5HDfvtknDSGRpy2EoWEFHew/48TGE
         v8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFqX1xpzYfRr7XRliTwmy4fXdKDRsTPOMhc3mSTdFn8=;
        b=Yl9cXgVmy1aI2apPfG4LSjpr0i9TDh5xlUwzSNSWrouzk7uLSjd603EKaHutvdXhOB
         8i+VnKctW7NAL9pVW5/dtNAFJrYCncyp99zgBbk4mj3fHUg1a3W0G73hz86T/brSOH1a
         8cACEGslIFCr3uB7Ss46VSxVorKYaxEZXlu9WlIEEAOiArQi8COy3GLl0P1IJLx74PAx
         HkCjjGZ1aFO1rbk++g+juvVoprdEgF8gAoYrCe9CvRzxjvmUzjdpdrkgGsaXqJiTbh/o
         Ryf+qF19H33uYIAfiem2Ejni5FOHYb6zmgY4lzA6I76vHq/2m0qQQRPEj0IXZ2pce4B6
         yUHg==
X-Gm-Message-State: AO0yUKUETErhNxxPxpaxan8RXtYquGcYpXaWfWL24jMa9DamoFPbex3C
        wAgcf8K+JV7fDrStsmLJokfseg==
X-Google-Smtp-Source: AK7set8SGGeExgdNhwXfD4zxjZKAtHNtYbpfnDssEcIzSxtUWQqlrX3hqIY9udSP8TB7rai0FtsUNA==
X-Received: by 2002:a5d:608e:0:b0:2c6:ca01:e70b with SMTP id w14-20020a5d608e000000b002c6ca01e70bmr1690293wrt.31.1676901567663;
        Mon, 20 Feb 2023 05:59:27 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id p12-20020a5d48cc000000b002c6eaf53bcdsm544410wrs.28.2023.02.20.05.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:59:27 -0800 (PST)
Message-ID: <9981e1fc-2464-4c1a-5ce0-3772c9ffb9e8@linaro.org>
Date:   Mon, 20 Feb 2023 13:59:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v10 04/26] virt: gunyah: Add hypercalls to identify Gunyah
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-5-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230214211229.3239350-5-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

minor nits below,

On 14/02/2023 21:12, Elliot Berman wrote:
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
>   arch/arm64/Kbuild                    |  1 +
>   arch/arm64/gunyah/Makefile           |  3 ++
>   arch/arm64/gunyah/gunyah_hypercall.c | 61 ++++++++++++++++++++++++++++
>   drivers/virt/Kconfig                 |  2 +
>   drivers/virt/gunyah/Kconfig          | 13 ++++++
>   include/linux/gunyah.h               | 33 +++++++++++++++
>   6 files changed, 113 insertions(+)
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
> index 000000000000..f30d06ee80cf
> --- /dev/null
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/module.h>
> +#include <linux/gunyah.h>
> +
> +static const uint32_t gunyah_known_uuids[][4] = {
> +	{0x19bd54bd, 0x0b37571b, 0x946f609b, 0x54539de6}, /* QC_HYP (Qualcomm's build) */
> +	{0x673d5f14, 0x9265ce36, 0xa4535fdb, 0xc1d58fcd}, /* GUNYAH (open source build) */
> +};
> +
> +bool arch_is_gunyah_guest(void)
> +{
> +	struct arm_smccc_res res;
> +	u32 uid[4];
> +	int i;
> +
> +	arm_smccc_1_1_hvc(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
> +
> +	uid[0] = lower_32_bits(res.a0);
> +	uid[1] = lower_32_bits(res.a1);
> +	uid[2] = lower_32_bits(res.a2);
> +	uid[3] = lower_32_bits(res.a3);
> +
> +	for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
> +		if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
> +			break;
> +
> +	return i != ARRAY_SIZE(gunyah_known_uuids);

you could probably make this more readable by:


for (i = 0; i < ARRAY_SIZE(gunyah_known_uuids); i++)
	if (!memcmp(uid, gunyah_known_uuids[i], sizeof(uid)))
		return true;

return false;

> +}
> +EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
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
> index 59ef4c735ae8..3fef2854c5e1 100644
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
> @@ -79,4 +81,35 @@ static inline int gh_remap_error(enum gh_error gh_error)
>   	}
>   }
>   
> +enum gh_api_feature {
> +	GH_API_FEATURE_DOORBELL,
> +	GH_API_FEATURE_MSGQUEUE,
> +	GH_API_FEATURE_VCPU,
> +	GH_API_FEATURE_MEMEXTENT,
> +};
> +
> +bool arch_is_gunyah_guest(void);
> +
> +u16 gh_api_version(void);
> +bool gh_api_has_feature(enum gh_api_feature feature);
gh_api_has_feature or arch_is_gunyah_guest is in this patch, this should 
probably moved to the respecitive patch that implements these functions.

--srini
> +
> +#define GUNYAH_API_V1			1
> +
> +#define GH_API_INFO_API_VERSION_MASK	GENMASK_ULL(13, 0)
> +#define GH_API_INFO_BIG_ENDIAN		BIT_ULL(14)
> +#define GH_API_INFO_IS_64BIT		BIT_ULL(15)
> +#define GH_API_INFO_VARIANT_MASK	GENMASK_ULL(63, 56)
> +
> +#define GH_IDENTIFY_DOORBELL			BIT_ULL(1)
> +#define GH_IDENTIFY_MSGQUEUE			BIT_ULL(2)
> +#define GH_IDENTIFY_VCPU			BIT_ULL(5)
> +#define GH_IDENTIFY_MEMEXTENT			BIT_ULL(6)
> +
> +struct gh_hypercall_hyp_identify_resp {
> +	u64 api_info;
> +	u64 flags[3];
> +};
> +
> +void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
> +
>   #endif
