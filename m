Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9BA6C3417
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCUOYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjCUOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:24:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6901A95E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o12so60364232edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679408632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5Pm0MMnSmbEDdIbPohmhFMPMqFxou4bY0YB1uIPQY0=;
        b=CiFesSqyc13A+IFfOv3ojCvEOcPvBzioHBpEmQUbJolYCb39/LHhu1nTGXmAJ8hHlI
         3f5Ms/mO/LBTDcThExjMYF8H7g68sIF6XgnJV4EOb3hdtiiKSnZmAPS/fPAaIOJdPyg2
         t/JXEr/2AXjMG+pWoQfVQYMBtGRgLuph3qvsjxRYcHnpaRIf+xubvcAw6naCbLYbNcSg
         Sg4BiUkA9CBp4sIPKnzRFJ68+mh9IggECCepHrFjx8sAPUNFn5V22ZWqrMkaCxOpsuOt
         fcQcqM+J3HANR3J2Db65YSPhxWPzf9hJ4U+z7iTSK+9e0ESzpn8H3FvfVfl2NwKxNfR7
         EJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5Pm0MMnSmbEDdIbPohmhFMPMqFxou4bY0YB1uIPQY0=;
        b=ND5uQfO8/3nocT+IwB0OSURPnFCaNRertiViLLlvLf3zyC9hNDMEK+KtyaABPyhWH4
         nneZO/CcqZ16UBb9+Zn1BfRB3Z3Un/XekxeC6Px1VmoCOyuOG2ce6loQ3q9Bwyq8dSPF
         JTvny39JYpE0zdsiIJZMCiGq+Cx8CCTiNmGPrDEth78TEbSrygqeM/9VmnfjQfzvuScP
         amVVQgkENNkB+g5Nxju5soTm+5b+FVk1IJNMx95ftA0JDvxZbq99Y5IcT00Uf6m93/Ku
         +2c8LXH2xZ/pM9JEAOWaFTOR+Cqxx7oHRM3N8Rq8Guh8oiIfIXQqIwTk6KfiVM1cOY54
         4epg==
X-Gm-Message-State: AO0yUKVKeLltdi4KNF3IJB8v67Px20uWnFtipZ0dhKRml4aHen5NHtEg
        iGOeE0ofFDrUkX0xlm3nlPqNqw==
X-Google-Smtp-Source: AK7set/9ZXj1Czg1/cVBqeEkMOtdy8gYkoiYB258Ji3dmMs0uLNd1k0etia3Rbw6N4w6XiQ+H/BcZQ==
X-Received: by 2002:a17:906:c341:b0:934:d467:5492 with SMTP id ci1-20020a170906c34100b00934d4675492mr3133481ejb.54.1679408632143;
        Tue, 21 Mar 2023 07:23:52 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id l16-20020a1709061c5000b00939ad35d521sm1099737ejg.77.2023.03.21.07.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:23:51 -0700 (PDT)
Message-ID: <5e9b3ec6-5d47-cd73-c7c0-0aa891bdfc23@linaro.org>
Date:   Tue, 21 Mar 2023 14:23:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v11 15/26] gunyah: rsc_mgr: Add platform ops on
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-16-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230304010632.2127470-16-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/03/2023 01:06, Elliot Berman wrote:
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

I think I have asked this question but I can not find the answer to this 
from old replies.
Why is this platform hooks not part of core gunyah? Do we need a 
dedicated module for this.
By the looks of APIs I see this is very much close to rm and i think 
this functionality should live with rm.

--srini
+{
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
