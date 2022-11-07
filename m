Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB51C61EA51
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 06:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKGFCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 00:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKGFCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 00:02:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716EC26D2;
        Sun,  6 Nov 2022 21:02:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C6F3B80DBB;
        Mon,  7 Nov 2022 05:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE5CC433D6;
        Mon,  7 Nov 2022 05:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667797334;
        bh=2aiJHArwsupxkp1IsuKbI6DmVORpLnjh1xSSGylUQ4U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=idPmHuoZsj0NP1+z0T7FuC1wOLNYOgVR1P/Ngxv/XmTFNAsgEsq67hHpH6ftDpi7c
         wwxTszTcA6XcTd0mp5BRpotqbXvwKU2jFm2hL9+AvlZvFap5zkoP6pw2DkkAoRysK+
         r7ArF8dzFk0PoBxW2nWyTwD3WkRtXR/mjPlzIda4uugRqqaLntaeEcmpjvWIXsJphA
         Hh5MtzZ4jvrUGHUdvFZLAPOd7PN2P2TD/TCdvB/+G9J/hr9FQdX1p6rNWiV892+Y9B
         jwcHjLggT4M2s6HHNzCsYhWcpKtZE1fKTsCmgAS+xtB7ixw/CIyZyePcujB7OFbulr
         RDZ0fbegNUvsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F174C5C196D; Sun,  6 Nov 2022 21:02:12 -0800 (PST)
Date:   Sun, 6 Nov 2022 21:02:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the rcu tree
Message-ID: <20221107050212.GG28461@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221107142641.527396ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107142641.527396ea@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:26:41PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rcu tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/RCU/rcubarrier.rst:205: WARNING: Literal block ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   21c2e3909721 ("doc: Update rcubarrier.rst")

Huh.  I guess that numbered code samples are not supposed to have more
than nine lines?  Ah well, easy to fix by going back to left-justified
numbers.  I was wondering about that!

Apologies for the hassle!

							Thanx, Paul
