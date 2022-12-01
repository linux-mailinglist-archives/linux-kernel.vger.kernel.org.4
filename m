Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93B63F580
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiLAQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiLAQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:40:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19545BBBE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:40:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7CC16207C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719A0C433C1;
        Thu,  1 Dec 2022 16:40:44 +0000 (UTC)
Date:   Thu, 1 Dec 2022 11:40:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [RFC PATCH] panic: Add new taint flag for fault injection
Message-ID: <20221201114041.7eb410b1@gandalf.local.home>
In-Reply-To: <166991263326.311919.16890937584677289681.stgit@devnote3>
References: <20221201234121.8925fdf83115747ac4ac116a@kernel.org>
        <166991263326.311919.16890937584677289681.stgit@devnote3>
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

On Fri,  2 Dec 2022 01:37:13 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the function error injection framework in the fault injection
> subsystem can change the function code flow forcibly, it may cause
> unexpected behavior (but that is the purpose of this feature).
> To identify this in the kernel oops message, add a new taint flag
> for this, and set it if it is (and similar things in BPF) used.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
