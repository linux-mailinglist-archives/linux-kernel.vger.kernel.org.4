Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59B63D384
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiK3KhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiK3KhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:37:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6E45EDD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:37:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 20D3421B12;
        Wed, 30 Nov 2022 10:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669804637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shiALCOBs6Gr0Fj6n/xwDyUCSQqGUoGgam4so5jJ91A=;
        b=PiD8Bvnvc7HUJgEHthVGkG1yYFDPSVdhAXH8A36YGgcZV/S0jz3gMlUmHW8RCqU7l0nxax
        XPa0nzmB/wlWxO+yyTdcZ9hzmW64ul0dzCMVSipGEG/hdRZuKUofBzMLHWhj85GIClMByJ
        5QlBNdE/eRmsdWjta1RfzwCrZXFaYLU=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EB8422C149;
        Wed, 30 Nov 2022 10:37:16 +0000 (UTC)
Date:   Wed, 30 Nov 2022 11:37:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     paulmck@kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
Message-ID: <Y4cyXLfpTXRwOsof@alley>
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de>
 <Y3zw7nv5KJ32P4FG@alley>
 <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <87wn7m7fas.fsf@jogness.linutronix.de>
 <20221122234222.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221130001834.GA552288@paulmck-ThinkPad-P17-Gen-1>
 <877czcx1ph.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877czcx1ph.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-30 09:59:46, John Ogness wrote:
> Hi Paul,
> 
> On 2022-11-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > And this seems have avoided breaking things, so I moved it on top of
> > the earlier srcunmisafe.2022.11.09a stack with a new
> > srcunmisafe.2022.11.29a branch name.
> >
> > If you need me to, I can push this into the upcoming merge window.  Or
> > you could rebase on top of it, so that when the printk() series goes
> > in, this commit will come along for the ride.
> 
> It would be great if the series could land in linux-next, to give any
> other issues with the series a chance to show up.
> 
> Also, since the series is relatively significant, it would probably be
> better if it was pushed into the 6.2 merge window by you. Petr will need
> to make sure the printk series for the merge window is properly rebased
> for it.

I have rebased the branch rework/console-list-lock in printk/linux.git
on top of the new srcunmisafe.2022.11.29a.

It means that the changes will be part of the pull request from
the printk tree.

Anyway, it would be nice if Paul adds this branch into the pull request
for RCU tree as well. Then we could both send pull request soon
and it will not matter which one will be handled first.

Does it make any sense, please?

I have never done it this way before. The motivation is to allow
sending both pull requests soon. Linus likes early pull requests.
The fact that it will go also via RCU tree would make it clear
that Paul wanted to send it in this form. Or is it a bad idea?
Do I over-complicate it?

Best Regards,
Petr
