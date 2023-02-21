Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFEC69E63D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjBURrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbjBURrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:47:14 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB02ED78
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:47:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bo30so4790598wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mOLW7RcKOMj6wzBV4JkdTKKGO7dmgNUGUYLxw+QcAKg=;
        b=xuGVkaYUdKGqYhIHiOFe8sDq7BDuQ75ig9yBbfA+FwYWXQtUTq19CQ2xL/BlfJ2iPE
         i0HzabHfXUrsyciu64QkmIQnXfcbrqkiaIdasGqZzJsvxWrnJSOSZvTkTEykwFqH1hqd
         z++fVIhyj7/a1cXHVfUBrnptutt7zm16lGxtbmTQG3mpNZ7KPVSLNz6zYbQ/zIIUGPWW
         r5N5U0TLG9HyPxBRUTYEoThfJOD11g3PH1BlWV7rjyUfXBzADTiLnrZRypuOrHFXwlQz
         d/vkkksJk/XqGMzerIll5m+F5DEewhxz1ZaR6jT+/XCuu0/AZ3D1Z0R2f5W8R6JPho28
         CZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOLW7RcKOMj6wzBV4JkdTKKGO7dmgNUGUYLxw+QcAKg=;
        b=eyo8AC60rrRUxNKikz8RtOlQhLyOc+XvClwMVc+QeVtfumvNcrR3iG0I7VeBK7f3EN
         JZ7jpr3qTA5hVqPwrqu9as8gPMfmXZ7QwZsFQbiARCTf8BcBniG4G9QGMB6cqHQgE/Tz
         TBHhM5FBYJoB9GzftobEgdrAXNJnLrCeWCBRwEDpseOV8IvqCMsH03/6rM6qrkGEgBOh
         lZklwL/9QpCTpayHO/Akz3e08ebUYmT5qHcVuB2vBq0bo2CLrdnX4EHQ4zIKx4Apr0oN
         HDn9YKtz55scVrDyn11suqBY6utGCmAlr1LRY8t3+oXmvtximjKrZBqqOgFhftktDiUm
         bSRg==
X-Gm-Message-State: AO0yUKWrgD8hvU6+0GPL9gObkdWdzHwon4h/0fectYFz9aulDF8a8pop
        TPIYPIyy83sV6PVRc3G9SQUSKg==
X-Google-Smtp-Source: AK7set/k4QWtz5DOn4AY85c7F6LSJIWv9nqR8Svr+OWmkOD2pEDdiJwVsDYE6z3IgSNBHmR+R4qGkg==
X-Received: by 2002:a05:6000:1c04:b0:2c5:483f:1580 with SMTP id ba4-20020a0560001c0400b002c5483f1580mr3627719wrb.12.1677001629794;
        Tue, 21 Feb 2023 09:47:09 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q2-20020adff502000000b002c573a6216fsm3530970wro.37.2023.02.21.09.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:47:09 -0800 (PST)
Message-ID: <314a567a-7e85-a293-ab16-c03a049538fa@linaro.org>
Date:   Tue, 21 Feb 2023 17:47:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 18/26] virt: gunyah: Translate gh_rm_hyp_resource into
 gunyah_resource
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212521.3322247-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212521.3322247-1-quic_eberman@quicinc.com>
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



On 14/02/2023 21:25, Elliot Berman wrote:
> 
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
> ---
>   arch/arm64/include/asm/gunyah.h |  23 +++++
>   drivers/virt/gunyah/rsc_mgr.c   | 161 +++++++++++++++++++++++++++++++-
>   include/linux/gunyah.h          |   4 +
>   include/linux/gunyah_rsc_mgr.h  |   4 +
>   4 files changed, 191 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/include/asm/gunyah.h
> 
> diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
> new file mode 100644
> index 000000000000..64cfb964efee
> --- /dev/null
> +++ b/arch/arm64/include/asm/gunyah.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef __ASM_GUNYAH_H_
> +#define __ASM_GUNYAH_H_
> +
> +#include <linux/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +static inline int arch_gh_fill_irq_fwspec_params(u32 virq, struct irq_fwspec *fwspec)
> +{
> +	if (virq < 32 || virq > 1019)
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
> index 73c5a6b7cbbc..eb1bc3f68792 100644
> --- a/drivers/virt/gunyah/rsc_mgr.c
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -18,6 +18,8 @@
>   #include <linux/platform_device.h>
>   #include <linux/miscdevice.h>
>   
> +#include <asm/gunyah.h>
> +
>   #include "rsc_mgr.h"
>   #include "vm_mgr.h"
>   
> @@ -107,8 +109,137 @@ struct gh_rm {
>   	struct blocking_notifier_head nh;
>   
>   	struct miscdevice miscdev;
> +	struct irq_domain *irq_domain;
> +};
> +
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
> +	struct gh_rm *rm = d->host_data;
> +	u32 gh_virq = spec->gh_virq;
> +	int ret;
> +
> +	if (nr_irqs != 1 || gh_virq == U32_MAX)
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

leaking chip_data?

> +		return ret;
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
> +	struct gh_irq_chip_data *chip_data;
> +	struct irq_data *irq_data;
> +
> +	irq_data = irq_domain_get_irq_data(d, virq);
> +	if (!irq_data)
> +		return;
> +
> +	chip_data = irq_data->chip_data;
> +
> +	kfree(chip_data);
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
>   };
>   
> +struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm *rm,
> +						struct gh_rm_hyp_resource *hyp_resource)
> +{
> +	struct gunyah_resource *ghrsc;
> +
> +	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
> +	if (!ghrsc)
> +		return NULL;
return ERR_PTR(-ENOMEM);

> +
> +	ghrsc->type = hyp_resource->type;
> +	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
> +	ghrsc->irq = IRQ_NOTCONNECTED;
> +	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
> +	if (hyp_resource->virq && le32_to_cpu(hyp_resource->virq) != U32_MAX) {
> +		struct gh_irq_chip_data irq_data = {
> +			.gh_virq = le32_to_cpu(hyp_resource->virq),
> +		};
> +
> +		ghrsc->irq = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, &irq_data);
> +		if (ghrsc->irq < 0) {
> +			pr_err("Failed to allocate interrupt for resource %d label: %d: %d\n",
> +				ghrsc->type, ghrsc->rm_label, ghrsc->irq);
> +			ghrsc->irq = IRQ_NOTCONNECTED;
> +		}
> +	}
> +
> +	return ghrsc;
> +}
> +
> +void gh_rm_free_resource(struct gunyah_resource *ghrsc)
> +{
> +	irq_dispose_mapping(ghrsc->irq);
> +	kfree(ghrsc);
> +}
> +
>   static struct gh_rm_connection *gh_rm_alloc_connection(__le32 msg_id, u8 type)
>   {
>   	struct gh_rm_connection *connection;
> @@ -553,6 +684,8 @@ static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
>   
>   static int gh_rm_drv_probe(struct platform_device *pdev)
>   {
> +	struct irq_domain *parent_irq_domain;
> +	struct device_node *parent_irq_node;
>   	struct gh_msgq_tx_data *msg;
>   	struct gh_rm *rm;
>   	int ret;
> @@ -590,15 +723,40 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
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
> @@ -612,6 +770,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
>   	misc_deregister(&rm->miscdev);
> +	irq_domain_remove(rm->irq_domain);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 2e13669c6363..a06d5fa68a65 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -27,6 +27,10 @@ struct gunyah_resource {
>   	enum gunyah_resource_type type;
>   	u64 capid;
>   	int irq;
> +
> +	/* To help allocator of resource manager */
> +	struct list_head list;

Looks like unused?


> +	u32 rm_label;
>   };
>   
>   /**
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index dc05d5b1e1a3..2fb6efbe2f70 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -147,6 +147,10 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>   				struct gh_rm_hyp_resources **resources);
>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>   
> +struct gunyah_resource *gh_rm_alloc_resource(struct gh_rm *rm,
> +						struct gh_rm_hyp_resource *hyp_resource);
> +void gh_rm_free_resource(struct gunyah_resource *ghrsc);
> +
>   struct gunyah_rm_platform_ops {
>   	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
>   	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
