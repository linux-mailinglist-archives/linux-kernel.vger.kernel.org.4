Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18296D22AA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjCaO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjCaO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:28:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D431EFFE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:28:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y85so9755154iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272864; x=1682864864;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w147z043+gbNvaWzQ5Ovrk+j86p5Vxdfc02LUTIEYJw=;
        b=WIUSrD1r/4TIV+HMXV+HTfzWNuAykp1JnlNdWHNhaDiCle69Fz+rjY6f5l2f7gI/11
         5Mh3u5KoTZAHdFZnH8EnHZYVIVYQB5t7T8+/wbHq3JH3wmiZ56YFhSmvKeZbqRdsE8f9
         0lGL7fR3UMc6hSNoqN3cbg+H6XoZWGNNu0rjcN6DvV0pUY/8UIfh80ZVwTnIA93OxXOh
         zYuy6JCi+Ra+5vpYyt5A5msYRlSlG57/l0uOU00bLHJQQCD4WQQX6UnRw2qIhKrCSsIY
         nDI6OPZtaXm17XkgVTV3zIiP594Wic0vvoWUOGOmhSyIrjGCh4dUil7koK13cgFsAlPV
         AiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272864; x=1682864864;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w147z043+gbNvaWzQ5Ovrk+j86p5Vxdfc02LUTIEYJw=;
        b=4Ep4QM41bdpbVS/mrkWgECJOCrnSUvX+BKrdDaGwAnid0X6svtXSUSlTMFMgvMN3Hb
         LFE5B11VCtFGBHcQjNAwB2Gl4AZ/hKKMqGxHvdbHpczezCRY9OjKKlwlgsFa01IY2O83
         PcMjYu6b0etwz2f/R3+GpLqcg21rlBOkmuUQ0Yox3+c4nGCDZ/rPLU6wNbPUtzPy7ILS
         RzGiA5/KL57EPvF9xFyyimdgMAtmYSUF4h5AfizOLs2nxjiYzUsqBmLObRxe7R5lA511
         rbeE182SAjVulZiUMb2YjI6BMBZhOWym4KlcA2U2ypEfKXmnj6byX/Dl6tNEjyU1QSpZ
         cAaQ==
X-Gm-Message-State: AO0yUKXexnWE+65qdRUoS7uCBdNGu6TL5FIhqW1H/YESsW/ynyoziPdQ
        SMH7kWA6VnuxqO1zoAB16msW8Q==
X-Google-Smtp-Source: AK7set+S/MkJMiB7ANnsr8/XTm6urnAy2uRL2qGCFqrUQL/ZrdKLOCAcpJWOfdOooNysm+LH25zuhw==
X-Received: by 2002:a5e:a913:0:b0:758:86ab:4b34 with SMTP id c19-20020a5ea913000000b0075886ab4b34mr18356463iod.13.1680272863682;
        Fri, 31 Mar 2023 07:27:43 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id w65-20020a025d44000000b00408c8da83ffsm668804jaa.127.2023.03.31.07.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:27:43 -0700 (PDT)
Message-ID: <a8dc6572-0a48-f772-2d8c-6329d632e0b4@linaro.org>
Date:   Fri, 31 Mar 2023 09:27:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 24/26] virt: gunyah: Add irqfd interface
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
 <20230304010632.2127470-25-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-25-quic_eberman@quicinc.com>
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

I suggest a few things below, including some code simplification.
I also have a few questions (which could possibly be answered by
adding comments).

					-Alex
> ---
>   Documentation/virt/gunyah/vm-manager.rst |   2 +-
>   drivers/virt/gunyah/Kconfig              |   9 ++
>   drivers/virt/gunyah/Makefile             |   1 +
>   drivers/virt/gunyah/gunyah_irqfd.c       | 164 +++++++++++++++++++++++
>   include/linux/gunyah.h                   |   5 +
>   include/uapi/linux/gunyah.h              |  30 +++++
>   6 files changed, 210 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index 83d326b0d11f..a1dd70f0cbf6 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -124,7 +124,7 @@ the VM starts.
>   The possible types are documented below:
>   
>   .. kernel-doc:: include/uapi/linux/gunyah.h
> -   :identifiers: GH_FN_VCPU gh_fn_vcpu_arg
> +   :identifiers: GH_FN_VCPU gh_fn_vcpu_arg GH_FN_IRQFD gh_fn_irqfd_arg
>   
>   Gunyah VCPU API Descriptions
>   ----------------------------
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
> index 000000000000..38e5fe266b00
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_irqfd.c
> @@ -0,0 +1,164 @@
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
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/printk.h>
> +
> +#include <uapi/linux/gunyah.h>
> +
> +struct gh_irqfd {
> +	struct gh_resource *ghrsc;
> +	struct gh_vm_resource_ticket ticket;
> +	struct gh_vm_function_instance *f;
> +
> +	bool level;
> +
> +	struct eventfd_ctx *ctx;
> +	wait_queue_entry_t wait;
> +	poll_table pt;
> +};
> +
> +static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
> +{
> +	struct gh_irqfd *irqfd = container_of(wait, struct gh_irqfd, wait);
> +	__poll_t flags = key_to_poll(key);
> +	u64 enable_mask = GH_BELL_NONBLOCK;
> +	u64 old_flags;
> +	int ret = 0;
> +
> +	if (flags & EPOLLIN) {
> +		if (irqfd->ghrsc) {
> +			ret = gh_hypercall_bell_send(irqfd->ghrsc->capid, enable_mask, &old_flags);

I commented elsewhere that you might support passing a null
pointer as the last argument above (since you don't use the
result).

> +			if (ret)
> +				pr_err_ratelimited("Failed to inject interrupt %d: %d\n",
> +						irqfd->ticket.label, ret);
> +		} else
> +			pr_err_ratelimited("Premature injection of interrupt\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
> +{
> +	struct gh_irqfd *irq_ctx = container_of(pt, struct gh_irqfd, pt);
> +
> +	add_wait_queue(wqh, &irq_ctx->wait);
> +}
> +
> +static int gh_irqfd_populate(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc)
> +{
> +	struct gh_irqfd *irqfd = container_of(ticket, struct gh_irqfd, ticket);
> +	u64 enable_mask = GH_BELL_NONBLOCK;
> +	u64 ack_mask = ~0;

Why is the ACK mask ~0?

I guess I don't know details about this hypercall (do you document
them somewhere?), so it's hard to judge whether or why this is the
right thing to use.  The enable_mask is just GH_BELL_NONBLOCK,
which is just BIT(32).

> +	int ret = 0;
> +
> +	if (irqfd->ghrsc) {
> +		pr_warn("irqfd%d already got a Gunyah resource. Check if multiple resources with same label were configured.\n",

s/%d/%u/

> +			irqfd->ticket.label);
> +		return -1;

I would say you should return -EBUSY here instead.

However, all callers just check for a zero/nonzero result, so
you could instead have this function (and the pointer it's
assigned to) to return Boolean instead (and return true on
success).

> +	}
> +
> +	irqfd->ghrsc = ghrsc;
> +	if (irqfd->level) {

I think I don't understand this part of the code well
enough to know this.  What happens if level is false?

> +		ret = gh_hypercall_bell_set_mask(irqfd->ghrsc->capid, enable_mask, ack_mask);
> +		if (ret)
> +			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
> +				irqfd->ticket.label);
> +	}
> +
> +	return 0;
> +}
> +
> +static void gh_irqfd_unpopulate(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc)
> +{
> +	struct gh_irqfd *irqfd = container_of(ticket, struct gh_irqfd, ticket);
> +	u64 cnt;
> +
> +	eventfd_ctx_remove_wait_queue(irqfd->ctx, &irqfd->wait, &cnt);
> +}
> +
> +static long gh_irqfd_bind(struct gh_vm_function_instance *f)
> +{
> +	struct gh_fn_irqfd_arg *args = f->argp;
> +	struct gh_irqfd *irqfd;
> +	__poll_t events;
> +	struct fd fd;
> +	long r;
> +
> +	if (f->arg_size != sizeof(*args))
> +		return -EINVAL;
> +
> +	/* All other flag bits are reserved for future use */
> +	if (args->flags & ~GH_IRQFD_LEVEL)
> +		return -EINVAL;
> +
> +	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
> +	if (!irqfd)
> +		return -ENOMEM;
> +
> +	irqfd->f = f;
> +	f->data = irqfd;
> +

In the next section you get a temporary reference to the FD,
then look up the eventfd context from its file.  But in
gh_ioeventfd_bind() you just call eventfd_ctx_fdget().

I *think* you can do the same here, but perhaps I'm missing
something.


> +	fd = fdget(args->fd);
> +	if (!fd.file) {
> +		kfree(irqfd);
> +		return -EBADF;
> +	}
> +
> +	irqfd->ctx = eventfd_ctx_fileget(fd.file);
> +	if (IS_ERR(irqfd->ctx)) {
> +		r = PTR_ERR(irqfd->ctx);
> +		goto err_fdput;
> +	}
> +

I.e., rather than the two function calls above, you could just
call:

	irqfd->ctx = eventfd_ctx_fdget(args->fd);

And in that case you also wouldn't need the fdput() call in the
error path below.

> +	if (args->flags & GH_IRQFD_LEVEL)
> +		irqfd->level = true;
> +
> +	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
> +	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
> +
> +	irqfd->ticket.resource_type = GH_RESOURCE_TYPE_BELL_TX;
> +	irqfd->ticket.label = args->label;
> +	irqfd->ticket.owner = THIS_MODULE;
> +	irqfd->ticket.populate = gh_irqfd_populate;
> +	irqfd->ticket.unpopulate = gh_irqfd_unpopulate;
> +
> +	r = gh_vm_add_resource_ticket(f->ghvm, &irqfd->ticket);
> +	if (r)
> +		goto err_ctx;
> +
> +	events = vfs_poll(fd.file, &irqfd->pt);
> +	if (events & EPOLLIN)
> +		pr_warn("Premature injection of interrupt\n");
> +	fdput(fd);
> +
> +	return 0;
> +err_ctx:
> +	eventfd_ctx_put(irqfd->ctx);
> +err_fdput:
> +	fdput(fd);
> +	kfree(irqfd);
> +	return r;
> +}
> +
> +static void gh_irqfd_unbind(struct gh_vm_function_instance *f)
> +{
> +	struct gh_irqfd *irqfd = f->data;
> +
> +	gh_vm_remove_resource_ticket(irqfd->f->ghvm, &irqfd->ticket);
> +	eventfd_ctx_put(irqfd->ctx);
> +	kfree(irqfd);
> +}
> +
> +DECLARE_GH_VM_FUNCTION_INIT(irqfd, GH_FN_IRQFD, gh_irqfd_bind, gh_irqfd_unbind);
> +MODULE_DESCRIPTION("Gunyah irqfds");

Maybe singular, and maybe "Gunyah irqfd VM function(s)".

> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 63395dacc1a8..0344b6988cfa 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -33,6 +33,11 @@ struct gh_resource {
>   	u32 rm_label;
>   };
>   
> +/**
> + * Gunyah Doorbells
> + */
> +#define GH_BELL_NONBLOCK		BIT(32)
> +
>   /**
>    * Gunyah Message Queues
>    */
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index e52265fa5715..5617dadc1c7b 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -76,6 +76,19 @@ struct gh_vm_dtb_config {
>    */
>   #define GH_FN_VCPU 		1
>   
> +/**
> + * GH_FN_IRQFD - register eventfd to assert a Gunyah doorbell
> + *
> + * gh_fn_desc is filled with gh_fn_irqfd_arg
> + *
> + * Allows setting an eventfd to directly trigger a guest interrupt.
> + * irqfd.fd specifies the file descriptor to use as the eventfd.
> + * irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
> + *
> + * Return: 0
> + */
> +#define GH_FN_IRQFD 		2
> +
>   #define GH_FN_MAX_ARG_SIZE		256
>   
>   /**
> @@ -88,6 +101,23 @@ struct gh_fn_vcpu_arg {
>   
>   #define GH_IRQFD_LEVEL			(1UL << 0)

This is associated with the IRQFD "flags" field, so I'd name it
GH_IRQFD_FLAGS_LEVEL.

>   
> +/**
> + * struct gh_fn_irqfd_arg - Arguments to create an irqfd function
> + * @fd: an eventfd which when written to will raise a doorbell
> + * @label: Label of the doorbell created on the guest VM
> + * @flags: GH_IRQFD_LEVEL configures the corresponding doorbell to behave
> + *         like a level triggered interrupt.
> + * @padding: padding bytes
> + */
> +struct gh_fn_irqfd_arg {
> +	__u32 fd;

Should the "fd" field be signed?  Should it be an int?  (Perhaps
you're trying to define a fixed kernel API, so __s32 if signed would
be better.)

> +	__u32 label;
> +	__u32 flags;
> +	__u32 padding;
> +};
> +
> +#define GH_IOEVENTFD_DATAMATCH		(1UL << 0)
> +
>   /**
>    * struct gh_fn_desc - Arguments to create a VM function
>    * @type: Type of the function. See GH_FN_* macro for supported types

