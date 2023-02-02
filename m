Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF52687DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjBBMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjBBMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:47:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C468BDF9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:46:59 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l8so1294082wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 04:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMREe2uGtxx1nQqz2nFqLj1yAVyLLBzCpm3Pj5KHG8I=;
        b=SW9cZKxm6PgkcityeOHL1ayZKT2W6D1zVMZ6bNuiJgTu9MXtyRqW5+dNNzjeBUwD5g
         Ys+sYrByLF0Hmg9rXGBLmLUE8Z98ellVKsw5yzzgizraZM7YT5vTv2/Qf98Ls82FrrVc
         gGNFGNYoSoVav5FHCf2eaiMYK5zzXLYYkwyNrAqHPXw+t11K0q95H99dBQbe7RcQM+t4
         bKV0y2w46+6Kpz3n4zHq3Zgkt9IkK45+O71qGcZTGJNjRvtkFMabQElvHWcCu+nbSlcf
         Cb6yhTz0P0a9nrdS+g6sYeV6WaZeUEBbKPIGWTJW1D69td/hlPzRt3kkxaW5tdV+CNp0
         AYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMREe2uGtxx1nQqz2nFqLj1yAVyLLBzCpm3Pj5KHG8I=;
        b=jO/2ZQzImXnf5y1A8tEMGIpdeinNF4aB/jrvjbKwqRCZMDW0Fa6qcjBxgwB9Oi0sOM
         L75aRUXgZ7xyMxj+mtE8sX9HXe7YstybXkkgOxsHYzyudg/lUmi9mOuyBkpUFoRmwlLm
         3B10lVW4205JmzYiUfbgvy6UD0d+VTPOsNbnGQxdN5DZyS7jYPW7Jnw4XSkktRyLUgaG
         nfYShs1HM1jzR2g+aut7fM4MwfxOniWbfAP2/BqtyN2kip6+C1H1Ibvk9P842F60sxSk
         ICZijX6Mf2LVF2WMz65scoolFkwSeGcunOsgLRnl4Q+po/axRWwPmXD6TtWRNozKT4F5
         2qaQ==
X-Gm-Message-State: AO0yUKXW9e5ytls6T5tp3h4rbCd4T96ukUdQPx1aOlWAVfb4Qwg4MB1X
        137O1ey/W3RyGd9FIRJQSRz9Ng==
X-Google-Smtp-Source: AK7set+WNwJz4TnWff/70DvPPqlwttfQ1PgMlqPF7yWZ8USPZa5eZhEZX2n5IkEZfQl71fh0KES7VA==
X-Received: by 2002:a05:600c:540d:b0:3dc:1687:9b9a with SMTP id he13-20020a05600c540d00b003dc16879b9amr5702617wmb.37.1675341978409;
        Thu, 02 Feb 2023 04:46:18 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bd16-20020a05600c1f1000b003db0ee277b2sm4763745wmb.5.2023.02.02.04.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 04:46:17 -0800 (PST)
Message-ID: <4db1c760-10d9-3a22-106a-dda141dd5381@linaro.org>
Date:   Thu, 2 Feb 2023 12:46:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 10/27] gunyah: rsc_mgr: Add VM lifecycle RPC
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-11-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-11-quic_eberman@quicinc.com>
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



On 20/01/2023 22:46, Elliot Berman wrote:
> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Makefile      |   2 +-
>   drivers/virt/gunyah/rsc_mgr.h     |  36 +++++
>   drivers/virt/gunyah/rsc_mgr_rpc.c | 238 ++++++++++++++++++++++++++++++
>   include/linux/gunyah_rsc_mgr.h    |  55 +++++++
>   4 files changed, 330 insertions(+), 1 deletion(-)
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
> index 824749e63a54..2f12f31a2ea6 100644
> --- a/drivers/virt/gunyah/rsc_mgr.h
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -68,4 +68,40 @@ struct gh_rm;
>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
>   		void **resp_buf, size_t *resp_buff_size);
>   
> +/* Message IDs: VM Management */
> +#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
> +#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
> +#define GH_RM_RPC_VM_START			0x56000004
> +#define GH_RM_RPC_VM_STOP			0x56000005
> +#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
> +#define GH_RM_RPC_VM_INIT			0x5600000B
> +#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
> +#define GH_RM_RPC_VM_GET_VMID			0x56000024
> +
> +struct gh_vm_common_vmid_req {
> +	__le16 vmid;
> +	__le16 reserved0;
> +} __packed;
> +
> +/* Call: VM_STOP */
> +struct gh_vm_stop_req {
> +	__le16 vmid;
> +	u8 flags; /* currently not used */
> +	u8 reserved;
> +	__le32 stop_reason; /* currently not used */
> +} __packed;
> +
> +/* Call: VM_CONFIG_IMAGE */
> +struct gh_vm_config_image_req {
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
> index 000000000000..b6935dfac1fe
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -0,0 +1,238 @@
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
> +	void *resp;
> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	size_t resp_size;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), &resp, &resp_size);
> +	if (!ret && resp_size) {

Am struggling to understand these type of checks in success case, when a 
command is not expecting any response why are we checking for response 
here, This sounds like a bug in either RM or hypervisor.

Or Is this something that happens due to some firmware behaviour?
Could you elobrate on this.


> +		pr_warn("Unexpected payload size: %ld Expected: 0", resp_size);
> +		dump_stack();
> +		kfree(resp);
> +		return -EBADMSG;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
> + * @vmid: Use GH_VMID_INVAL or GH_VMID_SELF (0) to dynamically allocate a VM. A reserved VMID can
> + *        be supplied to request allocation of a platform-defined VM.
> + *
> + * Returns - the allocated VMID or negative value on error
> + */
> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
> +{
> +	void *resp;
> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
we pass vmid that is recevied  here.

> +	};
> +	struct gh_vm_alloc_vmid_resp *resp_payload;
> +	size_t resp_size;
> +	int ret;
> +
> +	if (vmid == GH_VMID_INVAL)
> +		vmid = 0;

then we change this to 0.

> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
> +			&resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (!vmid) {
then here we check agaist zero.

Why not just do

if (vmid == GH_VMID_INVAL || vmid == GH_VMID_SELF)

this will make core more reader friendly and match to what is in kerneldoc.

> +		if (resp_size != sizeof(*resp_payload)) {
> +			pr_warn("%s: unexpected payload size: %ld Expected: %ld", __func__,
> +				resp_size, sizeof(*resp_payload));
> +			ret = -EBADMSG;
> +		} else {
> +			resp_payload = resp;
> +			ret = le16_to_cpu(resp_payload->vmid);
> +		}
> +	}
> +	kfree(resp);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_alloc_vmid);
> +
> +/**
> + * gh_rm_dealloc_vmid() - Dispose the VMID
> + * @vmid: VM identifier
> + */
> +int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_DEALLOC_VMID, vmid);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_dealloc_vmid);
> +
> +/**
> + * gh_rm_vm_start() - Move the VM into "ready to run" state
> + * @vmid: VM identifier
> + *
> + * On VMs which use proxy scheduling, vcpu_run is needed to actually run the VM.
> + * On VMs which use Gunyah's scheduling, the vCPUs start executing in accordance with Gunyah
> + * scheduling policies.
> + */
> +int gh_rm_vm_start(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_START, vmid);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_vm_start);
> +
> +/**
> + * gh_rm_vm_stop() - Send a request to Resource Manager VM to stop a VM.
> + * @vmid: VM identifier
> + *
> + * Returns - 0 on success; negative value on failure
> + */
> +int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid)
> +{
> +	struct gh_vm_stop_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload),
> +			&resp, &resp_size);
> +	if (!ret && resp_size) {
same comment as the first one.
> +		pr_warn("%s: unexpected payload size: %ld Expected: 0", __func__, resp_size);
> +		kfree(resp);
> +		return -EBADMSG;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_vm_stop);
> +
> +int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
> +		u32 mem_handle, u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)
> +{
> +	struct gh_vm_config_image_req req_payload = { 0 };
> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	req_payload.vmid = cpu_to_le16(vmid);
> +	req_payload.auth_mech = cpu_to_le16(auth_mechanism);
> +	req_payload.mem_handle = cpu_to_le32(mem_handle);
> +	req_payload.image_offset = cpu_to_le64(image_offset);
> +	req_payload.image_size = cpu_to_le64(image_size);
> +	req_payload.dtb_offset = cpu_to_le64(dtb_offset);
> +	req_payload.dtb_size = cpu_to_le64(dtb_size);
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
> +			&resp, &resp_size);
> +	if (!ret && resp_size) {
same comment as the first one.
> +		pr_warn("%s: unexpected payload size: %ld Expected: 0", __func__, resp_size);
> +		kfree(resp);
> +		return -EBADMSG;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_vm_configure);
> +
> +/**
> + * gh_rm_vm_init() - Move the VM to initialized state.
> + * @vmid: VM identifier
> + *
> + * RM will allocate needed resources for the VM. After gh_rm_vm_init, gh_rm_get_hyp_resources()
> + * can be called to learn of the capabilities we can use with the new VM.
> + *
> + * Returns - 0 on success; negative value on failure
> + */
> +int gh_rm_vm_init(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_INIT, vmid);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_vm_init);
> +
> +/**
> + * gh_rm_get_hyp_resources() - Retrieve hypervisor resources (capabilities) associated with a VM
> + * @vmid: VMID of the other VM to get the resources of
> + * @resources: Set by gh_rm_get_hyp_resources and contains the returned hypervisor resources.
> + *
> + * Returns - 0 on success; negative value on failure
> + */
> +int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
> +				struct gh_rm_hyp_resources **resources)
> +{
> +	struct gh_rm_hyp_resources *resp;
> +	size_t resp_size;
> +	int ret;
> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
> +			 &req_payload, sizeof(req_payload),
> +			 (void **)&resp, &resp_size);
we can go upto 100 chars.

> +	if (ret)
> +		return ret;
> +
> +	if (!resp_size)
> +		return -EBADMSG;

This is again another check that falls under the first category, how can 
a command pass and return incorrect responses?

Or are we doing to many unnecessary checks?

> +
> +	if (resp_size < struct_size(resp, entries, 0) ||
> +		resp_size != struct_size(resp, entries, le32_to_cpu(resp->n_entries))) {
> +		kfree(resp);
> +		return -EBADMSG;
> +	}
> +
> +	*resources = resp;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get_hyp_resources);
> +
> +/**
> + * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
> + * @vmid: Filled with the VMID of this VM
> + */
> +int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid)
> +{
> +	static u16 cached_vmid = GH_VMID_INVAL;
> +	__le16 *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	if (cached_vmid != GH_VMID_INVAL) {
> +		*vmid = cached_vmid;
> +		return 0;
> +	}
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_VMID, NULL, 0, (void **)&resp, &resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (resp_size != sizeof(*resp)) {
> +		pr_warn("%s: unexpected payload size: %ld Expected: %ld", __func__,
> +			resp_size, sizeof(*resp));
> +		ret = -EBADMSG;
> +		goto out;
> +	}
> +
> +	*vmid = cached_vmid = le16_to_cpu(*resp);
> +out:
> +	kfree(resp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
