Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E8637151
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiKXD5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKXD5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:57:33 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A079B33;
        Wed, 23 Nov 2022 19:57:28 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NHkdF3hDjzJnqy;
        Thu, 24 Nov 2022 11:54:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 11:57:26 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 11:57:25 +0800
Subject: Re: [PATCH v2] doc: Fix htmldocs build warnings of stallwarn.rst
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>
References: <20221123120238.1904-1-thunder.leizhen@huawei.com>
 <Y34mIhHYjFFzywsk@debian.me>
 <32e46feb-20ee-b3b4-8c36-e6f8c295a4d6@huawei.com>
Message-ID: <6c5d82bc-f0bf-5cff-2eaa-58acd6aa78cd@huawei.com>
Date:   Thu, 24 Nov 2022 11:57:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <32e46feb-20ee-b3b4-8c36-e6f8c295a4d6@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/24 11:34, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/11/23 21:54, Bagas Sanjaya wrote:
>> On Wed, Nov 23, 2022 at 08:02:38PM +0800, Zhen Lei wrote:
>>> Documentation/RCU/stallwarn.rst:
>>> 401: WARNING: Literal block expected; none found.
>>> 428: WARNING: Literal block expected; none found.
>>> 445: WARNING: Literal block expected; none found.
>>> 459: WARNING: Literal block expected; none found.
>>> 468: WARNING: Literal block expected; none found.
>>>
>>> The literal block need to be indented, so add two spaces to each line.
>>
>> Indenting to match alignment of lists texts?
> 
> It's required by reStructuredText Markup Specification.
> 
> Indented Literal Blocks
> Indented literal blocks are indicated by indentation relative to the
> surrounding text (leading whitespace on each line). The literal block
> ends with the end of the indentation.
> 
> The surrounding text need to be indented, relative to the paragraphs
> above and below it and at the same level.
> 
>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> You miss crediting linux-next list, so please add:
>>
>> Link: https://lore.kernel.org/linux-next/20221123163255.48653674@canb.auug.org.au/
>> Fixes: 3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information")
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> OK, thanks.
> 
>>
>>> -The sampling period is shown as follows:
>>> -:<------------first timeout---------->:<-----second timeout----->:
>>> -:<--half timeout-->:<--half timeout-->:                          :
>>> -:                  :<--first period-->:                          :
>>> -:                  :<-----------second sampling period---------->:
>>> -:                  :                  :                          :
>>> -:          snapshot time point    1st-stall                  2nd-stall
>>> +The sampling period is shown as follows::
>>>  
>>> +  |<------------first timeout---------->|<-----second timeout----->|
>>> +  |<--half timeout-->|<--half timeout-->|                          |
>>> +  |                  |<--first period-->|                          |
>>> +  |                  |<-----------second sampling period---------->|
>>> +  |                  |                  |                          |
>>> +  |          snapshot time point    1st-stall                  2nd-stall
>>
>> The beginning pipe (|) on the last line of diagram above shouldn't be there
>> (axis label?).
> 
> OK, it might look better to delete it.
> 
> The text in literal block is treated as plain text.
> 
> 
>>
>>>  
>>>  The following describes four typical scenarios:
>>>  
>>> -1. A CPU looping with interrupts disabled.::
>>> +1. A CPU looping with interrupts disabled.
>>>  
>>> -   rcu:          hardirqs   softirqs   csw/system
>>> -   rcu:  number:        0          0            0
>>> -   rcu: cputime:        0          0            0   ==> 2500(ms)
>>> +   ::
>>> +
>>> +     rcu:          hardirqs   softirqs   csw/system
>>> +     rcu:  number:        0          0            0
>>> +     rcu: cputime:        0          0            0   ==> 2500(ms)
>>>  
>>>     Because interrupts have been disabled throughout the measurement
>>>     interval, there are no interrupts and no context switches.
>>> @@ -440,11 +442,11 @@ The following describes four typical scenarios:
>>>  
>>>     This is similar to the previous example, but with non-zero number of
>>>     and CPU time consumed by hard interrupts, along with non-zero CPU
>>> -   time consumed by in-kernel execution.::
>>> +   time consumed by in-kernel execution. ::
>>>  
>>> -   rcu:          hardirqs   softirqs   csw/system
>>> -   rcu:  number:      624          0            0
>>> -   rcu: cputime:       49          0         2446   ==> 2500(ms)
>>> +     rcu:          hardirqs   softirqs   csw/system
>>> +     rcu:  number:      624          0            0
>>> +     rcu: cputime:       49          0         2446   ==> 2500(ms)
>>>  
>>>     The fact that there are zero softirqs gives a hint that these were
>>>     disabled, perhaps via local_bh_disable().  It is of course possible
>>> @@ -454,20 +456,22 @@ The following describes four typical scenarios:
>>>  
>>>  3. A CPU looping with preemption disabled.
>>>  
>>> -   Here, only the number of context switches is zero.::
>>> +   Here, only the number of context switches is zero. ::
>>>  
>>> -   rcu:          hardirqs   softirqs   csw/system
>>> -   rcu:  number:      624         45            0
>>> -   rcu: cputime:       69          1         2425   ==> 2500(ms)
>>> +     rcu:          hardirqs   softirqs   csw/system
>>> +     rcu:  number:      624         45            0
>>> +     rcu: cputime:       69          1         2425   ==> 2500(ms)
>>>  
>>>     This situation hints that the stalled CPU was looping with preemption
>>>     disabled.
>>>  
>>> -4. No looping, but massive hard and soft interrupts.::
>>> +4. No looping, but massive hard and soft interrupts.
>>> +
>>> +   ::
>>>  
>>> -   rcu:          hardirqs   softirqs   csw/system
>>> -   rcu:  number:       xx         xx            0
>>> -   rcu: cputime:       xx         xx            0   ==> 2500(ms)
>>> +     rcu:          hardirqs   softirqs   csw/system
>>> +     rcu:  number:       xx         xx            0
>>> +     rcu: cputime:       xx         xx            0   ==> 2500(ms)
>>>  
>>>     Here, the number and CPU time of hard interrupts are all non-zero,
>>>     but the number of context switches and the in-kernel CPU time consumed
>>>
>>
>> Because paragraphs below the snippets directly refers to them,just use colon: 
> 
> This makes the style inconsistent when viewed on the web page. So I decided not
> to change it.
> 
> Take your advice and the end result will be as follows: (1 and 4 followed by a
> colon, 2 and 3 followed by a dot)
> 
> 1. A CPU looping with interrupts disabled:
> 2. A CPU looping with bottom halves disabled.
> 3. A CPU looping with preemption disabled.
> 4. No looping, but massive hard and soft interrupts:

Oh, I accept the suggestions for items 2 and 3.

> 
>>
>> ---- >8 ----
>>
>> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
>> index f15b766d39b8d9..4f6b91be03cfe0 100644
>> --- a/Documentation/RCU/stallwarn.rst
>> +++ b/Documentation/RCU/stallwarn.rst
>> @@ -423,9 +423,7 @@ The sampling period is shown as follows::
>>  
>>  The following describes four typical scenarios:
>>  
>> -1. A CPU looping with interrupts disabled.
>> -
>> -   ::
>> +1. A CPU looping with interrupts disabled::
>>  
>>       rcu:          hardirqs   softirqs   csw/system
>>       rcu:  number:        0          0            0
>> @@ -442,7 +440,7 @@ The following describes four typical scenarios:
>>  
>>     This is similar to the previous example, but with non-zero number of
>>     and CPU time consumed by hard interrupts, along with non-zero CPU
>> -   time consumed by in-kernel execution. ::
>> +   time consumed by in-kernel execution::
>>  
>>       rcu:          hardirqs   softirqs   csw/system
>>       rcu:  number:      624          0            0
>> @@ -456,7 +454,7 @@ The following describes four typical scenarios:
>>  
>>  3. A CPU looping with preemption disabled.
>>  
>> -   Here, only the number of context switches is zero. ::
>> +   Here, only the number of context switches is zero::
>>  
>>       rcu:          hardirqs   softirqs   csw/system
>>       rcu:  number:      624         45            0
>> @@ -465,9 +463,7 @@ The following describes four typical scenarios:
>>     This situation hints that the stalled CPU was looping with preemption
>>     disabled.
>>  
>> -4. No looping, but massive hard and soft interrupts.
>> -
>> -   ::
>> +4. No looping, but massive hard and soft interrupts::
>>  
>>       rcu:          hardirqs   softirqs   csw/system
>>       rcu:  number:       xx         xx            0
>>
>> Thanks.
>>
> 

-- 
Regards,
  Zhen Lei
