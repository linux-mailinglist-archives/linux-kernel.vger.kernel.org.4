Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D773A6494F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 16:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLKPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 10:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiLKPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 10:46:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1A61102
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9QKo1fRDCXnqxb5YHNlVFkmytvoQhmj++ird4MfpVzA=; b=MFHevEUX+zsZRnwYuu75O/nPgT
        MGF0hjNGjzaspO1mYJwSp6QHwMd+IPbR8yJcKAy+TzC3DsOWn9Cc325r0gFOonx+RZ/wuX+Stq0Bq
        3ENeLEFmdcoqR1E/ZytUOlMWV4TeNPqAkxgc6cs3ErCW4G9uz+daMJaHvrmv2ciBR32YBPNcVUf7M
        1USW2NxOggF1kl+UwHgTFG0FRR6ZQEWbqvf69mf4LXdwIvXM6ZHti9uB+TfUFn9y9xHAIyytkhHx/
        yG/oH4CydNWLwN3uMlHomy1uM2U3dzCYblWmbQ/LHonQA6EO39AY9ZWpGtIkDdYdU9rYDVNZJu8YW
        8lc7Y2xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4OWq-00A6yY-9u; Sun, 11 Dec 2022 15:46:12 +0000
Date:   Sun, 11 Dec 2022 15:46:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y5X7RBznTD6rPfro@casper.infradead.org>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211102208.2600-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 06:22:08PM +0800, Hillf Danton wrote:
> On 11 Dec 2022 08:39:18 +0000 Al Viro <viro@zeniv.linux.org.uk>
> > On Sun, Dec 11, 2022 at 03:56:12PM +0800, Hillf Danton wrote:
> > > On 11 Dec 2022 02:52:57 +0000 Al Viro <viro@zeniv.linux.org.uk>
> > > > On Sat, Dec 10, 2022 at 06:30:22PM -0800, syzbot wrote:
> > > > > Hello,
> > > > > 
> > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > WARNING in done_path_create
> > > > 
> > > > How many times does it need to be repeated that ANY BUG REPORTS INVOLVING NTFS3 IN
> > > > REPRODUCER NEED TO BE CCED TO MAINTAINERS OF NTFS3?
> > > > 
> > > > I'm done with any syzbot output.  From now on it's getting triaged
> > > > straight to /dev/null here.
> > > 
> > > Calm downnnnnn Sir even if this is not the east ender style.
> > > 
> > > Frankly no interest here at all wasting any network bandwidth just to get you
> > > interrupted if it would take less than 72 hours to discover one of the beatles
> > > you created. And actually more than double check is needed to ensure who
> > > did that.
> > 
> > 	The first iterations of the same suggestion had been a lot calmer...
> > One of the earlier examples: https://lore.kernel.org/all/YzEJ2D8kga+ZRDZx@ZenIV/
> > And I distinctly remember similar attempts from other folks.
> > 
> > 	It's really a matter of triage; as it is, syzkaller folks are
> > expecting that any mail from the bot will be looked into by everyone
> > on fsdevel, on the off-chance that it's relevant for them.  What's
> 
> FILESYSTEMS (VFS and infrastructure)
> M:	Alexander Viro <viro@zeniv.linux.org.uk>
> L:	linux-fsdevel@vger.kernel.org
> S:	Maintained
> F:	fs/*
> F:	include/linux/fs.h
> F:	include/linux/fs_types.h
> F:	include/uapi/linux/fs.h
> F:	include/uapi/linux/openat2.h
> 
>  _> ls fs/* | grep ntfs
> fs/ntfs:
> ntfs.h
> fs/ntfs3:
> fsntfs.c
> ntfs.h
> ntfs_fs.h
> 
> Why not change what you really want to cover instead of complaining once more
> and opting to triage?

You've completely misunderstood Al's point.  He's not whining about
being cc'd, he's pointing at this is ONLY USEFUL IF THE NTFS3
MAINTAINERS ARE CC'd.  And they're not.  So this is just noise.
And enough noise means that signal is lost.

> > more, it's not just "read the mail" - information in the mail body
> > is next to useless in such situations.  So you are asking to
> > 	* start a browser
> > 	* cut'n'paste the URL from MUA
> > 	* dig around in the files linked to the damn thing
> > ... all of that for an fs maintainer to see if his filesystem is
> > even present?  Seriously?  For each syzbot fsdevel posting?
> > 
> > 	I would have looked at it anyway; granted, seeing ntfs3 I'd chalked
> > it up to ntfs bugs (fs/ntfs3 has not been there for long and it didn't get
> > outright memory corruptors beaten out of it yet).
> > 
> > 	But how the bleeding hell are ntfs folks supposed to guess that
> > this report might be relevant for them?  Same for XFS, ext4, orangefs,
> > et sodding cetera - and for most of those any of such reports would've
> > ended up wasted time for the good and simple reasons that it's not
> > any fs they'd been involved with.
> > 
> > 	What really pisses me off is that on the sending side the
> > required check is trivial - if you are going to fuzz a filesystem,
> > put a note into report, preferably in subject.  Sure, it's your
> > code, you get to decide what to spend your time upon (you == syzkaller
> > maintainers).  But please keep in mind that for recepients it's
> > a lot of recurring work, worthless for the majority of those who
> > end up bothering with it.  Every time they receive a mail from
> > that source.
> > 
> > 	Ignore polite suggestions enough times, earn a mix of
> > impolite ones and .procmailrc recipes, it's that simple...
> > 
> 
