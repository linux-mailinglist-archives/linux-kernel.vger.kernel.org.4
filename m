Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4C69D28F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjBTSKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBTSKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:10:36 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47D21ABC3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:10:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p26so1543329wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GlS6iRAPGewPPTLsqOHq1XDB6gJgmlrzwf0UNpx6Qs=;
        b=qoNzJzfW3af4kC20aBc+Dn1KV4n9Ak2AsXgNUJALX227vUqBGkyYHmr/fAn52hl6dz
         SB+UT0P0qTg+DFUe+kU7v2U1WgSNcEuYSw4HCU+f2rJccslH06HCWbPhbTqsjCRYIgj0
         VttNk42mLehiHDs4Bs42NirXKglhm/Q3QvrT9BK+9WtPPCk3CFTPlhlAzaO6rI35noHU
         ctgsQYgYocW/71V1uyVEvV8khW8Qm27XMPma6czqnvMyX0/AetFE/vtApTxLpNuk0WO5
         /ihyqkOFHKC5jsAAJxdlAYWrpQGPWrsB/9hzUGq18TIMqzB8RI+NdC2j6qido5lzA5Mz
         X1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GlS6iRAPGewPPTLsqOHq1XDB6gJgmlrzwf0UNpx6Qs=;
        b=wa/p9Fjt5NnvoFOlwA1jpHfenju+qBut2dRa5R4yRJBGo6ilUh2IgZUNpEsMN3pTqA
         3cnxFp3+bGeD9kssIPLikAPEdDddCZhhZyL3v11Wb3dLEqs9zKE7A2en1XvqQ6FvaoLP
         THyIg/3mSBb9GUBYzOYd9DWfTyfb9gJF8JQj75lt3hQ7aK//r0/RaxP1kod71kbdD92K
         wobAiXwv+mV//PplqjyCRZ8w5sT0sJIjMeSbrM972TPVz2fw0fTxUdNllP40nluK5XRC
         F9sVWlzu0rfZQRNJ3CMymy9Y6wl72CEgAN6Y3xrVBnH6ZLHE8nQC2/a5oxsZTmXQMxh6
         ttbQ==
X-Gm-Message-State: AO0yUKWAqCBdSYj3IRuczXe5Kna3UnTCntvAYamaOwnAPFb909MDezLo
        YXFijNKOyn3W14ofGmjvJj9r9g==
X-Google-Smtp-Source: AK7set+EQ05Wv4rLLHeXmtOVn71t0uDBFVHe0aAlPsuL7fwM5sxNpbhWEeO2m/hB4m29WNWCcmPyAg==
X-Received: by 2002:a05:600c:2ed2:b0:3df:eda1:43b9 with SMTP id q18-20020a05600c2ed200b003dfeda143b9mr907889wmn.4.1676916631143;
        Mon, 20 Feb 2023 10:10:31 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i21-20020a1c5415000000b003e208cec49bsm2116531wmb.3.2023.02.20.10.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 10:10:30 -0800 (PST)
Message-ID: <d69f9699-b4d9-7a3a-71b1-7e6fe72c4f82@linaro.org>
Date:   Mon, 20 Feb 2023 18:10:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
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
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230214212327.3310128-1-quic_eberman@quicinc.com>
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
> The resource manager is a special virtual machine which is always
> running on a Gunyah system. It provides APIs for creating and destroying
> VMs, secure memory management, sharing/lending of memory between VMs,
> and setup of inter-VM communication. Calls to the resource manager are
> made via message queues.
> 
> This patch implements the basic probing and RPC mechanism to make those
> API calls. Request/response calls can be made with gh_rm_call.
> Drivers can also register to notifications pushed by RM via
> gh_rm_register_notifier
> 
> Specific API calls that resource manager supports will be implemented in
> subsequent patches.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   drivers/virt/gunyah/Makefile   |   3 +
>   drivers/virt/gunyah/rsc_mgr.c  | 604 +++++++++++++++++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h  |  77 +++++
>   include/linux/gunyah_rsc_mgr.h |  24 ++
>   4 files changed, 708 insertions(+)
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>   create mode 100644 include/linux/gunyah_rsc_mgr.h
> 
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 34f32110faf9..cc864ff5abbb 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,3 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_GUNYAH) += gunyah.o
> +
> +gunyah_rsc_mgr-y += rsc_mgr.o
> +obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> new file mode 100644
> index 000000000000..2a47139873a8
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -0,0 +1,604 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/sched.h>
> +#include <linux/gunyah.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/kthread.h>
why do we need this?

> +#include <linux/notifier.h>
> +#include <linux/workqueue.h>
> +#include <linux/completion.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/platform_device.h>
> +
> +#include "rsc_mgr.h"
> +

...

> +struct gh_rm {
> +	struct device *dev;
> +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
> +	struct gh_msgq msgq;
> +	struct mbox_client msgq_client;
> +	struct gh_rm_connection *active_rx_connection;
> +	int last_tx_ret;
> +

> +	struct idr call_idr;
> +	struct mutex call_idr_lock;

IDR interface is deprecated you should use Xarrays instead here,

Other good thing about Xarrays is that you need not worry about locking 
it uses RCU and internal spinlock, that should simiply code a bit here.

more info at
Documentation/core-api/xarray.rst

> +
> +	struct kmem_cache *cache;
> +	struct mutex send_lock;
> +	struct blocking_notifier_head nh;
> +};
> +
> +static struct gh_rm_connection *gh_rm_alloc_connection(__le32 msg_id, u8 type)
> +{
> +	struct gh_rm_connection *connection;
> +
> +	connection = kzalloc(sizeof(*connection), GFP_KERNEL);
> +	if (!connection)
> +		return ERR_PTR(-ENOMEM);
> +
> +	connection->type = type;
> +	connection->msg_id = msg_id;
> +
> +	return connection;
> +}
> +
> +static int gh_rm_init_connection_payload(struct gh_rm_connection *connection, void *msg,
> +					size_t hdr_size, size_t msg_size)
> +{
> +	size_t max_buf_size, payload_size;
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +
> +	if (hdr_size > msg_size)
> +		return -EINVAL;
> +
> +	payload_size = msg_size - hdr_size;
> +
> +	connection->num_fragments = FIELD_GET(RM_RPC_FRAGMENTS_MASK, hdr->type);
> +	connection->fragments_received = 0;
> +
> +	/* There's not going to be any payload, no need to allocate buffer. */
> +	if (!payload_size && !connection->num_fragments)
> +		return 0;
> +
> +	if (connection->num_fragments > GH_RM_MAX_NUM_FRAGMENTS)
> +		return -EINVAL;
> +
> +	max_buf_size = payload_size + (connection->num_fragments * GH_RM_MAX_MSG_SIZE);
> +
> +	connection->payload = kzalloc(max_buf_size, GFP_KERNEL);
> +	if (!connection->payload)
> +		return -ENOMEM;
> +
> +	memcpy(connection->payload, msg + hdr_size, payload_size);
> +	connection->size = payload_size;
> +	return 0;
> +}
> +
> +static void gh_rm_notif_work(struct work_struct *work)
> +{
> +	struct gh_rm_connection *connection = container_of(work, struct gh_rm_connection,
> +								notification.work);
> +	struct gh_rm *rm = connection->notification.rm;
> +
> +	blocking_notifier_call_chain(&rm->nh, connection->msg_id, connection->payload);
> +
> +	put_gh_rm(rm);
> +	kfree(connection->payload);
if (connection->size)
	kfree(connection->payload);

should we check for payload size before freeing this, Normally kfree 
NULL should be safe, unless connection object is allocated uninitialized.

> +	kfree(connection);
> +}
> +
> +static struct gh_rm_connection *gh_rm_process_notif(struct gh_rm *rm, void *msg, size_t msg_size)
> +{
> +	struct gh_rm_connection *connection;
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +	int ret;
> +
> +	connection = gh_rm_alloc_connection(hdr->msg_id, RM_RPC_TYPE_NOTIF);
> +	if (IS_ERR(connection)) {
> +		dev_err(rm->dev, "Failed to alloc connection for notification: %ld, dropping.\n",
> +			PTR_ERR(connection));
> +		return NULL;
> +	}
> +
> +	get_gh_rm(rm);
> +	connection->notification.rm = rm;
> +	INIT_WORK(&connection->notification.work, gh_rm_notif_work);
> +
> +	ret = gh_rm_init_connection_payload(connection, msg, sizeof(*hdr), msg_size);
> +	if (ret) {
> +		dev_err(rm->dev, "Failed to initialize connection buffer for notification: %d\n",
> +			ret);
put_gh_rm(rm);

is missing.
or move the get and other lines after this check

> +		kfree(connection);
> +		return NULL;
> +	}
> +
> +	return connection;
> +}
> +

> +static int gh_rm_send_request(struct gh_rm *rm, u32 message_id,
> +			      const void *req_buff, size_t req_buff_size,
> +			      struct gh_rm_connection *connection)
> +{
> +	u8 msg_type = FIELD_PREP(RM_RPC_TYPE_MASK, RM_RPC_TYPE_REQUEST);
> +	size_t buff_size_remaining = req_buff_size;
> +	const void *req_buff_curr = req_buff;
> +	struct gh_msgq_tx_data *msg;
> +	struct gh_rm_rpc_hdr *hdr;
> +	u32 cont_fragments = 0;
> +	size_t payload_size;
> +	void *payload;
> +	int ret;
> +
> +	if (req_buff_size)
> +		cont_fragments = (req_buff_size - 1) / GH_RM_MAX_MSG_SIZE;
> +
> +	if (req_buff_size > GH_RM_MAX_NUM_FRAGMENTS * GH_RM_MAX_MSG_SIZE) {
> +		pr_warn("Limit exceeded for the number of fragments: %u\n", cont_fragments);
> +		dump_stack();
> +		return -E2BIG;
> +	}
> +
> +	ret = mutex_lock_interruptible(&rm->send_lock);
> +	if (ret)
> +		return ret;
> +
> +	/* Consider also the 'request' packet for the loop count */
> +	do {
> +		msg = kmem_cache_zalloc(rm->cache, GFP_KERNEL);
> +		if (!msg) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* Fill header */
> +		hdr = (struct gh_rm_rpc_hdr *)msg->data;
> +		hdr->api = RM_RPC_API;
> +		hdr->type = msg_type | FIELD_PREP(RM_RPC_FRAGMENTS_MASK, cont_fragments);
> +		hdr->seq = cpu_to_le16(connection->reply.seq);
> +		hdr->msg_id = cpu_to_le32(message_id);
> +
> +		/* Copy payload */
> +		payload = hdr + 1;
> +		payload_size = min(buff_size_remaining, GH_RM_MAX_MSG_SIZE);
> +		memcpy(payload, req_buff_curr, payload_size);
> +		req_buff_curr += payload_size;
> +		buff_size_remaining -= payload_size;
> +
> +		/* Force the last fragment to immediately alert the receiver */
> +		msg->push = !buff_size_remaining;
> +		msg->length = sizeof(*hdr) + payload_size;
> +
> +		ret = mbox_send_message(gh_msgq_chan(&rm->msgq), msg);
> +		if (ret < 0) {
> +			kmem_cache_free(rm->cache, msg);
> +			break;
> +		}
> +
> +		if (rm->last_tx_ret) {
> +			ret = rm->last_tx_ret;
> +			break;
> +		}
> +
> +		msg_type = FIELD_PREP(RM_RPC_TYPE_MASK, RM_RPC_TYPE_CONTINUATION);
> +	} while (buff_size_remaining);
> +
> +out:
> +	mutex_unlock(&rm->send_lock);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +/**
> + * gh_rm_call: Achieve request-response type communication with RPC
> + * @rm: Pointer to Gunyah resource manager internal data
> + * @message_id: The RM RPC message-id
> + * @req_buff: Request buffer that contains the payload
> + * @req_buff_size: Total size of the payload
> + * @resp_buf: Pointer to a response buffer
> + * @resp_buff_size: Size of the response buffer
> + *
> + * Make a request to the RM-VM and wait for reply back. For a successful
> + * response, the function returns the payload. The size of the payload is set in
> + * resp_buff_size. The resp_buf should be freed by the caller.
> + *
> + * req_buff should be not NULL for req_buff_size >0. If req_buff_size == 0,
> + * req_buff *can* be NULL and no additional payload is sent.
> + *
> + * Context: Process context. Will sleep waiting for reply.
> + * Return: 0 on success. <0 if error.
> + */
> +int gh_rm_call(struct gh_rm *rm, u32 message_id, void *req_buff, size_t req_buff_size,
> +		void **resp_buf, size_t *resp_buff_size)
> +{
> +	struct gh_rm_connection *connection;
> +	int ret;
> +
> +	/* message_id 0 is reserved. req_buff_size implies req_buf is not NULL */
> +	if (!message_id || (!req_buff && req_buff_size) || !rm)
> +		return -EINVAL;
> +
> +	connection = gh_rm_alloc_connection(cpu_to_le32(message_id), RM_RPC_TYPE_REPLY);
> +	if (IS_ERR(connection))
> +		return PTR_ERR(connection);
> +
> +	init_completion(&connection->reply.seq_done);
> +
> +	/* Allocate a new seq number for this connection */
> +	mutex_lock(&rm->call_idr_lock);
> +	ret = idr_alloc_cyclic(&rm->call_idr, connection, 0, U16_MAX,
> +						GFP_KERNEL);
> +	mutex_unlock(&rm->call_idr_lock);
> +	if (ret < 0)
> +		goto out;

new line.

> +	connection->reply.seq = ret;
> +
> +	/* Send the request to the Resource Manager */
> +	ret = gh_rm_send_request(rm, message_id, req_buff, req_buff_size, connection);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Wait for response */
> +	ret = wait_for_completion_interruptible(&connection->reply.seq_done);
> +	if (ret)
> +		goto out;
> +
> +	/* Check for internal (kernel) error waiting for the response */
> +	if (connection->reply.ret) {
> +		ret = connection->reply.ret;
> +		if (ret != -ENOMEM)
> +			kfree(connection->payload);
> +		goto out;
> +	}
> +
> +	/* Got a response, did resource manager give us an error? */
> +	if (connection->reply.rm_error != GH_RM_ERROR_OK) {
> +		pr_warn("RM rejected message %08x. Error: %d\n", message_id,
> +			connection->reply.rm_error);
> +		dump_stack();
> +		ret = gh_rm_remap_error(connection->reply.rm_error);
> +		kfree(connection->payload);
> +		goto out;
> +	}
> +
> +	/* Everything looks good, return the payload */
> +	*resp_buff_size = connection->size;
> +	if (connection->size)
> +		*resp_buf = connection->payload;
> +	else {
> +		/* kfree in case RM sent us multiple fragments but never any data in
> +		 * those fragments. We would've allocated memory for it, but connection->size == 0
> +		 */
> +		kfree(connection->payload);
> +	}
> +
> +out:
> +	mutex_lock(&rm->call_idr_lock);
> +	idr_remove(&rm->call_idr, connection->reply.seq);
> +	mutex_unlock(&rm->call_idr_lock);
> +	kfree(connection);
> +	return ret;
> +}
> +
> +
> +int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&rm->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
> +
> +int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&rm->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_notifier_unregister);
> +
> +void get_gh_rm(struct gh_rm *rm)
> +{
> +	get_device(rm->dev);
> +}
> +EXPORT_SYMBOL_GPL(get_gh_rm);

Can we have some consistency in the exported symbol naming,
we have two combinations now.

EXPORT_SYMBOL_GPL(gh_rm_notifier_register);
EXPORT_SYMBOL_GPL(get_gh_rm);

lets stick to one.
> +
> +void put_gh_rm(struct gh_rm *rm)
> +{
> +	put_device(rm->dev);
> +}
> +EXPORT_SYMBOL_GPL(put_gh_rm);
> 
...

> +
> +static int gh_rm_drv_probe(struct platform_device *pdev)
> +{
> +	struct gh_msgq_tx_data *msg;
> +	struct gh_rm *rm;
> +	int ret;
> +
How are we ensuring that gunyah driver is probed before this driver?


> +	rm = devm_kzalloc(&pdev->dev, sizeof(*rm), GFP_KERNEL);
> +	if (!rm)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, rm);
> +	rm->dev = &pdev->dev;
> +
> +	mutex_init(&rm->call_idr_lock);
> +	idr_init(&rm->call_idr);
> +	rm->cache = kmem_cache_create("gh_rm", struct_size(msg, data, GH_MSGQ_MAX_MSG_SIZE), 0,
> +		SLAB_HWCACHE_ALIGN, NULL);
> +	if (!rm->cache)
> +		return -ENOMEM;
new line here would be nice.

> +	mutex_init(&rm->send_lock);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&rm->nh);
> +
> +	ret = gh_msgq_platform_probe_direction(pdev, true, 0, &rm->tx_ghrsc);
> +	if (ret)
> +		goto err_cache;
> +
> +	ret = gh_msgq_platform_probe_direction(pdev, false, 1, &rm->rx_ghrsc);
> +	if (ret)
> +		goto err_cache;
> +
> +	rm->msgq_client.dev = &pdev->dev;
> +	rm->msgq_client.tx_block = true;
> +	rm->msgq_client.rx_callback = gh_rm_msgq_rx_data;
> +	rm->msgq_client.tx_done = gh_rm_msgq_tx_done;
> +
> +	return gh_msgq_init(&pdev->dev, &rm->msgq, &rm->msgq_client, &rm->tx_ghrsc, &rm->rx_ghrsc);
> +err_cache:
> +	kmem_cache_destroy(rm->cache);
> +	return ret;
> +}
> +
> +static int gh_rm_drv_remove(struct platform_device *pdev)
> +{
> +	struct gh_rm *rm = platform_get_drvdata(pdev);
> +
> +	mbox_free_channel(gh_msgq_chan(&rm->msgq));
> +	gh_msgq_remove(&rm->msgq);
> +	kmem_cache_destroy(rm->cache);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gh_rm_of_match[] = {
> +	{ .compatible = "gunyah-resource-manager" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, gh_rm_of_match);
> +
> +static struct platform_driver gh_rm_driver = {
> +	.probe = gh_rm_drv_probe,
> +	.remove = gh_rm_drv_remove,
> +	.driver = {
> +		.name = "gh_rsc_mgr",
> +		.of_match_table = gh_rm_of_match,
> +	},
> +};
> +module_platform_driver(gh_rm_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Resource Manager Driver");
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> new file mode 100644
> index 000000000000..d4e799a7526f
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef __GH_RSC_MGR_PRIV_H
> +#define __GH_RSC_MGR_PRIV_H
> +
> +#include <linux/gunyah.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/types.h>
> +
<------------------
> +/* RM Error codes */
> +enum gh_rm_error {
> +	GH_RM_ERROR_OK			= 0x0,
> +	GH_RM_ERROR_UNIMPLEMENTED	= 0xFFFFFFFF,
> +	GH_RM_ERROR_NOMEM		= 0x1,
> +	GH_RM_ERROR_NORESOURCE		= 0x2,
> +	GH_RM_ERROR_DENIED		= 0x3,
> +	GH_RM_ERROR_INVALID		= 0x4,
> +	GH_RM_ERROR_BUSY		= 0x5,
> +	GH_RM_ERROR_ARGUMENT_INVALID	= 0x6,
> +	GH_RM_ERROR_HANDLE_INVALID	= 0x7,
> +	GH_RM_ERROR_VALIDATE_FAILED	= 0x8,
> +	GH_RM_ERROR_MAP_FAILED		= 0x9,
> +	GH_RM_ERROR_MEM_INVALID		= 0xA,
> +	GH_RM_ERROR_MEM_INUSE		= 0xB,
> +	GH_RM_ERROR_MEM_RELEASED	= 0xC,
> +	GH_RM_ERROR_VMID_INVALID	= 0xD,
> +	GH_RM_ERROR_LOOKUP_FAILED	= 0xE,
> +	GH_RM_ERROR_IRQ_INVALID		= 0xF,
> +	GH_RM_ERROR_IRQ_INUSE		= 0x10,
> +	GH_RM_ERROR_IRQ_RELEASED	= 0x11,
> +};
> +
> +/**
> + * gh_rm_remap_error() - Remap Gunyah resource manager errors into a Linux error code
> + * @gh_error: "Standard" return value from Gunyah resource manager
> + */
> +static inline int gh_rm_remap_error(enum gh_rm_error rm_error)
> +{
> +	switch (rm_error) {
> +	case GH_RM_ERROR_OK:
> +		return 0;
> +	case GH_RM_ERROR_UNIMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case GH_RM_ERROR_NOMEM:
> +		return -ENOMEM;
> +	case GH_RM_ERROR_NORESOURCE:
> +		return -ENODEV;
> +	case GH_RM_ERROR_DENIED:
> +		return -EPERM;
> +	case GH_RM_ERROR_BUSY:
> +		return -EBUSY;
> +	case GH_RM_ERROR_INVALID:
> +	case GH_RM_ERROR_ARGUMENT_INVALID:
> +	case GH_RM_ERROR_HANDLE_INVALID:
> +	case GH_RM_ERROR_VALIDATE_FAILED:
> +	case GH_RM_ERROR_MAP_FAILED:
> +	case GH_RM_ERROR_MEM_INVALID:
> +	case GH_RM_ERROR_MEM_INUSE:
> +	case GH_RM_ERROR_MEM_RELEASED:
> +	case GH_RM_ERROR_VMID_INVALID:
> +	case GH_RM_ERROR_LOOKUP_FAILED:
> +	case GH_RM_ERROR_IRQ_INVALID:
> +	case GH_RM_ERROR_IRQ_INUSE:
> +	case GH_RM_ERROR_IRQ_RELEASED:
> +		return -EINVAL;
> +	default:
> +		return -EBADMSG;
> +	}
> +}
> +
---------------->

Only user for the error code coversion is within the rm driver, you 
should just move this to the .c file, I see no value of this in .h 
unless there are some other users for this.



> +struct gh_rm;
> +int gh_rm_call(struct gh_rm *rsc_mgr, u32 message_id, void *req_buff, size_t req_buff_size,
> +		void **resp_buf, size_t *resp_buff_size);
> +
> +#endif
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> new file mode 100644
> index 000000000000..c992b3188c8d
> --- /dev/null
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _GUNYAH_RSC_MGR_H
> +#define _GUNYAH_RSC_MGR_H
> +
> +#include <linux/list.h>
> +#include <linux/notifier.h>
> +#include <linux/gunyah.h>
> +
> +#define GH_VMID_INVAL	U16_MAX
> +
> +/* Gunyah recognizes VMID0 as an alias to the current VM's ID */
> +#define GH_VMID_SELF			0
> +
> +struct gh_rm;
> +int gh_rm_notifier_register(struct gh_rm *rm, struct notifier_block *nb);
> +int gh_rm_notifier_unregister(struct gh_rm *rm, struct notifier_block *nb);
> +void get_gh_rm(struct gh_rm *rm);
> +void put_gh_rm(struct gh_rm *rm);
> +
> +#endif
