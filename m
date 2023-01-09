Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB93663329
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbjAIVhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbjAIVfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:35:48 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39993C71A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:42 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id bp26so5551049ilb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE3UYT1VOOeLoiUyNm19+2/ASU5b5vePG8nhus+/6lM=;
        b=bkNJWshF/OdKfaRccPgjDjtrsBYbtUZ0GBq9jnk8L6gnus2klle40JPWKM9vOYH1IN
         Nks2gEwEXw7pY9BG2xH7GKZl97oTRFvwNMSY1wYn0fNY1Hf0anV/owyqgV1KCooIeErI
         jNPy9vtXleKuDibJYsCdLwisPlPXTTS7TaqixQuuVIe54pqJ+233j8cvaPpKlW8p7CTs
         UVswGfZtro1gxx4AMhA7wbi+pt9CEeFlh+LhBQKteXbVLWfmXBbgyXcN7fEJLcIQ42zz
         QL4csLHmIJHQ3IKOh+yr0YeryEDHQTA2KtD0xHofKo+Y0ecMgea3GiZatytFDiu4vdmt
         Qr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE3UYT1VOOeLoiUyNm19+2/ASU5b5vePG8nhus+/6lM=;
        b=73qVuHan40BXFEYx31XMxsWlgzJ+3MCUUAAXB7rP9/sxnNu8cphdg/6KkSy+rkxAjl
         KtNUlij1k+3HiajQWOQdXkCtqs0oF1t50CTHdYloBIUlk6U/QwW3uSugxY3dsmg3hWh1
         GjeGF65NPocMt57fa/miNT+GKCREzIMt+OOWZdiErxggyORK7UJsEM9U2vGxH3Y2Wtaf
         gTE5MEu0icCcRSEuR3K8GJQehdiXMzUHoM4bxp7dmUBO8G35EL0+bSgntQtMjKTq8Tg5
         EETkBjfcQGyo/L/jD4fXlOJ4OWZ/+JjEh/qgqiZaTcKxlxQ3qplBjvWSmHqq4DNhcNnk
         D03g==
X-Gm-Message-State: AFqh2kqnNjsLICTwQJzuZ72/F3ERTmZ2dy2xxLh0HT3upQ2eaFbC83IF
        W+9ddnJXYATPXKCkhq5CmtTRdA==
X-Google-Smtp-Source: AMrXdXtuvAtUaqLqfLCsnhz3MI/FfYy9jdQbj584nwd97t5b9/6xdoLdvLudDal8SK/yp7vVpAhBzg==
X-Received: by 2002:a92:dc02:0:b0:30d:976d:bbe7 with SMTP id t2-20020a92dc02000000b0030d976dbbe7mr8144868iln.4.1673300082371;
        Mon, 09 Jan 2023 13:34:42 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id u11-20020a92d1cb000000b0030c1ec638desm3047780ilg.14.2023.01.09.13.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:34:41 -0800 (PST)
Message-ID: <4e064b55-22fd-5f29-620b-715a5d822a75@linaro.org>
Date:   Mon, 9 Jan 2023 15:34:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 09/28] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221219225850.2397345-1-quic_eberman@quicinc.com>
 <20221219225850.2397345-10-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20221219225850.2397345-10-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 4:58 PM, Elliot Berman wrote:
> Gunyah message queues are a unidirectional inter-VM pipe for messages up

s/Gunyah message queues are/A Gunyah message queue is/

> to 1024 bytes. This driver supports pairing a receiver message queue and
> a transmitter message queue to expose a single mailbox channel.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/message-queue.rst |   8 +
>   MAINTAINERS                                 |   1 +
>   drivers/mailbox/Kconfig                     |  10 +
>   drivers/mailbox/Makefile                    |   2 +
>   drivers/mailbox/gunyah-msgq.c               | 229 ++++++++++++++++++++
>   include/linux/gunyah.h                      |  61 +++++-
>   6 files changed, 309 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/mailbox/gunyah-msgq.c
> 
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> index be4ab289236a..9245dbe6dd8a 100644
> --- a/Documentation/virt/gunyah/message-queue.rst
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -54,3 +54,11 @@ vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
>         |               |         |                 |         |               |
>         |               |         |                 |         |               |
>         +---------------+         +-----------------+         +---------------+
> +
> +Gunyah message queues are exposed as mailboxes. To create the mailbox, create
> +a mbox_client and call `gh_msgq_init`. On receipt of the RX_READY interrupt,
> +all messages in the RX message queue are read and pushed via the `rx_callback`
> +of the registered mbox_client.
> +
> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
> +   :identifiers: gh_msgq_init
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36698df6b0e5..667480bfd387 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8942,6 +8942,7 @@ S:	Supported
>   F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>   F:	Documentation/virt/gunyah/
>   F:	arch/arm64/gunyah/
> +F:	drivers/mailbox/gunyah-msgq.c
>   F:	drivers/virt/gunyah/
>   F:	include/linux/gunyah.h
>   
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 05d6fae800e3..baf9451c5f04 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -41,6 +41,16 @@ config IMX_MBOX
>   	help
>   	  Mailbox implementation for i.MX Messaging Unit (MU).
>   
> +config GUNYAH_MESSAGE_QUEUES

Is Gunyah useful without message queues? Are Gunyah message
queues useful without the rest of Gunyah?  Are there other
possible message queue implementations?  My point is that
maybe this isn't a necessary kernel config option.

> +	tristate "Gunyah Message Queue Mailbox"
> +	depends on GUNYAH
> +	help
> +	  Mailbox implementation for Gunyah Message Queues. Gunyah message queues
> +	  are an IPC mechanism to pass short messages between virtual machines
> +	  running under the Gunyah hypervisor.
> +
> +	  Say Y here if you run Linux as a Gunyah virtual machine.
> +
>   config PLATFORM_MHU
>   	tristate "Platform MHU Mailbox"
>   	depends on OF
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index fc9376117111..5f929bb55e9a 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>   
>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
>   
> +obj-$(CONFIG_GUNYAH)		+= gunyah-msgq.o

Assuming you keep the Kconfig option, should this be
referring to CONFIG_GUNYAH_MESSAGE_QUEUES?

> +
>   obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>   
>   obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
> diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.c
> new file mode 100644
> index 000000000000..d5a324e85428
> --- /dev/null
> +++ b/drivers/mailbox/gunyah-msgq.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/gunyah.h>
> +#include <linux/printk.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
> +#define mbox_chan_to_msgq(chan) (container_of(chan->mbox, struct gh_msgq, mbox))
> +
> +static inline bool gh_msgq_has_tx(struct gh_msgq *msgq)
> +{
> +	return msgq->tx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_TX;

I think this was pointed out elsewhere; I think msgq->tx_ghrsc
can be null.  Same for msgq->rx_ghrsc below.

> +}
> +
> +static inline bool gh_msgq_has_rx(struct gh_msgq *msgq)
> +{
> +	return msgq->rx_ghrsc->type == GUNYAH_RESOURCE_TYPE_MSGQ_RX;

Is there any chance that a message queue would be created whose
type was anything other than MSGQ_RX?  It's possible that there
is some generic resource code that needs this type field, but
in this case I don't see why it's important.

And...  If that's the case, I think it's perhaps clearer to
just replace calls to gs_msgq_has_rx(msgq) with:

	if (msgq->rx_ghrsc)
		/* there is an RX message queue */

> +}
> +
> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +	struct gh_msgq_rx_data rx_data;
> +	unsigned long gh_err;
> +	ssize_t ret;
> +	bool ready = false;
> +
> +	do {

Maybe:	bool ready = true;

	while (ready) {
> +		gh_err = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
> +				(uintptr_t)&rx_data.data, sizeof(rx_data.data),
> +				&rx_data.length, &ready);
> +		if (gh_err == GH_ERROR_OK) {
> +			mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);

Maybe			continue;
		}

		if (gh_err != GH_ERROR_MSGQUEUE_EMPTY)
			pr_warn(...);

		break;

> +		} else if (GH_ERROR_MSGQUEUE_EMPTY) {
> +			break;
> +		} else {
> +			pr_warn("Failed to receive data from msgq for %s: %ld\n",

s/%ld/%zd/

> +				msgq->mbox.dev ? dev_name(msgq->mbox.dev) : "", ret);
> +			break;
> +		}
> +	} while (ready);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
> +{
> +	struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, txdone_tasklet);
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_status);
> +}
> +
> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct gh_msgq *msgq = mbox_chan_to_msgq(chan);
> +	struct gh_msgq_tx_data *msgq_data = data;
> +	u64 tx_flags = 0;
> +	unsigned long ret;
> +	bool ready;
> +
> +	if (msgq_data->push)
> +		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
> +

I probably missed something, but where is gh_hypercall_msgq_send()
defined?  I'm interested in what the ready flag is used for.
(Can the return value encode that?)

> +	ret = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_data->length,
> +					(uintptr_t)msgq_data->data, tx_flags, &ready);
> +
> +	/**
> +	 * unlikely because Linux tracks state of msgq and should not try to
> +	 * send message when msgq is full.
> +	 */

Is it just unlikely, or is it impossible?

> +	if (unlikely(ret == GH_ERROR_MSGQUEUE_FULL))
> +		return -EAGAIN;
> +
> +	/**
> +	 * Propagate all other errors to client. If we return error to mailbox
> +	 * framework, then no other messages can be sent and nobody will know
> +	 * to retry this message.
> +	 */
> +	msgq->last_status = gh_remap_error(ret);
> +
> +	/**
> +	 * This message was successfully sent, but message queue isn't ready to
> +	 * receive more messages because it's now full. Mailbox framework
> +	 * requires that we only report that message was transmitted only when

s/only //    (for one of them)

> +	 * we're ready to transmit another message. We'll get that in the form
> +	 * of tx IRQ once the other side starts to drain the msgq.
> +	 */
> +	if (ret == GH_ERROR_OK && !ready)
> +		return 0;
> +
> +	/**
> +	 * We can send more messages. Mailbox framework requires that tx done
> +	 * happens asynchronously to sending the message. Gunyah message queues
> +	 * tell us right away on the hypercall return whether we can send more
> +	 * messages. To work around this, defer the txdone to a tasklet.
> +	 */
> +	tasklet_schedule(&msgq->txdone_tasklet);
> +
> +	return 0;
> +}
> +
> +struct mbox_chan_ops gh_msgq_ops = {
> +	.send_data = gh_msgq_send_data,
> +};
> +
> +/**
> + * gh_msgq_init() - Initialize a Gunyah message queue with an mbox_client
> + * @parent: optional, device parent used for the mailbox controller
> + * @msgq: Pointer to the gh_msgq to initialize
> + * @cl: A mailbox client to bind to the mailbox channel that the message queue creates
> + * @tx_ghrsc: optional, the transmission side of the message queue
> + * @rx_ghrsc: optional, the receiving side of the message queue
> + *
> + * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most message queue use cases come with
> + * a pair of message queues to facilitiate bidirectional communication. When tx_ghrsc is set,

s/facilitiate/facilitate/

> + * the client can send messages with mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
> + * is set, the mbox_client should register an .rx_callback() and the message queue driver will
> + * push all available messages upon receiving the RX ready interrupt. The messages should be
> + * consumed or copied by the client right away as the gh_msgq_rx_data will be replaced/destroyed
> + * after the callback.
> + *
> + * Returns - 0 on success, negative otherwise
> + */
> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
> +		     struct gunyah_resource *tx_ghrsc, struct gunyah_resource *rx_ghrsc)
> +{
> +	int ret;
> +
> +	/* Must have at least a tx_ghrsc or rx_ghrsc and that they are the right device types */
> +	if ((!tx_ghrsc && !rx_ghrsc) ||
> +	    (tx_ghrsc && tx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_TX) ||
> +	    (rx_ghrsc && rx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_RX))

The internal parenthesis pairs above aren't really required.


> +		return -EINVAL;
> +
> +	msgq->tx_ghrsc = tx_ghrsc;
> +	msgq->rx_ghrsc = rx_ghrsc;
> +
> +	msgq->mbox.dev = parent;
> +	msgq->mbox.ops = &gh_msgq_ops;
> +	msgq->mbox.num_chans = 1;
> +	msgq->mbox.chans = kcalloc(msgq->mbox.num_chans, sizeof(*msgq->mbox.chans), GFP_KERNEL);
> +	if (!msgq->mbox.chans)
> +		return -ENOMEM;
> +	msgq->mbox.txdone_irq = true;
> +
> +	if (gh_msgq_has_tx(msgq)) {

Maybe	if (tx_ghrsc) {

> +		ret = request_irq(msgq->tx_ghrsc->irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
> +				msgq);
> +		if (ret)
> +			goto err_chans;
> +	}
> +
> +	if (gh_msgq_has_rx(msgq)) {

Maybe	if (rx_ghrsc) {

> +		ret = request_threaded_irq(msgq->rx_ghrsc->irq, NULL, gh_msgq_rx_irq_handler,
> +						IRQF_ONESHOT, "gh_msgq_rx", msgq);
> +		if (ret)
> +			goto err_tx_irq;
> +	}
> +
> +	tasklet_setup(&msgq->txdone_tasklet, gh_msgq_txdone_tasklet);
> +
> +	ret = mbox_controller_register(&msgq->mbox);
> +	if (ret)
> +		goto err_rx_irq;
> +
> +	ret = mbox_bind_client(gh_msgq_chan(msgq), cl);
> +	if (ret)
> +		goto err_mbox;
> +
> +	return 0;
> +err_mbox:
> +	mbox_controller_unregister(&msgq->mbox);
> +err_rx_irq:
> +	if (gh_msgq_has_rx(msgq))

	if (rx_ghrsc)

> +		free_irq(msgq->rx_ghrsc->irq, msgq);
> +err_tx_irq:
> +	if (gh_msgq_has_tx(msgq))

	if (tx_ghrsc)

> +		free_irq(msgq->tx_ghrsc->irq, msgq);
> +err_chans:
> +	kfree(msgq->mbox.chans);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_msgq_init);
> +
> +void gh_msgq_remove(struct gh_msgq *msgq)
> +{
> +	mbox_controller_unregister(&msgq->mbox);
> +
> +	if (gh_msgq_has_rx(msgq))
> +		free_irq(msgq->rx_ghrsc->irq, msgq);
> +
> +	if (gh_msgq_has_tx(msgq))
> +		free_irq(msgq->tx_ghrsc->irq, msgq);
> +
> +	kfree(msgq->mbox.chans);
> +}
> +EXPORT_SYMBOL_GPL(gh_msgq_remove);
> +
> +
> +static int __init gh_msgq_init_module(void)
> +{
> +	if (gh_api_version() != GUNYAH_API_V1) {
> +		pr_warn("Unrecognized gunyah version: %u. Currently supported: %d\n",
> +			gh_api_version(), GUNYAH_API_V1);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +module_init(gh_msgq_init_module);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Message Queue Driver");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index c863cac4a3cf..e317d7ac938f 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -7,10 +7,67 @@
>   #define _GUNYAH_H
>   
>   #include <linux/bitfield.h>
> -#include <linux/types.h>
>   #include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/types.h>
> +
> +/* Follows resource manager's resource types for VM_GET_HYP_RESOURCES */
> +enum gunyah_resource_type {
> +	GUNYAH_RESOURCE_TYPE_BELL_TX	= 0,
> +	GUNYAH_RESOURCE_TYPE_BELL_RX	= 1,
> +	GUNYAH_RESOURCE_TYPE_MSGQ_TX	= 2,
> +	GUNYAH_RESOURCE_TYPE_MSGQ_RX	= 3,
> +	GUNYAH_RESOURCE_TYPE_VCPU	= 4,
> +};
> +
> +struct gunyah_resource {
> +	enum gunyah_resource_type type;
> +	u64 capid;
> +	int irq;
> +};
> +
> +/**
> + * Gunyah Message Queues
> + */
> +
> +#define GH_MSGQ_MAX_MSG_SIZE	240
> +
> +struct gh_msgq_tx_data {
> +	size_t length;
> +	bool push;
> +	char data[];
> +};
> +
> +struct gh_msgq_rx_data {
> +	size_t length;
> +	char data[GH_MSGQ_MAX_MSG_SIZE];
> +};
> +
> +struct gh_msgq {
> +	struct gunyah_resource *tx_ghrsc;
> +	struct gunyah_resource *rx_ghrsc;
> +
> +	/* msgq private */
> +	int last_status;

Maybe note that last_status is an errno (and not GH_ERROR_*)

					-Alex

> +	struct mbox_controller mbox;
> +	struct tasklet_struct txdone_tasklet;
> +};
> +
> +
> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
> +		     struct gunyah_resource *tx_ghrsc, struct gunyah_resource *rx_ghrsc);
> +void gh_msgq_remove(struct gh_msgq *msgq);
> +
> +static inline struct mbox_chan *gh_msgq_chan(struct gh_msgq *msgq)
> +{
> +	return &msgq->mbox.chans[0];
> +}
> +
> +/******************************************************************************/
> +/* Common arch-independent macros and definitions for Gunyah hypercalls */
>   
> -/* Common Gunyah macros */
>   #define GH_CAPID_INVAL	U64_MAX
>   #define GH_VMID_ROOT_VM	0xff
>   

