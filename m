Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFBE7456AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGCIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjGCIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:00:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852F1E43;
        Mon,  3 Jul 2023 01:00:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40E29218E5;
        Mon,  3 Jul 2023 08:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688371248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bd/LciAqDCV/m74RUrNOjpcJEH3cskz5UoOcCQ0l1X8=;
        b=KlX3jAmyxcFEWIbgel3UsuOION4p5niC9HJdhLBUOC5gBqjtuF5uJw06wQ26o9tXUkIxf/
        itr4MDfX8C695FiVFdXb4a0SYsAZdEYS1LaalJ2SYeCLmallZxEYOaZuUeKCSkCK6IB/5F
        Aiy8rwsgMqNZY1Z2vX47SXTwBhoXDG4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22F37138FC;
        Mon,  3 Jul 2023 08:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FtKmBTCAomT7ZAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 03 Jul 2023 08:00:48 +0000
Date:   Mon, 3 Jul 2023 10:00:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, bigeasy@linutronix.de,
        pmladek@suse.com, will@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com,
        mgorman@techsingularity.net, longman@redhat.com,
        lgoncalv@redhat.com, john.ogness@linutronix.de, david@redhat.com,
        boqun.feng@gmail.com, mm-commits@vger.kernel.org
Subject: Re: +
 mm-page_alloc-use-write_seqlock_irqsave-instead-write_seqlock-local_irq_save.patch
 added to mm-unstable branch
Message-ID: <ZKKAL9o4lC1Iw5SP@dhcp22.suse.cz>
References: <20230702234049.DCE06C433C8@smtp.kernel.org>
 <b8c61ac6-220a-fb08-90a6-d14ff7754ab9@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c61ac6-220a-fb08-90a6-d14ff7754ab9@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-07-23 09:09:46, Tetsuo Handa wrote:
> Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> because of https://lkml.kernel.org/r/a1c559b7-335e-5401-d167-301c5b1cd312@I-love.SAKURA.ne.jp .

This is not really productive approach! You are rising non-material
concerns you haven't proven to be real. This is blocking otherwise
useful fix. I am completely fine recording your nack with a reference to
your concern should we ever trip over your concerns and so we can easily
revert and find a different solution but I do not believe this should
stand in the way in the fix.

Now concerning the patch 1 in the series, I do agree this should be
passing through the lockdep maintainers. But this fix is not really
dependent on it.

> On 2023/07/03 8:40, Andrew Morton wrote:
> > The patch titled
> >      Subject: mm/page_alloc: use write_seqlock_irqsave() instead write_seqlock() + local_irq_save().
> > has been added to the -mm mm-unstable branch.  Its filename is
> >      mm-page_alloc-use-write_seqlock_irqsave-instead-write_seqlock-local_irq_save.patch
> > 
> > This patch will shortly appear at
> >      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-page_alloc-use-write_seqlock_irqsave-instead-write_seqlock-local_irq_save.patch
> > 
> > This patch will later appear in the mm-unstable branch at
> >     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > 
> > Before you just go and hit "reply", please:
> >    a) Consider who else should be cc'ed
> >    b) Prefer to cc a suitable mailing list as well
> >    c) Ideally: find the original patch on the mailing list and do a
> >       reply-to-all to that, adding suitable additional cc's
> > 
> > *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> > 
> > The -mm tree is included into linux-next via the mm-everything
> > branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > and is updated there every 2-3 working days

-- 
Michal Hocko
SUSE Labs
