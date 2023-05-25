Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDD17101FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 02:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjEYAZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 20:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjEYAZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 20:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E884A4;
        Wed, 24 May 2023 17:25:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CF4F63953;
        Thu, 25 May 2023 00:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E51DC433EF;
        Thu, 25 May 2023 00:25:31 +0000 (UTC)
Date:   Wed, 24 May 2023 20:25:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing/timer: Add missing hrtimer modes to
 decode_hrtimer_mode().
Message-ID: <20230524202526.289e3a65@rorschach.local.home>
In-Reply-To: <20230524153928.p9umapxB@linutronix.de>
References: <20230418143854.8vHWQKLM@linutronix.de>
        <20230424174441.3baebdef@rorschach.local.home>
        <20230524153928.p9umapxB@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 17:39:28 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2023-04-24 17:44:41 [-0400], Steven Rostedt wrote:
> > On Tue, 18 Apr 2023 16:38:54 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > The trace output for the HRTIMER_MODE_.*_HARD modes is seen as a number
> > > since these modes are not decoded. The author was not aware of the fancy
> > > decoding function which makes the life easier.
> > > 
> > > Extend decode_hrtimer_mode() with the additional HRTIMER_MODE_.*_HARD
> > > modes.
> > > 
> > > Fixes: ae6683d815895 ("hrtimer: Introduce HARD expiry mode")
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>  
> > 
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Could this be either routed via the tracing tree or the tip tree but
> please route this :)
> 

Events are normally owned by the subsystem they are used in. So it
should go through tip. But if I get an ack from the subsystem
maintainer, I can route it through tracing.

-- Steve
