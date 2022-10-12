Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8745FCE98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJLWwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLWwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:52:18 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF611879B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:52:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g1so27852192lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wy85oWePI/WQcvp4V7jOsX+25xDbhZz3AoTWE5kIvvI=;
        b=TXhk4PAUTBW2kOFTHbe758dSw/imETo0vnHyY+DK2AY1Cw0QonVZ6zW0q3TRNdgbi+
         5jra+WBzNJGoZVW4ydn4ZWtJoccM7epRQk7E50zqEyEXbUnN68u/n377ILfsJZc5qAuL
         DWnm1VHfu7dwMIERc+ehzMuS8fHmy2G5K0hTNRlaqrleMeYXkXcI8QGCMvZzxy1VQtOD
         t/CioJmxRwvTexEsyE0bieldsUPRVZGPTlNx1IY4VPsKNGx3KCDO5Ws3BKcIgn/xayyQ
         XyNk4tdBpfJFKkdvPKWqJYWPgrHOjyMm/m9S/Ht6XtRHClfZBrtrPnzvrWXw+goYN/n9
         eIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wy85oWePI/WQcvp4V7jOsX+25xDbhZz3AoTWE5kIvvI=;
        b=7nv9cbV3uenKAtcIw7W6YCmMtk+tfdzTAWHIFkONdp2XXAz395QVMPKUF/fCPKV67I
         BPDZ0ydACOUp73VmC29KbeCNt1fMlJuQqdwCQDBmZFlPASw1Zm+BL3/4ME5zErf/jwm6
         x2QiBgjk+GlJsOwsGMBzDU0Fxve173mFJkR+YtX9ZA+4nKAdACg70nmVTIgJYR9N04ZW
         R/sogfM7pMlRVlb4FBnnsWwb6d0uFT880GLjGnczJVLrXgi6ITJerOHBfq3lTsH/xfOf
         LSIP5P5w3tsz03kgeoDxc1h914nEpBQoN8PlaMg8/KmpLbcnuich+ktE/RCg6jWCioLn
         fN4Q==
X-Gm-Message-State: ACrzQf3doYrt0BGhPohISJG/NfamHaG4fOKXT4Go6vSjODkup5pdIvS+
        IY/Fgv7oCW2l1xUOej5pbl7jEw==
X-Google-Smtp-Source: AMsMyM40GoPXucfad7s4wUwOuCdG6UlNKoAf4CmhUW6vg2r8LWAt1W5ZFWQ9j1r4bHmgzLEoQyI8wQ==
X-Received: by 2002:a05:6512:31d4:b0:4a2:7709:db05 with SMTP id j20-20020a05651231d400b004a27709db05mr10733408lfe.544.1665615134072;
        Wed, 12 Oct 2022 15:52:14 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o14-20020a056512230e00b0049493c14b17sm135353lfu.181.2022.10.12.15.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 15:52:13 -0700 (PDT)
Message-ID: <9a42be23-e035-0944-ba62-f6af6b7acc0d@linaro.org>
Date:   Thu, 13 Oct 2022 01:52:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v5 10/13] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-GB
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-11-quic_eberman@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011000840.289033-11-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 03:08, Elliot Berman wrote:
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
>   MAINTAINERS                    |   2 +-
>   drivers/virt/gunyah/Kconfig    |  20 +-
>   drivers/virt/gunyah/Makefile   |   3 +
>   drivers/virt/gunyah/rsc_mgr.c  | 601 +++++++++++++++++++++++++++++++++
>   drivers/virt/gunyah/rsc_mgr.h  |  34 ++
>   include/linux/gunyah_rsc_mgr.h |  26 ++
>   6 files changed, 682 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.c
>   create mode 100644 drivers/virt/gunyah/rsc_mgr.h
>   create mode 100644 include/linux/gunyah_rsc_mgr.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 599804836d05..8a3d79b56698 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8891,7 +8891,7 @@ F:	arch/arm64/gunyah/
>   F:	drivers/mailbox/gunyah-msgq.c
>   F:	drivers/virt/gunyah/
>   F:	include/asm-generic/gunyah.h
> -F:	include/linux/gunyah.h
> +F:	include/linux/gunyah*.h
>   
>   HABANALABS PCI DRIVER
>   M:	Oded Gabbay <ogabbay@kernel.org>
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index f4c822a82f1a..78deed3c4562 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -3,9 +3,6 @@
>   config GUNYAH
>   	tristate "Gunyah Virtualization drivers"
>   	depends on ARM64
> -	select AUXILIARY_BUS
> -	select MAILBOX
> -	select GUNYAH_MESSAGE_QUEUES

This should be squashed into earlier patches

>   	help
>   	  The Gunyah drivers are the helper interfaces that runs in a guest VM
>   	  such as basic inter-VM IPC and signaling mechanisms, and higher level
> @@ -13,3 +10,20 @@ config GUNYAH
>   
>   	  Say Y/M here to enable the drivers needed to interact in a Gunyah
>   	  virtual environment.
> +
> +if GUNYAH

Just `depends on GUNYAH'

> +
> +config GUNYAH_RESORUCE_MANAGER
> +	tristate "Gunyah Resource Manager"
> +	select MAILBOX
> +	select GUNYAH_MESSAGE_QUEUES
> +	default y
> +	help
> +	  The resource manager (RM) is a privileged application VM supporting
> +	  the Gunyah Hypervisor. Enable this driver to support communicating
> +	  with Gunyah RM. This is typically required for a VM running under
> +	  Gunyah wanting to have Gunyah-awareness.
> +
> +	  Say Y/M here if unsure.
> +
> +endif
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index dc081e2dc02b..2cae8ea5bc7d 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -1,2 +1,5 @@
>   gunyah-y += gunyah.o
>   obj-$(CONFIG_GUNYAH) += gunyah.o
> +
> +gunyah_rsc_mgr-y += rsc_mgr.o
> +obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o

You know, you don't have to do this...

> diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
> new file mode 100644
> index 000000000000..0e2f04984ada
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr.c
> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "gh_rsc_mgr: " fmt
> +
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/sched.h>
> +#include <linux/gunyah.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/kthread.h>
> +#include <linux/notifier.h>
> +#include <linux/workqueue.h>
> +#include <linux/completion.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +#include <linux/platform_device.h>
> +
> +#include "rsc_mgr.h"
> +
> +/* Resource Manager Header */
> +struct gh_rm_rpc_hdr {
> +	u8 version:4,
> +		hdr_words:4;

Does the following work? It looks better:

u8 version: 4;
u8 hdr_words: 4;

etc.


> +	u8 type:2,
> +		fragments:6;
> +	u16 seq;
> +	u32 msg_id;
> +} __packed;
> +
> +/* Standard reply header */
> +struct gh_rm_rpc_reply_hdr {
> +	struct gh_rm_rpc_hdr rpc_hdr;
> +	u32 err_code;
> +} __packed;
> +
> +/* RPC Header versions */
> +#define GH_RM_RPC_HDR_VERSION_ONE	0x1
> +
> +/* RPC Header words */
> +#define GH_RM_RPC_HDR_WORDS		0x2
> +
> +/* RPC Message types */
> +#define GH_RM_RPC_TYPE_CONT		0x0
> +#define GH_RM_RPC_TYPE_REQ		0x1
> +#define GH_RM_RPC_TYPE_RPLY		0x2
> +#define GH_RM_RPC_TYPE_NOTIF		0x3
> +
> +#define GH_RM_MAX_NUM_FRAGMENTS		62
> +
> +#define GH_RM_MAX_MSG_SIZE	(GH_MSGQ_MAX_MSG_SIZE - sizeof(struct gh_rm_rpc_hdr))
> +
> +/**
> + * struct gh_rm_connection - Represents a complete message from resource manager
> + * @payload: Combined payload of all the fragments (i.e. msg headers stripped off).
> + * @size: Size of the payload.
> + * @ret: Linux return code, set in case there was an error processing the connection.
> + * @msg_id: Message ID from the header.
> + * @type: GH_RM_RPC_TYPE_RPLY or GH_RM_RPC_TYPE_NOTIF.
> + * @num_fragments: total number of fragments expected to be received for this connection.
> + * @fragments_recieved: fragments received so far.
> + * @rm_error: For request/reply sequences with standard replies.
> + * @seq: Sequence ID for the main message.
> + */
> +struct gh_rm_connection {
> +	void *payload;
> +	size_t size;
> +	int ret;
> +	u32 msg_id;
> +	u8 type;
> +
> +	u8 num_fragments;
> +	u8 fragments_received;
> +
> +	/* only for req/reply sequence */
> +	u32 rm_error;
> +	u16 seq;
> +	struct completion seq_done;
> +};
> +
> +struct gh_rm_notif_complete {
> +	struct gh_rm_connection *conn;
> +	struct work_struct work;
> +};
> +
> +struct gh_rsc_mgr {
> +	struct gunyah_msgq msgq;
> +	struct mbox_client msgq_client;
> +	struct gh_rm_connection *active_rx_connection;
> +	int last_tx_ret;
> +
> +	struct idr call_idr;
> +	struct mutex call_idr_lock;
> +
> +	struct mutex send_lock;
> +
> +	struct work_struct recv_work;
> +};
> +
> +static struct gh_rsc_mgr *__rsc_mgr;
> +SRCU_NOTIFIER_HEAD_STATIC(gh_rm_notifier);
> +
> +static struct gh_rm_connection *gh_rm_alloc_connection(u32 msg_id, u8 type)
> +{
> +	struct gh_rm_connection *connection;
> +
> +	connection = kzalloc(sizeof(*connection), GFP_KERNEL);
> +	if (!connection)
> +		return NULL;
> +
> +	connection->type = type;
> +	connection->msg_id = msg_id;
> +
> +	return connection;
> +}
> +
> +/**
> + * gh_rm_init_connection_payload() - Fills the first message for a connection.
> + */
> +static int gh_rm_init_connection_payload(struct gh_rm_connection *connection, void *msg,
> +					size_t hdr_size, size_t payload_size)

Both calling sites pass payload_size as msg_size - hdr_size. I'd suggest 
moving this calculation here.

> +{
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +	size_t max_buf_size;
> +
> +	connection->num_fragments = hdr->fragments;
> +	connection->fragments_received = 0;
> +	connection->type = hdr->type;
> +
> +	/* There's not going to be any payload, no need to allocate buffer. */
> +	if (!payload_size && !connection->num_fragments)
> +		return 0;
> +
> +	/*
> +	 * maximum payload size is GH_MSGQ_MAX_MSG_SIZE - hdr_size
> +	 * and can received (hdr->fragments + 1) of those
> +	 */
> +	max_buf_size = (GH_MSGQ_MAX_MSG_SIZE - hdr_size) * (hdr->fragments + 1);
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
> +	struct gh_rm_notif_complete *notif = container_of(work, struct gh_rm_notif_complete, work);
> +	struct gh_rm_connection *connection = notif->conn;
> +	u32 notif_id = connection->msg_id;
> +	struct gh_rm_notification notification = {
> +		.buff = connection->payload,
> +		.size = connection->size,
> +	};
> +
> +	srcu_notifier_call_chain(&gh_rm_notifier, notif_id, &notification);
> +
> +	kfree(connection->payload);
> +	kfree(connection);
> +	kfree(notif);
> +}
> +
> +static struct gh_rm_connection *gh_rm_process_notif(struct gh_rsc_mgr *rsc_mgr,
> +						    void *msg, size_t msg_size)
> +{
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +	struct gh_rm_connection *connection;
> +
> +	connection = gh_rm_alloc_connection(hdr->msg_id, hdr->type);
> +	if (!connection) {
> +		pr_err("Failed to alloc connection for notification, dropping.\n");
> +		return NULL;
> +	}
> +
> +	if (gh_rm_init_connection_payload(connection, msg, sizeof(*hdr), msg_size - sizeof(*hdr))) {
> +		pr_err("Failed to alloc connection buffer for notification, dropping.\n");
> +		kfree(connection);
> +		return NULL;
> +	}
> +
> +	return connection;
> +}
> +
> +static struct gh_rm_connection *gh_rm_process_rply(struct gh_rsc_mgr *rsc_mgr,
> +						   void *msg, size_t msg_size)
> +{
> +	struct gh_rm_rpc_reply_hdr *reply_hdr = msg;
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +	struct gh_rm_connection *connection;
> +
> +	if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock))
> +		return ERR_PTR(-ERESTARTSYS);
> +
> +	connection = idr_find(&rsc_mgr->call_idr, hdr->seq);
> +	mutex_unlock(&rsc_mgr->call_idr_lock);
> +
> +	if (!connection) {
> +		pr_err("Failed to find connection for sequence %u\n", hdr->seq);
> +		return NULL;
> +	}
> +	if (connection->msg_id != hdr->msg_id) {
> +		pr_err("Reply for sequence %u expected msg_id: %x but got %x\n", hdr->seq,
> +			connection->msg_id, hdr->msg_id);
> +		/*
> +		 * Don't complete connection and error the client, maybe resource manager will
> +		 * send us the expected reply sequence soon.
> +		 */
> +		return NULL;
> +	}
> +
> +	if (gh_rm_init_connection_payload(connection, msg, sizeof(*reply_hdr),
> +					msg_size - sizeof(*reply_hdr))) {
> +		pr_err("Failed to alloc connection buffer for sequence %d\n", hdr->seq);
> +		/* Send connection complete and error the client. */
> +		connection->ret = -ENOMEM;
> +		complete(&connection->seq_done);
> +		return NULL;
> +	}
> +
> +	connection->rm_error = reply_hdr->err_code;
> +	return connection;
> +}
> +
> +static void gh_rm_process_cont(struct gh_rm_connection *connection, void *msg, size_t msg_size)
> +{
> +	struct gh_rm_rpc_hdr *hdr = msg;
> +	size_t payload_size = msg_size - sizeof(*hdr);
> +
> +	/*
> +	 * hdr->fragments and hdr->msg_id preserves the value from first reply or notif message.
> +	 * For sake of sanity, check if it's still intact.
> +	 */
> +	if (connection->msg_id != hdr->msg_id)
> +		pr_warn("Appending mismatched continuation with id %d to connection with id %d\n",
> +			hdr->msg_id, connection->msg_id);
> +	if (connection->num_fragments != hdr->fragments)
> +		pr_warn("Number of fragments mismatch for seq: %d\n", hdr->seq);
> +
> +	memcpy(connection->payload + connection->size, msg + sizeof(*hdr), payload_size);
> +	connection->size += payload_size;
> +	connection->fragments_received++;
> +}
> +
> +static bool gh_rm_complete_connection(struct gh_rm_connection *connection)
> +{
> +	struct gh_rm_notif_complete *notif_work;
> +
> +	if (!connection)
> +		return false;
> +
> +	if (connection->fragments_received != connection->num_fragments)
> +		return false;
> +
> +	switch (connection->type) {
> +	case GH_RM_RPC_TYPE_RPLY:
> +		complete(&connection->seq_done);
> +		break;
> +	case GH_RM_RPC_TYPE_NOTIF:
> +		notif_work = kzalloc(sizeof(*notif_work), GFP_KERNEL);
> +		if (notif_work == NULL)
> +			break;
> +
> +		notif_work->conn = connection;
> +		INIT_WORK(&notif_work->work, gh_rm_notif_work);
> +
> +		schedule_work(&notif_work->work);
> +		break;
> +	default:
> +		pr_err("Invalid message type (%d) received\n", connection->type);
> +		break;
> +	}
> +
> +	return true;
> +}
> +
> +static void gh_rm_abort_connection(struct gh_rm_connection *connection)
> +{
> +	switch (connection->type) {
> +	case GH_RM_RPC_TYPE_RPLY:
> +		connection->ret = -EIO;
> +		complete(&connection->seq_done);
> +		break;
> +	case GH_RM_RPC_TYPE_NOTIF:
> +		fallthrough;
> +	default:
> +		kfree(connection->payload);
> +		kfree(connection);
> +	}
> +}
> +
> +static void gh_rm_msgq_rx_data(struct mbox_client *cl, void *mssg)
> +{
> +	struct gh_rsc_mgr *rsc_mgr = container_of(cl, struct gh_rsc_mgr, msgq_client);
> +	struct gunyah_msgq_rx_data *rx_data = mssg;
> +	void *msg = rx_data->data;
> +	size_t msg_size = rx_data->length;
> +	struct gh_rm_rpc_hdr *hdr;
> +
> +	if (msg_size <= sizeof(struct gh_rm_rpc_hdr)) {
> +		pr_err("Invalid message size received: %ld is too small\n", msg_size);
> +		return;
> +	}
> +
> +	hdr = msg;
> +	switch (hdr->type) {
> +	case GH_RM_RPC_TYPE_NOTIF:
> +		if (rsc_mgr->active_rx_connection) {
> +			/* Not possible per protocol. Do something better than BUG_ON */
> +			pr_warn("Received start of new notification without finishing existing message series.\n");
> +			gh_rm_abort_connection(rsc_mgr->active_rx_connection);
> +		}
> +		rsc_mgr->active_rx_connection = gh_rm_process_notif(rsc_mgr, msg, msg_size);
> +		break;
> +	case GH_RM_RPC_TYPE_RPLY:
> +		if (rsc_mgr->active_rx_connection) {
> +			/* Not possible per protocol. Do something better than BUG_ON */
> +			pr_warn("Received start of new reply without finishing existing message series.\n");
> +			gh_rm_abort_connection(rsc_mgr->active_rx_connection);
> +		}
> +		rsc_mgr->active_rx_connection = gh_rm_process_rply(rsc_mgr, msg, msg_size);
> +		break;
> +	case GH_RM_RPC_TYPE_CONT:
> +		if (!rsc_mgr->active_rx_connection) {
> +			pr_warn("Received a continuation message without receiving initial message\n");
> +			break;
> +		}
> +		gh_rm_process_cont(rsc_mgr->active_rx_connection, msg, msg_size);
> +		break;
> +	default:
> +		pr_err("Invalid message type (%d) received\n", hdr->type);
> +		return;
> +	}
> +
> +	if (gh_rm_complete_connection(rsc_mgr->active_rx_connection))
> +		rsc_mgr->active_rx_connection = NULL;
> +}
> +
> +static void gh_rm_msgq_tx_done(struct mbox_client *cl, void *mssg, int r)
> +{
> +	struct gh_rsc_mgr *rsc_mgr = container_of(cl, struct gh_rsc_mgr, msgq_client);
> +
> +	kfree(mssg);
> +	rsc_mgr->last_tx_ret = r;
> +}
> +
> +static int gh_rm_send_request(struct gh_rsc_mgr *rsc_mgr, u32 message_id,
> +				const void *req_buff, size_t req_buff_size,
> +				struct gh_rm_connection *connection)
> +{
> +	size_t buff_size_remaining = req_buff_size;
> +	const void *req_buff_curr = req_buff;
> +	struct gh_rm_rpc_hdr *hdr;
> +	u32 cont_fragments = req_buff_size / GH_RM_MAX_MSG_SIZE;
> +	size_t payload_size;
> +	struct gunyah_msgq_tx_data *msg;
> +	int i, ret;
> +
> +	if (WARN(cont_fragments > GH_RM_MAX_NUM_FRAGMENTS,
> +		 "Limit exceeded for the number of fragments: %u\n", cont_fragments))
> +		return -E2BIG;
> +
> +	ret = mutex_lock_interruptible(&rsc_mgr->send_lock);
> +	if (ret)
> +		return ret;
> +
> +	/* Consider also the 'request' packet for the loop count */
> +	for (i = 0; i <= cont_fragments; i++) {
> +		if (buff_size_remaining > GH_RM_MAX_MSG_SIZE) {
> +			payload_size = GH_RM_MAX_MSG_SIZE;
> +			buff_size_remaining -= payload_size;
> +		} else {
> +			payload_size = buff_size_remaining;
> +		}
> +
> +		msg = kzalloc(sizeof(*msg) + GH_MSGQ_MAX_MSG_SIZE, GFP_KERNEL);
> +		if (!msg) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* Fill header */
> +		hdr = (struct gh_rm_rpc_hdr *)msg->data;
> +		hdr->version = GH_RM_RPC_HDR_VERSION_ONE;
> +		hdr->hdr_words = GH_RM_RPC_HDR_WORDS;
> +		hdr->type = i == 0 ? GH_RM_RPC_TYPE_REQ : GH_RM_RPC_TYPE_CONT;
> +		hdr->fragments = cont_fragments;
> +		hdr->seq = connection->seq;
> +		hdr->msg_id = message_id;
> +
> +		/* Copy payload */
> +		memcpy(msg->data + sizeof(*hdr), req_buff_curr, payload_size);
> +		req_buff_curr += payload_size;
> +
> +		/* Force the last fragment to immediately alert the receiver */
> +		msg->push = i == cont_fragments;
> +		msg->length = sizeof(*hdr) + payload_size;
> +
> +		ret = mbox_send_message(gunyah_msgq_chan(&rsc_mgr->msgq), msg);
> +		if (ret < 0) {
> +			kfree(msg);
> +			break;
> +		}
> +
> +		if (rsc_mgr->last_tx_ret) {
> +			ret = rsc_mgr->last_tx_ret;
> +			break;
> +		}
> +	}
> +
> +out:
> +	mutex_unlock(&rsc_mgr->send_lock);
> +	return ret < 0 ? ret : 0;
> +}
> +
> +/**
> + * gh_rm_call: Achieve request-response type communication with RPC
> + * @message_id: The RM RPC message-id
> + * @req_buff: Request buffer that contains the payload
> + * @req_buff_size: Total size of the payload
> + * @resp_buf: Pointer to a response buffer
> + * @resp_buff_size: Size of the response buffer
> + * @reply_err_code: Returns Gunyah standard error code for the response
> + *
> + * Make a request to the RM-VM and wait for reply back. For a successful
> + * response, the function returns the payload. The size of the payload is set in resp_buff_size.
> + * The resp_buf should be freed by the caller.
> + *
> + * Context: Process context. Will sleep waiting for reply.
> + * Return: >0 is standard reply error from RM. <0 on internal error.
> + */
> +int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
> +		void **resp_buf, size_t *resp_buff_size)
> +{
> +	struct gh_rm_connection *connection;
> +	int ret;
> +	struct gh_rsc_mgr *rsc_mgr = __rsc_mgr;
> +
> +	/* messaged_id 0 is reserved */
> +	if (!message_id)
> +		return -EINVAL;
> +
> +	if (!rsc_mgr)
> +		return -EPROBE_DEFER;
> +
> +	connection = gh_rm_alloc_connection(message_id, GH_RM_RPC_TYPE_RPLY);
> +	if (!connection)
> +		return -ENOMEM;
> +
> +	init_completion(&connection->seq_done);
> +
> +	/* Allocate a new seq number for this connection */
> +	if (mutex_lock_interruptible(&rsc_mgr->call_idr_lock)) {
> +		kfree(connection);
> +		return -ERESTARTSYS;
> +	}
> +	connection->seq = idr_alloc_cyclic(&rsc_mgr->call_idr, connection, 0, U16_MAX, GFP_KERNEL);
> +	mutex_unlock(&rsc_mgr->call_idr_lock);
> +
> +	/* Send the request to the Resource Manager */
> +	ret = gh_rm_send_request(rsc_mgr, message_id, req_buff, req_buff_size, connection);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* Wait for response */
> +	ret = wait_for_completion_interruptible(&connection->seq_done);
> +	if (ret)
> +		goto out;
> +
> +	if (connection->ret) {
> +		ret = connection->ret;
> +		kfree(connection->payload);
> +		goto out;
> +	}
> +
> +	if (connection->rm_error) {
> +		ret = connection->rm_error;
> +		kfree(connection->payload);
> +		goto out;
> +	}
> +
> +	*resp_buf = connection->payload;
> +	*resp_buff_size = connection->size;
> +
> +out:
> +	mutex_lock(&rsc_mgr->call_idr_lock);
> +	idr_remove(&rsc_mgr->call_idr, connection->seq);
> +	mutex_unlock(&rsc_mgr->call_idr_lock);
> +
> +	kfree(connection);
> +	return ret;
> +}
> +
> +int gh_rm_register_notifier(struct notifier_block *nb)
> +{
> +	return srcu_notifier_chain_register(&gh_rm_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_register_notifier);
> +
> +int gh_rm_unregister_notifier(struct notifier_block *nb)
> +{
> +	return srcu_notifier_chain_unregister(&gh_rm_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(gh_rm_unregister_notifier);
> +
> +static int gh_msgq_platform_probe_direction(struct platform_device *pdev,
> +				u8 gh_type, int idx, struct gunyah_resource *ghrsc)
> +{
> +	int ret;
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	ghrsc->type = gh_type;
> +
> +	ghrsc->irq = platform_get_irq(pdev, idx);
> +	if (ghrsc->irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, ghrsc->irq);
> +		return ghrsc->irq;
> +	}
> +
> +	ret = of_property_read_u64_index(node, "reg", idx, &ghrsc->capid);

Is there any reason why can't you use platform_get_resource() here?

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to get capid%d: %d\n", idx, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gh_rm_drv_probe(struct platform_device *pdev)
> +{
> +	struct gh_rsc_mgr *rsc_mgr;
> +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
> +	int ret;
> +
> +	rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
> +	if (!rsc_mgr)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, rsc_mgr);
> +
> +	mutex_init(&rsc_mgr->call_idr_lock);
> +	idr_init(&rsc_mgr->call_idr);
> +	mutex_init(&rsc_mgr->send_lock);
> +
> +	ret = gh_msgq_platform_probe_direction(pdev, GUNYAH_RESOURCE_TYPE_MSGQ_TX, 0, &tx_ghrsc);
> +	if (ret)
> +		return ret;
> +
> +	ret = gh_msgq_platform_probe_direction(pdev, GUNYAH_RESOURCE_TYPE_MSGQ_RX, 1, &rx_ghrsc);
> +	if (ret)
> +		return ret;
> +
> +	rsc_mgr->msgq_client.dev = &pdev->dev;
> +	rsc_mgr->msgq_client.tx_block = true;
> +	rsc_mgr->msgq_client.rx_callback = gh_rm_msgq_rx_data;
> +	rsc_mgr->msgq_client.tx_done = gh_rm_msgq_tx_done;
> +
> +	ret = gunyah_msgq_init(&pdev->dev, &rsc_mgr->msgq, &rsc_mgr->msgq_client,
> +				&tx_ghrsc, &rx_ghrsc);
> +	if (ret)
> +		return ret;
> +
> +	__rsc_mgr = rsc_mgr;
> +
> +	return 0;
> +}
> +
> +static int gh_rm_drv_remove(struct platform_device *pdev)
> +{
> +	struct gh_rsc_mgr *rsc_mgr = platform_get_drvdata(pdev);
> +
> +	__rsc_mgr = NULL;
> +
> +	mbox_free_channel(gunyah_msgq_chan(&rsc_mgr->msgq));
> +	gunyah_msgq_remove(&rsc_mgr->msgq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gh_rm_of_match[] = {
> +	{ .compatible = "gunyah-resource-manager" },
> +	{ }
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
> +module_platform_driver(gh_rsc_mgr_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Resource Manager Driver");
> diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
> new file mode 100644
> index 000000000000..e4f2499267bf
> --- /dev/null
> +++ b/drivers/virt/gunyah/rsc_mgr.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#ifndef __GH_RSC_MGR_PRIV_H
> +#define __GH_RSC_MGR_PRIV_H
> +
> +#include <linux/gunyah.h>
> +
> +/* RM Error codes */
> +#define GH_RM_ERROR_OK			0x0
> +#define GH_RM_ERROR_UNIMPLEMENTED	0xFFFFFFFF
> +#define GH_RM_ERROR_NOMEM		0x1
> +#define GH_RM_ERROR_NORESOURCE		0x2
> +#define GH_RM_ERROR_DENIED		0x3
> +#define GH_RM_ERROR_INVALID		0x4
> +#define GH_RM_ERROR_BUSY		0x5
> +#define GH_RM_ERROR_ARGUMENT_INVALID	0x6
> +#define GH_RM_ERROR_HANDLE_INVALID	0x7
> +#define GH_RM_ERROR_VALIDATE_FAILED	0x8
> +#define GH_RM_ERROR_MAP_FAILED		0x9
> +#define GH_RM_ERROR_MEM_INVALID		0xA
> +#define GH_RM_ERROR_MEM_INUSE		0xB
> +#define GH_RM_ERROR_MEM_RELEASED	0xC
> +#define GH_RM_ERROR_VMID_INVALID	0xD
> +#define GH_RM_ERROR_LOOKUP_FAILED	0xE
> +#define GH_RM_ERROR_IRQ_INVALID		0xF
> +#define GH_RM_ERROR_IRQ_INUSE		0x10
> +#define GH_RM_ERROR_IRQ_RELEASED	0x11
> +
> +int gh_rm_call(u32 message_id, void *req_buff, size_t req_buff_size,
> +		void **resp_buf, size_t *resp_buff_size);
> +
> +#endif
> diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> new file mode 100644
> index 000000000000..b3b37225b7fb
> --- /dev/null
> +++ b/include/linux/gunyah_rsc_mgr.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
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
> +struct gh_rm_notification {
> +	const void *buff;
> +	const size_t size;
> +};
> +
> +int gh_rm_register_notifier(struct notifier_block *nb);
> +int gh_rm_unregister_notifier(struct notifier_block *nb);
> +
> +#endif

-- 
With best wishes
Dmitry

