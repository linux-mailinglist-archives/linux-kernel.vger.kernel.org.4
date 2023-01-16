Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76D66B6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 05:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjAPEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 23:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjAPEjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 23:39:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C35249;
        Sun, 15 Jan 2023 20:39:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3EAB80D1D;
        Mon, 16 Jan 2023 04:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48828C433D2;
        Mon, 16 Jan 2023 04:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673843945;
        bh=0QPl8nwsl8BGr7XsE/hiHs/gh56ZYxgcDmE0A6dC+2Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pqw/obpxEP1PYv5H6SGSWA7P9+8beL3tAZbYolRVcS9/sPE+pyux3kHLCBhvVUViV
         fij5OwvYNpdgU5GXrqZ5zyDdxZ48Sk9t/Ue4j0K2H3Zm0wuj85E8uJSgr/ujw4kohG
         nuvO9AI6Tc9uSKLXtQglpE3/YZcANrkLUkcH1STVJa56M4BZZyEG50C5/s0VB+Uq7m
         faAWW5fyTLMt6VbHqlgvtukeb4Zd5fQMmv24UwyJLTWWkw1t3NUD9iJ1ueA9fhMBSz
         VcMiSSNBYETsoK9UjF+fH9S0FWV2S4VsLDebpTj+Hcaixp4GrkiZiSx7SV6rVoN4aK
         ZOEt965XemmTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D97CF5C05A0; Sun, 15 Jan 2023 20:39:04 -0800 (PST)
Date:   Sun, 15 Jan 2023 20:39:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the tomoyo tree
Message-ID: <20230116043904.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230111111439.4c4745d2@canb.auug.org.au>
 <20230116122841.67cbc7fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116122841.67cbc7fc@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 12:28:41PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 11 Jan 2023 11:14:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the rcu tree got a conflict in:
> > 
> >   security/tomoyo/Kconfig
> > 
> > between commit:
> > 
> >   80f8be7af03f ("tomoyo: Omit use of bin2c")
> > 
> > from the tomoyo tree and commit:
> > 
> >   ed87f6865857 ("tomoyo: Remove "select SRCU"")
> > 
> > from the rcu tree.
> 
> So the rcu tree commit is now duplicated in the tomoyo tree (but
> slightly different due to the bin2c commit).

I will be dropping it from -rcu on my next rebase, and apologies for
the hassle!

							Thanx, Paul
