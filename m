Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5E6D2280
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjCaO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjCaO0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:26:53 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7320634
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r5so21812644qtp.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272780; x=1682864780;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l5xTO2bAfCdeDlG8Z0JydV0a/7hP8q3ZK6XMz6VrT0E=;
        b=nA5ZIobtuy1bCNwR4gjyFn0T+4kkF7t+iEbH3dbLTAIFOVe5+bfX4/VoGHcHBzGB/W
         1rlzzVhcMYgGyH+NqlQmi5yp93dhGTWaKnhfT6hKD2TKFJDxteoba0CFBn/cRT15euc1
         gBLGwovMaGVldE5FqAmfqgQCnTJa7nUUB9DOV3fjjipqunAhzfT7CnT0R3VdMFptjodn
         Fw9R0Ku6ccQR1RVjd1r0TymSewxbs4dIIvVfj47QYkEu+B8mDJOAivoDJ8KGsTUS9usn
         qNB+UmilxH8V/APY6fcvTshJJICOWHJBgetNDmN2Nffo/UgGXNENyxWV8ojCi7gM58lZ
         qGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272780; x=1682864780;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5xTO2bAfCdeDlG8Z0JydV0a/7hP8q3ZK6XMz6VrT0E=;
        b=EsvZTF6EB9hu/4uGM51iy/zVl+TRgn1K67qmPAXTWjlTA3BLQ5nzBnWI0/ApN5a1sV
         GWRXtHvv4wnFaqKi6qJ77V9X0tYK3U85DJn6mcu5OlQ4AuL3alqpGwAu+/eFkLImWFf+
         8B819SDZO0WRjK84mFSnhJXwiesHeZw7XRYHdxqJTD90t9G0Uqucdqfx7AsSCwKYlpma
         5wwEqKQufXDsraA1kWXG0Hrq2nosQzN4M6XsUScsmxLjETsbKrS8rfzoLOmCSF58Sb0X
         EMH85fb5ks9C9tpGXe0F1YdpJHFPYIQ0gtun7PumglVs6hKuOqYhrPBjOaAbUX9kxxcK
         inow==
X-Gm-Message-State: AAQBX9eVOFKwDGkqGimnH08kUvOCvJaGxtUd6qeaKn6ak0VDDsueIjh/
        MIUNJaOgolEFdHtDtXT6Fz8AxA==
X-Google-Smtp-Source: AKy350ZjKYOzYTsTLQ9sMNYxkkCY6kQFDJnn8z1906Eznbn+zaiLN7okTF43jTWXw8+6STlBsnSBcw==
X-Received: by 2002:a05:622a:211:b0:3d8:519a:91c9 with SMTP id b17-20020a05622a021100b003d8519a91c9mr15644361qtx.8.1680272780061;
        Fri, 31 Mar 2023 07:26:20 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id q201-20020a3743d2000000b007424376ca4bsm704663qka.18.2023.03.31.07.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:26:19 -0700 (PDT)
Message-ID: <3b4e230c-6635-43f6-99ce-1ed51b55a450@linaro.org>
Date:   Fri, 31 Mar 2023 09:26:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 12/26] gunyah: vm_mgr: Add/remove user memory regions
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
 <20230304010632.2127470-13-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-13-quic_eberman@quicinc.com>
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
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I have quite a few suggestions here, but I don't think I identified
any bugs.

					-Alex

> ---
>   drivers/virt/gunyah/Makefile    |   2 +-
>   drivers/virt/gunyah/vm_mgr.c    |  44 ++++++
>   drivers/virt/gunyah/vm_mgr.h    |  25 ++++
>   drivers/virt/gunyah/vm_mgr_mm.c | 229 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/gunyah.h     |  29 ++++
>   5 files changed, 328 insertions(+), 1 deletion(-)
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
> index dbacf36af72d..e950274c6a53 100644
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
> @@ -47,11 +55,44 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
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
> +		if (!gh_api_has_feature(GH_FEATURE_MEMEXTENT))
> +			return -EOPNOTSUPP;
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
> +
> +	return r;
> +}
> +
>   static int gh_vm_release(struct inode *inode, struct file *filp)
>   {
>   	struct gh_vm *ghvm = filp->private_data;
> @@ -64,6 +105,9 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
>   }
>   
>   static const struct file_operations gh_vm_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = gh_vm_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
>   	.release = gh_vm_release,
>   	.llseek = noop_llseek,
>   };
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index 4b22fbcac91c..c9f6fa5478ed 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -7,17 +7,42 @@
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
>   	struct device *parent;
>   
>   	struct work_struct free_work;
> +	struct mutex mm_lock;
> +	struct list_head memory_mappings;
>   };
>   
> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region);
> +void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
> +int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
> +struct gh_vm_mem *gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label);
> +
>   #endif
> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
> new file mode 100644
> index 000000000000..db6f55cef37f
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
> @@ -0,0 +1,229 @@
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

I think you should call this function gh_vm_mem_reclaim_mapping().
Then add a new function with this name, which takes only a ghvm
argument, and will take mm_lock and call this function to reclaim
all mappings on a VM.  That encapsulates some code found in
gh_vm_free().  (You could use a similar model for removing
functions, as well as tickets and resources, and use them
gh_vm_free().)

> +void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
> +	__must_hold(&ghvm->mm_lock)
> +{
> +	int i, ret = 0;
> +
> +	if (mapping->parcel.mem_handle != GH_MEM_HANDLE_INVAL) {
> +		ret = gh_rm_mem_reclaim(ghvm->rm, &mapping->parcel);
> +		if (ret)
> +			pr_warn("Failed to reclaim memory parcel for label %d: %d\n",
> +				mapping->parcel.label, ret);
> +	}
> +
> +	if (!ret)
> +		for (i = 0; i < mapping->npages; i++)
> +			unpin_user_page(mapping->pages[i]);
> +
> +	kfree(mapping->pages);
> +	kfree(mapping->parcel.acl_entries);
> +	kfree(mapping->parcel.mem_entries);
> +
> +	list_del(&mapping->list);
> +}
> +

The next function is never used.  Can you get rid of it for
now, and add it if/when needed?

> +struct gh_vm_mem *gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label)
> +{
> +	struct gh_vm_mem *mapping;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	mapping = __gh_vm_mem_find_by_label(ghvm, label);
> +	mutex_unlock(&ghvm->mm_lock);
> +
> +	return mapping ? : ERR_PTR(-ENODEV);
> +}
> +
> +int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *region)
> +{
> +	struct gh_vm_mem *mapping, *tmp_mapping;
> +	struct gh_rm_mem_entry *mem_entries;
> +	phys_addr_t curr_page, prev_page;
> +	struct gh_rm_mem_parcel *parcel;
> +	int i, j, pinned, ret = 0;
> +	size_t entry_size;
> +	u16 vmid;
> +
> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr) || !PAGE_ALIGNED(region->guest_phys_addr))

A clever trick would be to use:

	allofem = region->memory_size |
		  region->userspace_addr | 		
		  region->guest_phys_addr;
	if (!region->memory size || !PAGE_ALIGNED(allofem))

But that's just a clever trick.

> +		return -EINVAL;
> +
> +	if (region->guest_phys_addr + region->memory_size < region->guest_phys_addr)
> +		return -EOVERFLOW;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ret;
> +
> +	mapping = __gh_vm_mem_find_by_label(ghvm, region->label);
> +	if (mapping) {
> +		mutex_unlock(&ghvm->mm_lock);
> +		return -EEXIST;
> +	}
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> +	if (!mapping) {
> +		mutex_unlock(&ghvm->mm_lock);
> +		return -ENOMEM;
> +	}
> +
> +	mapping->parcel.label = region->label;
> +	mapping->guest_phys_addr = region->guest_phys_addr;
> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
> +	parcel = &mapping->parcel;

Assign parcel->label here instead.

> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
> +
> +	/* Check for overlap */

See my other suggestion about using a common helper here.

> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
> +			tmp_mapping->guest_phys_addr) ||

I *think* this || is supposed to be &&.  But I find the way this
is formatted (and negated) makes this all more confusing than
it should be.

> +			(mapping->guest_phys_addr >=
> +			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {

I think this little block of code is worthy of its own function
to allow it to be examined in isolation (and maybe be explained).

static bool gh_vm_mem_overlap(struct gh_vm_mem *a, struct gh_vm_mem *b)
{
	u64 a_end = a->guest_phys_addr + a->npages << PAGE_SHIFT;
	u64 b_end = b->guest_phys_addr + b->npages << PAGE_SHIFT;

	return a->guest_phys_addr < b_end && b->guest_phys_addr < a_end;
}

> +			ret = -EEXIST;
> +			goto free_mapping;
> +		}
> +	}
> +
> +	list_add(&mapping->list, &ghvm->memory_mappings);

You should defer adding the mapping to the list.  More below.

> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		mapping->npages = 0; /* update npages for reclaim */

If you haven't added it to the list, you can goto free_mapping
here instead.

> +		goto reclaim;
> +	}
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;

I would suggest having a new err_free_pages label that frees
mapping->pages, just before free_mapping.

> +		mapping->npages = 0; /* update npages for reclaim */
> +		goto reclaim;

Now that you actually have something to reclaim, add the
mapping to the VM mappings list.

> +	} else if (pinned != mapping->npages) {
> +		ret = -EFAULT;
> +		mapping->npages = pinned; /* update npages for reclaim */
> +		goto reclaim;
> +	}
> +
> +	parcel->n_acl_entries = 2;
> +	mapping->share_type = VM_MEM_SHARE;
> +	parcel->acl_entries = kcalloc(parcel->n_acl_entries, sizeof(*parcel->acl_entries),
> +					GFP_KERNEL);
> +	if (!parcel->acl_entries) {
> +		ret = -ENOMEM;
> +		goto reclaim;
> +	}
> +
> +	parcel->acl_entries[0].vmid = cpu_to_le16(ghvm->vmid);
> +
> +	if (region->flags & GH_MEM_ALLOW_READ)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_R;
> +	if (region->flags & GH_MEM_ALLOW_WRITE)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_W;
> +	if (region->flags & GH_MEM_ALLOW_EXEC)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_X;
> +
> +	if (mapping->share_type == VM_MEM_SHARE) {

There is no need for this conditional test.  The share_type *is*
VM_MEM_SHARE (you just set it to that).

> +		ret = gh_rm_get_vmid(ghvm->rm, &vmid);
> +		if (ret)
> +			goto reclaim;
> +
> +		parcel->acl_entries[1].vmid = cpu_to_le16(vmid);
> +		/* Host assumed to have all these permissions. Gunyah will not
> +		 * grant new permissions if host actually had less than RWX
> +		 */
> +		parcel->acl_entries[1].perms |= GH_RM_ACL_R | GH_RM_ACL_W | GH_RM_ACL_X;

The perms value is already zero here.  Just use =, not |=.

> +	}
> +
> +	mem_entries = kcalloc(mapping->npages, sizeof(*mem_entries), GFP_KERNEL);
> +	if (!mem_entries) {
> +		ret = -ENOMEM;
> +		goto reclaim;
> +	}
> +
> +	/* reduce number of entries by combining contiguous pages into single memory entry */

Are you sure you need to do this?  I.e., does pin_user_pages_fast()
already take care of consolidating these pages?

> +	prev_page = page_to_phys(mapping->pages[0]);
> +	mem_entries[0].ipa_base = cpu_to_le64(prev_page);
> +	entry_size = PAGE_SIZE;
> +	for (i = 1, j = 0; i < mapping->npages; i++) {
> +		curr_page = page_to_phys(mapping->pages[i]);

I think you can actually use the page frame numbers
here instead of the addresses.  If they are consecutive,
they are contiguous.  See pages_are_mergeable() for an
example of that.  Using PFNs might simplify this code.

> +		if (curr_page - prev_page == PAGE_SIZE) {
> +			entry_size += PAGE_SIZE;
> +		} else {
> +			mem_entries[j].size = cpu_to_le64(entry_size);
> +			j++;
> +			mem_entries[j].ipa_base = cpu_to_le64(curr_page);
> +			entry_size = PAGE_SIZE;
> +		}
> +
> +		prev_page = curr_page;
> +	}
> +	mem_entries[j].size = cpu_to_le64(entry_size);

It might be messier, but it seems like you could scan the pages to
see how many you'll need (after combining), then allocate the array
of mem entries based on that.  That is, do that rather than allocating,
filling, then duplicating and freeing.

	count = 1;
	curr_page = mapping->pages[0];
	for (i = 1; i < mapping->npages; i++) {
		next_page = mapping->pages[i];
		if (page_to_pfn(next_page) !=
			    page_to_pfn(curr_page) + 1)
			count++;
		curr_page = next_page;
	}
	parcel->n_mem_entries = count;
	parcel->mem_entries = kcalloc(count, ...);
	/* Then fill them up */

(Not tested, but you get the idea.)

> +
> +	parcel->n_mem_entries = j + 1;
> +	parcel->mem_entries = kmemdup(mem_entries, sizeof(*mem_entries) * parcel->n_mem_entries,
> +					GFP_KERNEL);
> +	kfree(mem_entries);
> +	if (!parcel->mem_entries) {
> +		ret = -ENOMEM;
> +		goto reclaim;
> +	}
> +
> +	mutex_unlock(&ghvm->mm_lock);
> +	return 0;
> +reclaim:
> +	gh_vm_mem_reclaim(ghvm, mapping);
> +free_mapping:
> +	kfree(mapping);
> +	mutex_unlock(&ghvm->mm_lock);
> +	return ret;
> +}
> +
> +int gh_vm_mem_free(struct gh_vm *ghvm, u32 label)
> +{
> +	struct gh_vm_mem *mapping;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ret;
> +
> +	mapping = __gh_vm_mem_find_by_label(ghvm, label);
> +	if (!mapping)
> +		goto out;
> +
> +	gh_vm_mem_reclaim(ghvm, mapping);
> +	kfree(mapping);
> +out:
> +	mutex_unlock(&ghvm->mm_lock);
> +	return ret;
> +}
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 10ba32d2b0a6..a19207e3e065 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -20,4 +20,33 @@
>    */
>   #define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
>   
> +/*
> + * ioctls for VM fds
> + */
> +

I think you should define the following three values in an enum.

> +#define GH_MEM_ALLOW_READ	(1UL << 0)
> +#define GH_MEM_ALLOW_WRITE	(1UL << 1)
> +#define GH_MEM_ALLOW_EXEC	(1UL << 2)
> +
> +/**
> + * struct gh_userspace_memory_region - Userspace memory descripion for GH_VM_SET_USER_MEM_REGION
> + * @label: Unique identifer to the region.

Unique with respect to what?  I think it's unique among memory
regions defined within a VM.  And I think it's arbitrary and
defined by the caller (right?).

> + * @flags: Flags for memory parcel behavior
> + * @guest_phys_addr: Location of the memory region in guest's memory space (page-aligned)
> + * @memory_size: Size of the region (page-aligned)
> + * @userspace_addr: Location of the memory region in caller (userspace)'s memory
> + *
> + * See Documentation/virt/gunyah/vm-manager.rst for further details.
> + */
> +struct gh_userspace_memory_region {
> +	__u32 label;
> +	__u32 flags;

Add a comment to indicate what types of values "flags" can have.
Maybe "flags" should be called "perms" or something?

> +	__u64 guest_phys_addr;
> +	__u64 memory_size;
> +	__u64 userspace_addr;

Why isn't userspace_addr just a (void *)?  That would be a more natural
thing to pass to the kernel.  Is it to avoid 32-bit/64-bit pointer
differences in the API?

> +};
> +
> +#define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
> +						struct gh_userspace_memory_region)
> +

I think it's nicer to group the definitions of these IOCTL values.
Then in the struct definitions that follow, you can add comment that
indicates which IOCTL the struct is used for.

>   #endif

