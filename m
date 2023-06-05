Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EBA723051
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbjFETua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjFETuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:50:10 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F944E43
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:49:49 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33bbc91dcb7so26803015ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994581; x=1688586581;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AoGYGv3KPg6iI3zwROaC4znPUgfJaIbc2JX64cMTxmI=;
        b=QZ8JeqTa0FllTqteHKOgBvOZLKRki6LoF3k0+sVaaYuywbpX5WLVg/UxM8xd5JHuEF
         LcfCJkLGos4nodJ1/M67TcxqLmqVTMuEoG5sLlvZUi471RNjnIG4z1gcd76KkCnx4YxM
         a6/JHBLD6NJwO/jWxDRTSmKA3hj1Rb+c5o04x5GDJiJ6LTZLEcImuPMi39Iaz+FfGKgc
         Oj6SOpIgnaJF4fNSTLYTgaAuFDqQfuJcBCn5LjkMSAlvEamCMVRM8rtz6BriMv+EEBTY
         D3WKo3yw1+lH6NFGuKnYkBYwWLkE6ITLlabobbyRrD8lid303Y3rm/qk38d413dkDCoE
         sDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994581; x=1688586581;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoGYGv3KPg6iI3zwROaC4znPUgfJaIbc2JX64cMTxmI=;
        b=dk3q6+0dErpqMKaaIMbfthLcwBNhm2MVvM88ofoXldy5hKImQoEOxwuA+HcwXKud44
         j5soHk/778Nih+usJCVIhocHhgxoQQbcW6ikz6p3qHzkFooWErqE87WdZXULWJITEydq
         vfdLDzAElfEjP18WrRM/8fDAAsmZKHA6xBX8R/wdAbpia4MpblO0MngCuvEYCEkQKITr
         7JzAtLFrVjCKLnw9pXZeOH6xZIByupciOKLTNdDSSE+13tOw8GVeXyUGywaKjCzIGWHU
         maa0vo2xkQSlLAx5LLvfBaTSex1wIfGdsW9ZbyF8Eq0RA4U0XKJKG4U+h3RuYWnnrxN6
         +g3g==
X-Gm-Message-State: AC+VfDzDsEwXq38O/d4ffTbmyniqspkW6yDCUSQvJ/he+eLvcTswh6cM
        e3parsYBG+DzGZ/tNfi1sRjQvw==
X-Google-Smtp-Source: ACHHUZ7c+5TNATvl8SE4CkkKkZqGiEqqGY0RrrjSK7oGGFf+hsEfcxyS+ovCLiDHaxJ6bNIrBng+cA==
X-Received: by 2002:a92:6e12:0:b0:335:9303:4345 with SMTP id j18-20020a926e12000000b0033593034345mr42867ilc.25.1685994581256;
        Mon, 05 Jun 2023 12:49:41 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id s7-20020a92cc07000000b003244d7f2292sm2541508ilp.32.2023.06.05.12.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:49:40 -0700 (PDT)
Message-ID: <91d52a40-98c5-3d79-79af-7a21b41acfc4@linaro.org>
Date:   Mon, 5 Jun 2023 14:49:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 16/24] virt: gunyah: Translate gh_rm_hyp_resource into
 gunyah_resource
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-17-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-17-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> When booting a Gunyah virtual machine, the host VM may gain capabilities
> to interact with resources for the guest virtual machine. Examples of
> such resources are vCPUs or message queues. To use those resources, we
> need to translate the RM response into a gunyah_resource structure which
> are useful to Linux drivers. Presently, Linux drivers need only to know
> the type of resource, the capability ID, and an interrupt.
> 
> On ARM64 systems, the interrupt reported by Gunyah is the GIC interrupt
> ID number and always a SPI.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Please zero the automatic variable in the place I suggest it.
I have two other comments/questions.  Otherwise, this looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   arch/arm64/include/asm/gunyah.h |  24 +++++
>   drivers/virt/gunyah/rsc_mgr.c   | 162 +++++++++++++++++++++++++++++++-
>   include/linux/gunyah.h          |   3 +
>   include/linux/gunyah_rsc_mgr.h  |   3 +
>   4 files changed, 191 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/include/asm/gunyah.h
> 
> diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
> new file mode 100644
> index 000000000000..c83d983b0f4e
> --- /dev/null
> +++ b/arch/arm64/include/asm/gunyah.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef _ASM_GUNYAH_H
> +#define _ASM_GUNYAH_H
> +
> +#include <linux/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +static inline int arch_gh_fill_irq_fwspec_params(u32 virq, struct irq_fwspec *fwspec)
> +{
> +	/* Assume that Gunyah gave us an SPI; defensively check it */
> +	if (WARN_ON(virq < 32 || virq > 1019))
> +		return -EINVAL;
> +
> +	fwspec->param_count = 3;
> +	fwspec->param[0] = GIC_SPI;
> +	fwspec->param[1] = virq - 32;
> +	fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> index 4f6f96bdcf3d..43ea010ea47a 100644
> --- a/drivers/virt/gunyah/rsc_mgr.c
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -17,6 +17,8 @@
>   #include <linux/platform_device.h>
>   #include <linux/miscdevice.h>
>   
> +#include <asm/gunyah.h>
> +
>   #include "rsc_mgr.h"
>   #include "vm_mgr.h"
>   
> @@ -133,6 +135,7 @@ struct gh_rm_connection {
>    * @send_lock: synchronization to allow only one request to be sent at a time
>    * @nh: notifier chain for clients interested in RM notification messages
>    * @miscdev: /dev/gunyah
> + * @irq_domain: Domain to translate Gunyah hwirqs to Linux irqs
>    */
>   struct gh_rm {
>   	struct device *dev;
> @@ -151,6 +154,7 @@ struct gh_rm {
>   	struct blocking_notifier_head nh;
>   
>   	struct miscdevice miscdev;
> +	struct irq_domain *irq_domain;
>   };
>   
>   /**
> @@ -191,6 +195,133 @@ static inline int gh_rm_remap_error(enum gh_rm_error rm_error)
>   	}
>   }
>   
> +struct gh_irq_chip_data {
> +	u32 gh_virq;
> +};
> +
> +static struct irq_chip gh_rm_irq_chip = {
> +	.name			= "Gunyah",
> +	.irq_enable		= irq_chip_enable_parent,
> +	.irq_disable		= irq_chip_disable_parent,
> +	.irq_ack		= irq_chip_ack_parent,
> +	.irq_mask		= irq_chip_mask_parent,
> +	.irq_mask_ack		= irq_chip_mask_ack_parent,
> +	.irq_unmask		= irq_chip_unmask_parent,
> +	.irq_eoi		= irq_chip_eoi_parent,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> +	.irq_set_type		= irq_chip_set_type_parent,
> +	.irq_set_wake		= irq_chip_set_wake_parent,
> +	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_get_irqchip_state	= irq_chip_get_parent_state,
> +	.irq_set_irqchip_state	= irq_chip_set_parent_state,
> +	.flags			= IRQCHIP_SET_TYPE_MASKED |
> +				  IRQCHIP_SKIP_SET_WAKE |
> +				  IRQCHIP_MASK_ON_SUSPEND,
> +};
> +
> +static int gh_rm_irq_domain_alloc(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs,
> +				 void *arg)
> +{
> +	struct gh_irq_chip_data *chip_data, *spec = arg;
> +	struct irq_fwspec parent_fwspec;

You are passing the above structure as an argument
to arch_gh_fill_irq_fwspec_params().  It might not
matter currently, but since it's not clear whether
you're assigning all fields before that call, you
should initially zero it.

	struct irq_fwspec parent_fwspec = { };

> +	struct gh_rm *rm = d->host_data;
> +	u32 gh_virq = spec->gh_virq;
> +	int ret;
> +
> +	if (nr_irqs != 1)
> +		return -EINVAL;
> +
> +	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
> +	if (!chip_data)
> +		return -ENOMEM;
> +
> +	chip_data->gh_virq = gh_virq;
> +
> +	ret = irq_domain_set_hwirq_and_chip(d, virq, chip_data->gh_virq, &gh_rm_irq_chip,
> +						chip_data);
> +	if (ret)
> +		goto err_free_irq_data;
> +
> +	parent_fwspec.fwnode = d->parent->fwnode;
> +	ret = arch_gh_fill_irq_fwspec_params(chip_data->gh_virq, &parent_fwspec);
> +	if (ret) {
> +		dev_err(rm->dev, "virq translation failed %u: %d\n", chip_data->gh_virq, ret);
> +		goto err_free_irq_data;
> +	}
> +
> +	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
> +	if (ret)
> +		goto err_free_irq_data;
> +
> +	return ret;
> +err_free_irq_data:
> +	kfree(chip_data);
> +	return ret;
> +}
> +
> +static void gh_rm_irq_domain_free_single(struct irq_domain *d, unsigned int virq)
> +{
> +	struct irq_data *irq_data;
> +
> +	irq_data = irq_domain_get_irq_data(d, virq);
> +	if (!irq_data)
> +		return;
> +
> +	kfree(irq_data->chip_data);
> +	irq_data->chip_data = NULL;
> +}
> +
> +static void gh_rm_irq_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr_irqs; i++)
> +		gh_rm_irq_domain_free_single(d, virq);
> +}
> +
> +static const struct irq_domain_ops gh_rm_irq_domain_ops = {
> +	.alloc		= gh_rm_irq_domain_alloc,
> +	.free		= gh_rm_irq_domain_free,
> +};
> +
> +struct gh_resource *gh_rm_alloc_resource(struct gh_rm *rm, struct gh_rm_hyp_resource *hyp_resource)
> +{
> +	struct gh_resource *ghrsc;
> +	int ret;
> +
> +	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
> +	if (!ghrsc)
> +		return NULL;
> +
> +	ghrsc->type = hyp_resource->type;
> +	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
> +	ghrsc->irq = IRQ_NOTCONNECTED;
> +	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
> +	if (hyp_resource->virq) {
> +		struct gh_irq_chip_data irq_data = {
> +			.gh_virq = le32_to_cpu(hyp_resource->virq),
> +		};
> +
> +		ret = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, &irq_data);
> +		if (ret < 0) {
> +			dev_err(rm->dev,
> +				"Failed to allocate interrupt for resource %d label: %d: %d\n",
> +				ghrsc->type, ghrsc->rm_label, ghrsc->irq);

Is it reasonable to return in this case without indicating to the
caller that something is wrong?

> +		} else {
> +			ghrsc->irq = ret;
> +		}
> +	}
> +
> +	return ghrsc;
> +}
> +
> +void gh_rm_free_resource(struct gh_resource *ghrsc)
> +{
> +	irq_dispose_mapping(ghrsc->irq);
> +	kfree(ghrsc);
> +}
> +
>   static int gh_rm_init_connection_payload(struct gh_rm_connection *connection, void *msg,
>   					size_t hdr_size, size_t msg_size)
>   {
> @@ -661,6 +792,8 @@ static int gh_identify(void)
>   
>   static int gh_rm_drv_probe(struct platform_device *pdev)
>   {
> +	struct irq_domain *parent_irq_domain;
> +	struct device_node *parent_irq_node;
>   	struct gh_msgq_tx_data *msg;
>   	struct gh_rm *rm;
>   	int ret;
> @@ -701,15 +834,41 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_cache;
>   
> +	parent_irq_node = of_irq_find_parent(pdev->dev.of_node);
> +	if (!parent_irq_node) {
> +		dev_err(&pdev->dev, "Failed to find interrupt parent of resource manager\n");
> +		ret = -ENODEV;
> +		goto err_msgq;
> +	}
> +
> +	parent_irq_domain = irq_find_host(parent_irq_node);
> +	if (!parent_irq_domain) {
> +		dev_err(&pdev->dev, "Failed to find interrupt parent domain of resource manager\n");
> +		ret = -ENODEV;
> +		goto err_msgq;
> +	}
> +
> +	rm->irq_domain = irq_domain_add_hierarchy(parent_irq_domain, 0, 0, pdev->dev.of_node,
> +							&gh_rm_irq_domain_ops, NULL);
> +	if (!rm->irq_domain) {
> +		dev_err(&pdev->dev, "Failed to add irq domain\n");
> +		ret = -ENODEV;
> +		goto err_msgq;
> +	}
> +	rm->irq_domain->host_data = rm;
> +
> +	rm->miscdev.parent = &pdev->dev;
>   	rm->miscdev.name = "gunyah";
>   	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
>   	rm->miscdev.fops = &gh_dev_fops;
>   
>   	ret = misc_register(&rm->miscdev);
>   	if (ret)
> -		goto err_msgq;
> +		goto err_irq_domain;
>   
>   	return 0;
> +err_irq_domain:
> +	irq_domain_remove(rm->irq_domain);
>   err_msgq:
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
> @@ -723,6 +882,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
>   	misc_deregister(&rm->miscdev);
> +	irq_domain_remove(rm->irq_domain);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 982e27d10d57..4b398b59c2c5 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -27,6 +27,9 @@ struct gh_resource {
>   	enum gh_resource_type type;
>   	u64 capid;
>   	unsigned int irq;
> +
> +	struct list_head list;

This list isn't used (yet).  It seems to be the links used
to hold the resource either on a VM's list of resources, or
on a resource ticket's list of resources.

Not a big deal, but it might be better to introduce the
field in the patch that first uses it.

> +	u32 rm_label;
>   };
>   
>   /**
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index 7c599654ea30..e74e867583f5 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -139,6 +139,9 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>   				struct gh_rm_hyp_resources **resources);
>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>   
> +struct gh_resource *gh_rm_alloc_resource(struct gh_rm *rm, struct gh_rm_hyp_resource *hyp_resource);
> +void gh_rm_free_resource(struct gh_resource *ghrsc);
> +
>   struct gh_rm_platform_ops {
>   	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
>   	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);

