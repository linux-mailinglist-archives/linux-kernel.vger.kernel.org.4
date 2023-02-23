Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61B36A0618
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjBWKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjBWKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:25:14 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9F023672
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:25:12 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j2so10086063wrh.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILsJiQmAcGMco7NUgLTOCX0TG7re8hDAG5iO8fvr7a4=;
        b=TK8kcnTC+nImoJL65VRAhunMg8vM1exizc22cs8DXr1R/r+n/iyvPS49NLhUmQ8+VC
         +B7R2hVboQeqG5v6DjQxyIAVXIrILn0Uil5bHPLmuI5KjpMkRQB9IaFfUS/vmW21j4CS
         qYP3gxyi6uj4GIrnI5LbW/Xq/u0g9u42o8fHrG396hg6YwlkWvE3ELRThjZ48V+gjv3R
         kcUSVpid1pNlrQq0e1kFj9gRb3zPXCl7k7P0TIXvKvbhO85UFnR+Y9FibEAYNn1WVIWQ
         SbmMfGOp1B/9XGq8zgnROx3QR2oX98MpiKl8358NoJ0m+dXsoe840h6k3I3oupYQTnhv
         6v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILsJiQmAcGMco7NUgLTOCX0TG7re8hDAG5iO8fvr7a4=;
        b=2GEQdC6Xwp9vYxWJICjqPyBq9I9DUQLNVZe0JNtXo+DIPi/VfLvnKnripVbhjQ7EdA
         i8LViUauoh60I+NWoDHMmPVhSSw/QnXPeNy/U5hq8o51dHO8/kiaKLZmEDuTGBhJt+XS
         XObR+rWKzL7zJP0wiuu2F0eEhwoBBRJaZqcvRHiGqvMVSe+bhNio+N13ugMQYbHFa1Gm
         12leN6rdMDShfwRRV0D6g8XN3RvQZ3p64QRD6Vq1WWfMQPhF+2PT3099vqLLPrzjcfE6
         F/d0W661kIL+2mbjW7lNkmZRlJVf8elyXfh+RQa4RbILq9hghWnoPtNqp6hWSuxxzSWs
         PSuA==
X-Gm-Message-State: AO0yUKWi6gVElPdeqfJGWE3xWg93BMnFbZLDNF20xlTCc1gFNz3a+7A9
        H5VpYPJs1q86KtFiKFB2M/lnnQ==
X-Google-Smtp-Source: AK7set8DT7LYGd+BggBMdTTvDzh5kJcrtERcWSp8PmQ4OJsHb5Ia4iNw4ehu6zGRRm2nkiAsnY+I9Q==
X-Received: by 2002:a5d:6789:0:b0:2c5:5ed8:77d4 with SMTP id v9-20020a5d6789000000b002c55ed877d4mr8570791wru.57.1677147910458;
        Thu, 23 Feb 2023 02:25:10 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m4-20020a05600c40c400b003e223fe0a3asm10943246wmh.27.2023.02.23.02.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:25:09 -0800 (PST)
Message-ID: <7e3170e4-c530-0b5b-903f-e5ea6d8268dc@linaro.org>
Date:   Thu, 23 Feb 2023 10:25:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 07/26] mailbox: Add Gunyah message queue mailbox
Content-Language: en-US
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
 <c8161a4c-fa45-cb9e-7211-5486ece1fc2d@linaro.org>
 <576aed85-a566-3645-559e-06b2135cf57f@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <576aed85-a566-3645-559e-06b2135cf57f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2023 00:15, Elliot Berman wrote:
> 
> 
> On 2/20/2023 5:59 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 14/02/2023 21:23, Elliot Berman wrote:
>>> Gunyah message queues are a unidirectional inter-VM pipe for messages up
>>> to 1024 bytes. This driver supports pairing a receiver message queue and
>>> a transmitter message queue to expose a single mailbox channel.
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>>   Documentation/virt/gunyah/message-queue.rst |   8 +
>>>   drivers/mailbox/Makefile                   |   2 +
>>>   drivers/mailbox/gunyah-msgq.c               | 214 ++++++++++++++++++++
>>>   include/linux/gunyah.h                      |  56 +++++
>>>   4 files changed, 280 insertions(+)
>>>   create mode 100644 drivers/mailbox/gunyah-msgq.c
>>>
>>> diff --git a/Documentation/virt/gunyah/message-queue.rst 
>>> b/Documentation/virt/gunyah/message-queue.rst
>>> index 0667b3eb1ff9..082085e981e0 100644
>>> --- a/Documentation/virt/gunyah/message-queue.rst
>>> +++ b/Documentation/virt/gunyah/message-queue.rst
>>> @@ -59,3 +59,11 @@ vIRQ: two TX message queues will have two vIRQs 
>>> (and two capability IDs).
>>>         |               |         |                 | |               |
>>>         |               |         |                 | |               |
>>>         +---------------+         +-----------------+ +---------------+
>>> +
>>> +Gunyah message queues are exposed as mailboxes. To create the 
>>> mailbox, create
>>> +a mbox_client and call `gh_msgq_init`. On receipt of the RX_READY 
>>> interrupt,
>>> +all messages in the RX message queue are read and pushed via the 
>>> `rx_callback`
>>> +of the registered mbox_client.
>>> +
>>> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
>>> +   :identifiers: gh_msgq_init
>>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>>> index fc9376117111..5f929bb55e9a 100644
>>> --- a/drivers/mailbox/Makefile
>>> +++ b/drivers/mailbox/Makefile
>>> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)    += mtk-cmdq-mailbox.o
>>>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)    += zynqmp-ipi-mailbox.o
>>> +obj-$(CONFIG_GUNYAH)        += gunyah-msgq.o
>>
>> Why are we reusing CONFIG_GUNYAH Kconfig symbol for mailbox, why not 
>> CONFIG_GUNYAH_MBOX?
>>
> 
> There was some previous discussion about this:
> 
> https://lore.kernel.org/all/2a7bb5f2-1286-b661-659a-a5037150eae8@quicinc.com/
> 
>>> +
>>>   obj-$(CONFIG_SUN6I_MSGBOX)    += sun6i-msgbox.o
>>>   obj-$(CONFIG_SPRD_MBOX)       += sprd-mailbox.o
>>> diff --git a/drivers/mailbox/gunyah-msgq.c 
>>> b/drivers/mailbox/gunyah-msgq.c
>>> new file mode 100644
>>> index 000000000000..03ffaa30ce9b
>>> --- /dev/null
>>> +++ b/drivers/mailbox/gunyah-msgq.c
>>> @@ -0,0 +1,214 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>> rights reserved.
>>> + */
>>> +
>>> +#include <linux/mailbox_controller.h>
>>> +#include <linux/module.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/gunyah.h>
>>> +#include <linux/printk.h>
>>> +#include <linux/init.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/wait.h>
>>
>> ...
>>
>>> +/* Fired when message queue transitions from "full" to "space 
>>> available" to send messages */
>>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>>> +{
>>> +    struct gh_msgq *msgq = data;
>>> +
>>> +    mbox_chan_txdone(gh_msgq_chan(msgq), 0);
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +/* Fired after sending message and hypercall told us there was more 
>>> space available. */
>>> +static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
>>
>> Tasklets have been long deprecated, consider using workqueues in this 
>> particular case.
>>
> 
> Workqueues have higher latency and tasklets came as recommendation from 
> Jassi. drivers/mailbox/imx-mailbox.c uses tasklets in the same way.
> 
> I did some quick unscientific measurements of ~1000x samples. The median 
> latency for resource manager went from 25.5 us (tasklet) to 26 us 
> (workqueue) (2% slower). The mean went from 28.7 us to 32.5 us (13% 
> slower). Obviously, the outliers for workqueues were much more extreme.

TBH, this is expected because we are only testing resource manager, Note 
  the advantage that you will see shifting from tasket to workqueues is 
on overall system latencies and some drivers performance that need to 
react to events.

please take some time to read this nice article about this 
https://lwn.net/Articles/830964/


--srini
> 
>>
>>> +{
>>> +    struct gh_msgq *msgq = container_of(tasklet, struct gh_msgq, 
>>> txdone_tasklet);
>>> +
>>> +    mbox_chan_txdone(gh_msgq_chan(msgq), msgq->last_ret);
>>> +}
>>> +
>>> +static int gh_msgq_send_data(struct mbox_chan *chan, void *data)
>>> +{
>> ..
>>
>>> +    tasklet_schedule(&msgq->txdone_tasklet);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct mbox_chan_ops gh_msgq_ops = {
>>> +    .send_data = gh_msgq_send_data,
>>> +};
>>> +
>>> +/**
>>> + * gh_msgq_init() - Initialize a Gunyah message queue with an 
>>> mbox_client
>>> + * @parent: optional, device parent used for the mailbox controller
>>> + * @msgq: Pointer to the gh_msgq to initialize
>>> + * @cl: A mailbox client to bind to the mailbox channel that the 
>>> message queue creates
>>> + * @tx_ghrsc: optional, the transmission side of the message queue
>>> + * @rx_ghrsc: optional, the receiving side of the message queue
>>> + *
>>> + * At least one of tx_ghrsc and rx_ghrsc should be not NULL. Most 
>>> message queue use cases come with
>>> + * a pair of message queues to facilitate bidirectional 
>>> communication. When tx_ghrsc is set,
>>> + * the client can send messages with 
>>> mbox_send_message(gh_msgq_chan(msgq), msg). When rx_ghrsc
>>> + * is set, the mbox_client should register an .rx_callback() and the 
>>> message queue driver will
>>> + * push all available messages upon receiving the RX ready 
>>> interrupt. The messages should be
>>> + * consumed or copied by the client right away as the 
>>> gh_msgq_rx_data will be replaced/destroyed
>>> + * after the callback.
>>> + *
>>> + * Returns - 0 on success, negative otherwise
>>> + */
>>> +int gh_msgq_init(struct device *parent, struct gh_msgq *msgq, struct 
>>> mbox_client *cl,
>>> +             struct gunyah_resource *tx_ghrsc, struct 
>>> gunyah_resource *rx_ghrsc)
>>> +{
>>> +    int ret;
>>> +
>>> +    /* Must have at least a tx_ghrsc or rx_ghrsc and that they are 
>>> the right device types */
>>> +    if ((!tx_ghrsc && !rx_ghrsc) ||
>>> +        (tx_ghrsc && tx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_TX) ||
>>> +        (rx_ghrsc && rx_ghrsc->type != GUNYAH_RESOURCE_TYPE_MSGQ_RX))
>>> +        return -EINVAL;
>>> +
>>> +    if (gh_api_version() != GUNYAH_API_V1) {
>>> +        pr_err("Unrecognized gunyah version: %u. Currently 
>>> supported: %d\n",
>> dev_err(parent
>>
>> would make this more useful
>>
> 
> Done.
> 
> - Elliot
