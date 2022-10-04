Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13405F4AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJDVEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJDVEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:04:04 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6F2965270;
        Tue,  4 Oct 2022 14:04:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 6EB2C8AC3BA;
        Wed,  5 Oct 2022 08:04:01 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ofp56-00FfvW-2h; Wed, 05 Oct 2022 08:04:00 +1100
Date:   Wed, 5 Oct 2022 08:04:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, linux-xfs@vger.kernel.org,
        Stephen Zhang <starzhangzsd@gmail.com>,
        Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <20221004210400.GO3600936@dread.disaster.area>
References: <20221004072302.345bfd4a@canb.auug.org.au>
 <20221003222103.GM3600936@dread.disaster.area>
 <20221004225012.501e11ed@canb.auug.org.au>
 <YzxX7ks+YD7U1dcl@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzxX7ks+YD7U1dcl@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=633c9fc2
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=Qawa6l4ZSaYA:10 a=7-415B0cAAAA:8
        a=dO8VshlyLlrOEYzubo8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:57:34AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 04, 2022 at 10:50:12PM +1100, Stephen Rothwell wrote:
> > Hi Dave,
> > 
> > On Tue, 4 Oct 2022 09:21:03 +1100 Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > The commit matches exactly what was sent to the list. It's just
> > > that the patch was sent from a personal email address with a
> > > corporate signoff.
> > > 
> > > Since when has that been an issue?  I -personally- have been doing
> > > this for well over a decade and I'm pretty sure there are lots of
> > > other people who also do this.
> > 
> > If you are happy (as the maintainer), then fine.

Not really, I don't like it when our tools don't do the right thing,
are entirely silent about it and then I get surprised by custom
checks other people run.

> > My script just could
> > not connect those 2 email addresses.  I check for matches between the
> > address itself (the part between the <>) or a match between the "name"
> > part (before the <>).  If either matches (or it is obvious) then I
> > don't report it.

Yup, during development of the patches the names started out
matching. The SOB stayed the same but the name on the personal email
address got anglicised, hence nothing matched by the time I pulled
it with b4.

> > I have reported very few of these.
> 
> My checkpatch is happier if the whole "name <email>" string matches, but
> it'll accept name matches.  This ofc rests upon the assumption that
> I can spot the deepcake'd Dave Chinners hawking phones in Russia or
> whatever. ;)

If someone wants to fake me and do my work for me so I don't have to
do anything, I'm all for it. :)

As it is, I use the convention of putting an explicit From: tag in
the commit message that matches the SOB so tools pulling stuff from
mailing lists do the right thing with them (same as any third-party
provided patch in a series). 

> That said... I think we should get in the habit of asking patch authors
> to make sure that at least one of the email or name strings match
> between the From and SOB tags.  I can see how people who grok even less
> about how Chinese names work than I do (read: lawyers) might get fussy
> about this kind of thing.

As per above, the normal solution is an explicit "From: <foo>" line
that matches the SOB.  It's just annoying that our new-fangled tools
haven't encoded this long-standing convention to warn us when we
pull a patch with a from-tag that doesn't match a sob-tag.

And, yes, I know about git hooks - forcing every maintainer to
implement their own custom git hooks to catch errors the tool they
are all using can easily catch is not a reliable or scalable
solution. We use common tools for a reason.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
