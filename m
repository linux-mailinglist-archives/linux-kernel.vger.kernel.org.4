Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5DC67FA55
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 20:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjA1TGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 14:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1TGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:06:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60762618F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 11:06:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9EF60BAA
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 19:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D81EC433EF;
        Sat, 28 Jan 2023 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674932795;
        bh=xsLOU0qakVmaxu0sULZCDDb1Co+IWv8ABQ8CyhVQTOY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NGx/XQqa/2RoIFwP5wuS79QFjfK8IufPPzpov42YrJSnW5hFmqV7dWMlPERyJ1nmQ
         IvxCQalwauVoeVq7ihrebfTndaf5PaKu7c56bHRFuoQRFulpBK3vXNwi9biLJiISb5
         g8pDLOkd6iWURzjk5guh5CtcOdoL8lBf9jcl5R3eOFjzvl+HZcNBxeWVXSDnOkWuc0
         NozHa5LmtwheUxF4wDLul0KIXapUB1dEY8TUCtxeg+/Mvg5DaRkfll0ySTjMBffVB1
         KZz0rlw9xYzwCzTMjDaDh4Wzbzj97xpAlf5T1VrK3289JTNtcHtDAfDE7O5TdHKthL
         Yqgk9WaH9/Hzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DAE4F5C089F; Sat, 28 Jan 2023 11:06:34 -0800 (PST)
Date:   Sat, 28 Jan 2023 11:06:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20230128190634.GA1043262@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123002258.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123014812.7gptbvvndzemt5nc@treble>
 <20221123174951.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123181941.fh4hrr3pazelwtxc@treble>
 <20221123191242.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123223214.gxwyrakfj7nbs2fb@treble>
 <20221123230612.GM4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123230612.GM4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 03:06:12PM -0800, Paul E. McKenney wrote:
> On Wed, Nov 23, 2022 at 02:32:14PM -0800, Josh Poimboeuf wrote:
> > On Wed, Nov 23, 2022 at 11:12:42AM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 23, 2022 at 10:19:41AM -0800, Josh Poimboeuf wrote:
> > > > On Wed, Nov 23, 2022 at 09:49:51AM -0800, Paul E. McKenney wrote:
> > > > > > > > Perhaps the best way would be to stick a REACHABLE annotation in
> > > > > > > > arch_cpu_idle_dead() or something?
> > > > > > > 
> > > > > > > When I apply this on -next, I still get the objtool complaint.
> > > > > > > Is there something else I should also be doing?
> > > > > > 
> > > > > > Silly GCC is folding the inline asm.  This works (but still doesn't seem
> > > > > > like the right approach):
> > > > > > 
> > > > > > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > > > > > index 26e8f57c75ad..128e7d78fedf 100644
> > > > > > --- a/arch/x86/kernel/process.c
> > > > > > +++ b/arch/x86/kernel/process.c
> > > > > > @@ -702,7 +702,7 @@ static void (*x86_idle)(void);
> > > > > >  #ifndef CONFIG_SMP
> > > > > >  static inline void play_dead(void)
> > > > > >  {
> > > > > > -	BUG();
> > > > > > +	_BUG_FLAGS(ASM_UD2, 0, ASM_REACHABLE);
> > > > > >  }
> > > > > >  #endif
> > > > > 
> > > > > I tried this, and still get:
> > > > > 
> > > > > vmlinux.o: warning: objtool: do_idle+0x156: unreachable instruction
> > > > > 
> > > > > Maybe my gcc is haunted?
> > > > 
> > > > Weird, it worked for me.  I have
> > > > 
> > > >   gcc version 12.2.1 20220819 (Red Hat 12.2.1-2) (GCC)
> > > 
> > > Me, I have these, so quite a bit older:
> > > 
> > > gcc version 8.5.0 20210514 (Red Hat 8.5.0-15) (GCC)
> > > gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.1)
> > > 
> > > > and I can't really fathom why that wouldn't work.  Maybe it's a
> > > > different issue?  The "unreachable instruction" warning is limited to
> > > > one, so when a first warning gets fixed, a second warning might suddenly
> > > > become visible.
> > > > 
> > > > Can you attach arch/x86/kernel/process.o?
> > > 
> > > Attached!
> > 
> > Hm, for whatever reason, that .o file is indeed missing the reachable
> > annotation.  <scratches head>
> 
> There are at least three definitions.  Might I be getting the wrong one?
> 
> I have CONFIG_DEBUG_BUGVERBOSE=y and CONFIG_GENERIC_BUG=y, so I would
> expect to be using the first one:
> 
> #define _BUG_FLAGS(ins, flags, extra)					\
> do {									\
> 	asm_inline volatile("1:\t" ins "\n"				\
> 		     ".pushsection __bug_table,\"aw\"\n"		\
> 		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
> 		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
> 		     "\t.word %c1"        "\t# bug_entry::line\n"	\
> 		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
> 		     "\t.org 2b+%c3\n"					\
> 		     ".popsection\n"					\
> 		     extra						\
> 		     : : "i" (__FILE__), "i" (__LINE__),		\
> 			 "i" (flags),					\
> 			 "i" (sizeof(struct bug_entry)));		\
> } while (0)
> 
> > I confirmed the patch also fixes the warning with:
> > 
> >   gcc version 8.5.0 20210514 (Red Hat 8.5.0-10) (GCC)
> > 
> > No idea why it's not working for you... but maybe it doesn't matter as
> > I'm still thinking we should go with a different approach.
> 
> OK, then I will await your update.

Sorry to be a nag, but I am still seeing this.  Not a huge problem because
I now filter it out so that it does not get in the way of other bugs,
but I figured that I should follow up.

							Thanx, Paul
