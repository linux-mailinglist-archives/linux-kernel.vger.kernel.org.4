Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B390A64E4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLOXmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:42:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C843F587;
        Thu, 15 Dec 2022 15:42:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A32061FAF;
        Thu, 15 Dec 2022 23:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5347C433EF;
        Thu, 15 Dec 2022 23:42:04 +0000 (UTC)
Date:   Thu, 15 Dec 2022 18:42:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not synchronize freeing of trigger filter
 on boot up
Message-ID: <20221215184202.7ebb3055@gandalf.local.home>
In-Reply-To: <20221215231027.GS4001@paulmck-ThinkPad-P17-Gen-1>
References: <20221213172429.7774f4ba@gandalf.local.home>
        <20221214084954.e759647a2f5f1a38bc78b371@kernel.org>
        <20221214200333.GA3208104@paulmck-ThinkPad-P17-Gen-1>
        <20221215100241.73a30da8@gandalf.local.home>
        <20221215170256.GG4001@paulmck-ThinkPad-P17-Gen-1>
        <20221215135102.556ee076@gandalf.local.home>
        <20221215190158.GK4001@paulmck-ThinkPad-P17-Gen-1>
        <20221215173913.5432bfbf@gandalf.local.home>
        <20221215231027.GS4001@paulmck-ThinkPad-P17-Gen-1>
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

On Thu, 15 Dec 2022 15:10:27 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> The nice thing about the current placement of rcu_scheduler_starting()
> is that there is not yet any other task to switch to.  ;-)

Fair enough. Anyway the last patch appears to do the job.

Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
