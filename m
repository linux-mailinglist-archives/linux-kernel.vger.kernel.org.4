Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCFF5F4DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 05:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJEDBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 23:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJEDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 23:01:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A295D10B;
        Tue,  4 Oct 2022 20:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9496B81C76;
        Wed,  5 Oct 2022 03:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD2AC433C1;
        Wed,  5 Oct 2022 03:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664938887;
        bh=2K4KiV7cPFLSD3RGGa7NSZcyE05Kqz67W50GPiHXla8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcChFZKOLy8PrM/3mS4FU94zl7cO7jcTJijAbPcaDeobVoGq4jgy9eN3FyoWQv06F
         xePczqWR+x6ZRMNwSItfmx2PUjFbdfKvMTHzI0y1/iqcNSwrKJ9RMatq+hvFwMZEbu
         GtzKO6mxx4N0EdH2anf7olBtuq5PStHtEenWCPNfmOwkuoObQMd2w2DfUoqBekEwbu
         OrzKStlqEVhUYHIRAErUwkMGbEJRj+iCphgIbz3kNJOx1iOJ4c7A8aHqO9CXDlVBXW
         ZakIdt3/9n0Ai9F4TZ49dpMytq0yLMG6PB/RnU9x/Pgaygg+0mMty/DvVbIUcv5kj8
         PIQSjRCFA5jSA==
Date:   Tue, 4 Oct 2022 20:01:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-xfs@vger.kernel.org, Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <YzzzhsZQ4qlDrcFW@magnolia>
References: <20221004072302.345bfd4a@canb.auug.org.au>
 <20221003222103.GM3600936@dread.disaster.area>
 <20221004225012.501e11ed@canb.auug.org.au>
 <YzxX7ks+YD7U1dcl@magnolia>
 <20221004210400.GO3600936@dread.disaster.area>
 <CANubcdV462CTQQsmkaPG-dP1Cgy6BqHKj-gXZzh=U=pH+i7dfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdV462CTQQsmkaPG-dP1Cgy6BqHKj-gXZzh=U=pH+i7dfg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 10:52:05AM +0800, Stephen Zhang wrote:
> Dave Chinner <david@fromorbit.com> 于2022年10月5日周三 05:06写道：
> > As it is, I use the convention of putting an explicit From: tag in
> > the commit message that matches the SOB so tools pulling stuff from
> > mailing lists do the right thing with them (same as any third-party
> > provided patch in a series).
> >
> > > That said... I think we should get in the habit of asking patch authors
> > > to make sure that at least one of the email or name strings match
> > > between the From and SOB tags.  I can see how people who grok even less
> > > about how Chinese names work than I do (read: lawyers) might get fussy
> > > about this kind of thing.
> >
> > As per above, the normal solution is an explicit "From: <foo>" line
> > that matches the SOB.  It's just annoying that our new-fangled tools
> > haven't encoded this long-standing convention to warn us when we
> > pull a patch with a from-tag that doesn't match a sob-tag.
> >
> 
> Sorry, but I'm not sure whether what you mean is adding another "From: " line
> right above the SOB tag like:
> ====
> From: name2 <email address2>
> Date: Mon, 12 Sep 2022 xx:xx:xx +0800
> Subject: [PATCH ] xfs: fix xxx and xxx
> 
> ...
> the commit  message
> ...
> 
> From: name <email address>             //added line
> signed-off-by:  name <email address>
> ...
> ====

I think Dave means something like this patch of mine:
https://lore.kernel.org/linux-xfs/166473478893.1083155.2555785331844801316.stgit@magnolia/T/#u

From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org
Date:   Sun, 02 Oct 2022 11:19:48 -0700
Subject: [PATCH 3/4] xfs: set the buffer type after holding the AG[IF] across trans_roll

From: Darrick J. Wong <djwong@kernel.org>

Currently, the only way to lock an allocation group is to hold the AGI
and AGF buffers.  If repair needs to roll the transaction while
repairing some AG metadata, it maintains that lock by holding the two
buffers across the transaction roll and joins them afterwards.

However, repair is not the same as the other parts of XFS that employ
this bhold/bjoin sequence, because it's possible that the AGI or AGF
buffers are not actually dirty before the roll.  In this case, the
buffer log item can detach from the buffer, which means that we have to
re-set the buffer type in the bli after joining the buffer to the new
transaction so that log recovery will know what to do if the fs fails.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---

Notice how after the Subject: there is a blank line (which terminates
the headers) followed by a new From: line in the body?  And the
name/email in that second From: line matches the SOB later on?

--D

> 
> Thanks,
> Stephen.
