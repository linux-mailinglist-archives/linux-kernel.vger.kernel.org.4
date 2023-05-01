Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A714D6F317C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjEANUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEANUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:20:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAE129
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=846+YrpI8KR9DQxQI7gb1EF19GO4Rnb3akR/OvAMgvE=; b=tPF0w0NgxweYEOzTImSd9cPPLK
        zrixEIHQywumVa2DmeWJcNsGqtRRxheQDFrkRndRpLaE/lghKH3vG2AQDbaqAgcg4H/Q5xkrQU+JW
        vWSXNZiNhuV2TcIjW1EGYwhaH6EsJh9sYYm75V6ljWTLSBLigPdPADuVWWcxI9pUtR6y5iWyWLd8R
        sQefcbdJVUlUh+a0+B4DHVxDyLHsz1577uKfNUU8MBkuEZ7cG1pxKpjIzvKrSM6812swSXo1k0uBq
        L2lbG/jrVzzxsEX5LTLjd1Zq88hG963LA7WAEWzB1VXxqNKu4wIKJPVC+Y6D2E10eQI/vcqn5Z54K
        n/UV7Uww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ptTS2-007LTx-0p; Mon, 01 May 2023 13:20:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C53B6300348;
        Mon,  1 May 2023 15:20:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9CD923262B93; Mon,  1 May 2023 15:20:20 +0200 (CEST)
Date:   Mon, 1 May 2023 15:20:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH -next] sched: fix cid_lock kernel-doc warnings
Message-ID: <20230501132020.GA1597538@hirez.programming.kicks-ass.net>
References: <20230428031111.322-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428031111.322-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 08:11:11PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warnings for cid_lock and use_cid_lock.
> These comments are not in kernel-doc format.
> 
> kernel/sched/core.c:11496: warning: Cannot understand  * @cid_lock: Guarantee forward-progress of cid allocation.
>  on line 11496 - I thought it was a doc line
> kernel/sched/core.c:11505: warning: Cannot understand  * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
>  on line 11505 - I thought it was a doc line
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Blergh, so mostly I avoid kerneldoc like the plague; because then you
get random people doing 'fixups' that end up making the actual comment
unreadable garbage.

Mostly my answer to any such patch is to simply remove the extra * and
call it fixed.

But now the thing presumes to know better? :-(

Anyway, in this case I suppose we can add it on and see, there's still a
fair number of actual kerneldoc comments in that file.

>  kernel/sched/core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/kernel/sched/core.c b/kernel/sched/core.c
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11492,7 +11492,7 @@ void call_trace_sched_update_nr_running(
>  
>  #ifdef CONFIG_SCHED_MM_CID
>  
> -/**
> +/*
>   * @cid_lock: Guarantee forward-progress of cid allocation.
>   *
>   * Concurrency ID allocation within a bitmap is mostly lock-free. The cid_lock
> @@ -11501,7 +11501,7 @@ void call_trace_sched_update_nr_running(
>   */
>  DEFINE_RAW_SPINLOCK(cid_lock);
>  
> -/**
> +/*
>   * @use_cid_lock: Select cid allocation behavior: lock-free vs spinlock.
>   *
>   * When @use_cid_lock is 0, the cid allocation is lock-free. When contention is
