Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD5F6782A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjAWRL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjAWRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:11:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBF2D175;
        Mon, 23 Jan 2023 09:11:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0166360FBF;
        Mon, 23 Jan 2023 17:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81E5C433D2;
        Mon, 23 Jan 2023 17:11:51 +0000 (UTC)
Date:   Mon, 23 Jan 2023 12:11:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ftrace/scripts: Update the instructions for
 ftrace-bisect.sh
Message-ID: <20230123121147.341b0992@gandalf.local.home>
In-Reply-To: <Y869C8HcHownYfII@FVFF77S0Q05N>
References: <20230123112252.022003dd@gandalf.local.home>
        <Y869C8HcHownYfII@FVFF77S0Q05N>
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

On Mon, 23 Jan 2023 16:59:55 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> > +# The old (slow) way, for kernels before v5.1.
> > +#
> > +# [old-way] # cat available_filter_functions > ~/full-file
> > +#
> > +# [old-way] *** Note *** this will take several minutes. Setting multiple
> > +# [old-way] functions is an O(n^2) operation, and we are dealing with thousands
> > +# [old-way] of functions. So go have  coffee, talk with your coworkers, read
> > +# [old-way] facebook. And eventually, this operation will end.  
> 
> Super-trivial nit, but the above step isn't actually that expensive, and it's
> the subsequent write to set_ftrace_filter that's going to be slow.

How about:

 "*** Note *** this process will take several minutes to update the filters." 


> 
> That double spacing in 'go have  coffee' looks odd; is that an old error from
> reformatting a line break, and/or a missing 'a' ?

I can fix that.

> 
> How about:
> 
> # [old-way] *** Note *** writing function names to set_ftrace_filter will take
> # [old-way] several minutes. Setting multiple functions is an O(n^2) operation,
> # [old-way] and we will set thousands of functions. So for subsequent steps,
> # [old-way] go have a coffee, talk with your coworkers, read facebook. And
> # [old-way] eventually, this operation will end.
> 
> ... or leave this in place below, and add "If using [old-way] ..." to the start?

I wanted to explicitly show that the above is only a reference to the old
way, and leave no doubt about it. It was either doing this or deleting it
completely. I chose to keep it.

> 
> Regardless, this looks sensible to me!

Thanks, I'll send a v2 with the nit updates.

-- Steve

