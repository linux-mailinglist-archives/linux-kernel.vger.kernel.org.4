Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8968D5A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjBGLhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjBGLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:37:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6261FFF3E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:36:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o36so10820440wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 03:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mdps6QBYo2EpuvJeAjXIcH3c9RsvgZrrYv9TzRjo4cg=;
        b=PwiGU5LiVPMC55a4jM5WbxdWafNPqkDEJ6q+rPKmDoWesqzTsxe5weTgyhsUiUtJLl
         +6TQVnSw3OPz4j92KQNzOYF3LzD+WtWoktbQFWk7+vkdCJSG6WMVx1Eu8fCGKtkD0ypZ
         LFe6ZfTUt4lPsrszA3zzWv7k0yoYPdq3PjldNi/jPbF4Gg73S5aFSJsNXBywyDpH+ndu
         0KVZbabl7Pxa5Zlw5E70x9iZQDmAQnRewS2XBOGurDpP0F52GKCbdJ4GqyPTm73lO7u9
         zB51SJcBRdfgkDxZ/xf6esONMzqwIzZfYQk1qkTq6uUPsmj/43zf68ImwLF5wy+oCB1J
         pOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdps6QBYo2EpuvJeAjXIcH3c9RsvgZrrYv9TzRjo4cg=;
        b=sKoxWNQxQnBL3puRIJV0uyx+4t7/fhTo/cYabO1Md/zsb5xc0y8eAiBa8vfsDIAK61
         rbXtSJJDaIz+6HYTXUfkRN7MhHxCV0gOQWL81DXHd0LESBRjKD/YpC69BUIPRPCtLCra
         DFn9WrUwMhF9cEq9nyaO31UbtW57sTp3VvtYmFE65BvFvLlughBowVpDx/GOLbBzb2CL
         InOyc7ZWp7s2bGfFSLgRFOCJEyxRjLQICEso8SX3q689n072w86x0jEgEEe+QhpC0KaH
         SNxqaU/C2oTv34XVYJY3xwEq9e1afIU81+gsviJYNA+6hhBdLCwP2MMDKC5T5cXg+ltP
         RN1w==
X-Gm-Message-State: AO0yUKVTBx6n+XyihDlCsCrJoBX4rcTJ5NNSce7m2X+n0b5GETwAGu3L
        cvAY88z4ktcGGsBiiKjVkpm1pA==
X-Google-Smtp-Source: AK7set9n+m4pjXErkmugtRMuy4NBW/6r4G9q7oXcQhxqaTVJO4e/w06E1QNJPt8PPg3CIPLvKxJACg==
X-Received: by 2002:a05:600c:3093:b0:3df:fbd5:690 with SMTP id g19-20020a05600c309300b003dffbd50690mr2788705wmn.17.1675769815959;
        Tue, 07 Feb 2023 03:36:55 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k32-20020a05600c1ca000b003ddf2865aeasm20243816wms.41.2023.02.07.03.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 03:36:55 -0800 (PST)
Message-ID: <14d57333-02bc-6294-ed20-4c882dcd0dae@linaro.org>
Date:   Tue, 7 Feb 2023 11:36:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v9 14/27] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
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
 <20230120224627.4053418-15-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230120224627.4053418-15-quic_eberman@quicinc.com>
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
> Add remaining ioctls to support non-proxy VM boot:
> 
>   - Gunyah Resource Manager uses the VM's devicetree to configure the
>     virtual machine. The location of the devicetree in the guest's
>     virtual memory can be declared via the SET_DTB_CONFIG ioctl.
>   - Trigger start of the virtual machine with VM_START ioctl.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/vm_mgr.c    | 110 ++++++++++++++++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h    |   9 +++
>   drivers/virt/gunyah/vm_mgr_mm.c |  24 +++++++
>   include/uapi/linux/gunyah.h     |   8 +++
>   4 files changed, 151 insertions(+)
> 
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index b847fde63333..48bd3f06fb6c 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -9,6 +9,7 @@
>   #include <linux/file.h>
>   #include <linux/gunyah_rsc_mgr.h>
>   #include <linux/miscdevice.h>
> +#include <linux/mm.h>
>   #include <linux/module.h>
>   
>   #include <uapi/linux/gunyah.h>
> @@ -37,10 +38,98 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
>   
>   	mutex_init(&ghvm->mm_lock);
>   	INIT_LIST_HEAD(&ghvm->memory_mappings);
> +	init_rwsem(&ghvm->status_lock);
>   

using read write semaphore is really not going to make any difference in 
this particular case.
we have just one reader (gh_vm_ensure_started) and it mostly makes 
synchronous call to writer (vm_start).

>   	return ghvm;
>   }
>   
> +static int gh_vm_start(struct gunyah_vm *ghvm)
> +{
> +	struct gunyah_vm_memory_mapping *mapping;
> +	u64 dtb_offset;
> +	u32 mem_handle;
> +	int ret;
> +
> +	down_write(&ghvm->status_lock);
> +	if (ghvm->vm_status != GH_RM_VM_STATUS_NO_STATE) {
> +		up_write(&ghvm->status_lock);
> +		return 0;
> +	}
> +
> +	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
> +		switch (mapping->share_type) {
> +		case VM_MEM_LEND:
> +			ret = gh_rm_mem_lend(ghvm->rm, &mapping->parcel);
> +			break;
> +		case VM_MEM_SHARE:
> +			ret = gh_rm_mem_share(ghvm->rm, &mapping->parcel);
> +			break;
> +		}

> +		if (ret > 0)
> +			ret = -EINVAL;

why are we converting the error messages, afaiu both gh_rm_mem_lend and 
gh_rm_mem_share return a valid error codes.

> +		if (ret) {
> +			pr_warn("Failed to %s parcel %d: %d\n",
> +				mapping->share_type == VM_MEM_LEND ? "lend" : "share",
> +				mapping->parcel.label,
> +				ret);
> +			goto err;
> +		}
> +	}
> +
> +	mapping = gh_vm_mem_mapping_find_mapping(ghvm, ghvm->dtb_config.gpa, ghvm->dtb_config.size);
> +	if (!mapping) {
> +		pr_warn("Failed to find the memory_handle for DTB\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	mem_handle = mapping->parcel.mem_handle;
> +	dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
> +
> +	ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, mem_handle,
> +				0, 0, dtb_offset, ghvm->dtb_config.size);
> +	if (ret) {
> +		pr_warn("Failed to configure VM: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = gh_rm_vm_init(ghvm->rm, ghvm->vmid);
> +	if (ret) {
> +		pr_warn("Failed to initialize VM: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
> +	if (ret) {
> +		pr_warn("Failed to start VM: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ghvm->vm_status = GH_RM_VM_STATUS_READY;
> +
> +	up_write(&ghvm->stvm_status = atus_lock);
> +	return ret;
> +err:
> +	ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
> +	up_write(&ghvm->status_lock);
> +	return ret;
> +}
> +
> +static void gh_vm_stop(struct gunyah_vm *ghvm)
> +{
> +	int ret;
> +
> +	down_write(&ghvm->status_lock);
> +	if (ghvm->vm_status == GH_RM_VM_STATUS_READY) {
> +		ret = gh_rm_vm_stop(ghvm->rm, ghvm->vmid);
> +		if (ret)
> +			pr_warn("Failed to stop VM: %d\n", ret);
> +	}
> +
> +	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
> +	up_write(&ghvm->status_lock);
> +}
> +
>   static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   {
>   	struct gunyah_vm *ghvm = filp->private_data;
> @@ -84,6 +173,25 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   		}
>   		break;
>   	}
> +	case GH_VM_SET_DTB_CONFIG: {
> +		struct gh_vm_dtb_config dtb_config;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
> +			break;
> +
same feedback as other patches on setting error codes.
> +		dtb_config.size = PAGE_ALIGN(dtb_config.size);
> +		ghvm->dtb_config = dtb_config;
> +
> +		r = 0;
> +		break;
> +	}
> +	case GH_VM_START: {
> +		r = gh_vm_start(ghvm);
> +		if (r)
> +			r = -EINVAL;
> +		break;
> +	}
>   	default:
>   		r = -ENOTTY;
>   		break;
> @@ -97,6 +205,8 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
>   	struct gunyah_vm *ghvm = filp->private_data;
>   	struct gunyah_vm_memory_mapping *mapping, *tmp;
>   
> +	gh_vm_stop(ghvm);
> +
>   	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
>   		gh_vm_mem_mapping_reclaim(ghvm, mapping);
>   		kfree(mapping);
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index 6b38bf780f76..5c02fb305893 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -10,6 +10,7 @@
>   #include <linux/list.h>
>   #include <linux/miscdevice.h>
>   #include <linux/mutex.h>
> +#include <linux/rwsem.h>
>   
>   #include <uapi/linux/gunyah.h>
>   
> @@ -34,6 +35,12 @@ struct gunyah_vm {
>   	u16 vmid;
>   	struct gh_rm *rm;
>   
> +	enum gh_rm_vm_auth_mechanism auth;
> +	struct gh_vm_dtb_config dtb_config;
> +
> +	enum gh_rm_vm_status vm_status;
> +	struct rw_semaphore status_lock;
> +
>   	struct mutex mm_lock;
>   	struct list_head memory_mappings;
>   };
> @@ -42,5 +49,7 @@ struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
>   							struct gh_userspace_memory_region *region);
>   void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_mapping *mapping);
>   struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label);
> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
> +								u64 gpa, u32 size);
>   
>   #endif
> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
> index f2dbdb4ee8ab..7fcb9f8a29bf 100644
> --- a/drivers/virt/gunyah/vm_mgr_mm.c
> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
> @@ -53,6 +53,30 @@ void gh_vm_mem_mapping_reclaim(struct gunyah_vm *ghvm, struct gunyah_vm_memory_m
>   	mutex_unlock(&ghvm->mm_lock);
>   }
>   
> +struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find_mapping(struct gunyah_vm *ghvm,
> +								u64 gpa, u32 size)
> +{
> +	struct gunyah_vm_memory_mapping *mapping = NULL;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
> +		if (gpa >= mapping->guest_phys_addr &&
> +			(gpa + size <= mapping->guest_phys_addr +
> +			(mapping->npages << PAGE_SHIFT))) {
> +			goto unlock;
> +		}
> +	}
> +
> +	mapping = NULL;
> +unlock:
> +	mutex_unlock(&ghvm->mm_lock);
> +	return mapping;
> +}
> +
>   struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_find(struct gunyah_vm *ghvm, u32 label)
>   {
>   	struct gunyah_vm_memory_mapping *mapping;
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 574f33b198d0..36359ad2175e 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -42,4 +42,12 @@ struct gh_userspace_memory_region {
>   #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
>   						struct gh_userspace_memory_region)
>   
> +struct gh_vm_dtb_config {
> +	__u64 gpa;

need kernedoc, what is gpa?

> +	__u64 size;
> +};
> +#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x2, struct gh_vm_dtb_config)
> +
> +#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
> +
>   #endif
