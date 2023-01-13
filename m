Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F365D66A3A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjAMTrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjAMTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:47:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512FED2FB;
        Fri, 13 Jan 2023 11:47:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAC22B821AC;
        Fri, 13 Jan 2023 19:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E834C433D2;
        Fri, 13 Jan 2023 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673639250;
        bh=trURWyxaGIWMItlm7vEr9MA2H7W42GYsbU5eJZfOv+I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vi1q5cQe53U1qisWzw2QCE3TVQu3x1Pnp+CYvmhe5fg/p4CqjzkmweqqEZjx1RT0s
         xHjRIR460pZ7/fVG+g42/zrZmF1rg36U0XhdHI5VGWftkYKUXds7x1/qMG653sLG40
         Fv1SUUKCYTIeO18X50MVFfIbqVN+9fRqVbkM0dHRugU+EnQKOykVItQ7H6uwie91EQ
         wlOEYuaPfqEnph3JceeT79Z8Iiyv4x+v83O8DSnLBYhEoLEyu9sg/juMeUJGAffrSf
         wB8n4+yOCeGbHMiS0uSxjckIK+o9FdIjYMLd1/ahisAgg2vDZYNY7w21SYVd4wPt0m
         pGqOdSXIK51sA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D5525C06D0; Fri, 13 Jan 2023 11:47:30 -0800 (PST)
Date:   Fri, 13 Jan 2023 11:47:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH rcu v2 05/20] drivers/hwtracing/stm: Remove "select SRCU"
Message-ID: <20230113194730.GG4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
 <20230113001132.3375334-5-paulmck@kernel.org>
 <871qnysa7u.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qnysa7u.fsf@ubik.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 05:52:37PM +0200, Alexander Shishkin wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> 
> Accidentally acked the previous version. This appears to be the same.

I somehow missed that ack, probably fat-fingered it.  :-/

> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul
