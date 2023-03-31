Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8AB6D226A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCaOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjCaOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:25:44 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737301F79D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:25:24 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id h187so8051045iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272722; x=1682864722;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZYRMjzxgKGgW042mmrZpxESiOe1xnULtIRRqdEZ79rE=;
        b=O3G001+4GJ0XfADuk1R/XZ+dXoud+qvbmxOtyevAJMC2hvMZxc9zH1T69+XRp5HRFv
         uylERVXLuz3IgbSf2BlgltzBvc1MrmedpnXHau0TCOLiz9ZtNqt1T81fTrdRNwfOqRN7
         FdEAafHpx/8uvhSaTzeGLpkssIVrnvrYi1N2ypAaqhYmp1QMLOs+fGtJNsmGf42r+hMW
         u/ILosewC2Pcpw3/OndnySCB+q88TGN57UqByGQyQlh4IasQok7C88yGhf72yh8IBK6X
         gsAYGyHKSV6Qd3Yrt7XC2FbKJpQBTrCWnGCb/6kR7sJFbXGIX5Yc+RppMaNk1JVQ/X/t
         dxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272722; x=1682864722;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYRMjzxgKGgW042mmrZpxESiOe1xnULtIRRqdEZ79rE=;
        b=YK8AnJSolEFRAfAPDZbBbRpKR2jEFRVEAojBE2d4lk9dcZfwfvPnYrbIyz191yTVro
         rsNpeNT29ovLApf038PXLfN+JmPr/CidOYmg2fc0RywsIW6t6lBzGLJKNyiGUW4yXlXX
         DPTwyZEGAVoZwTSW+s4CeRnBk4WC6+pFZeNrG9s/9MdeJsipfHRuXwMWRQuThB79OM+l
         BbEA2JJ0h0lMLArcOsoHDQ0dZQuE2ZaFTSeVkN+gtRJs1j8Y4qheiLiDv//kN+Y1l8L0
         jJnNmlNQKPSAle81+WRegDP7UVYp6fxEk/TM0QtqQdx0Oy5arj+W/6dqcYp6WhBZe3KQ
         QQzA==
X-Gm-Message-State: AAQBX9dYkTNUsmxB2taf/NPrgmbvrelaOL7AxqpjTyVcsSJSHz5mrGyz
        iG3G5qvUn5sOV+y0XdMdmN8ySQ==
X-Google-Smtp-Source: AKy350ZpXQwDTMfH17dAchw/+kvkDNZoQ9x4IMWVgRXyBNts8XwVb5u1TbfDCvBpMF/gUM8AMPUWIA==
X-Received: by 2002:a6b:ce16:0:b0:75d:b1:b718 with SMTP id p22-20020a6bce16000000b0075d00b1b718mr3686117iob.9.1680272721936;
        Fri, 31 Mar 2023 07:25:21 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id m24-20020a056602019800b007596e6ea7d5sm622731ioo.52.2023.03.31.07.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:25:21 -0700 (PDT)
Message-ID: <01f2f8a2-15e6-66e8-a5a0-eb9f511a1121@linaro.org>
Date:   Fri, 31 Mar 2023 09:25:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v11 07/26] mailbox: Add Gunyah message queue mailbox
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
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
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-8-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230304010632.2127470-8-quic_eberman@quicinc.com>
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
> Gunyah message queues are a unidirectional inter-VM pipe for messages up
> to 1024 bytes. This driver supports pairing a receiver message queue and
> a transmitter message queue to expose a single mailbox channel.

I think it's good to reuse existing frameworks, for example, using
the mailbox abstraction to implement your messaging code.  But I
find there are some minor mismatches between what you need and
the way the mailbox code works.

I'm not really suggesting you change anything, but I'll just say
it seemed like there were a few spots you needed to do things
that were slightly awkward in order to satisfy mailbox requirements.

I'll point out in a few comments what I mean below.

I'll take one more look at it again next time, but I assume this
works and I have no other new comments today.

					-Alex

> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/message-queue.rst |   8 +
>   drivers/mailbox/Makefile                    |   2 +
>   drivers/mailbox/gunyah-msgq.c               | 209 ++++++++++++++++++++
>   include/linux/gunyah.h                      |  57 ++++++
>   4 files changed, 276 insertions(+)
>   create mode 100644 drivers/mailbox/gunyah-msgq.c
> 
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> index b352918ae54b..70d82a4ef32d 100644
> --- a/Documentation/virt/gunyah/message-queue.rst
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -61,3 +61,11 @@ vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
>         |               |         |                 |         |               |
>         |               |         |                 |         |               |
>         +---------------+         +-----------------+         +---------------+
> +
> +Gunyah message queues are exposed as mailboxes. To create the mailbox, create
> +a mbox_client and call `gh_msgq_init()`. On receipt of the RX_READY interrupt,
> +all messages in the RX message queue are read and pushed via the `rx_callback`
> +of the registered mbox_client.
> +
> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
> +   :identifiers: gh_msgq_init
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index fc9376117111..5f929bb55e9a 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>   
>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
>   
> +obj-$(CONFIG_GUNYAH)		+= gunyah-msgq.o
> +
>   obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>   
>   obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
> diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.c
> new file mode 100644
> index 000000000000..1989298653f9
> --- /dev/null
> +++ b/drivers/mailbox/gunyah-msgq.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
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
> +static irqreturn_t gh_msgq_rx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +	struct gh_msgq_rx_data rx_data;
> +	enum gh_error gh_error;
> +	bool ready = true;
> +
> +	while (ready) {
> +		gh_error = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
> +				&rx_data.data, sizeof(rx_data.data),
> +				&rx_data.length, &ready);
> +		if (gh_error != GH_ERROR_OK) {
> +			if (gh_error != GH_ERROR_MSGQUEUE_EMPTY)
> +				dev_warn(msgq->mbox.dev, "Failed to receive data: %d\n", gh_error);
> +			break;
> +		}
> +		mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Fired when message queue transitions from "full" to "space available" to send messages */
> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Fired after sending message and hypercall told us there was more space available. */
> +static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
> +{
> +	struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, txdone_tasklet);
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_ret);
> +}
> +
> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct gh_msgq *msgq = mbox_chan_to_msgq(chan);
> +	struct gh_msgq_tx_data *msgq_data = data;
> +	u64 tx_flags = 0;
> +	enum gh_error gh_error;
> +	bool ready;
> +
> +	if (msgq_data->push)
> +		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
> +
> +	gh_error = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_data->length, msgq_data->data,
> +						tx_flags, &ready);
> +
> +	/**
> +	 * unlikely because Linux tracks state of msgq and should not try to
> +	 * send message when msgq is full.
> +	 */
> +	if (unlikely(gh_error == GH_ERROR_MSGQUEUE_FULL))
> +		return -EAGAIN;
> +
> +	/**
> +	 * Propagate all other errors to client. If we return error to mailbox
> +	 * framework, then no other messages can be sent and nobody will know
> +	 * to retry this message.

If you weren't using the mailbox framework, would you be
sending the error to the client in this case?  (I'm just
curious; it's good to document the behavior if you were
to return it to the mailbox framework.)

> +	 */
> +	msgq->last_ret = gh_remap_error(gh_error);
> +
> +	/**
> +	 * This message was successfully sent, but message queue isn't ready to
> +	 * accept more messages because it's now full. Mailbox framework
> +	 * requires that we only report that message was transmitted when
> +	 * we're ready to transmit another message. We'll get that in the form
> +	 * of tx IRQ once the other side starts to drain the msgq.

So you are forced to delay reporting the completion
here because you're using the mailbox framework.

> +	 */
> +	if (gh_error == GH_ERROR_OK) {
> +		if (!ready)
> +			return 0;
> +	} else
> +		dev_err(msgq->mbox.dev, "Failed to send data: %d (%d)\n", gh_error, msgq->last_ret);
> +
> +	/**
> +	 * We can send more messages. Mailbox framework requires that tx done
> +	 * happens asynchronously to sending the message. Gunyah message queues
> +	 * tell us right away on the hypercall return whether we can send more
> +	 * messages. To work around this, defer the txdone to a tasklet.
> +	 */

If you weren't using the mailbox framework, you'd send the next
message directly rather than scheduling this tasklet to do it.

> +	tasklet_schedule(&msgq->txdone_tasklet);
> +
> +	return 0;
> +}
> +
> +static struct mbox_chan_ops gh_msgq_ops = {
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
> + * At least one of tx_ghrsc and rx_ghrsc must be not NULL. Most message queue use cases come with
> + * a pair of message queues to facilitate bidirectional communication. When tx_ghrsc is set,
> + * the client can send messages with mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
> + * is set, the mbox_client must register an .rx_callback() and the message queue driver will
> + * deliver all available messages upon receiving the RX ready interrupt. The messages should be
> + * consumed or copied by the client right away as the gh_msgq_rx_data will be replaced/destroyed
> + * after the callback.
> + *
> + * Returns - 0 on success, negative otherwise
> + */
> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
> +		 struct gh_resource *tx_ghrsc, struct gh_resource *rx_ghrsc)
> +{
> +	int ret;
> +
> +	/* Must have at least a tx_ghrsc or rx_ghrsc and that they are the right device types */
> +	if ((!tx_ghrsc && !rx_ghrsc) ||
> +	    (tx_ghrsc && tx_ghrsc->type != GH_RESOURCE_TYPE_MSGQ_TX) ||
> +	    (rx_ghrsc && rx_ghrsc->type != GH_RESOURCE_TYPE_MSGQ_RX))
> +		return -EINVAL;
> +
> +	if (!gh_api_has_feature(GH_FEATURE_MSGQUEUE))
> +		return -EOPNOTSUPP;
> +
> +	msgq->tx_ghrsc = tx_ghrsc;
> +	msgq->rx_ghrsc = rx_ghrsc;
> +
> +	msgq->mbox.dev = parent;
> +	msgq->mbox.ops = &gh_msgq_ops;
> +	msgq->mbox.num_chans = 1;
> +	msgq->mbox.txdone_irq = true;
> +	msgq->mbox.chans = &msgq->mbox_chan;
> +
> +	if (msgq->tx_ghrsc) {
> +		ret = request_irq(msgq->tx_ghrsc->irq, gh_msgq_tx_irq_handler, 0, "gh_msgq_tx",
> +				msgq);
> +		if (ret)
> +			goto err_chans;
> +	}
> +
> +	if (msgq->rx_ghrsc) {
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
> +	if (msgq->rx_ghrsc)
> +		free_irq(msgq->rx_ghrsc->irq, msgq);
> +err_tx_irq:
> +	if (msgq->tx_ghrsc)
> +		free_irq(msgq->tx_ghrsc->irq, msgq);
> +err_chans:
> +	kfree(msgq->mbox.chans);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(gh_msgq_init);
> +
> +void gh_msgq_remove(struct gh_msgq *msgq)
> +{
> +	tasklet_kill(&msgq->txdone_tasklet);
> +	mbox_controller_unregister(&msgq->mbox);
> +
> +	if (msgq->rx_ghrsc)
> +		free_irq(msgq->rx_ghrsc->irq, msgq);
> +
> +	if (msgq->tx_ghrsc)
> +		free_irq(msgq->tx_ghrsc->irq, msgq);
> +
> +	kfree(msgq->mbox.chans);
> +}
> +EXPORT_SYMBOL_GPL(gh_msgq_remove);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Gunyah Message Queue Driver");
> diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
> index 18cfbf5ee48b..378bec0f2ce1 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -8,11 +8,68 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/errno.h>
> +#include <linux/interrupt.h>
>   #include <linux/limits.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
>   #include <linux/types.h>
>   
> +/* Follows resource manager's resource types for VM_GET_HYP_RESOURCES */

I'm not sure what you mean by "Follows" here.  You mean that these are
the gh_rm_hyp_resource type values that GET_HYP_RESOURCES can return?

Note that gh_resource_type values must fit in an 8 bit field.

> +enum gh_resource_type {
> +	GH_RESOURCE_TYPE_BELL_TX	= 0,
> +	GH_RESOURCE_TYPE_BELL_RX	= 1,
> +	GH_RESOURCE_TYPE_MSGQ_TX	= 2,
> +	GH_RESOURCE_TYPE_MSGQ_RX	= 3,

Fix alignment below.

> +	GH_RESOURCE_TYPE_VCPU	= 4,
> +};
> +
> +struct gh_resource {
> +	enum gh_resource_type type;
> +	u64 capid;
> +	unsigned int irq;
> +};
> +
> +/**
> + * Gunyah Message Queues
> + */
> +
> +#define GH_MSGQ_MAX_MSG_SIZE	240

Maybe insert another tab the before 240.  You later define
GH_BELL_NONBLOCK that far out, and aligning them will look
better.

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
> +	struct gh_resource *tx_ghrsc;
> +	struct gh_resource *rx_ghrsc;
> +
> +	/* msgq private */
> +	int last_ret; /* Linux error, not GH_STATUS_* */
> +	struct mbox_chan mbox_chan;
> +	struct mbox_controller mbox;
> +	struct tasklet_struct txdone_tasklet;
> +};
> +
> +
> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct mbox_client *cl,
> +		     struct gh_resource *tx_ghrsc, struct gh_resource *rx_ghrsc);
> +void gh_msgq_remove(struct gh_msgq *msgq);
> +
> +static inline struct mbox_chan *gh_msgq_chan(struct gh_msgq *msgq)
> +{
> +	return &msgq->mbox.chans[0];
> +}
> +
>   /******************************************************************************/
>   /* Common arch-independent definitions for Gunyah hypercalls                  */
> +
>   #define GH_CAPID_INVAL	U64_MAX
>   #define GH_VMID_ROOT_VM	0xff
>   

