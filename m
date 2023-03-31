Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311356D2292
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjCaO1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjCaO13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:27:29 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30E91E72F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t19so21791410qta.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272813; x=1682864813;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AepkT1wk642AMoxt36LM3nPaMig9zHziqmtS4m+5IYA=;
        b=BEmnYwFiBL+keaattFmRJwszVXtARgYTJKWN2Tr9W7Kk60AIPebJcD1dN35FfctXzP
         1fodMwuKPjamJyohGK5wYv6BC9Bp31Yxp/Rsg/gcWK8VLhzveBtz2k2AxwfwwZ4puLLA
         lNCSbHxn+6WyiAbl0nW/QfCWqVsKXUzvMjK59Y4+7xlJ4CMLKdaQ+xiXMaXg39WPskt7
         oRK9WnkoI3fN2gRFVlTOjhkMs7yXK+9Atyo9hpfquwFTU0owYARtSoG2FpP0rlcANMwj
         nqMtljq85C9kSvXNFUrazcuKGoHEHmM41LzaGM3D6OGgocrkMTrggrrqiDBldduxnlXW
         S6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272813; x=1682864813;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AepkT1wk642AMoxt36LM3nPaMig9zHziqmtS4m+5IYA=;
        b=b+Br1K4HUy5OptQC7VjKtCTYMYbeyVq6i8ErgwfXTeAMX4OM+LoDMizeKhh1zn4AXi
         Ls+WkktfUZxZclog33CzTEejPUX+Z2AvSKkGiWeEUPVR7Yqz5YS0PkOPJcLub8f5wDVp
         s++CJcqKZzgyy8Tc6pG4xMYThSJ9x4Lj/HAkqMo5B8UliXYi30Thiqm0/W6eB8kkGyYg
         X0MAWXArzhRk08AcKXi+A0pMDmmM9L2XGUetOKN2wsrjYV91ylfRrMEx6ugsWo4b7gjl
         k+1k8B7LRATUaqk5tpzzF17fPVTeREc8Fgxo33MDDOgXXbfhhECXdjUnWT1zEcxiaOp3
         CJ8A==
X-Gm-Message-State: AAQBX9dUrFtssBr82kj65vO7F9bwccQ/CXC1v6CdXhJyWEyid/vDrSMX
        GMaJGSXOqBihb03xneer3Nj1nQ==
X-Google-Smtp-Source: AKy350bmYOUhDlf3tKWJbe0bhmYDip0LvEhCpmdPWj6YbJZshPUnQJmBV5NfA52/NzlInFOdKNMRYQ==
X-Received: by 2002:ac8:7fd4:0:b0:3e4:e61d:5eeb with SMTP id b20-20020ac87fd4000000b003e4e61d5eebmr30560515qtk.6.1680272813012;
        Fri, 31 Mar 2023 07:26:53 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id m62-20020a375841000000b0071eddd3bebbsm694153qkb.81.2023.03.31.07.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:26:52 -0700 (PDT)
Message-ID: <f2994324-cf04-c695-bbbe-df4cf2faa0c1@linaro.org>
Date:   Fri, 31 Mar 2023 09:26:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 18/26] virt: gunyah: Translate gh_rm_hyp_resource into
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
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-19-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-19-quic_eberman@quicinc.com>
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

Several comments here, nothing major.	-Alex

> ---
>   arch/arm64/include/asm/gunyah.h |  23 +++++
>   drivers/virt/gunyah/rsc_mgr.c   | 163 +++++++++++++++++++++++++++++++-
>   include/linux/gunyah.h          |   4 +
>   include/linux/gunyah_rsc_mgr.h  |   3 +
>   4 files changed, 192 insertions(+), 1 deletion(-)
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

Maybe just one _ at the beginning and none at the end?
Follow the same convention across all your header files.
(Maybe you're looking at other files in the same directory
as this one, but that's not consistent.)

> +
> +#include <linux/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +static inline int arch_gh_fill_irq_fwspec_params(u32 virq, struct irq_fwspec *fwspec)
> +{
> +	if (virq < 32 || virq > 1019)
> +		return -EINVAL;

What is special about VIRQs greater than 1019 (minus 32)?

It's probably documented somewhere but it's worth adding a
comment here to explain the check.

You would know better than I, but could/should the caller
be responsible for this check?  (Not a big deal.)

> +
> +	fwspec->param_count = 3;
> +	fwspec->param[0] = GIC_SPI;
> +	fwspec->param[1] = virq - 32;

And why is 32 subtracted?

> +	fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> index d7ce692d0067..383be5ac0f44 100644
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
> @@ -132,6 +134,7 @@ struct gh_rm_connection {
>    * @send_lock: synchronization to allow only one request to be sent at a time
>    * @nh: notifier chain for clients interested in RM notification messages
>    * @miscdev: /dev/gunyah
> + * @irq_domain: Domain to translate Gunyah hwirqs to Linux irqs
>    */
>   struct gh_rm {
>   	struct device *dev;
> @@ -150,6 +153,7 @@ struct gh_rm {
>   	struct blocking_notifier_head nh;
>   
>   	struct miscdevice miscdev;
> +	struct irq_domain *irq_domain;
>   };
>   
>   /**
> @@ -190,6 +194,134 @@ static inline int gh_rm_remap_error(enum gh_rm_error rm_error)
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
> +	struct gh_rm *rm = d->host_data;
> +	u32 gh_virq = spec->gh_virq;
> +	int ret;
> +
> +	if (nr_irqs != 1 || gh_virq == U32_MAX)

Does U32_MAX have special meaning?  Why are you checking for it?
Whatever it is, you should explain why this is invalid here.

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
> +	struct gh_irq_chip_data *chip_data;

No need to define chip_data.

> +	struct irq_data *irq_data;
> +
> +	irq_data = irq_domain_get_irq_data(d, virq);
> +	if (!irq_data)
> +		return;
> +
> +	chip_data = irq_data->chip_data;
> +
> +	kfree(chip_data);

Just call kfree(irq_data->chip_data);

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
> +
> +	ghrsc = kzalloc(sizeof(*ghrsc), GFP_KERNEL);
> +	if (!ghrsc)
> +		return NULL;
> +
> +	ghrsc->type = hyp_resource->type;
> +	ghrsc->capid = le64_to_cpu(hyp_resource->cap_id);
> +	ghrsc->irq = IRQ_NOTCONNECTED;
> +	ghrsc->rm_label = le32_to_cpu(hyp_resource->resource_label);
> +	if (hyp_resource->virq && le32_to_cpu(hyp_resource->virq) != U32_MAX) {

Again, does U32_MAX have a particular meaning here?

> +		struct gh_irq_chip_data irq_data = {
> +			.gh_virq = le32_to_cpu(hyp_resource->virq),
> +		};
> +
> +		ghrsc->irq = irq_domain_alloc_irqs(rm->irq_domain, 1, NUMA_NO_NODE, &irq_data);
> +		if (ghrsc->irq < 0) {
> +			dev_err(rm->dev,
> +				"Failed to allocate interrupt for resource %d label: %d: %d\n",
> +				ghrsc->type, ghrsc->rm_label, ghrsc->irq);
> +			ghrsc->irq = IRQ_NOTCONNECTED;

ghrsc->irq already had that value.  You could use a local
variable irq to hold the value, and then assign ghrsc->irq
after you know it's good.

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
> @@ -639,6 +771,8 @@ static int gh_msgq_platform_probe_direction(struct platform_device *pdev, bool t
>   
>   static int gh_rm_drv_probe(struct platform_device *pdev)
>   {
> +	struct irq_domain *parent_irq_domain;
> +	struct device_node *parent_irq_node;
>   	struct gh_msgq_tx_data *msg;
>   	struct gh_rm *rm;
>   	int ret;
> @@ -675,15 +809,41 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
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
> @@ -697,6 +857,7 @@ static int gh_rm_drv_remove(struct platform_device *pdev)
>   	struct gh_rm *rm = platform_get_drvdata(pdev);
>   
>   	misc_deregister(&rm->miscdev);
> +	irq_domain_remove(rm->irq_domain);
>   	mbox_free_channel(gh_msgq_chan(&rm->msgq));
>   	gh_msgq_remove(&rm->msgq);
>   	kmem_cache_destroy(rm->cache);
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 378bec0f2ce1..3e706b59d2c0 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -27,6 +27,10 @@ struct gh_resource {
>   	enum gh_resource_type type;
>   	u64 capid;
>   	unsigned int irq;
> +
> +	/* To help allocator in vm manager */

I don't find the above comment helpful.

> +	struct list_head list;
> +	u32 rm_label;
>   };
>   
>   /**
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index acf8c1545a6c..58693c27cf1a 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -145,6 +145,9 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>   				struct gh_rm_hyp_resources **resources);
>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>   
> +struct gh_resource *gh_rm_alloc_resource(struct gh_rm *rm, struct gh_rm_hyp_resource *hyp_resource);
> +void gh_rm_free_resource(struct gh_resource *ghrsc);
> +
>   struct gh_rm_platform_ops {
>   	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
>   	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);

