Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334CF63B6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiK2BH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234898AbiK2BHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:07:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B5DF82;
        Mon, 28 Nov 2022 17:07:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D499D61195;
        Tue, 29 Nov 2022 01:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C472C433C1;
        Tue, 29 Nov 2022 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669684072;
        bh=bCqd8v9lHjL2ul05e/LBwa+/suvL7rIevjVdtH4HU4A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z/b1PdS2AWRPx5gGRafxRu0Pe/zco/UmEBogfjOULopORXR1WBwyYoed5eQiQkCpy
         t+ZtE/eOdHCZ6ZR/THF0D2ZCP3iCFgfJCtJI4yOB3OaYITdCpsaVfgMXXQJHGPKLer
         a7anDOIAqUkGv/32wpsAwW0EvIcicCFpuv+gFzpd1Zu2SNKYKqbGim8w08dNguJ2zE
         C3ZtUdJ21cIMpzYtHAGwianSnRjp2wX34/rGvTBlYuo+uQOyKWlctcvMFFMGa7Fjjz
         2ERds7mcEHDtcN4tUrvsN35Rhe41yusducMoIfek8LJmuzzbxoAPIsMLCPiMBl0+wC
         vguu+vMfBEiAQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BFA305C0EBE; Mon, 28 Nov 2022 17:07:51 -0800 (PST)
Date:   Mon, 28 Nov 2022 17:07:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>, bagasdotme@gmail.com,
        frederic@kernel.org, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        mathieu.desnoyers@efficios.com, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, rostedt@goodmis.org, sfr@canb.auug.org.au
Subject: Re: [PATCH v3] doc: Fix htmldocs build warnings of stallwarn.rst
Message-ID: <20221129010751.GA72848@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221124062204.1932-1-thunder.leizhen@huawei.com>
 <5689fac5-9ea9-a631-8ed0-a68dbbbe2466@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5689fac5-9ea9-a631-8ed0-a68dbbbe2466@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 12:09:01PM +0900, Akira Yokosawa wrote:
> Hi,
> 
> On Thu, 24 Nov 2022 14:22:03 +0800, Zhen Lei wrote:
> > Documentation/RCU/stallwarn.rst:
> > 401: WARNING: Literal block expected; none found.
> > 428: WARNING: Literal block expected; none found.
> > 445: WARNING: Literal block expected; none found.
> > 459: WARNING: Literal block expected; none found.
> > 468: WARNING: Literal block expected; none found.
> > 
> > The literal block need to be indented, so add two spaces to each line.
> > 
> > In addition, ':', which is used as a boundary in the literal block, is
> > replaced by '|'.
> > 
> > Link: https://lore.kernel.org/linux-next/20221123163255.48653674@canb.auug.org.au/
> > Fixes: 3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Tested "make htmldocs" on top of -rcu tree's dev.
> Resulting stallwarn.html looks much better!
> 
> Tested-by: Akira Yokosawa <akiyks@gmail.com>

Queued for further testing and review, thank you all!

							Thanx, Paul

>         Thanks, Akira
> 
> > ---
> >  Documentation/RCU/stallwarn.rst | 56 ++++++++++++++++++---------------
> >  1 file changed, 30 insertions(+), 26 deletions(-)
> > 
> > v2 --> v3:
> > 1. Add "Link:", "Fixes:", "Reported-by:".
> > 2. Remove a orphaned pipe (|).
> > 3. Change ". ::" to "::"
> > 
> > v1 --> v2:
> > For the case that both colons need to be deleted, change "::" to expanded
> > form or partially minimized form.
