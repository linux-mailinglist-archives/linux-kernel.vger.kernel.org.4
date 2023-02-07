Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D45968DBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjBGOf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjBGOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:34:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984A3EFE2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:30:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so10127723wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOpPEC2Awvgh2+il+1cdOelaxS0kr6969CW5gfZdK9s=;
        b=mvmIayQ6kbXX2V1Crl0tHuqqPSYFLB/Jc8zYwglHDcxyt934fkl+bWG6tLuCpQ1g5M
         Jb9KOLyEms2XLQ3wir9yiiaWxp2b+zzlB/xYywUOiCIuPwI6UKMcX3PMOvoSNkWe8fkN
         Nw8Ws+PMzukriLOCXNBIBORq3847BjCpUi1rIvGpmgEUWjDNwdRHURkSNd1oA39bkNTP
         QaLerpe41EPHHKUA1OnajCdSskROLxC2RJ9KgPNEV15H9cLQdIO+8S7kqxWcA1KA7BRx
         r6PN8jB5gMHWV7Ltvt/T0Tm+PHOqMBpmj3WxvPkvSnBGvvC/3B63h/jtFoGsKnOVsqij
         tYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOpPEC2Awvgh2+il+1cdOelaxS0kr6969CW5gfZdK9s=;
        b=vFNYhp2Sxwadf/CAQtLhlm5xpm9SW96oPTvbuM+RCZtDRhzPz5Mc8+bSoioH2Mwdm5
         yQHA/tXqfG0fagpNdRS5j4EEuGhXjQoHRTNRCX95mkFI3mOphty3LImYUK7Fzklwe6os
         Ch3JTeaiF55wEPFzzrPbePreLOWP7tf2FqIebpkfwqVtvNz5cpuZ0Y/cvIFazfbSxOdu
         RWgPgBEi9fzbY8mY/HgC3Fo6ILV1QbZB9N5HC2Dm3FXs4zOXc0+G6/OXMXfJMX6ijlxR
         GVhj1j4fGgFatoFeOkSSn09PZUvb9TFoz67u8wdNzbxHrDCqJMwNaUO9kmlDAqOePjC4
         te3A==
X-Gm-Message-State: AO0yUKWttPBCV5yTY7owgyGx4Y5S6Gdaq4Z0Jg7/om1RD0p/hWaZbVu5
        i0DB95juXkjEpwocOWRgDWVb3w==
X-Google-Smtp-Source: AK7set8jcs1Fi07SodeYKm3KsVNy19Z8Ks0GBdzOiILFELxjwbjn+1rpRCWpD+Y0NUJHjqjrlI6mSA==
X-Received: by 2002:a05:600c:920:b0:3df:d817:df98 with SMTP id m32-20020a05600c092000b003dfd817df98mr3295961wmp.10.1675780248891;
        Tue, 07 Feb 2023 06:30:48 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j14-20020a05600c190e00b003daf681d05dsm15344363wmq.26.2023.02.07.06.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 06:30:47 -0800 (PST)
Message-ID: <724a79fe-304d-f8db-c66c-9fdbfac873c8@linaro.org>
Date:   Tue, 7 Feb 2023 14:30:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 26/27] virt: gunyah: Add irqfd interface
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
 <20230120224627.4053418-27-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-27-quic_eberman@quicinc.com>
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
> Enable support for creating irqfds which can raise an interrupt on a
> Gunyah virtual machine. irqfds are exposed to userspace as a Gunyah VM
> function with the name "irqfd". If the VM devicetree is not configured
> to create a doorbell with the corresponding label, userspace will still
> be able to assert the eventfd but no interrupt will be raised on the
> guest.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/vm-manager.rst |  22 +++
>   drivers/virt/gunyah/Kconfig              |   9 ++
>   drivers/virt/gunyah/Makefile             |   1 +
>   drivers/virt/gunyah/gunyah_irqfd.c       | 166 +++++++++++++++++++++++
>   include/linux/gunyah.h                   |   5 +
>   include/uapi/linux/gunyah.h              |  11 +-
>   6 files changed, 213 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index d11267d59802..b6cf8db826b8 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -142,3 +142,25 @@ The vcpu type will register with the VM Manager to expect to control
>   vCPU number `vcpu_id`. It returns a file descriptor allowing interaction with
>   the vCPU. See the Gunyah vCPU API description sections for interacting with
>   the Gunyah vCPU file descriptors.
> +
> +Type: "irqfd"
> +^^^^^^^^^^^^^
> +
> +::
> +
> +  struct gh_fn_irqfd_arg {
> +	__u32 fd;
> +	__u32 label;
> +  #define GH_IRQFD_LEVEL			(1UL << 0)
> +  #define GH_IRQFD_DEASSIGN		(1UL << 1)
> +	__u32 flags;
> +  };
> +
> +Allows setting an eventfd to directly trigger a guest interrupt.
> +irqfd.fd specifies the file descriptor to use as the eventfd.
> +irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
> +The irqfd is removed using the GH_IRQFD_DEASSIGN flag and specifying at least
> +the irqfd.label.
> +
> +GH_IRQFD_LEVEL configures the corresponding doorbell to behave like a level
> +triggered interrupt.
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index 4c1c6110b50e..2cde24d429d1 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -26,3 +26,12 @@ config GUNYAH_VCPU
>   	  VMMs can also handle stage 2 faults of the vCPUs.
>   
>   	  Say Y/M here if unsure and you want to support Gunyah VMMs.
> +
> +config GUNYAH_IRQFD
> +	tristate "Gunyah irqfd interface"
> +	depends on GUNYAH
> +	help
> +	  Enable kernel support for creating irqfds which can raise an interrupt
> +	  on Gunyah virtual machine.
> +
> +	  Say Y/M here if unsure and you want to support Gunyah VMMs.
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 2d1b604a7b03..6cf756bfa3c2 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -7,3 +7,4 @@ gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
>   
>   obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
> +obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
> diff --git a/drivers/virt/gunyah/gunyah_irqfd.c b/drivers/virt/gunyah/gunyah_irqfd.c
> new file mode 100644
> index 000000000000..a3be9ca2377a
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_irqfd.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/eventfd.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/gunyah.h>
> +#include <linux/gunyah_vm_mgr.h>
> +#include <linux/kref.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/printk.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +struct gunyah_irqfd {
> +	struct gunyah_resource *ghrsc;
> +	struct gunyah_vm_resource_ticket ticket;
> +	struct gunyah_vm_function *f;
> +
> +	struct kref kref;
> +	bool level;
> +
> +	struct eventfd_ctx *ctx;
> +	wait_queue_entry_t wait;
> +	poll_table pt;
> +	struct fd fd;
> +};
> +
> +static void gh_irqfd_cleanup(struct kref *kref)
> +{
> +	struct gunyah_irqfd *irqfd = container_of(kref, struct gunyah_irqfd, kref);
> +
> +	kfree(irqfd);
> +}
> +
> +static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
> +{
> +	struct gunyah_irqfd *irqfd = container_of(wait, struct gunyah_irqfd, wait);
> +	__poll_t flags = key_to_poll(key);
> +	u64 enable_mask = GH_DBL_NONBLOCK;
> +	u64 old_flags;
> +	int ret = 0;
> +
> +	if (flags & EPOLLIN) {
> +		if (irqfd->ghrsc) {
> +			ret = gh_hypercall_dbl_send(irqfd->ghrsc->capid, enable_mask, &old_flags);
> +			if (ret)
> +				pr_err("Failed to assert irq %d\n", irqfd->f->fn.irqfd.label);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
> +{
> +	struct gunyah_irqfd *irq_ctx = container_of(pt, struct gunyah_irqfd, pt);
> +
> +	add_wait_queue(wqh, &irq_ctx->wait);
> +}
> +
> +static int gunyah_irqfd_populate(struct gunyah_vm_resource_ticket *ticket,
> +				struct gunyah_resource *ghrsc)
> +{
> +	struct gunyah_irqfd *irqfd = container_of(ticket, struct gunyah_irqfd, ticket);
> +	u64 enable_mask = GH_DBL_NONBLOCK;
> +	u64 ack_mask = ~0;
> +	int ret = 0;
> +
> +	irqfd->ghrsc = ghrsc;
> +	if (irqfd->level) {
> +		ret = gh_hypercall_dbl_set_mask(irqfd->ghrsc->capid, enable_mask, ack_mask);
> +		if (ret)
> +			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
> +				irqfd->f->fn.irqfd.label);
> +	}
> +	kref_get(&irqfd->kref);
> +
> +	return 0;
> +}
> +
> +static void gunyah_irqfd_unpopulate(struct gunyah_vm_resource_ticket *ticket,
> +					struct gunyah_resource *ghrsc)
> +{
> +	struct gunyah_irqfd *irqfd = container_of(ticket, struct gunyah_irqfd, ticket);
> +	u64 cnt;
> +
> +	eventfd_ctx_remove_wait_queue(irqfd->ctx, &irqfd->wait, &cnt);
> +	eventfd_ctx_put(irqfd->ctx);

> +	fdput(irqfd->fd);
<--
> +	irqfd->ctx = NULL;
> +	irqfd->fd.file = NULL;
> +	irqfd->ghrsc = NULL;
-->

How do we know that this is the last reference ?

> +	kref_put(&irqfd->kref, gh_irqfd_cleanup);
> +}
> +
> +static long gunyah_irqfd_bind(struct gunyah_vm_function *f)
> +{
> +	__poll_t events;
> +	struct gunyah_irqfd *irqfd;
> +	long r;
> +
> +	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
> +	if (!irqfd)
> +		return -ENOMEM;
> +
> +	irqfd->f = f;
> +	f->data = irqfd;
> +
> +	irqfd->fd = fdget(f->fn.irqfd.fd);
> +	if (!irqfd->fd.file) {
> +		r = -EBADF;
> +		goto err_free;
> +	}
> +
> +	irqfd->ctx = eventfd_ctx_fileget(irqfd->fd.file);
> +	if (IS_ERR(irqfd->ctx)) {
> +		r = PTR_ERR(irqfd->ctx);
> +		goto err_fdput;
> +	}
> +
> +	if (f->fn.irqfd.flags & GH_IRQFD_LEVEL)
> +		irqfd->level = true;
> +
> +	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
> +	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
> +	kref_init(&irqfd->kref);
> +
> +	irqfd->ticket.resource_type = GUNYAH_RESOURCE_TYPE_BELL_TX;
> +	irqfd->ticket.label = f->fn.irqfd.label;
> +	irqfd->ticket.owner = THIS_MODULE;
> +	irqfd->ticket.populate = gunyah_irqfd_populate;
> +	irqfd->ticket.unpopulate = gunyah_irqfd_unpopulate;
> +
> +	r = ghvm_add_resource_ticket(f->ghvm, &irqfd->ticket);
> +	if (r)
> +		goto err_ctx;
> +
> +	events = vfs_poll(irqfd->fd.file, &irqfd->pt);
> +	if (events & EPOLLIN)
> +		pr_warn("Premature injection of interrupt\n");
> +
> +	return 0;
> +err_ctx:
kref_put missing?

> +	eventfd_ctx_put(irqfd->ctx);
> +err_fdput:
> +	fdput(irqfd->fd);
> +err_free:
> +	kfree(irqfd);
> +	return r;
> +}
> +
> +static void gunyah_irqfd_release(struct gunyah_vm_function *f)
> +{
> +	struct gunyah_irqfd *irqfd = f->data;
> +
> +	/* unpopulate will trigger clean up of the eventfd */
> +	ghvm_remove_resource_ticket(irqfd->f->ghvm, &irqfd->ticket);
> +}
> +
> +DECLARE_GUNYAH_VM_FUNCTION_INIT(irqfd, gunyah_irqfd_bind, gunyah_irqfd_release);
> +MODULE_DESCRIPTION("Gunyah irqfds");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index ac4879940c10..6b363707a901 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -33,6 +33,11 @@ struct gunyah_resource {
>   	u32 rm_label;
>   };
>   
> +/**
> + * Gunyah Doorbells
> + */
> +#define GH_DBL_NONBLOCK		BIT(32)
> +
>   /**
>    * Gunyah Message Queues
>    */
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index b4afb11f538a..a947f0317ca9 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -57,10 +57,19 @@ struct gh_fn_vcpu_arg {
>   	__u32 vcpu_id;
>   };
>   
> +struct gh_fn_irqfd_arg {
> +	__u32 fd;
> +	__u32 label;
> +#define GH_IRQFD_LEVEL			(1UL << 0)
> +#define GH_IRQFD_DEASSIGN		(1UL << 1)
> +	__u32 flags;

same issue here, this is not naturaly aligned.

for details take a look at Documentation/driver-api/ioctl.rst

> +};
> +
>   struct gh_vm_function {
>   	char name[GUNYAH_FUNCTION_NAME_SIZE];
>   	union {
> -		struct gh_device_vcpu_arg vcpu;
> +		struct gh_fn_vcpu_arg vcpu;
> +		struct gh_fn_irqfd_arg irqfd;
>   		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
>   	};
>   };
