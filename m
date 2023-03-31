Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8A6D2276
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjCaO0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjCaO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:26:34 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FB62062D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id cu4so16462739qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272761; x=1682864761;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GR8HbSJNeX2/6gkzUuSiSFMjntM3+JJlkqi7H7u9npY=;
        b=LlNcj2jyX8XrRKCjQxXr5wwSbidsngkFvz+FSRaK9YWDFL40NY7/3kgh+soDlzADsm
         f+xDW5dF490piR99KCafCo+FTsAPQLhbf3DYMaCegIuoo9mLUrznKGjUd5qJX1ObfOcY
         t0iiFwHYZwliOXUqdYRuznpAKLxg06VV9JKOBoBLDf5uPxD8ZHnmhu+VpG86lE3EIBi8
         bPiT5XIV3VodVsXHBI+HosufvLthN0ttaAoSZYT6kmhzZ8Qv6Ij0lY4qN4RulBDpKRIS
         bYUgif6rY5h+Ox4oTje6xwxnhDsw4r5hy5a+4kMcO18XFwQrk27KNUbYDTw53CtIybv5
         RkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272761; x=1682864761;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GR8HbSJNeX2/6gkzUuSiSFMjntM3+JJlkqi7H7u9npY=;
        b=YIOTJGcJPx/3jCpvUGGQQ+utJislGXNDhKCkCgljIZ3aGsyh6K/5XlNxJTdX0dQSAn
         klOXAQODSQffw0Vv2KGZhgM5zYsSjD7ajJsS57gN/JSPtQ2sGgJLDch2eKRGRje5skyL
         cg4lYSemjma2eLD3rr2uh2u2YX0iaO2iBUaXWi3nP7Qf08zYp0dZ+aQeVInUESYlkk+u
         ye9wBgGrRTJqkbJuQ+YFOQ03ioLdFrOxBBO+XwwW51KL9UffS2Ky7YKBW5/tIAPPLe1V
         zCKtaeSje5GVydVy5eCLIIO0b3dsePEgY1KIfkAgSr0N6EDBu0s9TQF7t7cG1WDFLUtN
         mwIQ==
X-Gm-Message-State: AAQBX9caC1GJZTWEScvNd7+76UBz0tLnbJc6Dp3g/qYz2TolTv2DpKCa
        J+rphr32JLyeG2wp3Jhcs7b6VA==
X-Google-Smtp-Source: AKy350aCdaT57cC6uWksuF5mhfKW1oFiWKlrdmkyxSri2/aHfUyewgmtwvFz9rHLt5dnqxqDTt1V8w==
X-Received: by 2002:a05:6214:e85:b0:5aa:4c08:f188 with SMTP id hf5-20020a0562140e8500b005aa4c08f188mr42053846qvb.51.1680272761386;
        Fri, 31 Mar 2023 07:26:01 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id ob8-20020a0562142f8800b005e2007584f1sm420165qvb.24.2023.03.31.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:26:01 -0700 (PDT)
Message-ID: <37bc641a-77b9-a740-a08e-8b86d0b50630@linaro.org>
Date:   Fri, 31 Mar 2023 09:25:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 10/26] gunyah: vm_mgr: Introduce basic VM Manager
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-11-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-11-quic_eberman@quicinc.com>
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

One suggestion to move some code here.  And a few other minor
things.

					-Alex

> ---
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   drivers/virt/gunyah/Makefile                  |   2 +-
>   drivers/virt/gunyah/rsc_mgr.c                 |  38 +++++-
>   drivers/virt/gunyah/vm_mgr.c                  | 116 ++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  |  23 ++++
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
> index 67813c9a52db..d7ce692d0067 100644
> --- a/drivers/virt/gunyah/rsc_mgr.c
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -15,8 +15,10 @@
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
> @@ -129,6 +131,7 @@ struct gh_rm_connection {
>    * @cache: cache for allocating Tx messages
>    * @send_lock: synchronization to allow only one request to be sent at a time
>    * @nh: notifier chain for clients interested in RM notification messages
> + * @miscdev: /dev/gunyah
>    */
>   struct gh_rm {
>   	struct device *dev;
> @@ -145,6 +148,8 @@ struct gh_rm {
>   	struct kmem_cache *cache;
>   	struct mutex send_lock;
>   	struct blocking_notifier_head nh;
> +
> +	struct miscdevice miscdev;
>   };
>   
>   /**
> @@ -593,6 +598,21 @@ void gh_rm_put(struct gh_rm *rm)
>   }
>   EXPORT_SYMBOL_GPL(gh_rm_put);
>   

I feel like /dev/gunyah code would more appropriately be found
in "vm_mgr.c".  All gh_dev_ioctl() does is call the function
defined there, and it's therefore a VM-oriented rather than
resource-oriented device.

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
>   static int gh_msgq_platform_probe_direction(struct platform_device *pdev, bool tx,
>   					    struct gh_resource *ghrsc)
>   {
> @@ -651,7 +671,22 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
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
> @@ -661,6 +696,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
>   {
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
> +	misc_deregister(&rm->miscdev);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> new file mode 100644
> index 000000000000..dbacf36af72d
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -0,0 +1,116 @@
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
> +	ghvm->parent = gh_rm_get(rm);
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
> +	.llseek = noop_llseek,
> +};
> +
> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
> +{
> +	struct gh_vm *ghvm;
> +	struct file *file;
> +	int fd, err;
> +
> +	/* arg reserved for future use. */

Do you have a clear idea of how this might be used in the future?

I was thinking you could silently ignore the argument value, but
I suppose if it *does* get used in the future, you want the caller
to know it's being ignored.  (Is that right?)

> +	if (arg)
> +		return -EINVAL;
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
> +	gh_vm_free(&ghvm->free_work);
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
> index 000000000000..4b22fbcac91c
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _GH_PRIV_VM_MGR_H
> +#define _GH_PRIV_VM_MGR_H

Maybe _GH_VM_MGR_H?

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
> +	struct device *parent;
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

Use _UAPI_LINUX_GUNYAH_H

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

