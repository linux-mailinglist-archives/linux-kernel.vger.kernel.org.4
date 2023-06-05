Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F3D723030
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjFETtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjFETtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:49:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0A115
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:48:31 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-777b0dd72d8so57609039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994491; x=1688586491;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X7Oy4wT5uBiOM9SDBBBvUHVuySMbuXLAoCMDXwzYWgU=;
        b=jZAUrNOgEabzabyZSP4DK+YpdOo7L9fkdXOy+agEikDZwOIw/ThE5rT9Td+XDGfyGe
         Q2mglTX7ARfqJac1v1o7VwxpdUEpUCxYV+ezqD+O7ajnuIRgX5WvftSwXU5OVbC2ofFw
         i7hFwnLaWHgyf+y4ve9ckFG+RMrtjTPcd/txzU5M82ntsIw0ZpgTGot+ezAnUpDrWLzd
         iXEsIPjxC7IgAad6DdURzCxs9/eUF1ONJAw8KVofp8dMPliVKV6drrEcVQx0GvD0qVrZ
         bcNJhe3ynyZCPiaOPEswIufpsWZ1B4wh4JwXR2Ifmofo9gj6OOJNZB1vzzltqjIK8MD/
         bGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994491; x=1688586491;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7Oy4wT5uBiOM9SDBBBvUHVuySMbuXLAoCMDXwzYWgU=;
        b=FPzkFA1pi7Yk/HG/iHOgwAKN2Dfss9DXbDigFSKS72HHoWnFrjCx7AfQ4c9U3+oNb2
         iXLJRqLp43dPZbGpFW67key4CXz3CUUa7pkCRH2w11hC5bizjatFZoCSJSHVzZsbHyw9
         X8zyo2eiKI9x6qJVz4tSNhZ8xOIe5jLT6GPi8cmC0vwprTnDSKPHPh/ZVLwv9WglGmkL
         wb/WCWWP2/NeEKf2utu+BLE2Af1W2qXr6UHvOS1keq4+DBMjT2ANBlkfl2UgNZWElrJD
         UN1ukZsiD3uy3xs70Az+vPhKLrlsSNLHQ3y6eWF2k8ZDvMQeX7W1Oe/8yZn2xKo4ai8B
         +Btg==
X-Gm-Message-State: AC+VfDy3KmuA3YBhLuVeKUAyeB3m68j+aODRI6nje6m/hoB5Rv9iycW9
        ZHVrW6/DQX58BuH/jN3lPAelWQ==
X-Google-Smtp-Source: ACHHUZ49Kq5emfknzZKLYVE3fCeZHZLOQY091mklNjKZfyYvGYu/wTVNlPdSP5wsvKPtF6NwX36wtg==
X-Received: by 2002:a6b:6102:0:b0:774:9116:3836 with SMTP id v2-20020a6b6102000000b0077491163836mr160414iob.13.1685994491337;
        Mon, 05 Jun 2023 12:48:11 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id ee21-20020a056638293500b004186badba5esm2350462jab.36.2023.06.05.12.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:48:10 -0700 (PDT)
Message-ID: <9747a71d-c6d0-b67b-a3b1-c84848268f46@linaro.org>
Date:   Mon, 5 Jun 2023 14:48:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 09/24] gunyah: rsc_mgr: Add RPC for sharing memory
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
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-10-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-10-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Gunyah resource manager provides API to manipulate stage 2 page tables.
> Manipulations are represented as a memory parcel. Memory parcels

Not a huge deal, but maybe:
   The Gunyah resource manager provides an API for manipulating stage 2
   page tables.  The API uses "memory parcels" to represent regions of
   memory affected by API calls.

> describe a list of memory regions (intermediate physical address and

...(intermediate physical address--IPA--and size)...

> size), a list of new permissions for VMs, and the memory type (DDR or
> MMIO). Memory parcels are uniquely identified by a handle allocated by

s/Memory parcels are/Each memory parcel is/

Also, as I recall, a memory parcel is contiguous memory in
the guest address space.  If that's true, it might be worth
mentioning (here and/or in the code).

> Gunyah. There are a few types of memory parcel sharing which Gunyah
> supports:
> 
>   - Sharing: the guest and host VM both have access
>   - Lending: only the guest has access; host VM loses access
>   - Donating: Permanently lent (not reclaimed even if guest shuts down)
> 
> Memory parcels that have been shared or lent can be reclaimed by the
> host via an additional call. The reclaim operation restores the original
> access the host VM had to the memory parcel and removes the access to
> other VM.
> 
> One point to note that memory parcels don't describe where in the guest
> VM the memory parcel should reside. The guest VM must accept the memory
> parcel either explicitly via a "gh_rm_mem_accept" call (not introduced
> here) or be configured to accept it automatically at boot. As the guest
> VM accepts the memory parcel, it also mentions the IPA it wants to place
> memory parcel.

I have quite a few small comments and questions.  Some of the
questions arise because I haven't done a very deep review this
time, so I might just be missing or forgetting bits of the
bigger picture.

My feedback is down to nits though, for the most part.  Consider
what I say, but even if you ignore much of it:

Reviewed-by: Alex Elder <elder@linaro.org>

> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/rsc_mgr_rpc.c | 227 ++++++++++++++++++++++++++++++
>   include/linux/gunyah_rsc_mgr.h    |  48 +++++++
>   2 files changed, 275 insertions(+)
> 
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> index a4a9f0ba4e1f..4f25f07400b3 100644
> --- a/drivers/virt/gunyah/rsc_mgr_rpc.c
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -6,6 +6,12 @@
>   #include <linux/gunyah_rsc_mgr.h>
>   #include "rsc_mgr.h"
>   
> +/* Message IDs: Memory Management */
> +#define GH_RM_RPC_MEM_LEND			0x51000012
> +#define GH_RM_RPC_MEM_SHARE			0x51000013
> +#define GH_RM_RPC_MEM_RECLAIM			0x51000015
> +#define GH_RM_RPC_MEM_APPEND			0x51000018

These definitions seem to be permanent, unchanging, definitional
values for the Gunyah RM API.  It seems like they could reside
in a file that reinforces that--like "gh_rm_api.h" or something.

That said, nobody else will be using these, so I guess defining
it here makes sense.

> +
>   /* Message IDs: VM Management */
>   #define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
>   #define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
> @@ -22,6 +28,46 @@ struct gh_rm_vm_common_vmid_req {
>   	__le16 _padding;
>   } __packed;
>   
> +/* Call: MEM_LEND, MEM_SHARE */
> +#define GH_MEM_SHARE_REQ_FLAGS_APPEND		BIT(1)
> +
> +struct gh_rm_mem_share_req_header {
> +	u8 mem_type;
> +	u8 _padding0;
> +	u8 flags;
> +	u8 _padding1;
> +	__le32 label;
> +} __packed;
> +
> +struct gh_rm_mem_share_req_acl_section {
> +	__le32 n_entries;
> +	struct gh_rm_mem_acl_entry entries[];
> +};
> +
> +struct gh_rm_mem_share_req_mem_section {
> +	__le16 n_entries;
> +	__le16 _padding;
> +	struct gh_rm_mem_entry entries[];
> +};
> +
> +/* Call: MEM_RELEASE */
> +struct gh_rm_mem_release_req {
> +	__le32 mem_handle;
> +	u8 flags; /* currently not used */
> +	u8 _padding0;
> +	__le16 _padding1;
> +} __packed;
> +
> +/* Call: MEM_APPEND */
> +#define GH_MEM_APPEND_REQ_FLAGS_END		BIT(0)
> +
> +struct gh_rm_mem_append_req_header {
> +	__le32 mem_handle;
> +	u8 flags;
> +	u8 _padding0;
> +	__le16 _padding1;
> +} __packed;
> +
>   /* Call: VM_ALLOC */
>   struct gh_rm_vm_alloc_vmid_resp {
>   	__le16 vmid;
> @@ -51,6 +97,8 @@ struct gh_rm_vm_config_image_req {
>   	__le64 dtb_size;
>   } __packed;
>   
> +#define GH_RM_MAX_MEM_ENTRIES	512
> +
>   /*
>    * Several RM calls take only a VMID as a parameter and give only standard
>    * response back. Deduplicate boilerplate code by using this common call.
> @@ -64,6 +112,185 @@ static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
>   	return gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), NULL, NULL);
>   }
>   
> +static int _gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle, bool end_append,
> +			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
> +{
> +	struct gh_rm_mem_share_req_mem_section *mem_section;
> +	struct gh_rm_mem_append_req_header *req_header;
> +	size_t msg_size = 0;
> +	void *msg;
> +	int ret;
> +
> +	msg_size += sizeof(struct gh_rm_mem_append_req_header);
> +	msg_size += struct_size(mem_section, entries, n_mem_entries);
> +
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	req_header = msg;
> +	mem_section = (void *)req_header + sizeof(struct gh_rm_mem_append_req_header);

You could use req_header + 1.  Even if not, use sizeof(*req_header).

> +
> +	req_header->mem_handle = cpu_to_le32(mem_handle);
> +	if (end_append)
> +		req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
> +
> +	mem_section->n_entries = cpu_to_le16(n_mem_entries);
> +	memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * n_mem_entries);
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, NULL, NULL);
> +	kfree(msg);
> +
> +	return ret;
> +}
> +
> +static int gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle,
> +			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
> +{
> +	bool end_append;
> +	int ret = 0;
> +	size_t n;
> +
> +	while (n_mem_entries) {
> +		if (n_mem_entries > GH_RM_MAX_MEM_ENTRIES) {
> +			end_append = false;
> +			n = GH_RM_MAX_MEM_ENTRIES;
> +		} else {
> +			end_append = true;
> +			n = n_mem_entries;
> +		}
> +
> +		ret = _gh_rm_mem_append(rm, mem_handle, end_append, mem_entries, n);
> +		if (ret)
> +			break;
> +
> +		mem_entries += n;
> +		n_mem_entries -= n;
> +	}
> +
> +	return ret;
> +}
> +
> +static int gh_rm_mem_lend_common(struct gh_rm *rm, u32 message_id, struct gh_rm_mem_parcel *p)
> +{
> +	size_t msg_size = 0, initial_mem_entries = p->n_mem_entries, resp_size;
> +	size_t acl_section_size, mem_section_size;
> +	struct gh_rm_mem_share_req_acl_section *acl_section;
> +	struct gh_rm_mem_share_req_mem_section *mem_section;
> +	struct gh_rm_mem_share_req_header *req_header;
> +	u32 *attr_section;
> +	__le32 *resp;
> +	void *msg;
> +	int ret;
> +
> +	if (!p->acl_entries || !p->n_acl_entries || !p->mem_entries || !p->n_mem_entries ||
> +	    p->n_acl_entries > U8_MAX || p->mem_handle != GH_MEM_HANDLE_INVAL)
> +		return -EINVAL;
> +
> +	if (initial_mem_entries > GH_RM_MAX_MEM_ENTRIES)
> +		initial_mem_entries = GH_RM_MAX_MEM_ENTRIES;

Is it OK to truncate the number of entries silently?

> +
> +	acl_section_size = struct_size(acl_section, entries, p->n_acl_entries);

Is there a limit on the number of ACL entries (as there is for
the number of mem entries).

> +	mem_section_size = struct_size(mem_section, entries, initial_mem_entries);
> +	/* The format of the message goes:
> +	 * request header
> +	 * ACL entries (which VMs get what kind of access to this memory parcel)
> +	 * Memory entries (list of memory regions to share)
> +	 * Memory attributes (currently unused, we'll hard-code the size to 0)
> +	 */
> +	msg_size += sizeof(struct gh_rm_mem_share_req_header);
> +	msg_size += acl_section_size;
> +	msg_size += mem_section_size;
> +	msg_size += sizeof(u32); /* for memory attributes, currently unused */
> +
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	req_header = msg;
> +	acl_section = (void *)req_header + sizeof(*req_header);
> +	mem_section = (void *)acl_section + acl_section_size;
> +	attr_section = (void *)mem_section + mem_section_size;
> +
> +	req_header->mem_type = p->mem_type;
> +	if (initial_mem_entries != p->n_mem_entries)
> +		req_header->flags |= GH_MEM_SHARE_REQ_FLAGS_APPEND;
> +	req_header->label = cpu_to_le32(p->label);
> +
> +	acl_section->n_entries = cpu_to_le32(p->n_acl_entries);
> +	memcpy(acl_section->entries, p->acl_entries,
> +		flex_array_size(acl_section, entries, p->n_acl_entries));
> +
> +	mem_section->n_entries = cpu_to_le16(initial_mem_entries);
> +	memcpy(mem_section->entries, p->mem_entries,
> +		flex_array_size(mem_section, entries, initial_mem_entries));
> +
> +	/* Set n_entries for memory attribute section to 0 */
> +	*attr_section = 0;
> +
> +	ret = gh_rm_call(rm, message_id, msg, msg_size, (void **)&resp, &resp_size);
> +	kfree(msg);
> +
> +	if (ret)
> +		return ret;
> +
> +	p->mem_handle = le32_to_cpu(*resp);
> +	kfree(resp);
> +
> +	if (initial_mem_entries != p->n_mem_entries) {
> +		ret = gh_rm_mem_append(rm, p->mem_handle,
> +					&p->mem_entries[initial_mem_entries],
> +					p->n_mem_entries - initial_mem_entries);

Will there always be at most one gh_rm_mem_append() call?

> +		if (ret) {
> +			gh_rm_mem_reclaim(rm, p);
> +			p->mem_handle = GH_MEM_HANDLE_INVAL;
> +		}
> +	}
> +
> +	return ret;
> +}

. . .

