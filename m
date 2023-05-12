Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27A9700B28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbjELPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjELPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:16:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778EA5BA5;
        Fri, 12 May 2023 08:16:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 95F223200907;
        Fri, 12 May 2023 11:16:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 May 2023 11:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683904599; x=1683990999; bh=xt
        kb0nJV/iS7JIfrwakr/gfmwjRljCPV+qLudxkRwvA=; b=sBX9ErKRfkz9Ul1g96
        LV+tKo1DkSmM49i8E+NsCfLc9uZA1ibWE5qlYXjZUkoLkc4f+KAO52Y3jpCeB6hr
        xzS3uPmQFCcRSevNIP29Yf+84wW/iwjpLQy6TY/ZlSGuJmFIY/xnMO3SQFTaQpJF
        FormSQyKFuvnB10Po/Z4bduNspwBs7f7pAipK6q6zHcnopoRJ5wGNrDC4g75ZM2l
        skaUdemsMa+iiAxNYS5byhFL69rMFy+UzpNaiRDLkKQGRu86DTUJyif6FxcOnuvC
        9Opx1QNWICUcBkmvT12ndteLx3Czy9LX4VIqt11/eUpK02J9+462hbFgL3EBgDJs
        PXjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683904599; x=1683990999; bh=xtkb0nJV/iS7J
        Ifrwakr/gfmwjRljCPV+qLudxkRwvA=; b=WdXbKy6BLe1bFynIaA8GGQIwotTaw
        pbWzDihwlD9aVcvLcNQKkInousioevCf1ybERYVHQ2f5WWEAdwRpE0MG3p4JpoiP
        e29Z+2UL9V88UTVGIqoNrDBBJNJEshG2wSPZhVOxoj9E7wOvY4wV95HYY+wnk0iF
        QX351PyYZMkDaK3ISmGW9e41bV9QuxG9fKby3kHhewOs5lO1aib2JnL5+wL4ksMH
        tRVBzwne97msGrMT2TeTuOzpfBhcngoq2ThPjkgSe0iUEAXBOF8nrJ+rkq2wbyZ7
        NOgweavZ3ztN2iN52qwUSnKlvs5i74JoWy+3+oQGfJJ4n1uQ+J+h4TI4A==
X-ME-Sender: <xms:V1heZJQTmJMC2hbul4vj_bXa3rgxi_TjROX8wv3RjQTpEczvKZGTuw>
    <xme:V1heZCxqvSVdosCWMx4BDEmkypoeh8xl49W-z-Ub7mD-ARgy-vrlD-J-z_GFUAuqO
    -Up26qsWatcrXIUG7o>
X-ME-Received: <xmr:V1heZO0U-j4aGTBrvRyZ_b9xHVuRtrLP6IKoc8jNxOAIFAZ-_97FAwyK--LyYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehtddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhepueettdetgfejfeffheffffekjeeuveeifeduleegjedutdefffetkeel
    hfelleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:V1heZBBDp5QkShqK-1eVcHzI7XVr5qhXQtrbZl7N_KWmektV5wjT9A>
    <xmx:V1heZCiye4CUpRCFSX9NzvOLoCn-8Q-atAZdbArAGRWCrRF7vgNzpQ>
    <xmx:V1heZFpngUQJ44J_RX25Jd8VoRTqS-awPIHUlK35Jo3rCbg9WVvT0g>
    <xmx:V1heZKcAuYI1ENaGrW4njRQzj6JoYiTqWi3FnsfNjI_YO2L7_xnH9w>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 11:16:37 -0400 (EDT)
Date:   Fri, 12 May 2023 09:16:36 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] xfs: don't do inodgc work if task is exiting
Message-ID: <ZF5YVNdeVNSoG08p@tycho.pizza>
References: <20230511151702.14704-1-tycho@tycho.pizza>
 <20230512014547.GA3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512014547.GA3223426@dread.disaster.area>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:45:47AM +1000, Dave Chinner wrote:
> 
> Yeah, this is papering over the observed symptom, not addressing the
> root cause of the inodegc flush delay. What do you see when you run
> sysrq-w and sysrq-l? Are there inodegc worker threads blocked
> performing inodegc?

I will try this next time we encounter this.

> e.g. inodegc flushes could simply be delayed by an unlinked inode
> being processed that has millions of extents that need to be freed.
> 
> In reality, inode reclaim can block for long periods of time
> on any filesystem, so the concept of "inode reclaim should
> not block when PF_EXITING" is not a behaviour that we guarantee
> anywhere or could guarantee across the board.
> 
> Let's get to the bottom of why inodegc has apparently stalled before
> trying to work out how to fix it...

I'm happy to try, but I think it is also worth applying this patch.
Like I said in the other thread, having to evac a box to get rid of an
unkillable userspace process is annoying.

Thanks for the debugging tips.

Tycho
