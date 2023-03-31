Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38476D2287
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCaO1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjCaO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:27:05 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F31FD38
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id t13so16474156qvn.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272788; x=1682864788;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zdLqW1mQ/0UzPv1Zt7TsggrBbDPiNimPaRte3w4Z92o=;
        b=IN/LmFrafsC/lIvRQcYyvo1M8a9/yoHuSDtNuLG0hl4aYROvNAn2y6+4d7YC6QvD8V
         EdO0e0XqyEMM4ntkKVQz/ymGrP/t1dIVnT5b5NC4QnMykNEnvjJCSsy9ir9W2LXRuSgW
         r++MnGYRRbkt4dyovIVYCzNjhhYGYlEXdspQ+5MBbORRkAXrQlv792kWsUMYbhTh1IU/
         +cURuXrwml1Su4wgxgpOq6XmWktgm53aUVc8wXFqsWJ67Uhpj6Bz8aF0pJlX7sKsKAfO
         5m5/eR1STmr8smInPLHm2Ytjwq/c1lfVFyKQR2ktPbTQARif7E3F9deGb3ZPXipJCiBi
         KVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272788; x=1682864788;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdLqW1mQ/0UzPv1Zt7TsggrBbDPiNimPaRte3w4Z92o=;
        b=VGx+p0zsbpx0RngYuLzQMM9YMkU+tTaqDXT1+hFULk6iF0N1hCKq6U4moob01/rk33
         i59cAmyq/ECZ8Lns5q4yKTwljJPrQnr4sGZ2u1Drj8/B+Qkg3hOJwQ3VYGzGI//Zmzuw
         gFA94JEhXXNfEhrrWpZ9F3wMZRMKbEXq5D0vCBM/jVE6EUOY4AqKY8KRQHLSDs8Ajxs6
         6DkoHdwJHI69A8fXvrZnFwNg6uTHxZW4rcbF8OELRtyVCyQVkStX7V/eU9EADNJ38rHG
         fivWU1As3dUSyGW5Mwvwk5Wqe9zNpuVuZRfMuag4g9R+lBZNIzfOxudppQP+Nfg7A92n
         skpQ==
X-Gm-Message-State: AAQBX9fxdOildQupM3zq+tgt72QUh3kteQE1H/2hbCDvOfk5guxwdYsN
        1No9FfkaHpcfpV4NX+EWcLcWsA==
X-Google-Smtp-Source: AKy350YxU34eqq9gLkkKyiVA2Bz/ZFHGCxc/cTRFFwUgeWyP627nbL274McCSnZRT9Nafe4MzKM/Wg==
X-Received: by 2002:ad4:5dec:0:b0:56e:bdfb:f4c5 with SMTP id jn12-20020ad45dec000000b0056ebdfbf4c5mr44243640qvb.36.1680272788600;
        Fri, 31 Mar 2023 07:26:28 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id 2-20020a370b02000000b0071f0d0aaef7sm692406qkl.80.2023.03.31.07.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:26:28 -0700 (PDT)
Message-ID: <3271fdf5-57cd-d962-fd20-01f5a5447232@linaro.org>
Date:   Fri, 31 Mar 2023 09:26:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
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
 <20230304010632.2127470-14-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-14-quic_eberman@quicinc.com>
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

I identify one bug here, possibly another.  And I have a few
suggestions about things that could improve code readability.

					-Alex

> ---
>   drivers/virt/gunyah/vm_mgr.c    | 243 ++++++++++++++++++++++++++++++--
>   drivers/virt/gunyah/vm_mgr.h    |  10 ++
>   drivers/virt/gunyah/vm_mgr_mm.c |  23 +++
>   include/linux/gunyah_rsc_mgr.h  |   6 +
>   include/uapi/linux/gunyah.h     |  13 ++
>   5 files changed, 282 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index e950274c6a53..299b9bb81edc 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -9,37 +9,118 @@
>   #include <linux/file.h>
>   #include <linux/gunyah_rsc_mgr.h>
>   #include <linux/miscdevice.h>
> +#include <linux/mm.h>
>   #include <linux/module.h>
>   
>   #include <uapi/linux/gunyah.h>
>   
>   #include "vm_mgr.h"
>   
> +static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
> +{
> +	struct gh_rm_vm_status_payload *payload = data;
> +
> +	if (payload->vmid != ghvm->vmid)
> +		return NOTIFY_OK;
> +
> +	/* All other state transitions are synchronous to a corresponding RM call */
> +	if (payload->vm_status == GH_RM_VM_STATUS_RESET) {
> +		down_write(&ghvm->status_lock);
> +		ghvm->vm_status = payload->vm_status;
> +		up_write(&ghvm->status_lock);
> +		wake_up(&ghvm->vm_status_wait);
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int gh_vm_rm_notification_exited(struct gh_vm *ghvm, void *data)
> +{
> +	struct gh_rm_vm_exited_payload *payload = data;
> +
> +	if (payload->vmid != ghvm->vmid)
> +		return NOTIFY_OK;
> +
> +	down_write(&ghvm->status_lock);
> +	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
> +	up_write(&ghvm->status_lock);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int gh_vm_rm_notification(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct gh_vm *ghvm = container_of(nb, struct gh_vm, nb);
> +
> +	switch (action) {
> +	case GH_RM_NOTIFICATION_VM_STATUS:
> +		return gh_vm_rm_notification_status(ghvm, data);
> +	case GH_RM_NOTIFICATION_VM_EXITED:
> +		return gh_vm_rm_notification_exited(ghvm, data);
> +	default:
> +		return NOTIFY_OK;
> +	}
> +}
> +
> +static void gh_vm_stop(struct gh_vm *ghvm)
> +{
> +	int ret;
> +
> +	down_write(&ghvm->status_lock);
> +	if (ghvm->vm_status == GH_RM_VM_STATUS_RUNNING) {
> +		ret = gh_rm_vm_stop(ghvm->rm, ghvm->vmid);
> +		if (ret)
> +			dev_warn(ghvm->parent, "Failed to stop VM: %d\n", ret);
> +	}
> +
> +	ghvm->vm_status = GH_RM_VM_STATUS_EXITED;
> +	up_write(&ghvm->status_lock);
> +}
> +
>   static void gh_vm_free(struct work_struct *work)
>   {
>   	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
>   	struct gh_vm_mem *mapping, *tmp;
>   	int ret;
>   
> -	mutex_lock(&ghvm->mm_lock);
> -	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> -		gh_vm_mem_reclaim(ghvm, mapping);
> -		kfree(mapping);
> -	}
> -	mutex_unlock(&ghvm->mm_lock);
> -
> -	ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
> -	if (ret)
> -		pr_warn("Failed to deallocate vmid: %d\n", ret);
> +	switch (ghvm->vm_status) {
> +	case GH_RM_VM_STATUS_RUNNING:
> +		gh_vm_stop(ghvm);
> +		fallthrough;
> +	case GH_RM_VM_STATUS_INIT_FAILED:
> +	case GH_RM_VM_STATUS_LOAD:
> +	case GH_RM_VM_STATUS_EXITED:
> +		mutex_lock(&ghvm->mm_lock);
> +		list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
> +			gh_vm_mem_reclaim(ghvm, mapping);
> +			kfree(mapping);
> +		}
> +		mutex_unlock(&ghvm->mm_lock);
> +		fallthrough;
> +	case GH_RM_VM_STATUS_NO_STATE:
> +		ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
> +		if (ret)
> +			dev_warn(ghvm->parent, "Failed to deallocate vmid: %d\n", ret);
> +
> +		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);

I think you should unregister the notifier before you
deallocate the VMID.  I think the notifier might be able
to use the VMID.

> +		gh_rm_put(ghvm->rm);
> +		kfree(ghvm);
> +		break;
> +	default:
> +		dev_err(ghvm->parent, "VM is unknown state: %d. VM will not be cleaned up.\n",
> +			ghvm->vm_status);
>   
> -	put_gh_rm(ghvm->rm);
> -	kfree(ghvm);
> +		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
> +		gh_rm_put(ghvm->rm);
> +		kfree(ghvm);
> +		break;
> +	}
>   }
>   
>   static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   {
>   	struct gh_vm *ghvm;
> -	int vmid;
> +	int vmid, ret;
>   
>   	vmid = gh_rm_alloc_vmid(rm, 0);
>   	if (vmid < 0)
> @@ -55,13 +136,130 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   	ghvm->vmid = vmid;
>   	ghvm->rm = rm;
>   
> +	init_waitqueue_head(&ghvm->vm_status_wait);
> +	ghvm->nb.notifier_call = gh_vm_rm_notification;
> +	ret = gh_rm_notifier_register(rm, &ghvm->nb);
> +	if (ret) {
> +		gh_rm_put(rm);
> +		gh_rm_dealloc_vmid(rm, vmid);
> +		kfree(ghvm);
> +		return ERR_PTR(ret);
> +	}
> +
>   	mutex_init(&ghvm->mm_lock);
>   	INIT_LIST_HEAD(&ghvm->memory_mappings);
> +	init_rwsem(&ghvm->status_lock);
>   	INIT_WORK(&ghvm->free_work, gh_vm_free);
> +	ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
>   
>   	return ghvm;
>   }
>   
> +static int gh_vm_start(struct gh_vm *ghvm)
> +{
> +	struct gh_vm_mem *mapping;
> +	u64 dtb_offset;
> +	u32 mem_handle;
> +	int ret;
> +
> +	down_write(&ghvm->status_lock);
> +	if (ghvm->vm_status != GH_RM_VM_STATUS_LOAD) {
> +		up_write(&ghvm->status_lock);
> +		return 0;
> +	}
> +
> +	ghvm->vm_status = GH_RM_VM_STATUS_RESET;
> +
> +	mutex_lock(&ghvm->mm_lock);
> +	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
> +		switch (mapping->share_type) {
> +		case VM_MEM_LEND:
> +			ret = gh_rm_mem_lend(ghvm->rm, &mapping->parcel);
> +			break;
> +		case VM_MEM_SHARE:
> +			ret = gh_rm_mem_share(ghvm->rm, &mapping->parcel);
> +			break;
> +		}
> +		if (ret) {
> +			dev_warn(ghvm->parent, "Failed to %s parcel %d: %d\n",
> +				mapping->share_type == VM_MEM_LEND ? "lend" : "share",
> +				mapping->parcel.label,
> +				ret);
> +			goto err;
> +		}
> +	}
> +	mutex_unlock(&ghvm->mm_lock);
> +
> +	mapping = gh_vm_mem_find_by_addr(ghvm, ghvm->dtb_config.guest_phys_addr,
> +					ghvm->dtb_config.size);
> +	if (!mapping) {
> +		dev_warn(ghvm->parent, "Failed to find the memory_handle for DTB\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	mem_handle = mapping->parcel.mem_handle;
> +	dtb_offset = ghvm->dtb_config.guest_phys_addr - mapping->guest_phys_addr;
> +
> +	ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, mem_handle,
> +				0, 0, dtb_offset, ghvm->dtb_config.size);
> +	if (ret) {
> +		dev_warn(ghvm->parent, "Failed to configure VM: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = gh_rm_vm_init(ghvm->rm, ghvm->vmid);
> +	if (ret) {
> +		dev_warn(ghvm->parent, "Failed to initialize VM: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = gh_rm_vm_start(ghvm->rm, ghvm->vmid);
> +	if (ret) {
> +		dev_warn(ghvm->parent, "Failed to start VM: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ghvm->vm_status = GH_RM_VM_STATUS_RUNNING;
> +	up_write(&ghvm->status_lock);
> +	return ret;
> +err:
> +	ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
> +	/* gh_vm_free will handle releasing resources and reclaiming memory */
> +	up_write(&ghvm->status_lock);
> +	return ret;
> +}
> +
> +static int gh_vm_ensure_started(struct gh_vm *ghvm)
> +{
> +	int ret;
> +
> +	ret = down_read_interruptible(&ghvm->status_lock);
> +	if (ret)
> +		return ret;
> +
> +	/* Unlikely because VM is typically started */
> +	if (unlikely(ghvm->vm_status == GH_RM_VM_STATUS_LOAD)) {
> +		up_read(&ghvm->status_lock);
> +		ret = gh_vm_start(ghvm);
> +		if (ret)
> +			goto out;

You have already released the status lock at this point.
So going to "out" will do it again.  This is a BUG.

I think you just want to return ret, and you don't need
the "out" error path.


> +		/** gh_vm_start() is guaranteed to bring status out of
> +		 * GH_RM_VM_STATUS_LOAD, thus inifitely recursive call is not
> +		 * possible
> +		 */
> +		return gh_vm_ensure_started(ghvm);
> +	}
> +
> +	/* Unlikely because VM is typically running */
> +	if (unlikely(ghvm->vm_status != GH_RM_VM_STATUS_RUNNING))
> +		ret = -ENODEV;
> +
> +out:
> +	up_read(&ghvm->status_lock);
> +	return ret;
> +}
> +
>   static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   {
>   	struct gh_vm *ghvm = filp->private_data;
> @@ -85,6 +283,25 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   		r = gh_vm_mem_alloc(ghvm, &region);
>   		break;
>   	}
> +	case GH_VM_SET_DTB_CONFIG: {
> +		struct gh_vm_dtb_config dtb_config;
> +
> +		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
> +			return -EFAULT;
> +

It's clear that the base of the DTB does not need to be
page aligned.  But why do you round up the size to a
page boundary?  (It might be the "extra for overlay"
I comment on elsewhere, but even if so, it's worth
mentioning this.)

> +		dtb_config.size = PAGE_ALIGN(dtb_config.size);
> +		if (dtb_config.guest_phys_addr + dtb_config.size < dtb_config.guest_phys_addr)
> +			return -EOVERFLOW;
> +
> +		ghvm->dtb_config = dtb_config;
> +
> +		r = 0;
> +		break;
> +	}
> +	case GH_VM_START: {
> +		r = gh_vm_ensure_started(ghvm);
> +		break;
> +	}
>   	default:
>   		r = -ENOTTY;
>   		break;
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index c9f6fa5478ed..26bcc2ae4478 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -10,6 +10,8 @@
>   #include <linux/list.h>
>   #include <linux/miscdevice.h>
>   #include <linux/mutex.h>
> +#include <linux/rwsem.h>
> +#include <linux/wait.h>
>   
>   #include <uapi/linux/gunyah.h>
>   
> @@ -34,6 +36,13 @@ struct gh_vm {
>   	u16 vmid;
>   	struct gh_rm *rm;
>   	struct device *parent;
> +	enum gh_rm_vm_auth_mechanism auth;
> +	struct gh_vm_dtb_config dtb_config;
> +
> +	struct notifier_block nb;
> +	enum gh_rm_vm_status vm_status;
> +	wait_queue_head_t vm_status_wait;
> +	struct rw_semaphore status_lock;
>   
>   	struct work_struct free_work;
>   	struct mutex mm_lock;
> @@ -44,5 +53,6 @@ int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *regio
>   void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
>   int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
>   struct gh_vm_mem *gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label);
> +struct gh_vm_mem *gh_vm_mem_find_by_addr(struct gh_vm *ghvm, u64 guest_phys_addr, u32 size);
>   
>   #endif
> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
> index db6f55cef37f..6e1d2e8bddb7 100644
> --- a/drivers/virt/gunyah/vm_mgr_mm.c
> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
> @@ -47,6 +47,29 @@ void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
>   	list_del(&mapping->list);
>   }
>   

I think you should call this gh_vm_mem_find_mapping().  You are
finding the mapping that contains the given range.

> +struct gh_vm_mem *gh_vm_mem_find_by_addr(struct gh_vm *ghvm, u64 guest_phys_addr, u32 size)
> +{
> +	struct gh_vm_mem *mapping = NULL;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ghvm->mm_lock);
> +	if (ret)
> +		return ERR_PTR(ret);
> +

I think you could slightly modify this, and replace this loop and
the one in gh_vm_mem_alloc() with a call to a helper function.

What I suggest is that you define a function like
__gh_vm_mem_overlap(ghvm, offset, size).  It would return a
gh_vm_mem pointer if it found any mapping that overlapped
the range, or null if none is found.

Here, you could then check the returned result to ensure
the entire range fits within it.

And in gh_vm_mem_alloc() you could simply use the result
to indicate that you can't allocate the range (because
at least one existing range covers all or part of the new
one).

> +	list_for_each_entry(mapping, &ghvm->memory_mappings, list) {
> +		if (guest_phys_addr >= mapping->guest_phys_addr &&
> +			(guest_phys_addr + size <= mapping->guest_phys_addr +
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
>   struct gh_vm_mem *gh_vm_mem_find_by_label(struct gh_vm *ghvm, u32 label)
>   {
>   	struct gh_vm_mem *mapping;
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index 88a429dad09e..8b0b46f28e39 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -29,6 +29,12 @@ struct gh_rm_vm_exited_payload {
>   #define GH_RM_NOTIFICATION_VM_EXITED		 0x56100001
>   
>   enum gh_rm_vm_status {
> +	/**
> +	 * RM doesn't have a state where load partially failed because
> +	 * only Linux

I have no idea what the comment above means...  Please fix.

Several of the values below are never explicitly assigned,
and some are used but not assigned.  The others apparently
might come back from the resource manager?  Why, for
example, are the PAUSED, AUTH, and RESETTING statuses
defined if we don't use them?

> +	 */
> +	GH_RM_VM_STATUS_LOAD_FAILED	= -1,
> +
>   	GH_RM_VM_STATUS_NO_STATE	= 0,
>   	GH_RM_VM_STATUS_INIT		= 1,
>   	GH_RM_VM_STATUS_READY		= 2,
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index a19207e3e065..d6abd8605a2e 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -49,4 +49,17 @@ struct gh_userspace_memory_region {
>   #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
>   						struct gh_userspace_memory_region)
>   
> +/**
> + * struct gh_vm_dtb_config - Set the location of the VM's devicetree blob
> + * @guest_phys_addr: Address of the VM's devicetree in guest memory.
> + * @size: Maximum size of the devicetree.
> + */
> +struct gh_vm_dtb_config {
> +	__u64 guest_phys_addr;
> +	__u64 size;
> +};
> +#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x2, struct gh_vm_dtb_config)
> +
> +#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
> +
>   #endif

