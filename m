Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0DF63EE17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiLAKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiLAKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:42:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAAE54465;
        Thu,  1 Dec 2022 02:42:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BAC3521B21;
        Thu,  1 Dec 2022 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669891318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrDyVcK51+fIcxn7DpPFqr3mP3lLiCkb6MliQynUwgE=;
        b=Vv9OVNm79Av0F2QVTn/ISJlH+1QSAWCPU3n+ck/owo40mpoX1wSC8xMZBxkYDWhUTIK9Cc
        we6uahoEFZFEKt7VMeZZkmE9SFkkKUiglTapUyn/dSKhbyFucKdMDtJEKkoRE8UxHs5svx
        Uz/oVbkSX9MZ2hmCeOL0a6d2L51x6GM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C8E9F2C141;
        Thu,  1 Dec 2022 10:41:57 +0000 (UTC)
Date:   Thu, 1 Dec 2022 11:41:57 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the printk tree
Message-ID: <Y4iE9YL75WQNazSv@alley>
References: <20221201105504.71c318f0@canb.auug.org.au>
 <20221130235959.GE4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130235959.GE4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-11-30 15:59:59, Paul E. McKenney wrote:
> On Thu, Dec 01, 2022 at 10:55:04AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the rcu tree got a conflict in:
> > 
> >   kernel/rcu/update.c
> > 
> > between commit:
> > 
> >   64e838679e14 ("rcu: Make SRCU mandatory")
> > 
> > from the printk tree and commit:
> > 
> >   0cd7e350abc4 ("rcu: Make SRCU mandatory")
> > 
> > from the rcu tree.
> > 
> > I fixed it up (I just used the latter - it kept the WARN_ON_ONCE) and
> > can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> > 
> > Maybe you could share a (non rebasing) topic branch?
> 
> Please accept my apologies for the hassle!
> 
> We are sharing a topic branch, but it recently changed and was therefore
> rebased.  You saw -rcu providing the updated version to -next, but what
> with timezones and all, printk() is still providing the old one.

I have rebased the printk tree on top of the updated commit
0cd7e350abc4 ("rcu: Make SRCU mandatory").

All should be fine now.

It is great the linux-next exists.

Best Regards,
Petr
