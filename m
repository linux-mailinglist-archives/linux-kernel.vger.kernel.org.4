Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667B3648A2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLIVnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:43:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CAF1E736;
        Fri,  9 Dec 2022 13:42:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2BEA6234A;
        Fri,  9 Dec 2022 21:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5694C433D2;
        Fri,  9 Dec 2022 21:42:57 +0000 (UTC)
Date:   Fri, 9 Dec 2022 16:42:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Donglin Peng <dolinux.peng@gmail.com>
Cc:     tzanussi@gmail.com, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: ftrace: fix a issue with duplicated subtitle
 number
Message-ID: <20221209164255.6c15e535@gandalf.local.home>
In-Reply-To: <20221209025119.1371570-1-dolinux.peng@gmail.com>
References: <20221209025119.1371570-1-dolinux.peng@gmail.com>
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

On Thu,  8 Dec 2022 18:51:19 -0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> The subtitle "5.3 Clearing filters" and "5.3 Subsystem filters" has
> the same index number, let's fix it.
> 
> Fixes: 95b696088c1c ("tracing/filters: add filter Documentation")
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Jon, care to take this?

Thanks!

-- Steve

> ---
>  Documentation/trace/events.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index c47f381d0c00..8f86eef1bada 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -258,7 +258,7 @@ file.
>  To clear the filters for all events in a subsystem, write a '0' to the
>  subsystem's filter file.
>  
> -5.3 Subsystem filters
> +5.4 Subsystem filters
>  ---------------------
>  
>  For convenience, filters for every event in a subsystem can be set or
> @@ -305,7 +305,7 @@ their old filters)::
>  	# cat sched_wakeup/filter
>  	common_pid == 0
>  
> -5.4 PID filtering
> +5.5 PID filtering
>  -----------------
>  
>  The set_event_pid file in the same directory as the top events directory

