Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985FE5F9A55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiJJHqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJJHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD551A05C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26EC160E08
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851FCC433C1;
        Mon, 10 Oct 2022 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665387766;
        bh=cZreQPbofZvG+IqZESfiuKht27lFd+bJfDigZhbPu6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5IaZb2lTSQXjOAR6RXogzfOQe6bJqkxWYAEVeQjSe4cYuGNIMP2J4k+hm4Ocun9R
         Isse1QxoPv+vs+xirEL4wqBFEwee96Tt1YapZVequNomIfGsdMOlUUFQjm0atkeGVp
         t5eC1rNtHfLPvJBKVBwUH4Frs02KYone0gu86jT72CsK6jM3QClUxWw9h+wVzcMT8S
         4Pe3hGl/u0HHF1iSoID9WHivB12MbmW3oapXCCHscZ9ED6X8SUh04tJaOSxnhh7rqp
         T9oe4xUIYUQsuHk+GD9Kt/mii6wOZuXOMvaa5E86aLZjoqmr8tq/PEASUfld4YUonZ
         qs3A//JIgGgSA==
Date:   Mon, 10 Oct 2022 08:42:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Backlight for v6.1
Message-ID: <Y0PM8fGW+8rxNlwU@google.com>
References: <Yz18QA27+gN0oaM3@google.com>
 <CAHk-=whK-q1W-X0q0f_nBJ9sKyta-DVJhEAS4BF_oKAVAUQ4Jw@mail.gmail.com>
 <Y0AmmR2NfKc/Y7Mb@google.com>
 <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg=hh8xkPjiySnjAyR66AG64eyZ1Y9gHw+MCs8uuSZReA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Oct 2022, Linus Torvalds wrote:

> On Fri, Oct 7, 2022 at 6:16 AM Lee Jones <lee@kernel.org> wrote:
> >
> > PR satisfying this dependency was submitted the following day:
> 
> .. you ignored the whole "another driver hit v6.0 without ever getting
> the dependency".

Not ignored.  I provided you with a response applicable to the
situation surrounding *this* pull-request.  As for the actions /
motives of other maintainers, I cannot / should not comment.

Admittedly, that is not to say this could not have happened solely
between 2 subsystems that I maintain!  The other subsystem maintainers
and I work together regularly, utilising immutable branches to ensure
we do not cause build breakage at merge-time, but we (clearly) do not
work to the same levels of due diligence with respect to dependencies
preventing full build test / coverage.

> In particular, there was a silent semantic conflict in the Crystal
> Cove (intel PMIC) driver with the i2c changes. I noticed it because
> there were other things going on, and I went and looked.

It appears as though, Andy, Hans and yourself are having a nice
conversation about this particular instance already - I'll leave you
to it.

> So I caught this particular issue, but I really think that code that
> cannot be enabled at all even for build testing - or code that is
> quite hard to enable either intentionally or by mistake - is a
> problem.

Unbuildable / untestable code is an interesting problem.  One which, I
must say, I haven't taken a particularly deep look into.  Even though 
MFDs (and their associated children) are particularly susceptible to
dependency issues that would otherwise prevent testing, I very much
doubt this problem is unique to MFD.

To your knowledge, has there been any research into unbuildable
drivers (/ subsystems!)?  There must have been some notable studies on
(static / running) code coverage analysis, but I'd be surprised if
these cover code that simply cannot be built / executed.

Until this point, I assumed my build-coverage was rather good.  It
covers varying compilers, 7 architectures, and many different
*_defconfigs which include allmodconfig and allyesconfig, totalling 70
unique kernel builds.

You have been mentioning allmodconfig a fair bit.  Are you also
including allyesconfig in your observations?  Does that not alleviate 
some of the angst around what should be built-in vs modules in terms
of buildability?

If this is as big of an issue as you say, perhaps we should invest
a little time to investigate some sound method(s) to scan for similar
instances.  Tricky to do, seeing how many different architectures /
platforms the kernel supports.

-- 
Lee Jones [李琼斯]
