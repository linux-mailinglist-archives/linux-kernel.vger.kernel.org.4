Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4165C0F6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237643AbjACNhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbjACNhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:37:05 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137010072
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:37:04 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id h27so18001631vsq.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZC/4CfEoCP84h65P9/vsWymefu0+WCG960hCYZnBdU=;
        b=SpOfI22JH24uzwGva6MCBxzoPptM8baY9coyGpfLyvdNThWVHri3dfmcr5GksM1Tew
         KLOivj+8Ejk1YPH2PQHIMGgntIsBnMsIfNyGA8dNFQwzANFJUR3LZDh8YVV44EmoT+Dk
         Db34YdqsMZMry9s6rKZJM/IQWmW7BI7yug+jEaCceo7LI/iTC49NrJiNNqeB2P1C4lnI
         vqmFgyKYWqJhJh2z96N0OZNR8fov1w4XQeGy2gc3ZMSCBLpQwhWyK7zPDFSs4lpPwP5R
         EciZjeIl0HWtYVKoO4/E+hakt+Fvj7kbsCova8CPF+UmJMK4akhIXZlM4GS07I6ETbde
         rn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZC/4CfEoCP84h65P9/vsWymefu0+WCG960hCYZnBdU=;
        b=w+SajZJMYmPWa6mHkreGUwB4l2dCCdx1VEDzUPitXEHJ7vXjMHrEisTnrd6Mf2yVXW
         yq7ybTr3nFPHmNg69Fpa9PDBpbkt0xHI7WGKsBrZP/FC9WG8b3VhJRhTBjhVNvDcuOc0
         sT+WKJwKBWwgAK3tK/o9nrEkcSnKeZn0GH6FL73s/Wnf4j3jQJbl91roV6NNmHWX9y7K
         n87Jnd+dMZKORcfmSLBubSRoNdylqJq2ikBWF/25RvlBMxkD8vQLmOt1uJIZLs0wKqpR
         z79IEtKtBVrIS0J4j6FPJnGYdle7U5/UQT9xsADYwVGJrg9pEj7npWnCmkAAUlwF+SqC
         5MUw==
X-Gm-Message-State: AFqh2kpxZrktglUFQ/LJ2KqSchRuAI4KwpX9g9Qt48Cdf44mxZgtGew+
        8uprTV7/RF/+TZib9RSoU818lehxiE85n+kYv5zrMw==
X-Google-Smtp-Source: AMrXdXszcryYqU11zWEiwxmncWD5vTxNtQqq6xqhBf+tGjHDmFPG1fbVdWHTLbCfd9SQIH5+bCo8uE0LpSghpN36afs=
X-Received: by 2002:a67:f642:0:b0:3c4:ec4b:b943 with SMTP id
 u2-20020a67f642000000b003c4ec4bb943mr4907800vso.17.1672753023001; Tue, 03 Jan
 2023 05:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20221211002908.2210-1-hdanton@sina.com> <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com> <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com> <Y5d565XVsinbNNL2@mit.edu>
 <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com>
 <Y5fY6BRTB9OfwFU0@ZenIV> <CANp29Y4x8zoXW0z-HarX3xZ6o8OHzWnGyHw8+JGsbLJKDWUgGA@mail.gmail.com>
 <Y64D69VTnJEQuHwT@sol.localdomain> <Y7BqAxMrtyigw6O8@mit.edu>
In-Reply-To: <Y7BqAxMrtyigw6O8@mit.edu>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 3 Jan 2023 14:36:51 +0100
Message-ID: <CANp29Y6hO0XcZdwSAd4uiuw03PmgQZOXhfSO3mFboQ9N7NdDMA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Marco Elver <elver@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Taras Madan <tarasmadan@google.com>
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

Hi Eric, Ted,

On Sat, Dec 31, 2022 at 5:58 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Dec 29, 2022 at 01:17:31PM -0800, Eric Biggers wrote:
> > Thanks Aleksandr.  From what I can see, the fix is working for new filesystem
> > bugs: the filesystem(s) involved get added to the title and the recipients.
> >
> > One question: what happens to all the open bugs, like this one ("WARNING in
> > do_mkdirat") that were reported before the syzbot fix?  Are they going to be
> > re-reported correctly?  Perhaps any bug whose reproducer includes
> > "syz_mount_image" and was reported before the date of this fix should be
> > invalidated more aggressively than usual, so that it can be re-reported?

I fear that the community will not be super excited to see those tons
of fs bug reports again :)

Soon it'll become possible to see the subsystems on the dashboard and
to filter bugs based on them, hopefully this will help those bugs not
get completely lost.

>
> As a related request/wish, it would be nice if those dashboard pages
> that were created before the new-style reporting which includes the
> file system image, strace otuput, etc., could get regenerated.  For example:
>
> https://syzkaller.appspot.com/bug?id=be6e90ce70987950e6deb3bac8418344ca8b96cd

I've deployed the change -- now it should display all the download
links on the bug info page. If we have reported a download link /
strace log in an email, it should be there. For yet older bugs, it's
trickier. We regenerate reproducers once in 100 days, so if the old
bugs keep on happening, the information will appear there over time as
well.

>
> Even if someone has already submitted a proposed fix, I often like to
> double-check that the fix is really fixing the true root cause of the
> problem, as opposed to just making a superficial change that blocks
> the current syzbot reproducer, but which will eventually be tripped
> again because code is still vulnerable.  (For example, we might block
> a straightforward reproducer by adding a check at mount time, but if
> the superblocks get corrupted during the journal replay, we'd still be
> vulnerable.)  And having access to the corrupted file system image,
> and other associated reporting data, is often super-helpful in that
> regard.

Thank you very much for the feedback below!

>
> Also, can we at some point have the C reproducer actually using proper
> C strings instead of hex digits?  It will make the reproducer much
> more human understandable, as well making it easier to edit the string
> when the developer is trying to do a better job minimizing the test
> case than syzbot.  For example:
>
>   memcpy(
>       (void*)0x20000000,
>       "\x6e\x6f\x75\x73\x65\x72\x5f\x78\x61\x74\x74\x72\x2c\x61\x63\x6c\x2c\x64"
>       "\x65\x62\x75\x67\x5f\x77\x61\x6e\x74\x5f\x65\x78\x74\x72\x61\x5f\x69\x73"
>       "\x69\x7a\x65\x3d\x30\x78\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30\x30"
>       "\x30\x30\x38\x30\x2c\x6c\x61\x7a\x79\x74\x69\x6d\x65\x2c\x6e\x6f\x62\x68"
>       "\x2c\x71\x75\x6f\x74\x61\x2c\x00\x3d\x93\x09\x61\x36\x5d\x73\x58\x9c",
>       89);
>
> Would be *much* more understable if it were:
>
>   memcpy(
>       (void*)0x20000000,
>       "nouser_xattr,acl,debug_want_extra_isize=0x0000000000000080,lazytime,nobh,quota,",
>       80);

I've filed an issue to keep track on the progress:
https://github.com/google/syzkaller/issues/3605

>
> Of course, something like:
>
>    char mount_options[] = "nouser_xattr,acl,debug_want_extra_isize=0x0000000000000080,lazytime,nobh,quota,";
>
> Would be even better (and more portable) than using random hex
> addresses, but just simply using ASCII strings would be a good first
> step.
>
> Of course, filling in C structures instead of just a random memcpy of
> hex garbage would be even *more* awesome, bunt I'll take what I can
> get.  :-)
>
> Another opportunity for improvement is to try minimizing mount
> options, so it becomes more obvious which ones are required.  For
> example, in the above example, a minimized mount option string would
> have been:
>
>   memcpy((void*)0x20000000, "debug_want_extra_isize=0x80,lazytime," 38);
>
> Having a more minimized reproducer would improve the reliability of
> the bisect, as well as making it easier for the developer to figure
> out the true root cause of the problem.

I've filed an issue: https://github.com/google/syzkaller/issues/3606

--
Best Regards,
Aleksandr

>
> Cheers,
>
>                                         - Ted
>
