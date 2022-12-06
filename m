Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF5643CDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 06:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbiLFFyi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Dec 2022 00:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiLFFyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 00:54:20 -0500
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B653275C1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 21:54:16 -0800 (PST)
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id DCDACC09FE;
        Tue,  6 Dec 2022 05:54:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id DEEBF18;
        Tue,  6 Dec 2022 05:54:13 +0000 (UTC)
Message-ID: <23a61dd072ee1d2cc5b54281b0a9dc13e01aa0b8.camel@perches.com>
Subject: Re: Fw: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn
 about missing Link:
From:   Joe Perches <joe@perches.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kai =?ISO-8859-1?Q?Wasserb=E4ch?= <kai@dev.carbon-project.org>
Date:   Mon, 05 Dec 2022 21:54:13 -0800
In-Reply-To: <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
References: <20221205131424.36909375d90d5a40cd028bc0@linux-foundation.org>
         <11a9fe60f5333a931b8d75f67808b6d923c16dfa.camel@perches.com>
         <25f4838b-208a-cf8c-914c-b2092665d56f@leemhuis.info>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: DEEBF18
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Stat-Signature: mjsx31x6rtq6pujqnyhaqkf4yee5oiag
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19rKO3gGkxEMRatNNSkA9mA1lYurhuvi8g=
X-HE-Tag: 1670306053-807855
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-12-06 at 05:55 +0100, Thorsten Leemhuis wrote:
> Hi Joe! Many thx for looking into this.
> 
> On 06.12.22 02:02, Joe Perches wrote:
> > On Mon, 2022-12-05 at 13:14 -0800, Andrew Morton wrote:
> > > Begin forwarded message:
> > > 
> > > Date: Sun,  4 Dec 2022 12:33:37 +0100
> > > From: Kai Wasserbäch <kai@dev.carbon-project.org>
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Andrew Morton <akpm@linux-foundation.org>, Thorsten Leemhuis <linux@leemhuis.info>
> > > Subject: [PATCH 0/2] feat: checkpatch: prohibit Buglink: and warn about missing Link:
> > > 
> > > Thorsten Leemhuis suggested the following two changes to checkpatch, which
> > > I hereby humbly submit for review. Please let me know if any changes
> > > would be required for acceptance.
> > [...]
> > > Suggested-by: Thorsten Leemhuis <linux@leemhuis.info>
> > > Signed-off-by: Kai Wasserbäch <kai@dev.carbon-project.org>
> > > 
> > > Kai Wasserbäch (2):
> > >   feat: checkpatch: error on usage of a Buglink tag in the commit log
> > 
> > Why, what's wrong with a buglink reference?
> 
> Long story short: Linus doesn't like it:
> 
> ```
> > > BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
> > > BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com
> > [...]
> > please stop making up random tags that make no sense.
> > 
> > Just use "Link:"
> > [...]
> > 
> > It's extra context to the commit, in case somebody wants to know the
> > history. The "bug" part is (and always should be) already explained in
> > the commit message, there's absolutely no point in adding soem extra
> > noise to the "Link:" tag.>
> ```
> That's a quote from
> https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
> 
> In that message he also links to another mail from him, where he wrote:
> ```
> > I think "BugLink:" is silly, because that's just a regular link.
> > What's the upside of saying "Bug" in there? If you're fixing a bug,
> > and are linking to reports and discussions by people, what does that
> > "bug" buy you apart from another ugly CamelCase thing?
> > 
> > In other words, in "BugLink:", neither "Bug" nor "Link" is actually meaningful.
> > 
> > The current "Link:" tag exists AS A GENERIC WAY TO SAY "look, here's
> > more information". That's the point. The word "Link" has no other
> > meaning, and trying to then combine it with other things is worthless.
> ```
> https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/
> 
> Our docs say to use Link in this case, too; see
> Documentation/process/submitting-patches.rst
> (http://docs.kernel.org/process/submitting-patches.html) and
> Documentation/process/5.Posting.rst
> (https://docs.kernel.org/process/5.Posting.html)
> 
> And using various tags for the same thing makes it also harder for
> external scripts that look at commits to take further action -- like the
> regression tracking bot I write and use for my work.
> 
> All of that obviously should have been in patch description. Let me
> resubmit that patch with all of that in there, or are you dead against
> this idea now?

No, better commit description would be useful and perhaps a more
generic, "is the thing in front of a URI/URL" a known/supported entry,
instead of using an known invalid test would be a better mechanism.

> > >   feat: checkpatch: Warn about Reported-by: not being followed by a
> > >     Link:
> > 
> > I think this is unnecessary.
> 
> I expect this to cause more discussion, which is why this should be in a
> separate submission. But in the end the reasons are similar as above:
> (1) Linus really want to see those links to make things easier for
> future code archeologists. (2) My regression tracking efforts heavily
> rely on those Links, as they allow to automatically connect reports with
> patches and commits to fix the reported regression; without those the
> tracking is a PITA and doesn't scale.
> 
> Together that IMHO is strong enough reason to warn in this case.

Maybe, I think there might be some value in not intermixing signature
tags and other tags though.

