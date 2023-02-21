Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121E769DE24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBUKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:46:11 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE4922035
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:46:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t13so3829426wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sd64Vl/ocLQAKFinJVHc0nnXpTzTz1sxrsjUhCW8XzU=;
        b=L9N2sMfCDxEftxrKDhPF1D+ULhkKs4Q2AAWmqm7xYVnceALrJIzy71bPm8Ez6au2Xc
         9AAbIWDRAzGurAkO2p6OVW+rFbWjbkYf/icgXJrAYJPY79VYkbf5rQkT19zU7ISzecU5
         XTGTUN1wx+v5rTmaZu2YFxOTqebZm5otCOmzrqhTYduAQD/FTNuxOcDQgz3i+Zvw/Hmo
         sLiUIqIYM+q+3J6LYvVB9fAQyXlccBglUfhzrGZjYeI4l+150gPwfVnX4ts+x6vD97qX
         dcouc+qNsXSAkVtrDlAJMSyxYBv2e2X5TrYQHQrQ5og/hGfC/hv6Qy8iy02/cp9rSIC4
         U9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sd64Vl/ocLQAKFinJVHc0nnXpTzTz1sxrsjUhCW8XzU=;
        b=ezAGHTjloHggIFJ3aeS4ueZR9+RvHhuAUohj1Bx3Gr2zPpBnIl3LbDB58tkuhZMVp2
         Pm/u2sGLbqccVV1e3cUf/iPhnFuxeziyLctXS+Py/i2HCVE08gY6g8E4NPDUTnmtAyN2
         VTyQuLQoofbqa5GExhAgIkuqX/tzSzQ5KxStKCERfls9EjLsspe++Zei5l3PEqSMePK6
         nLgk4vClH3BBo9zpBU1HAndvz4JfhUjJNB6rjzNzvqB07qytGldSxLXBSzXH1xx0NQaj
         kMsime6r/PktTS8QB4T3TBHIFvamW5MYWMP/Ec1kTj8gqpxZbZgPDv8efRMd4Et7bmtu
         Zemw==
X-Gm-Message-State: AO0yUKUW1QWhGGF5A4iDfL4ZpqE7rlEIc0ywg+2JBBtho4Y6FZtDwbAZ
        5+gYGU7YD/eavjqOIh9Fhv4Aag==
X-Google-Smtp-Source: AK7set+XHFJ83YZICxtjlFusD5HvFybIf677VpyIxQOkl2dZpiT7JLj7dxAXtacAQ+SLTQkTXaiE9w==
X-Received: by 2002:a5d:4905:0:b0:2c6:e7f6:49af with SMTP id x5-20020a5d4905000000b002c6e7f649afmr2302205wrq.27.1676976363941;
        Tue, 21 Feb 2023 02:46:03 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q2-20020adff942000000b002c573778432sm7898257wrr.102.2023.02.21.02.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 02:46:03 -0800 (PST)
Message-ID: <dbcfa4e9-a1ad-0f24-77bf-05934ca26bb2@linaro.org>
Date:   Tue, 21 Feb 2023 10:46:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 10/26] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212356.3313181-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212356.3313181-1-quic_eberman@quicinc.com>
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



On 14/02/2023 21:23, Elliot Berman wrote:
> 
> Gunyah VM manager is a kernel moduel which exposes an interface to
> Gunyah userspace to load, run, and interact with other Gunyah virtual
> machines. The interface is a character device at /dev/gunyah.
> 
> Add a basic VM manager driver. Upcoming patches will add more ioctls
> into this driver.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   drivers/virt/gunyah/Makefile                  |   2 +-
>   drivers/virt/gunyah/rsc_mgr.c                 |  37 +++++-
>   drivers/virt/gunyah/vm_mgr.c                  | 118 ++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  |  22 ++++
>   include/uapi/linux/gunyah.h                   |  23 ++++
>   6 files changed, 201 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/vm_mgr.c
>   create mode 100644 drivers/virt/gunyah/vm_mgr.h
>   create mode 100644 include/uapi/linux/gunyah.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 0a1882e296ae..2513324ae7be 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -137,6 +137,7 @@ Code  Seq#    Include File                                           Comments
>   'F'   DD     video/sstfb.h                                           conflict!
>   'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           conflict!
>   'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            conflict!
> +'G'   00-0f  linux/gunyah.h                                          conflict!
>   'H'   00-7F  linux/hiddev.h                                          conflict!
>   'H'   00-0F  linux/hidraw.h                                          conflict!
>   'H'   01     linux/mei.h                                             conflict!
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index de29769f2f3f..03951cf82023 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -2,5 +2,5 @@
>   
>   obj-$(CONFIG_GUNYAH) += gunyah.o
>   
> -gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> index 2a47139873a8..73c5a6b7cbbc 100644
> --- a/drivers/virt/gunyah/rsc_mgr.c
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -16,8 +16,10 @@
>   #include <linux/completion.h>
>   #include <linux/gunyah_rsc_mgr.h>
>   #include <linux/platform_device.h>
> +#include <linux/miscdevice.h>
>   
>   #include "rsc_mgr.h"
> +#include "vm_mgr.h"
>   
>   #define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
>   #define RM_RPC_HEADER_WORDS_MASK	GENMASK(7, 4)
> @@ -103,6 +105,8 @@ struct gh_rm {
>   	struct kmem_cache *cache;
>   	struct mutex send_lock;
>   	struct blocking_notifier_head nh;
> +
> +	struct miscdevice miscdev;
>   };
>   
>   static struct gh_rm_connection *gh_rm_alloc_connection(__le32 msg_id, u8 type)
> @@ -509,6 +513,21 @@ void put_gh_rm(struct gh_rm *rm)
>   }
>   EXPORT_SYMBOL_GPL(put_gh_rm);
>   
> +static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	struct miscdevice *miscdev = filp->private_data;
> +	struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
> +
> +	return gh_dev_vm_mgr_ioctl(rm, cmd, arg);
> +}
> +
> +static const struct file_operations gh_dev_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= gh_dev_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
>   static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
>   					bool tx, int idx, struct gunyah_resource *ghrsc)
>   {
> @@ -567,7 +586,22 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
>   	rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
>   	rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
>   
> -	return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
> +	ret = gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
> +	if (ret)
> +		goto err_cache;
> +
> +	rm->miscdev.name = "gunyah";
> +	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	rm->miscdev.fops = &gh_dev_fops;
> +
> +	ret = misc_register(&rm->miscdev);
> +	if (ret)
> +		goto err_msgq;
> +
> +	return 0;
> +err_msgq:
> +	mbox_free_channel(gh_msgq_chan(&rm->msgq));
> +	gh_msgq_remove(&rm->msgq);
>   err_cache:
>   	kmem_cache_destroy(rm->cache);
>   	return ret;
> @@ -577,6 +611,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
>   {
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
> +	misc_deregister(&rm->miscdev);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> new file mode 100644
> index 000000000000..fd890a57172e
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gh_vm_mgr: " fmt
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/file.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +#include "vm_mgr.h"
> +
> +static void gh_vm_free(struct work_struct *work)
> +{
> +	struct gh_vm *ghvm = container_of(work, struct gh_vm, free_work);
> +	int ret;
> +
> +	ret = gh_rm_dealloc_vmid(ghvm->rm, ghvm->vmid);
> +	if (ret)
> +		pr_warn("Failed to deallocate vmid: %d\n", ret);
> +
> +	put_gh_rm(ghvm->rm);
> +	kfree(ghvm);
> +}
> +
> +static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
> +{
> +	struct gh_vm *ghvm;
> +	int vmid;
> +
> +	vmid = gh_rm_alloc_vmid(rm, 0);
> +	if (vmid < 0)
> +		return ERR_PTR(vmid);
> +
> +	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
> +	if (!ghvm) {
> +		gh_rm_dealloc_vmid(rm, vmid);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	get_gh_rm(rm);
> +
> +	ghvm->vmid = vmid;
> +	ghvm->rm = rm;
> +
> +	INIT_WORK(&ghvm->free_work, gh_vm_free);
> +
> +	return ghvm;
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
> +	return 0;
> +}
> +
> +static const struct file_operations gh_vm_fops = {
> +	.release = gh_vm_release,

> +	.compat_ioctl	= compat_ptr_ioctl,

This line should go with the patch that adds real ioctl

> +	.llseek = noop_llseek,
> +};
> +
> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
Not sure what is the gain of this multiple levels of redirection.

How about

long gh_dev_create_vm(struct gh_rm *rm, unsigned long arg)
{
...
}

and rsc_mgr just call it as part of its ioctl call

static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned 
long arg)
{
	struct miscdevice *miscdev = filp->private_data;
	struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);

	switch (cmd) {
	case GH_CREATE_VM:
		return gh_dev_create_vm(rm, arg);
	default:
		return -ENOIOCTLCMD;
	}
}


> +{
> +	struct gh_vm *ghvm;
> +	struct file *file;
> +	int fd, err;
> +
> +	/* arg reserved for future use. */
> +	if (arg)
> +		return -EINVAL;

The only code path I see here is via GH_CREATE_VM ioctl which obviously 
does not take any arguments, so if you are thinking of using the 
argument for architecture-specific VM flags.  Then this needs to be 
properly done by making the ABI aware of this.

As you mentioned zero value arg imply an "unauthenticated VM" type, but 
this was not properly encoded in the userspace ABI. Why not make it 
future compatible. How about adding arguments to GH_CREATE_VM and pass 
the required information correctly.
Note that once the ABI is accepted then you will not be able to change 
it, other than adding a new one.

> +
> +	ghvm = gh_vm_alloc(rm);
> +	if (IS_ERR(ghvm))
> +		return PTR_ERR(ghvm);
> +
> +	fd = get_unused_fd_flags(O_CLOEXEC);
> +	if (fd < 0) {
> +		err = fd;
> +		goto err_destroy_vm;
> +	}
> +
> +	file = anon_inode_getfile("gunyah-vm", &gh_vm_fops, ghvm, O_RDWR);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		goto err_put_fd;
> +	}
> +
> +	fd_install(fd, file);
> +
> +	return fd;
> +
> +err_put_fd:
> +	put_unused_fd(fd);
> +err_destroy_vm:
> +	kfree(ghvm);
> +	return err;
> +}
> +
> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case GH_CREATE_VM:
> +		return gh_dev_ioctl_create_vm(rm, arg);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> new file mode 100644
> index 000000000000..76954da706e9
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _GH_PRIV_VM_MGR_H
> +#define _GH_PRIV_VM_MGR_H
> +
> +#include <linux/gunyah_rsc_mgr.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned long arg);
> +
> +struct gh_vm {
> +	u16 vmid;
> +	struct gh_rm *rm;
> +
> +	struct work_struct free_work;
> +};
> +
> +#endif
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> new file mode 100644
> index 000000000000..10ba32d2b0a6
> --- /dev/null
> +++ b/include/uapi/linux/gunyah.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _UAPI_LINUX_GUNYAH
> +#define _UAPI_LINUX_GUNYAH
> +
> +/*
> + * Userspace interface for /dev/gunyah - gunyah based virtual machine
> + */
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define GH_IOCTL_TYPE			'G'
> +
> +/*
> + * ioctls for /dev/gunyah fds:
> + */
> +#define GH_CREATE_VM			_IO(GH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */

Can HLOS forcefully destroy a VM?
If so should we have a corresponding DESTROY IOCTL?

--srini

> +
> +#endif
