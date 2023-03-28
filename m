Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145E86CC9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjC1SQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjC1SQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:16:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F989F;
        Tue, 28 Mar 2023 11:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F17E2B81E36;
        Tue, 28 Mar 2023 18:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67F7C433D2;
        Tue, 28 Mar 2023 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680027392;
        bh=mX5FRbksEdfPlA5RUWG2p76bf5c21aezUdzZqBwXRc4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RF5Oo+8B15Rvbo4Iy/ABMMd3rpjtWQ0KLqJf4DuK8e69IgLmRwg1BH/0ck2+iyfJg
         Usy5YSlziFGN7jauK5Zgtqva2leRhdF85jgXTDEbqfJnuHtQ3CdjwR06duuDRjbgDG
         dC5TGL+vhzmFTbTfvk4T49lxKtTuNSW3ZVgKjHAxPoe3bL5Iu1jVg4rBs7ixulJHSG
         UGjjxaCXKkIkh0Nef1eDQxCB1JoJZ7IGEbh3JBIOzS+O/I7QCCPGa18XCvZY47dSFd
         jqNbz3MyHsApeDTpjRhHwWjpFEdYZr2KuJjBB5iXN4CVMj4fDtmYLlTNCgVuNopFeU
         HngDaNdAKISaA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A16F1540479; Tue, 28 Mar 2023 11:16:32 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:16:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        rcu@vger.kernel.org
Subject: Re: [tip: smp/core] kernel/smp: Make csdlock_debug= resettable
Message-ID: <c6169b0d-94e5-43c3-bb9b-997b478a0e6f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230321005516.50558-4-paulmck@kernel.org>
 <167999248681.5837.4240401894848544789.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167999248681.5837.4240401894848544789.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:34:46AM -0000, tip-bot2 for Paul E. McKenney wrote:
> The following commit has been merged into the smp/core branch of tip:
> 
> Commit-ID:     203e435844734cfa503cd1755f35db2514db5cca
> Gitweb:        https://git.kernel.org/tip/203e435844734cfa503cd1755f35db2514db5cca
> Author:        Paul E. McKenney <paulmck@kernel.org>
> AuthorDate:    Mon, 20 Mar 2023 17:55:16 -07:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Fri, 24 Mar 2023 11:01:26 +01:00
> 
> kernel/smp: Make csdlock_debug= resettable

Very good, thank you!  I have removed these from the -rcu tree's "dev"
branch, and if testing goes well will be sending the new version to -next.

							Thanx, Paul

> It is currently possible to set the csdlock_debug_enabled static
> branch, but not to reset it.  This is an issue when several different
> entities supply kernel boot parameters and also for kernels built with
> CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT=y.
> 
> Therefore, make the csdlock_debug=0 kernel boot parameter turn off
> debugging.  Last one wins!
> 
> Reported-by: Jes Sorensen <Jes.Sorensen@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Juergen Gross <jgross@suse.com>
> Link: https://lore.kernel.org/r/20230321005516.50558-4-paulmck@kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 13 +++++++------
>  kernel/smp.c                                    | 11 ++++++++---
>  2 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b15198a..5f2ec4b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -889,12 +889,13 @@
>  	cs89x0_media=	[HW,NET]
>  			Format: { rj45 | aui | bnc }
>  
> -	csdlock_debug=	[KNL] Enable debug add-ons of cross-CPU function call
> -			handling. When switched on, additional debug data is
> -			printed to the console in case a hanging CPU is
> -			detected, and that CPU is pinged again in order to try
> -			to resolve the hang situation.  The default value of
> -			this option depends on the CSD_LOCK_WAIT_DEBUG_DEFAULT
> +	csdlock_debug=	[KNL] Enable or disable debug add-ons of cross-CPU
> +			function call handling. When switched on,
> +			additional debug data is printed to the console
> +			in case a hanging CPU is detected, and that
> +			CPU is pinged again in order to try to resolve
> +			the hang situation.  The default value of this
> +			option depends on the CSD_LOCK_WAIT_DEBUG_DEFAULT
>  			Kconfig option.
>  
>  	dasd=		[HW,NET]
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 7a85bcd..298ba75 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -116,11 +116,16 @@ static DEFINE_STATIC_KEY_MAYBE(CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT, csdlock_debug
>   */
>  static int __init csdlock_debug(char *str)
>  {
> +	int ret;
>  	unsigned int val = 0;
>  
> -	get_option(&str, &val);
> -	if (val)
> -		static_branch_enable(&csdlock_debug_enabled);
> +	ret = get_option(&str, &val);
> +	if (ret) {
> +		if (val)
> +			static_branch_enable(&csdlock_debug_enabled);
> +		else
> +			static_branch_disable(&csdlock_debug_enabled);
> +	}
>  
>  	return 1;
>  }
