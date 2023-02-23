Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D356A1224
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBWVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBWVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:37:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26005BB84
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:37:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so691210pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7+aUg9HXQ/A/eUt8v18nKugzdSz6vl7sg4McbH6tWQ=;
        b=c0u0fvJZo7cq6NMR9jPgTY+MYZwgs+0jV6PRHowGAKrgQuoUhvj3TL13DAL7cHpEIg
         4fYxMXbiP4VqePjSGrYZ+GgoINswsELo4klKlaOH4DjNL3MId9Z0yRYhzhfiPzf14+Js
         l5sOFeOLeZTeRxCU5FJ7yUA5tg8DlZpNSY3LQYP/lIR8O/awnhgVGJ4sEswcpLfqh6ux
         GeK5MXrLx3lqT4df5CdiOamajjJAW0KBcA5PN6wJTJ6HgbUrsXmFllSjzjM7WvPpOqsO
         TE70o8gCt2etNpQiPKSBG2B/atIKnm7rJoR0iG6sIKDmvr+I3CnqWdiZmk1xPB6cJt5x
         hIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7+aUg9HXQ/A/eUt8v18nKugzdSz6vl7sg4McbH6tWQ=;
        b=WPHZ8CEBRWcigAy1vALbJzZ0igqxwlrhFwd5LQdPVHkEUNKMLkhfKMvUt02szp3sd+
         09XIxl86U2HCiyEzVYP0jaK8OEuE4WCoLmVQpX5frt8+UMdqPLQRbtqF7UHoAyxhJtvj
         FaTY04FlLhYL/SLXyO+TEaVaOWMpkRO89RmTvn2kQ3gnBx5N3UYbThcICJDohbe1qVbU
         K2sDEVDfUUUIh7IbAMzdzxGxpfrzEfPDaTl+Nqa6Np80TfDwtTFq3HReFa3nHkvq8VnA
         tP2gb+zH4IP+h8H+RFyBIj7/FJhTjG8SLzuhJuTNxjxrrKJ9vdZAuFfklMDL2Kg9uTRB
         EbGA==
X-Gm-Message-State: AO0yUKVrmJ6h8Aw86iZpEhaqSLamx5Nk2ko1EqNnFvs84T3QFFtnJxCz
        F3zyN4fCQRYc8HRiCb7Mpese5A==
X-Google-Smtp-Source: AK7set+WA4y6isMIp2ZzVMyILhKLJ1WQxXMtedotrSE0LCPg6li/VQItDsL6LiRCl1UMeJqGyYTlRQ==
X-Received: by 2002:a05:6a20:6918:b0:c7:164c:edf7 with SMTP id q24-20020a056a20691800b000c7164cedf7mr12929189pzj.36.1677188233241;
        Thu, 23 Feb 2023 13:37:13 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id s23-20020a62e717000000b005a9cb8edee3sm3881780pfh.85.2023.02.23.13.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 13:37:01 -0800 (PST)
Message-ID: <556ab51e-ddf8-b56b-1743-36f3b6d623d1@linaro.org>
Date:   Thu, 23 Feb 2023 15:36:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212343.3311875-1-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20230214212343.3311875-1-quic_eberman@quicinc.com>
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

On 2/14/23 3:23 PM, Elliot Berman wrote:
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

I suggested this before and you honored it.  Now I'll suggest
it again, and ask you to do it throughout the driver.

Please separate the definitions of constant values that
certain fields can take on from the structure definition.
I think doing it the way you have here makes it harder to
understand the structure definition.

You could define an anonymous enumerated type to hold
the values meant to be held by each field.

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
> +#include "rsc_mgr.h"
> +
> +/*
> + * Several RM calls take only a VMID as a parameter and give only standard
> + * response back. Deduplicate boilerplate code by using this common call.
> + */
> +static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
> +{
> +	struct gh_rm_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	size_t resp_size;
> +	void *resp;
> +
> +	return gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), &resp, &resp_size);
> +}
> +
> +/**
> + * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: Use GH_VMID_INVAL or 0 to dynamically allocate a VM. A reserved VMID can
> + *        be supplied to request allocation of a platform-defined VM.

Honestly, I'd rather just see 0 (and *not* GH_VMID_INVAL) be the
special value to mean "dynamically allocate the VMID."  It seems
0 is a reserved VMID anyway, and GH_VMID_INVAL might as well be
treated here as an invalid parameter.

Is there any definitition of which VMIDs are reserved?  Like,
anything under 1024?

That's it on this patch for now.

					-Alex

> + *
> + * Returns - the allocated VMID or negative value on error
> + */
> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
> +{
> +	struct gh_rm_vm_common_vmid_req req_payload = { 0 };
> +	struct gh_rm_vm_alloc_vmid_resp *resp_payload;
> +	size_t resp_size;
> +	void *resp;
> +	int ret;

. . .

