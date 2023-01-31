Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB850682F96
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjAaOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjAaOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:46:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A347EF3;
        Tue, 31 Jan 2023 06:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C561B81D1C;
        Tue, 31 Jan 2023 14:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FBFC433EF;
        Tue, 31 Jan 2023 14:46:06 +0000 (UTC)
Date:   Tue, 31 Jan 2023 09:46:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] tracing: clean up some inconsistent indentings
Message-ID: <20230131094404.06a477fd@gandalf.local.home>
In-Reply-To: <20230131061935.53453-1-yang.lee@linux.alibaba.com>
References: <20230131061935.53453-1-yang.lee@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 14:19:35 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> kernel/trace/trace_events_synth.c:567 trace_event_raw_event_synth() warn: inconsistent indenting
> 

NACK!

This just removes the warning and hence it hides the bug!

This was already reported by kernel test robot:
   https://lore.kernel.org/all/202301302110.mEtNwkBD-lkp@intel.com/

I have a fix but haven't posted it yet.

-- Steve

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3892
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  kernel/trace/trace_events_synth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index adb630633f31..949d4cbe3f82 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -564,7 +564,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
>  					   event->fields[i]->is_dynamic,
>  					   data_size, &n_u64);
>  			data_size += len; /* only dynamic string increments */
> -		} if (event->fields[i]->is_stack) {
> +		}
> +		if (event->fields[i]->is_stack) {
>  		        long *stack = (long *)(long)var_ref_vals[val_idx];
>  
>  			len = trace_stack(entry, event, stack,

