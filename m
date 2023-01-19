Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24E6673F23
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjASQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjASQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:42:21 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9157E78A93
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674146538; x=1705682538;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=z9AcesbRfM8AyuvBswQAgK3Gx191bj3OeWXftzL4StA=;
  b=RQ5kdE4QTo+QzLUpyTMOqdLDl93yF+3om0hcwXqCssuaMMn0BMTI4Mwf
   DAWtuIbKXCMJXxG6JkzLVBFv1gUDR8XXaEqeCstjdzXddC8ZzOEnPa9T0
   dZ5NokDeRRY3N3bJ3P0We4EVRVMWdBzFPB4WDaGO8kTC1/MaAisdX0tIg
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Jan 2023 08:42:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:42:17 -0800
Received: from [10.216.7.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 08:42:16 -0800
Message-ID: <97f8d450-8f1b-c89d-f0eb-813d17744975@quicinc.com>
Date:   Thu, 19 Jan 2023 22:12:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: Query about IPI as NMI (pseudo-NMI) support patches
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>
References: <5bed08c5-8663-4e68-27b4-8b6d3957a880@quicinc.com>
 <86zgb07tfs.wl-maz@kernel.org>
 <a20a9592-05e7-c529-5ab1-d7d52fffa59a@quicinc.com>
 <86v8ln7bqw.wl-maz@kernel.org>
 <c40486a0-2e5f-bbdb-c93b-8740154fce78@quicinc.com>
In-Reply-To: <c40486a0-2e5f-bbdb-c93b-8740154fce78@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,


On 1/4/2023 9:19 PM, Mukesh Ojha wrote:
> Hi Marc,
> 
> Thanks for your patience in replying queries
> 
> On 1/3/2023 11:15 PM, Marc Zyngier wrote:
>> On Tue, 03 Jan 2023 16:45:04 +0000,
>> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>
>>> Hi,
>>>
>>> Thanks for your reply.
>>>
>>> On 1/2/2023 10:41 PM, Marc Zyngier wrote:
>>>> Hi Mukesh,
>>>>
>>>> On Mon, 02 Jan 2023 16:44:59 +0000,
>>>> Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>>>
>>>>> Hi Marc,
>>>>>
>>>>> I was looking similar support mentioned in below patch series.
>>>>>
>>>>> https://lore.kernel.org/lkml/CAFA6WYO0+LQ=mB1spCstt0cNZ0G+sZu_+Wrv6BKSeXqF5SRq4A@mail.gmail.com/#t 
>>>>>
>>>>>
>>>>> Wanted to check if there is chance of these patches to land in
>>>>> mainline ?
>>>>
>>>> I certainly have no intention to merge it as is, specially as there is
>>>> no good usage model for it other than "but think of debug!".
>>>>
>>>> We have exactly *one* SGI left. If we are going to lose it over such a
>>>> feature, I'd want a description of how we are going to share it
>>>> between potential users, and how we claw some currently used SGIs
>>>> back.
>>>
>>>
>>> But, looks like patch will fail if SGI is not available.
>>>
>>> https://lore.kernel.org/lkml/1604317487-14543-4-git-send-email-sumit.garg@linaro.org/ 
>>>
>>>
>>>
>>>
>>> set_smp_ipi_range(base_sgi, 8);
>>>
>>> +    if (n > nr_ipi)
>>> +        set_smp_dynamic_ipi(ipi_base + nr_ipi);
>>> +
>>>
>>> So, static SGI allocation still has higher priority than dynamic
>>> one.  Would you be accepting if we keep it under some
>>> CONFIG_ARM64_IPI_NMI_DEBUG ?
>>
>> But why should this thing have priority over other potential features?
>> As I said above, there are two requirements:
>>
>> - being able to share a single NMI SGI amongst multiple users
>>
>> - being able to free existing SGIs in case we absolutely need an SGI
>>    for some other purposes
>>
>> In both cases, this is about making the SGI space scale *beyond* the 8
>> possible interrupts that we have. This needs to be solved to get
>> something like this in.
> 
> Agree, we have shortage of SGI's, Will try to think if we can fix this.
> 
> However, I think IPI_CPU_STOP is something which can be used as an NMI, 
> As this will be used only(once) during panic()->send_smp_stop().
> 
> Can we do some special handling for IPI_CPU_STOP similar to pmu 
> interrupts like request it as NMI and fallback to normal irq if not 
> supported/on error ?

Can we do this ?

-Mukesh
> 
> 
>>
>> And I don't think hiding this behind an obscure "debug" configuration
>> option that will get abused with out of tree stuff is a good move.
>> Quite the opposite.
>>
> 
> Thanks, Make sense.
> 
>> Thanks,
>>
>>     M.
>>
> 
> -Mukesh
