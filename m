Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6CC6BF6EB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCRA2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:28:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC67BE41FE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B26D60C8E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 00:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE376C433D2;
        Sat, 18 Mar 2023 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679099278;
        bh=v0n3SvDI9nlvUCZM4h3tQJJVoAQLQmI4S7n5rZY/z54=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jbA2JRhbrqKbCvafRAfE6IqzKLGrISl6O9pvPQ5nlLdc9bU1+NgvgdhSDAfi5YWYB
         aW7Nra9aE4K2QjKixPTEov/i0FhHc2e3apJq/FZzyVTUjtrzQqE4hDvxudX39oXNVR
         1BJ190Bz6WP308Byca1sRKxBQfADzO3U4fA3dC3h0h9oPf1KmkYpFG7vy2G2a/Y/Ry
         FnHSx3lm2a88Usf1aVJJxOU3nb0pTR7/3UrKiiwNdWt/RlUrkebdDEwAz+tc3y7gyj
         ritwEKI2KxRFhiZoMzQMb4+zn+JbQujQjw7JE35UALdGaoFzd2EYmhpi2EYun8UpC0
         ePUWGnDSvePUw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2266A1540381; Fri, 17 Mar 2023 17:27:58 -0700 (PDT)
Date:   Fri, 17 Mar 2023 17:27:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Change Joel Fernandes from R: to M:
Message-ID: <239a4c83-de67-452d-b23f-a1a2692065e2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230317194404.923623-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317194404.923623-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 07:44:04PM +0000, Joel Fernandes (Google) wrote:
> I have spent years learning / contributing to RCU with several features,
> talks and presentations, with my most recent work being on Lazy-RCU.
> 
> Please consider me for M, so I can tell my wife why I spend a lot of my
> weekends and evenings on this complicated and mysterious thing -- which is
> mostly in the hopes of preventing the world from burning down because
> everything runs on this one way or another. ;-)
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec57c42ed544..2e70394ac64a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17638,11 +17638,11 @@ READ-COPY UPDATE (RCU)
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
>  M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
> +M:	Joel Fernandes <joel@joelfernandes.org>
>  M:	Josh Triplett <josh@joshtriplett.org>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  R:	Lai Jiangshan <jiangshanlai@gmail.com>
> -R:	Joel Fernandes <joel@joelfernandes.org>
>  L:	rcu@vger.kernel.org
>  S:	Supported
>  W:	http://www.rdrop.com/users/paulmck/RCU/
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
