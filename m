Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16269E069
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjBUM3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbjBUM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:29:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A58E055
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:28:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg37-20020a05600c3ca500b003e21e018039so4207980wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJW+7iysMnqIna8Ab5FhntJUCE2PYpB1iw2tSIjI988=;
        b=Lrst/Mb+nD8ttFCNBcZNg31BN7sYfsASpQH+Gk77gwatp6omgAEUjE72qKX+QY4EpP
         ABaEz3pEMy8pU4nRBmvb17XrYzJImsbBfAmKajR3DZyubSlZfxnaYjh8IBTE70JVV7ze
         Cv8k5ceZjNf6FevHXA2pfhg9Ce1m1TTLweoaIQzY7JfAqUoFL6Jxir6XJcAVOKOH+Djb
         8HePbGMue2l+W3dUy3PKpmHnpxnpq3P7tZpGObHG3htRjCVpRVDX4PTaG++UIYV0UvrW
         APfBCO54b+0wgBhhiMOIDxJMaCIf1qjfqn4RD7rE0T2JQLe9gea8FonxbUQEidy1WITo
         gRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJW+7iysMnqIna8Ab5FhntJUCE2PYpB1iw2tSIjI988=;
        b=uA8rlYBMIL+IFZa+tZ+AjJv0ZpWxApnYzYBPYXQpUkdDydufIkGYBizTOWaYpq8qb3
         69EYHpV3pvqN1FcDmnoZ10AzZVBne+v2QjmsxYDUNnxD3gtwR7eYaMDS0jz8L3AHbwxD
         ZdXCGzH0ih6QkbETNIx8R+vmiccryc4TWgvib3gytwH9Hh2Btlau9KhkiQzHEs6XPwdL
         zarHtWrpZd1JkpVwhDH+OEPJ2lYH8KIckgca4OUKoOnSFjI1YKsjeERDt0oeLZO+iLbg
         nmK8EiEpyFM7c0RyK1AfOcQ6rn2I3sK36qrOZK7Fx7TEXf2vUd5lDawv82qe2t355v5S
         YVTA==
X-Gm-Message-State: AO0yUKXDDTgislAUUn8ORN77jrtpVFVM00JQZB4Go2P8TyY/4x1bk8MO
        5gqPf3bf5Em5xwGUNlSBgaTw/A==
X-Google-Smtp-Source: AK7set+OsZuPliSmwbd6noes3vAtUJ154YxisBGvNV8rDjsuKZV3Elgnpp4eR8ZM357b3oj1xvQdUw==
X-Received: by 2002:a05:600c:2e84:b0:3df:e57d:f4ba with SMTP id p4-20020a05600c2e8400b003dfe57df4bamr3752873wmn.7.1676982537649;
        Tue, 21 Feb 2023 04:28:57 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 18-20020a05600c231200b003e20fa01a86sm3982865wmo.13.2023.02.21.04.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 04:28:56 -0800 (PST)
Message-ID: <db397198-d079-faa5-691f-c4b06822d2f3@linaro.org>
Date:   Tue, 21 Feb 2023 12:28:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212417.3315422-1-quic_eberman@quicinc.com>
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



On 14/02/2023 21:24, Elliot Berman wrote:
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
> +			r = gh_vm_mem_alloc(ghvm, &region);
> +		else
> +			r = gh_vm_mem_free(ghvm, region.label);

Looks like we are repurposing GH_VM_SET_USER_MEM_REGION for allocation 
and freeing.

Should we have corresponding GH_VM_UN_SET_USER_MEM_REGION instead for 
freeing? given that label is the only relevant member of struct 
gh_userspace_memory_region in free case.


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

what the behavoir of hypervisor if we failed to reclaim the pages?

> +	}
> +
> +	if (!ret)
So we will leave the user pages pinned if hypervisor call fails, but 
further down we free the mapping all together.

Am not 100% sure if this will have any side-effect, but is it okay to 
leave user-pages pinned with no possiblity of unpinning them in such cases?


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
> +struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label)
> +{
> +	struct gh_vm_mem *mapping;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
new line would be nice here.

> +	mapping = __gh_vm_mem_find(ghvm, label);
> +	mutex_unlock(&ghvm->mm_lock);
new line would be nice here.

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
> +	if (!gh_api_has_feature(GH_API_FEATURE_MEMEXTENT))
> +		return -EOPNOTSUPP;

Should this not be first thing to do in ioctl before even entering this 
function?

> +
> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr) || !PAGE_ALIGNED(region->guest_phys_addr))
> +		return -EINVAL;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ret;
new line.

> +	mapping = __gh_vm_mem_find(ghvm, region->label);
> +	if (mapping) {
> +		mutex_unlock(&ghvm->mm_lock);
> +		return -EEXIST;
> +	}
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> +	if (!mapping) {
> +		ret = -ENOMEM;
> +		goto free_mapping;

how about,

mutex_unlock(&ghvm->mm_lock);
return -ENMEM;

> +	}
> +
> +	mapping->parcel.label = region->label;
> +	mapping->guest_phys_addr = region->guest_phys_addr;
> +	mapping->npages = region->memory_size >> PAGE_SHIFT;
> +	parcel = &mapping->parcel;
> +	parcel->mem_handle = GH_MEM_HANDLE_INVAL; /* to be filled later by mem_share/mem_lend */
> +	parcel->mem_type = GH_RM_MEM_TYPE_NORMAL;
> +
> +	/* Check for overlap */
> +	list_for_each_entry(tmp_mapping, &ghvm->memory_mappings, list) {
> +		if (!((mapping->guest_phys_addr + (mapping->npages << PAGE_SHIFT) <=
> +			tmp_mapping->guest_phys_addr) ||
> +			(mapping->guest_phys_addr >=
> +			tmp_mapping->guest_phys_addr + (tmp_mapping->npages << PAGE_SHIFT)))) {
> +			ret = -EEXIST;
> +			goto free_mapping;
> +		}
> +	}
> +
> +	list_add(&mapping->list, &ghvm->memory_mappings);
> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		mapping->npages = 0; /* update npages for reclaim */
> +		goto reclaim;
> +	}
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;
> +		mapping->npages = 0; /* update npages for reclaim */
> +		goto reclaim;
> +	} else if (pinned != mapping->npages) {
> +		ret = -EFAULT;
> +		mapping->npages = pinned; /* update npages for reclaim */
> +		goto reclaim;
> +	}
> +
> +	if (region->flags & GH_MEM_LENT) {
> +		parcel->n_acl_entries = 1;
> +		mapping->share_type = VM_MEM_LEND;
> +	} else {
> +		parcel->n_acl_entries = 2;
> +		mapping->share_type = VM_MEM_SHARE;
> +	}
> +	parcel->acl_entries = kcalloc(parcel->n_acl_entries, sizeof(*parcel->acl_entries),
> +					GFP_KERNEL);
> +	if (!parcel->acl_entries) {
> +		ret = -ENOMEM;
> +		goto reclaim;
> +	}
> +
> +	parcel->acl_entries[0].vmid = cpu_to_le16(ghvm->vmid);
new line
> +	if (region->flags & GH_MEM_ALLOW_READ)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_R;
> +	if (region->flags & GH_MEM_ALLOW_WRITE)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_W;
> +	if (region->flags & GH_MEM_ALLOW_EXEC)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_X;
> +
> +	if (mapping->share_type == VM_MEM_SHARE) {
> +		ret = gh_rm_get_vmid(ghvm->rm, &vmid);
> +		if (ret)
> +			goto reclaim;
> +
> +		parcel->acl_entries[1].vmid = cpu_to_le16(vmid);
> +		/* Host assumed to have all these permissions. Gunyah will not
> +		 * grant new permissions if host actually had less than RWX
> +		 */
> +		parcel->acl_entries[1].perms |= GH_RM_ACL_R | GH_RM_ACL_W | GH_RM_ACL_X;
> +	}
> +
> +	mem_entries = kcalloc(mapping->npages, sizeof(*mem_entries), GFP_KERNEL);
> +	if (!mem_entries) {
> +		ret = -ENOMEM;
> +		goto reclaim;
> +	}
> +
> +	/* reduce number of entries by combining contiguous pages into single memory entry */
> +	prev_page = page_to_phys(mapping->pages[0]);
> +	mem_entries[0].ipa_base = cpu_to_le64(prev_page);
> +	entry_size = PAGE_SIZE;
new line
> +	for (i = 1, j = 0; i < mapping->npages; i++) {
> +		curr_page = page_to_phys(mapping->pages[i]);
> +		if (page_contiguous(prev_page, curr_page)) {
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
> +	mapping = __gh_vm_mem_find(ghvm, label);
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
> + * @flags: Flags for memory parcel behavior
> + * @guest_phys_addr: Location of the memory region in guest's memory space (page-aligned)#

Note about overlapping here would be useful.

> + * @memory_size: Size of the region (page-aligned)
> + * @userspace_addr: Location of the memory region in caller (userspace)'s memory
> + *
> + * See Documentation/virt/gunyah/vm-manager.rst for further details.
> + */
> +struct gh_userspace_memory_region {
> +	__u32 label;
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
