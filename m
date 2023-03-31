Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7996D228C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjCaO13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjCaO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:27:23 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668EE20C20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:50 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id t13so16474851qvn.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272808; x=1682864808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3dxk5D/WIM5agiPzLfy0bKY3higsqR8pdGCbn1Ese0Y=;
        b=dkpB/AytYNjRNFr1OwerJ4ryTHyWpmP9AbttOewQ7t8LCFWHgvyRLqhuq57kLfscqX
         l+3/PvDQxdSpYvU/h7akpFAhwZkjZBU64s5M4EM9CHg4zlrpPQdlxjGTz0Eel19QXiNy
         L67UnJC0VVM62VL4IZfuXwRUo75oOC0hfTrTtxvq+PrXOh+v30AhpLNE+cXOrsYdiF68
         QT0HApsksNkVhwbQvm6ZbpKabOPWTYbQ7Crnx8QfQMBA7EPs9KUwWHXywpAinir3y/y2
         HNo0bwsaie0AzesyMSw0PbW5bwfRH5Ndhmnbf043iWLW/rbiELs1NqTvorkT7ehU1vhd
         djfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272808; x=1682864808;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dxk5D/WIM5agiPzLfy0bKY3higsqR8pdGCbn1Ese0Y=;
        b=wDscsfXFCMLdpa1b6rmSa+33fWrrTKNcH6u5VUAA+rBfzS24SyCRAjnMkl//ospiGn
         1iWdl1CbFuybunN8rkHfbFSbx/ZnMeToTaCVghF0+hXF2A/DFlygPuP/7/vPqWeCwBK8
         JVMF93dyEurUuGj4WhUyY2nPpCGvClsnjT1umKpI6f/Nvwty7kijB7OStR/uEdUf9z15
         BwIYSCUE9WI5QNQE3L/HiZg2iByc0qeZ+Xb/wBv71XW5lTVZxrBlNBdjtkDNLZGNgOZM
         Sh0B1jEyQokwU3GnWBlR3zHXE6rEyXHnvD9RKD15s2HXFAp2ep6zGIckFI6JVRoDMOTG
         y7aQ==
X-Gm-Message-State: AAQBX9fzJx/rZfo3lGNgsfR1mcyDC6kvIVvvWCtvKfQelPmYuDnEyKuE
        7+MxUL+fvIermPm2xxBHX0/WqA==
X-Google-Smtp-Source: AKy350bZeTRq+/m0WZz3TxBBUXHt3PO7r+bEwzC7KnQQAzahYppX4Juc5wuWDvtdZIhfSXOTU6qN2Q==
X-Received: by 2002:a05:6214:3008:b0:5ac:d6e6:452b with SMTP id ke8-20020a056214300800b005acd6e6452bmr14176547qvb.24.1680272808164;
        Fri, 31 Mar 2023 07:26:48 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id pr23-20020a056214141700b005dd8b9345c5sm624779qvb.93.2023.03.31.07.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:26:47 -0700 (PDT)
Message-ID: <6739f846-141f-d23d-536a-e00d18eb11be@linaro.org>
Date:   Fri, 31 Mar 2023 09:26:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 15/26] gunyah: rsc_mgr: Add platform ops on
 mem_lend/mem_reclaim
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-16-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-16-quic_eberman@quicinc.com>
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
> On Qualcomm platforms, there is a firmware entity which controls access
> to physical pages. In order to share memory with another VM, this entity
> needs to be informed that the guest VM should have access to the memory.

Will Gunyah ever be used on something other than a Qualcomm
platform?

Is there really any need to have these "platform hooks"
conditionally compiled?

One other comment below.

					-Alex

> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Kconfig                 |  4 ++
>   drivers/virt/gunyah/Makefile                |  1 +
>   drivers/virt/gunyah/gunyah_platform_hooks.c | 80 +++++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h               |  3 +
>   drivers/virt/gunyah/rsc_mgr_rpc.c           | 18 ++++-
>   include/linux/gunyah_rsc_mgr.h              | 17 +++++
>   6 files changed, 121 insertions(+), 2 deletions(-)
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
> index 000000000000..60da0e154e98
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
> +static struct gh_rm_platform_ops *rm_platform_ops;
> +static DECLARE_RWSEM(rm_platform_ops_lock);
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
> +int gh_rm_register_platform_ops(struct gh_rm_platform_ops *platform_ops)
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
> +void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops *platform_ops)
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
> +int devm_gh_rm_register_platform_ops(struct device *dev, struct gh_rm_platform_ops *ops)
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
> index 3665ebc7b020..6838e736f361 100644
> --- a/drivers/virt/gunyah/rsc_mgr.h
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -13,4 +13,7 @@ struct gh_rm;
>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buf_size,
>   		void **resp_buf, size_t *resp_buf_size);
>   
> +int gh_rm_platform_pre_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +int gh_rm_platform_post_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +
>   #endif
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> index 3df15ad5b97d..733be4dc8dd2 100644
> --- a/drivers/virt/gunyah/rsc_mgr_rpc.c
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -204,6 +204,12 @@ static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_
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
> @@ -227,8 +233,10 @@ static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_
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
> @@ -283,8 +291,14 @@ int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
>   	struct gh_rm_mem_release_req req = {
>   		.mem_handle = cpu_to_le32(parcel->mem_handle),
>   	};
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), NULL, NULL);
> +	/* Do not call platform mem reclaim hooks: the reclaim didn't happen*/

Move the comment above the gh_rm_call() call, and rephrase, such as:

	/* Only call platform mem reclaim hooks if... */

> +	if (ret)
> +		return ret;
>   
> -	return gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), NULL, NULL);
> +	return gh_rm_platform_post_mem_reclaim(rm, parcel);
>   }
>   
>   /**
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index 8b0b46f28e39..515087931a2b 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -145,4 +145,21 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
>   				struct gh_rm_hyp_resources **resources);
>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>   
> +struct gunyah_rm_platform_ops {
> +	int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +	int (*post_mem_reclaim)(struct gh_rm *rm, struct gh_rm_mem_parcel *mem_parcel);
> +};
> +
> +#if IS_ENABLED(CONFIG_GUNYAH_PLATFORM_HOOKS)
> +int gh_rm_register_platform_ops(struct gh_rm_platform_ops *platform_ops);
> +void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops *platform_ops);
> +int devm_gh_rm_register_platform_ops(struct device *dev, struct gh_rm_platform_ops *ops);
> +#else
> +static inline int gh_rm_register_platform_ops(struct gh_rm_platform_ops *platform_ops)
> +	{ return 0; }
> +static inline void gh_rm_unregister_platform_ops(struct gh_rm_platform_ops *platform_ops) { }
> +static inline int devm_gh_rm_register_platform_ops(struct device *dev,
> +	struct gh_rm_platform_ops *ops) { return 0; }
> +#endif
> +
>   #endif

