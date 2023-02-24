Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4346A1781
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjBXHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:49:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E724DE3E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:49:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q16so2629804wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbxEvBcANfCyv04vVI+P20GroH/CL1OZ8pzexawzCPA=;
        b=tnQWyJSxP15q1apDQgYJZl7TiYEzVSdSDue1GfVVOaD0fB7R0X/Bpt/P+s54EvMarj
         Y1GC+LfEvoa4d+LHbYhq1lLahNstbjvLM3CPlLNdcTMWd+6fEpU5pCFUdd1VfeuNgKwk
         ibvjVqYpxqAiwq34+4XApexuqjYGbp4gt7qZw1iuaxGK1TvncfYmapRjGkD85NIMMmmP
         NbuQi4uWSQWuuy9ihIFez+nKuGnq8M3VjfTqgeRzTTrLM/7QimIK9UBuRM43t1GjyADK
         yey+QqJZp4HrIHUMyIt6xRNdgPgUO0A11h1Oks2iBavOIBt53d+FQQPLO4ynnVsaUe+U
         aQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbxEvBcANfCyv04vVI+P20GroH/CL1OZ8pzexawzCPA=;
        b=i4en5iOh3hRuzROKn6Z224oIicoyKV6AgCtEXcJNjrlNJIVak9OwiNQjY8VcdRjEjA
         7eeV3an9ttuRANq2I7HGFGxe0+0FBV2YcMal+VhCJSYMrz0uwRlIUVnw1uDo+iztDY8K
         MW524i+PjnC4wrfIEKWfdMnr02zSvsgKPQZrdhhWu89Aiu8+A0qaNlaFN42LDRAZiQK7
         5pA0fBGR0c0wbsDy9mia4FiJ1KlKOvaZUZ+5VjqfLE0gd7xF0YO7AgWwUkDmAnny0GO+
         /H39gK9P+1n0jo1+s2EuFFO9FOgRaN0/YDUZnywAeiLKzVEGDpiFoJvijNGSdgI6eHsP
         0z6Q==
X-Gm-Message-State: AO0yUKW6LR4UR6RPO54GFxTB/ufgUOx3ai5+iLOCdQxOnWuGfpgy4sU8
        BTBNehuM7Oq2BFk3IdBMcyaZFQ==
X-Google-Smtp-Source: AK7set/nHyhaRUq0Yd+9Qdd+3r2tbNOhcXsgs9HAHAccmP/VT5YKMYKugqE9ITyi4t9jCFYpx+UWhg==
X-Received: by 2002:a05:6000:98c:b0:2c5:5ee9:6b27 with SMTP id by12-20020a056000098c00b002c55ee96b27mr11889818wrb.13.1677224973014;
        Thu, 23 Feb 2023 23:49:33 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j21-20020a5d6e55000000b002c3f81c51b6sm13600444wrz.90.2023.02.23.23.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 23:49:32 -0800 (PST)
Message-ID: <78fc83d7-a31b-c6bd-4e08-f0696e0a275b@linaro.org>
Date:   Fri, 24 Feb 2023 07:49:31 +0000
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
 <7e3170e4-c530-0b5b-903f-e5ea6d8268dc@linaro.org>
 <d42cba3e-db22-5241-0ae2-ccec3b811a5a@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <d42cba3e-db22-5241-0ae2-ccec3b811a5a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2023 23:15, Elliot Berman wrote:
> 
> 
> On 2/23/2023 2:25 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 23/02/2023 00:15, Elliot Berman wrote:
>>>
>>>
>>> On 2/20/2023 5:59 AM, Srinivas Kandagatla wrote:
>>>>
>>>>
>>>> On 14/02/2023 21:23, Elliot Berman wrote:
>>>>> Gunyah message queues are a unidirectional inter-VM pipe for 
>>>>> messages up
>>>>> to 1024 bytes. This driver supports pairing a receiver message 
>>>>> queue and
>>>>> a transmitter message queue to expose a single mailbox channel.
>>>>>
>>>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>>>> ---
>>>>>   Documentation/virt/gunyah/message-queue.rst |   8 +
>>>>>   drivers/mailbox/Makefile                   |   2 +
>>>>>   drivers/mailbox/gunyah-msgq.c               | 214 
>>>>> ++++++++++++++++++++
>>>>>   include/linux/gunyah.h                      |  56 +++++
>>>>>   4 files changed, 280 insertions(+)
>>>>>   create mode 100644 drivers/mailbox/gunyah-msgq.c
>>>>>
>>>>> diff --git a/Documentation/virt/gunyah/message-queue.rst 
>>>>> b/Documentation/virt/gunyah/message-queue.rst
>>>>> index 0667b3eb1ff9..082085e981e0 100644
>>>>> --- a/Documentation/virt/gunyah/message-queue.rst
>>>>> +++ b/Documentation/virt/gunyah/message-queue.rst
>>>>> @@ -59,3 +59,11 @@ vIRQ: two TX message queues will have two vIRQs 
>>>>> (and two capability IDs).
>>>>>         |               |         |                 | 
>>>>> |               |
>>>>>         |               |         |                 | 
>>>>> |               |
>>>>>         +---------------+         +-----------------+ 
>>>>> +---------------+
>>>>> +
>>>>> +Gunyah message queues are exposed as mailboxes. To create the 
>>>>> mailbox, create
>>>>> +a mbox_client and call `gh_msgq_init`. On receipt of the RX_READY 
>>>>> interrupt,
>>>>> +all messages in the RX message queue are read and pushed via the 
>>>>> `rx_callback`
>>>>> +of the registered mbox_client.
>>>>> +
>>>>> +.. kernel-doc:: drivers/mailbox/gunyah-msgq.c
>>>>> +   :identifiers: gh_msgq_init
>>>>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>>>>> index fc9376117111..5f929bb55e9a 100644
>>>>> --- a/drivers/mailbox/Makefile
>>>>> +++ b/drivers/mailbox/Makefile
>>>>> @@ -55,6 +55,8 @@ obj-$(CONFIG_MTK_CMDQ_MBOX)    += mtk-cmdq-mailbox.o
>>>>>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)    += zynqmp-ipi-mailbox.o
>>>>> +obj-$(CONFIG_GUNYAH)        += gunyah-msgq.o
>>>>
>>>> Why are we reusing CONFIG_GUNYAH Kconfig symbol for mailbox, why not 
>>>> CONFIG_GUNYAH_MBOX?
>>>>
>>>
>>> There was some previous discussion about this:
>>>
>>> https://lore.kernel.org/all/2a7bb5f2-1286-b661-659a-a5037150eae8@quicinc.com/
>>>
>>>>> +
>>>>>   obj-$(CONFIG_SUN6I_MSGBOX)    += sun6i-msgbox.o
>>>>>   obj-$(CONFIG_SPRD_MBOX)       += sprd-mailbox.o
>>>>> diff --git a/drivers/mailbox/gunyah-msgq.c 
>>>>> b/drivers/mailbox/gunyah-msgq.c
>>>>> new file mode 100644
>>>>> index 000000000000..03ffaa30ce9b
>>>>> --- /dev/null
>>>>> +++ b/drivers/mailbox/gunyah-msgq.c
>>>>> @@ -0,0 +1,214 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>>>> rights reserved.
>>>>> + */
>>>>> +
>>>>> +#include <linux/mailbox_controller.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/interrupt.h>
>>>>> +#include <linux/gunyah.h>
>>>>> +#include <linux/printk.h>
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/slab.h>
>>>>> +#include <linux/wait.h>
>>>>
>>>> ...
>>>>
>>>>> +/* Fired when message queue transitions from "full" to "space 
>>>>> available" to send messages */
>>>>> +static irqreturn_t gh_msgq_tx_irq_handler(int irq, void *data)
>>>>> +{
>>>>> +    struct gh_msgq *msgq = data;
>>>>> +
>>>>> +    mbox_chan_txdone(gh_msgq_chan(msgq), 0);
>>>>> +
>>>>> +    return IRQ_HANDLED;
>>>>> +}
>>>>> +
>>>>> +/* Fired after sending message and hypercall told us there was 
>>>>> more space available. */
>>>>> +static void gh_msgq_txdone_tasklet(struct tasklet_struct *tasklet)
>>>>
>>>> Tasklets have been long deprecated, consider using workqueues in 
>>>> this particular case.
>>>>
>>>
>>> Workqueues have higher latency and tasklets came as recommendation 
>>> from Jassi. drivers/mailbox/imx-mailbox.c uses tasklets in the same way.
>>>
>>> I did some quick unscientific measurements of ~1000x samples. The 
>>> median latency for resource manager went from 25.5 us (tasklet) to 26 
>>> us (workqueue) (2% slower). The mean went from 28.7 us to 32.5 us 
>>> (13% slower). Obviously, the outliers for workqueues were much more 
>>> extreme.
>>
>> TBH, this is expected because we are only testing resource manager, 
>> Note   the advantage that you will see shifting from tasket to 
>> workqueues is on overall system latencies and some drivers performance 
>> that need to react to events.
>>
>> please take some time to read this nice article about this 
>> https://lwn.net/Articles/830964/
>>
> 
> Hmm, this article is from 2020 and there was another effort in 2007. 
> Neither seems to have succeeded. I'd like to stick to same mechanisms as 
> other mailbox controllers.

I don't want to block this series because of this. We will have more 
opportunity to improve this once some system wide profiling is done.

AFAIU, In this system we will have atleast 2 tasklets between VM and RM 
and 2 per inter-vm, so if the number of tasklets increase in the system 
will be potentially spending more time in soft irq handling it.

At somepoint in time its good to get some profiling done using 
bcc/softirqs to see how much time is spent on softirqs.


--srini

> 
> Jassi, do you have any preferences?
> 
> Thanks,
> Elliot
> 
> 
