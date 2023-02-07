Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3A68D91D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjBGNQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjBGNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:15:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B9C3CE3A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:15:35 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h3so5674526wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAKiHUgxqE5rg0/f1FVu8ugVDbgO9Yb63m2qLMmxHgI=;
        b=KrYbYTMANVPB4WRowNS2b0+VIizK1Njw82xnErVjIYboGM6kaEHiRKGBTwFgHUsHLh
         VGlmKMuGbhVasLgFPOu/gTbGwgbd9JxFGjXyQV+B2USjX+McbDXCNjq8dbeZmbjOSP5J
         NcOqjTLmEOS7EJJLwdwW2yHBW2DaoHmY+DAf5nAGhGvGeVUJZ3hV1rhP3Pt0cvfg8jyO
         T3kf1uj+sshGBYnyhtJ4mdgupxklCl8Ls90ZV9bPnJ48VYAxwWQaXhjtm20yUB6v2w9W
         B6NPUnXYJBP/uSR8C+DMKbBYMQES0qlqCIKyq+7MBqSngNKAuFxvYaKZ5RNTxWbzbuSD
         /bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAKiHUgxqE5rg0/f1FVu8ugVDbgO9Yb63m2qLMmxHgI=;
        b=D1RM2pBZNNxDQQ0MVck20JfX5sleH+i+7oKwHP+5mjyguaNmoMyFT/lJV/e0C7b0i7
         JahCAppn7btnXv3gt3dzWSkjuVkgBbfmf64EBL5m5fWJCrKy21xV0b9JNo1eWf2tQDPV
         MavzVwChBBcbiLrjvQZr5TbT/kQJ8WZAEcyDDfjqyR2LIS0vjm2z1OTb18zNFldlAV/T
         R1jaZbO8ONfKLPsAAAj1dCCTdQ5ZJurmRekhfeSyjDLNeU961P77MSDlSCCNsH7OxDfW
         5HSByWFZHKHXePFbWs3w14jclHdFJkThAux33v/ZeAJreoW8JETfJHNRz3lDHtngVfn2
         M1dg==
X-Gm-Message-State: AO0yUKWIBRbQGfni8Uaj4anjEsjG62CxXNeneNlKXfi7BgcNBSqMbUxo
        rroi6CwAWRgZSGtfD/yod0X7Zg==
X-Google-Smtp-Source: AK7set8cn7YrruxGmcYVHi8IPBD54PsERb/K7dO57Si+k70ChOPadUGgn25vP4twccmkoVCrjvR9Mw==
X-Received: by 2002:adf:ed43:0:b0:2c1:2a2e:34e2 with SMTP id u3-20020adfed43000000b002c12a2e34e2mr2444601wro.69.1675775734397;
        Tue, 07 Feb 2023 05:15:34 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i6-20020adffc06000000b002c3e28d0343sm7326438wrr.85.2023.02.07.05.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:15:33 -0800 (PST)
Message-ID: <c1564a80-d1be-f31d-2db3-1ec0b847e921@linaro.org>
Date:   Tue, 7 Feb 2023 13:15:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 21/27] gunyah: vm_mgr: Add framework to add VM
 Functions
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-22-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-22-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 22:46, Elliot Berman wrote:
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
> ---
>   Documentation/virt/gunyah/vm-manager.rst |  18 +++
>   drivers/virt/gunyah/vm_mgr.c             | 187 ++++++++++++++++++++++-
>   drivers/virt/gunyah/vm_mgr.h             |   5 +
>   include/linux/gunyah_vm_mgr.h            |  68 +++++++++
>   include/uapi/linux/gunyah.h              |  13 ++
>   5 files changed, 289 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/gunyah_vm_mgr.h
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index 62513af09cbf..d929f8f20b3b 100644
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
> +   the function is given the pointer to the `struct gunyah_resource` when the
> +   VM is starting.
> +
> +2. Register IO handler(s). IO handlers allow a function to handle stage-2 faults
> +   from the virtual machine.
> +
>   Sample Userspace VMM
>   ====================
>   
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index 48bd3f06fb6c..1e795f3d19d5 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -16,7 +16,147 @@
>   
>   #include "vm_mgr.h"
>   
> -static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
> +static DEFINE_MUTEX(functions_lock);
> +static LIST_HEAD(functions);
> +
> +static struct gunyah_vm_function_driver *__find_function(const char name[GUNYAH_FUNCTION_NAME_SIZE])
> +	__must_hold(functions_lock)
> +{
> +	struct gunyah_vm_function_driver *iter, *drv = NULL;
> +
> +	list_for_each_entry(iter, &functions, list) {
> +		if (!strncmp(iter->name, name, GUNYAH_FUNCTION_NAME_SIZE)) {
> +			drv = iter;
> +			break;
> +		}
> +	}
> +
> +	return drv;
> +}
> +
> +int gunyah_vm_function_register(struct gunyah_vm_function_driver *drv)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&functions_lock);
> +	if (__find_function(drv->name)) {
> +		ret = -EEXIST;
> +		goto out;
> +	}
> +
> +	INIT_LIST_HEAD(&drv->instances);
> +	list_add(&drv->list, &functions);
> +out:
> +	mutex_unlock(&functions_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gunyah_vm_function_register);
> +
> +static void gh_vm_remove_function(struct gunyah_vm_function *f)
> +	__must_hold(functions_lock)
> +{
> +	f->drv->release(f);
> +	list_del(&f->vm_list);
> +	list_del(&f->drv_list);
> +	module_put(f->drv->mod);
> +	kfree(f);
> +}
> +
> +void gunyah_vm_function_unregister(struct gunyah_vm_function_driver *drv)
> +{
> +	struct gunyah_vm_function *f, *iter;
> +
> +	mutex_lock(&functions_lock);
> +	list_for_each_entry_safe(f, iter, &drv->instances, drv_list)
> +		gh_vm_remove_function(f);
> +	list_del(&drv->list);
> +	mutex_unlock(&functions_lock);
> +}
> +EXPORT_SYMBOL_GPL(gunyah_vm_function_unregister);
> +
> +static long gh_vm_add_function(struct gunyah_vm *ghvm, struct gunyah_vm_function *f)
> +{
> +	long r = 0;
> +
> +	mutex_lock(&functions_lock);
> +	f->drv = __find_function(f->fn.name);
> +	if (!f->drv) {
> +		mutex_unlock(&functions_lock);
> +		r = request_module("ghfunc:%s", f->fn.name);
> +		if (r)
> +			return r;
> +
> +		mutex_lock(&functions_lock);
> +		f->drv = __find_function(f->fn.name);
> +	}
> +
> +	if (!f->drv) {
> +		r = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (!try_module_get(f->drv->mod)) {
> +		r = -ENOENT;
> +		f->drv = NULL;
> +		goto out;
> +	}
> +
> +	f->ghvm = ghvm;
> +	f->rm = ghvm->rm;
> +
> +	r = f->drv->bind(f);
> +	if (r < 0) {
> +		module_put(f->drv->mod);
> +		goto out;
> +	}
> +
> +	list_add(&f->vm_list, &ghvm->functions);
> +	list_add(&f->drv_list, &f->drv->instances);
> +out:
> +	mutex_unlock(&functions_lock);
> +	return r;
> +}
> +
> +static long gh_vm_rm_function(struct gunyah_vm *ghvm, struct gh_vm_function *fn)
> +{
> +	long r = 0;
> +	struct gunyah_vm_function *f, *iter;
> +
> +	r = mutex_lock_interruptible(&functions_lock);
> +	if (r)
> +		return r;
> +
> +	list_for_each_entry_safe(f, iter, &ghvm->functions, vm_list) {
> +		if (!memcmp(&f->fn, fn, sizeof(*fn)))
> +			gh_vm_remove_function(f);
> +	}
> +
> +	mutex_unlock(&functions_lock);
> +	return 0;
> +}
> +
> +static void ghvm_put(struct kref *kref)
> +{
> +	struct gunyah_vm *ghvm = container_of(kref, struct gunyah_vm, kref);
> +
> +	gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
> +	put_gh_rm(ghvm->rm);
> +	kfree(ghvm);
> +}
> +
> +int __must_check get_gunyah_vm(struct gunyah_vm *ghvm)
> +{
> +	return kref_get_unless_zero(&ghvm->kref);
> +}
> +EXPORT_SYMBOL_GPL(get_gunyah_vm);
> +
> +void put_gunyah_vm(struct gunyah_vm *ghvm)
> +{
> +	kref_put(&ghvm->kref, ghvm_put);
> +}
> +EXPORT_SYMBOL_GPL(put_gunyah_vm);
> +
> +static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm *rm)
>   {
>   	struct gunyah_vm *ghvm;
>   	int vmid;
> @@ -39,6 +179,8 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
>   	mutex_init(&ghvm->mm_lock);
>   	INIT_LIST_HEAD(&ghvm->memory_mappings);
>   	init_rwsem(&ghvm->status_lock);
> +	kref_init(&ghvm->kref);
> +	INIT_LIST_HEAD(&ghvm->functions);
>   
>   	return ghvm;
>   }
> @@ -192,6 +334,39 @@ static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   			r = -EINVAL;
>   		break;
>   	}
> +	case GH_VM_ADD_FUNCTION: {
> +		struct gunyah_vm_function *f;
> +
> +		r = -ENOMEM;
> +		f = kzalloc(sizeof(*f), GFP_KERNEL);
> +		if (!f)
> +			break;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&f->fn, argp, sizeof(f->fn)))
> +			break;
> +
> +		r = gh_vm_add_function(ghvm, f);
> +		if (r < 0)
> +			kfree(f);
> +		break;
> +	}
> +	case GH_VM_REMOVE_FUNCTION: {
> +		struct gh_vm_function *fn;
> +
> +		r = -ENOMEM;
> +		fn = kzalloc(sizeof(*fn), GFP_KERNEL);
> +		if (!fn)
> +			break;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(fn, argp, sizeof(*fn)))
> +			break;
> +
> +		r = gh_vm_rm_function(ghvm, fn);
> +		kfree(fn);
> +		break;
> +	}
>   	default:
>   		r = -ENOTTY;
>   		break;
> @@ -204,15 +379,23 @@ static int gh_vm_release(struct inode *inode, struct file *filp)
>   {
>   	struct gunyah_vm *ghvm = filp->private_data;
>   	struct gunyah_vm_memory_mapping *mapping, *tmp;
> +	struct gunyah_vm_function *f, *fiter;
>   
>   	gh_vm_stop(ghvm);
>   
> +	mutex_lock(&functions_lock);
> +	list_for_each_entry_safe(f, fiter, &ghvm->functions, vm_list) {
> +		gh_vm_remove_function(f);
> +	}
> +	mutex_unlock(&functions_lock);
> +
>   	list_for_each_entry_safe(mapping, tmp, &ghvm->memory_mappings, list) {
>   		gh_vm_mem_mapping_reclaim(ghvm, mapping);
>   		kfree(mapping);
>   	}
> +
>   	put_gh_rm(ghvm->rm);
> -	kfree(ghvm);
> +	put_gunyah_vm(ghvm);
>   	return 0;
>   }
>   
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> index 5c02fb305893..8d3b0678fb96 100644
> --- a/drivers/virt/gunyah/vm_mgr.h
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/gunyah_rsc_mgr.h>
>   #include <linux/list.h>
> +#include <linux/kref.h>
>   #include <linux/miscdevice.h>
>   #include <linux/mutex.h>
>   #include <linux/rwsem.h>
> @@ -41,8 +42,12 @@ struct gunyah_vm {
>   	enum gh_rm_vm_status vm_status;
>   	struct rw_semaphore status_lock;
>   
> +	struct kref kref;
> +
>   	struct mutex mm_lock;
>   	struct list_head memory_mappings;
> +
> +	struct list_head functions;
>   };
>   
>   struct gunyah_vm_memory_mapping *gh_vm_mem_mapping_alloc(struct gunyah_vm *ghvm,
> diff --git a/include/linux/gunyah_vm_mgr.h b/include/linux/gunyah_vm_mgr.h
> new file mode 100644
> index 000000000000..69f98eb503e9
> --- /dev/null
> +++ b/include/linux/gunyah_vm_mgr.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _GUNYAH_VM_MGR_H
> +#define _GUNYAH_VM_MGR_H
> +
> +#include <linux/compiler_types.h>
> +#include <linux/gunyah.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/list.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/notifier.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +struct gunyah_vm;
> +
> +int __must_check get_gunyah_vm(struct gunyah_vm *ghvm);
> +void put_gunyah_vm(struct gunyah_vm *ghvm);
> +
> +struct gunyah_vm_function;
> +struct gunyah_vm_function_driver {
> +	const char name[GUNYAH_FUNCTION_NAME_SIZE];
> +	struct module *mod;
> +	long (*bind)(struct gunyah_vm_function *f);
> +	void (*release)(struct gunyah_vm_function *f);
> +	struct list_head list;
> +	struct list_head instances;
> +};
> +
> +struct gunyah_vm_function {
> +	struct gh_vm_function fn;
> +	struct gunyah_vm *ghvm;
> +	struct gh_rm *rm;
> +	struct gunyah_vm_function_driver *drv;
> +	void *data;
> +	struct list_head vm_list;
> +	struct list_head drv_list;
> +};
> +
> +int gunyah_vm_function_register(struct gunyah_vm_function_driver *f);
> +void gunyah_vm_function_unregister(struct gunyah_vm_function_driver *f);
> +
> +#define DECLARE_GUNYAH_VM_FUNCTION(_name, _bind, _release)		\
> +	static struct gunyah_vm_function_driver _name = {		\
> +		.name = __stringify(_name),				\
> +		.mod = THIS_MODULE,					\
> +		.bind = _bind,						\
> +		.release = _release,					\
> +	};								\
> +	MODULE_ALIAS("ghfunc:"__stringify(_name))

lets not over kill this by having DECLARE_GUNYAH_VM_FUNCTION, this will 
make the drivers readable in a more familar way. let the driver define 
this static struct.


> +
> +#define DECLARE_GUNYAH_VM_FUNCTION_INIT(_name, _bind, _release)		\
> +	DECLARE_GUNYAH_VM_FUNCTION(_name, _bind, _release);		\
> +	static int __init _name##_mod_init(void)			\
> +	{								\
> +		return gunyah_vm_function_register(&(_name));		\
> +	}								\
> +	module_init(_name##_mod_init);					\
> +	static void __exit _name##_mod_exit(void)			\
> +	{								\
> +		gunyah_vm_function_unregister(&(_name));		\
> +	}								\
> +	module_exit(_name##_mod_exit)
> +

How about:

#define module_gunyah_function_driver(__gf_driver)
         module_driver(__gf_driver, gunyah_vm_function_register, \
                         gunyah_vm_function_unregister)

Having relook at the patch, I think modeling the gunyah_vm_function as a 
proper device and driver model will scale, you could leverage most of 
this manual management to the existing driver model. May I suggest to 
you take a look at  include/linux/auxiliary_bus.h
with that you could model add_functions as
auxiliary_device_add and the respecitive drivers as module_auxiliary_driver.

> +#endif
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 36359ad2175e..ec8da6fde045 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -50,4 +50,17 @@ struct gh_vm_dtb_config {
>   
>   #define GH_VM_START		_IO(GH_IOCTL_TYPE, 0x3)
>   
> +#define GUNYAH_FUNCTION_NAME_SIZE		32
> +#define GUNYAH_FUNCTION_MAX_ARG_SIZE		1024
> +
> +struct gh_vm_function {
> +	char name[GUNYAH_FUNCTION_NAME_SIZE];
> +	union {
> +		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];

Are we missing any thing here, its odd to see a single member union like 
this.
if other memembers are part of another patch please move them to this 
one as its confusing.
> +	};
> +};
> +
> +#define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_vm_function)
> +#define GH_VM_REMOVE_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x7, struct gh_vm_function)
> +
>   #endif
