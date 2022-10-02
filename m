Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC97A5F2308
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJBMSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJBMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:18:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9072FC29;
        Sun,  2 Oct 2022 05:18:46 -0700 (PDT)
Received: from letrec.thunk.org ([50.224.35.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 292CIMkg004134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Oct 2022 08:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664713105; bh=xm8/ovDerx/0Wto/6gkA+29zQ8plVt/TZLt1P8cBNkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EbQCJMkPhVfpzLIQ4CWwfMH5rakqnaxcrWZYUmRwNSVbpzNRhct1sIGykD5S4A7Ci
         vg3NFWbochckUpJLNLb4Lzo4QvbcTzav/qDgW3MqA7QyqFNhcuJNnMBog4rtqaawqi
         BFgYzLdyT43WNYLHzSn1XXeyxDCus1Gkrzp7Wi7ZIb+H/y3JyMupHMAOSNyZ302PFv
         1RoHJKCvbMkxFIFu45Tlb/ZcQRP6vQL1eI/9qzkfrvM3rkhVYLiSLVNwTOE+oaH1jc
         NOAKOYYHi3MJz41BmNKs7kmTsNh8nILZvk9x8F9dHJenjQ4O1Y8m+Twcd6scyHyxvc
         JIuzkSIUZD0PA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 89CDE8C2AAD; Sun,  2 Oct 2022 08:18:22 -0400 (EDT)
Date:   Sun, 2 Oct 2022 08:18:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <YzmBjgXq9geMnL1B@mit.edu>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com>
 <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info>
 <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info>
 <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 02:58:04PM +0000, Artem S. Tashkinov wrote:
> 
> My expectations are actually quite low:
> 
> * A central place to collect bugs (yeah, bugzilla)
> * Proper up to date components (they don't change too often, so there's
> not a lot of work to be done - you can refresh them probably every 12-24
> months and it's gonna be totally OK)
> * An ability to CC the relevant people/mailing lists (this is the only
> serious missing feature)
> 
> That's it. It's a billion times better than random emails sent to random
> mailing lists. Signing up once is easier that to keep track of whom and
> where you've emailed or not. And of course it's a ton lot easier to find
> the existing bug reports.

First of all, some of the components do CC the relevant mailing lists
automatically.  And this is the part of Bugzilla which is hand-hacked
and has no, zero, nada support upstream.  I'll defer to Konstantin
about how easy it is to keep that working.

Secondly, not everyone is happy with getting an e-mail message sent to
a mailing list that has a lot of bugzilla metadata associated with it,
and depending on how they respond, the response might not make it back
to bugzilla.

Finally, in the absense of someone to actually close bugzilla entries
and do other necessary grooming, the bugzilla database will rapidly
become useless --- in which case, you might as well have a web form
that just helps the user send e-mail to the mailing list, and hope it
doesn't become a SPAM magnet.

> Bugzilla as it is works nearly perfectly. We have a number of developers
> who don't want to touch it or get emails from it - it's their right.
> However it would be madness to take it from users. That will make filing
> and following up on bug reports an absolutely poor experience for
> absolute most users.

At the moment, developers aren't following up on the bug reports.
There is some debate as to why.  Is it because users who can't figure
out how to send e-mail, and who send web-form based e-mails send low
quality bug reports that can't be easily responded to unless someone
is paid $$$ and/or has the patience of a saint?  Is it because
components aren't being gatewayed to mailing lists?

And if we force developers to get Bugzilla spam whether they want it
not, and they said, "absolutely not", is it there right to have the
mailing list gateway disabled --- and if so, what does that do to the
user experience?  Thats basically the situation we have right now.

     		  		      - Ted
