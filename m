Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FD6BE005
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCQEK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCQEKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:10:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4A17CF8;
        Thu, 16 Mar 2023 21:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9C58B823F2;
        Fri, 17 Mar 2023 04:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960FDC433EF;
        Fri, 17 Mar 2023 04:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679026236;
        bh=QvZ5gV1saIPSO2uCw4OHBFsnU96E62dijbWa0Ok4l6Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LgZahAZJ5A4aKmpxPvxTZtPEVMfQw1S1cVUTEMNmlhSJ0+sjPyT2vfWvxPjRK0/K3
         K9MMkCW1qlEiMC4eh/K/ZTsOMAW/zjyDPFd0iuvbS+lClrwAsEUOtcCRFfq6a0mxir
         typt0+JpkhWuTYTCZJvre2NPvM01ymCxkap6AnbCLtpKQUuC0HSk0o8W+9SqUwycuN
         aHQO9A+md/0udngSl8RkmS+m2QL0OZnCLvzwUQZUMk6U4Eq1VZ1r8WwIRl8CbAzq5b
         sL4ai4K3JIKMaho9KPKcjTztKqdx6v//XTRrrZlWUA+m5BcwXZSJC5T4XOQxAwA8hN
         cSxw1GofOz6aA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 307941540395; Thu, 16 Mar 2023 21:10:36 -0700 (PDT)
Date:   Thu, 16 Mar 2023 21:10:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself to RCU entry
Message-ID: <4ee9e39a-e87a-4c9f-802f-3ce546b4e196@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230317032905.10837-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317032905.10837-1-boqun.feng@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 08:29:05PM -0700, Boqun Feng wrote:
> Just to be clear, the "M:" tag before my name is short of "Minions" ;-)
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Welcome aboard!  ;-)

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d5bc223f305..370d2970b193 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17638,6 +17638,7 @@ M:	"Paul E. McKenney" <paulmck@kernel.org>
>  M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
>  M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
>  M:	Josh Triplett <josh@joshtriplett.org>
> +M:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  R:	Lai Jiangshan <jiangshanlai@gmail.com>
> -- 
> 2.39.2
> 
