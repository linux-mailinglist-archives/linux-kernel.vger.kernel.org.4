Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5614773361D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbjFPQdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjFPQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:33:33 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9630F5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:33:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77a103c5ebbso30421839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686933211; x=1689525211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=resRWGkob1IQnmz+Wjwf9DcmrXuQQYleHyTWv5YGX1M=;
        b=d+ESlMZdKPkUZM8iPGcfx21FG8PurrVCwQBO2SKwQFOVtG85fj0CJT7YVMcRX4N9lO
         mZpMbuUOXJRc1TWsmBFKDIRH9d2P/CyWmsXLEbDJO76T0X9LRSHn15Fq0qIRcpDrvb0i
         xm5WX2W+EDaPmSkzO/fqoRYRnvs3sVKwCYco6nW7p8kDD7X547YoyGu55QtO7DoGDaGF
         3ip7BuosZdTSR5+1V6S+DdomCo8QwlD/xPsEbQde8YAJW2vIvA+I0+g4st3xElcOB9b8
         74xDobCBCCbSPXAEsEaGSPY2PJLj1jgJxR9ZsYG6kwO+L7CeEM1d7xu1DUBgvztfeVe2
         DrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933211; x=1689525211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=resRWGkob1IQnmz+Wjwf9DcmrXuQQYleHyTWv5YGX1M=;
        b=GV3h4elLXkDwsPCVWdB5iUwP6+XjXn+IH8BKW0KokTz5C7jhAwjP66VVYDy/B1BhmK
         c3qPZ3gvRQDUJ9MY26NterLw6Mfs6OEfRV1idNHVlhvOItVIwsDwz0w7Z3Cz77zPH5zO
         iZQPxp/8MVW29Mm2p3UglsZD6pCqWsTBzS6YvzAjRgBdS/U+LCZuUe+1VdrwYy48z4Kj
         24nIsClADFptRVcIIyKFeBxSKJa61CVsUPErHjXL1JdwAhVJW4avRfpKfVnK0X+B5fzF
         yLUhjevaa0QztGi3itmr29Slckm9bVakk5Huvhyxs7K8jLIh46ILYPaUUW4BqI/Q0nvu
         EioA==
X-Gm-Message-State: AC+VfDzT2mcjwdaoIKhfuKaKg+ztPmONFvtU/oHrfGytM6+JhRJvyZFD
        1UVmV7I8QEWinaSdCrfCaDMxNg==
X-Google-Smtp-Source: ACHHUZ6cLDCjP6nI3WGHS8UCPS7OSFUFU7DUbTbcv0TZ5hDyU9vGzkThXihOnW94C+nE4eWtHvs1tg==
X-Received: by 2002:a05:6602:2992:b0:777:b364:bab9 with SMTP id o18-20020a056602299200b00777b364bab9mr2587068ior.6.1686933210677;
        Fri, 16 Jun 2023 09:33:30 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id t12-20020a02c48c000000b0040f94261ab1sm6433067jam.12.2023.06.16.09.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:33:30 -0700 (PDT)
Message-ID: <35cffc70-a04e-e049-1bdf-1c5a250bb84e@linaro.org>
Date:   Fri, 16 Jun 2023 11:33:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 11/25] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
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
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-12-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20230613172054.3959700-12-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 12:20 PM, Elliot Berman wrote:
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I have one trivial comment below.  This patch adds some complexity
but this time around I'm going to assume I checked those things
in some detail previously.  This time I'm doing more of a scan
through the patch and I find it looks good.  (If you want me to
spend more time on this, say so.)

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/virt/gunyah/Makefile    |   2 +-
>   drivers/virt/gunyah/vm_mgr.c    |  59 +++++++-
>   drivers/virt/gunyah/vm_mgr.h    |  26 ++++
>   drivers/virt/gunyah/vm_mgr_mm.c | 232 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/gunyah.h     |  37 +++++
>   5 files changed, 352 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/virt/gunyah/vm_mgr_mm.c
> 
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index e47e25895299c..bacf78b8fa337 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,4 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
> +gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index a43401cb34f7d..297427952b8c7 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -15,6 +15,8 @@
>   
>   #include "vm_mgr.h"
>   
> +static void gh_vm_free(struct work_struct *work);
> +
>   static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   {
>   	struct gh_vm *ghvm;
> @@ -26,20 +28,72 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   	ghvm->parent = gh_rm_get(rm);
>   	ghvm->rm = rm;
>   
> +	mmgrab(current->mm);
> +	ghvm->mm = current->mm;
> +	mutex_init(&ghvm->mm_lock);
> +	INIT_LIST_HEAD(&ghvm->memory_mappings);
> +	INIT_WORK(&ghvm->free_work, gh_vm_free);
> +
>   	return ghvm;
>   }
>   
> -static int gh_vm_release(struct inode *inode, struct file *filp)
> +static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   {
>   	struct gh_vm *ghvm = filp->private_data;
> +	void __user *argp = (void __user *)arg;
> +	long r;

Don't you use "ret" for return values most of the time?
(Not a big deal, maybe there's another reason you used
"r" here.)

> +
> +	switch (cmd) {
> +	case GH_VM_SET_USER_MEM_REGION: {
> +		struct gh_userspace_memory_region region;
> +
> +		/* only allow owner task to add memory */
> +		if (ghvm->mm != current->mm)
> +			return -EPERM;
> +
> +		if (copy_from_user(&region, argp, sizeof(region)))
> +			return -EFAULT;
> +
> +		/* All other flag bits are reserved for future use */
> +		if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC))
> +			return -EINVAL;
> +
> +		r = gh_vm_mem_alloc(ghvm, &region);
> +		break;
> +	}
> +	default:
> +		r = -ENOTTY;
> +		break;
> +	}
>   
> +	return r;
> +}
> +
> +static void gh_vm_free(struct work_struct *work)
> +{
> +	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
> +
> +	gh_vm_mem_reclaim(ghvm);
>   	gh_rm_put(ghvm->rm);
> +	mmdrop(ghvm->mm);
>   	kfree(ghvm);
> +}
> +
> +static int gh_vm_release(struct inode *inode, struct file *filp)
> +{
> +	struct gh_vm *ghvm = filp->private_data;
> +
> +	/* VM will be reset and make RM calls which can interruptible sleep.
> +	 * Defer to a work so this thread can receive signal.
> +	 */
> +	schedule_work(&ghvm->free_work);
>   	return 0;
>   }
>   
>   static const struct file_operations gh_vm_fops = {
>   	.owner = THIS_MODULE,
> +	.unlocked_ioctl = gh_vm_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
>   	.release = gh_vm_release,
>   	.llseek = noop_llseek,
>   };
> @@ -77,8 +131,7 @@ static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
>   err_put_fd:
>   	put_unused_fd(fd);
>   err_destroy_vm:
> -	gh_rm_put(ghvm->rm);
> -	kfree(ghvm);
> +	gh_vm_free(&ghvm->free_work);
>   	return err;
>   }
>   
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index 1e94b58d7d34d..434ef9f662a7a 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -7,14 +7,40 @@
>   #define _GH_VM_MGR_H
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
>   	struct gh_rm *rm;
>   	struct device *parent;
> +
> +	struct work_struct free_work;
> +	struct mm_struct *mm; /* userspace tied to this vm */
> +	struct mutex mm_lock;
> +	struct list_head memory_mappings;
>   };
>   
> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
> +void gh_vm_mem_reclaim(struct gh_vm *ghvm);
> +
>   #endif
> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
> new file mode 100644
> index 0000000000000..6974607f02edd
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
> @@ -0,0 +1,232 @@
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
> +static bool pages_are_mergeable(struct page *a, struct page *b)
> +{
> +	return page_to_pfn(a) + 1 == page_to_pfn(b);
> +}
> +
> +static bool gh_vm_mem_overlap(struct gh_vm_mem *a, u64 addr, u64 size)
> +{
> +	u64 a_end = a->guest_phys_addr + (a->npages << PAGE_SHIFT);
> +	u64 end = addr + size;
> +
> +	return a->guest_phys_addr < end && addr < a_end;
> +}
> +
> +static struct gh_vm_mem *__gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label)
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
> +static void gh_vm_mem_reclaim_mapping(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
> +	__must_hold(&ghvm->mm_lock)
> +{
> +	int ret = 0;
> +
> +	if (mapping->parcel.mem_handle != GH_MEM_HANDLE_INVAL) {
> +		ret = gh_rm_mem_reclaim(ghvm->rm, &mapping->parcel);
> +		if (ret)
> +			pr_warn("Failed to reclaim memory parcel for label %d: %d\n",
> +				mapping->parcel.label, ret);
> +	}
> +
> +	if (!ret) {
> +		unpin_user_pages(mapping->pages, mapping->npages);
> +		account_locked_vm(ghvm->mm, mapping->npages, false);
> +	}
> +
> +	kfree(mapping->pages);
> +	kfree(mapping->parcel.acl_entries);
> +	kfree(mapping->parcel.mem_entries);
> +
> +	list_del(&mapping->list);
> +}
> +
> +void gh_vm_mem_reclaim(struct gh_vm *ghvm)
> +{
> +	struct gh_vm_mem *mapping, *tmp;
> +
> +	mutex_lock(&ghvm->mm_lock);
> +
> +	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> +		gh_vm_mem_reclaim_mapping(ghvm, mapping);
> +		kfree(mapping);
> +	}
> +
> +	mutex_unlock(&ghvm->mm_lock);
> +}
> +
> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
> +{
> +	struct gh_vm_mem *mapping, *tmp_mapping;
> +	struct page *curr_page, *prev_page;
> +	struct gh_rm_mem_parcel *parcel;
> +	int i, j, pinned, ret = 0;
> +	unsigned int gup_flags;
> +	size_t entry_size;
> +	u16 vmid;
> +
> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr) ||
> +		!PAGE_ALIGNED(region->guest_phys_addr))
> +		return -EINVAL;
> +
> +	if (overflows_type(region->guest_phys_addr + region->memory_size, u64))
> +		return -EOVERFLOW;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ret;
> +
> +	mapping = __gh_vm_mem_find_by_label(ghvm, region->label);
> +	if (mapping) {
> +		ret = -EEXIST;
> +		goto unlock;
> +	}
> +
> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +		if (gh_vm_mem_overlap(tmp_mapping, region->guest_phys_addr,
> +					region->memory_size)) {
> +			ret = -EEXIST;
> +			goto unlock;
> +		}
> +	}
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL_ACCOUNT);
> +	if (!mapping) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	mapping->guest_phys_addr = region->guest_phys_addr;
> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
> +	parcel = &mapping->parcel;
> +	parcel->label = region->label;
> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
> +
> +	ret = account_locked_vm(ghvm->mm, mapping->npages, true);
> +	if (ret)
> +		goto free_mapping;
> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL_ACCOUNT);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		mapping->npages = 0; /* update npages for reclaim */
> +		goto unlock_pages;
> +	}
> +
> +	gup_flags = FOLL_LONGTERM;
> +	if (region->flags & GH_MEM_ALLOW_WRITE)
> +		gup_flags |= FOLL_WRITE;
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					gup_flags, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;
> +		goto free_pages;
> +	} else if (pinned != mapping->npages) {
> +		ret = -EFAULT;
> +		mapping->npages = pinned; /* update npages for reclaim */
> +		goto unpin_pages;
> +	}
> +
> +	parcel->n_acl_entries = 2;
> +	mapping->share_type = VM_MEM_SHARE;
> +	parcel->acl_entries = kcalloc(parcel->n_acl_entries, sizeof(*parcel->acl_entries),
> +					GFP_KERNEL);
> +	if (!parcel->acl_entries) {
> +		ret = -ENOMEM;
> +		goto unpin_pages;
> +	}
> +
> +	/* acl_entries[0].vmid will be this VM's vmid. We'll fill it when the
> +	 * VM is starting and we know the VM's vmid.
> +	 */
> +	if (region->flags & GH_MEM_ALLOW_READ)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_R;
> +	if (region->flags & GH_MEM_ALLOW_WRITE)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_W;
> +	if (region->flags & GH_MEM_ALLOW_EXEC)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_X;
> +
> +	ret = gh_rm_get_vmid(ghvm->rm, &vmid);
> +	if (ret)
> +		goto free_acl;
> +
> +	parcel->acl_entries[1].vmid = cpu_to_le16(vmid);
> +	/* Host assumed to have all these permissions. Gunyah will not
> +	 * grant new permissions if host actually had less than RWX
> +	 */
> +	parcel->acl_entries[1].perms = GH_RM_ACL_R | GH_RM_ACL_W | GH_RM_ACL_X;
> +
> +	parcel->n_mem_entries = 1;
> +	for (i = 1; i < mapping->npages; i++) {
> +		if (!pages_are_mergeable(mapping->pages[i - 1], mapping->pages[i]))
> +			parcel->n_mem_entries++;
> +	}
> +
> +	parcel->mem_entries = kcalloc(parcel->n_mem_entries,
> +					sizeof(parcel->mem_entries[0]),
> +					GFP_KERNEL_ACCOUNT);
> +	if (!parcel->mem_entries) {
> +		ret = -ENOMEM;
> +		goto free_acl;
> +	}
> +
> +	/* reduce number of entries by combining contiguous pages into single memory entry */
> +	prev_page = mapping->pages[0];
> +	parcel->mem_entries[0].phys_addr = cpu_to_le64(page_to_phys(prev_page));
> +	entry_size = PAGE_SIZE;
> +	for (i = 1, j = 0; i < mapping->npages; i++) {
> +		curr_page = mapping->pages[i];
> +		if (pages_are_mergeable(prev_page, curr_page)) {
> +			entry_size += PAGE_SIZE;
> +		} else {
> +			parcel->mem_entries[j].size = cpu_to_le64(entry_size);
> +			j++;
> +			parcel->mem_entries[j].phys_addr =
> +				cpu_to_le64(page_to_phys(curr_page));
> +			entry_size = PAGE_SIZE;
> +		}
> +
> +		prev_page = curr_page;
> +	}
> +	parcel->mem_entries[j].size = cpu_to_le64(entry_size);
> +
> +	list_add(&mapping->list, &ghvm->memory_mappings);
> +	mutex_unlock(&ghvm->mm_lock);
> +	return 0;
> +free_acl:
> +	kfree(parcel->acl_entries);
> +unpin_pages:
> +	unpin_user_pages(mapping->pages, pinned);
> +free_pages:
> +	kfree(mapping->pages);
> +unlock_pages:
> +	account_locked_vm(ghvm->mm, mapping->npages, false);
> +free_mapping:
> +	kfree(mapping);
> +unlock:
> +	mutex_unlock(&ghvm->mm_lock);
> +	return ret;
> +}
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 86b9cb60118dd..91d6dd26fcc89 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -20,4 +20,41 @@
>    */
>   #define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
>   
> +/*
> + * ioctls for VM fds
> + */
> +
> +/**
> + * enum gh_mem_flags - Possible flags on &struct gh_userspace_memory_region
> + * @GH_MEM_ALLOW_READ: Allow guest to read the memory
> + * @GH_MEM_ALLOW_WRITE: Allow guest to write to the memory
> + * @GH_MEM_ALLOW_EXEC: Allow guest to execute instructions in the memory
> + */
> +enum gh_mem_flags {
> +	GH_MEM_ALLOW_READ	= 1UL << 0,
> +	GH_MEM_ALLOW_WRITE	= 1UL << 1,
> +	GH_MEM_ALLOW_EXEC	= 1UL << 2,
> +};
> +
> +/**
> + * struct gh_userspace_memory_region - Userspace memory descripion for GH_VM_SET_USER_MEM_REGION
> + * @label: Identifer to the region which is unique to the VM.
> + * @flags: Flags for memory parcel behavior. See &enum gh_mem_flags.
> + * @guest_phys_addr: Location of the memory region in guest's memory space (page-aligned)
> + * @memory_size: Size of the region (page-aligned)
> + * @userspace_addr: Location of the memory region in caller (userspace)'s memory
> + *
> + * See Documentation/virt/gunyah/vm-manager.rst for further details.
> + */
> +struct gh_userspace_memory_region {
> +	__u32 label;
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

