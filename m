Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951E567D67B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjAZUep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjAZUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:34:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8D731E35;
        Thu, 26 Jan 2023 12:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D6EC6191C;
        Thu, 26 Jan 2023 20:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ADCC433D2;
        Thu, 26 Jan 2023 20:34:40 +0000 (UTC)
Date:   Thu, 26 Jan 2023 15:34:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ross Zwisler <zwisler@chromium.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] docs: ftrace: always use canonical ftrace path
Message-ID: <20230126153438.5e98da15@gandalf.local.home>
In-Reply-To: <87a6259mll.fsf@meer.lwn.net>
References: <20230125213251.2013791-1-zwisler@google.com>
        <87a6259mll.fsf@meer.lwn.net>
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

On Thu, 26 Jan 2023 11:28:38 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Ross Zwisler <zwisler@chromium.org> writes:
> 
> > The canonical location for the tracefs filesystem is at /sys/kernel/tracing.
> >
> > But, from Documentation/trace/ftrace.rst:
> >
> >   Before 4.1, all ftrace tracing control files were within the debugfs
> >   file system, which is typically located at /sys/kernel/debug/tracing.
> >   For backward compatibility, when mounting the debugfs file system,
> >   the tracefs file system will be automatically mounted at:
> >
> >   /sys/kernel/debug/tracing
> >
> > Many parts of Documentation still reference this older debugfs path, so
> > let's update them to avoid confusion.
> >
> > Signed-off-by: Ross Zwisler <zwisler@google.com>  
> 
> So this seems like a good cleanup to me.  Unless somebody objects, I'll
> apply it to the docs tree in the near future.
>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Doing a quick 'git grep 'debug/tracing' there's a lot more that needs to be
cleaned up, but that's outside the Documentation directory.

Ross, care to follow through with those? ;-)

Thanks Jon and Ross,

-- Steve
