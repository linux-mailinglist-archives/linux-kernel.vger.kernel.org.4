Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA06368F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiKWSdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbiKWScc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:32:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95126453;
        Wed, 23 Nov 2022 10:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 831A761E73;
        Wed, 23 Nov 2022 18:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9952C433C1;
        Wed, 23 Nov 2022 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669228345;
        bh=qlJGkQUoH97jjulOJM08KV8g3ZWseUgpcf17OKcB79c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jppLilPjVrlbm208AqRfBA9BYCISp8szS9PJbocUzBxqDon0m4d9BJs9hqowDn3Jx
         CYvcH2hqxOPG8JeHsN2qpAqy9MJ7wTuq2WlouqqkPpz6jz9lQ8ROWCfs0wvQrCXCY3
         JxSiJZDnOlwqAVQV0FpYluRImZGrDk35EwTlKvUikXSP+Xtu58CSyUKU9iDcLpLm2C
         yicnPkzMvxgiRrMYqM0+5QW4Kg5m3WmQs2bzkhUVrHaW4sOJw/C34NywjRZ6ryrlYI
         7VZlra67etNM8CUbrSnwfGyfFXWfyON1aYEzlemqXsvgSd9BZZ0G0EW8QDcwnWapr8
         88tPHZA7LsQFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9DD645C0A3F; Wed, 23 Nov 2022 10:32:24 -0800 (PST)
Date:   Wed, 23 Nov 2022 10:32:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] docs/RCU/rcubarrier: Adjust 'Answer' parts of QQs as
 definition-lists
Message-ID: <20221123183224.GB4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <b74e2e19-0317-e717-cc15-a7854b04adf4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74e2e19-0317-e717-cc15-a7854b04adf4@gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 06:23:09PM +0900, Akira Yokosawa wrote:
> The "Answer" parts of QQs divert from proper format of definition-lists
> as described at [1] and are not rendered as such.
> 
> Adjust them.
> 
> Link: [1] https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#definition-lists
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Applied both, thank you!

							Thanx, Paul

> ---
>  Documentation/RCU/rcubarrier.rst | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
> index 5a643e5233d5..9fb9ed777355 100644
> --- a/Documentation/RCU/rcubarrier.rst
> +++ b/Documentation/RCU/rcubarrier.rst
> @@ -296,7 +296,8 @@ Quick Quiz #1:
>  	Is there any other situation where rcu_barrier() might
>  	be required?
>  
> -Answer: Interestingly enough, rcu_barrier() was not originally
> +Answer:
> +	Interestingly enough, rcu_barrier() was not originally
>  	implemented for module unloading. Nikita Danilov was using
>  	RCU in a filesystem, which resulted in a similar situation at
>  	filesystem-unmount time. Dipankar Sarma coded up rcu_barrier()
> @@ -315,7 +316,8 @@ Quick Quiz #2:
>  	Why doesn't line 8 initialize rcu_barrier_cpu_count to zero,
>  	thereby avoiding the need for lines 9 and 10?
>  
> -Answer: Suppose that the on_each_cpu() function shown on line 8 was
> +Answer:
> +	Suppose that the on_each_cpu() function shown on line 8 was
>  	delayed, so that CPU 0's rcu_barrier_func() executed and
>  	the corresponding grace period elapsed, all before CPU 1's
>  	rcu_barrier_func() started executing.  This would result in
> @@ -351,7 +353,8 @@ Quick Quiz #3:
>  	are delayed for a full grace period? Couldn't this result in
>  	rcu_barrier() returning prematurely?
>  
> -Answer: This cannot happen. The reason is that on_each_cpu() has its last
> +Answer:
> +	This cannot happen. The reason is that on_each_cpu() has its last
>  	argument, the wait flag, set to "1". This flag is passed through
>  	to smp_call_function() and further to smp_call_function_on_cpu(),
>  	causing this latter to spin until the cross-CPU invocation of
> 
> base-commit: 741cfda870057958c53f9cb0b21ac33f531baaf4
> -- 
> 2.25.1
> 
