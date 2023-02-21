Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0048169E223
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBUOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjBUOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:18:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AEE1EFCC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:18:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so3153535wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vid7qjCnedMIIHoc02tgIQdFa2iY2esABKrcRBKUYik=;
        b=yljG619+twY93lW25056Gpx4myhvJ94UT5dB/SPGZXobm7XtOGJDxgALMmVLsGl6vl
         Ar1U+yRxiws73yVCAJHEZ4U61cgfKVNZG2JlalsLPc1mPWrPBtRgrNvJnr9aDjhdjDZz
         lnCLrLYD7RCXCs4mN2JiW92W8wrKmz1HYHyo1gHGqH2xFV36GIf+6Rk7urk4IK3n3CjH
         gXjTjn4stZaOKuOFzfW17gpTQIKbXvcBDaXNUCmP7SM5IqAOYO7WG2F51mxI0jdb0GyD
         GqGOEWIno/bS0KdyCnNdnc9fFiwtQHpoM/rgEtmu9t+v6D6QP/Mu3wIf2PgoujUFdkSp
         dLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vid7qjCnedMIIHoc02tgIQdFa2iY2esABKrcRBKUYik=;
        b=CSGL1MyVHK37MoccA0a3gozwXA0xKybt+p2t967SFJPa+q64VRYz1spm2JiSrVXJJT
         7DAaCTNUEgM3u4aFtCEVeRnEG3fDCmShT942GLWLC8jafZHu35PTAzsRa4mVPQyHaAyp
         VJ7eAesREeQDAKOr8xX0xIVvgVDDk4QErMwY7aUgL3y53cxkJ5OGW9y4Jn+CfEg79mOH
         gKSOU737cmtFB2dSWRs4wdIhJBxPy9Xht4YM7EweTf/sMqBmyUlJWlxugL550xflUxQm
         T7fUjjUJ1w0obzcTDIZYsPIaWYXB9441eM11gNG8MBEHlKJW+5ExkLwPpXkldx/pjtiI
         qqVQ==
X-Gm-Message-State: AO0yUKXRmP+/pCttjFJMxwOaXjMtsloHV+Zk70r6pb7QPq1Egc1ETkWU
        bSk2S5EMZPkrw6eALN33qNvyNA==
X-Google-Smtp-Source: AK7set8jO8kVaZ3Rk0zZ8SaW82QWhZXU1NuU+ffbNXyvBzbykwgDmSI8hWheU15QF2RjiLLSK/ro6A==
X-Received: by 2002:a05:600c:510a:b0:3e8:490b:e286 with SMTP id o10-20020a05600c510a00b003e8490be286mr647285wms.14.1676989080864;
        Tue, 21 Feb 2023 06:18:00 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k31-20020a05600c1c9f00b003dc42d48defsm5770854wms.6.2023.02.21.06.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 06:17:59 -0800 (PST)
Message-ID: <1080339c-608e-6df8-8eee-b8f3bb7f396d@linaro.org>
Date:   Tue, 21 Feb 2023 14:17:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 13/26] gunyah: vm_mgr: Add ioctls to support basic
 non-proxy VM boot
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
 <20230214212427.3316544-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212427.3316544-1-quic_eberman@quicinc.com>
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
>   drivers/virt/gunyah/vm_mgr.c    | 229 ++++++++++++++++++++++++++++++--
>   drivers/virt/gunyah/vm_mgr.h    |  10 ++
>   drivers/virt/gunyah/vm_mgr_mm.c |  23 ++++
>   include/linux/gunyah_rsc_mgr.h  |   6 +
>   include/uapi/linux/gunyah.h     |  13 ++
>   5 files changed, 268 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index 84102bac03cc..fa324385ade5 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -9,37 +9,114 @@
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
Is this even possible? If yes, then this is a bug somewhere, we should 
not be getting notifications for something that does not belong to this vm.
What is the typical case for such behavior? comment would be useful.


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
same

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
> +			pr_warn("Failed to stop VM: %d\n", ret);
Should we not bail out from this fail path?


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
> +	switch (ghvm->vm_status) {
> +unknown_state:

Never seen this style of using goto from switch to a new label in 
switch case. Am sure this is some kinda trick but its not helping readers.

Can we rewrite this using a normal semantics.

may be a do while could help.


> +	case GH_RM_VM_STATUS_RUNNING:
> +		gh_vm_stop(ghvm);
> +		fallthrough;
> +	case GH_RM_VM_STATUS_INIT_FAILED:
> +	case GH_RM_VM_STATUS_LOAD:
> +	case GH_RM_VM_STATUS_LOAD_FAILED:
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
> +			pr_warn("Failed to deallocate vmid: %d\n", ret);
> +
> +		gh_rm_notifier_unregister(ghvm->rm, &ghvm->nb);
> +		put_gh_rm(ghvm->rm);
> +		kfree(ghvm);
> +		break;
> +	default:
> +		pr_err("VM is unknown state: %d, assuming it's running.\n", ghvm->vm_status);
vm_status did not change do we not endup here again?

> +		goto unknown_state;
>   	}
> -	mutex_unlock(&ghvm->mm_lock);
> -
> -	ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
> -	if (ret)
> -		pr_warn("Failed to deallocate vmid: %d\n", ret);
> -
> -	put_gh_rm(ghvm->rm);
> -	kfree(ghvm);
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
> @@ -56,13 +133,123 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   	ghvm->vmid = vmid;
>   	ghvm->rm = rm;
>   
> +	init_waitqueue_head(&ghvm->vm_status_wait);
> +	ghvm->nb.notifier_call = gh_vm_rm_notification;
> +	ret = gh_rm_notifier_register(rm, &ghvm->nb);
> +	if (ret) {
> +		put_gh_rm(rm);
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

<------
should we not take ghvm->mm_lock here to make sure that list is 
consistent while processing.
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
> +			pr_warn("Failed to %s parcel %d: %d\n",
> +				mapping->share_type == VM_MEM_LEND ? "lend" : "share",
> +				mapping->parcel.label,
> +				ret);
> +			goto err;
> +		}
> +	}
--->

> +
> +	mapping = gh_vm_mem_find_mapping(ghvm, ghvm->dtb_config.gpa, ghvm->dtb_config.size);
> +	if (!mapping) {
> +		pr_warn("Failed to find the memory_handle for DTB\n");

What wil happen to the mappings that are lend or shared?

> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	mem_handle = mapping->parcel.mem_handle;
> +	dtb_offset = ghvm->dtb_config.gpa - mapping->guest_phys_addr;
> +
> +	ret = gh_rm_vm_configure(ghvm->rm, ghvm->vmid, ghvm->auth, mem_handle,

where is authentication mechanism (auth) comming from? Who is supposed 
to set this value?

Should it come from userspace? if so I do not see any UAPI facility to 
do that via VM_START ioctl.


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
> +	ghvm->vm_status = GH_RM_VM_STATUS_RUNNING;
> +	up_write(&ghvm->status_lock);
> +	return ret;
> +err:
> +	ghvm->vm_status = GH_RM_VM_STATUS_INIT_FAILED;
> +	up_write(&ghvm->status_lock);

Am really not sure if we are doing right thing in the error path, there 
are multiple cases that seems to be not handled or if it was not 
required no comments to clarify this are documented.
ex: if vm start fails then what happes with memory mapping or do we need 
to un-configure vm or un-init vm from hypervisor side?

if none of this is required its useful to add come clear comments.

> +	return ret;
> +}
> +
> +static int gh_vm_ensure_started(struct gh_vm *ghvm)
> +{
> +	int ret;
> +
> +retry:
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
> +		goto retry;
> +	}

do while will do better job here w.r.t to readablity.

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
> @@ -88,6 +275,22 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   			r = gh_vm_mem_free(ghvm, region.label);
>   		break;
>   	}
> +	case GH_VM_SET_DTB_CONFIG: {
> +		struct gh_vm_dtb_config dtb_config;
> +
> +		if (copy_from_user(&dtb_config, argp, sizeof(dtb_config)))
> +			return -EFAULT;
> +
> +		dtb_config.size = PAGE_ALIGN(dtb_config.size);
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
> index 97bc00c34878..e9cf56647cc2 100644
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
> @@ -33,6 +35,13 @@ struct gh_vm_mem {
>   struct gh_vm {
>   	u16 vmid;
>   	struct gh_rm *rm;
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
> @@ -43,5 +52,6 @@ int gh_vm_mem_alloc(struct gh_vm *ghvm, struct gh_userspace_memory_region *regio
>   void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping);
>   int gh_vm_mem_free(struct gh_vm *ghvm, u32 label);
>   struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label);
> +struct gh_vm_mem *gh_vm_mem_find_mapping(struct gh_vm *ghvm, u64 gpa, u32 size);
>   
>   #endif
> diff --git a/drivers/virt/gunyah/vm_mgr_mm.c b/drivers/virt/gunyah/vm_mgr_mm.c
> index 03e71a36ea3b..128b90da555a 100644
> --- a/drivers/virt/gunyah/vm_mgr_mm.c
> +++ b/drivers/virt/gunyah/vm_mgr_mm.c
> @@ -52,6 +52,29 @@ void gh_vm_mem_reclaim(struct gh_vm *ghvm, struct gh_vm_mem *mapping)
>   	list_del(&mapping->list);
>   }
>   
> +struct gh_vm_mem *gh_vm_mem_find_mapping(struct gh_vm *ghvm, u64 gpa, u32 size)
naming is bit missleading we already have
gh_vm_mem_find/__gh_vm_mem_find which is returning mapping based on label
now with gh_vm_mem_find_mapping() is doing same thing but with address.

Can we rename them clearly
gh_vm_mem_find_mapping_by_label()
gh_vm_mem_find_mapping_by_addr()

> +{

> +	struct gh_vm_mem *mapping = NULL;
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
>   struct gh_vm_mem *gh_vm_mem_find(struct gh_vm *ghvm, u32 label)
>   {
>   	struct gh_vm_mem *mapping;
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index 2d8b8b6cc394..9cffee6f9b4e 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -32,6 +32,12 @@ struct gh_rm_vm_exited_payload {
>   #define GH_RM_NOTIFICATION_VM_EXITED		 0x56100001
>   
>   enum gh_rm_vm_status {
> +	/**
> +	 * RM doesn't have a state where load partially failed because
> +	 * only Linux
> +	 */
> +	GH_RM_VM_STATUS_LOAD_FAILED	= -1,
> +
>   	GH_RM_VM_STATUS_NO_STATE	= 0,
>   	GH_RM_VM_STATUS_INIT		= 1,
>   	GH_RM_VM_STATUS_READY		= 2,
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index d85d12119a48..d899bba6a4c6 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -53,4 +53,17 @@ struct gh_userspace_memory_region {
>   #define GH_VM_SET_USER_MEM_REGION	_IOW(GH_IOCTL_TYPE, 0x1, \
>   						struct gh_userspace_memory_region)
>   
> +/**
> + * struct gh_vm_dtb_config - Set the location of the VM's devicetree blob
> + * @gpa: Address of the VM's devicetree in guest memory.
> + * @size: Maximum size of the devicetree.
> + */
> +struct gh_vm_dtb_config {
> +	__u64 gpa;
> +	__u64 size;
> +};
> +#define GH_VM_SET_DTB_CONFIG	_IOW(GH_IOCTL_TYPE, 0x2, struct gh_vm_dtb_config)
> +
> +#define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
> +
>   #endif
