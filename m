Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B82690C13
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjBIOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjBIOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:41:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82944EB58;
        Thu,  9 Feb 2023 06:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15881B82186;
        Thu,  9 Feb 2023 14:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E462EC433EF;
        Thu,  9 Feb 2023 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675953678;
        bh=TZ5nyh/Nz50g4Ou5F8th8cMJcRG25BNPZLtFN7x2xjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pu76DWdLkYzQE4D2cP0ZWJoo2y3ROVjnMDorXBkWR8B6ATdHFA257whhlSlz/AhHA
         b2cJ4XWmTYB+ZmVYFv9aVr/+r/yjTgvEIqQTZHysD5C2MkIqTw6N8cMn3MHXOCxW6a
         iFA51/QtcqndrrFScWobLMkChiOonDL8tkTf94HRhHXaQX9BeKHl7xZsAyr5fhrIpm
         s40oKdIgZhgoVOoVTtLLvQEiBWAhm4ZidNZqUyLwpX0Lh8Ejw98F55rSWMgl99tkRi
         MFG1/Ba5jDfjo4HmeQvAABpbET3+GWAngv9w3xZlzuoltr8FzvbvAenfvMbNZW3d1o
         Q8EBt8SxRoNGQ==
Date:   Thu, 9 Feb 2023 23:41:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH 21/24] Documentation: trace: correct spelling
Message-Id: <20230209234113.47c44d04f81204a692f387d3@kernel.org>
In-Reply-To: <20230209071400.31476-22-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
        <20230209071400.31476-22-rdunlap@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Feb 2023 23:13:57 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Correct spelling problems for Documentation/trace/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com> # for coresight

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  Documentation/trace/coresight/coresight-etm4x-reference.rst |    2 +-
>  Documentation/trace/events.rst                              |    6 +++---
>  Documentation/trace/fprobe.rst                              |    2 +-
>  Documentation/trace/ftrace-uses.rst                         |    2 +-
>  Documentation/trace/hwlat_detector.rst                      |    2 +-
>  Documentation/trace/uprobetracer.rst                        |    2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff -- a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> --- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
> +++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
> @@ -675,7 +675,7 @@ Bit assignments shown below:-
>      reconstructed using only conditional branches.
>  
>      There is currently no support in Perf for supplying modified binaries to the decoder, so this
> -    feature is only inteded to be used for debugging purposes or with a 3rd party tool.
> +    feature is only intended to be used for debugging purposes or with a 3rd party tool.
>  
>      Choosing this option will result in a significant increase in the amount of trace generated -
>      possible danger of overflows, or fewer instructions covered. Note, that this option also
> diff -- a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -903,7 +903,7 @@ functions can be used.
>  
>  To create a kprobe event, an empty or partially empty kprobe event
>  should first be created using kprobe_event_gen_cmd_start().  The name
> -of the event and the probe location should be specfied along with one
> +of the event and the probe location should be specified along with one
>  or args each representing a probe field should be supplied to this
>  function.  Before calling kprobe_event_gen_cmd_start(), the user
>  should create and initialize a dynevent_cmd object using
> @@ -983,7 +983,7 @@ The basic idea is simple and amounts to
>  layer that can be used to generate trace event commands.  The
>  generated command strings can then be passed to the command-parsing
>  and event creation code that already exists in the trace event
> -subystem for creating the corresponding trace events.
> +subsystem for creating the corresponding trace events.
>  
>  In a nutshell, the way it works is that the higher-level interface
>  code creates a struct dynevent_cmd object, then uses a couple
> @@ -1056,7 +1056,7 @@ to add an operator between the pair (her
>  appended onto the end of the arg pair (here ';').
>  
>  There's also a dynevent_str_add() function that can be used to simply
> -add a string as-is, with no spaces, delimeters, or arg check.
> +add a string as-is, with no spaces, delimiters, or arg check.
>  
>  Any number of dynevent_*_add() calls can be made to build up the string
>  (until its length surpasses cmd->maxlen).  When all the arguments have
> diff -- a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> --- a/Documentation/trace/fprobe.rst
> +++ b/Documentation/trace/fprobe.rst
> @@ -111,7 +111,7 @@ saved at function entry and passed to ex
>          the instruction pointer of @regs may be different from the @entry_ip
>          in the entry_handler. If you need traced instruction pointer, you need
>          to use @entry_ip. On the other hand, in the exit_handler, the instruction
> -        pointer of @regs is set to the currect return address.
> +        pointer of @regs is set to the correct return address.
>  
>  Share the callbacks with kprobes
>  ================================
> diff -- a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
> --- a/Documentation/trace/ftrace-uses.rst
> +++ b/Documentation/trace/ftrace-uses.rst
> @@ -193,7 +193,7 @@ FTRACE_OPS_FL_RECURSION
>  	Not, if this flag is set, then the callback will always be called
>  	with preemption disabled. If it is not set, then it is possible
>  	(but not guaranteed) that the callback will be called in
> -	preemptable context.
> +	preemptible context.
>  
>  FTRACE_OPS_FL_IPMODIFY
>  	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
> diff -- a/Documentation/trace/hwlat_detector.rst b/Documentation/trace/hwlat_detector.rst
> --- a/Documentation/trace/hwlat_detector.rst
> +++ b/Documentation/trace/hwlat_detector.rst
> @@ -14,7 +14,7 @@ originally written for use by the "RT" p
>  kernel is highly latency sensitive.
>  
>  SMIs are not serviced by the Linux kernel, which means that it does not
> -even know that they are occuring. SMIs are instead set up by BIOS code
> +even know that they are occurring. SMIs are instead set up by BIOS code
>  and are serviced by BIOS code, usually for "critical" events such as
>  management of thermal sensors and fans. Sometimes though, SMIs are used for
>  other tasks and those tasks can spend an inordinate amount of time in the
> diff -- a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
> --- a/Documentation/trace/uprobetracer.rst
> +++ b/Documentation/trace/uprobetracer.rst
> @@ -55,7 +55,7 @@ Synopsis of uprobe_tracer
>  
>    (\*1) only for return probe.
>    (\*2) this is useful for fetching a field of data structures.
> -  (\*3) Unlike kprobe event, "u" prefix will just be ignored, becuse uprobe
> +  (\*3) Unlike kprobe event, "u" prefix will just be ignored, because uprobe
>          events can access only user-space memory.
>  
>  Types


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
