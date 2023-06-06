Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214F172431C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjFFMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbjFFMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:52:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE82E73
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:51:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so52585325e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055908; x=1688647908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZh99cIYnwvZsi6uZpNCU21woKiQBSAqCICVQ7Ob5E0=;
        b=zPz/3ZBG0cPd6MQtjJaYXoEjtlfz9hcya6M2rJWZD90St+gjqlyY35Z7EJR8a+9FvQ
         2Hwv/hxhLFhwC6dJzW1C7S2JPKI2fOioe3KA/R3EaYdNehcoYOov0WGvLu1Mn+WfG4ne
         AgKVkeRzLF2CXYP271biPMDwXqIDFnJN8ZQXPrpVom9NVOGpnSQfb/zSZjCsS5OmkC0p
         rfen1v3ksaoGwSuGxTVJlPIlRx6hS4Ks82gC/7y4+EkbdcZQr44VLC4alrhuqSd8wN63
         bpEysiVinj3oZk/qr3q6Rmfi6gEQTXUikac6vhmqz2bjdO3XADq4UJQ90i2h48HaLa/g
         ucJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055908; x=1688647908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZh99cIYnwvZsi6uZpNCU21woKiQBSAqCICVQ7Ob5E0=;
        b=ainCM/CJn5a4XyOQZBlaL5ROOcY1FMAYyqI3TX3Sfp0yORrjydTnT2rA3ui62Qu2VK
         Z7Z8hUNnit2tOWisX/m5nmuitG/ClpbIFE3eQcw3u6jzuOuuw7CGwnkJd0ltoipJi8x3
         Paq1BLd0pr8Bd2jFrQozURvZ7BCyKR4+XeboyPIQ3VbGyPo4Evs23azBzHPFFxqp2Pcf
         Bez6j3YHcuwRI5YZnJjME5LEaEP1r8JDaBxG7cyCHx5eJYxfCShJhACj1mHf3rTwffF0
         4xAsWLHbotQpB0vcUZYvWB1PFLkjkRPn2nhglNH2IWKSg/6a0o2ZzGYpqHVe0BRt3Tqj
         VLrg==
X-Gm-Message-State: AC+VfDzu6VhovxyKCoVqalGUhCfs0bqCCX7Mhg46DkN9baK1D/Aw9Oyq
        TCyFy79PnZ5q34qdY4UXbgrATw==
X-Google-Smtp-Source: ACHHUZ4Ae36WqblRWF0dpgIZyUiWIfTtkAnUt2NN2wz9itn7NnEzqxaZdrANrhn9T9EAmOMNz2qLPQ==
X-Received: by 2002:a7b:c041:0:b0:3f6:787:4a84 with SMTP id u1-20020a7bc041000000b003f607874a84mr1999484wmc.7.1686055907851;
        Tue, 06 Jun 2023 05:51:47 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z24-20020a1c4c18000000b003f734ee1670sm10136442wmf.31.2023.06.06.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 05:51:47 -0700 (PDT)
Message-ID: <898f5d05-8d9c-c2f3-723f-dd326dcb9439@linaro.org>
Date:   Tue, 6 Jun 2023 13:51:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v13 08/24] gunyah: vm_mgr: Introduce basic VM Manager
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-9-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230509204801.2824351-9-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/05/2023 21:47, Elliot Berman wrote:
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



Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>   drivers/virt/gunyah/Makefile                  |  2 +-
>   drivers/virt/gunyah/rsc_mgr.c                 | 50 +++++++++-
>   drivers/virt/gunyah/vm_mgr.c                  | 93 +++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.h                  | 20 ++++
>   include/uapi/linux/gunyah.h                   | 23 +++++
>   6 files changed, 187 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/vm_mgr.c
>   create mode 100644 drivers/virt/gunyah/vm_mgr.h
>   create mode 100644 include/uapi/linux/gunyah.h
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 176e8fc3f31b..396212e88f7d 100644
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
> index 241bab357b86..e47e25895299 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,4 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
> -gunyah-y += rsc_mgr.o rsc_mgr_rpc.o
> +gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
>   obj-$(CONFIG_GUNYAH) += gunyah.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> index 88b5beb1ea51..4f6f96bdcf3d 100644
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
> @@ -130,6 +132,7 @@ struct gh_rm_connection {
>    * @cache: cache for allocating Tx messages
>    * @send_lock: synchronization to allow only one request to be sent at a time
>    * @nh: notifier chain for clients interested in RM notification messages
> + * @miscdev: /dev/gunyah
>    */
>   struct gh_rm {
>   	struct device *dev;
> @@ -146,6 +149,8 @@ struct gh_rm {
>   	struct kmem_cache *cache;
>   	struct mutex send_lock;
>   	struct blocking_notifier_head nh;
> +
> +	struct miscdevice miscdev;
>   };
>   
>   /**
> @@ -581,6 +586,33 @@ int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb)
>   }
>   EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
>   
> +struct device *gh_rm_get(struct gh_rm *rm)
> +{
> +	return get_device(rm->miscdev.this_device);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get);
> +
> +void gh_rm_put(struct gh_rm *rm)
> +{
> +	put_device(rm->miscdev.this_device);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_put);
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
>   static int gh_msgq_platform_probe_direction(struct platform_device *pdev, bool tx,
>   					    struct gh_resource *ghrsc)
>   {
> @@ -665,7 +697,22 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
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
> @@ -675,6 +722,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
>   {
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
> +	misc_deregister(&rm->miscdev);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> new file mode 100644
> index 000000000000..a43401cb34f7
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -0,0 +1,93 @@
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
> +static __must_check struct gh_vm *gh_vm_alloc(struct gh_rm *rm)
> +{
> +	struct gh_vm *ghvm;
> +
> +	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
> +	if (!ghvm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ghvm->parent = gh_rm_get(rm);
> +	ghvm->rm = rm;
> +
> +	return ghvm;
> +}
> +
> +static int gh_vm_release(struct inode *inode, struct file *filp)
> +{
> +	struct gh_vm *ghvm = filp->private_data;
> +
> +	gh_rm_put(ghvm->rm);
> +	kfree(ghvm);
> +	return 0;
> +}
> +
> +static const struct file_operations gh_vm_fops = {
> +	.owner = THIS_MODULE,
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
> +	gh_rm_put(ghvm->rm);
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
> +		return -ENOTTY;
> +	}
> +}
> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
> new file mode 100644
> index 000000000000..1e94b58d7d34
> --- /dev/null
> +++ b/drivers/virt/gunyah/vm_mgr.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _GH_VM_MGR_H
> +#define _GH_VM_MGR_H
> +
> +#include <linux/gunyah_rsc_mgr.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, unsigned long arg);
> +
> +struct gh_vm {
> +	struct gh_rm *rm;
> +	struct device *parent;
> +};
> +
> +#endif
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> new file mode 100644
> index 000000000000..86b9cb60118d
> --- /dev/null
> +++ b/include/uapi/linux/gunyah.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _UAPI_LINUX_GUNYAH_H
> +#define _UAPI_LINUX_GUNYAH_H
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
