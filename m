Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104D26879A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBBJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBBJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:59:17 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E7587D25
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:59:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q5so1209327wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHea8kyU+V/tcWLN+5K+aynGDqOYuX+1Dl2ZaVpPFKg=;
        b=MFBzdipPXKtdkcxhQzUed4P6WfvKxBjO0TtgDHWsyFCMK2nKN6/95UXNaSuL4WYsQN
         XTLAeiRM+9tgYqMZmUoe4FqPNlkUci62TfGNeSlSsdnV9BOpOluMoTrpLNeekuxSDw2A
         gvsKBmUVQHvdmt0aVeYUnNL0JaoEYEH+qMM0Lxgeouzm510qDkUBza8CUmXSS8/1IXOy
         VRNFV6nIzYTLsFjtb7YMZf1j0ohw6LEL5SSSLYZSkiu8QkLxoVJzo0zlt7XT5kh0D7Gl
         7Y1fwp2bqItIzF745xEzOK2wB3XP1FteYZemHss8cdkR9lSkPsXxi+F1wXcmCPh6Wqbp
         rcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHea8kyU+V/tcWLN+5K+aynGDqOYuX+1Dl2ZaVpPFKg=;
        b=2GmmD2n9Z9pA097xsMPbUHA5kKWBvvZDoGiiz+5cTu1VUPFzBGzrK5++qHTwgawaYl
         lbn6LAG8eqmIKBnvILsVIHOj/wQ2G2kSqiBqG+3pJnouHuf81ZonTdF9lmILVhrppOBC
         39GCvxVc9PlpHz5R/rzcvnNOFwn34M3pZj1emUojbtcUyZTN4gTzWCgfqpk3JCoe84AG
         ICp0+rnGEGj9Xb0xT2NTk9wSg9F+yLtNrwrc/SN9yHL42UHFjnhA4NMMYh8r7E0sYtUE
         I0KxVZDHBnXlsBSpqHrwqRvmLrySJWf/q+bIIKn+vuQ/1JRrPwKkGeq0ROIlg5Nha0Pt
         ECPQ==
X-Gm-Message-State: AO0yUKUAQpiyma2OdvpLWePTp26ZuDPoD5bBkhlNGtNh7PJL5VslJhyx
        k1DaiYK0qRx0p2lrpvhJ6QpCdA==
X-Google-Smtp-Source: AK7set+K1gY9InG0OadSWT9wI7lDZtoEXwN78191Z9C6Nt91Cvqchnzmy6P3BgVXSAcDMqWOdcoYfg==
X-Received: by 2002:a05:6000:2:b0:2bf:cbf0:e021 with SMTP id h2-20020a056000000200b002bfcbf0e021mr4594751wrx.71.1675331953785;
        Thu, 02 Feb 2023 01:59:13 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o6-20020adfe806000000b002bdf8dd6a8bsm19098512wrm.80.2023.02.02.01.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:59:12 -0800 (PST)
Message-ID: <e5acd00c-7a53-a789-8dab-a69cffda34f5@linaro.org>
Date:   Thu, 2 Feb 2023 09:59:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 08/27] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-9-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-9-quic_eberman@quicinc.com>
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



On 20/01/2023 22:46, Elliot Berman wrote:
> Gunyah message queues are a unidirectional inter-VM pipe for messages up
> to 1024 bytes. This driver supports pairing a receiver message queue and
> a transmitter message queue to expose a single mailbox channel.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/message-queue.rst |   8 +
>   MAINTAINERS                                 |   1 +
>   drivers/mailbox/Makefile                    |   2 +
>   drivers/mailbox/gunyah-msgq.c               | 214 ++++++++++++++++++++
>   include/linux/gunyah.h                      |  59 +++++-
>   5 files changed, 283 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/mailbox/gunyah-msgq.c
> 
> diff --git a/Documentation/virt/gunyah/message-queue.rst b/Documentation/virt/gunyah/message-queue.rst
> index 0667b3eb1ff9..082085e981e0 100644
> --- a/Documentation/virt/gunyah/message-queue.rst
> +++ b/Documentation/virt/gunyah/message-queue.rst
> @@ -59,3 +59,11 @@ vIRQ: two TX message queues will have two vIRQs (and two capability IDs).
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
> index fe19e71efc6d..d02e8abe6457 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9049,6 +9049,7 @@ S:	Supported
>   F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>   F:	Documentation/virt/gunyah/
>   F:	arch/arm64/gunyah/
> +F:	drivers/mailbox/gunyah-msgq.c
>   F:	drivers/virt/gunyah/
>   F:	include/linux/gunyah.h
>   
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
> index 000000000000..caa283f7248b
> --- /dev/null
> +++ b/drivers/mailbox/gunyah-msgq.c
> @@ -0,0 +1,214 @@
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
> +	unsigned long gh_err;
> +	bool ready = true;
> +
> +	while (ready) {
> +		gh_err = gh_hypercall_msgq_recv(msgq->rx_ghrsc->capid,
> +				(uintptr_t)&rx_data.data, sizeof(rx_data.data),
you should proabably use  GH_MSGQ_MAX_MSG_SIZE instead of calling sizeof 
for every loop.

> +				&rx_data.length, &ready);
> +		if (gh_err == GH_ERROR_OK) {
> +			mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
> +		} else if (gh_err == GH_ERROR_MSGQUEUE_EMPTY) {
> +			break;
> +		} else {
> +			pr_warn("Failed to receive data from msgq for %s: %zd\n",
> +				msgq->mbox.dev ? dev_name(msgq->mbox.dev) : "", gh_err);
> +			break;
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
How about making this more readable.
also use of gh_ in local variables is not really adding any value.

while (ready) {
	err = gh_hypercall_msgq_recv(...);
	if (err) {
		if (err != GH_ERROR_MSGQUEUE_EMPTY)
                 	dev_warn(msgq->mbox.dev, "Failed to receive data 
%zd\n", err);
         		break;

                }
	mbox_chan_received_data(gh_msgq_chan(msgq), &rx_data);
}


> +
> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
> +{
> +	struct gh_msgq *msgq = data;
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), 0);
What is this irq for? Is it for tx done ack?

> +
> +	return IRQ_HANDLED;
> +}
> +
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
> +	unsigned long ret;
> +	bool ready;
> +
> +	if (msgq_data->push)
> +		tx_flags |= GH_HYPERCALL_MSGQ_TX_FLAGS_PUSH;
> +
> +	ret = gh_hypercall_msgq_send(msgq->tx_ghrsc->capid, msgq_data->length,
> +					(uintptr_t)msgq_data->data, tx_flags, &ready);
> +
> +	/**
> +	 * unlikely because Linux tracks state of msgq and should not try to
> +	 * send message when msgq is full.
> +	 */
> +	if (unlikely(ret == GH_ERROR_MSGQUEUE_FULL))
> +		return -EAGAIN;
> +
> +	/**
> +	 * Propagate all other errors to client. If we return error to mailbox
> +	 * framework, then no other messages can be sent and nobody will know
> +	 * to retry this message.
> +	 */
> +	msgq->last_ret = gh_remap_error(ret);
> +
> +	/**
> +	 * This message was successfully sent, but message queue isn't ready to
> +	 * receive more messages because it's now full. Mailbox framework
> +	 * requires that we only report that message was transmitted when
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
> + * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most message queue use cases come with
> + * a pair of message queues to facilitate bidirectional communication. When tx_ghrsc is set,
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
> +		return -EINVAL;
> +
> +	if (gh_api_version() != GUNYAH_API_V1) {
> +		pr_warn("Unrecognized gunyah version: %u. Currently supported: %d\n",
> +			gh_api_version(), GUNYAH_API_V1);
how about using dev_err here?

> +		return -ENODEV;

-EOPNOTSUPP?

> +	}
> +
> +	if (!gh_api_has_feature(GH_API_FEATURE_MSGQUEUE))
> +		return -EOPNOTSUPP;
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

new line here would be nice.
> +	msgq->mbox.txdone_irq = true;
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

AFAIU, this looks like duplicating what core already has with 
TXDONE_BY_POLL.

can we not use
txdone_poll = true
and implement last_tx_done callback to use hrtimer from the core to tick tx.

--srini
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
> index b5f61c14ec1e..5d6fc9f88718 100644
> --- a/include/linux/gunyah.h
> +++ b/include/linux/gunyah.h
> @@ -8,10 +8,67 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/errno.h>
> +#include <linux/interrupt.h>
>   #include <linux/limits.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
>   #include <linux/types.h>
>   
> -/* Common Gunyah macros */
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
> +	int last_ret; /* Linux error, not GH_STATUS_* */
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
> +
>   #define GH_CAPID_INVAL	U64_MAX
>   #define GH_VMID_ROOT_VM	0xff
>   
