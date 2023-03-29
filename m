Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248F36CF489
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjC2U3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjC2U3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:29:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A01A4EF2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 13:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 147FB61DD3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22ECC433D2;
        Wed, 29 Mar 2023 20:29:33 +0000 (UTC)
Date:   Wed, 29 Mar 2023 16:29:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [for-next][PATCH 25/25] tracing: Unbreak user events
Message-ID: <20230329162932.3028e909@gandalf.local.home>
In-Reply-To: <20230329194554.139185152@goodmis.org>
References: <20230329194516.146147554@goodmis.org>
        <20230329194554.139185152@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I forgot to Cc Beau on this.

-- Steve

On Wed, 29 Mar 2023 15:45:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The user events was added a bit prematurely, and there were a few kernel
> developers that had issues with it. The API also needed a bit of work to
> make sure it would be stable. It was decided to make user events "broken"
> until this was settled. Now it has a new API that appears to be as stable
> as it will be without the use of a crystal ball. It's being used within
> Microsoft as is, which means the API has had some testing in real world
> use cases. It went through many discussions in the bi-weekly tracing
> meetings, and there's been no more comments about updates.
> 
> I feel this is good to go.
> 
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index c7020e071bf9..8cf97fa4a4b3 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -792,7 +792,6 @@ config USER_EVENTS
>  	bool "User trace events"
>  	select TRACING
>  	select DYNAMIC_EVENTS
> -	depends on BROKEN || COMPILE_TEST # API needs to be straighten out
>  	help
>  	  User trace events are user-defined trace events that
>  	  can be used like an existing kernel trace event.  User trace

