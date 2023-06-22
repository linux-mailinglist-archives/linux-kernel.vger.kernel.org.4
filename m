Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5A73A764
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjFVRjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFVRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:39:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6081BD6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:39:30 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-196.bstnma.fios.verizon.net [173.48.111.196])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35MHdDCG014082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 13:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687455556; bh=8LMsnDg3PnnvGhnL9RsuzWWRCWQ2nXEzpByDEPyMuRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Lp7Qc9l30GMXKzSLw65ja4VPIrZaI6rpa3r6zvlflf2HKZH14LQ6iuOP9mpY0tajo
         Uk8AEk26JYLOO7Rs16O5R+s8XrBfvhdWKbhJWxV2hzse/3BZYfe7umN/W2mK8dIB++
         QdsCP5+8FolEY/tLNy365kwxrS6I/jz+K/kTPmxuJCjUIo659IByzO1wdSluOCmniq
         8KSnYJdE22j7J1b528y/IqFHLMwCt6N5xY5+ag4BMSBxBNFxvWr7yzIwDByitnMsHd
         /Kzv0fJTul8ur7sxcZR9a1zUfN5uvAwVijmLQfS07ORkiW5cuCTKKrhCGnhHjmAKwL
         nCG+BFv/PvE0Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6763B15C027E; Thu, 22 Jun 2023 13:39:13 -0400 (EDT)
Date:   Thu, 22 Jun 2023 13:39:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and the
 wider community
Message-ID: <20230622173913.GA34229@mit.edu>
References: <20230620212502.GI286961@mit.edu>
 <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org>
 <2023062144-hefty-why-305d@gregkh>
 <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:02:10PM +1000, Finn Thain wrote:
> 
> You mentioned wasted resources. If you want to generate e-waste, remove 
> drivers from the kernel. If you want to prevent e-waste, add drivers for 
> obsolete hardware and then watch the user count climb from zero as devices 
> get pulled from drawers and dusted off.

You seem to making a lot of assumptions here, with no evidence to back
up your assertions.  The driver question is from twenty years ago, and
talks to SCSI cards using LVD (low-voltage diferential) SCSI 3 cables
(for 160 MB/s).  SCSI Disks from that era are typically 20GB to 30GB.
Compare that to modern SATA disks today that are 10-18 TB in size, and
SATA-3 transfers data at 600 MB/s.

So you are assuming (a) that people just "happen" to have ancient, 20
year old cards justlying around in drawers, (b) they have 20 year old
SCSI disks and SCSI cables that these cards would actually talk to,
and (c) they would think it would make sense from a power, space, and
cooling perspective to take this kind of antique storage solutions are
use it for actually storing data.

> Anyway, your reaction is an interesting example of strong feelings in the 
> community as to how contributed code should or should not be used. E.g. 
> some get upset if their code runs on weapons systems, others get upset if 
> the latest release might not run on suitable hardware in the immediate 
> future. Some add or remove licence terms according to their convictions.

Um, I don't even know where this came from.  In any case, the Linux
Kernel is licensed under the GPL2, which, like all Open Source
compliant licenses, does not distribute against fields of endeavor
(such as weapons systems, etc.)

As far as getting upset if the latest release doesn't run on "suitable
hardware", if they are upset they can submit a bug report, or better
yet, submit a patch to address the situation.  What people seem to
forget is that free software does not mean that people will fix your
software for your use case for free.  It means that *you* are free to
fix the software, or to pay someone to fix the software in question.

> If there was consensus, it might be feasible to give a formula for 
> "recognized usage" which could be quantified. From there we could create a 
> kind of heat map to show which commits, maintainers, processes, models, 
> modules etc. were the most "useful" within some time interval.

The best we have is we can see what users submit bug reports about
(especially, for example, when we discover that some driver was
accidentally broken a few years ago due to the need to upgrade code to
use newer API's as we improve and refactor code, and no one has
complained about the driver being used --- that's a good hint that no
one cares), and what individuals and companies choose to spend time
working to improve certain parts of the kernel.  If code is under
active maintenance, then it's worth *someone's* time to keep
maintained.

And of course, if remove a driver because it is unmaintained and is
for obsolete hardware, if someone shows up saying (a) they care about
that driver, and (b) they are willing to volunteer to maintain the
driver, or are willing to pay someone to maintain the driver, and they
have contracted with XYZ developer working for ABC company, then it's
super simple to revert the driver removal.  It is, after all, only a
"git revert" away.

I do have to concur with Greg that relying on this as way to get new
people to be work on Linux kernel is a *terrible* idea.  The number of
people who are interested in retro-computing is quite small, in my
experience.

Cheers,

					- Ted

