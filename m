Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A46726D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjARS0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjARS0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:26:45 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890C5A819
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:26:42 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e204so603964iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ps+eL1/c+O2UYvFHzy2kmIGhPZecVMtX+/NhgDsMYHU=;
        b=k34v9jK9OiKIC4eI3u4Yqqyvko/PH8w6B1FTQEsMV+kzHMyRPsVjw1FnVStQTAifGw
         bRHe1MDlj5/wFGCye+2Qv/YB2Fk+paPeu4keesxcCfr4PBzTGWJ98nPtK/zVTA1krHGP
         ikjvX+2s+2dBLqgILQBjVKHR/JAUanGqKtEwSLqo5BXoWe/2Wk6XL2P53srKsdBKVC6c
         NXlEp5ofhzJ15nmUGWnpg5GLu0pLselrZV1NWx8N3eY36qHUa+UIWvSMezBrskgEFC+t
         kl5yKqgM461QRbRdK1u/xO1aKPuTBgN3MnlyVWeuOYq4ff/7izir5M08sjOBzjos2aG3
         T6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps+eL1/c+O2UYvFHzy2kmIGhPZecVMtX+/NhgDsMYHU=;
        b=uKQPazxuxMHnYpotFwX1mMCuMUKKg+jNTCPGwE+1URhksAXdmgQ5MhtBj7F/sxZhbF
         WFl5mNv6DmyV3Du8cO0n7vfe/L6G19oyBPLADRTjg117cJ67ebeFGwL0JkTY8pJ20rPx
         PevgiZUMFO0wwj5TYbj50mSmRIfclw2nAmJVIf8kq8Zj6318yTRXlbqEYbUPhSLCZHuc
         nRGstmM13jZLtpqDETBvUHppzZJuWt8jFrYVmIw5EzWDrBAqkU7i43NLqUqCPxsx0CPN
         3nGBDW4CRtZgDDRdcUzsyctqV0Ja1KGhv1l4kj+iwJwkTP49u+65NiZs34sIwTpJie2a
         ycrw==
X-Gm-Message-State: AFqh2kpxwD16l5yEC+UjdKO0tvc7JqIQfo5mNfyJqh0VbEUPSSTk4876
        eU2rBopuwmXk7+0gYXQhKcwyfw==
X-Google-Smtp-Source: AMrXdXtLotQj4AMTseDMGSZaQ5J7tjAXffstvezwoIFsVGSFIhS/qklNO7VR6umCg+kxsgU0wPM7RA==
X-Received: by 2002:a6b:c8ca:0:b0:704:b0c0:d273 with SMTP id y193-20020a6bc8ca000000b00704b0c0d273mr5528394iof.20.1674066401456;
        Wed, 18 Jan 2023 10:26:41 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id z13-20020a05660229cd00b006f6623df63asm11506513ioq.14.2023.01.18.10.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 10:26:40 -0800 (PST)
Message-ID: <7a4fdcca-b72a-d155-854f-07ec1a4a9107@linaro.org>
Date:   Wed, 18 Jan 2023 12:26:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 11/28] gunyah: rsc_mgr: Add VM lifecycle RPC
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-12-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20221219225850.2397345-12-quic_eberman@quicinc.com>
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

On 12/19/22 4:58 PM, Elliot Berman wrote:
> Add Gunyah Resource Manager RPC to launch an unauthenticated VM.

I have a number of general comments on your patch, and there
are a few bugs that you will need to address.

> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Makefile      |   2 +-
>   drivers/virt/gunyah/rsc_mgr.h     |  41 ++++++
>   drivers/virt/gunyah/rsc_mgr_rpc.c | 224 ++++++++++++++++++++++++++++++
>   include/linux/gunyah_rsc_mgr.h    |  50 +++++++
>   4 files changed, 316 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/virt/gunyah/rsc_mgr_rpc.c
> 
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index e7cf59b9e64e..5caa05267a58 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,4 +1,4 @@
>   obj-$(CONFIG_GUNYAH) += gunyah.o
>   
> -gunyah_rsc_mgr-y += rsc_mgr.o
> +gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
>   obj-$(CONFIG_GUNYAH_RESOURCE_MANAGER) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> index b5bb36a7a4cc..1f9e3c38038e 100644
> --- a/drivers/virt/gunyah/rsc_mgr.h
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -33,4 +33,45 @@ struct gh_rm_rpc;
>   int gh_rm_call(struct gh_rm_rpc *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
>   		void **resp_buf, size_t *resp_buff_size);
>   
> +/* Message IDs: VM Management */
> +#define GH_RM_RPC_VM_ALLOC_VMID			0x56000001

These values very clearly appear to be encoded.  Like the top
byte (0x56) might be defining the resource type and bytes below
it are the request ID?  If that is truly the case I think it
is useful to lay out that format, and perhaps define the values
based on the components that they are comprised of.

> +#define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
> +#define GH_RM_RPC_VM_START			0x56000004
> +#define GH_RM_RPC_VM_STOP			0x56000005
> +#define GH_RM_RPC_VM_CONFIG_IMAGE		0x56000009
> +#define GH_RM_RPC_VM_INIT			0x5600000B
> +#define GH_RM_RPC_VM_GET_HYP_RESOURCES		0x56000020
> +#define GH_RM_RPC_VM_GET_VMID			0x56000024
> +
> +/* Call: CONSOLE_OPEN, CONSOLE_CLOSE, CONSOLE_FLUSH */

The above comment is nonsense.  None of these symbols (or
similar) are defined, anywhere.  For the current patch, this
structure is used for VM_ALLOC_VMID, VM_GET_HYP_RESOURCES,
and via gh_rm_common_vmid_call(), VM_DEALLOC_VMID, VM_START,
and VM_INIT.  It's possible you'll use it for other requests
in subsequent patches.

Here you are defining a single "common" structure that's
used for several message types.  I think there are legitimate
reasons for that.  However...

In general, I think I'd rather see every message type laid
out separately.  It becomes a little long, here, where you
would define them, but in the code that uses them it allows
some simple patterns to be used in message handler functions
that I think improve understandability and perhaps correctness.
I'll provide some examples below to try to make my case.

> +struct gh_vm_common_vmid_req {
> +	__le16 vmid;
> +	__le16 reserved0;

If the above is really reserved (and unused), its
endianness doesn't matter.  (Not really a big deal.)

> +} __packed;

The above structure defines the format of a *request*
message.  But it is *also* the format of a VM_ALLOC_VMID
*response* message.  So the name of the type does not
match the way it's used.  As a reviewer, this seems off.

> +/* Call: VM_STOP */
> +struct gh_vm_stop_req {
> +	__le16 vmid;
> +	u8 flags;

I don't believe you specify what the valid values this
"flags" field can hold.  If not, I think you should (and
if it's currently not used/needed, say that).

> +	u8 reserved;
> +	__le32 stop_reason;

Same thing here.  This field is defined but from what
I can tell, it is not currently used.  What values
*could* it take on?  Why is it currently ignored?

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
> +struct gh_vm_get_hyp_resources_resp {
> +	__le32 n_entries;
> +	struct gh_rm_hyp_resource entries[];

This header file should include <linux/gunyah_rsrc_mgr.h> to get
the required definition of struct gh_rm_hyp_resource.

> +} __packed;
> +
>   #endif
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> new file mode 100644
> index 000000000000..8d9c1c635a27
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/gunyah_rsc_mgr.h>
> +
> +#include "rsc_mgr.h"
> +
> +/*
> + * Several RM calls take only a VMID as a parameter and give only standard
> + * response back. Deduplicate boilerplate code by using this common call.

In other words, the response message is empty for the requests that use
this function.

> + */
> +static int gh_rm_common_vmid_call(struct gh_rm_rpc *rm, u32 message_id, u16 vmid)
> +{
> +	void *resp = NULL;

No need to set this to NULL if you ignore its value
when the gh_rm_call() is unsuccessful.

> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	size_t resp_size;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), &resp, &resp_size);

Here and in all other calls to gh_rm_call() here (and added later),
you need to handle the return value differently.  (THIS IS A BUG.)

There are three classes of return value from gh_rm_call():
- Zero (success)
- Negative errno
- Positive Gunyah resource manager error code

In practice, it might be nice to distinguish Gunyah error codes from
Linux errnos, but I think the easiest solution might be to have a
function that maps Gunyah codes to comparable errno values, and have
gh_rm_call() use it so its return value is always 0 or negative.

> +	if (!ret)
> +		kfree(resp);
> +
> +	WARN_ON(!ret && resp_size);

You should have well-defined behavior when the response message
is empty.  Will the response pointer be valid or not?  I suggest
that a 0 length response message be guaranteed to return a null
pointer if the return value indicates success.  And a non-zero
length should be guaranteed to be valid.  There should be no
need for callers to issue warnings like this.

So the above would then just be (note this follows a pattern
similar to used by handlers later in the file):

	if (ret)
		return ret;
	
	if (resp_size)		/* (this is optional) */
		kfree(resp);

	return 0;


> +
> +	return ret;
> +}
> +
> +/**
> + * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
> + * @vmid: Use GH_VMID_INVAL to dynamically allocate a VM. A reserved VMID can also be requested
> + *        for a special-purpose platform-defined VM.
> + *
> + * Returns - the allocated VMID or negative value on error

Currently (based on a comment I made above) this statement
is not correct.  But I think what's described is the proper
return convention.  It's probably worth mentioning that it
will never return GH_VMID_SELF or GH_VMID_INVAL.

> + */
> +int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid)
> +{
> +	void *resp;
> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +	struct gh_vm_common_vmid_req *resp_payload;
> +	size_t resp_size;
> +	int ret;
> +

What is the meaning of this call if you pass GH_VMID_SELF?
Is that defined to be valid?  The code allows it, and if
so it treats it as equivalent to passing GH_VMID_INVAL.

> +	if (vmid == GH_VMID_INVAL)
> +		vmid = 0;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_ALLOC_VMID, &req_payload, sizeof(req_payload), &resp,
> +			&resp_size);

This *can* return a positive Gunyah resource manager error ID.
So in this case the caller would (erroneously) assume it was
a valid VMID.

You need to fix this.

> +	if (ret)
> +		return ret;
> +
> +	if (!vmid) {
> +		if (resp_size != sizeof(*resp_payload)) {
> +			ret = -EINVAL;

EINVAL means "invalid argument".  I *think* the right thing
to return would be -EBADMSG.  In any case I don't really
think -EINVAL is appropriate.

> +		} else {
> +			resp_payload = resp;
> +			ret = resp_payload->vmid;

This is a bug.  The vmid is a little-endian value, so you need
to use:

	ret = le16_to_cpu(resp_payload->vmid);

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

   * Returns: ...    (here and throughout)

> + */
> +int gh_rm_dealloc_vmid(struct gh_rm_rpc *rm, u16 vmid)
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
> +int gh_rm_vm_start(struct gh_rm_rpc *rm, u16 vmid)
> +{
> +	return gh_rm_common_vmid_call(rm, GH_RM_RPC_VM_START, vmid);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_vm_start);
> +
> +/**
> + * gh_rm_vm_stop() - Send a request to Resource Manager VM to stop a VM.
> + * @vmid: VM identifier
> + */
> +int gh_rm_vm_stop(struct gh_rm_rpc *rm, u16 vmid)
> +{
> +	struct gh_vm_stop_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),

This structure has a flags and a stop_reason field.  As I mentioned
earlier, I think you ought to explain what values this might have,
or perhaps explain why they're not used.

> +	};
> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_STOP, &req_payload, sizeof(req_payload),
> +			&resp, &resp_size);
> +	if (ret)
> +		return ret;

Is the response in this case in fact empty?  You are discarding
it, but because you don't specify how every request/response is
structured, we can only guess what's contained in the response
(if there is one).  This is a reason why I prefer having every
message structure shown explicitly, even if some are identical.
It makes it very clear to the reader what the protocol actually
looks like.  And unlike what you do in gh_rm_common_vmid_call(),
you ignore the resp_size, which could be checked if we knew its
expected size.

> +	kfree(resp);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_vm_stop);
> +
> +int gh_rm_vm_configure(struct gh_rm_rpc *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
> +		u32 mem_handle, u64 image_offset, u64 image_size, u64 dtb_offset, u64 dtb_size)
> +{
> +	struct gh_vm_config_image_req req_payload = { 0 };
> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +
> +	req_payload.vmid = cpu_to_le16(vmid);
> +	req_payload.auth_mech = cpu_to_le32(auth_mechanism);
> +	req_payload.mem_handle = cpu_to_le32(mem_handle);
> +	req_payload.image_offset = cpu_to_le64(image_offset);
> +	req_payload.image_size = cpu_to_le64(image_size);
> +	req_payload.dtb_offset = cpu_to_le64(dtb_offset);
> +	req_payload.dtb_size = cpu_to_le64(dtb_size);
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_CONFIG_IMAGE, &req_payload, sizeof(req_payload),
> +			&resp, &resp_size);
> +	if (ret)
> +		return ret;
> +	kfree(resp);
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
> + */
> +int gh_rm_vm_init(struct gh_rm_rpc *rm, u16 vmid)
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
> + * Return: >=0 value indicates the number of gh_rm_hyp_resource entries filled into *resources
> + */
> +ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
> +				struct gh_rm_hyp_resource **resources)

First, this function can return a positive Gunyah resource manager
error as well, which is a problem.

But this function is also pretty different from the rest, returning
the number of elements in the array whose address is returned.

I don't know why you don't just return the actual response
buffer (rather than duplicating most of it), and let the
caller use its embedded n_entries field to determine its
length.  Either way it's not beautiful I guess, but the
kmemdup() call seems unneccesary and adds a possible
additional error condition.

> +{
> +	struct gh_vm_get_hyp_resources_resp *resp;
> +	size_t resp_size;
> +	int ret;
> +	struct gh_vm_common_vmid_req req_payload = {
> +		.vmid = cpu_to_le16(vmid),
> +	};
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_HYP_RESOURCES,
> +			 &req_payload, sizeof(req_payload),
> +			 (void **)&resp, &resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (resp_size < sizeof(*resp) ||
> +		(sizeof(*resp->entries) && (resp->n_entries > U32_MAX / sizeof(*resp->entries))) ||
> +		(resp_size != sizeof(*resp) + (resp->n_entries * sizeof(*resp->entries)))) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	*resources = kmemdup(resp->entries, (resp->n_entries * sizeof(*resp->entries)), GFP_KERNEL);

If *resources is NULL you should return -ENOMEM.

> +	ret = resp->n_entries;
> +
> +out:
> +	kfree(resp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get_hyp_resources);
> +
> +/**
> + * gh_rm_get_vmid() - Retrieve VMID of this virtual machine
> + * @vmid: Filled with the VMID of this VM
> + */
> +int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid)
> +{
> +	static u16 cached_vmid = GH_VMID_INVAL;

This cached VMID seems like a good idea, but you don't actually use it.

> +	void *resp;
> +	size_t resp_size;
> +	int ret;
> +	int payload = 0;

In fact the payload has type __le16 (or at least I assume so).
I don't actually know what this payload represents.  Is it a
VMID (which would I presume in this case be GH_VMID_SELF)?
How big is it, actually?

If you were to define each request and response, I would hope
each would be a packed structure, so in this case:

	struct gh_rm_get_vmid_request {
		__le16 vmid;
		u16 reserved;	/* ??? */
	} __packed;

> +
> +	if (cached_vmid != GH_VMID_INVAL) {
> +		*vmid = cached_vmid;
> +		return 0;
> +	}
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_VM_GET_VMID, &payload, sizeof(payload), &resp, &resp_size);
> +	if (ret)
> +		return ret;
> +
> +	if (resp_size != sizeof(*vmid))
> +		return -EIO;
> +	*vmid = *(u16 *)resp;

This is a bug.  The response is little endian, so you need to do:

	*vmid = le16_to_32(resp);

> +	kfree(resp);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_get_vmid);
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index b4f55c19954b..eb94b48c41de 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -15,4 +15,54 @@
>   /* Gunyah recognizes VMID0 as an alias to the current VM's ID */
>   #define GH_VMID_SELF			0

Please be sure to use this symbol in place of 0 when that's
what you mean.  In gh_rm_get_vmid() it looked like *maybe*
that's what was being passed as an argument in the request
payload--and if so, that's a case I'd like to see GH_VMID_SELF.

					-Alex

>   
> +struct gh_rm_rpc;
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
> +/* RPC Calls */
> +int gh_rm_alloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
> +int gh_rm_dealloc_vmid(struct gh_rm_rpc *rm, u16 vmid);
> +int gh_rm_vm_start(struct gh_rm_rpc *rm, u16 vmid);
> +int gh_rm_vm_stop(struct gh_rm_rpc *rm, u16 vmid);
> +
> +enum gh_rm_vm_auth_mechanism {
> +	GH_RM_VM_AUTH_NONE		= 0,
> +	GH_RM_VM_AUTH_QCOM_PIL_ELF	= 1,
> +	GH_RM_VM_AUTH_QCOM_ANDROID_PVM	= 2,
> +};
> +
> +int gh_rm_vm_configure(struct gh_rm_rpc *rm, u16 vmid, enum gh_rm_vm_auth_mechanism auth_mechanism,
> +			u32 mem_handle, u64 image_offset, u64 image_size,
> +			u64 dtb_offset, u64 dtb_size);
> +int gh_rm_vm_init(struct gh_rm_rpc *rm, u16 vmid);
> +
> +struct gh_rm_hyp_resource {
> +	u8 type;
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
> +ssize_t gh_rm_get_hyp_resources(struct gh_rm_rpc *rm, u16 vmid,
> +				struct gh_rm_hyp_resource **resources);
> +int gh_rm_get_vmid(struct gh_rm_rpc *rm, u16 *vmid);
> +
>   #endif

