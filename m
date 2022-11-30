Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D363CC77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiK3ASl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiK3ASg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:18:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312ED6D49E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 16:18:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA3561975
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC16C433C1;
        Wed, 30 Nov 2022 00:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669767515;
        bh=32P7Tdfu4Ts5oM1uLmW0Lc5o3FyYiZ6VzqkhhwVK6bY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lhErzqz6u8Wu1Yk5vaAkZiKuy5s79QNPnTGdMZMCnpiCIDkrYForl6RAYOZ8n4Y+Y
         IbVNE4hhbWnxmaPyh7ck+Aow19zsCaeUbEvVvV9XsfDwYQvJcnqAPllq0VhOsKUYzG
         iJNBzJ0H6sqFtfc9iTKZzssBCCJuRIVPY25UUx414oPcMrp+lDDohL+4pQtAgkMgeY
         2wpASgDqOBckAaV+TFC+0oeTSEftjr42h7kRMOSKRz4ddyv5Z6gRvlmmS7NuuM+WRp
         DfLfnfufV/hBeLudO8j80pl3hx2UobSUD8MQyxvLC1Wv13h5dOoZtXlGUaHMyJ09NB
         +Gw9uNLu7JeXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A47B75C0584; Tue, 29 Nov 2022 16:18:34 -0800 (PST)
Date:   Tue, 29 Nov 2022 16:18:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
Message-ID: <20221130001834.GA552288@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
 <Y3zw7nv5KJ32P4FG@alley>
 <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <87wn7m7fas.fsf@jogness.linutronix.de>
 <20221122234222.GQ4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122234222.GQ4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:42:22PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 23, 2022 at 12:20:19AM +0106, John Ogness wrote:
> > On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > And here is a first cut.  There will be more patches removing uses
> > > of CONFIG_SRCU.
> > >
> > > Thoughts?
> > 
> > I am happy with it. Thanks!
> > 
> > >     rcu: Make SRCU mandatory
> > >     
> > >     Kernels configured with CONFIG_PRINTK=n and CONFIG_SRCU=n get build
> > >     failures.  This causes trouble for deep embedded systems.  But given
> > >     that there are more than 25 instances of "select SRCU" in the kernel,
> > >     it is hard to believe that there are many kernels running in production
> > >     without SRCU.  This commit therefore makes SRCU mandatory.  The SRCU
> > >     Kconfig option remains for backwards compatibility, and will be removed
> > >     when it is no longer used.
> > >     
> > >     Reported-by: John Ogness <john.ogness@linutronix.de>
> > >     Reported-by: Petr Mladek <pmladek@suse.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
> Applied both, and thank you both!

And this seems have avoided breaking things, so I moved it on top of the
earlier srcunmisafe.2022.11.09a stack with a new srcunmisafe.2022.11.29a
branch name.

If you need me to, I can push this into the upcoming merge window.
Or you could rebase on top of it, so that when the printk() series goes
in, this commit will come along for the ride.

Your choice, just let me know!

							Thanx, Paul
