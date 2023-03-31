Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D152A6D2271
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjCaO0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjCaO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:26:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A21DFAD
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:25:47 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id kr22so2437065qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272746; x=1682864746;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ehIT8kbZSW8D6fx7fJoGvMypWEQfU3h/Lkte7SGm/M=;
        b=EWLCeOgs5xC303XBu06qzsYSkX8Nnc+TGf/xlVJO+85VnyYuht9Hs0Ddhpp6jQd7J3
         r6kB7cZ+DDrqXAQCELF9gKkk28dP+Wlwk+wZv6Fm1cTNS+CgEBIncFKNfFp6D7JWTnWk
         P7nfZShKSPZjLdvFZpWiPz1ZgVoVrCFO/U4E4gHxpQteFs5M1z0z4FuRqUMMJuorE7BS
         9dbd05rLEH0Q6B5NNBDrm3CNj4CeOaRjTrTv5nODIISlmpzCap7FxU7CmUnmX6UGMy3P
         03GEJlTtFKSJxjszTLSrRM5ms4ODgkqW5N4ovWJJ1osBjeaqeCN28LUXS3Mw6V4GlvIh
         8oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272746; x=1682864746;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ehIT8kbZSW8D6fx7fJoGvMypWEQfU3h/Lkte7SGm/M=;
        b=ghHJTcxdGFaZbBVz1Sf9iPsM9+OiA9bIF6hY4H8UVet76OK9+cOZGZenGnJgvCgLz7
         Ggd7L3G3vAbbjGo0peczW6lG4NI4vwyq2Y2WDzuNRemeFT8dRDhq+b6xPRfLjld1VYwr
         xv/2IiA6RbrcHYilEoWpudlwy2LNN82XqA970j0iiN4y9Vbs2qvXkb1MpbXn+yYff1ht
         jPImL1B0RoH0Pa1IQyeW9ytvOhaTdT7QYYiWaiU2vZ24zNeG9f2+Fg2wv17wJt1+EuxU
         xvmtZBlJTwNoVJm5x7KpPPND8OwBSU2KzvVjWcKnz3EEKnk+lncMLL4V2QPraK+eMBay
         xANA==
X-Gm-Message-State: AAQBX9drwq566YPc73fJ1Lylx2MD+g7XaiF7ZVlMlEiuS6z2UuOpkJIV
        h/R8uWjmG0w4Z7+42RPbakactg==
X-Google-Smtp-Source: AKy350bm88rZQoQJCqHDyb3gMI7VpB/ErLAFNLRQKydZHq9lZOhIPgJKbUM2n1eXEdAXB2zU1eeB1w==
X-Received: by 2002:a05:6214:48c:b0:56f:8ef:693 with SMTP id pt12-20020a056214048c00b0056f08ef0693mr47025174qvb.0.1680272746498;
        Fri, 31 Mar 2023 07:25:46 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id r8-20020a0cf808000000b005deeeba2aa2sm633978qvn.43.2023.03.31.07.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:25:46 -0700 (PDT)
Message-ID: <558f3d62-ac07-49e7-d496-d14c5a90d3ff@linaro.org>
Date:   Fri, 31 Mar 2023 09:25:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 09/26] gunyah: rsc_mgr: Add VM lifecycle RPC
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
 <20230304010632.2127470-10-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-10-quic_eberman@quicinc.com>
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
> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Several comments, no major issues here.	-Alex

> ---
>   drivers/virt/gunyah/Makefile      |   2 +-
>   drivers/virt/gunyah/rsc_mgr_rpc.c | 260 ++++++++++++++++++++++++++++++
>   include/linux/gunyah_rsc_mgr.h    |  73 +++++++++
>   3 files changed, 334 insertions(+), 1 deletion(-)
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
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> new file mode 100644
> index 000000000000..ffcb861a31b5
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/gunyah_rsc_mgr.h>
> +#include "rsc_mgr.h"
> +
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
> +	__le16 _padding;
> +} __packed;
> +
> +/* Call: VM_ALLOC */
> +struct gh_rm_vm_alloc_vmid_resp {
> +	__le16 vmid;
> +	__le16 _padding;
> +} __packed;
> +
> +/* Call: VM_STOP */
> +#define GH_RM_VM_STOP_FLAG_FORCE_STOP	BIT(0)
> +
> +#define GH_RM_VM_STOP_REASON_FORCE_STOP		3
> +
> +struct gh_rm_vm_stop_req {
> +	__le16 vmid;
> +	u8 flags;
> +	u8 _padding;
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
> +/*
> + * Several RM calls take only a VMID as a parameter and give only standard
> + * response back. Deduplicate boilerplate code by using this common call.
> + */
> +static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
> +{
> +	struct gh_rm_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +
> +	return gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), NULL, NULL);
> +}
> +
> +/**
> + * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: Use 0 to dynamically allocate a VM. A reserved VMID can be supplied
> + *        to request allocation of a platform-defined VM.
> + *
> + * Returns - the allocated VMID or negative value on error
> + */
> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid)
> +{
> +	struct gh_rm_vm_common_vmid_req req_payload = {
> +		.vmid = vmid,
> +	};
> +	struct gh_rm_vm_alloc_vmid_resp *resp_payload;
> +	size_t resp_size;
> +	void *resp;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
> +			&resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (!vmid) {
> +		resp_payload = resp;
> +		ret = le16_to_cpu(resp_payload->vmid);
> +		kfree(resp);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * gh_rm_dealloc_vmid() - Dispose the VMID

s/the/of a/

> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
> + */
> +int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_DEALLOC_VMID, vmid);
> +}
> +
> +/**
> + * gh_rm_vm_reset() - Reset the VM's resources
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
> + *
> + * While tearing down the VM, request RM to clean up all the VM resources

s/While/As part of/

> + * associated with the VM. Only after this, Linux can clean up all the
> + * references it maintains to resources.
> + */
> +int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_RESET, vmid);
> +}
> +
> +/**
> + * gh_rm_vm_start() - Move the VM into "ready to run" state
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
> + *
> + * On VMs which use proxy scheduling, vcpu_run is needed to actually run the VM.
> + * On VMs which use Gunyah's scheduling, the vCPUs start executing in accordance with Gunyah
> + * scheduling policies.
> + */
> +int gh_rm_vm_start(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_START, vmid);
> +}
> +
> +/**
> + * gh_rm_vm_stop() - Send a request to Resource Manager VM to forcibly stop a VM.
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
> + */
> +int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid)
> +{
> +	struct gh_rm_vm_stop_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +		.flags = GH_RM_VM_STOP_FLAG_FORCE_STOP,
> +		.stop_reason = cpu_to_le32(GH_RM_VM_STOP_REASON_FORCE_STOP),
> +	};
> +
> +	return gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload), NULL, NULL);
> +}
> +
> +/**
> + * gh_rm_vm_configure() - Prepare a VM to start and provide the common
> + *			  configuration needed by RM to configure a VM
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier allocated with gh_rm_alloc_vmid
> + * @auth_mechanism: Authentication mechanism used by resource manager to verify
> + *                  the virtual machine
> + * @mem_handle: Handle to a previously shared memparcel that contains all parts
> + *              of the VM image subject to authentication.
> + * @image_offset: Start address of VM image, relative to the start of memparcel
> + * @image_size: Size of the VM image
> + * @dtb_offset: Start address of the devicetree binary with VM configuration,
> + *              relative to start of memparcel.
> + * @dtb_size: Maximum size of devicetree binary. Resource manager applies
> + *            an overlay to the DTB and dtb_size should include room for
> + *            the overlay.

The above comment about including extra room doesn't sit well.
How much extra room is required?  Is there any way you can
provide an estimate?  Or better yet, is it possible to have
gh_rm_call() somehow calculate that extra amount and add it on?

> + */
> +int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
> +		u32 mem_handle, u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)

 From what I can tell, the auth argument (and generally, ghvm->auth)
is never used.  If that's the case, it might be nicer to explicitly
not included it for now, and only add it when it's going to be used
(and tested to work correctly).

I don't know if this is a reasonable strategy, but I'm always a
little skeptical about unused code like this.

> +{
> +	struct gh_rm_vm_config_image_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +		.auth_mech = cpu_to_le16(auth_mechanism),
> +		.mem_handle = cpu_to_le32(mem_handle),
> +		.image_offset = cpu_to_le64(image_offset),
> +		.image_size = cpu_to_le64(image_size),
> +		.dtb_offset = cpu_to_le64(dtb_offset),
> +		.dtb_size = cpu_to_le64(dtb_size),
> +	};
> +

Are there any sanity checks that could be performed before we
actually make the call to the resource manager?  Like, can
you ensure the DTB offset and size are in range?

> +	return gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
> +			  NULL, NULL);
> +}
> +
> +/**
> + * gh_rm_vm_init() - Move the VM to initialized state.

s/the/a/

> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VM identifier
> + *
> + * RM will allocate needed resources for the VM.
> + */
> +int gh_rm_vm_init(struct gh_rm *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_INIT, vmid);
> +}
> +
> +/**
> + * gh_rm_get_hyp_resources() - Retrieve hypervisor resources (capabilities) associated with a VM
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: VMID of the other VM to get the resources of
> + * @resources: Set by gh_rm_get_hyp_resources and contains the returned hypervisor resources.

Caller must free the resources pointer returned if successful.
(Please mention this.)

> + */
> +int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
> +				struct gh_rm_hyp_resources **resources)
> +{
> +	struct gh_rm_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	struct gh_rm_hyp_resources *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
> +			 &req_payload, sizeof(req_payload),
> +			 (void **)&resp, &resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (!resp_size)
> +		return -EBADMSG;
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
> +
> +/**
> + * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
> + * @rm: Handle to a Gunyah resource manager
> + * @vmid: Filled with the VMID of this VM
> + */
> +int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid)
> +{
> +	static u16 cached_vmid = GH_VMID_INVAL;
> +	size_t resp_size;
> +	__le32 *resp;
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
> +	*vmid = cached_vmid = lower_16_bits(le32_to_cpu(*resp));
> +	kfree(resp);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index deca9b3da541..6a2f434e67f7 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -18,4 +18,77 @@ int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb);
>   struct device *gh_rm_get(struct gh_rm *rm);
>   void gh_rm_put(struct gh_rm *rm);
>   
> +struct gh_rm_vm_exited_payload {
> +	__le16 vmid;
> +	__le16 exit_type;
> +	__le32 exit_reason_size;
> +	u8 exit_reason[];
> +} __packed;
> +
> +#define GH_RM_NOTIFICATION_VM_EXITED		 0x56100001

I think all these notification reasons should be defined in
an enumerated type, to group them, and name the group.

> +
> +enum gh_rm_vm_status {
> +	GH_RM_VM_STATUS_NO_STATE	= 0,
> +	GH_RM_VM_STATUS_INIT		= 1,
> +	GH_RM_VM_STATUS_READY		= 2,
> +	GH_RM_VM_STATUS_RUNNING		= 3,
> +	GH_RM_VM_STATUS_PAUSED		= 4,
> +	GH_RM_VM_STATUS_LOAD		= 5,
> +	GH_RM_VM_STATUS_AUTH		= 6,
> +	GH_RM_VM_STATUS_INIT_FAILED	= 8,
> +	GH_RM_VM_STATUS_EXITED		= 9,
> +	GH_RM_VM_STATUS_RESETTING	= 10,
> +	GH_RM_VM_STATUS_RESET		= 11,
> +};
> +
> +struct gh_rm_vm_status_payload {
> +	__le16 vmid;
> +	u16 reserved;
> +	u8 vm_status;
> +	u8 os_status;
> +	__le16 app_status;
> +} __packed;
> +
> +#define GH_RM_NOTIFICATION_VM_STATUS		 0x56100008
> +
> +/* RPC Calls */
> +int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid);
> +int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid);
> +int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid);
> +int gh_rm_vm_start(struct gh_rm *rm, u16 vmid);
> +int gh_rm_vm_stop(struct gh_rm *rm, u16 vmid);
> +
> +enum gh_rm_vm_auth_mechanism {
> +	GH_RM_VM_AUTH_NONE		= 0,
> +	GH_RM_VM_AUTH_QCOM_PIL_ELF	= 1,
> +	GH_RM_VM_AUTH_QCOM_ANDROID_PVM	= 2,
> +};
> +
> +int gh_rm_vm_configure(struct gh_rm *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
> +			u32 mem_handle, u64 image_offset, u64 image_size,
> +			u64 dtb_offset, u64 dtb_size);
> +int gh_rm_vm_init(struct gh_rm *rm, u16 vmid);
> +
> +struct gh_rm_hyp_resource {
> +	u8 type;

Maybe add a comment on the above field, and others, such as:

	u8 type;	/* enum gh_resource_type */

> +	u8 reserved;
> +	__le16 partner_vmid;
> +	__le32 resource_handle;
> +	__le32 resource_label;
> +	__le64 cap_id;
> +	__le32 virq_handle;
> +	__le32 virq;
> +	__le64 base;
> +	__le64 size;
> +} __packed;
> +
> +struct gh_rm_hyp_resources {
> +	__le32 n_entries;
> +	struct gh_rm_hyp_resource entries[];
> +} __packed;
> +
> +int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 vmid,
> +				struct gh_rm_hyp_resources **resources);
> +int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
> +
>   #endif

