Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B763F9D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiLAV3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:29:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEE17BF8D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:29:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BD8862122
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB20C433D6;
        Thu,  1 Dec 2022 21:29:28 +0000 (UTC)
Date:   Thu, 1 Dec 2022 16:29:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Mason <clm@meta.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
Message-ID: <20221201162926.559dbdf8@gandalf.local.home>
In-Reply-To: <20221201162526.2fdfd65d@gandalf.local.home>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
        <166991263326.311919.16890937584677289681.stgit@devnote3>
        <202212010838.B0B109DA@keescook>
        <20221201114848.13a87aca@gandalf.local.home>
        <202212010852.6D4B542@keescook>
        <20221201141426.08411b29@gandalf.local.home>
        <78b7a67f-8c5b-6b2e-7fb5-01c47d75c104@meta.com>
        <20221201162526.2fdfd65d@gandalf.local.home>
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

On Thu, 1 Dec 2022 16:25:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Sorry, I'm completely failing to parse.  Is this directed at Kees or
> > Benjamin?  I'm also not sure what the this is in "why this is needed for
> > BPF"?
> >   
> 
> It was directed towards Kees. I don't even know who "Benjamin" is. I don't
> see a "Benjamin" in the Cc list.

Oh, I see a Benjamin replied to another branch of the email thread.

May I suggest getting a better email client ;-)  One that has proper
threading where it is obvious which email is being replied to.

-- Steve
