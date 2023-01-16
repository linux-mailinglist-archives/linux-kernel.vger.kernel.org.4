Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84B66B6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjAPElh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjAPEld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:41:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985F7EEC;
        Sun, 15 Jan 2023 20:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D9060EA3;
        Mon, 16 Jan 2023 04:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4F3C433D2;
        Mon, 16 Jan 2023 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673844090;
        bh=VsTEaqei0Tw8E99cgNfiMgiyNqjGZJ2QFOtt9jci3SA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D9YgZwdJ5xtyJt1BHIoJFj68Cn2YK68Dhjaqg/0CU1cPwqcAjZQ58oAaDNSbEXhvB
         PBFhZmCYn0TjwxF5Rzr1FN+x9UMLGiG4/d6yu6YyTsnfwek1wTplp8sMMdXx+joLAk
         9WqashouEwtvTwAKDja6uKLMFqzyvbUxEXXD5FgLA6WPzjjLF1qMnwgRR1Oq8e6b0n
         8rjDkGlBIANQ/164xQE2gZg19qfN7IGLPIR9qBOgH/N3U7eVkds5wvkfxHl2Q0B6aD
         c0L8YotMj2Com8NcafPRwDWMxuTMrFQfuUn1j8zlIfQjkXECjQ2KfILfgjD51ifmqS
         QeasEx0sMW0sA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 582435C05A0; Sun, 15 Jan 2023 20:41:30 -0800 (PST)
Date:   Sun, 15 Jan 2023 20:41:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Teigland <teigland@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <20230116044130.GR2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109101117.2a55e070@canb.auug.org.au>
 <20230116123151.3a491801@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116123151.3a491801@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 12:31:51PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 9 Jan 2023 10:11:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > The following commit is also in the dlm tree as a different commit
> > (but the same patch):
> > 
> >   2674cc2403f8 ("fs/dlm: Remove "select SRCU"")
> 
> This is now commit 7d470a3572f9 in the rcu tree ...

I have added this to my list to drop on my next rebase.  Not sure what
happened on the previous rebases.

							Thanx, Paul
