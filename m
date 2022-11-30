Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6263E5F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLAAAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLAAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:00:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075BC55CBE;
        Wed, 30 Nov 2022 16:00:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86AC4614D0;
        Thu,  1 Dec 2022 00:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCD3C433C1;
        Wed, 30 Nov 2022 23:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669852799;
        bh=A8QePwwq3UcIYS0FtIj0J/YbSPxOT9xQQdTxngvK8HU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hnnthAWgXOCsYXshrFqNDz7f88K4x5axlnAPYPw5A7oizRo2mLgr5toTTlV0KcMVM
         UXWd57BtNLPlytOwaNdCpEnZBMdFU4vV2VT47JPeWc1SQJb/IXGFqrBqKbAgDBfaU5
         4WGc++pgaOt6DC0LZGLL3IUy8aFOy5NRz+ZWBK0ZdmLgJ0ZYCmbCO3fXIa7c7SA3M2
         LoxNYmDOaCIgxVvPMB4u+57nOkomIrl03bBtkxEqNQchqypYhhlOg7g3Najj4832vz
         DAR5xQqEYeCmpFmcaCLrLeN4jaAVneOhGAQE5Di9DDOSpY2Ce0MA4Ei8uiZF2H3j8o
         GoA9GbE0RWfDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 852245C089E; Wed, 30 Nov 2022 15:59:59 -0800 (PST)
Date:   Wed, 30 Nov 2022 15:59:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the printk tree
Message-ID: <20221130235959.GE4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221201105504.71c318f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201105504.71c318f0@canb.auug.org.au>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:55:04AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   kernel/rcu/update.c
> 
> between commit:
> 
>   64e838679e14 ("rcu: Make SRCU mandatory")
> 
> from the printk tree and commit:
> 
>   0cd7e350abc4 ("rcu: Make SRCU mandatory")
> 
> from the rcu tree.
> 
> I fixed it up (I just used the latter - it kept the WARN_ON_ONCE) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.
> 
> Maybe you could share a (non rebasing) topic branch?

Please accept my apologies for the hassle!

We are sharing a topic branch, but it recently changed and was therefore
rebased.  You saw -rcu providing the updated version to -next, but what
with timezones and all, printk() is still providing the old one.

With a little luck, this will straighten itself out soon.

							Thanx, Paul
