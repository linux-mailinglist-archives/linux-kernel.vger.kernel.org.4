Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1153F63A1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiK1HF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiK1HFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:05:23 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9509D55A2;
        Sun, 27 Nov 2022 23:05:22 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NLGgH0f7nz15MX4;
        Mon, 28 Nov 2022 15:04:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 15:05:20 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 15:05:19 +0800
Subject: Re: [PATCH v3] doc: Fix htmldocs build warnings of stallwarn.rst
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
References: <20221124062204.1932-1-thunder.leizhen@huawei.com>
 <Y4Q0Q8QPg1jp3r6C@debian.me>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4bc71aae-4ae6-7ea2-2f8a-6165cf6b5409@huawei.com>
Date:   Mon, 28 Nov 2022 15:05:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y4Q0Q8QPg1jp3r6C@debian.me>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/28 12:08, Bagas Sanjaya wrote:
> On Thu, Nov 24, 2022 at 02:22:03PM +0800, Zhen Lei wrote:
>> Documentation/RCU/stallwarn.rst:
>> 401: WARNING: Literal block expected; none found.
>> 428: WARNING: Literal block expected; none found.
>> 445: WARNING: Literal block expected; none found.
>> 459: WARNING: Literal block expected; none found.
>> 468: WARNING: Literal block expected; none found.
>>
>> The literal block need to be indented, so add two spaces to each line.
>>
> 
> What about following patch description below instead?
> 
> ```
> When merging rcu tree for linux-next, Stephen Rothwell reported htmldocs
> warnings:
> 
> <warnings>...
> 
> These are due to unindented literal blocks. Indent them to fix these
> warnings.
> ```

That's great. Thanks.

> 
>> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
>> index c1e92dfef40d501..ca7b7cd806a16c9 100644
>> --- a/Documentation/RCU/stallwarn.rst
>> +++ b/Documentation/RCU/stallwarn.rst
>> @@ -398,9 +398,9 @@ In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
>>  rcupdate.rcu_cpu_stall_cputime=1, the following additional information
>>  is supplied with each RCU CPU stall warning::
>>  
>> -rcu:          hardirqs   softirqs   csw/system
>> -rcu:  number:      624         45            0
>> -rcu: cputime:       69          1         2425   ==> 2500(ms)
>> +  rcu:          hardirqs   softirqs   csw/system
>> +  rcu:  number:      624         45            0
>> +  rcu: cputime:       69          1         2425   ==> 2500(ms)
>>  
> 
> OK.
>  
>> -The sampling period is shown as follows:
>> -:<------------first timeout---------->:<-----second timeout----->:
>> -:<--half timeout-->:<--half timeout-->:                          :
>> -:                  :<--first period-->:                          :
>> -:                  :<-----------second sampling period---------->:
>> -:                  :                  :                          :
>> -:          snapshot time point    1st-stall                  2nd-stall
>> +The sampling period is shown as follows::
>>  
>> +  |<------------first timeout---------->|<-----second timeout----->|
>> +  |<--half timeout-->|<--half timeout-->|                          |
>> +  |                  |<--first period-->|                          |
>> +  |                  |<-----------second sampling period---------->|
>> +  |                  |                  |                          |
>> +             snapshot time point    1st-stall                  2nd-stall
>>  
> 
> OK.
> 
>>  The following describes four typical scenarios:
>>  
>> -1. A CPU looping with interrupts disabled.::
>> +1. A CPU looping with interrupts disabled.
>>  
>> -   rcu:          hardirqs   softirqs   csw/system
>> -   rcu:  number:        0          0            0
>> -   rcu: cputime:        0          0            0   ==> 2500(ms)
>> +   ::
>> +
>> +     rcu:          hardirqs   softirqs   csw/system
>> +     rcu:  number:        0          0            0
>> +     rcu: cputime:        0          0            0   ==> 2500(ms)
> 
> OK.
> 
>>     This is similar to the previous example, but with non-zero number of
>>     and CPU time consumed by hard interrupts, along with non-zero CPU
>> -   time consumed by in-kernel execution.::
>> +   time consumed by in-kernel execution::
>>  
>> -   rcu:          hardirqs   softirqs   csw/system
>> -   rcu:  number:      624          0            0
>> -   rcu: cputime:       49          0         2446   ==> 2500(ms)
>> +     rcu:          hardirqs   softirqs   csw/system
>> +     rcu:  number:      624          0            0
>> +     rcu: cputime:       49          0         2446   ==> 2500(ms)
> 
> OK.
> 
>>  
>>  3. A CPU looping with preemption disabled.
>>  
>> -   Here, only the number of context switches is zero.::
>> +   Here, only the number of context switches is zero::
>>  
>> -   rcu:          hardirqs   softirqs   csw/system
>> -   rcu:  number:      624         45            0
>> -   rcu: cputime:       69          1         2425   ==> 2500(ms)
>> +     rcu:          hardirqs   softirqs   csw/system
>> +     rcu:  number:      624         45            0
>> +     rcu: cputime:       69          1         2425   ==> 2500(ms)
> 
> OK.
> 
>>  
>>     This situation hints that the stalled CPU was looping with preemption
>>     disabled.
>>  
>> -4. No looping, but massive hard and soft interrupts.::
>> +4. No looping, but massive hard and soft interrupts.
>> +
>> +   ::
> 
> No, no that way. For consistency, the item sentence should also be end with
> double colon marker:

If you open Documentation/output/RCU/stallwarn.html on a web page, you'll find
that my current change is correct. Indented paragraphs are displayed in smaller
fonts. I want the following four sentences to end with a dot. Subparagraphs that
are subordinate to them are additionally indented. So there's no need to use
colons to emphasize it.

1. A CPU looping with interrupts disabled.
2. A CPU looping with bottom halves disabled.
3. A CPU looping with preemption disabled.
4. No looping, but massive hard and soft interrupts.

> 
> ---- >8 ----
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index ca7b7cd806a16c..056127ef2b8e7e 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -465,9 +465,7 @@ The following describes four typical scenarios:
>     This situation hints that the stalled CPU was looping with preemption
>     disabled.
>  
> -4. No looping, but massive hard and soft interrupts.
> -
> -   ::
> +4. No looping, but massive hard and soft interrupts::
>  
>       rcu:          hardirqs   softirqs   csw/system
>       rcu:  number:       xx         xx            0
> 
> Thanks. 
> 

-- 
Regards,
  Zhen Lei
