Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EA0634B47
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiKVXmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiKVXm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:42:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E7729D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:42:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0DC6B81B7E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356E2C433C1;
        Tue, 22 Nov 2022 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669160543;
        bh=ZlcOvU3eu3r1c4u146SifF1N6YLjW6w6G9CQ1GxW/HI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l7RoRAnAV4D7mq8CPLiIBAW6X/rUoGgGCxxa33eHhRN2cc+fz+hfueqgfGygt1eQy
         XHkeWOS/MisXlIzmm7WtXesYzbSaBlONBkA9kQ+ESfFZMM+9sx7HRhJOuLq328yN8J
         piI2E89DisnOadnHYBdYTDnJoxIa2XSfA5Uj+SrfgGgpHnkFcHJLUVYdLmZcL/VQwJ
         dMZiBHgmzF3Axn/OGg/ijhD2LpqGig8T2r2a8gigK4FLnof7rYxePnQY49EFR5Eio4
         Db+ZSrVlTvf+GSPSjnytBfJbaz9T0eMrWO5JDiPTOscPIW5ZKk8cRCrfnXukIPFXW0
         BExedZup114Cw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CEC565C0BE7; Tue, 22 Nov 2022 15:42:22 -0800 (PST)
Date:   Tue, 22 Nov 2022 15:42:22 -0800
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
Message-ID: <20221122234222.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
 <Y3zw7nv5KJ32P4FG@alley>
 <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <87wn7m7fas.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn7m7fas.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 12:20:19AM +0106, John Ogness wrote:
> On 2022-11-22, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > And here is a first cut.  There will be more patches removing uses
> > of CONFIG_SRCU.
> >
> > Thoughts?
> 
> I am happy with it. Thanks!
> 
> >     rcu: Make SRCU mandatory
> >     
> >     Kernels configured with CONFIG_PRINTK=n and CONFIG_SRCU=n get build
> >     failures.  This causes trouble for deep embedded systems.  But given
> >     that there are more than 25 instances of "select SRCU" in the kernel,
> >     it is hard to believe that there are many kernels running in production
> >     without SRCU.  This commit therefore makes SRCU mandatory.  The SRCU
> >     Kconfig option remains for backwards compatibility, and will be removed
> >     when it is no longer used.
> >     
> >     Reported-by: John Ogness <john.ogness@linutronix.de>
> >     Reported-by: Petr Mladek <pmladek@suse.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Applied both, and thank you both!

							Thanx, Paul
