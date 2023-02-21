Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403A369DE73
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjBULHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjBULHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:07:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B77E25971
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v3so3901862wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O1e3Vx4V8mQbGHFAPhyICTFHEhdaUxrP+zw0Dso00fc=;
        b=lmjmGXf1NcQuT9X1jvcwZTm/aomvo9/2uaiEb1G9S2o+rbewUXIgbEPSvPbSTdOCXN
         k+29Q7F4JtiUPh0J/Uc1/YXbOoRKIExrmyBok7EOEz1nzG16oWlO/6GdKfVBDVqfuwRk
         h7KsiJzC8YdUMsmyuSi0usDymZHbDfHkqLAb2raLCDnO6CE5v1Vm7hFxcEbcqHsG1g6g
         z69AvpvoQMcuFGY1Oxz6K4J7ZcQH9o8piQIDCq4TJeanX9DO57Gl+6kku7Q8qsYc8sRv
         C97OVcv5YwtntZ2H569vjrh9NieTsxl7LNibjagLL17li4fJZZzwmYRaFmlMo9BlMZSv
         sJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1e3Vx4V8mQbGHFAPhyICTFHEhdaUxrP+zw0Dso00fc=;
        b=EOgkvhDAl5cmKrXRMr8YlUcOfadRK4Hes53k8QYj0wnzIQHc2POICHo+KxwTIfRr8p
         581PSnYvLNJi82gZcBRtS1guzgRs3T6vAE+p3BPSTuxfPkPbIGE2Bs+Q9lKs6rL2tQpC
         itw4zKjgdBTeBpcKUaRwHejbtd0Cmv3mvhW603hQ4k0tWhGv7ZfxdtMkAPUCXdOLd8o4
         oY2QwsnC7e7mCmCUL6E5J5paA9DWeQuO8l93pfpAMUw81Dbhss8dNzStMFDl+F4MvVkY
         Qt32pw4/5n+sUOHnHWbYvFbtcDgVRfeaL5cu6GF8IVsSlAS1ofgtzuhTor9X69hWSYEk
         hvxQ==
X-Gm-Message-State: AO0yUKXufr8/zX0N8QyHFSvDmMtQRIZNLcwBVnQYaKG7DiBvDwo25sup
        Cb5qB2zpi7fC+9LqwbFmyXigAg==
X-Google-Smtp-Source: AK7set/T2qlZ8wjueRjkgqZ0ZGbcdfmitFSt7Fij6ZYh5R28ti+yaOele5L0H2zdTW38qzM//xlWFA==
X-Received: by 2002:adf:f487:0:b0:2c3:f026:907e with SMTP id l7-20020adff487000000b002c3f026907emr3596307wro.10.1676977656443;
        Tue, 21 Feb 2023 03:07:36 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id x4-20020adfdd84000000b002c556a4f1casm3862640wrl.42.2023.02.21.03.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:07:35 -0800 (PST)
Message-ID: <c4be9e0c-8b42-042d-60eb-d735f6d75232@linaro.org>
Date:   Tue, 21 Feb 2023 11:07:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 11/26] gunyah: rsc_mgr: Add RPC for sharing memory
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
 <20230214212405.3314219-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212405.3314219-1-quic_eberman@quicinc.com>
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
> Gunyah resource manager provides API to manipulate stage 2 page tables.
> Manipulations are represented as a memory parcel. Memory parcels
> describe a list of memory regions (intermediate physical address and
> size), a list of new permissions for VMs, and the memory type (DDR or
> MMIO). Memory parcels are uniquely identified by a handle allocated by
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
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/rsc_mgr.h     |  44 +++++++
>   drivers/virt/gunyah/rsc_mgr_rpc.c | 185 ++++++++++++++++++++++++++++++
>   include/linux/gunyah_rsc_mgr.h    |  47 ++++++++
>   3 files changed, 276 insertions(+)
> 
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> index 7406237bc66d..9b23cefe02b0 100644
> --- a/drivers/virt/gunyah/rsc_mgr.h
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -74,6 +74,12 @@ struct gh_rm;
>   int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
>   		void **resp_buf, size_t *resp_buff_size);
>   
> +/* Message IDs: Memory Management */
> +#define GH_RM_RPC_MEM_LEND			0x51000012
> +#define GH_RM_RPC_MEM_SHARE			0x51000013
> +#define GH_RM_RPC_MEM_RECLAIM			0x51000015
> +#define GH_RM_RPC_MEM_APPEND			0x51000018
> +
>   /* Message IDs: VM Management */
>   #define GH_RM_RPC_VM_ALLOC_VMID			0x56000001
>   #define GH_RM_RPC_VM_DEALLOC_VMID		0x56000002
> @@ -90,6 +96,44 @@ struct gh_rm_vm_common_vmid_req {
>   	__le16 reserved0;
>   } __packed;
>   
> +/* Call: MEM_LEND, MEM_SHARE */
> +struct gh_rm_mem_share_req_header {
> +	u8 mem_type;
> +	u8 reserved0;
> +#define GH_MEM_SHARE_REQ_FLAGS_APPEND		BIT(1)
> +	u8 flags;
> +	u8 reserved1;
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
> +	__le16 reserved0;
> +	struct gh_rm_mem_entry entries[];
> +};
> +
> +/* Call: MEM_RELEASE */
> +struct gh_rm_mem_release_req {
> +	__le32 mem_handle;
> +	u8 flags; /* currently not used */
> +	__le16 reserved0;
> +	u8 reserved1;
> +} __packed;
> +
> +/* Call: MEM_APPEND */
> +struct gh_rm_mem_append_req_header {
> +	__le32 mem_handle;
> +#define GH_MEM_APPEND_REQ_FLAGS_END	BIT(0)
> +	u8 flags;
> +	__le16 reserved0;
> +	u8 reserved1;
> +} __packed;
> +
>   /* Call: VM_ALLOC */
>   struct gh_rm_vm_alloc_vmid_resp {
>   	__le16 vmid;
> diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
> index 4515cdd80106..0c83b097fec9 100644
> --- a/drivers/virt/gunyah/rsc_mgr_rpc.c
> +++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
> @@ -7,6 +7,8 @@
>   
>   #include "rsc_mgr.h"
>   
> +#define GH_RM_MAX_MEM_ENTRIES	512
> +
>   /*
>    * Several RM calls take only a VMID as a parameter and give only standard
>    * response back. Deduplicate boilerplate code by using this common call.
> @@ -22,6 +24,189 @@ static int gh_rm_common_vmid_call(struct gh_rm *rm, u32 message_id, u16 vmid)
>   	return gh_rm_call(rm, message_id, &req_payload, sizeof(req_payload), &resp, &resp_size);
>   }
>   
> +static int _gh_rm_mem_append(struct gh_rm *rm, u32 mem_handle, bool end_append,
> +			struct gh_rm_mem_entry *mem_entries, size_t n_mem_entries)
> +{
> +	struct gh_rm_mem_share_req_mem_section *mem_section;
> +	struct gh_rm_mem_append_req_header *req_header;
> +	size_t msg_size = 0, resp_size;
> +	void *msg, *resp;
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
> +
> +	req_header->mem_handle = cpu_to_le32(mem_handle);
> +	if (end_append)
> +		req_header->flags |= GH_MEM_APPEND_REQ_FLAGS_END;
> +
> +	mem_section->n_entries = cpu_to_le16(n_mem_entries);
> +	memcpy(mem_section->entries, mem_entries, sizeof(*mem_entries) * n_mem_entries);
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, &resp, &resp_size);

I have seen this pattern, where we pass &resp eventhough we are not 
expecting a response.

Can we make this explicit by passing NULL. This can also help to find 
any leaks of resp in case they are not freed by the caller.

ret = gh_rm_call(rm, GH_RM_RPC_MEM_APPEND, msg, msg_size, NULL, NULL);

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
> +
> +	/* The format of the message goes:
> +	 * request header
> +	 * ACL entries (which VMs get what kind of access to this memory parcel)
> +	 * Memory entries (list of memory regions to share)
> +	 * Memory attributes (currently unused, we'll hard-code the size to 0)
> +	 */
> +	msg_size += sizeof(struct gh_rm_mem_share_req_header);
> +	msg_size += struct_size(acl_section, entries, p->n_acl_entries);
> +	msg_size += struct_size(mem_section, entries, initial_mem_entries);
> +	msg_size += sizeof(u32); /* for memory attributes, currently unused */
> +
> +	msg = kzalloc(msg_size, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	req_header = msg;
> +	acl_section = (void *)req_header + sizeof(*req_header);
> +	mem_section = (void *)acl_section + struct_size(acl_section, entries, p->n_acl_entries);
> +	attr_section = (void *)mem_section + struct_size(mem_section, entries, initial_mem_entries);
> +
> +	req_header->mem_type = p->mem_type;
> +	if (initial_mem_entries != p->n_mem_entries)
> +		req_header->flags |= GH_MEM_SHARE_REQ_FLAGS_APPEND;
> +	req_header->label = cpu_to_le32(p->label);
> +
> +	acl_section->n_entries = cpu_to_le32(p->n_acl_entries);
> +	memcpy(acl_section->entries, p->acl_entries, sizeof(*(p->acl_entries)) * p->n_acl_entries);
> +
> +	mem_section->n_entries = cpu_to_le16(initial_mem_entries);
> +	memcpy(mem_section->entries, p->mem_entries,
> +		sizeof(*(p->mem_entries)) * initial_mem_entries);
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
> +
> +	if (initial_mem_entries != p->n_mem_entries) {
> +		ret = gh_rm_mem_append(rm, p->mem_handle,
> +					&p->mem_entries[initial_mem_entries],
> +					p->n_mem_entries - initial_mem_entries);
> +		if (ret) {
> +			gh_rm_mem_reclaim(rm, p);
> +			p->mem_handle = GH_MEM_HANDLE_INVAL;
> +		}
> +	}
> +
> +	kfree(resp);
> +	return ret;
> +}
> +
> +/**
> + * gh_rm_mem_lend() - Lend memory to other virtual machines.
> + * @rm: Handle to a Gunyah resource manager
> + * @parcel: Package the memory information of the memory to be lent.
> + *
> + * Lending removes Linux's access to the memory while the memory parcel is lent.
> + */
> +int gh_rm_mem_lend(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
> +{
> +	return gh_rm_mem_lend_common(rm, GH_RM_RPC_MEM_LEND, parcel);
> +}
> +
> +
> +/**
> + * gh_rm_mem_share() - Share memory with other virtual machines.
> + * @rm: Handle to a Gunyah resource manager
> + * @parcel: Package the memory information of the memory to be shared.
> + *
> + * Sharing keeps Linux's access to the memory while the memory parcel is shared.
> + */
> +int gh_rm_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
> +{
> +	return gh_rm_mem_lend_common(rm, GH_RM_RPC_MEM_SHARE, parcel);
> +}
> +
> +/**
> + * gh_rm_mem_reclaim() - Reclaim a memory parcel
> + * @rm: Handle to a Gunyah resource manager
> + * @parcel: Package the memory information of the memory to be reclaimed.
> + *
> + * RM maps the associated memory back into the stage-2 page tables of the owner VM.
> + */
> +int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel)
> +{
> +	struct gh_rm_mem_release_req req = {
> +		.mem_handle = cpu_to_le32(parcel->mem_handle),
> +	};
> +	size_t resp_size;
> +	void *resp;
> +	int ret;
> +
> +	ret = gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), &resp, &resp_size);
> +	/* Do not call platform mem reclaim hooks: the reclaim didn't happen*/
> +	if (ret)
> +		return ret;
> +
how about

return gh_rm_call(rm, GH_RM_RPC_MEM_RECLAIM, &req, sizeof(req), &resp, 
&resp_size);


> +	return ret;
> +}
> +
>   /**
>    * gh_rm_alloc_vmid() - Allocate a new VM in Gunyah. Returns the VM identifier.
>    * @rm: Handle to a Gunyah resource manager
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> index e7bd29f8be6e..2d8b8b6cc394 100644
> --- a/include/linux/gunyah_rsc_mgr.h
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -11,6 +11,7 @@
>   #include <linux/gunyah.h>
>   
>   #define GH_VMID_INVAL	U16_MAX
> +#define GH_MEM_HANDLE_INVAL	U32_MAX
>   
>   /* Gunyah recognizes VMID0 as an alias to the current VM's ID */
>   #define GH_VMID_SELF			0
> @@ -54,7 +55,53 @@ struct gh_rm_vm_status_payload {
>   
>   #define GH_RM_NOTIFICATION_VM_STATUS		 0x56100008
>   
> +struct gh_rm_mem_acl_entry {
> +	__le16 vmid;
> +#define GH_RM_ACL_X		BIT(0)
> +#define GH_RM_ACL_W		BIT(1)
> +#define GH_RM_ACL_R		BIT(2)
> +	u8 perms;
> +	u8 reserved;
> +} __packed;
> +
> +struct gh_rm_mem_entry {
> +	__le64 ipa_base;
> +	__le64 size;
> +} __packed;
> +
> +enum gh_rm_mem_type {
> +	GH_RM_MEM_TYPE_NORMAL	= 0,
> +	GH_RM_MEM_TYPE_IO	= 1,
> +};
> +
> +/*
> + * struct gh_rm_mem_parcel - Package info about memory to be lent/shared/donated/reclaimed
> + * @mem_type: The type of memory: normal (DDR) or IO
> + * @label: An client-specified identifier which can be used by the other VMs to identify the purpose
> + *         of the memory parcel.
> + * @acl_entries: An array of access control entries. Each entry specifies a VM and what access
> + *               is allowed for the memory parcel.
> + * @n_acl_entries: Count of the number of entries in the `acl_entries` array.
> + * @mem_entries: An list of regions to be associated with the memory parcel. Addresses should be
> + *               (intermediate) physical addresses from Linux's perspective.
> + * @n_mem_entries: Count of the number of entries in the `mem_entries` array.
> + * @mem_handle: On success, filled with memory handle that RM allocates for this memory parcel
> + */
> +struct gh_rm_mem_parcel {
> +	enum gh_rm_mem_type mem_type;
> +	u32 label;
> +	size_t n_acl_entries;
> +	struct gh_rm_mem_acl_entry *acl_entries;
> +	size_t n_mem_entries;
> +	struct gh_rm_mem_entry *mem_entries;
> +	u32 mem_handle;
> +};
> +
>   /* RPC Calls */
> +int gh_rm_mem_lend(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
> +int gh_rm_mem_share(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
> +int gh_rm_mem_reclaim(struct gh_rm *rm, struct gh_rm_mem_parcel *parcel);
> +
>   int gh_rm_alloc_vmid(struct gh_rm *rm, u16 vmid);
>   int gh_rm_dealloc_vmid(struct gh_rm *rm, u16 vmid);
>   int gh_rm_vm_reset(struct gh_rm *rm, u16 vmid);
