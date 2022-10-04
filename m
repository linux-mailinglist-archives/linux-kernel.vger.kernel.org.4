Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE185F4708
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJDP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJDP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:57:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A06846600;
        Tue,  4 Oct 2022 08:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1DF9B81AD5;
        Tue,  4 Oct 2022 15:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A6CC433D6;
        Tue,  4 Oct 2022 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664899054;
        bh=11sJidorOVDP2DRslyNXc9Oiqpq0bLQvUTJNvjTO8zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu2LOiDAg22hM0x6WLSwpsRciu6lyv3U+JTxrccSnQMhkjl0VNP2pfONS78eJmk6m
         Xt/6V0duEMVbuEnv8CF3ikV75XIJMA2Stvsz9wQ0Fu3IM9C42aR4loatr9OAgR8IWD
         EDEyNJQkcbqDES+b15ZIMw8Q8Y016z41tWJUr90dsZ8bHPNAlTGX5LZIk6KHD3UGa3
         CzaYHsr3kkeVw4FzM165IC/kfoNw7Rlnkqoghn6jzkavCCQThUzQk//ZcJjehTS7Ee
         OsV2XxFdLWG2WJCx+h8jKKt7jaYYeicsEvuEtYsCtU8U4gn9gS6EbbfOt//lwzzV5G
         cAglWDl8Ia/Dg==
Date:   Tue, 4 Oct 2022 08:57:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        Stephen Zhang <starzhangzsd@gmail.com>,
        Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <YzxX7ks+YD7U1dcl@magnolia>
References: <20221004072302.345bfd4a@canb.auug.org.au>
 <20221003222103.GM3600936@dread.disaster.area>
 <20221004225012.501e11ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004225012.501e11ed@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:50:12PM +1100, Stephen Rothwell wrote:
> Hi Dave,
> 
> On Tue, 4 Oct 2022 09:21:03 +1100 Dave Chinner <david@fromorbit.com> wrote:
> >
> > The commit matches exactly what was sent to the list. It's just
> > that the patch was sent from a personal email address with a
> > corporate signoff.
> > 
> > Since when has that been an issue?  I -personally- have been doing
> > this for well over a decade and I'm pretty sure there are lots of
> > other people who also do this.
> 
> If you are happy (as the maintainer), then fine.  My script just could
> not connect those 2 email addresses.  I check for matches between the
> address itself (the part between the <>) or a match between the "name"
> part (before the <>).  If either matches (or it is obvious) then I
> don't report it.
> 
> I have reported very few of these.

My checkpatch is happier if the whole "name <email>" string matches, but
it'll accept name matches.  This ofc rests upon the assumption that
I can spot the deepcake'd Dave Chinners hawking phones in Russia or
whatever. ;)

That said... I think we should get in the habit of asking patch authors
to make sure that at least one of the email or name strings match
between the From and SOB tags.  I can see how people who grok even less
about how Chinese names work than I do (read: lawyers) might get fussy
about this kind of thing.

--D

> > Hence if this is wrong, then we've got a tooling problem with b4.
> > Why does b4 allow this rather than warn/fail if it's not actually
> > allowed in the linux-next tree?
> 
> These reports are more of "is this right/was this a slipup?" rather
> than "this is not allowed" i.e.. there are circumstances under which
> the actual author does not (or cannot) provide a Signed-off-by and that
> is OK.
> -- 
> Cheers,
> Stephen Rothwell


