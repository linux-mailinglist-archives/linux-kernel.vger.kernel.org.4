Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8E733D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 03:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjFQBvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 21:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjFQBvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 21:51:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4E13AB6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 18:50:59 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qjf9p0n7szTlBj;
        Sat, 17 Jun 2023 09:50:22 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 17 Jun 2023 09:50:56 +0800
Subject: Re: [PATCH] sched: remove unneeded header files
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20230527205731.2283720-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2fd3e785-f8bb-b3fc-6340-ed029e32057b@huawei.com>
Date:   Sat, 17 Jun 2023 09:50:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230527205731.2283720-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/28 4:57, Miaohe Lin wrote:
> Remove some unneeded header files. No functional change intended.

friendly ping... :)

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/sched/sched.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6408385c7e3f..d3db1a67ad6a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -26,7 +26,6 @@
>  #include <linux/bug.h>
>  #include <linux/capability.h>
>  #include <linux/cgroup_api.h>
> -#include <linux/cgroup.h>
>  #include <linux/context_tracking.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask_api.h>
> @@ -34,8 +33,6 @@
>  #include <linux/file.h>
>  #include <linux/fs_api.h>
>  #include <linux/hrtimer_api.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq_work.h>
>  #include <linux/jiffies.h>
>  #include <linux/kref_api.h>
>  #include <linux/kthread.h>
> @@ -44,19 +41,15 @@
>  #include <linux/lockdep.h>
>  #include <linux/minmax.h>
>  #include <linux/mm.h>
> -#include <linux/module.h>
>  #include <linux/mutex_api.h>
>  #include <linux/plist.h>
>  #include <linux/poll.h>
>  #include <linux/proc_fs.h>
>  #include <linux/profile.h>
> -#include <linux/psi.h>
>  #include <linux/rcupdate.h>
>  #include <linux/seq_file.h>
> -#include <linux/seqlock.h>
>  #include <linux/softirq.h>
>  #include <linux/spinlock_api.h>
> -#include <linux/static_key.h>
>  #include <linux/stop_machine.h>
>  #include <linux/syscalls_api.h>
>  #include <linux/syscalls.h>
> 

