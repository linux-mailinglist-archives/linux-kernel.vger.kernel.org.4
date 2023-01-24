Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8539678CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjAXALc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjAXALa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:11:30 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC21204B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:11:20 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r132so11904599oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CMGBITMz/lZXCdFVps8h/n7rt2b1zZj8hAlJn9lprRY=;
        b=lUUPMeHekcwzu5xQppi84GAUJeT5ZVQiZA4fOCOTC01Tgysoh8T9a5HNjOylL5O8q+
         4cM0yW1dA3OIT7AJOzGT9Y44wf3eslxaLFQ3WhPRKrRTK89ydRkXq4ywvnLfppRyUSTE
         LgAMsOdS/tTEBKUnpnLvJ/SD/thpV5yKZSPSqxeewmTv0W49GIUtTQmLaqfCSRYZalqo
         LneYb64SbHjXwDLN7e7unTgVEHg1yskwcY79z9/fBnrNVENr+QU8YO/uikCq4dyE2ptY
         kZNrMnePJ1+AIww23aB3LQBe+cWijGXwkAjGLr0LraZ8U2YZ/s/1xVJI3tw4dgqN2E+O
         OQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMGBITMz/lZXCdFVps8h/n7rt2b1zZj8hAlJn9lprRY=;
        b=0Ye/vDGMfv+ZFfSComZNZGtedd2ItruyR0KXrsebOPHHRS6q3W8UlUK0gXMROx64fB
         VJGNGL4uOoCcAmUaS6ZJ4Fn9Ynm9koYv7VXWmHwIYXnNTuHQh7xmeY98jMUo7Y3EcDh7
         xcyojWEYmFGFwBuuLcnVVVsYtpJKMnzZY82KoMSbSWb6GVl6vyj6AmO/JV50uaprWHVa
         Zv63/z68yUJ0dHBXSOs48VxtIlGbMJI6TuU5/tmPXhkQ/z1aD9GzYW4NJOR16AiwywzB
         /gylvIXzAl9LOEbPZzzH50glU0qfYIOs4rZDq2EDq5avpmO1F3FGu9xGDIcIy/qfrgHQ
         r+hA==
X-Gm-Message-State: AFqh2ko/ooVphUN3ywHJhCtlVnDuelBfyP+j5o6ES7C5logzJo2C1X8N
        9CGH+r9QeYvLmYD7bVZb2anGNbXglI1f9Myj6FpKdK5r
X-Google-Smtp-Source: AMrXdXsNzX8wnMzrzwoysweIyE0AFToe00bJ4Iyyja138RtBGRebyrXJAnDgp2CG+BTJqX3WEPIFE0nCpqgcglEroyU=
X-Received: by 2002:aca:2107:0:b0:365:64a:b3a1 with SMTP id
 7-20020aca2107000000b00365064ab3a1mr1021061oiz.81.1674519080060; Mon, 23 Jan
 2023 16:11:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ad6:0:b0:49c:e11d:f815 with HTTP; Mon, 23 Jan 2023
 16:11:19 -0800 (PST)
In-Reply-To: <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com> <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
 <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com> <CAHk-=whUSZk1dZrJuhxeb4qB3POstVRwOZCN8PXd3W7ztbqQBg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 24 Jan 2023 01:11:19 +0100
Message-ID: <CAGudoHH+SmRoyXvppjBEoK=dvVdy1jvKNHDLEVf9mLnzsEds6Q@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Uros Bizjak <ubizjak@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, Jan 23, 2023 at 7:59 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>> Basic idea would be to have competing CPUs aggregate the total change
>> on the lock and then have one of them make it happen across the
>> interconnect -- so instead of add/sub 1 you would add/sub n, where n
>> can very well be quite big.
>
> No. The use is literally serialized, and done one at a time, and needs
> to be synchronous.
>
> We're talking about looking up a <i>single</i> path component, while
> at the same time making sure that that path component isn't being
> removed by another CPU - and there is by definition no other locking
> going on, because the lockref *is* the locking.
>
[snip]
>
> Thanks to RCU pathname lookup, the lockref thing *should* come into
> play only when  you actually fall out of RCU mode, ie for the last
> component. That's a huge win, because that's what avoids the whole
> "everybody hammers on the root/pwd dentry counts".
>
> Your benchmark that looked up the *same* last component in parallell
> and all the time is not really a real load.
>
[snip2]
>
> So I'm not claiming lockref is perfect, but I do suspect you're
> barking up the wrong tree here. The optimizations you are talking
> about are either not realistic in the first place (because
> serialization and locking) or have already mostly been done (ie
> avoiding the op entirely except for the last component).
>

That was a minor remark in the spirit of attempting to reduce pingpong,
only made because of the paper. It was not a serious proposal, but
perhaps I failed to make it clear enough.

A more serious remark was in the last paragraph.

> HOWEVER. There is one special exception that might be interesting and
> that has never been done: 'fstat()' and friends could possibly avoid
> the "try_to_unlazy()" even for the last component.
>
> IOW, we might be able to do fstatat() without ever even finalizing the
> RCU state of the pathname, and actually looking up the stat
> information while still in RCU mode, and instead of doing the actual
> final lockref_get_not_dead() to turn an RCU path into a real
> ref-counted path, we could just do the "get the stat info, then do
> read_seqcount_retry() to verify that the RCU walk _and_ the stat info
> is still valid".
>

Ignoring mentioning specific routines by name is precisely what
I proposed in that e-mail. To quote myself:

> Personally, for lockref, I think the way to go forward is to use it less
> to begin with and to look for ways to convert it into a lock xadd-able
> primitive instead. The "doing it less thing" could be done by
> implementing a RCU-only mode for select syscalls, which defaults to
> opportunistically avoid refing squat. If the caller manages to do what
> it needed to do, that is a massive win; otherwise refs get taken. This
> could work well in the common case for syscalls like statx and access,
> but would not for open. Frankly I'm surprised something like this is
> not already implemented (maybe I missed a major showstopper?).

Now back to your response:

> But I'm not convinced that final complexity would be worth it. It
> sounds like a potentially fun and interesting exercise (Al Viro added
> to particupants so that he can say "No! That's not 'fun and exciting',
> that's just crazy!") if somebody really wants to, but see above: the
> last path component is very seldom something that sees contention. You
> look up the same root/pwd over and over again, but nobody sane looks
> up the same full pathname over and over again.
>
[snip]
> But since you clearly were looking at fstatat() performance, I can
> only point you at this case and say "There's _potentially_ upside
> there".
>

So if you strace something like gcc compiling stuff you will find:
- some access calls on shared dirs, for example:
78533 access("/usr/lib/gcc/x86_64-linux-gnu/11/", X_OK) = 0
78533 access("/usr/lib/gcc/x86_64-linux-gnu/11/", X_OK) = 0
78533 access("/usr/lib/gcc/x86_64-linux-gnu/11/", X_OK) = 0
- same with newfstatat:
87428 newfstatat(AT_FDCWD, "./arch/x86/include",
{st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
87428 newfstatat(AT_FDCWD, "./arch/x86/include/generated",
{st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
87428 newfstatat(AT_FDCWD, "./include", {st_mode=S_IFDIR|0755,
st_size=4096, ...}, 0) = 0
87428 newfstatat(AT_FDCWD, "./arch/x86/include/uapi",
{st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
- there is also quite a bit of readlink:
87502 readlink("/tmp", 0x7ffe28847ac0, 1023) = -1 EINVAL (Invalid argument)
87502 readlink("/tmp/ccTh37oI.s", 0x7ffe28847ac0, 1023) = -1 EINVAL
(Invalid argument)

that last bit is glibc doing realpath(). A case can be made for making
realpath into a syscall instead, but I'm not going to flame over for
the time being. :)

Anyhow, my point is that 2 gcc compiling different files do invoke path
lookups with the same terminal path components and lockref stuff gets
bounced around when it happens.

On another point how to end up dealing with lockref less, I have to
note glibc switched fstat(fd, buf) to use newfstatat(fd, "", buf,
AT_EMPTY_PATH) internally. This adds a lot of work single-threaded as
it forces a path lookup with associated stac/clac trip, but more
importantly the kernel no longer relies on liveness of the dentry
provided by the file object, but uses lockref instead. Something which
allows to get data produced by newfstatat without forcing a lookup
sounds like a welcome addition. Same goes for statx which seems to be
the recommended syscall. I'll be writing about this to -fsdevel some
time later.

-- 
Mateusz Guzik <mjguzik gmail.com>
