Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB976478C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiLHW1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLHW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:27:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540180A38
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:27:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so6960214pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 14:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQR25hXZloAZorduWX7OmeRW/OBJ2WK3euXwD9n9+OE=;
        b=jPWrXunVIw6xvwvb4APnqTacxKN8+MZTMZkPycGpLzVR9FwAdZtA7UpOUL7aRe6YXN
         nqULpExYr9dskSVj6kTkQDgo/gG+dW7WcPiYnZ0jKWPcG1Ri3o9BCskGQVC41G2LFFxM
         FjhYO449k6XP1vOsWydY5gc6Iz6eBa4fVKIaAz3ZwN5fXghuLUotRr31csVdNVWKUB4V
         WCbCSsZWweOWfFgw3js1GcWVoqpQ4wJ/uoK1NgFw21wA9vl/6gzV1lrXb74Q4OC2Z8aR
         4NwNBQYl5KhAH6UZgU4wCGsBplT6Q8fHQgwbpTKZ3nquUz2+hma/jaZlBivR7k5lrKW/
         q1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQR25hXZloAZorduWX7OmeRW/OBJ2WK3euXwD9n9+OE=;
        b=XA9msPUVldnMULM7poi7C/zvoDv8mBxG3DFhV0CW2pPXQ3W7iImZ+CV08/hwgz3moJ
         n7MOTeL0CX5tLR3iqMcbNRKR6rIpOVSQj3LObQdLHbQvz6nbt8P55vmatwagf+c0hvAp
         D5n1eNcXirV4iTUzgaKRBj/Py9R8/iRW1JCCFtRlb/mKzsZUrPY8jfiyqopzyxBqS4fh
         nOA2ULc4LXmX7qtS4S6n7gyu+RQeN1Z+QbbfFYkgs/GYj3b2kpxvz9XAYmWFQdVp5XDw
         FruhAtQUEPg9QsK8fp4sJFOBJhdHLvkBG7Fqumv5AcdqRdGjHAbbBNZIScq60SYqHugK
         DrOw==
X-Gm-Message-State: ANoB5pnCaUj5dZclrXVO7m5QWnIUJPrfCPdZVTv2MAIez6mpYcYlmEaR
        mFNt9zEKIC8KpeVUVcZk+PS0DABRWioc0RechHasog==
X-Google-Smtp-Source: AA0mqf60mwXumrk4UCOpMfT9176Le5R3jMXkA3oyK0ZTsWhXOXgDFL3X4Sj0SNL7lP9IAszx/ccNAveyoVuDKUZD9X0=
X-Received: by 2002:a17:902:7682:b0:182:6c84:7ff4 with SMTP id
 m2-20020a170902768200b001826c847ff4mr86056876pll.25.1670538438538; Thu, 08
 Dec 2022 14:27:18 -0800 (PST)
MIME-Version: 1.0
References: <20221020210056.0d8d0a5b@gandalf.local.home>
In-Reply-To: <20221020210056.0d8d0a5b@gandalf.local.home>
From:   Ross Zwisler <zwisler@google.com>
Date:   Thu, 8 Dec 2022 15:27:07 -0700
Message-ID: <CAGRrVHw2ABuBtb+6BtES0WPNpbtu3p6vfZ-pADjtYYxm9kWZ4g@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Add trace_trigger kernel command line option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 7:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Allow triggers to be enabled at kernel boot up. For example:
>
>   trace_trigger="sched_switch.stacktrace if prev_state == 2"
>
> The above will enable the stacktrace trigger on top of the sched_switch
> event and only trigger if its prev_state is 2 (TASK_UNINTERRUPTIBLE). Then
> at boot up, a stacktrace will trigger and be recorded in the tracing ring
> buffer every time the sched_switch happens where the previous state is
> TASK_INTERRUPTIBLE.
>
> Another useful trigger would be "traceoff" which can stop tracing on an
> event if a field of the event matches a certain value defined by the
> filter ("if" statement).
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

<>

> +#ifdef CONFIG_HIST_TRIGGERS

Can you help me understand why this is only available if
CONFIG_HIST_TRIGGERS is selected in the kernel config?  AFAICT this
code doesn't depend on the histogram code, and the run-time selection
of triggers is usable without CONFIG_HIST_TRIGGERS.

Thanks!

> +static void trace_early_triggers(struct trace_event_file *file, const char *name)
> +{
> +       int ret;
> +       int i;

<>
