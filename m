Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11C63F7FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLATOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLATOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:14:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000CCA432D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:14:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AEE1B8200D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A34AC433C1;
        Thu,  1 Dec 2022 19:14:29 +0000 (UTC)
Date:   Thu, 1 Dec 2022 14:14:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
Message-ID: <20221201141426.08411b29@gandalf.local.home>
In-Reply-To: <202212010852.6D4B542@keescook>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
        <166991263326.311919.16890937584677289681.stgit@devnote3>
        <202212010838.B0B109DA@keescook>
        <20221201114848.13a87aca@gandalf.local.home>
        <202212010852.6D4B542@keescook>
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

On Thu, 1 Dec 2022 08:53:02 -0800
Kees Cook <keescook@chromium.org> wrote:

> > Have you not been reading this thread?  
> 
> I skimmed it -- trying to catch up from turkey week. If this was already
> covered, then please ignore me. It just wasn't obvious from the commit
> log why it was included.

That's a better request :-)

That is, please add why this is needed for BPF (and also include a Link:
tag to this thread).

-- Steve
