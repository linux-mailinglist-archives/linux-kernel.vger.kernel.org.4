Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759EE66E1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjAQPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjAQPTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:19:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1923A3FF0B;
        Tue, 17 Jan 2023 07:19:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D02D2B81647;
        Tue, 17 Jan 2023 15:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF28C433EF;
        Tue, 17 Jan 2023 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673968780;
        bh=rLGxGIdl3NzqeAdz9fWHriOufesH0VZrGgGDRzB17t0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UQetiuaVBWCGC5zS4dMFhwIjHGkR25Ko1JDJP8sgx3+FVwDar2Oz8OZss2Km03Wtl
         UDyhOj4z4pGSXRBg1gTe53F/7pgmZIufeA34MmwTdOiOu06hlXzpveeCHcNBpbjIb/
         QXLc2kRm/++cP8Bs744BqsBzLKg/buGDwDHTyVurLFa/Oo/szLqaEIzWNY1SECDVZX
         DuSVMX2iVFXa3not3x3W5dfisY+iNgKh/JJVeBG23w7j5S3hguH6DpnESgUKnfu8CN
         EEJHxOinuy4dCRXKAQTQHDepEpiTUozsDxt4pGrEaSKsAJsKF1qNMnwhYcVbR8MI6a
         JxX2eMinn6ubQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 11E615C0543; Tue, 17 Jan 2023 07:19:40 -0800 (PST)
Date:   Tue, 17 Jan 2023 07:19:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH] rcu/rcutorture: Eliminate variable
 n_rcu_torture_boost_rterror
Message-ID: <20230117151940.GJ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230117055310.3408-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117055310.3408-1-zbestahu@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 01:53:10PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@coolpad.com>
> 
> After commit 8b700983de82 ("sched: Remove sched_set_*() return value"),
> this variable is not used anymore. So eliminate it entirely.
> 
> Signed-off-by: Yue Hu <huyue2@coolpad.com>

Good eyes!  Applied, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 634df26a2c27..327c8fbb7e00 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -179,7 +179,6 @@ static atomic_t n_rcu_torture_mbchk_tries;
>  static atomic_t n_rcu_torture_error;
>  static long n_rcu_torture_barrier_error;
>  static long n_rcu_torture_boost_ktrerror;
> -static long n_rcu_torture_boost_rterror;
>  static long n_rcu_torture_boost_failure;
>  static long n_rcu_torture_boosts;
>  static atomic_long_t n_rcu_torture_timers;
> @@ -2194,12 +2193,11 @@ rcu_torture_stats_print(void)
>  		atomic_read(&n_rcu_torture_alloc),
>  		atomic_read(&n_rcu_torture_alloc_fail),
>  		atomic_read(&n_rcu_torture_free));
> -	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld rtbre: %ld ",
> +	pr_cont("rtmbe: %d rtmbkf: %d/%d rtbe: %ld rtbke: %ld ",
>  		atomic_read(&n_rcu_torture_mberror),
>  		atomic_read(&n_rcu_torture_mbchk_fail), atomic_read(&n_rcu_torture_mbchk_tries),
>  		n_rcu_torture_barrier_error,
> -		n_rcu_torture_boost_ktrerror,
> -		n_rcu_torture_boost_rterror);
> +		n_rcu_torture_boost_ktrerror);
>  	pr_cont("rtbf: %ld rtb: %ld nt: %ld ",
>  		n_rcu_torture_boost_failure,
>  		n_rcu_torture_boosts,
> @@ -2217,15 +2215,13 @@ rcu_torture_stats_print(void)
>  	if (atomic_read(&n_rcu_torture_mberror) ||
>  	    atomic_read(&n_rcu_torture_mbchk_fail) ||
>  	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
> -	    n_rcu_torture_boost_rterror || n_rcu_torture_boost_failure ||
> -	    i > 1) {
> +	    n_rcu_torture_boost_failure || i > 1) {
>  		pr_cont("%s", "!!! ");
>  		atomic_inc(&n_rcu_torture_error);
>  		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
>  		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mbchk_fail));
>  		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
>  		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
> -		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
>  		WARN_ON_ONCE(n_rcu_torture_boost_failure); // boost failed (TIMER_SOFTIRQ RT prio?)
>  		WARN_ON_ONCE(i > 1); // Too-short grace period
>  	}
> @@ -3540,7 +3536,6 @@ rcu_torture_init(void)
>  	atomic_set(&n_rcu_torture_error, 0);
>  	n_rcu_torture_barrier_error = 0;
>  	n_rcu_torture_boost_ktrerror = 0;
> -	n_rcu_torture_boost_rterror = 0;
>  	n_rcu_torture_boost_failure = 0;
>  	n_rcu_torture_boosts = 0;
>  	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
> -- 
> 2.17.1
> 
