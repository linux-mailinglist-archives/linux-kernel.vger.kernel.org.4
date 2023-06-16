Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0F73362F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345389AbjFPQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjFPQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:35:14 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF79B35BD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:34:56 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5700b15c12fso10519707b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686933296; x=1689525296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ce4KytIsLFQoTnFGNUIQpuZox9dI1TMqHMgtpHitDJE=;
        b=AM5pS2b1qZO2h5G6+bgLAfUDIdmDW+lAlPzUCskg5gf5JP0DCSpy+4BHubfHigez36
         qspf0NwgROPLjLteXP7AXMnC4nzGD7sfDDWxl5M++o4XFPekn77TB2RDIU4T5TRNtzyY
         ofu3hJxEaOnco+6U+M5xVJ7nsoZm9o2uxu/j/Y6hkh7ysZLCen5VB4umq4AlR4GVyZ4m
         O9BL3dm56qpko+hQyLcNzE5XhxLGdnofllW76yUXA5XzMttq+8ljZ8b0+VFcmAjn4YBE
         XEApNTrYPOCSnInuXMoXw1Eniupu8Ij/q624ahQrsRPfmT3M0+V6YJK426rsjSUgtklf
         YU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933296; x=1689525296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ce4KytIsLFQoTnFGNUIQpuZox9dI1TMqHMgtpHitDJE=;
        b=fNbSDGmHSV+mmfG4VTq5gI3D5I0s1epsgF8jiqAJYJ+Dwu7l4sT0Q1TWggtaBkoSiM
         AB2gp9TNN1Z4rul8vaw06erNORdwtoGcM8dO6+WWmD42lXS+JiVLN1yJ2mmGFjErcPab
         5a+i7u1vJJi/wMnl/nwqwRXAw/JhcFg6lI8NVbM5PUl+QhygAYz5F95kq6M4J3Vhh+BD
         PetTcaYQuy8cMVaUEBVaZNES+sLFTbFFGuPSZrNBObI63h6xLjK3aa88Xx+o6w9cXaDG
         ygMONHk3eoKIlMnCspcnDC0Tdl/i2mXYJ6ervLlrLCnCnlkDe5v4DZeozGBygF6Pr0Cv
         +X/g==
X-Gm-Message-State: AC+VfDztpEVpZWynvuFRXTQOU+vDGW1zBqkfDjbq6rY+wnkkNZODXs5z
        jHX3OaixpxQHmrzRgARvuVGHew==
X-Google-Smtp-Source: ACHHUZ6B6tr6zEYWodTJjcVRxJ2fYgnsCN1y/AmB8V3zSm4FIeS8ROueCR96h0kAAEH0KzkIvWCesw==
X-Received: by 2002:a81:7308:0:b0:568:8fa1:7a3 with SMTP id o8-20020a817308000000b005688fa107a3mr2203888ywc.5.1686933295961;
        Fri, 16 Jun 2023 09:34:55 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id u73-20020a0deb4c000000b0056cffe97a11sm1761072ywe.13.2023.06.16.09.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:34:55 -0700 (PDT)
Message-ID: <efedea8b-dcaf-2666-76e4-711f07f39b80@linaro.org>
Date:   Fri, 16 Jun 2023 11:34:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 23/25] virt: gunyah: Add irqfd interface
Content-Language: en-US
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
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-24-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20230613172054.3959700-24-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 12:20 PM, Elliot Berman wrote:
> Enable support for creating irqfds which can raise an interrupt on a
> Gunyah virtual machine. irqfds are exposed to userspace as a Gunyah VM
> function with the name "irqfd". If the VM devicetree is not configured
> to create a doorbell with the corresponding label, userspace will still
> be able to assert the eventfd but no interrupt will be raised on the
> guest.
> 
> Acked-by: Alex Elder <elder@linaro.org>

I guess I don't mind upgrading this.  It looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/vm-manager.rst |   2 +-
>   drivers/virt/gunyah/Kconfig              |   9 ++
>   drivers/virt/gunyah/Makefile             |   1 +
>   drivers/virt/gunyah/gunyah_irqfd.c       | 180 +++++++++++++++++++++++
>   include/uapi/linux/gunyah.h              |  35 +++++
>   5 files changed, 226 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_irqfd.c
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index b0c3bde105ae9..57a254827be26 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -116,7 +116,7 @@ the VM *before* the VM starts.
>   The argument types are documented below:
>   
>   .. kernel-doc:: include/uapi/linux/gunyah.h
> -   :identifiers: gh_fn_vcpu_arg
> +   :identifiers: gh_fn_vcpu_arg gh_fn_irqfd_arg gh_irqfd_flags
>   
>   Gunyah VCPU API Descriptions
>   ----------------------------
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index 0a58395f7d2c5..bc2c46d9df946 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -39,3 +39,12 @@ config GUNYAH_VCPU
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
> index cc16b6c19db92..ad212a1cf9671 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -7,3 +7,4 @@ gunyah-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah.o
>   
>   obj-$(CONFIG_GUNYAH_VCPU) += gunyah_vcpu.o
> +obj-$(CONFIG_GUNYAH_IRQFD) += gunyah_irqfd.o
> diff --git a/drivers/virt/gunyah/gunyah_irqfd.c b/drivers/virt/gunyah/gunyah_irqfd.c
> new file mode 100644
> index 0000000000000..3e954ebd20297
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_irqfd.c
> @@ -0,0 +1,180 @@
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
> +	int ret = 0;
> +
> +	if (flags & EPOLLIN) {
> +		if (irqfd->ghrsc) {
> +			ret = gh_hypercall_bell_send(irqfd->ghrsc->capid, 1, NULL);
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
> +static bool gh_irqfd_populate(struct gh_vm_resource_ticket *ticket, struct gh_resource *ghrsc)
> +{
> +	struct gh_irqfd *irqfd = container_of(ticket, struct gh_irqfd, ticket);
> +	int ret;
> +
> +	if (irqfd->ghrsc) {
> +		pr_warn("irqfd%d already got a Gunyah resource. Check if multiple resources with same label were configured.\n",
> +			irqfd->ticket.label);
> +		return false;
> +	}
> +
> +	irqfd->ghrsc = ghrsc;
> +	if (irqfd->level) {
> +		/* Configure the bell to trigger when bit 0 is asserted (see
> +		 * irq_wakeup) and for bell to automatically clear bit 0 once
> +		 * received by the VM (ack_mask).  need to make sure bit 0 is cleared right away,
> +		 * otherwise the line will never be deasserted. Emulating edge
> +		 * trigger interrupt does not need to set either mask
> +		 * because irq is listed only once per gh_hypercall_bell_send
> +		 */
> +		ret = gh_hypercall_bell_set_mask(irqfd->ghrsc->capid, 1, 1);
> +		if (ret)
> +			pr_warn("irq %d couldn't be set as level triggered. Might cause IRQ storm if asserted\n",
> +				irqfd->ticket.label);
> +	}
> +
> +	return true;
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
> +	if (args->flags & ~GH_IRQFD_FLAGS_LEVEL)
> +		return -EINVAL;
> +
> +	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
> +	if (!irqfd)
> +		return -ENOMEM;
> +
> +	irqfd->f = f;
> +	f->data = irqfd;
> +
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
> +	if (args->flags & GH_IRQFD_FLAGS_LEVEL)
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
> +static bool gh_irqfd_compare(const struct gh_vm_function_instance *f,
> +				const void *arg, size_t size)
> +{
> +	const struct gh_fn_irqfd_arg *instance = f->argp,
> +					 *other = arg;
> +
> +	if (sizeof(*other) != size)
> +		return false;
> +
> +	return instance->label == other->label;
> +}
> +
> +DECLARE_GH_VM_FUNCTION_INIT(irqfd, GH_FN_IRQFD, 2, gh_irqfd_bind, gh_irqfd_unbind,
> +				gh_irqfd_compare);
> +MODULE_DESCRIPTION("Gunyah irqfd VM Function");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index 434ffa8ffc783..0c480c622686a 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -77,9 +77,12 @@ struct gh_vm_dtb_config {
>    * @GH_FN_VCPU: create a vCPU instance to control a vCPU
>    *              &struct gh_fn_desc.arg is a pointer to &struct gh_fn_vcpu_arg
>    *              Return: file descriptor to manipulate the vcpu.
> + * @GH_FN_IRQFD: register eventfd to assert a Gunyah doorbell
> + *               &struct gh_fn_desc.arg is a pointer to &struct gh_fn_irqfd_arg
>    */
>   enum gh_fn_type {
>   	GH_FN_VCPU = 1,
> +	GH_FN_IRQFD,
>   };
>   
>   #define GH_FN_MAX_ARG_SIZE		256
> @@ -99,6 +102,38 @@ struct gh_fn_vcpu_arg {
>   	__u32 id;
>   };
>   
> +/**
> + * enum gh_irqfd_flags - flags for use in gh_fn_irqfd_arg
> + * @GH_IRQFD_FLAGS_LEVEL: make the interrupt operate like a level triggered
> + *                        interrupt on guest side. Triggering IRQFD before
> + *                        guest handles the interrupt causes interrupt to
> + *                        stay asserted.
> + */
> +enum gh_irqfd_flags {
> +	GH_IRQFD_FLAGS_LEVEL		= 1UL << 0,
> +};
> +
> +/**
> + * struct gh_fn_irqfd_arg - Arguments to create an irqfd function.
> + *
> + * Create this function with &GH_VM_ADD_FUNCTION using type &GH_FN_IRQFD.
> + *
> + * Allows setting an eventfd to directly trigger a guest interrupt.
> + * irqfd.fd specifies the file descriptor to use as the eventfd.
> + * irqfd.label corresponds to the doorbell label used in the guest VM's devicetree.
> + *
> + * @fd: an eventfd which when written to will raise a doorbell
> + * @label: Label of the doorbell created on the guest VM
> + * @flags: see &enum gh_irqfd_flags
> + * @padding: padding bytes
> + */
> +struct gh_fn_irqfd_arg {
> +	__u32 fd;
> +	__u32 label;
> +	__u32 flags;
> +	__u32 padding;
> +};
> +
>   /**
>    * struct gh_fn_desc - Arguments to create a VM function
>    * @type: Type of the function. See &enum gh_fn_type.

