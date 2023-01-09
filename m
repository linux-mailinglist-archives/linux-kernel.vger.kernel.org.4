Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AEF66331E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbjAIVgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbjAIVfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:35:18 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FC2639
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:28 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id 3so5177525iou.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8m4DFL0o0qd5QscXiwgoKmLMBSqq+i05fHZ/s/wMX/4=;
        b=Ql+5VRCz4faT/eFSPTEFYtrnyUyZfRTPKf795upKyuC3gN7L9k4fky5CQofEWXyiBz
         qhc1ebHVEwl9xa4hsp06o78f3F404uTSDVcQTjg82fhJ+u+xHIfU3LSl1ZZAgHvIy9jt
         04+OJ2fd0Pwk1APu4anj37IOEdT2LZw/TFmJGwpuX7XCtbeSHjpMIibk4ZmfHTQDtIEQ
         xykiaVC+B8w/P9VRGWY/Ne7bMnKc2X8rKcZMBUbDWZX4K3bvlQXWMhDs5UzbDVbrgX2h
         XUt1tIqu12YjQUw0BW1CEuhximLlHL12htIyMZyOewai6C+u1aEwjBc0QiseQoz8FCy9
         se2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8m4DFL0o0qd5QscXiwgoKmLMBSqq+i05fHZ/s/wMX/4=;
        b=u0HwAmR3WVLmGVe0RLnal21tWokRF+d+qXQ4EvE2H85xF1zXFDDPKSnHBpFshqSWye
         3HpqWyPrFdFfj9X0m2jgFiXqRKlQh2xkxp7J1uUem5UUI1F5bQaNqVc6MaQscC6rPHGu
         /tu56Dg6RFQmQLAH7hb+4CjRWtLXb44bEt437BN1ALXS/Ka6Gfq4eFFsRwCf1DEdwqQo
         hbJWtHm4ZwyYwFbPKWSi1E1MltIB0M3S+mIvydu+baVWGQ2akefR76zsZAq/Hg9dxGzD
         AIDYlHsrPitie6a0h+3WkpqxJ+Id83HAh7t33JgEENPXkq8GsHXlXtRVbDJbaavgCbn2
         OTww==
X-Gm-Message-State: AFqh2krVA4+Vuw3w4K4TX2pABEFO/ENKHJBukNuhccxR9CMCagNcSfl1
        P4EwG8520U1GUyISYiPkXzuagw==
X-Google-Smtp-Source: AMrXdXvL1n6TBi6MtvlD08nsqhMU4g4VbGzCDhCRe7bdSdKrxqU/nGl/cU5GDAsYJnY+bnfazPsf8w==
X-Received: by 2002:a5d:80d6:0:b0:6e3:3d8:cac8 with SMTP id h22-20020a5d80d6000000b006e303d8cac8mr45163351ior.9.1673300067698;
        Mon, 09 Jan 2023 13:34:27 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id g26-20020a056602073a00b006e30c7e5cb2sm3600501iox.47.2023.01.09.13.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:27 -0800 (PST)
Message-ID: <63bbc640-9b0c-95af-3d35-291da0323db3@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v8 05/28] virt: gunyah: Add hypercalls to identify Gunyah
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-6-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20221219225850.2397345-6-quic_eberman@quicinc.com>
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
> Add hypercalls to identify when Linux is running a virtual machine under
> Gunyah.
> 
> There are two calls to help identify Gunyah:
> 
> 1. gh_hypercall_get_uid() returns a UID when running under a Gunyah
>     hypervisor.
> 2. gh_hypercall_hyp_identify() returns build information and a set of
>     feature flags that are supported by Gunyah.

The first is a "service", while the second is a "hypercall".
Can you explain the distinction?  The sentence at the top
refers to both as "hypercalls".

> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   MAINTAINERS                          |  2 +
>   arch/arm64/Kbuild                    |  1 +
>   arch/arm64/gunyah/Makefile           |  1 +
>   arch/arm64/gunyah/gunyah_hypercall.c | 69 ++++++++++++++++++++++++++++
>   drivers/virt/Kconfig                 |  1 +
>   drivers/virt/gunyah/Kconfig          | 12 +++++
>   include/linux/gunyah.h               | 25 ++++++++++
>   7 files changed, 111 insertions(+)
>   create mode 100644 arch/arm64/gunyah/Makefile
>   create mode 100644 arch/arm64/gunyah/gunyah_hypercall.c
>   create mode 100644 drivers/virt/gunyah/Kconfig
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74e76e0ab14d..36698df6b0e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8941,6 +8941,8 @@ L:	linux-arm-msm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>   F:	Documentation/virt/gunyah/
> +F:	arch/arm64/gunyah/
> +F:	drivers/virt/gunyah/
>   F:	include/linux/gunyah.h
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
> index 000000000000..9fbc720b6fb6
> --- /dev/null
> +++ b/arch/arm64/gunyah/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_GUNYAH) += gunyah_hypercall.o
> diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
> new file mode 100644
> index 000000000000..0beb3123d650
> --- /dev/null
> +++ b/arch/arm64/gunyah/gunyah_hypercall.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/module.h>
> +#include <linux/gunyah.h>
> +
> +#define GH_CALL_TYPE_PLATFORM_CALL		0
> +#define GH_CALL_TYPE_HYPERCALL			2
> +#define GH_CALL_TYPE_SERVICE			3
> +#define GH_CALL_TYPE_SHIFT			14
> +#define GH_CALL_FUNCTION_NUM_MASK		0x3fff

A FN_ID is a 32-bit value.  Are all 18 high-order bits considered
part of the call type?  It might be good to specify that explicitly
by defining a mask for it.

> +
> +#define GH_FN_ID(type, num)	((type) << GH_CALL_TYPE_SHIFT | ((num) & GH_CALL_FUNCTION_NUM_MASK))
> +

Is there any need for the endianness of these values to be specified?
Does Gunyah operate with a well-defined endianness?  Is there any
chance a VM can run with an endianness different from Gunyah?  I
see that the arm_smcc_* structures are defined without endianness.
(Sorry if these are dumb questions.)

> +#define GH_SERVICE(fn)		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> +						   ARM_SMCCC_OWNER_VENDOR_HYP, \
> +						   GH_FN_ID(GH_CALL_TYPE_SERVICE, fn))
> +
> +#define GH_HYPERCALL_CALL_UID			GH_SERVICE(0x3f01)

Perhaps 0x3f01 could be defined symbolically.

However if this is the only place it's ever used, doing so
doesn't add much value (meaning, just do it the way you did).

> +
> +#define GH_HYPERCALL(fn)	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
> +						   ARM_SMCCC_OWNER_VENDOR_HYP, \
> +						   GH_FN_ID(GH_CALL_TYPE_HYPERCALL, fn))
> +
> +#define GH_HYPERCALL_HYP_IDENTIFY		GH_HYPERCALL(0x0000)

Will there be a growing set of well-known hypervisor call functions?
Perhaps 0x0000 should be defined symbolically.  (Or not if it's only
used here.)

> +
> +/**
> + * gh_hypercall_get_uid() - Returns a UID when running under a Gunyah hypervisor
> + * @uid: An array of 4 u32's (u32 uid[4];)
> + *
> + * Caller should compare the resulting UID to a list of known Gunyah UIDs to
> + * confirm that Linux is running as a guest of Gunyah.

I presume that, if the returned UID isn't well-known, then no other
Gunyah-related calls are meaningful.  Is that correct?

> + */
> +void gh_hypercall_get_uid(u32 uid[4])
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_hvc(GH_HYPERCALL_CALL_UID, &res);
> +
> +	uid[0] = res.a0;
> +	uid[1] = res.a1;
> +	uid[2] = res.a2;
> +	uid[3] = res.a3;

I see in the definition of struct arm_smccc_res that the four
fields are unsigned long values.  That differs from the u32
array passed as argument.  Are the resource IDs guaranteed to
be four 32-bit values?  I personally prefer being explicit
about the upper 32-bits being discarded (though some don't
agree with that convention).

> +}
> +EXPORT_SYMBOL_GPL(gh_hypercall_get_uid);
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
> index 000000000000..127156a678a6
> --- /dev/null
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config GUNYAH

Maybe config QCOM_GUNYAH?  Will this ever run on hardware
other than Qualcomm's?

> +	tristate "Gunyah Virtualization drivers"
> +	depends on ARM64
> +	help
> +	  The Gunyah drivers are the helper interfaces that runs in a guest VM

s/runs/run/

> +	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> +	  services such as memory/device sharing, IRQ sharing, and so on.
> +
> +	  Say Y/M here to enable the drivers needed to interact in a Gunyah
> +	  virtual environment.
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 824e20a11d27..2765d2b40198 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -6,6 +6,7 @@
>   #ifndef _GUNYAH_H
>   #define _GUNYAH_H
>   
> +#include <linux/bitfield.h>
>   #include <linux/types.h>
>   #include <linux/errno.h>
>   
> @@ -71,4 +72,28 @@ static inline int gh_remap_error(int gh_error)
>   	}
>   }
>   
> +#define GUNYAH_API_V1			1
> +
> +#define GH_API_INFO_API_VERSION_MASK	GENMASK_ULL(13, 0)
> +#define GH_API_INFO_BIG_ENDIAN		BIT_ULL(14)
> +#define GH_API_INFO_IS_64BIT		BIT_ULL(15)
> +#define GH_API_INFO_VARIANT_MASK	GENMASK_ULL(63, 56)
> +

How are the GH_IDENTIFY bits below used?  Are they encoded
in the three 64-bit flags fields in the response structure?
Does that mean only the first of those three is (currently)
used?

> +#define GH_IDENTIFY_PARTITION_CSPACE		BIT_ULL(0)
> +#define GH_IDENTIFY_DOORBELL			BIT_ULL(1)
> +#define GH_IDENTIFY_MSGQUEUE			BIT_ULL(2)
> +#define GH_IDENTIFY_VIC				BIT_ULL(3)
> +#define GH_IDENTIFY_VPM				BIT_ULL(4)
> +#define GH_IDENTIFY_VCPU			BIT_ULL(5)
> +#define GH_IDENTIFY_MEMEXTENT			BIT_ULL(6)
> +#define GH_IDENTIFY_TRACE_CTRL			BIT_ULL(7)
> +
> +struct gh_hypercall_hyp_identify_resp {
> +	u64 api_info;
> +	u64 flags[3];
> +};

Again I'll ask about endianness.  This is a response coming *from*
Gunyah.  Is it guaranteed to use the same byte order convention as
the running operating system (Linux) guest?

					-Alex

> +
> +void gh_hypercall_get_uid(u32 uid[4]);
> +void gh_hypercall_hyp_identify(struct gh_hypercall_hyp_identify_resp *hyp_identity);
> +
>   #endif

