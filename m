Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0901E678385
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjAWRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWRps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:45:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F27D91E5FD;
        Mon, 23 Jan 2023 09:45:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58C02C14;
        Mon, 23 Jan 2023 09:46:26 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14F23F71E;
        Mon, 23 Jan 2023 09:45:43 -0800 (PST)
Date:   Mon, 23 Jan 2023 17:45:41 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] ftrace/scripts: Update the instructions for
 ftrace-bisect.sh
Message-ID: <Y87HxUN/mcC99Xj6@FVFF77S0Q05N>
References: <20230123112252.022003dd@gandalf.local.home>
 <Y869C8HcHownYfII@FVFF77S0Q05N>
 <20230123121147.341b0992@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123121147.341b0992@gandalf.local.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:11:47PM -0500, Steven Rostedt wrote:
> On Mon, 23 Jan 2023 16:59:55 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > > +# The old (slow) way, for kernels before v5.1.
> > > +#
> > > +# [old-way] # cat available_filter_functions > ~/full-file
> > > +#
> > > +# [old-way] *** Note *** this will take several minutes. Setting multiple
> > > +# [old-way] functions is an O(n^2) operation, and we are dealing with thousands
> > > +# [old-way] of functions. So go have  coffee, talk with your coworkers, read
> > > +# [old-way] facebook. And eventually, this operation will end.  
> > 
> > Super-trivial nit, but the above step isn't actually that expensive, and it's
> > the subsequent write to set_ftrace_filter that's going to be slow.
> 
> How about:
> 
>  "*** Note *** this process will take several minutes to update the filters." 

Sounds good to me! :)

FWIW, with that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> > That double spacing in 'go have  coffee' looks odd; is that an old error from
> > reformatting a line break, and/or a missing 'a' ?
> 
> I can fix that.

Thanks!

> > How about:
> > 
> > # [old-way] *** Note *** writing function names to set_ftrace_filter will take
> > # [old-way] several minutes. Setting multiple functions is an O(n^2) operation,
> > # [old-way] and we will set thousands of functions. So for subsequent steps,
> > # [old-way] go have a coffee, talk with your coworkers, read facebook. And
> > # [old-way] eventually, this operation will end.
> > 
> > ... or leave this in place below, and add "If using [old-way] ..." to the start?
> 
> I wanted to explicitly show that the above is only a reference to the old
> way, and leave no doubt about it. It was either doing this or deleting it
> completely. I chose to keep it.

Fair enough!

Mark.
