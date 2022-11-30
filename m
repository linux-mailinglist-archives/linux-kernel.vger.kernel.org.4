Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1638963E2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiK3V70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3V7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:59:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631DE68C55
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 13:59:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0047861E13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58889C433C1;
        Wed, 30 Nov 2022 21:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669845558;
        bh=I7ZPJe9XHlqMia81O3uhYe6fc1scXYz7V1EB4g8dyAw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pS6nMyNACaLCcqO3OgOZ60Y5WffasZSPTyo6XEFeVn3f7xrjn8EpRCkZ2fT/+euyT
         vbtRNvHMVYevjkJFITHYw9ikIdNm/azl0T3DZKlz20oxAoFDOo5JwMYH+lEP6Z463A
         N6xDtatv/qOv0bsjHOvygDMXLGmNFdFvSvDM0r/1q3BWdQBziR9DSESi0FfQL+KQcL
         D7SRISUuKtbT7NrbBlrDpBYuq+GmlzkYwuLqtD+lDWe7rL+QcFi1ME0CRcak4/YMK1
         dtFF8GLwRr0K367ICS82Z/lHrGhzelP2KeURyubA1EK0Fu5RqHFVrDudEi7Mb5lgzG
         tSIBEvr0Sy8tQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F0D425C051C; Wed, 30 Nov 2022 13:59:17 -0800 (PST)
Date:   Wed, 30 Nov 2022 13:59:17 -0800
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
Message-ID: <20221130215917.GY4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
 <Y3zw7nv5KJ32P4FG@alley>
 <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <87wn7m7fas.fsf@jogness.linutronix.de>
 <20221122234222.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221130001834.GA552288@paulmck-ThinkPad-P17-Gen-1>
 <877czcx1ph.fsf@jogness.linutronix.de>
 <Y4cyXLfpTXRwOsof@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4cyXLfpTXRwOsof@alley>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:37:16AM +0100, Petr Mladek wrote:
> On Wed 2022-11-30 09:59:46, John Ogness wrote:
> > Hi Paul,
> > 
> > On 2022-11-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > And this seems have avoided breaking things, so I moved it on top of
> > > the earlier srcunmisafe.2022.11.09a stack with a new
> > > srcunmisafe.2022.11.29a branch name.
> > >
> > > If you need me to, I can push this into the upcoming merge window.  Or
> > > you could rebase on top of it, so that when the printk() series goes
> > > in, this commit will come along for the ride.
> > 
> > It would be great if the series could land in linux-next, to give any
> > other issues with the series a chance to show up.
> > 
> > Also, since the series is relatively significant, it would probably be
> > better if it was pushed into the 6.2 merge window by you. Petr will need
> > to make sure the printk series for the merge window is properly rebased
> > for it.
> 
> I have rebased the branch rework/console-list-lock in printk/linux.git
> on top of the new srcunmisafe.2022.11.29a.

Very good, thank you!

> It means that the changes will be part of the pull request from
> the printk tree.
> 
> Anyway, it would be nice if Paul adds this branch into the pull request
> for RCU tree as well. Then we could both send pull request soon
> and it will not matter which one will be handled first.
> 
> Does it make any sense, please?
> 
> I have never done it this way before. The motivation is to allow
> sending both pull requests soon. Linus likes early pull requests.
> The fact that it will go also via RCU tree would make it clear
> that Paul wanted to send it in this form. Or is it a bad idea?
> Do I over-complicate it?

All fair points.

I have srcunmisafe.2022.11.29a merged into -rcu immediately following
my RCU merge commit for the upcoming merge window.  My current rcu/next
branch includes it.

So if there are no mandatory-SRCU explosions in -next by Sunday December
4th, I will send Linus this commit in the merge window that is currently
slated to open the week of December 12th:

ec69c6900127 ("srcunmisafe.2022.11.29a: Make SRCU mandatory.")

As the title suggests, this includes the desired commit.

If there are explosions, well, we will deal with them and see where
we go from there.  My fallback commit would be this guy:

87492c06e68d ("Merge branches 'doc.2022.10.20a', 'fixes.2022.10.21a', 'lazy.2022.11.30a', 'srcunmisafe.2022.11.09a', 'torture.2022.10.18c' and 'torturescript.2022.10.20a' into HEAD")

This excludes that commit.  But hopefully there will be no explosions
that cannot be taken care of quickly.

Does that work for you?

							Thanx, Paul
