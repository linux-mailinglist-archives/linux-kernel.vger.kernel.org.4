Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA2678F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 05:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjAXEsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 23:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjAXEsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:48:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284136FD2;
        Mon, 23 Jan 2023 20:48:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D8B660F4D;
        Tue, 24 Jan 2023 04:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB169C433D2;
        Tue, 24 Jan 2023 04:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674535720;
        bh=cdZSy4HVJi5q/GdGD/RtQ2K0KuSPNHmEF1e93Oo+QcE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DWnngTyFHKSe7yWXvaqjX86ipfypfvJC/5LZUY3mz1mzOXYlL22JNKAarGT30EdKj
         xBLxJPsgri/GCqaLa+ns1Ruvi4kKJujj/Z+sQGy1NOK8+beol+4ht/sGLIsp3HHxC+
         lgTcC39HWSxTHv7tj0ve1bPiYKNpB96H33GqsbGQKM46ElV2WP4oP0ei6NKGOZ+/o2
         4K6LPgSKi3XZT5ZoBBx09HLmrQX0zlQsOOMGh5Gi4TJYfUV8cqAnP5SmynbF4NkC/T
         mtcUx4xw1qus/5QS8bHXqqvnPy/1iQP+9h3pDw1W/1WUmXXbDGGeAJ0sIWjBGlKwfL
         XOiLjssb35l8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 788D05C1183; Mon, 23 Jan 2023 20:48:40 -0800 (PST)
Date:   Mon, 23 Jan 2023 20:48:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the rcu tree
Message-ID: <20230124044840.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124120107.205ca8ae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124120107.205ca8ae@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 12:01:07PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the pm tree as different commits
> (but the same patches):
> 
>   ba66764b5e43 ("kernel/power: Remove "select SRCU"")
>   e5ded8e65e70 ("drivers/cpufreq: Remove "select SRCU"")
> 
> Thesea are also commits
> 
>   52e0452b413d ("PM: sleep: Remove "select SRCU"")
>   38a29e5834eb ("drivers/cpufreq: Remove "select SRCU"")
> 
> in the pm tree.

My tests passed, so I have now pushed out an rcu/next branch with
these commits dropped from -rcu.  Apologies for the hassle!

							Thanx, Paul
