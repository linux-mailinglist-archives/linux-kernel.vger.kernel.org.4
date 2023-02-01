Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF2685C32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjBAAdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjBAAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:33:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BF012F2A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:33:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140CA61727
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC74C433EF;
        Wed,  1 Feb 2023 00:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675211591;
        bh=YRSDj1AY6NhREBukfAEgo5c+XXgcGO8hS75WhBsfoV4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tNE224bjpLI0s4JnC5dNW6xd7DX0tKGV8ZNDLHizAr2O80FDsPQlayqGWYLXXDEb6
         AIO7VHG7Bnc1qrmUTrgggleBZFNH20A7qxwFeuF1NXdMX4Z1ycAK23Ts/fAvs954Tk
         Bu/pwXW9dbwej/D1t10V75mhO+LQx1JswSDmfyNpmrCYypZo0CzamCMrE7h/k/vJ2f
         bIBb6TNc3xBnx7PaGTudpmKgnSWqgO1+Js0kL6+JLKaVLU9I4n1gG6AVJtQXJgYtyo
         IvWn9mp34UYfj7o5gpSk0cZbP+bW9kQIBVFdBWPN75g9l+waDvrbz+yuB+rU0DreuG
         LvE4ejWPkhOHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 168495C0623; Tue, 31 Jan 2023 16:33:11 -0800 (PST)
Date:   Tue, 31 Jan 2023 16:33:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning for next-20221118
Message-ID: <20230201003311.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123002258.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123014812.7gptbvvndzemt5nc@treble>
 <20221123174951.GZ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123181941.fh4hrr3pazelwtxc@treble>
 <20221123191242.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <20221123223214.gxwyrakfj7nbs2fb@treble>
 <20221123230612.GM4001@paulmck-ThinkPad-P17-Gen-1>
 <20230128190634.GA1043262@paulmck-ThinkPad-P17-Gen-1>
 <20230201000247.3x3jev6xxxxkfrnm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201000247.3x3jev6xxxxkfrnm@treble>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 04:02:47PM -0800, Josh Poimboeuf wrote:
> On Sat, Jan 28, 2023 at 11:06:34AM -0800, Paul E. McKenney wrote:
> > Sorry to be a nag, but I am still seeing this.  Not a huge problem because
> > I now filter it out so that it does not get in the way of other bugs,
> > but I figured that I should follow up.
> 
> Does this fix it? (works for me)

A quick touch test indicates that it does indeed fix it, thank you!

I am also rerunning the exact test setup that generated the original
warning, but I don't expect any nasty surprises.

							Thanx, Paul

> If so, I'll need to extend it for all arches.
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 40d156a31676..5db0daba750f 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -712,6 +712,7 @@ void arch_cpu_idle_enter(void)
>  void arch_cpu_idle_dead(void)
>  {
>  	play_dead();
> +	BUG();
>  }
>  
>  /*
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 314802f98b9d..7fbbd1572288 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -185,7 +185,7 @@ void arch_cpu_idle(void);
>  void arch_cpu_idle_prepare(void);
>  void arch_cpu_idle_enter(void);
>  void arch_cpu_idle_exit(void);
> -void arch_cpu_idle_dead(void);
> +void __noreturn arch_cpu_idle_dead(void);
>  
>  int cpu_report_state(int cpu);
>  int cpu_check_up_prepare(int cpu);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f26ab2675f7d..921b8b3e3d0c 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -71,7 +71,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
>  void __weak arch_cpu_idle_prepare(void) { }
>  void __weak arch_cpu_idle_enter(void) { }
>  void __weak arch_cpu_idle_exit(void) { }
> -void __weak arch_cpu_idle_dead(void) { }
> +void __weak arch_cpu_idle_dead(void) { while (1); }
>  void __weak arch_cpu_idle(void)
>  {
>  	cpu_idle_force_poll = 1;
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 4b7c8b33069e..a9cb925bf095 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -167,6 +167,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
>  		"__reiserfs_panic",
>  		"__stack_chk_fail",
>  		"__ubsan_handle_builtin_unreachable",
> +		"arch_cpu_idle_dead",
>  		"cpu_bringup_and_idle",
>  		"cpu_startup_entry",
>  		"do_exit",
