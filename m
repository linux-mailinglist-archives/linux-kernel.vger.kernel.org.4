Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836CE64EE23
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiLPPtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiLPPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:48:48 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215265FB92
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:48:47 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id v21so625140uam.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYyw641UQlhdY1HWQGXj9TtCUKC82UQ9QI48yzSo1is=;
        b=rPYrTc6DvNr/X7Oi9wM8LYTYjVShddq9aQ+JRdNQYkWUujHxfHoC+0KZtpdCivvRj/
         jDVkRekXW7rVRelvVCxP3Jwnfqf3HFn4xkNE/s/JGe2vkeXDmNH2kBX7aIdYoOViGeFM
         gpGVlH8DAzI1beEs8QtvDg5VyaWf3fgO+InZ2d26nfkoOevGYsTK0CQDYpHFvt/yUHCo
         XQ20h7TkP7tnyoALGGNCNIljth4pLdw2f+nLGjTRatdU/3dAq2006hgcltktomK3YYs8
         IUt3WneZAz7gURpcdiVgTE18odWgAsis7p1WS5QhLf4YW6KsfRUgYZzb6CGEG5CF1pvs
         Y5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYyw641UQlhdY1HWQGXj9TtCUKC82UQ9QI48yzSo1is=;
        b=wMRQ+QCvbDz53q7o6gYMHh36BzYc+yrU26yIcxY3WB3UvKcxlkj9hLK90PoaT9qMk7
         4DNxFksy+POLtZphbtlpGC3VRy2+UGD0EmKiIOY6QGCyvGDrhtYdRdx2LDbhorlLc8na
         tKgwdscDEnRSIPq43ihLMOvtznfBSgYO2P6dCkHyf6UpNF6sMff5PhDge7uDTjiuHCTs
         kfrOaUvCeRCYS0AYVEmcrmV4pOBt2kyqGF2kocupFwguU0GhJ0yDRBn2XhaBBLSn1XfO
         DJVyckrPlQhyjKzFQAiJtI2qrrN2MmOjS5UhsgcnoXkn1NI5ZUQZe/c5VObRjPjvokcK
         NFKA==
X-Gm-Message-State: ANoB5pmWRsPPKduiNchymCi8qxSmRp1ugswjcZQjUFbRPGx4CFCON08m
        g0uAH169VJOb0OOMXcOB4Z3/yKYqCSTq42Q4pJyVN5tauZsB622U
X-Google-Smtp-Source: AA0mqf4T5nbzgu+TCh9N6EOi6miuOG5tQBOYekxMbZim3irFSGgi+QEZadNXAL8LsMVD4hMNKHK4R//ELrG7VbFYIoQ=
X-Received: by 2002:ab0:700c:0:b0:42f:70c2:593b with SMTP id
 k12-20020ab0700c000000b0042f70c2593bmr1966770ual.50.1671205726107; Fri, 16
 Dec 2022 07:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20221211002908.2210-1-hdanton@sina.com> <00000000000025ff8d05ef842be6@google.com>
 <20221211075612.2486-1-hdanton@sina.com> <20221211102208.2600-1-hdanton@sina.com>
 <20221212032911.2965-1-hdanton@sina.com> <Y5d565XVsinbNNL2@mit.edu>
 <CANpmjNNCQEXpJt1PQptyr8mrBbhWpToCRfvUT+RXmw5EA5EwVw@mail.gmail.com> <Y5fY6BRTB9OfwFU0@ZenIV>
In-Reply-To: <Y5fY6BRTB9OfwFU0@ZenIV>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 16 Dec 2022 16:48:34 +0100
Message-ID: <CANp29Y4x8zoXW0z-HarX3xZ6o8OHzWnGyHw8+JGsbLJKDWUgGA@mail.gmail.com>
Subject: Re: [syzbot] WARNING in do_mkdirat
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Marco Elver <elver@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
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

On Tue, Dec 13, 2022 at 2:44 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Dec 12, 2022 at 08:29:10PM +0100, Marco Elver wrote:
>
> > > > Given the call trace above, how do you know the ntfs3 guys should be also
> > > > Cced in addition to AV? What if it would take more than three months for
> > > > syzbot to learn the skills in your mind?
>
> Depends.  If you really are talking about the *BOT* learning to do
> that on its own, it certainly would take more than 3 months; strong AI
> is hard.  If, OTOH, it is not an AI research project and intervention of
> somebody capable of passing the Turing test does not violate the purity
> of experiment...  Surely converting "if it mounts an image as filesystem
> of type $T, grep the tree for "MODULE_ALIAS_FS($T)" and treat that
> as if a function from the resulting file had been found in stack trace"
> into something usable for the bot should not take more than 3 months,
> should it?
>
> If expressing that rule really takes "more than three months", I would
> suggest that something is very wrong with the bot architecture...
>
> > Teaching a bot the pattern matching skills of a human is non-trivial.
> > The current design will likely do the simplest thing: regex match
> > reproducers and map a match to some kernel source dir, for which the
> > maintainers are Cc'd. If you have better suggestions on how to
> > mechanize subsystem selection based on a reproducer, please shout.
>
> Er...  Yes?  Look, it's really that simple -
> for i in `sed -ne 's/.*syz_mount_image$\([_[:alnum:]]*\).*/\1/p' <$REPRO`; do
>         git grep -l "MODULE_ALIAS_FS(\"$i\")"
> done | sort | uniq
> gets you the list of files.  No, I'm not suggesting to go for that kind
> of shell use, but it's clearly doable with regex and search over the source
> for fixed strings.  Unless something's drastically wrong with the way the
> bot is written, it should be capable of something as basic as that...
>
> If it can't do that kind of mapping, precalculating it for given tree is
> also not hard:
> git grep 'MODULE_ALIAS_FS("'|sed -ne 's/\(.*\):.*MODULE_ALIAS_FS("\([_[:alnum:]]*\)".*/syz_mount_image$\2:\1/p'
> will yield lines like
> syz_mount_image$ext2:fs/ext2/super.c
> syz_mount_image$ext2:fs/ext4/super.c
> syz_mount_image$ext3:fs/ext4/super.c
> syz_mount_image$ext4:fs/ext4/super.c
> etc.  Surely turning *that* into whatever form the bot wants can't
> be terribly hard? [*]
>
> All of that assumes that pattern-matching in syzkaller reproducer is
> expressible; if "we must do everything by call trace alone" is
> a real limitation, we are SOL; stack trace simply doesn't have
> that information.  Is there such an architectural limitation?

Thanks for the feedback, and we regret the inconvenience this may have caused.

We've deployed a simple short term solution to the immediate issue:
syzbot will extract the involved filesystems from reproducers and use
this information to construct the email subject line and Cc the
related people/mailing lists. This should take effect starting next
week.

That being said, in response to the original feedback we have already
been planning comprehensive improvements to the subsystem selection
process that will support more than just filesystems. But
unfortunately, this is going to take longer to become available.

--
Aleksandr

>
> [*] depending upon config, ext2 could be mounted by ext2.ko and ext4.ko;
> both have the same maillist for bug reports, so this ambiguity doesn't
> matter - either match would do.
