Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8169E2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjBUOwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjBUOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:51:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3B62B28B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:51:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p16so1239418wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61MA9d9k15JKa4jamwq/NaCewXWkItPbKXWj29+Q23U=;
        b=tPHOk8NiCCWzEeQ9W2a9xKaQ5a5S7b1bTT9FPiLZ9UP0s3svezEmWKcn+rGnzWl3T4
         1YsqfPW++P4f3i6MYtaftu5Y4ti7JWZrOvqslvO4CAQeRFdac2C4Ff9U4JOfXKOkMgle
         0BxxEedc6LuSO6O4w+0VO7sxjaUUaaisFRpNpa+2YqmYJOeBDusWLGCevTqudexBRAZC
         YHNlCNxkHiyjIjTOccFe9gL6zy6XPGCUpdPf2hfmLJDqnHicpglQL9A5+vVppNQzYBON
         7hQvVNw/LmdGaBjDxSQ2noCENNuSYqdEGwnK5kwY4AaebMnRDTdaYkGeI2Rb+z880niA
         b7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61MA9d9k15JKa4jamwq/NaCewXWkItPbKXWj29+Q23U=;
        b=U/QzphEi4sqC6+jU0l9Ktv8LXulQxGPVyFGnbCtuBrAgAxpYor7CeOtte49i5VA/jo
         4OsuEZ+rzL6d6kOz0pHVxUKYyIlb1GAJjH5lEpCypJCeLY3IdS+CNyvbYphhWNyfxKSR
         PMFqJ72izNw4RmsweZIrNGhm5l+Dh4OcdRudAEnlC8jnYltqBQxIvd0IlRwow68UeKek
         liiPTJRvT6dHvNuHIFxTkE9SMIdYS9rgUdP99vqjokxzZ4FVzKiAThc+BPzd96uk4Nbd
         +bumxyA2jUcnleoa6VegxqAvNs1yWEK47qr/qN1e4q7WYU4x3qEwN/rZ3PrpwD9p3tzp
         kJRg==
X-Gm-Message-State: AO0yUKW6T8Xk8K9jtrkx1OP48FicCqGu7j8IDPQDRbLqRiCF+GPsDjJN
        7wnxBloOOKB/TxUeR/uUOuJzHg==
X-Google-Smtp-Source: AK7set+DfDexyIU7tTTB5DKhJPQS/uru31IREvdU34ajTjOlCMLAPBS/DfZwAwMK6eAV0n4fyNYhvg==
X-Received: by 2002:a05:600c:2ad6:b0:3df:eb5d:fbf with SMTP id t22-20020a05600c2ad600b003dfeb5d0fbfmr3334058wme.38.1676991114055;
        Tue, 21 Feb 2023 06:51:54 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id k39-20020a05600c1ca700b003db012d49b7sm6526818wms.2.2023.02.21.06.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 06:51:53 -0800 (PST)
Message-ID: <963d84e8-7b91-c278-1978-4e73d73f7c6f@linaro.org>
Date:   Tue, 21 Feb 2023 14:51:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 15/26] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212448.3318756-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212448.3318756-1-quic_eberman@quicinc.com>
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



On 14/02/2023 21:24, Elliot Berman wrote:
> 
> On Qualcomm platforms, there is a firmware entity which controls access
> to physical pages. In order to share memory with another VM, this entity
> needs to be informed that the guest VM should have access to the memory.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Kconfig                 |  4 ++
>   drivers/virt/gunyah/Makefile                |  1 +
>   drivers/virt/gunyah/gunyah_platform_hooks.c | 80 +++++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h               |  3 +
>   drivers/virt/gunyah/rsc_mgr_rpc.c           | 12 +++-
>   include/linux/gunyah_rsc_mgr.h              | 17 +++++
>   6 files changed, 115 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_platform_hooks.c
> 
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index 1a737694c333..de815189dab6 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -4,6 +4,7 @@ config GUNYAH
>   	tristate "Gunyah Virtualization drivers"
>   	depends on ARM64
>   	depends on MAILBOX
> +	select GUNYAH_PLATFORM_HOOKS
>   	help
>   	  The Gunyah drivers are the helper interfaces that run in a guest VM
>   	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> @@ -11,3 +12,6 @@ config GUNYAH
>   
>   	  Say Y/M here to enable the drivers needed to interact in a Gunyah
>   	  virtual environment.
> +
> +config GUNYAH_PLATFORM_HOOKS
> +	tristate
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index ff8bc4925392..6b8f84dbfe0d 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_GUNYAH) += gunyah.o
> +obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
>   
>   gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/gunyah_platform_hooks.c b/drivers/virt/gunyah/gunyah_platform_hooks.c
> new file mode 100644
> index 000000000000..e67e2361b592
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_platform_hooks.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/rwsem.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +
> +#include "rsc_mgr.h"
> +
> +static struct gunyah_rm_platform_ops *rm_platform_ops;
> +static DECLARE_RWSEM(rm_platform_ops_lock);

Why do we need this read/write lock or this global rm_platform_ops here, 
AFAIU, there will be only one instance of platform_ops per platform.

This should be a core part of the gunyah and its driver early setup, 
that should give us pretty much lock less behaviour.

We should be able to determine by Hypervisor UUID that its on Qualcomm 
platform or not, during early gunyah setup which should help us setup 
the platfrom ops accordingly.

This should also help cleanup some of the gunyah code that was added 
futher down in this patchset.


--srini

> +
> +int gh_rm_platform_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
> +{
> +	int ret = 0;
> +
> +	down_read(&rm_platform_ops_lock);
> +	if (rm_platform_ops && rm_platform_ops->pre_mem_share)
> +		ret = rm_platform_ops->pre_mem_share(rm, mem_parcel);
> +	up_read(&rm_platform_ops_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_platform_pre_mem_share);
> +
> +int gh_rm_platform_post_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel)
> +{
> +	int ret = 0;
> +
> +	down_read(&rm_platform_ops_lock);
> +	if (rm_platform_ops && rm_platform_ops->post_mem_reclaim)
> +		ret = rm_platform_ops->post_mem_reclaim(rm, mem_parcel);
> +	up_read(&rm_platform_ops_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_platform_post_mem_reclaim);
> +
> +int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
> +{
> +	int ret = 0;
> +
> +	down_write(&rm_platform_ops_lock);
> +	if (!rm_platform_ops)
> +		rm_platform_ops = platform_ops;
> +	else
> +		ret = -EEXIST;
> +	up_write(&rm_platform_ops_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_register_platform_ops);
> +
> +void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
> +{
> +	down_write(&rm_platform_ops_lock);
> +	if (rm_platform_ops == platform_ops)
> +		rm_platform_ops = NULL;
> +	up_write(&rm_platform_ops_lock);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_unregister_platform_ops);
> +
> +static void _devm_gh_rm_unregister_platform_ops(void *data)
> +{
> +	gh_rm_unregister_platform_ops(data);
> +}
> +
> +int devm_gh_rm_register_platform_ops(struct device *dev, struct gunyah_rm_platform_ops *ops)
> +{
> +	int ret;
> +
> +	ret = gh_rm_register_platform_ops(ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action(dev, _devm_gh_rm_unregister_platform_ops, ops);
> +}
> +EXPORT_SYMBOL_GPL(devm_gh_rm_register_platform_ops);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Platform Hooks");
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> index 9b23cefe02b0..e536169df41e 100644
> --- a/drivers/virt/gunyah/rsc_mgr.h
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -74,6 +74,9 @@ struct gh_rm;
>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
>   		void **resp_buf, size_t *resp_buff_size);
>   
> +int gh_rm_platform_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +int gh_rm_platform_post_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +
>   /* Message IDs: Memory Management */
>   #define GH_RM_RPC_MEM_LEND			0x51000012
>   #define GH_RM_RPC_MEM_SHARE			0x51000013
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> index 0c83b097fec9..0b12696bf069 100644
> --- a/drivers/virt/gunyah/rsc_mgr_rpc.c
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -116,6 +116,12 @@ static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_
>   	if (!msg)
>   		return -ENOMEM;
>   
> +	ret = gh_rm_platform_pre_mem_share(rm, p);
> +	if (ret) {
> +		kfree(msg);
> +		return ret;
> +	}
> +
>   	req_header = msg;
>   	acl_section = (void *)req_header + sizeof(*req_header);
>   	mem_section = (void *)acl_section + struct_size(acl_section, entries, p->n_acl_entries);
> @@ -139,8 +145,10 @@ static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_
>   	ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, &resp_size);
>   	kfree(msg);
>   
> -	if (ret)
> +	if (ret) {
> +		gh_rm_platform_post_mem_reclaim(rm, p);
>   		return ret;
> +	}
>   
>   	p->mem_handle = le32_to_cpu(*resp);
>   
> @@ -204,7 +212,7 @@ int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
>   	if (ret)
>   		return ret;
>   
> -	return ret;
> +	return gh_rm_platform_post_mem_reclaim(rm, parcel);
>   }
>   
>   /**
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index 9cffee6f9b4e..dc05d5b1e1a3 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -147,4 +147,21 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>   				struct gh_rm_hyp_resources **resources);
>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>   
> +struct gunyah_rm_platform_ops {
> +	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +};
> +
> +#if IS_ENABLED(CONFIG_GUNYAH_PLATFORM_HOOKS)
> +int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
> +void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops);
> +int devm_gh_rm_register_platform_ops(struct device *dev, struct gunyah_rm_platform_ops *ops);
> +#else
> +static inline int gh_rm_register_platform_ops(struct gunyah_rm_platform_ops *platform_ops)
> +	{ return 0; }
> +static inline void gh_rm_unregister_platform_ops(struct gunyah_rm_platform_ops *platform_ops) { }
> +static inline int devm_gh_rm_register_platform_ops(struct device *dev,
> +	struct gunyah_rm_platform_ops *ops) { return 0; }
> +#endif
> +
>   #endif
