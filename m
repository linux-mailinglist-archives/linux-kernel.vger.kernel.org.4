Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F029E5F6A24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiJFO7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJFO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:59:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15926AC384
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:59:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64ABD6E;
        Thu,  6 Oct 2022 07:59:32 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.149])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0644C3F67D;
        Thu,  6 Oct 2022 07:59:25 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:59:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ftrace: Create separate entry in MAINTAINERS for
 function hooks
Message-ID: <Yz7tRw1f24pjxR2t@FVFF77S0Q05N.cambridge.arm.com>
References: <20221006144346.554825677@goodmis.org>
 <20221006144439.459272364@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006144439.459272364@goodmis.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 10:43:48AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The function hooks (ftrace) is a completely different subsystem from the
> general tracing. It manages how to attach callbacks to most functions in
> the kernel. It is also used by live kernel patching. It really is not part
> of tracing, although tracing uses it.
> 
> Create a separate entry for FUNCTION HOOKS (FTRACE) to be separate from
> tracing itself in the MAINTAINERS file.
> 
> Perhaps it shouldbe moved out of the kernel/trace directory, but that's
                  ^^
Missing space.

> for another time.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks, this should save some space in my INBOX!

Mark.

> ---
>  MAINTAINERS | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86b8aa4c11cb..d95f5d3b4d37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8411,6 +8411,19 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/fujitsu-tablet.c
>  
> +FUNCTION HOOKS (FTRACE)
> +M:	Steven Rostedt <rostedt@goodmis.org>
> +M:	Masami Hiramatsu <mhiramat@kernel.org>
> +R:	Mark Rutland <mark.rutland@arm.com>
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> +F:	Documentation/trace/ftrace*
> +F:	kernel/trace/ftrace*
> +F:	kernel/trace/fgraph.c
> +F:	arch/*/*/*/*ftrace*
> +F:	arch/*/*/*ftrace*
> +F:	include/*/ftrace.h
> +
>  FUNGIBLE ETHERNET DRIVERS
>  M:	Dimitris Michailidis <dmichail@fungible.com>
>  L:	netdev@vger.kernel.org
> @@ -20615,14 +20628,10 @@ F:	drivers/char/tpm/
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
> -R:	Mark Rutland <mark.rutland@arm.com>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> -F:	Documentation/trace/ftrace.rst
> -F:	arch/*/*/*/*ftrace*
> -F:	arch/*/*/*ftrace*
> +F:	Documentation/trace/*
>  F:	fs/tracefs/
> -F:	include/*/ftrace.h
>  F:	include/linux/trace*.h
>  F:	include/trace/
>  F:	kernel/trace/
> -- 
> 2.35.1
