Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241305F35E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJCSyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJCSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:54:21 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C4B43637;
        Mon,  3 Oct 2022 11:54:20 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1329abb0ec6so1373640fac.8;
        Mon, 03 Oct 2022 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FIzWmWN1I6YXU/aAJy96gawoVGv35HbU2tFhtZjd8kg=;
        b=GMSBDUtWSW8r5MPFGXqTCJUSL7Y6NVBVy+Q4G6Rnq4onoHonlVlorlBczD93BR5zLW
         6gajfadSoIPaP21LvQ6HLCaF2JcJL6y96MPe6oTGq8MithQ7s5ulNTDPAhW/wtfuRE7r
         JMpEzHqpBnkZmDRBtmW3BvZOjQ41hiZbiVdelOiYGWaeY7Eze3hCDA8uRxCoKOIxqnCM
         g0ec25MlZNvQGCw/Qi2CeBy1kqdu7u8dog2lFbj/hhiajAIGko2fZNtp9DinajIjLO5E
         2a5lRA6+eODvivlNAo1SXneZw3KqVZcvhIwPo0VqNUoybswIJMUYcF6cJ6kuI+shq4V6
         bVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FIzWmWN1I6YXU/aAJy96gawoVGv35HbU2tFhtZjd8kg=;
        b=qOeCoPRapDwShNUzp2SA/lMaFNxzxSSjFl+2mTrci6deiYJ7KHdG6OphjYFQoWQ6T5
         vgPWp9EtpZXtBCFZWd1zCwOLSh/TamhI1wME6CYJGZcTGuEz1Bdanzhl0Jsd1Z9Ncj9v
         DK6Abm4x7dpsnzGGHksinnOHwBq2TujpdJiwplCY84rufU8YvGsbQVrXA1xuuLSDNRVH
         cZbQuzhDdZTHWQf+pT3NIKc28ihGStXghjNdE4zEce3EzfnPtHxqVGCvOIS2jQLtsI+k
         TdIxjC+Pvoz0F+ty6ec7AaW/Kj9mHr3U2U+wbU35C/6N+SRRHcpWYh1ImFcPbqSHVCK+
         gATw==
X-Gm-Message-State: ACrzQf1pjtnYOKF0EGzGqKn+l7uCakyRQ5K7OAR0nKmURpQZ4CgiGl40
        ldR+RMTszSayapzI6eRazRU=
X-Google-Smtp-Source: AMsMyM6CxufjFwB0bI+jFpaWRPRMUmGRf/87B7a5iI+TDYgOAqVWfqFBwTOeTV8MkxBqkNARdQJ5rw==
X-Received: by 2002:a05:6870:c18f:b0:132:8af2:2831 with SMTP id h15-20020a056870c18f00b001328af22831mr1805005oad.9.1664823259907;
        Mon, 03 Oct 2022 11:54:19 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id by6-20020a056830608600b0065c477a9db9sm2539495otb.1.2022.10.03.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:54:19 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:52:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH bitmap-for-next 0/5] bitmap,cpumask: Add
 for_each_cpu_andnot()
Message-ID: <YzsvVx+i1JM8V72D@yury-laptop>
References: <20221003153420.285896-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003153420.285896-1-vschneid@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 04:34:15PM +0100, Valentin Schneider wrote:
> As suggested by Yury, this is the bitmap/cpumask specific bits of [1]. This now
> also contains an extra fix for blk_mq.

Patches ##2-5 look good to me, but I'd like to give them some testing.
Let's also wait for other comments, and if nothing wrong will be spotted,
I'll take it.

Thanks,
Yury
 
> This is based on top of Yury's bitmap-for-next [2].
> 
> A note on treewide use of for_each_cpu_andnot()
> ===============================================
> 
> I've used the below coccinelle script to find places that could be patched (I
> couldn't figure out the valid syntax to patch from coccinelle itself):
> 
> ,-----
> @tmpandnot@
> expression tmpmask;
> iterator for_each_cpu;
> position p;
> statement S;
> @@
> cpumask_andnot(tmpmask, ...);
> 
> ...
> 
> (
> for_each_cpu@p(..., tmpmask, ...)
> 	S
> |
> for_each_cpu@p(..., tmpmask, ...)
> {
> 	...
> }
> )
> 
> @script:python depends on tmpandnot@
> p << tmpandnot.p;
> @@
> coccilib.report.print_report(p[0], "andnot loop here")
> '-----
> 
> Which yields (against c40e8341e3b3):
> 
> .//arch/powerpc/kernel/smp.c:1587:1-13: andnot loop here
> .//arch/powerpc/kernel/smp.c:1530:1-13: andnot loop here
> .//arch/powerpc/kernel/smp.c:1440:1-13: andnot loop here
> .//arch/powerpc/platforms/powernv/subcore.c:306:2-14: andnot loop here
> .//arch/x86/kernel/apic/x2apic_cluster.c:62:1-13: andnot loop here
> .//drivers/acpi/acpi_pad.c:110:1-13: andnot loop here
> .//drivers/cpufreq/armada-8k-cpufreq.c:148:1-13: andnot loop here
> .//drivers/cpufreq/powernv-cpufreq.c:931:1-13: andnot loop here
> .//drivers/net/ethernet/sfc/efx_channels.c:73:1-13: andnot loop here
> .//drivers/net/ethernet/sfc/siena/efx_channels.c:73:1-13: andnot loop here
> .//kernel/sched/core.c:345:1-13: andnot loop here
> .//kernel/sched/core.c:366:1-13: andnot loop here
> .//net/core/dev.c:3058:1-13: andnot loop here
> 
> A lot of those are actually of the shape
> 
>   for_each_cpu(cpu, mask) {
>       ...
>       cpumask_andnot(mask, ...);
>   }
> 
> I think *some* of the powerpc ones would be a match for for_each_cpu_andnot(),
> but I decided to just stick to the one obvious one in __sched_core_flip().
> 
> [1]: https://lore.kernel.org/all/20220923132527.1001870-1-vschneid@redhat.com/
> [2]: https://github.com/norov/linux.git/ -b bitmap-for-next
> 
> Cheers,
> Valentin
> 
> Valentin Schneider (5):
>   blk_mq: Fix cpumask_check() warning in blk_mq_hctx_next_cpu()
>   lib/find_bit: Introduce find_next_andnot_bit()
>   cpumask: Introduce for_each_cpu_andnot()
>   lib/test_cpumask: Add for_each_cpu_and(not) tests
>   sched/core: Merge cpumask_andnot()+for_each_cpu() into
>     for_each_cpu_andnot()
> 
>  block/blk-mq.c          |  9 +++++++--
>  include/linux/cpumask.h | 18 ++++++++++++++++++
>  include/linux/find.h    | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/sched/core.c     |  5 +----
>  lib/cpumask_kunit.c     | 19 +++++++++++++++++++
>  lib/find_bit.c          |  9 +++++++++
>  6 files changed, 92 insertions(+), 6 deletions(-)
> 
> --
> 2.31.1
