Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3921666A381
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAMTlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjAMTkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:40:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C3BF76;
        Fri, 13 Jan 2023 11:39:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 606DAB821AC;
        Fri, 13 Jan 2023 19:38:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4B5C433EF;
        Fri, 13 Jan 2023 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673638738;
        bh=vlnmm/O7DlFaDeVKwNejA4fovrCbP+j0Q9YzyXT4DlQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ryYakuDPSknRt3Bz8BSlZQGC60Q71eSTQ9IyvXqlIaf4Kptt+9kcnWMP9xtMn9FjA
         XK5YEdZ82czQmR6cQ2l3AF9kq/xLT8F8B1EnsMQHabYs4vB3qxWub0KCEImHFaeR0N
         pB5cNGzmTaH33WdGM4yk85R7gNBXgkejr5L9OkhoaxcFsDckMarXyyuwuNz+okVg5P
         vMRU3bFlc9AEerz9XZjjeekSMpZscgaWvNBE9JwDK52hyIV5+XG3YdSwoaNjBVoKJv
         0JHXNdtFTkI2Qad01hkBMQ1ZoZVt/cFqbWX5AiWrDVKBGo0gH1cvr/nmkbURvGd3Jk
         Jr73D/1B0LdTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8D9CA5C06D0; Fri, 13 Jan 2023 11:38:57 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:38:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation/RCU: Fix a typo in checklist.rst
Message-ID: <20230113193857.GD4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113083108.59302-1-qiuxu.zhuo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113083108.59302-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:31:08PM +0800, Qiuxu Zhuo wrote:
> "Please not that you *cannot* rely..." probably has a typo.
> Fix it.
> 
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> Not sure whether it's a too small typo to need this patch.
> If so, sorry for the noise. :-)

Not at all!  Queued for the v6.4 merge window, thank you.  (Not the
upcoming merge window, but the one after that.)

							Thanx, Paul

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
> 2.17.1
> 
