Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984346DEAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjDLEw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDLEwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E914EE1;
        Tue, 11 Apr 2023 21:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E319762DF7;
        Wed, 12 Apr 2023 04:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8F1C433EF;
        Wed, 12 Apr 2023 04:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681275140;
        bh=8lvgbqxpZS7LWiUXWiKwTmk6A1A2wNVnb94GRGPYfIQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pwbvIysT5erxtyf9nuIA6gEOFFtyjEiSOwg+cYZaU//WxUfjwfjNQnP3HoMUvpyV5
         paJx2jkV9xZkLGx41TjfcL3azU1X+TKcZb92kwBWXB8gp3YpXTNAVbhyxwA5hskGa1
         MBhO8hFG0xTYUmPeV/6NiI2otIp3/QPf5t8xiGYrc7ogfOJ/G71aT+T0y0oFeMaOkA
         mx0OaYwz11jC4VZE/zK+3LToj6A7VCE58MSBeP5xl/tb8J/BzRXgiPvqgqqucMM68a
         Qm56UMqTXRltDaGUdfgz5s0uQCGqTDn7BEAoxpxTGtvJJon/yNl+Zq9UGdsvrzg8cW
         BP9FdrwIOsoDw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E12B91540478; Tue, 11 Apr 2023 21:52:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 21:52:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lin Yu Chen <starpt.official@gmail.com>
Cc:     corbet@lwn.net, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: Fix typo in Documentation/RCU/checklist.rst
Message-ID: <ddef7eae-6fd4-4a79-881f-e99fbed48d67@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230411141341.74133-1-starpt.official@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411141341.74133-1-starpt.official@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 07:13:41AM -0700, Lin Yu Chen wrote:
> This commit corrects the spelling of "not" to "note" to accurately
> convey the intended meaning.
> 
> Signed-off-by: Lin Yu Chen <starpt.official@gmail.com>

Good eyes, thank you!

However, Qiuxu Zhuo beat you to this one, please see this commit
in the -rcu tree:

e5ad8b68f8d4 ("Documentation/RCU: s/not/note/ in checklist.rst")

							Thanx, Paul

> ---
>  Documentation/RCU/checklist.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
> index cc361fb01ed4..bd3c58c44bef 100644
> --- a/Documentation/RCU/checklist.rst
> +++ b/Documentation/RCU/checklist.rst
> @@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
>  	can serve as rcu_read_lock_sched(), but is less readable and
>  	prevents lockdep from detecting locking issues.
>  
> -	Please not that you *cannot* rely on code known to be built
> +	Please note that you *cannot* rely on code known to be built
>  	only in non-preemptible kernels.  Such code can and will break,
>  	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
>  
> -- 
> 2.25.1
> 
