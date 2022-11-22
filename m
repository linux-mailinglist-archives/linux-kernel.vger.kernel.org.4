Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A8634384
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiKVSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiKVSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:20:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7607C47A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:20:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DEB4B81D36
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ED3C433D6;
        Tue, 22 Nov 2022 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669141244;
        bh=ceNU5XII/EkTj7P6FArHTm/ysabdhOhtj1854DbTSQ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IsyJXNM75SEUXLq+37x04YZs1KNmPPRxIG9Su8qRpDCiFQwzDTeJ5G9/oXulStnWo
         2xcKttOy9UJfq0NWd37H0wDno/tyOdLaIX1NGEBBs5BaLI8lt5wtnnlxmiYxzWEh9d
         fmGvu1m3JxcJ8Au9iBqgD72uRAqd+DkDfFTfWvSJmhvTOXIAjdQ5aabMYa8YuyY+Yw
         y5uxqn8YeAX0WbRmO7NuX2ODcjmNGX5j7yjDf+F87sK3shayzKMkhEYaHTEW9QCJbg
         U5BqMj0lIONIlVQCNzofXtWH9EgCoX+rOHKbV3ODuR9nAhjU/DNCwODBoADkJqwqIn
         cnd0pUMdfbZGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 864885C312A; Tue, 22 Nov 2022 10:20:44 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:20:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
Message-ID: <20221122182044.GN4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
 <Y3zw7nv5KJ32P4FG@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zw7nv5KJ32P4FG@alley>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:55:26PM +0100, Petr Mladek wrote:
> On Tue 2022-11-22 16:33:39, John Ogness wrote:
> > On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >> @paulmck: Do you have a problem with permanently activating CONFIG_SRCU?
> > >
> > > The people wanting it separate back in the day were those wanting very
> > > tiny kernels.  I have not heard from them in a long time, so maybe it
> > > is now OK to just make SRCU unconditional.
> > 
> > Who decides this? Or maybe I should create a semaphore-based Variant of
> > console_srcu_read_lock()/console_srcu_read_unlock() for the
> > "!CONFIG_PRINTK && !CONFIG_SRCU" case?
> 
> I would prefer to avoid it. It would require keeping this in mind.
> Semaphore behaves very differently than srcu_read_lock (deadlocks,
> nesting).
> 
> I am not sure how much the tiny SRCU would increase the size of
> the kernel. I doubt that it would be more that what printk()
> added by the various per-CPU and per-console buffers.
> 
> Well, another question is why we actually need to register the consoles
> at all for !CONFIG_PRINTK. Only reasons come to my mind:
> 
>    + /dev/console
>    + preventing double registration/unregistration (initialization)
> 
> I could imagine to handle these two use-cases a special way
> on tiny systems. But I would do it only when anyone complains.

Tiny SRCU is indeed tiny.

And given the large number of "select SRCU" statements out there,
I doubt that there are very many Linux kernels running in production
without SRCU.  Very likely none at all, actually.

I will put together a patch series.

							Thanx, Paul
