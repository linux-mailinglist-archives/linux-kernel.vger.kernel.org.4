Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63D96A1459
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBXAef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 19:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBXAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 19:34:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127E14D614
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:34:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso1059475pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 16:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LkwTUypetfbi40a7yUCwplrx+RBHVyw2x29kpaOPhT4=;
        b=am3yOtTpdx27lGyhxqz/SnjApTNPPEsR+25AXQqCnW2kZN1xDHcbAn3UUnl7FL739S
         iAw+ZevJe5nIhoHildehVOzSX3M2kNvKDTKieqk1Prw7pBZMhTCyE3eVuAKAq7kVDHiU
         dHtGDXkq9Pelgen3+IwgYB4Ipzk3f4QK8udrjQdSe3RN3fk+n9QGd8qDp9Kf3B/YKUxW
         3d1rc/Y27X6KGiVkwP4RARMfWA0sjmrXkumyGH7SiSzpfvumRAxyuj0PF22h2M3cJctQ
         sxDDmiSmHNSE9HWJSHyg1L3gvJzwxIMVLUKHGwKN+G6aPxBinK2DHPMnIiNcMUqzdNr9
         51gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkwTUypetfbi40a7yUCwplrx+RBHVyw2x29kpaOPhT4=;
        b=VYPvV8HAgWa73tHzXhQmgLtNLQF34dQxUXH6edkxvIbfn6uc+VDFGfP2XB5CRWNMO0
         MSFnu2dSp2CPcqOUOAAGJSxeVglj3DTLadj9ryedovYPIqpVAd5tX8cmX+e/pqvgSHKb
         WH5UxF+AqSlnJmoxZRwVNf8DNrali+cEwbup8Wo79iS6W29r/YJal5wH5jPZ0yj2lbO7
         INCKn8qdHCFjLvZdjejdl+pkfXBCpnJiRtJVzeURU1RO+5IfdFBk/aBAQaNX2GmO4hGQ
         9XHCdfVTFWLKPkpexKOvuGdZ8bNWZkqDWnc03Ay5J7W7ziXBqiCc7/X7OZvscYQqFqv2
         ZhKQ==
X-Gm-Message-State: AO0yUKWKD2FCkCGgEtGseYUceg/5DjWnG9NnWe8j69ZIIJgsnRVtcSvv
        p3woiUVy9A3gD4FFhpLjkpXqPQ==
X-Google-Smtp-Source: AK7set/hBcxLlMi3dFarw0MLGHPQBxey3QzObDAiMrnRL16ZFY/iV8hwbEqJvSl91y0Ujhn3MOyFOQ==
X-Received: by 2002:a05:6a20:a004:b0:cc:a93:2b82 with SMTP id p4-20020a056a20a00400b000cc0a932b82mr5292194pzj.58.1677198871421;
        Thu, 23 Feb 2023 16:34:31 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id e24-20020a62aa18000000b005d61829db4fsm3712019pff.168.2023.02.23.16.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 16:34:30 -0800 (PST)
Message-ID: <971726ce-b88a-0e68-45aa-862f821116ae@linaro.org>
Date:   Thu, 23 Feb 2023 18:34:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20230214212417.3315422-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 3:24 PM, Elliot Berman wrote:
> 
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Makefile    |   2 +-
>   drivers/virt/gunyah/vm_mgr.c    |  44 ++++++
>   drivers/virt/gunyah/vm_mgr.h    |  25 ++++
>   drivers/virt/gunyah/vm_mgr_mm.c | 235 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/gunyah.h     |  33 +++++
>   5 files changed, 338 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
> 
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 03951cf82023..ff8bc4925392 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -2,5 +2,5 @@
>   
>   obj-$(CONFIG_GUNYAH) += gunyah.o
>   
> -gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index fd890a57172e..84102bac03cc 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -18,8 +18,16 @@
>   static void gh_vm_free(struct work_struct *work)
>   {
>   	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
> +	struct gh_vm_mem *mapping, *tmp;
>   	int ret;
>   
> +	mutex_lock(&ghvm->mm_lock);
> +	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> +		gh_vm_mem_reclaim(ghvm, mapping);
> +		kfree(mapping);
> +	}
> +	mutex_unlock(&ghvm->mm_lock);
> +
>   	ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
>   	if (ret)
>   		pr_warn("Failed to deallocate vmid: %d\n", ret);
> @@ -48,11 +56,46 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   	ghvm->vmid = vmid;
>   	ghvm->rm = rm;
>   
> +	mutex_init(&ghvm->mm_lock);
> +	INIT_LIST_HEAD(&ghvm->memory_mappings);
>   	INIT_WORK(&ghvm->free_work, gh_vm_free);
>   
>   	return ghvm;
>   }
>   
> +static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct gh_vm *ghvm = filp->private_data;
> +	void __user *argp = (void __user *)arg;
> +	long r;
> +
> +	switch (cmd) {
> +	case GH_VM_SET_USER_MEM_REGION: {
> +		struct gh_userspace_memory_region region;
> +
> +		if (copy_from_user(&region, argp, sizeof(region)))
> +			return -EFAULT;
> +
> +		/* All other flag bits are reserved for future use */
> +		if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC |
> +			GH_MEM_LENT))
> +			return -EINVAL;
> +
> +
> +		if (region.memory_size)

Would there be any value in allowing a zero-size memory
region to be created?  Maybe that doesn't make sense, but
I guess i'm questioning whether a zero memory region size
have special meaning in this interface is a good thing to
do.  You could sensibly have a separate REMOVE_USER_MEM_REGION
request, and still permit 0 to be a valid size.

> +			r = gh_vm_mem_alloc(ghvm, &region);
> +		else
> +			r = gh_vm_mem_free(ghvm, region.label);
> +		break;
> +	}
> +	default:
> +		r = -ENOTTY;
> +		break;
> +	}
> +
> +	return r;
> +}
> +
>   static int gh_vm_release(struct inode *inode, struct file *filp)
>   {
>   	struct gh_vm *ghvm = filp->private_data;
> @@ -65,6 +108,7 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
>   }
>   
>   static const struct file_operations gh_vm_fops = {
> +	.unlocked_ioctl = gh_vm_ioctl,
>   	.release = gh_vm_release,
>   	.compat_ioctl	= compat_ptr_ioctl,
>   	.llseek = noop_llseek,
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index 76954da706e9..97bc00c34878 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -7,16 +7,41 @@
>   #define _GH_PRIV_VM_MGR_H
>   
>   #include <linux/gunyah_rsc_mgr.h>
> +#include <linux/list.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mutex.h>
>   
>   #include <uapi/linux/gunyah.h>
>   
>   long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned long arg);
>   
> +enum gh_vm_mem_share_type {
> +	VM_MEM_SHARE,
> +	VM_MEM_LEND,

Are there any other share types anticipated?  Even if
there were, for now you could use a Boolean to distinguish
between shared or lent (at least until a third option
materializes).

> +};
> +
> +struct gh_vm_mem {
> +	struct list_head list;
> +	enum gh_vm_mem_share_type share_type;
> +	struct gh_rm_mem_parcel parcel;
> +
> +	__u64 guest_phys_addr;
> +	struct page **pages;
> +	unsigned long npages;
> +};
> +
>   struct gh_vm {
>   	u16 vmid;
>   	struct gh_rm *rm;
>   
>   	struct work_struct free_work;
> +	struct mutex mm_lock;
> +	struct list_head memory_mappings;
>   };
>   
> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
> +void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
> +int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
> +struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label);
> +
>   #endif
> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
> new file mode 100644
> index 000000000000..03e71a36ea3b
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gh_vm_mgr: " fmt
> +
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/mm.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +#include "vm_mgr.h"
> +
> +static inline bool page_contiguous(phys_addr_t p, phys_addr_t t)

Is there not some existing function that captures this?
In any case, it's used in one place and I think it would
be clearer to just put the logic there rather than hiding
it behind this function.

> +{
> +	return t - p == PAGE_SIZE;
> +}
> +
> +static struct gh_vm_mem *__gh_vm_mem_find(struct gh_vm *ghvm, u32 label)
> +	__must_hold(&ghvm->mm_lock)
> +{
> +	struct gh_vm_mem *mapping;
> +
> +	list_for_each_entry(mapping, &ghvm->memory_mappings, list)
> +		if (mapping->parcel.label == label)
> +			return mapping;
> +
> +	return NULL;
> +}
> +

. . .

> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 10ba32d2b0a6..d85d12119a48 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -20,4 +20,37 @@
>    */
>   #define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
>   
> +/*
> + * ioctls for VM fds
> + */
> +
> +/**
> + * struct gh_userspace_memory_region - Userspace memory descripion for GH_VM_SET_USER_MEM_REGION
> + * @label: Unique identifer to the region.

Maybe this is described somewhere, but what is the purpose
of the label?  Who uses it?  Is it meant to be a value
only the current owner of a resource understands?  Or does
resource manager use it internally, or what?

> + * @flags: Flags for memory parcel behavior
> + * @guest_phys_addr: Location of the memory region in guest's memory space (page-aligned)
> + * @memory_size: Size of the region (page-aligned)
> + * @userspace_addr: Location of the memory region in caller (userspace)'s memory
> + *
> + * See Documentation/virt/gunyah/vm-manager.rst for further details.
> + */
> +struct gh_userspace_memory_region {
> +	__u32 label;

Define the possible permission values separate from
the structure.

					-Alex

> +#define GH_MEM_ALLOW_READ	(1UL << 0)
> +#define GH_MEM_ALLOW_WRITE	(1UL << 1)
> +#define GH_MEM_ALLOW_EXEC	(1UL << 2)
> +/*
> + * The guest will be lent the memory instead of shared.
> + * In other words, the guest has exclusive access to the memory region and the host loses access.
> + */
> +#define GH_MEM_LENT		(1UL << 3)
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size;
> +	__u64 userspace_addr;
> +};
> +
> +#define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
> +						struct gh_userspace_memory_region)
> +
>   #endif

