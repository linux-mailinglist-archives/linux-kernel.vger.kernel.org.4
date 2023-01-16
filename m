Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D166B6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAPEpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjAPEog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:44:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0CA25C;
        Sun, 15 Jan 2023 20:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 515D460EAD;
        Mon, 16 Jan 2023 04:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B098EC433D2;
        Mon, 16 Jan 2023 04:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673844249;
        bh=b5bxrr6nNjYt4gGv6ALOoPkAE74HTQR7crVVVQarvaw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QIV02z2hXXleDgcedQFlslz4LxhF0QTEh1zojbykGkO5Qj8aiuyhOpaRz7nHdwOzN
         gOlLcVlVQLEvjCKTJ1ZmzLI0mPiQ/+EQ+PlPnQihnJ7reo+UbiYvZ0aNmePPQ5yYyU
         CXRXUwfwZKB4kc8jWuKyMSzsT53Ltp9puNTOWixTQifH+i/retIiNgymV0sDTASVUA
         ZVXLq6Cd6gIm6gPcjvm2ZE2m93+DnfhaH4igXCvTrrdNSh1THCe2lEZem/dhtO8loW
         D97+YbnBrDxgQvlyyWPCM2jcXgjHjn2rBrP2dMitScKA9fmn157D/VWNbxcsoIWsFt
         YtH2QPtR6Tngg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 57B295C05A0; Sun, 15 Jan 2023 20:44:09 -0800 (PST)
Date:   Sun, 15 Jan 2023 20:44:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <20230116044409.GS2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230116123821.41d336ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116123821.41d336ea@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 12:38:21PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the tip tree as a different commit
> (but the same patch):
> 
>   836dc5db1d87 ("context_tracking: Use arch_atomic_*() in __ct_user_enter and __ct_user_exit")
> 
> It is commit
> 
>   0e26e1de0032 ("context_tracking: Fix noinstr vs KASAN")
> 
> in the tip tree.

Plus I have yet another copy in the -rcu tree.  I will drop it on my
next rebase.

							Thanx, Paul
