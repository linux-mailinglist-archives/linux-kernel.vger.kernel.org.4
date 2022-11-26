Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED21563931D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKZBai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKZBah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:30:37 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C355B1D0FC;
        Fri, 25 Nov 2022 17:30:35 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NJvL01zNCzRpXR;
        Sat, 26 Nov 2022 09:30:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 09:30:34 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 09:30:32 +0800
Subject: Re: [PATCH v3] doc: Fix htmldocs build warnings of stallwarn.rst
To:     "Paul E . McKenney" <paulmck@kernel.org>,
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
CC:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20221124062204.1932-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1c472632-caf6-72d3-5de8-aaa3a1fdfd61@huawei.com>
Date:   Sat, 26 Nov 2022 09:30:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221124062204.1932-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2022/11/24 14:22, Zhen Lei wrote:
> Documentation/RCU/stallwarn.rst:
> 401: WARNING: Literal block expected; none found.
> 428: WARNING: Literal block expected; none found.
> 445: WARNING: Literal block expected; none found.
> 459: WARNING: Literal block expected; none found.
> 468: WARNING: Literal block expected; none found.
> 
> The literal block need to be indented, so add two spaces to each line.
> 
> In addition, ':', which is used as a boundary in the literal block, is
> replaced by '|'.
> 
> Link: https://lore.kernel.org/linux-next/20221123163255.48653674@canb.auug.org.au/
> Fixes: 3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/RCU/stallwarn.rst | 56 ++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 26 deletions(-)
> 
> v2 --> v3:
> 1. Add "Link:", "Fixes:", "Reported-by:".
> 2. Remove a orphaned pipe (|).
> 3. Change ". ::" to "::"

Hi, Bagas Sanjaya:
  Do you have time to review this patch again? Your review comments are important
because you made comments in the previous version.

> 
> v1 --> v2:
> For the case that both colons need to be deleted, change "::" to expanded
> form or partially minimized form.
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index c1e92dfef40d501..ca7b7cd806a16c9 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -398,9 +398,9 @@ In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
>  rcupdate.rcu_cpu_stall_cputime=1, the following additional information
>  is supplied with each RCU CPU stall warning::
>  
> -rcu:          hardirqs   softirqs   csw/system
> -rcu:  number:      624         45            0
> -rcu: cputime:       69          1         2425   ==> 2500(ms)
> +  rcu:          hardirqs   softirqs   csw/system
> +  rcu:  number:      624         45            0
> +  rcu: cputime:       69          1         2425   ==> 2500(ms)
>  
>  These statistics are collected during the sampling period. The values
>  in row "number:" are the number of hard interrupts, number of soft
> @@ -412,22 +412,24 @@ in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
>  stalls, these tasks are typically kernel tasks, which is why only the
>  system CPU time are considered.
>  
> -The sampling period is shown as follows:
> -:<------------first timeout---------->:<-----second timeout----->:
> -:<--half timeout-->:<--half timeout-->:                          :
> -:                  :<--first period-->:                          :
> -:                  :<-----------second sampling period---------->:
> -:                  :                  :                          :
> -:          snapshot time point    1st-stall                  2nd-stall
> +The sampling period is shown as follows::
>  
> +  |<------------first timeout---------->|<-----second timeout----->|
> +  |<--half timeout-->|<--half timeout-->|                          |
> +  |                  |<--first period-->|                          |
> +  |                  |<-----------second sampling period---------->|
> +  |                  |                  |                          |
> +             snapshot time point    1st-stall                  2nd-stall
>  
>  The following describes four typical scenarios:
>  
> -1. A CPU looping with interrupts disabled.::
> +1. A CPU looping with interrupts disabled.
>  
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:        0          0            0
> -   rcu: cputime:        0          0            0   ==> 2500(ms)
> +   ::
> +
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:        0          0            0
> +     rcu: cputime:        0          0            0   ==> 2500(ms)
>  
>     Because interrupts have been disabled throughout the measurement
>     interval, there are no interrupts and no context switches.
> @@ -440,11 +442,11 @@ The following describes four typical scenarios:
>  
>     This is similar to the previous example, but with non-zero number of
>     and CPU time consumed by hard interrupts, along with non-zero CPU
> -   time consumed by in-kernel execution.::
> +   time consumed by in-kernel execution::
>  
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:      624          0            0
> -   rcu: cputime:       49          0         2446   ==> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:      624          0            0
> +     rcu: cputime:       49          0         2446   ==> 2500(ms)
>  
>     The fact that there are zero softirqs gives a hint that these were
>     disabled, perhaps via local_bh_disable().  It is of course possible
> @@ -454,20 +456,22 @@ The following describes four typical scenarios:
>  
>  3. A CPU looping with preemption disabled.
>  
> -   Here, only the number of context switches is zero.::
> +   Here, only the number of context switches is zero::
>  
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:      624         45            0
> -   rcu: cputime:       69          1         2425   ==> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:      624         45            0
> +     rcu: cputime:       69          1         2425   ==> 2500(ms)
>  
>     This situation hints that the stalled CPU was looping with preemption
>     disabled.
>  
> -4. No looping, but massive hard and soft interrupts.::
> +4. No looping, but massive hard and soft interrupts.
> +
> +   ::
>  
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:       xx         xx            0
> -   rcu: cputime:       xx         xx            0   ==> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:       xx         xx            0
> +     rcu: cputime:       xx         xx            0   ==> 2500(ms)
>  
>     Here, the number and CPU time of hard interrupts are all non-zero,
>     but the number of context switches and the in-kernel CPU time consumed
> 

-- 
Regards,
  Zhen Lei
