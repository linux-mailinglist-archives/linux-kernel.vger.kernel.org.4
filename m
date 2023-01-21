Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124156765FF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAUL3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:29:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38F93B3D2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 03:29:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5140A5FFC8;
        Sat, 21 Jan 2023 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674300585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5syjoP68/X1yj4HDBfbMlhfi9N1S6g7T+QMIMt/oPX8=;
        b=gpWM2hDo+vCjQ4xw4JVKSPaz9Mz/4Iae9UEU795MN41r4KP8YTLTzHusMm/29LCLR1L36q
        qw4pikvS04wq3+FX82eSoJIeHsp9t5MgihNZvN9EjML2J3b3MmsNj2mtArlKWma6tBt2ok
        /+XutrD1lxd4sH256oSqRPJ6U1N6Ytc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674300585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5syjoP68/X1yj4HDBfbMlhfi9N1S6g7T+QMIMt/oPX8=;
        b=m5mnLxazxSC/EnFrtILhKcZfeR78ijOenbWBO58NVlGXSCbVjkW5uBwk3QH9AXrOL/unHj
        ZDzZHxULPeb1YiBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8F71138FE;
        Sat, 21 Jan 2023 11:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KKH1M6jMy2O0EgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 21 Jan 2023 11:29:44 +0000
Message-ID: <86e68d3b-b029-5e82-5bbc-e0ccc2ae1d36@suse.cz>
Date:   Sat, 21 Jan 2023 12:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230121033942.350387-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 04:39, Hyeonggon Yoo wrote:
> In workloads where this_cpu operations are frequently performed,
> enabling DEBUG_PREEMPT may result in significant increase in
> runtime overhead due to frequent invocation of
> __this_cpu_preempt_check() function.
> 
> This can be demonstrated through benchmarks such as hackbench where this
> configuration results in a 10% reduction in performance, primarily due to
> the added overhead within memcg charging path.
> 
> Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
> of its potential impact on performance in some workloads.
> 
> hackbench-process-sockets
> 		      debug_preempt	 no_debug_preempt
> Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
> Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
> Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
> Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
> Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
> Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
> Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
> Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
> Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Looks like it's there since the beginning of preempt and pre-git. But
probably should be something for scheduler maintainers rather than mm/slab,
even if the impact manifests there. You did Cc Ingo (the original author) so
let me Cc the rest here.

> ---
>  lib/Kconfig.debug | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ddbfac2adf9c..f6f845a4b9ec 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1176,13 +1176,16 @@ config DEBUG_TIMEKEEPING
>  config DEBUG_PREEMPT
>  	bool "Debug preemptible kernel"
>  	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
> -	default y
>  	help
>  	  If you say Y here then the kernel will use a debug variant of the
>  	  commonly used smp_processor_id() function and will print warnings
>  	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
>  	  will detect preemption count underflows.
>  
> +	  This option has potential to introduce high runtime overhead,
> +	  depending on workload as it triggers debugging routines for each
> +	  this_cpu operation. It should only be used for debugging purposes.
> +
>  menu "Lock Debugging (spinlocks, mutexes, etc...)"
>  
>  config LOCK_DEBUGGING_SUPPORT

