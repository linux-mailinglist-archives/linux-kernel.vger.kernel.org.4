Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9004264BE13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiLMUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiLMUnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:43:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A11C935
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:43:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5DDF61729
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D74BC433D2;
        Tue, 13 Dec 2022 20:43:49 +0000 (UTC)
Date:   Tue, 13 Dec 2022 15:43:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [RFC][PATCH] trace: Add trace points for tasklet entry/exit
Message-ID: <20221213154347.118e6444@gandalf.local.home>
In-Reply-To: <20221213185310.1315794-1-jstultz@google.com>
References: <20221213185310.1315794-1-jstultz@google.com>
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

On Tue, 13 Dec 2022 18:53:10 +0000
John Stultz <jstultz@google.com> wrote:

> From: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> 
> Tasklets are supposed to finish their work quickly and
> should not block the current running process, but it is not
> guaranteed that. Currently softirq_entry/exit can be used to
> know total tasklets execution time, but not helpful to track
> individual tasklet's execution time. With that we can't find
> any culprit tasklet function, which is taking more time.
> 
> Add tasklet_entry/exit trace point support to track
> individual tasklet execution.
> 
> This patch has been carried in the Android tree for awhile
> so I wanted to submit it for review upstream. Feedback would
> be appreciated!
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Connor O'Brien <connoro@google.com>
> Cc: kernel-team@android.com
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> [elavila: Port to android-mainline]
> Signed-off-by: J. Avila <elavila@google.com>
> [jstultz: Rebased to upstream, cut unused trace points, added
>  comments for the tracepoints, reworded commit]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---

This looks fine to me.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
