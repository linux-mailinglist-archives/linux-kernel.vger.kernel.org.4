Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92B36D2295
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjCaO1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjCaO1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:27:36 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956B20612
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:27:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x8so16389410qvr.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272818; x=1682864818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4DsHYW3uSFVtonsd7QQHGghvQLdtD/3WFaEvciGoFU=;
        b=cdq817dKr8MjBnulr/FB28uxmZRT3Bz0WW0/1DAtUrzRuKwmyircdekEjtqdbfhY7N
         hJ/LtukiRr0O77IwpcgDvQ5ZKiKvdhPciElybtPH85kfifMlY3JQDzbbe0SvYvm1OGVr
         etf3oGE0chUPgHfA46bnrXGj+cy6WlgDvu/kvvUkXkTbcmEI0aw+4LjFy+D81owbQtG1
         4vhR/xVgskCUzMON1rMZye8UdRw3uFrencK3z7D3a2Z9qzRLj1ZVQ3eHcW8WC/a0Asfn
         Os4TuW3dtHK1+x3YTgGOro0k37mH0c5lK4pobwE0dRJAWfGsVNgMJL8rt2V4QoL/lZhE
         dXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272818; x=1682864818;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4DsHYW3uSFVtonsd7QQHGghvQLdtD/3WFaEvciGoFU=;
        b=SAPv4o322I7/KDjpzcrBMzqsFza0bZyCnHPd/dGraqrBX6KdwqDh/3HPLuVgAfaB5P
         3RtCJO9pJ9iYwQXGgerkdFE7hCOAJRCdCui4/o2JHuXYu127+kuJ2tFWSQK59N7LAALG
         evqMurdJNB80eb80c7U9FGaLKhoZPs5U3vYHaimnNWr4m/v16Iww6oqT2hEGbA6ICKNE
         oMyPjg9FFxZlf3t2mT1OtUF1ulgVfxGq8jkTCm+KiD7v3VXmkBF9QTNCoUrE8hSU2POz
         giYPflgQSReL3UxWaSWTqxEERSLPUJFBVNG6pTTez4q+Tnx9hxwZ2vIycrSlvM1ASjOc
         2rCA==
X-Gm-Message-State: AAQBX9dKEkZmxeC6gJ2hG1OsCL+rdLfBOBxQbF6mhUOdf4FwWTp6BlTM
        pOn35Go74qg4EOC50bqaw3v0MA==
X-Google-Smtp-Source: AKy350Z5577RjS5EKZopl+yV71cWKq4EUbc52y6PTqPwpT9c6jcjgEl6ugCC//x6c0gEm93qatgcow==
X-Received: by 2002:a05:6214:2607:b0:56a:b623:9b09 with SMTP id gu7-20020a056214260700b0056ab6239b09mr55315858qvb.14.1680272818078;
        Fri, 31 Mar 2023 07:26:58 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id oh4-20020a056214438400b005dd8b9345e6sm615727qvb.126.2023.03.31.07.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:26:57 -0700 (PDT)
Message-ID: <47fcb01e-f33b-c843-d81e-e898be1170ef@linaro.org>
Date:   Fri, 31 Mar 2023 09:26:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 19/26] gunyah: vm_mgr: Add framework to add VM
 Functions
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-20-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-20-quic_eberman@quicinc.com>
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
> Introduce a framework for Gunyah userspace to install VM functions. VM
> functions are optional interfaces to the virtual machine. vCPUs,
> ioeventfs, and irqfds are examples of such VM functions and are
> implemented in subsequent patches.
> 
> A generic framework is implemented instead of individual ioctls to
> create vCPUs, irqfds, etc., in order to simplify the VM manager core
> implementation and allow dynamic loading of VM function modules.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I found two bugs here, and have some suggestions that might
improve code readability.

					-Alex

> ---
>   Documentation/virt/gunyah/vm-manager.rst |  18 ++
>   drivers/virt/gunyah/vm_mgr.c             | 208 ++++++++++++++++++++++-
>   drivers/virt/gunyah/vm_mgr.h             |   4 +
>   include/linux/gunyah_vm_mgr.h            |  73 ++++++++
>   include/uapi/linux/gunyah.h              |  17 ++
>   5 files changed, 316 insertions(+), 4 deletions(-)
>   create mode 100644 include/linux/gunyah_vm_mgr.h
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index 1b4aa18670a3..af8ad88a88ab 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -17,6 +17,24 @@ sharing userspace memory with a VM is done via the GH_VM_SET_USER_MEM_REGION
>   ioctl. The VM itself is configured to use the memory region via the
>   devicetree.
>   
> +Gunyah Functions
> +================
> +
> +Components of a Gunyah VM's configuration that need kernel configuration are
> +called "functions" and are built on top of a framework. Functions are identified
> +by a string and have some argument(s) to configure them. They are typically
> +created by the `GH_VM_ADD_FUNCTION` ioctl.
> +
> +Functions typically will always do at least one of these operations:
> +
> +1. Create resource ticket(s). Resource tickets allow a function to register
> +   itself as the client for a Gunyah resource (e.g. doorbell or vCPU) and
> +   the function is given the pointer to the `struct gh_resource` when the
> +   VM is starting.
> +
> +2. Register IO handler(s). IO handlers allow a function to handle stage-2 faults
> +   from the virtual machine.
> +
>   Sample Userspace VMM
>   ====================
>   
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index 299b9bb81edc..88db011395ec 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -6,16 +6,165 @@
>   #define pr_fmt(fmt) "gh_vm_mgr: " fmt
>   
>   #include <linux/anon_inodes.h>
> +#include <linux/compat.h>
>   #include <linux/file.h>
>   #include <linux/gunyah_rsc_mgr.h>
> +#include <linux/gunyah_vm_mgr.h>
>   #include <linux/miscdevice.h>
>   #include <linux/mm.h>
>   #include <linux/module.h>
> +#include <linux/xarray.h>
>   
>   #include <uapi/linux/gunyah.h>
>   
>   #include "vm_mgr.h"
>   
> +static DEFINE_XARRAY(functions);
> +
> +int gh_vm_function_register(struct gh_vm_function *fn)
> +{
> +	if (!fn->bind || !fn->unbind)
> +		return -EINVAL;
> +
> +	return xa_err(xa_store(&functions, fn->type, fn, GFP_KERNEL));
> +}
> +EXPORT_SYMBOL_GPL(gh_vm_function_register);
> +

I would move gh_vm_remove_function_instance() down, grouping it
more closely with the code that uses it.

> +static void gh_vm_remove_function_instance(struct gh_vm_function_instance *inst)
> +	__must_hold(&inst->ghvm->fn_lock)
> +{
> +	inst->fn->unbind(inst);
> +	list_del(&inst->vm_list);
> +	module_put(inst->fn->mod);
> +	kfree(inst->argp);
> +	kfree(inst);
> +}
> +
> +void gh_vm_function_unregister(struct gh_vm_function *fn)
> +{
> +	/* Expecting unregister to only come when unloading a module */
> +	WARN_ON(fn->mod && module_refcount(fn->mod));
> +	xa_erase(&functions, fn->type);
> +}
> +EXPORT_SYMBOL_GPL(gh_vm_function_unregister);
> +

You define gh_vm_get_function(), but you don't define the matching
gh_vm_put_function() abstraction.  Instead, you just expect the
caller to know that they should call module_put().  Even if it's
a simple wrapper, please define gh_vm_put_function().

> +static struct gh_vm_function *gh_vm_get_function(u32 type)
> +{
> +	struct gh_vm_function *fn;
> +	int r;
> +
> +	fn = xa_load(&functions, type);
> +	if (!fn) {
> +		r = request_module("ghfunc:%d", type);
> +		if (r)
> +			return ERR_PTR(r);
> +
> +		fn = xa_load(&functions, type);
> +	}
> +
> +	if (!fn || !try_module_get(fn->mod))
> +		fn = ERR_PTR(-ENOENT);
> +
> +	return fn;
> +}
> +
> +static long gh_vm_add_function(struct gh_vm *ghvm, struct gh_fn_desc *f)

This is adding a function *instance*.  Maybe it would be clearer
if you included that in the name.

> +{
> +	struct gh_vm_function_instance *inst;
> +	void __user *argp;
> +	long r = 0;
> +
> +	if (f->arg_size > GH_FN_MAX_ARG_SIZE) {
> +		dev_err(ghvm->parent, "%s: arg_size > %d\n", __func__, GH_FN_MAX_ARG_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
> +	if (!inst)
> +		return -ENOMEM;
> +
> +	inst->arg_size = f->arg_size;
> +	if (inst->arg_size) {
> +		inst->argp = kzalloc(inst->arg_size, GFP_KERNEL);
> +		if (!inst->argp) {
> +			r = -ENOMEM;
> +			goto free;
> +		}
> +
> +		argp = u64_to_user_ptr(f->arg);
> +		if (copy_from_user(inst->argp, argp, f->arg_size)) {
> +			r = -EFAULT;
> +			goto free_arg;
> +		}
> +	}
> +
> +	inst->fn = gh_vm_get_function(f->type);
> +	if (IS_ERR(inst->fn)) {
> +		r = PTR_ERR(inst->fn);
> +		goto free_arg;
> +	}
> +
> +	inst->ghvm = ghvm;
> +	inst->rm = ghvm->rm;
> +
> +	mutex_lock(&ghvm->fn_lock);
> +	r = inst->fn->bind(inst);
> +	if (r < 0) {

You need to unlock the mutex here.  This is a BUG.

> +		module_put(inst->fn->mod);
> +		goto free_arg;

Perhaps you should add a new label in the error path and
unlock the mutex and put the function reference there.

> +	}
> +
> +	list_add(&inst->vm_list, &ghvm->functions);
> +	mutex_unlock(&ghvm->fn_lock);
> +
> +	return r;
> +free_arg:
> +	kfree(inst->argp);
> +free:
> +	kfree(inst);
> +	return r;
> +}
> +
> +static long gh_vm_rm_function(struct gh_vm *ghvm, struct gh_fn_desc *f)

This is removing a function *instance*, right?

> +{
> +	struct gh_vm_function_instance *inst, *iter;
> +	void __user *user_argp;
> +	void *argp;
> +	long r = 0;
> +
> +	r = mutex_lock_interruptible(&ghvm->fn_lock);
> +	if (r)
> +		return r;
> +
> +	if (f->arg_size) {

This is a BUG.  You' aren't freeing things, you seem
to have just duplicated the allocation code.

Actually I think this is just a block of copied code
that's here by mistake.  The loop might be doing
the removal you intend.

> +		argp = kzalloc(f->arg_size, GFP_KERNEL);
> +		if (!argp) {
> +			r = -ENOMEM;
> +			goto out;
> +		}
> +
> +		user_argp = u64_to_user_ptr(f->arg);
> +		if (copy_from_user(argp, user_argp, f->arg_size)) {
> +			r = -EFAULT;
> +			kfree(argp);
> +			goto out;
> +		}
> 
I *think* the for loop and freeing the argument here
still does what you want.

> +		list_for_each_entry_safe(inst, iter, &ghvm->functions, vm_list) {
> +			if (inst->fn->type == f->type &&
> +			    f->arg_size == inst->arg_size &&
> +			    !memcmp(argp, inst->argp, f->arg_size))
> +				gh_vm_remove_function_instance(inst);
> +		}
> +
> +		kfree(argp);
> +	}
> +
> +out:
> +	mutex_unlock(&ghvm->fn_lock);
> +	return r;
> +}
> +
>   static int gh_vm_rm_notification_status(struct gh_vm *ghvm, void *data)
>   {
>   	struct gh_rm_vm_status_payload *payload = data;
> @@ -80,6 +229,7 @@ static void gh_vm_stop(struct gh_vm *ghvm)
>   static void gh_vm_free(struct work_struct *work)
>   {
>   	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
> +	struct gh_vm_function_instance *inst, *iiter;
>   	struct gh_vm_mem *mapping, *tmp;
>   	int ret;
>   
> @@ -90,6 +240,12 @@ static void gh_vm_free(struct work_struct *work)
>   	case GH_RM_VM_STATUS_INIT_FAILED:
>   	case GH_RM_VM_STATUS_LOAD:
>   	case GH_RM_VM_STATUS_EXITED:
> +		mutex_lock(&ghvm->fn_lock);
> +		list_for_each_entry_safe(inst, iiter, &ghvm->functions, vm_list) {
> +			gh_vm_remove_function_instance(inst);
> +		}
> +		mutex_unlock(&ghvm->fn_lock);
> +
>   		mutex_lock(&ghvm->mm_lock);
>   		list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
>   			gh_vm_mem_reclaim(ghvm, mapping);
> @@ -117,6 +273,28 @@ static void gh_vm_free(struct work_struct *work)
>   	}
>   }
>   
> +static void _gh_vm_put(struct kref *kref)
> +{
> +	struct gh_vm *ghvm = container_of(kref, struct gh_vm, kref);
> +
> +	/* VM will be reset and make RM calls which can interruptible sleep.
> +	 * Defer to a work so this thread can receive signal.
> +	 */
> +	schedule_work(&ghvm->free_work);
> +}
> +
> +int __must_check gh_vm_get(struct gh_vm *ghvm)
> +{
> +	return kref_get_unless_zero(&ghvm->kref);
> +}
> +EXPORT_SYMBOL_GPL(gh_vm_get);
> +

Maybe move _gh_vm_put() here.

> +void gh_vm_put(struct gh_vm *ghvm)
> +{
> +	kref_put(&ghvm->kref, _gh_vm_put);
> +}
> +EXPORT_SYMBOL_GPL(gh_vm_put);
> +
>   static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   {
>   	struct gh_vm *ghvm;
> @@ -150,6 +328,8 @@ static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
>   	INIT_LIST_HEAD(&ghvm->memory_mappings);
>   	init_rwsem(&ghvm->status_lock);
>   	INIT_WORK(&ghvm->free_work, gh_vm_free);
> +	kref_init(&ghvm->kref);
> +	INIT_LIST_HEAD(&ghvm->functions);
>   	ghvm->vm_status = GH_RM_VM_STATUS_LOAD;
>   
>   	return ghvm;
> @@ -302,6 +482,29 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   		r = gh_vm_ensure_started(ghvm);
>   		break;
>   	}
> +	case GH_VM_ADD_FUNCTION: {
> +		struct gh_fn_desc f;
> +
> +		if (copy_from_user(&f, argp, sizeof(f)))
> +			return -EFAULT;
> +
> +		r = gh_vm_add_function(ghvm, &f);
> +		break;
> +	}
> +	case GH_VM_REMOVE_FUNCTION: {

To be clear, this is adding a function *instance*.
(I'm not suggesting you change the name.)

> +		struct gh_fn_desc *f;
> +
> +		f = kzalloc(sizeof(*f), GFP_KERNEL);

Why do you allocate a function descriptor here dynamically,
while when adding a function you just define a descriptor
as a local variable (on the stack)?  It looks to me like
you should be able to do it the same way here and avoid
the possibility of a kzalloc() failure.

> +		if (!f)
> +			return -ENOMEM;
> +
> +		if (copy_from_user(f, argp, sizeof(*f)))
> +			return -EFAULT;

If the copy_from_user() fails you will have leaked the
memory allocated for the memory descriptor.  This is a BUG.

> +
> +		r = gh_vm_rm_function(ghvm, f);
> +		kfree(f);
> +		break;
> +	}
>   	default:
>   		r = -ENOTTY;
>   		break;

. . .
