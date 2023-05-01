Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F06F3165
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEANFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEANE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:04:59 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AADB18E
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1682946293;
        bh=OT2ptgbgygPjGNS/XlmNveOphgbtE68SZZIydPl11vU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IlSsXadH8KCk2gQs3qSlYJEvTNYKdi4PLLvciJjS/zpvwL9vIdDAgNpbj49CuRV1Z
         NvdT8PGePgJba+56xkTMO0Urt2hmDRCAoA4gaL+tV3vToWj0KlJRwav3QN8rEbxKJ9
         CHFxqTcYEhWrbg25aO9BGxdHWv5xOk3Dezs5qXr3oCis6llZskJN9LRKPVT/QpJz46
         1uQJfFvn2EPjEVDdk8vG+7hC16pHq6mgfbe1vAN29ohEAeYC70byB2TvobVgl8bKJ3
         3ISf/AT1bTkx4RdZL8mcZuenu+PSl+SRc4V4PdYyJbeUirF2CwC9iFGt9FCIiICWxF
         jvwQCbgpZT0OQ==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q93Mn5jsKzxGM;
        Mon,  1 May 2023 09:04:53 -0400 (EDT)
Message-ID: <c74b9751-7429-99ad-d46c-c004cb914cb7@efficios.com>
Date:   Mon, 1 May 2023 09:04:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] sched: fix cid_lock kernel-doc warnings
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230428031111.322-1-rdunlap@infradead.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230428031111.322-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-27 23:11, Randy Dunlap wrote:
> Fix kernel-doc warnings for cid_lock and use_cid_lock.
> These comments are not in kernel-doc format.
> 
> kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarantee forward-progress of cid allocation.
>   on line 11496 - I thought it was a doc line
> kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
>   on line 11505 - I thought it was a doc line
> 

Right. It made sense to have those as kernel-doc when those were 
mm_struct fields in previous versions of the patch, but not anymore now 
that those are stand-alone static variables.

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>   kernel/sched/core.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/kernel/sched/core.c b/kernel/sched/core.c
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11492,7 +11492,7 @@ void call_trace_sched_update_nr_running(
>   
>   #ifdef CONFIG_SCHED_MM_CID
>   
> -/**
> +/*
>    * @cid_lock: Guarantee forward-progress of cid allocation.
>    *
>    * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lock
> @@ -11501,7 +11501,7 @@ void call_trace_sched_update_nr_running(
>    */
>   DEFINE_RAW_SPINLOCK(cid_lock);
>   
> -/**
> +/*
>    * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
>    *
>    * When @use_cid_lock is 0, the cid allocation is lock-free. When contention is

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

