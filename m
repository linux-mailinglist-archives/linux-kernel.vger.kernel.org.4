Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF69A61EAEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 07:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKGGYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 01:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiKGGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 01:24:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC0AE0FB;
        Sun,  6 Nov 2022 22:24:49 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5Lhh3lfTzpVtp;
        Mon,  7 Nov 2022 14:21:08 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:24:46 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 14:24:45 +0800
Message-ID: <09e0a108-9f22-a9a0-2145-a81936745887@huawei.com>
Date:   Mon, 7 Nov 2022 14:24:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
To:     Robbie King <robbiek@xsightlabs.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <huangdaode@huawei.com>,
        <tanxiaofei@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221027155323.7xmpjfrh7qmil6o3@bogus>
 <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
 <20221031104036.bv6a7i6hxrmtpj23@bogus>
 <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
 <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
 <20221104151530.44sms3fnarqnvvsl@bogus>
 <ca35058d-1f40-3f85-9e2d-bfb29c8625cb@xsightlabs.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <ca35058d-1f40-3f85-9e2d-bfb29c8625cb@xsightlabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/4 23:39, Robbie King 写道:
> On 11/4/2022 11:15 AM, Sudeep Holla wrote:
>> On Fri, Nov 04, 2022 at 11:04:22AM -0400, Robbie King wrote:
>>> Hello Huisong, your raising of the shared interrupt issue is very 
>>> timely, I
>>> am working to implement "Extended PCC subspaces (types 3 and 4)" 
>>> using PCC
>>> on the ARM RDN2 reference platform as a proof of concept, and 
>>> encountered
>>> this issue as well.  FWIW, I am currently testing using Sudeep's 
>>> patch with
>>> the "chan_in_use" flag removed, and so far have not encountered any 
>>> issues.
>>>
>>
>> Interesting, do you mean the patch I post in this thread but without the
>> whole chan_in_use flag ?
>
> That's right, diff I'm running with is attached to end of message.
Hello Robbie, In multiple subspaces scenario, there is a problem
that OS doesn't know which channel should respond to the interrupt
if no this chan_in_use flag. If you have not not encountered any
issues in this case, it may be related to your register settings.

@Sudeep, what shoud we do next?
>
>>
>>> I think the RDN2 may provide an example of a write only interrupt
>>> acknowledge mechanism mentioned by Sudeep.
>>>
>>
>> Yes.
>>
>>> The RDN2 reference design uses the MHUv2 IP for the doorbell 
>>> mechanism.  If
>>> my implementation is correct (and it quite possibly is not), 
>>> acknowledging
>>> the DB interrupt from the platform is accomplished by writing a 1 to 
>>> the
>>> appropriate bit in the receiver channel window CH_CLR register, 
>>> which is
>>> documented as:
>>>
>>>    Channel flag clear.
>>>    Write 0b1 to a bit clears the corresponding bit in the CH_ST and 
>>> CH_ST_MSK.
>>>    Writing 0b0 has no effect.
>>>    Each bit always reads as 0b0.
>>>
>>
>> Correct, on this MHUv[1-2], it is write only register and it reads zero.
>> So basically you will ignore the interrupt if we apply the logic Huisong
>> proposed initially.
>>
>>> in the "Arm Corstone SSE-700 Subsystem Technical Reference Manual".
>>>
>>> Apologies if I am off in the weeds here as I have only been working 
>>> with
>>> PCC/SCMI for a very short period of time.
>>
>> Good to know info :).
>>
>
> It helps that your linux / firmware code is easy to follow! :)
>
> One other minor issue I encountered was that a NULL GAS (all zeros) 
> doesn't
> seem to be supported by pcc_chan_reg_init, may be a good opportunity 
> for me
> to submit my first RFC...
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index ed18936b8ce6..3fa7335d15b0 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -100,6 +100,7 @@ struct pcc_chan_info {
>         struct pcc_chan_reg cmd_update;
>         struct pcc_chan_reg error;
>         int plat_irq;
> +       unsigned int plat_irq_flags;
>  };
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index ed18936b8ce6..3fa7335d15b0 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -100,6 +100,7 @@ struct pcc_chan_info {
>         struct pcc_chan_reg cmd_update;
>         struct pcc_chan_reg error;
>         int plat_irq;
> +       unsigned int plat_irq_flags;
>  };
>
>  #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
> @@ -221,6 +222,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 
> flags)
>         return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>  }
>
> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
> +{
> +       return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
> +               ACPI_LEVEL_SENSITIVE;
> +}
> +
>  /**
>   * pcc_mbox_irq - PCC mailbox interrupt handler
>   * @irq:       interrupt number
> @@ -310,9 +317,12 @@ pcc_mbox_request_channel(struct mbox_client *cl, 
> int subspace_id)
>
>         if (pchan->plat_irq > 0) {
>                 int rc;
> +               unsigned long irqflags;
>
> -               rc = devm_request_irq(dev, pchan->plat_irq, 
> pcc_mbox_irq, 0,
> -                                     MBOX_IRQ_NAME, chan);
> +               irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
> +                           IRQF_SHARED | IRQF_ONESHOT : 0;
> +               rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
> +                                     irqflags, MBOX_IRQ_NAME, chan);
>                 if (unlikely(rc)) {
>                         dev_err(dev, "failed to register PCC interrupt 
> %d\n",
>                                 pchan->plat_irq);
> @@ -458,6 +468,8 @@ static int pcc_parse_subspace_irq(struct 
> pcc_chan_info *pchan,
>                 return -EINVAL;
>         }
>
> +       pchan->plat_irq_flags = pcct_ss->flags;
> +
>         if (pcct_ss->header.type == 
> ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
>                 struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void 
> *)pcct_ss;
>
>
> .
