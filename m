Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C868669DB76
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjBUHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjBUHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:50:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D601CF61
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:50:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l25so2968232wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hjfg64gDGO7h14TEC4RS/AXyVKIdDfjATSF2lUKEAMk=;
        b=MnJqfF8saYIdGPGzzEZegsn2Vhtv4zmyjBE0K3UA2uzL9Pd5fyWiDkZf0nqrhUxBAA
         T+AISA+Sl3+s7/EcuvPHrI42jRxu7ag3EwRMMbfPDyx54fepvx8ILyc/79eyW2PMf0p7
         PRIcqJv0DXCGnHaN0lLKfqu8+Ex1X34vNF4vH+Y89l39JDcHFQ8Ojvh9z+XkEYhxIQv9
         4xhWxDJtpQ624+jpMntoSPNgOIWiiXBZ48UpYETNNCL7wawrCBjF7UIhudtt7ZwHLtJS
         /1SwzmbJfWZJE0/SXaiL8YRltkcYPQRH54FMtoawjJj7eQJ1mmMmt/bRVUORDjiZ/SjS
         7dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hjfg64gDGO7h14TEC4RS/AXyVKIdDfjATSF2lUKEAMk=;
        b=Yp9+1deayds1kZxcaXcnbHY73vqI/O+nj3aTup+hFVAnw/K0aWAKGxSOHprpTgsS6w
         shC1BO/bE+PxCciXPhfcJ4DcgigO95wgN0IhpS4RZfSzFwXB+QnUb1v5ZZDauKuqCg25
         GonSGKtujnyyn4SkBgcRlQD5mwQVa/nsIPnSGwC3N1c7Yb1ee2jKx5bpdk+VijZYdFYk
         0ebjZ/pqOzzSE9PdMnYZNNEDTnR3XbVX/rTwhU6tMX1L8u4WiRt55YcBxBPY1kjTXNjp
         7T5kgHMYgFPJ97gWE238Ocp+2dTPvTHcSmA1nD+DfOsfftwxqJbHc+vYbe6xMzZbTIiF
         VQiA==
X-Gm-Message-State: AO0yUKX3lbE8yriRpaeWDBJuKxfQWg754Iv2vD/BSeXWDxDiTRUsnsLW
        n0KiqQoJ7f9+gvS5r1gtOmpIGw==
X-Google-Smtp-Source: AK7set97tfEfb+9jEmaIbBvjUjYHM1C/RcXs0xI1hR9WFaCJoLbuEO79GObcuG1M2I6FlEJKYM/nSA==
X-Received: by 2002:adf:e242:0:b0:2c5:8c04:c6a8 with SMTP id bl2-20020adfe242000000b002c58c04c6a8mr3548223wrb.51.1676965848828;
        Mon, 20 Feb 2023 23:50:48 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j16-20020a056000125000b002c5706f7c6dsm711101wrx.94.2023.02.20.23.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 23:50:48 -0800 (PST)
Message-ID: <78f841f1-1e1a-9eb9-940d-6e11dd18d86f@linaro.org>
Date:   Tue, 21 Feb 2023 07:50:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
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
 <20230214212343.3311875-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212343.3311875-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/2023 21:23, Elliot Berman wrote:
> 
> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Makefile      |   2 +-
>   drivers/virt/gunyah/rsc_mgr.h     |  45 ++++++
>   drivers/virt/gunyah/rsc_mgr_rpc.c | 226 ++++++++++++++++++++++++++++++
>   include/linux/gunyah_rsc_mgr.h    |  73 ++++++++++
>   4 files changed, 345 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
> 
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index cc864ff5abbb..de29769f2f3f 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -2,5 +2,5 @@
>   
>   obj-$(CONFIG_GUNYAH) += gunyah.o
>   
> -gunyah_rsc_mgr-y += rsc_mgr.o
> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> index d4e799a7526f..7406237bc66d 100644
> --- a/drivers/virt/gunyah/rsc_mgr.h
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -74,4 +74,49 @@ struct gh_rm;
>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
>   		void **resp_buf, size_t *resp_buff_size);
>   
<----------------------------
> +/* Message IDs: VM Management */
> +#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
> +#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
> +#define GH_RM_RPC_VM_START			0x56000004
> +#define GH_RM_RPC_VM_STOP			0x56000005
> +#define GH_RM_RPC_VM_RESET			0x56000006
> +#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
> +#define GH_RM_RPC_VM_INIT			0x5600000B
> +#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
> +#define GH_RM_RPC_VM_GET_VMID			0x56000024
> +
> +struct gh_rm_vm_common_vmid_req {
> +	__le16 vmid;
> +	__le16 reserved0;
> +} __packed;
> +
> +/* Call: VM_ALLOC */
> +struct gh_rm_vm_alloc_vmid_resp {
> +	__le16 vmid;
> +	__le16 reserved0;
> +} __packed;
> +
> +/* Call: VM_STOP */
> +struct gh_rm_vm_stop_req {
> +	__le16 vmid;
> +#define GH_RM_VM_STOP_FLAG_FORCE_STOP	BIT(0)
> +	u8 flags;
> +	u8 reserved;
> +#define GH_RM_VM_STOP_REASON_FORCE_STOP		3
> +	__le32 stop_reason;
> +} __packed;
> +
> +/* Call: VM_CONFIG_IMAGE */
> +struct gh_rm_vm_config_image_req {
> +	__le16 vmid;
> +	__le16 auth_mech;
> +	__le32 mem_handle;
> +	__le64 image_offset;
> +	__le64 image_size;
> +	__le64 dtb_offset;
> +	__le64 dtb_size;
> +} __packed;
> +
> +/* Call: GET_HYP_RESOURCES */
> +
-------------------------------->

All the above structures are very much internal to rsc_mgr_rpc.c and 
interface to the rsc_mgr_rpc is already abstracted with function arguments

ex:

int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum 
gh_rm_vm_auth_mechanism auth_mechanism, u32 mem_handle, u64 
image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)

So why do we need these structs and defines in header file at all?
you should proabably consider moving them to the .c file.


>   #endif
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> new file mode 100644
> index 000000000000..4515cdd80106
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/gunyah_rsc_mgr.h>
> +

Why new line here?

> +#include "rsc_mgr.h"
> +
> +/*
...

> +int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
> +		u32 mem_handle, u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)
> +{
> +	struct gh_rm_vm_config_image_req req_payload = { 0 };
> +	size_t resp_size;
> +	void *resp;
> +
> +	req_payload.vmid = cpu_to_le16(vmid);
> +	req_payload.auth_mech = cpu_to_le16(auth_mechanism);
> +	req_payload.mem_handle = cpu_to_le32(mem_handle);
> +	req_payload.image_offset = cpu_to_le64(image_offset);
> +	req_payload.image_size = cpu_to_le64(image_size);
> +	req_payload.dtb_offset = cpu_to_le64(dtb_offset);
> +	req_payload.dtb_size = cpu_to_le64(dtb_size);
> +
> +	return gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
> +			&resp, &resp_size);
> +}
> +

--srini
