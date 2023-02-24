Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379EE6A142A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBXAJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBXAJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F619F13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:09:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id ko13so15615587plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccCPNE0dRKdn3JLZtkA6wCbsKjwclr4fc3XDhVbkgLo=;
        b=nHqpFvKbKdvofrxGmm+RSs6Q5fKLZ4vSN9y/VSyKTTCS9QA+Licsnf0zajAgsMvSyu
         x+8cCaA7IVUEApOk5gX4oMCM9hIjIPy9Ikp6u7WDgcKQj32Oip2mrvMAOm/dx1HMBl1C
         qTwyiGVBzMocIe6s7O82OJNRhPQTAH3DFPOdSPv5r1zZsJBGxwHgl37SKnAlG09bqJF9
         TgxttzvxKH6mE9FYTCy6+GIzFHCXuNpuaU6PAv8AYtbdGIQHqaCFfEV9vX2MqalYHKvg
         mIDyfF4S9QNifKrCpo07uYklfPy8UmSSMDzu/Qhp5Qy8kcFumZ1lCLKfDWmusxaqQlAJ
         D5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccCPNE0dRKdn3JLZtkA6wCbsKjwclr4fc3XDhVbkgLo=;
        b=WgVWDTKh2VwMNiOUOfXnV4bvtKWlW9Its06lZFoGg0av+2LCrB28+SDpnrvtDyGcbb
         ddvuYtbw7E33WBdLRhckcni/EsRPujXZoXC46Xqi7ECae/RSJswDVaFWo1KJXn9yLHT4
         fpdo0Zs9tY23cIYHQoPXBLFAid6HMvY/G8ajUvxaMXtEarMuzhXt6tb2Nhv4NDepk0q9
         M/pzXFVhQTase64XPAjycu7ZSV5d07JSN/85EP1vKbb5ROiAW4te7Olvf27zCGokriCJ
         QekUNcOhJgOH8ZtYnMqkbVMOnQ/ewo52Cb65OaEElWaJ15vynrak9s2PdgzaQ3LG+OTh
         tc/w==
X-Gm-Message-State: AO0yUKUAEEAyfyhksAkrObWlTn3ue3Bdk17GnoCOVaPo/N92KzbCBWo8
        +5fPws5GhdyZtBwf7Q+cN8wBTw==
X-Google-Smtp-Source: AK7set/HnrMWRi5l/nSGXUaL8JJ1iDLJnBnX2j0CDyp5hfge20IJFbzCBCdSoKyNngrhY9QQqcNYRg==
X-Received: by 2002:a17:903:2441:b0:196:5bac:e319 with SMTP id l1-20020a170903244100b001965bace319mr16426552pls.35.1677197355664;
        Thu, 23 Feb 2023 16:09:15 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d21200b0019337bf957dsm8692210ply.296.2023.02.23.16.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 16:09:14 -0800 (PST)
Message-ID: <4eb2e494-d987-5eb7-3513-be58eb87c9af@linaro.org>
Date:   Thu, 23 Feb 2023 18:09:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 04/26] virt: gunyah: Add hypercalls to identify Gunyah
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214211229.3239350-5-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
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

On 2/14/23 3:12 PM, Elliot Berman wrote:
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

Are these really UUIDs? Standard ones?  Define them using
the standard Linux way of doing it.  See <linux/uuid.h>.

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

Can't you reuse these symbols, so that the same set
represents the feature and the identify response?

I'm not sure what a good naming scheme would be, but
you could easily do:
enum gh_api_feature {
	GH_FEATURE_DOORBELL	= 1,
	GH_FEATURE_MSGQUEUE	= 2,
	GH_FEATURE_VCPU		= 5,
	GH_FEATURE_MEMEXTENT	= 6,
};

And then you could do:

bool gh_api_has_feature(enum gh_api_feature feature)
{
         switch (feature) {
         case GH_FEATURE_DOORBELL:
	case GH_FEATURES_MSGQUEUE:
	case GH_FEATURE_VCPU:
	case GH_FEATURE_MEMEXTENT:
		return !!(gunyah_api.flags[0] & BIT_ULL(feature));

	default:
		return false;
	}
}

> +
> +bool arch_is_gunyah_guest(void);
> +
> +u16 gh_api_version(void);
> +bool gh_api_has_feature(enum gh_api_feature feature);
> +
> +#define GUNYAH_API_V1			1
> +

Rather than _INFO_ here, maybe _IDENTIFY_?

Why is "API_" needed in these symbol names?

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

Since this is a user space API, you *could* consider having
this function return an int.  Just in case there's a future
reason that a failure could occur, or that you want to
supply some other information.  If this truly doesn't make
sense, it's fine as-is...

> +
>   #endif

