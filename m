Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D6F6643EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjAJPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjAJPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:01:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694A3DBD6;
        Tue, 10 Jan 2023 07:01:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC073B816C6;
        Tue, 10 Jan 2023 15:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8563C433EF;
        Tue, 10 Jan 2023 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362860;
        bh=GkCuuUBbGtzHyqbeeZPCcr9oBpcB3S976YGyi9EQ3lU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jNxYzCjP4awMUYu3nopScrmNXpXer1dVDj9DpXABoWtqyCOgoX64jfGgufJJ6+C7a
         LRw0XIspZ0Ph/T1uxqh1yXYmyoOOc5QOvo8MOZ1uu7/BRlZXue9ilexm1JNGU8g5jP
         /2SVvdF5Oi5v0Sfvj4KmJtnYFeGMCGkB33my/qiI31xpo/MSHhk9lMA7N0ZpJb72wu
         P4fkp7rB7rxzNIVhcsjUYA9bW1HE0yQBXDQSV/1VRGfy/w6MBtJUHrknUV1lWLe2X7
         HdrN2wX6jXISi7Lr519FDbCMv1mbLn/TRct48Oy59Kgt+0U5rB1YPiqhhwSkHrXQyN
         BcCBWgvLBfNdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55A165C0687; Tue, 10 Jan 2023 07:01:00 -0800 (PST)
Date:   Tue, 10 Jan 2023 07:01:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: [PATCH rcu 12/27] drivers/devfreq: Remove "select SRCU"
Message-ID: <20230110150100.GN4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-12-paulmck@kernel.org>
 <49e7326a-2813-db52-9833-dbd5092cb971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e7326a-2813-db52-9833-dbd5092cb971@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:07:54PM +0900, Chanwoo Choi wrote:
> On 23. 1. 5. 09:37, Paul E. McKenney wrote:
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Cc: <linux-pm@vger.kernel.org>
> > ---
> >  drivers/devfreq/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 9754d8b316211..3c4862a752b5a 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -1,7 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  menuconfig PM_DEVFREQ
> >  	bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) support"
> > -	select SRCU
> >  	select PM_OPP
> >  	help
> >  	  A device may have a list of frequencies and voltages available.
> 
> Applied it. Thanks.

Thank you!  I will drop mine on my next rebase.

							Thanx, Paul
