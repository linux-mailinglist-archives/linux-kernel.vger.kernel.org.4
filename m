Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55555F8750
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 22:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJHUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 16:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJHUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 16:19:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB3B4A4;
        Sat,  8 Oct 2022 13:19:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3320CB80BED;
        Sat,  8 Oct 2022 20:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EC1C433D6;
        Sat,  8 Oct 2022 20:19:42 +0000 (UTC)
Date:   Sat, 8 Oct 2022 16:19:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ftrace: Correct access mode
Message-ID: <20221008161928.7098b068@rorschach.local.home>
In-Reply-To: <20221008083250.3160-1-leo.yan@linaro.org>
References: <20221008083250.3160-1-leo.yan@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Oct 2022 08:32:50 +0000
Leo Yan <leo.yan@linaro.org> wrote:

> The documentation gives an example for opening trace marker with
> write-only mode, but the flag WR_ONLY is not defined by glibc.
> 
> Use O_WRONLY to replace it.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  Documentation/trace/ftrace.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index b37dc19e4d40..60bceb018d6a 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -564,7 +564,7 @@ of ftrace. Here is a list of some of the key files:
>  
>  	start::
>  
> -		trace_fd = open("trace_marker", WR_ONLY);
> +		trace_fd = open("trace_marker", O_WRONLY);

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  
>  	Note: Writing into the trace_marker file can also initiate triggers
>  	      that are written into /sys/kernel/tracing/events/ftrace/print/trigger

