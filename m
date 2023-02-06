Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6FB68C2B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjBFQNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjBFQNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:13:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63610A8F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:13:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d14so10866325wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mAvudNFftbYPGJ/wOqY8UXA/T5UpeFO6vMP45zNs2N0=;
        b=MC+50Wfl3iw2A0V1e2xrVoUA16TZ2fEOnfier9HTUwRPhrCPIhzGAz04SiR98TI39W
         Wm/fcaC2IkL8uuLEA1G27dIZT+hv6MgKaTQlpWfl/a7cFmKbve9t4Fzwwho2cjQiKInm
         +RdccHLasOeQMnOf+2Xr/xIYAR3rkHNwDhuAUsY2GfwOS8F6bg/jxCrANunNR+ECcV3f
         n/8GHeDSkvSj/NOyclQeanlge5CTO76ik4bXTmM9rhXVHPBN+HFMvDkFTRMx8EWSJreN
         IJZCvW+wTu4nauC49K/Bhx7TEM+HVAT2VhIf52h4EPKU3XNZiBmsae8tAVkU4lAWqHsL
         N1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAvudNFftbYPGJ/wOqY8UXA/T5UpeFO6vMP45zNs2N0=;
        b=4of+plR5utsOLaMg3P5Vi2GbSTLteeEf0/1pcPVzqdCcgVEoqzv92W0xjIJlT54p2L
         xWNK0p0GNG4mKTIGKSafEseWkxHMG3sf60eIzQ4ujPLP6xP0qqoGOTMI9YaOB+mwqAsw
         WbjStQPzUoht4yYWNnJCskJW0C9wkfoud8PRoGtNl7XG62vWxgy556cdGWjU0gjSOvLs
         qAEhIyFIbaI9I1ArlATL3oWiOFF15vKtfANVgt/qhJCW/YfdUyD1mv3ApgxvdI/0OIyt
         bRYgOR/MJfs/Fkrxk52EDAmpZHwRjevUV6KyTVcBcisynrGPTsEC1CI0jSJ7CuBe7v4C
         8dUQ==
X-Gm-Message-State: AO0yUKW/flVcNUtcy9UN93z0VvOUzpbC64aEvPYTo2D777F5qj0cbdlg
        wHsWU6sc9m/9mD5CAVYQKA40Fg==
X-Google-Smtp-Source: AK7set8ENvI2At6Nu7CPauH8827z6d6FxXYnMa+67wfn4skgFTtqXBH8eGtty6DgBUwRwIkeMs2U5A==
X-Received: by 2002:a05:6000:1b04:b0:2c3:def9:7e1a with SMTP id f4-20020a0560001b0400b002c3def97e1amr6851838wrz.44.1675699981540;
        Mon, 06 Feb 2023 08:13:01 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id d17-20020a5d5391000000b002bfbf7679absm9040325wrv.107.2023.02.06.08.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 08:13:00 -0800 (PST)
Message-ID: <36950638-6aae-f115-86e5-97606a5d67fe@linaro.org>
Date:   Mon, 6 Feb 2023 16:12:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 13/27] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-14-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-14-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 22:46, Elliot Berman wrote:
> When launching a virtual machine, Gunyah userspace allocates memory for
> the guest and informs Gunyah about these memory regions through
> SET_USER_MEMORY_REGION ioctl.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Makefile    |   2 +-
>   drivers/virt/gunyah/vm_mgr.c    |  46 +++++++
>   drivers/virt/gunyah/vm_mgr.h    |  28 +++-
>   drivers/virt/gunyah/vm_mgr_mm.c | 223 ++++++++++++++++++++++++++++++++
>   include/uapi/linux/gunyah.h     |  22 ++++
>   5 files changed, 319 insertions(+), 2 deletions(-)
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
> index 0864dbd77e28..b847fde63333 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -35,14 +35,55 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
>   	ghvm->vmid = vmid;
>   	ghvm->rm = rm;
>   
> +	mutex_init(&ghvm->mm_lock);
> +	INIT_LIST_HEAD(&ghvm->memory_mappings);
> +
>   	return ghvm;
>   }
>   
>   static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   {
> +	struct gunyah_vm *ghvm = filp->private_data;
> +	void __user *argp = (void __user *)arg;
>   	long r;
>   
>   	switch (cmd) {
> +	case GH_VM_SET_USER_MEM_REGION: {
> +		struct gunyah_vm_memory_mapping *mapping;
> +		struct gh_userspace_memory_region region;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&region, argp, sizeof(region)))
> +			break;
Why not be explict about the error codes, do something like.

if (copy_from_user(&region, argp, sizeof(region)))
	return -EFAULT;


setting r value everytime before starting any code is making the code 
more reader unfriendly.


> +
> +		r = -EINVAL;
> +		/* All other flag bits are reserved for future use */
> +		if (region.flags & ~(GH_MEM_ALLOW_READ | GH_MEM_ALLOW_WRITE | GH_MEM_ALLOW_EXEC |
> +			GH_MEM_LENT))
> +			break;
> +
> +
> +		if (region.memory_size) {

This behaviour allocating memory in presense of valid memory_size and 
finding memory in cases of zero size needs to be described properly in 
the uapi so that the users are aware of this.

> +			r = 0;
> +			mapping = gh_vm_mem_mapping_alloc(ghvm, &region);
> +			if (IS_ERR(mapping)) {
> +				r = PTR_ERR(mapping);
> +				break;
> +			}
> +		} else {
> +			mapping = gh_vm_mem_mapping_find(ghvm, region.label);
> +			if (IS_ERR(mapping)) {
> +				r = PTR_ERR(mapping);
> +				break;
> +			}
> +			r = 0;
> +			if (!mapping)
> +				break;
> +			gh_vm_mem_mapping_reclaim(ghvm, mapping);
> +			kfree(mapping);
> +		}
> +		break;
> +	}
>   	default:
>   		r = -ENOTTY;
>   		break;
> @@ -54,7 +95,12 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   static int gh_vm_release(struct inode *inode, struct file *filp)
>   {
>   	struct gunyah_vm *ghvm = filp->private_data;
> +	struct gunyah_vm_memory_mapping *mapping, *tmp;
>   
Locking?
> +	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> +		gh_vm_mem_mapping_reclaim(ghvm, mapping);
> +		kfree(mapping);
> +	}
>   	put_gh_rm(ghvm->rm);
>   	kfree(ghvm);
>   	return 0;
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index e47f34de7f9e..6b38bf780f76 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -7,14 +7,40 @@
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
> +enum gunyah_vm_mem_share_type {
> +	VM_MEM_SHARE,
> +	VM_MEM_LEND,
> +};
> +
> +struct gunyah_vm_memory_mapping {
> +	struct list_head list;
> +	enum gunyah_vm_mem_share_type share_type;
> +	struct gh_rm_mem_parcel parcel;
> +
> +	__u64 guest_phys_addr;
> +	struct page **pages;
> +	unsigned long npages;
> +};
> +
>   struct gunyah_vm {
>   	u16 vmid;
> -	struct gh_rm_rpc *rm;
> +	struct gh_rm *rm;
> +
> +	struct mutex mm_lock;
> +	struct list_head memory_mappings;
>   };
>   
> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
> +							struct gh_userspace_memory_region *region);
> +void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_mapping *mapping);
> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label);
> +
>   #endif
> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
> new file mode 100644
> index 000000000000..f2dbdb4ee8ab
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
> @@ -0,0 +1,223 @@
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
> +static struct gunyah_vm_memory_mapping *__gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label)
> +{
> +	struct gunyah_vm_memory_mapping *mapping;
> +
> +
only one line.
> +	list_for_each_entry(mapping, &ghvm->memory_mappings, list)
> +		if (mapping->parcel.label == label)
> +			return mapping;
> +
> +	return NULL;
> +}
> +
> +void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_mapping *mapping)
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
> +	mutex_lock(&ghvm->mm_lock);
> +	list_del(&mapping->list);
> +	mutex_unlock(&ghvm->mm_lock);
> +}
> +
> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label)
> +{
> +	struct gunyah_vm_memory_mapping *mapping;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	mapping = __gh_vm_mem_mapping_find(ghvm, label);
> +	mutex_unlock(&ghvm->mm_lock);
> +	return mapping ? : ERR_PTR(-ENODEV);
> +}
> +
> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
> +							struct gh_userspace_memory_region *region)
> +{
Is this a static functoin or an exported symbol?

> +	phys_addr_t curr_page, prev_page;
> +	struct gunyah_vm_memory_mapping *mapping, *tmp_mapping;
> +	struct gh_rm_mem_entry *mem_entries;
> +	int i, j, pinned, ret = 0;
> +	struct gh_rm_mem_parcel *parcel;
> +	size_t entry_size;
> +	u16 vmid; > +
Reverse christmas tree to sor local variables would be nice.

> +	if (!region->memory_size || !PAGE_ALIGNED(region->memory_size) ||
> +		!PAGE_ALIGNED(region->userspace_addr))
Even this alignment needs some documentation.

Or why not just let the user only pass number of pages instead of size?


> +		return ERR_PTR(-EINVAL);
> +
> +	if (!gh_api_has_feature(GH_API_FEATURE_MEMEXTENT))
> +		return ERR_PTR(-EOPNOTSUPP);

We should proabably move this as very first check while handling this IOCTL.


> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	mapping = __gh_vm_mem_mapping_find(ghvm, region->label);

so label is unique and userspace proabably aware of this?
Can we have more than one userspace doing this? and if so how can it 
ensure that each label is unique?


> +	if (mapping) {
> +		mutex_unlock(&ghvm->mm_lock);
> +		return ERR_PTR(-EEXIST);
> +	}
> +
> +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> +	if (!mapping) {
> +		ret = -ENOMEM;
> +		goto unlock;
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
> +			goto unlock;
> +		}
> +	}
This looks like we will loop every mappign for each allocation giving us 
an O(n), How frequent and how many max mappings can be there in the system?

> +
> +	list_add(&mapping->list, &ghvm->memory_mappings);
> +unlock:
> +	mutex_unlock(&ghvm->mm_lock);
> +	if (ret)
> +		goto free_mapping;
> +
> +	mapping->pages = kcalloc(mapping->npages, sizeof(*mapping->pages), GFP_KERNEL);
> +	if (!mapping->pages) {
> +		ret = -ENOMEM;
> +		goto reclaim;
> +	}
> +
> +	pinned = pin_user_pages_fast(region->userspace_addr, mapping->npages,
> +					FOLL_WRITE | FOLL_LONGTERM, mapping->pages);
> +	if (pinned < 0) {
> +		ret = pinned;
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
> +	parcel->acl_entries = kcalloc(parcel->n_acl_entries,
> +						sizeof(*parcel->acl_entries),
> +						GFP_KERNEL);
> +	if (!parcel->acl_entries) {
> +		ret = -ENOMEM;
> +		goto reclaim;
> +	}
> +
> +	parcel->acl_entries[0].vmid = cpu_to_le16(ghvm->vmid);
> +	if (region->flags & GH_MEM_ALLOW_READ)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_R;
> +	if (region->flags & GH_MEM_ALLOW_WRITE)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_W;
> +	if (region->flags & GH_MEM_ALLOW_EXEC)
> +		parcel->acl_entries[0].perms |= GH_RM_ACL_X;
> +
> +	if (mapping->share_type == VM_MEM_SHARE) {
> +		ret = gh_rm_get_vmid(ghvm->rm, &vmid);
> +		if (ret) {
> +			if (ret > 0) {
> +				pr_warn("RM failed to get this VM's VMID: %d", ret);
> +				ret = -EINVAL;
> +			}
> +			goto reclaim;
> +		}
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
> +	return mapping;
> +reclaim:
> +	gh_vm_mem_mapping_reclaim(ghvm, mapping);
> +free_mapping:
> +	kfree(mapping);
> +	return ERR_PTR(ret);
> +}
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 88a40d6e0b96..574f33b198d0 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -20,4 +20,26 @@
>    */
>   #define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
>   
> +/*
> + * ioctls for VM fds
> + */
> +struct gh_userspace_memory_region {

This struct needs some kernedoc.

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
if we are only expecting pages, this should probably be make explict by 
using nr_pages instead of size

> +	__u64 userspace_addr;
> +};
> +
> +#define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
> +						struct gh_userspace_memory_region)
> +
>   #endif
