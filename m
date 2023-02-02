Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C2687DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjBBMyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBBMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:54:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA6360B1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:54:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1302641wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 04:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGDp7716sT1eqe9YQ1tcc7XxxRqLoBRLLBmsSB6reNM=;
        b=XQiMlQml0DXKzG0v891loqgy94caSyXEo6hOVw75KMQtB45YNQHXfUZ2uWY2mmsqpr
         yXkuFmY9nV3dU7bYpjmO17TyUFiSXXzHZEZmGWTCqrH+Q7C36ZMEP4df7A7oRRmMhs2O
         wh/WwfMeoYwowxursdZ2aj1dWsqSxi8N9vyzNy7oRU515J5zSjzUbNhDLq0q34doAI1S
         QirB1D5XM+o9C3dZ9XeWc94P9phZL2WNoe5TuoLXPYJ/BqmOHO9piPVJGi3Lqh5rDkqo
         FBpiHpvtWd79F5X6WiNffbBye10mCfXDvZypYzXMrWwF5Nlt5O5pkVckRU1tmGGxb1CH
         2wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGDp7716sT1eqe9YQ1tcc7XxxRqLoBRLLBmsSB6reNM=;
        b=tb4pcfms1XRJDUwU0cwjipBWGITAjgEnwnPuLZk7eukyqZ8wtbAQnIpctSzUOp+z9h
         9YFkBoeX+PgXuat+A+tW88midUD43Ny8bUonBEMbRl+Yq7XoShs/TFu1aFDVerdcgjds
         Vkqn6mB+ikxGTFIEYQIKO0IdPLhUAl8PjmwEGiqz3usLDjiietx5bsnH8mgWavlUxIrC
         r1OSks6FoI3SfbqfmHD/dpN9G5Omc1OxqDU8KWlriKVGGpKvYNqjD+FDR/rYRwFAV5dC
         1Y00Le/SSu0A9J7zX3FhTEw4siBCZ0T6/jVS05s28/34uAUy+u3dB3pS7ke7Iezd/9s0
         Pbyw==
X-Gm-Message-State: AO0yUKX0joFrhxeYrWif9rV9o3UlsfrVgDUzfwCh4w6kpHN076wNTxzX
        PRZnIo9Dt2aJ1gL98yULLrzWEw==
X-Google-Smtp-Source: AK7set8RcJmr7/yTpbHp90WCkCjakBS0ObD2W5bqUa1QHbIhJtRmuYEiQTp0JLl1H9gYQ0z4JzshGA==
X-Received: by 2002:a05:600c:4f96:b0:3cf:9844:7b11 with SMTP id n22-20020a05600c4f9600b003cf98447b11mr6136169wmq.23.1675342470159;
        Thu, 02 Feb 2023 04:54:30 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id u1-20020a05600c00c100b003a3442f1229sm4682183wmm.29.2023.02.02.04.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:54:29 -0800 (PST)
Message-ID: <5c5bec7d-e3de-ef7e-b0fc-83d6c0481af1@linaro.org>
Date:   Thu, 2 Feb 2023 12:54:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 11/27] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-12-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-12-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 22:46, Elliot Berman wrote:
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
>   drivers/virt/gunyah/rsc_mgr.c                 |  51 +++++++-
>   drivers/virt/gunyah/vm_mgr.c                  | 117 ++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  |  20 +++
>   include/linux/gunyah_rsc_mgr.h                |   3 +
>   include/uapi/linux/gunyah.h                   |  23 ++++
>   7 files changed, 215 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/vm_mgr.c
>   create mode 100644 drivers/virt/gunyah/vm_mgr.h
>   create mode 100644 include/uapi/linux/gunyah.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index eb045fc495a4..8696dc3cdd83 100644
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
> index 382f9943fd31..95f4aa928aaf 100644
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
> @@ -105,6 +107,7 @@ struct gh_rm {
>   	struct kmem_cache *cache;
>   	struct mutex send_lock;
>   
> +	struct miscdevice miscdev;
>   	struct work_struct recv_work;
>   };
>   
> @@ -526,6 +529,33 @@ int gh_rm_call(struct gh_rm *rm, u32 message_id, void *req_buff, size_t req_buff
>   	return ret;
>   }
>   
> +void get_gh_rm(struct gh_rm *rm)
> +{
> +	get_device(rm->dev);
> +}
> +EXPORT_SYMBOL_GPL(get_gh_rm);

We have 4/5 different vairants of exported symbols now.

EXPORT_SYMBOL_GPL(gunyah_vm_function_unregister);
EXPORT_SYMBOL_GPL(ghvm_add_resource_ticket);
EXPORT_SYMBOL_GPL(gh_vm_mgr_mmio_write);
EXPORT_SYMBOL_GPL(put_gh_rm);
EXPORT_SYMBOL_GPL(get_gunyah_vm);

I think this needs to be cleaned up for consistency reasons.

> +
> +void put_gh_rm(struct gh_rm *rm)
> +{
> +	put_device(rm->dev);
> +}
> +EXPORT_SYMBOL_GPL(put_gh_rm);
> +
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
> @@ -582,13 +612,32 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
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
> +err_cache:
> +	kmem_cache_destroy(rm->cache);
> +	return ret;
>   }
>   
>   static int gh_rm_drv_remove(struct platform_device *pdev)
>   {
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
> +	misc_deregister(&rm->miscdev);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> new file mode 100644
> index 000000000000..0864dbd77e28
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -0,0 +1,117 @@
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
> +static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gh_rm_rpc *rm)
> +{
> +	struct gunyah_vm *ghvm;
> +	int vmid;
> +
> +	vmid = gh_rm_alloc_vmid(rm, 0);
> +	if (vmid < 0)
> +		return ERR_PTR(vmid);
> +
> +	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
> +	if (!ghvm) {
> +		gh_rm_dealloc_vmid(rm, vmid);
> +		return ghvm;

return ERR_PTR(-ENOMEM);

> +	}
> +
> +	get_gh_rm(rm);
> +
> +	ghvm->vmid = vmid;
> +	ghvm->rm = rm;
> +
> +	return ghvm;
> +}
> +
> +static long gh_vm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	long r;
> +
> +	switch (cmd) {
> +	default:
> +		r = -ENOTTY;
> +		break;
> +	}

this function looks like dummy, why do we need this in this patch?

> +
> +	return r;
> +}
> +
> +static int gh_vm_release(struct inode *inode, struct file *filp)
> +{
> +	struct gunyah_vm *ghvm = filp->private_data;
> +
> +	put_gh_rm(ghvm->rm);
> +	kfree(ghvm);
> +	return 0;
> +}
> +
> +static const struct file_operations gh_vm_fops = {
> +	.unlocked_ioctl = gh_vm_ioctl,
> +	.release = gh_vm_release,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +	.llseek = noop_llseek,
> +};
> +
> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
> +{
> +	struct gunyah_vm *ghvm;
> +	struct file *file;
> +	int fd, err;
> +
> +	/* arg reserved for future use. */
> +	if (arg)
> +		return -EINVAL;

Bit confused here, GH_CREATE_VM IOCTL does not take any arguments so why 
is this arg reserved for future use. Are you going to change the ABI for 
GH_CREATE_VM?


> +
> +	ghvm = gunyah_vm_alloc(rm);
> +	if (IS_ERR_OR_NULL(ghvm))
> +		return PTR_ERR(ghvm) ? : -ENOMEM;
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
> +EXPORT_SYMBOL_GPL(gh_dev_vm_mgr_ioctl);
> +
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> new file mode 100644
> index 000000000000..e47f34de7f9e
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -0,0 +1,20 @@
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
> +struct gunyah_vm {
> +	u16 vmid;
> +	struct gh_rm_rpc *rm;
> +};
> +
> +#endif
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index be0bce5507b1..9a9a037b349a 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -17,6 +17,9 @@
>   
>   struct gh_rm;
>   
> +void get_gh_rm(struct gh_rm *rm);
> +void put_gh_rm(struct gh_rm *rm);
> +
>   enum gh_rm_vm_status {
>   	GH_RM_VM_STATUS_NO_STATE	= 0,
>   	GH_RM_VM_STATUS_INIT		= 1,
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> new file mode 100644
> index 000000000000..88a40d6e0b96
> --- /dev/null
> +++ b/include/uapi/linux/gunyah.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
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
> +
> +#endif
