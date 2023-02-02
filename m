Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293EF6872F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBBBYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjBBBY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:24:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B36953C;
        Wed,  1 Feb 2023 17:24:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8723619A5;
        Thu,  2 Feb 2023 01:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06833C433D2;
        Thu,  2 Feb 2023 01:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675301064;
        bh=0olKIEXlGYrwFqAEVWyZ4+1JT7fDrX0LKVYxyS71g94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdFpLw1Eolk1Uo6H6TSxuS+L3IciPSn7VYzv1ZUKrYTX1irXDQeUUZjDLnTLhZ4Ar
         Nmc1iQbxgLFYf5Rt7uj+ZLYCvz0BUP/K6XbEaZPYg1kE7k2pGXAlAJbPVrKwqTAQZ4
         Zq3ABZ4p8xjAtumTCoJvz9lVdOFeJ16iZa6bFTDwuVRDnHj8THZg0YpXCpkyTDaUN+
         e0CUu/lMKA+5tYTRmJRf2JGoAc10uGFn//eEh5xi3TukMumfEMKCwP1OpzJ7pUfv8z
         s+stTvX5DqzWZ71kYEddlIGJhcNj7KF78ms3f0+k5VqfzsoUlfgZNTrda8KfD6Ffc8
         byMvqTaRV19FQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86159405BE; Wed,  1 Feb 2023 22:24:21 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:24:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/9] perf docs: use canonical ftrace path
Message-ID: <Y9sQxX70vviNj+mn@kernel.org>
References: <20230130181915.1113313-1-zwisler@google.com>
 <20230130181915.1113313-5-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130181915.1113313-5-zwisler@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 30, 2023 at 11:19:10AM -0700, Ross Zwisler escreveu:
> The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> 
> But, from Documentation/trace/ftrace.rst:
> 
>   Before 4.1, all ftrace tracing control files were within the debugfs
>   file system, which is typically located at /sys/kernel/debug/tracing.
>   For backward compatibility, when mounting the debugfs file system,
>   the tracefs file system will be automatically mounted at:
> 
>   /sys/kernel/debug/tracing
> 
> A few spots in the perf docs still refer to this older debugfs path, so
> let's update them to avoid confusion.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---
>  tools/perf/Documentation/perf-list.txt          | 2 +-
>  tools/perf/Documentation/perf-script-perl.txt   | 2 +-
>  tools/perf/Documentation/perf-script-python.txt | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 57384a97c04f..6c83459d3192 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -228,7 +228,7 @@ This can be overridden by setting the kernel.perf_event_paranoid
>  sysctl to -1, which allows non root to use these events.
>  
>  For accessing trace point events perf needs to have read access to
> -/sys/kernel/debug/tracing, even when perf_event_paranoid is in a relaxed
> +/sys/kernel/tracing, even when perf_event_paranoid is in a relaxed
>  setting.
>  
>  TRACING
> diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/Documentation/perf-script-perl.txt
> index fa4f39d305a7..5b479f5e62ff 100644
> --- a/tools/perf/Documentation/perf-script-perl.txt
> +++ b/tools/perf/Documentation/perf-script-perl.txt
> @@ -55,7 +55,7 @@ Traces meant to be processed using a script should be recorded with
>  the above option: -a to enable system-wide collection.
>  
>  The format file for the sched_wakeup event defines the following fields
> -(see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
> +(see /sys/kernel/tracing/events/sched/sched_wakeup/format):
>  
>  ----
>   format:
> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
> index cf4b7f4b625a..6a8581012e16 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt
> @@ -319,7 +319,7 @@ So those are the essential steps in writing and running a script.  The
>  process can be generalized to any tracepoint or set of tracepoints
>  you're interested in - basically find the tracepoint(s) you're
>  interested in by looking at the list of available events shown by
> -'perf list' and/or look in /sys/kernel/debug/tracing/events/ for
> +'perf list' and/or look in /sys/kernel/tracing/events/ for
>  detailed event and field info, record the corresponding trace data
>  using 'perf record', passing it the list of interesting events,
>  generate a skeleton script using 'perf script -g python' and modify the
> @@ -449,7 +449,7 @@ Traces meant to be processed using a script should be recorded with
>  the above option: -a to enable system-wide collection.
>  
>  The format file for the sched_wakeup event defines the following fields
> -(see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
> +(see /sys/kernel/tracing/events/sched/sched_wakeup/format):
>  
>  ----
>   format:
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 

-- 

- Arnaldo
