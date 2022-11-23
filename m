Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A54635BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbiKWLlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiKWLlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:41:15 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C411095AA;
        Wed, 23 Nov 2022 03:41:13 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NHJyp4rQJzJnrl;
        Wed, 23 Nov 2022 19:37:54 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:41:10 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:41:10 +0800
Subject: Re: [PATCH] doc: Fix htmldocs build warnings of stallwarn.rst
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>
References: <20221123091246.1890-1-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9dd0bfd0-19e7-607a-0d75-567cdfa6ab86@huawei.com>
Date:   Wed, 23 Nov 2022 19:41:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221123091246.1890-1-thunder.leizhen@huawei.com>
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



On 2022/11/23 17:12, Zhen Lei wrote:
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
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/RCU/stallwarn.rst | 44 ++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index c1e92dfef40d501..0f6a58ebf5d7855 100644
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
> @@ -412,22 +412,22 @@ in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
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
> +  |          snapshot time point    1st-stall                  2nd-stall
>  
>  The following describes four typical scenarios:
>  
>  1. A CPU looping with interrupts disabled.::
>  

Wait, a space is need to be added before "::", otherwise, only one colon
will be removed from the output. And in this way, other paragraphs after
literal block are also displayed in red when using vim to edit stallwarn.rst.
So it would be better to use expanded form.

I will post v2.

> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:        0          0            0
> -   rcu: cputime:        0          0            0   ==> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:        0          0            0
> +     rcu: cputime:        0          0            0   ==> 2500(ms)
>  
>     Because interrupts have been disabled throughout the measurement
>     interval, there are no interrupts and no context switches.
> @@ -442,9 +442,9 @@ The following describes four typical scenarios:
>     and CPU time consumed by hard interrupts, along with non-zero CPU
>     time consumed by in-kernel execution.::
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
> @@ -456,18 +456,18 @@ The following describes four typical scenarios:
>  
>     Here, only the number of context switches is zero.::
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
>  4. No looping, but massive hard and soft interrupts.::
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
