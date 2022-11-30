Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71F63D123
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiK3IyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiK3IyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:54:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A582CDD9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:54:04 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669798441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxAtT2RyEbhsqxXgIB0l6BTa7WQnOPHGL1+w+BbQDt0=;
        b=gSoAVl/ItJQWaXPjCAuS+VaMPAVR+iO2Ybx/2EuWg5SefNi4AOsh91JmnrMmu+Z5rE3ej6
        2SeWRr1lRZ6QjRjRMGhAzJxrHGpbRmxmRqLB1J+ATWiRxfdpndWQEBOULMUrRzb/46rYtD
        grB7/jVk7CIr1Wq4zwJiwRj3dqgpdWged/pslNEjT/Zw4QABcDu5Z7fLjQfeN2IuzEAUOP
        5x7jqMuT4JhDoDDmslZtJ+j4VY3EbaJjm7qzRyPGbcK75u+rcPMnHinGZtz2I3kMIhIYDP
        Nd1SM/xrvQj/KCKCpf7L5Fi60omfTljt/SjOhFWqNdKgr5zJjdYFFZNhYr98EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669798441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oxAtT2RyEbhsqxXgIB0l6BTa7WQnOPHGL1+w+BbQDt0=;
        b=YHHF/7FruMxPTIa1WMFamICsykbMx4HScEOkEE+iCTNsHWXrylTU5Ulyn/Q3O7NbM17CNC
        sLIeZdQcsLmAviDQ==
To:     paulmck@kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: next-20221122: tinyconfig: ppc n s390:
 kernel/printk/printk.c:95:1: error: type specifier missing, defaults to
 'int'; ISO C99 and later do not support implicit int
 [-Werror,-Wimplicit-int]
In-Reply-To: <20221130001834.GA552288@paulmck-ThinkPad-P17-Gen-1>
References: <CA+G9fYvCWwndXdsvuW7iJ25wgfN6_iMY-OC_z6ufSwiJkzFFMw@mail.gmail.com>
 <87o7szoyij.fsf@jogness.linutronix.de>
 <20221122144839.GI4001@paulmck-ThinkPad-P17-Gen-1>
 <87leo3ovpw.fsf@jogness.linutronix.de> <Y3zw7nv5KJ32P4FG@alley>
 <20221122220053.GO4001@paulmck-ThinkPad-P17-Gen-1>
 <87wn7m7fas.fsf@jogness.linutronix.de>
 <20221122234222.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221130001834.GA552288@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 30 Nov 2022 09:59:46 +0106
Message-ID: <877czcx1ph.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 2022-11-29, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> And this seems have avoided breaking things, so I moved it on top of
> the earlier srcunmisafe.2022.11.09a stack with a new
> srcunmisafe.2022.11.29a branch name.
>
> If you need me to, I can push this into the upcoming merge window.  Or
> you could rebase on top of it, so that when the printk() series goes
> in, this commit will come along for the ride.

It would be great if the series could land in linux-next, to give any
other issues with the series a chance to show up.

Also, since the series is relatively significant, it would probably be
better if it was pushed into the 6.2 merge window by you. Petr will need
to make sure the printk series for the merge window is properly rebased
for it.

Thanks for helping us out here.

John
