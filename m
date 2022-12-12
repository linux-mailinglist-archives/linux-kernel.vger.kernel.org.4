Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE764A7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiLLTCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiLLTBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:01:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD018373
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:59:24 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BCIwpBh024656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 13:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670871534; bh=F8ImDoefZwZ9S60YIJxy6ALD/a+wGWb8H87kNMzMNro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RU/hBCfP6sacodzCTvTKXmkuTkSpPysq839v4HOO2Tby6EfYjg0ekmcS3+Ki0Hapy
         1A2WUBa+ut+WoiGfKhaQy6wAdwmoyIRKatwQVkZlajaKnklYYMuNAVOSmxL0ywe258
         v+VtEFBaL/u2V4DJ75bUIHWfAAvCIAaYhGZkUI+E+7OuYaHOUvT/thAIpU6MJKImte
         yMUYMwiRfhl0hzBf7E6tJOiSWPQQ15rNU/VsOgqQzzzeX2iGIG+Es9OLVIjQnyT0Bw
         +4fLTbDfJ/Ij/274kBMNdH/jNPpeTUGPdVCGC8tfllRz6bZh28x2BM66+hgcH2PMzH
         /BTwrMTKxpKvA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BD8C415C34C5; Mon, 12 Dec 2022 13:58:51 -0500 (EST)
Date:   Mon, 12 Dec 2022 13:58:51 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y5d565XVsinbNNL2@mit.edu>
References: <20221211002908.2210-1-hdanton@sina.com>
 <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com>
 <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212032911.2965-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:29:11AM +0800, Hillf Danton wrote:
> > You've completely misunderstood Al's point.  He's not whining about
> > being cc'd, he's pointing at this is ONLY USEFUL IF THE NTFS3
> > MAINTAINERS ARE CC'd.  And they're not.  So this is just noise.
> > And enough noise means that signal is lost.
> 
> Call Trace:
>  <TASK>
>  inode_unlock include/linux/fs.h:761 [inline]
>  done_path_create fs/namei.c:3857 [inline]
>  do_mkdirat+0x2de/0x550 fs/namei.c:4064
>  __do_sys_mkdirat fs/namei.c:4076 [inline]
>  __se_sys_mkdirat fs/namei.c:4074 [inline]
>  __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4074
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Given the call trace above, how do you know the ntfs3 guys should be also
> Cced in addition to AV? What if it would take more than three months for
> syzbot to learn the skills in your mind? What is preventing you routing
> the report to ntfs3?

If it takes 3 months for syzbot to take a look at the source code in
their own #!@?! reproducer, or just to take a look at the strace link
in the dashboard:

[pid  3639] mount("/dev/loop0", "./file2", "ntfs3", MS_NOSUID|MS_NOEXEC|MS_DIRSYNC|MS_I_VERSION, "") = 0

There's something really wrong.  The point Al has been making (and
I've been making for multiple years) is that Syzbot has the
information, but unfortunately, at the moment, it is only analyzing
the the stack trace, and it is not doing things that really could be
done automatically --- and cloud VM time is cheap, and upstream
maintainer time is expensive.  So by not improving syzbot in a way
that really shouldn't be all that difficult, the syzbot maintainers is
disrespectiving the time of the upstream maintainers.

So sure, we could ask Linus to triage all syzbot reports --- or we
could ask Al to triage all syzbot file system reports --- but that is
not a good use of upstream resources.

And "we didn't know this is super annoying" isn't an excuse, because
I've been asking for things like this *before* the COVID pandemic.  So
if the Syzbot team won't listen to observations by a random Google
engineer who happens to be an ext4 maintainer (or rather, I'm sure
they were listening, but they didn't consider it important enough to
staff and put on the roadmap), maybe something a bit
more.... assertive by Al is something that will inspire them to
prioritize this feature request "above the fold".  :-)

And Al does have a point --- if a lot of upstream maintainers consider
Syzbot reports to be less than useful, they will either auto-file
reports to a junk folder, or just ignore the Syzbot reports because
they are busy and the Probability(Usefulness) is close to zero, then
recovering from that black eye to Syzbot's reputation is going to be a
lot more difficult than if Syzbot was made more respectful of upstream
maintainer time much earlier.

Now, to be fair to the Syzbot team, the Syzbot console has gotten much
better.  You can now download the syzbot trace, and download the
mounted file system, when before, you had to do a lot more work to
extract the file system (which is stored in separate constant C
array's as compressed data) from the C reproducer.  So have things
have gotten better.

But at the same time, characterizing a syzbot report is something to
be done by every file system maintainer who looks as a syzbot report,
because there is no way to add a tag to the syzbot report that this
particular syzbot report *really* is an ntfs3 issue.  So any
information that a single developer figures out when triaging a bug
(is this potentially an ext4 bug, nope, it's an ntfs3 bug) has to be
replicated by every single kernel developer looking at the Syzbot
dashboard.  Which again, is not respectful of upstream maintainers'
time.

						- Ted
