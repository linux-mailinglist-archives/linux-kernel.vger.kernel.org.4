Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243686907D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBILyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBILxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:53:39 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E868AD5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:41:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id ea13so1090867pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 03:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yProl2BDwB5rM572Fbs59r3WL3B/5I59AVOYb+PuqHI=;
        b=KV/bOyz4S4KezQKKFVQaOOMbqOITttsXwy8iRe3FKzile+YMvQpsXjlrBt+eVKkIhA
         CllK54eqi+PV6eu/AEMwJMumk6EFiWmxtny2ybtbu/UOjns1koYHTZu1asp9C6lFsbQy
         WAhbQ6aqAIc4FpwbNIn1PlqSKdxo77osYJSDg1qZya+yEZubtT6zceSRDDH33l/Ri1yy
         YJyoEi/fg2vZJrRaDDIdYw51bT+f7JtWrqmntTTHlQUb0tNiRrurlXah2Qo/nJ/34GBY
         ZH4XsxYRhOyMWJy8WpweYPbg4q2oPvS3k5LwN8EGVTGsP6NJA46xcoNAM9SaNdDR00M4
         zkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yProl2BDwB5rM572Fbs59r3WL3B/5I59AVOYb+PuqHI=;
        b=6NvmRAEDldszUceB9248XqxuqXhk0/NRsOSoBvCubS6ELgA+f1+XZHOLWFmw4pmhhu
         QnFyAbeMfF99iG34jU3nxvV0z1eSkoE+pegOMQ9nAwGkP9xThf5XmnlozIYueabTR3P+
         dwlxfQzMKQhgEgZR6qZaIhHkzzQgOSFVBtUbiDicY0k7k/qFrFT3CHl7R2BXTmJDNtOw
         Ie2H89z8Agk8hW9XduzPCEs/q21EKLKxz+UYfvDX6wyAcyJ8GDgID6UAXPNBebjyNA4/
         GPCs7pD8y81bul994Th7wBu3vXPyHVIGbyXK6a/WnvwXugAzsCCSxcZ0WrsWnwEBou1R
         ZDKw==
X-Gm-Message-State: AO0yUKV/k9rI+ru6GpYKwHGiP9T11F0JeSwPhrB+J8PD3OB0tfhJ6Iwc
        y3RL0NJ/xDBS8DxjHxAjpqT6Y1P6psjAjTYP/lwUtw==
X-Google-Smtp-Source: AK7set/plM8/DX1Q4MYjtoJGIq6qokxZinH6ULU+y7Qbmu93F1XvNHH+br2ZXCpqQjFfdJKMazyGqra/KUg2lQRnsNk=
X-Received: by 2002:a62:2503:0:b0:5a8:494a:e498 with SMTP id
 l3-20020a622503000000b005a8494ae498mr913346pfl.51.1675942867561; Thu, 09 Feb
 2023 03:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20230209071400.31476-1-rdunlap@infradead.org> <20230209071400.31476-22-rdunlap@infradead.org>
In-Reply-To: <20230209071400.31476-22-rdunlap@infradead.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 9 Feb 2023 11:40:55 +0000
Message-ID: <CAJ9a7VjJCK8SPzYv0_doJ0aG-Q_NX2=HTyJcBynOduueUNas_A@mail.gmail.com>
Subject: Re: [PATCH 21/24] Documentation: trace: correct spelling
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed by: Mike Leach <mike.leach@linaro.org>

On Thu, 9 Feb 2023 at 07:14, Randy Dunlap <rdunlap@infradead.org> wrote:
>
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
>         Not, if this flag is set, then the callback will always be called
>         with preemption disabled. If it is not set, then it is possible
>         (but not guaranteed) that the callback will be called in
> -       preemptable context.
> +       preemptible context.
>
>  FTRACE_OPS_FL_IPMODIFY
>         Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
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
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
