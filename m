Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814A164A81E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiLLT3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiLLT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:29:48 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C96362
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:29:47 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id e141so14962482ybh.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LiVT748OxRXpzCifqoj8IWto4LyoPoQy563IYc6Z3N8=;
        b=Gl0PBS6+NcmiNtDFS7m2kIDHC+fMYTm2E1ue9F5esGqa09T6K6dVt8KUnbzRAQYatu
         TdTNx9kuwFTXf72vocw0TK7HjdmRWxe5EnyMsQKozBNqpWCDWX9Sg3KFAceFlFOlTeVf
         KAf4ZwV3jPwF4qAKTL5jto9PUaNBSMoIRrUnBXfIgFV1TukTJkc2GNyYs0jAl4R82nhF
         QfpTO0olr8vh/95ZB16xYRPDWAqB+CNS4F5Ro412byIyea7ROJZfIDG1E7QjdhLlRpXb
         QNQ4m4v2f49NL77CsDpglXI0aJBKLP8nbnNyGEHYE0fbBDzeJeHhnEkqf1uu3eP4XRgq
         S/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiVT748OxRXpzCifqoj8IWto4LyoPoQy563IYc6Z3N8=;
        b=t8IxzMzbL/4NgOFEmW+GWUY/CDNoFRcV0SEpPBH3ipr4ZkmLDILwEHs//WZFEYQ8D5
         yF237s1rXPFFWTM3wDcYT2HJh60/OKjyHuM+UTPmeg8HemAskZH3679a0fg2l6bmi+rf
         McRYXlC9phDyJl0fQ8BUJ9BNxU6Vj+KPYs5E8tUzYFJFClzd+H28LSi0YDqe876l9E5f
         g+pAsJerdWhAOrsFEWv7/9TKPosZnQWFE4nmh3tk9s3ViUDLbrWusc6tCPAzlBvgWV2J
         vJc1kFLMGUOuUHEPk5CnhyIoxYTQEzVWbeD5xLKH/g4qfKhBhDz0VnoBoMKptj0JaYnQ
         aDRg==
X-Gm-Message-State: ANoB5plieUkrbz4GMeSw3FTV3/h/JZJbS9NWR53H/sP0LdGa2lm4rrK/
        /LhyuNljs4zAGXOgOI6K32sN7s6nRwmXL3goSKvdJQ==
X-Google-Smtp-Source: AA0mqf6lprZSmewGrvzVAa0XSN3J7a1NlrVvMn5WyGmyExooaEz9MlPhHaGfB/x38ob74t7Sb98djD3uxaoGvd7bSrY=
X-Received: by 2002:a25:1e89:0:b0:6f6:b3d1:edcc with SMTP id
 e131-20020a251e89000000b006f6b3d1edccmr48267868ybe.125.1670873386230; Mon, 12
 Dec 2022 11:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20221211002908.2210-1-hdanton@sina.com> <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com> <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com> <Y5d565XVsinbNNL2@mit.edu>
In-Reply-To: <Y5d565XVsinbNNL2@mit.edu>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Dec 2022 20:29:10 +0100
Message-ID: <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022 at 19:58, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Dec 12, 2022 at 11:29:11AM +0800, Hillf Danton wrote:
> > > You've completely misunderstood Al's point.  He's not whining about
> > > being cc'd, he's pointing at this is ONLY USEFUL IF THE NTFS3
> > > MAINTAINERS ARE CC'd.  And they're not.  So this is just noise.
> > > And enough noise means that signal is lost.
> >
> > Call Trace:
> >  <TASK>
> >  inode_unlock include/linux/fs.h:761 [inline]
> >  done_path_create fs/namei.c:3857 [inline]
> >  do_mkdirat+0x2de/0x550 fs/namei.c:4064
> >  __do_sys_mkdirat fs/namei.c:4076 [inline]
> >  __se_sys_mkdirat fs/namei.c:4074 [inline]
> >  __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4074
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > Given the call trace above, how do you know the ntfs3 guys should be also
> > Cced in addition to AV? What if it would take more than three months for
> > syzbot to learn the skills in your mind? What is preventing you routing
> > the report to ntfs3?
>
> If it takes 3 months for syzbot to take a look at the source code in
> their own #!@?! reproducer, or just to take a look at the strace link
> in the dashboard:
>
> [pid  3639] mount("/dev/loop0", "./file2", "ntfs3", MS_NOSUID|MS_NOEXEC|MS_DIRSYNC|MS_I_VERSION, "") = 0
>
> There's something really wrong.  The point Al has been making (and
> I've been making for multiple years) is that Syzbot has the
> information, but unfortunately, at the moment, it is only analyzing
> the the stack trace, and it is not doing things that really could be
> done automatically --- and cloud VM time is cheap, and upstream
> maintainer time is expensive.  So by not improving syzbot in a way
> that really shouldn't be all that difficult, the syzbot maintainers is
> disrespectiving the time of the upstream maintainers.
>
> So sure, we could ask Linus to triage all syzbot reports --- or we
> could ask Al to triage all syzbot file system reports --- but that is
> not a good use of upstream resources.
>
> And "we didn't know this is super annoying" isn't an excuse, because
> I've been asking for things like this *before* the COVID pandemic.  So
> if the Syzbot team won't listen to observations by a random Google
> engineer who happens to be an ext4 maintainer (or rather, I'm sure
> they were listening, but they didn't consider it important enough to
> staff and put on the roadmap), maybe something a bit
> more.... assertive by Al is something that will inspire them to
> prioritize this feature request "above the fold".  :-)
>
> And Al does have a point --- if a lot of upstream maintainers consider
> Syzbot reports to be less than useful, they will either auto-file
> reports to a junk folder, or just ignore the Syzbot reports because
> they are busy and the Probability(Usefulness) is close to zero, then
> recovering from that black eye to Syzbot's reputation is going to be a
> lot more difficult than if Syzbot was made more respectful of upstream
> maintainer time much earlier.
>
> Now, to be fair to the Syzbot team, the Syzbot console has gotten much
> better.  You can now download the syzbot trace, and download the
> mounted file system, when before, you had to do a lot more work to
> extract the file system (which is stored in separate constant C
> array's as compressed data) from the C reproducer.  So have things
> have gotten better.
>
> But at the same time, characterizing a syzbot report is something to
> be done by every file system maintainer who looks as a syzbot report,
> because there is no way to add a tag to the syzbot report that this
> particular syzbot report *really* is an ntfs3 issue.  So any
> information that a single developer figures out when triaging a bug
> (is this potentially an ext4 bug, nope, it's an ntfs3 bug) has to be
> replicated by every single kernel developer looking at the Syzbot
> dashboard.  Which again, is not respectful of upstream maintainers'
> time.

This is being worked on:
https://github.com/google/syzkaller/issues/3393#issuecomment-1330305227

Teaching a bot the pattern matching skills of a human is non-trivial.
The current design will likely do the simplest thing: regex match
reproducers and map a match to some kernel source dir, for which the
maintainers are Cc'd. If you have better suggestions on how to
mechanize subsystem selection based on a reproducer, please shout.
