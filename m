Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079545F1721
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiJAAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiJAATt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85B057264;
        Fri, 30 Sep 2022 17:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B449B623C0;
        Sat,  1 Oct 2022 00:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D596CC433D6;
        Sat,  1 Oct 2022 00:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664583431;
        bh=KHeXu2nyUhB4rmYxARv+WxzcajWxJL4Fk5tvT/Fy5UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6wN/Ja6+/wusoi6ZQPwVfvYiv2i5R9vXTfEgYoHr8C5attjr7/FvT5xVJzUcGSRU
         62KddjC0eRbDKEWyOP9lN2+Z26ksfVf6NfiXFuSr6maMLJq79PahoiWo+sLEyWgN+6
         YJJG3g7klyEyfOP7vIzmZska46Rj78Y8LF8HIP5udtPp1P8kQmgchsgeW7jwqvliij
         TwrOr5A+Ttig9hlRnRvwhw+jf6PSXb1MEEqLMZFSgWFbJbirSacGDL7INJ7zLqRW0P
         3Nx7Wcba9RbSiyl2ryFkLePwBkdafdUqrHLhHYvP/SCFNwzkTTsnO33pPkCEgpKTcj
         qF0oKTHYFsF8g==
Date:   Sat, 1 Oct 2022 09:17:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Add Masami Hiramatsu as co-maintainer
Message-Id: <20221001091706.8efaeb64266efa6058a468df@kernel.org>
In-Reply-To: <20220930124131.7b6432dd@gandalf.local.home>
References: <20220930124131.7b6432dd@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 12:41:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Masami has been maintaining kprobes for a while now and that code has
> been an integral part of tracing. He has also been an excellent reviewer
> of all the tracing code and contributor as well.
> 
> The tracing subsystem needs another active maintainer to keep it running
> smoothly, and I do not know anyone more qualified for the job than Masami.
> 
> Ingo has also told me that he has not been active in the tracing code for
> some time and said he could be removed from the TRACING portion of the
> MAINTAINERS file.
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks Steve,

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f5ca4aefd184..6c7c9cdff05a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20614,7 +20614,7 @@ F:	drivers/char/tpm/
>  
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -M:	Ingo Molnar <mingo@redhat.com>
> +M:	Masami Hiramatsu <mhiramat@kernel.org>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>  F:	Documentation/trace/ftrace.rst
> @@ -20630,7 +20630,7 @@ F:	tools/testing/selftests/ftrace/
>  
>  TRACING MMIO ACCESSES (MMIOTRACE)
>  M:	Steven Rostedt <rostedt@goodmis.org>
> -M:	Ingo Molnar <mingo@kernel.org>
> +M:	Masami Hiramatsu <mhiramat@kernel.org>
>  R:	Karol Herbst <karolherbst@gmail.com>
>  R:	Pekka Paalanen <ppaalanen@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.35.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
