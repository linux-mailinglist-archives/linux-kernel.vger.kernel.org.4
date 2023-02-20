Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05769CE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjBTN7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjBTN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:59:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3E1DB8A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:59:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l38-20020a05600c1d2600b003dff4480a17so727088wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+EtAssA2uIVYju8xVugRuid67munGGrBVJ6FX1hjpME=;
        b=khhxdHwRm9hQoHObyWlrqw3km+HVAIUmpma+UktbsQI9OXZANOUS89n2MbrbpUAB0J
         yoK14JtzI/pl9RwNZPv7Ov5xUTh9yIVKR1vsaL3MACGiPSxNYc8ocMHeq/jVFc8FT7Z9
         UNSLpfECfZ29mN/j3Bzn7RHoJLe/FkbY08nGmzfG79wl4ahzoQkGrpjxen3xdg0ls/PM
         s009am+2bGNE83SduuBXOM86AAk1iXRGm/fuJGl6BivLS6O/Mk87DCx1sRNWk7rCPIdP
         FQwUi8v9rXjWlTJZwjZm2zBXKJcZwdeYYIiYoFfJoQ9b196FrXysPaFhVEz9XHwMORfa
         1Rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+EtAssA2uIVYju8xVugRuid67munGGrBVJ6FX1hjpME=;
        b=SRAn/PYwt+EO24+YSQiHWFAS4TzKDZpWpxa+9Ipgrm0MF2bqiCuRenupYb0zOh6xFZ
         z7g6RdlQqV1UFsQWw1vxHlGmgJUWXXZs8cFbFh7J/z/j0USmGLwf83/dZahTPl9E/SaW
         HZC9PDk+txpgipk50FA3AbV97ol4PpIX77AIhDeE2jvLt3tJeOb/Fsl4hbkuiIAM2svz
         TAOhfmaiHIy8LXWFJf65pkG0kYIuQIesR9+zgkFFf3TBNKaNjODJ6+3GdrwD0PJBKSe0
         PgT4W2FvDAC+mPDMu0SuCHL1AbiEOCmI981AiiyDQW0Zmncs1v36lwyC2yYvKEgk51fR
         YpQg==
X-Gm-Message-State: AO0yUKUpdBK0j5OLoSfLtWW9tv/9XBpC7Z4BC869AZthd4RqkHivC8Yd
        ofFwfZIV4N76CvlLYJexovJXjw==
X-Google-Smtp-Source: AK7set/XaSIF32pD4KWX97DlEmTa9e6GDBUHBybnZuS1jZ546f8NlqOL6r51YzUyGlO3cqEg1XNgdg==
X-Received: by 2002:a05:600c:13ca:b0:3df:fa96:f670 with SMTP id e10-20020a05600c13ca00b003dffa96f670mr917214wmg.22.1676901545229;
        Mon, 20 Feb 2023 05:59:05 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id z20-20020a7bc7d4000000b003daf6e3bc2fsm1386262wmk.1.2023.02.20.05.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:59:04 -0800 (PST)
Message-ID: <c8161a4c-fa45-cb9e-7211-5486ece1fc2d@linaro.org>
Date:   Mon, 20 Feb 2023 13:59:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v10 07/26] mailbox: Add Gunyah message queue mailbox
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212316.3309053-1-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230214212316.3309053-1-quic_eberman@quicinc.com>
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
> Gunyah message queues are a unidirectional inter-VM pipe for messages up
> to 1024 bytes. This driver supports pairing a receiver message queue and
> a transmitter message queue to expose a single mailbox channel.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/message-queue.rst |   8 +
>   drivers/mailbox/Makefile                    |   2 +
>   drivers/mailbox/gunyah-msgq.c               | 214 ++++++++++++++++++++
>   include/linux/gunyah.h                      |  56 +++++
>   4 files changed, 280 insertions(+)
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
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index fc9376117111..5f929bb55e9a 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>   
>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
>   
> +obj-$(CONFIG_GUNYAH)		+= gunyah-msgq.o

Why are we reusing CONFIG_GUNYAH Kconfig symbol for mailbox, why not 
CONFIG_GUNYAH_MBOX?

> +
>   obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>   
>   obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
> diff --git a/drivers/mailbox/gunyah-msgq.c b/drivers/mailbox/gunyah-msgq.c
> new file mode 100644
> index 000000000000..03ffaa30ce9b
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

...

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

Tasklets have been long deprecated, consider using workqueues in this 
particular case.


> +{
> +	struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, txdone_tasklet);
> +
> +	mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_ret);
> +}
> +
> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
> +{
..

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
> +		pr_err("Unrecognized gunyah version: %u. Currently supported: %d\n",
dev_err(parent

would make this more useful

> +			gh_api_version(), GUNYAH_API_V1);
> +		return -EOPNOTSUPP;
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
> +	msgq->mbox.txdone_irq = true;
> +	msgq->mbox.chans = kcalloc(msgq->mbox.num_chans, sizeof(*msgq->mbox.chans), GFP_KERNEL);
> +	if (!msgq->mbox.chans)
> +		return -ENOMEM;
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
