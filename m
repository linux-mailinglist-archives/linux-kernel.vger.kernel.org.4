Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3B6BE389
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjCQI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCQI3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:29:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EAE7EEF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:27:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l12so3651653wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679041588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQQ8Rr0GNNjEqZiFdGJDuoFmQDajpElxjEgIIXNrg+A=;
        b=CzspyjegKHykcmyIo8utz3QbIpdHNKov0r3UAEZb/RLinWUxOhbJDpbZtBJ61moMQr
         cfyJCsApMRC/Y/F3jh+H4HLiE48eOblbhCg5sQLkG2sMaSSeRjfQGs1Dd+Upyo8tiyvY
         NXWjRFpcBe3rd9cZRsokafh54Z4jgEUH3MdMwdKw5WgiDM2VTPzbhiY1Ml1AtDGYFxZa
         m2IbLvMNNhyQsyrqFEp1kU2ZdE7QWUq3ma2flxlokf8JeEO34Gpyhk8m63/xaAPncACe
         V3TU4D4afDpq39Ilc9oLjbiTlH10PjbqUMoNpULKciY05wfradFtwnJ0jJ/S7L0bp5z8
         VDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQQ8Rr0GNNjEqZiFdGJDuoFmQDajpElxjEgIIXNrg+A=;
        b=WzzXB43Ui9BbZB/mSj1nUfetPdWAo5lQSSSvloEbMcRiIf7qXq+RCRq88cbswXm55u
         VO0x0aAJJP10ZXAWCl7iBV02m1qKQjNpwm+39nSvIpNAwQ0vXwnD89+sGEjmJ8YDibh2
         7cMxMbebgOC5pkxPOIwmwH0tmbgJ/RVQadugtvdB6PFquP9uRbOC1+OM85oFdyeFNS9/
         O1HWRNjZxQDVOqTPgXPPtxDljmpQLGfkTIuAgPFF0+P43JXxq2WDq53AAsSvcTfdgk7f
         0u7LUjeWNWnI+sSmi6U+1PzvT0Bmeq07iLpq4w/UoXV2DUeNCgxGdT6LjDUJqxygVlK1
         uGEQ==
X-Gm-Message-State: AO0yUKWzWPVjOogi23VfRRXHQ21aMxxAvNNnU9RuQpJEQgjP07SiaR2O
        yNZKS/7/e5+lHzEa69C6MKfAyJOEFmOPeMhgXzk2mVgq61A=
X-Google-Smtp-Source: AK7set/XsKYXKPcgHxVDMQuU50dAs2voaZzF3O4clp0ePF612HRJSWrds+0U4UndaC5r7Gl85K3xcZ57jyioc1WJ0Ow=
X-Received: by 2002:adf:fb42:0:b0:2c9:bd6e:83c0 with SMTP id
 c2-20020adffb42000000b002c9bd6e83c0mr1579848wrs.3.1679041587654; Fri, 17 Mar
 2023 01:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
 <CAHk-=wh0foAi-kPgNOq6qSHPgsfekT8N9_--usjiTynpQbqvRA@mail.gmail.com>
In-Reply-To: <CAHk-=wh0foAi-kPgNOq6qSHPgsfekT8N9_--usjiTynpQbqvRA@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Fri, 17 Mar 2023 16:26:15 +0800
Message-ID: <CAJNi4rO+gdRH4Hsx3gOOBS3m=wiH=uroPh7iJ5QgP1iqvNEd_Q@mail.gmail.com>
Subject: Re: Question about select and poll system call
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had to confess I've got *almost* the similar consideration after a
long dedicated thinking before seeing this, so it's one of the
greatest decisions we can make together. A very nice and patient
explanation, and happy weekend, good guy:). Please feel free to raise
your different options for anyone watching this...

Anyway, some comments inline...

On Fri, Mar 17, 2023 at 2:15=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 13, 2023 at 7:28=E2=80=AFPM richard clark
> <richard.xnu.clark@gmail.com> wrote:
> >
> > There're two questions about these system calls:
> > 1. According to https://pubs.opengroup.org/onlinepubs/7908799/xsh/selec=
t.html:
> > ERRORS
> > [EINVAL]
> >       The nfds argument is less than 0 or greater than FD_SETSIZE.
> > But the current implementation in Linux like:
> >        if (nfds > FD_SETSIZE)
> >                nfds =3D FD_SETSIZE
> > What's the rationale behind this?
>
> Basically, the value of FD_SETSIZE has changed, and different pieces
> of the system have used different values over the years.
>
> The exact value of FD_SETSIZE ends up actually depending on the
> compile-time size of the "fd_set" variable, and both the kernel and
> glibc (and presumably other C library implementations) have changed
> over time.
>
> Just to give you a flavor of that history, 'select()' was implemented
> back in early '92 in linux-0.12 (one of the greatest Linux releases of
> all time - 0.12 was when Linux actually became *useful* to some
> people).
>
> And back then, we had this:
>
>   typedef unsigned long fd_set;
>
> which may seem a bit limiting today ("Only 32 bits??!?"), but to put
> that in perspective, back then we also had this:
>
>   #define NR_OPEN 20
>
> and Linux-0.12 also did the *radical* change of changing NR_INODE from
> 32 to 64. Whee..
>
> It was a very different time, in other words.
>
> Now, imagine what happens when you increase those kinds of limits (as
> we obviously did), and you do the library and kernel maintenance
> separately. Some people might use a newer library with an older
> kernel, and vice versa.
>
> Doing that
>
>          if (nfds > FD_SETSIZE)
>                  nfds =3D FD_SETSIZE;
>
> basically allows you to at least limp along in that situation, where
> maybe the library uses a 'fd_set' with thousands of bits, but the
> kernel has a smaller limit.
>
> Because you *will* find user programs that basically do
>
>           select(FD_SETSIZE, ...)
>
> even if they don't actually use all those bits. Returning an error
> because the C library had a different idea of how big the fdset was
> compared to the kernel would be bad.
>
> Now, the above is the *historical* reason for this all. The kernel
> hasn't actually changed FD_SETSIZE in decades. We could say "by now,
> if you use FD_SETSIZE larger than 1024, we'll return an error instead
> of just truncating it".
>
> But at the same time, while time has passed and we could do those
> kinds of decisions, by now the POSIX spec is almost immaterial, and
> compatibility with older versions of Linux is more important than
> POSIX paper compatibility.
>
> So there just isn't any reason to change any more.
>
> > 2. Can we unify the two different system calls? For example, using
> > poll(...) to implement the frontend select call(...), is there
> > something I'm missing for current implementation?
>
> No. select() and poll() are completely different animals. Trying to
> unify them means having to convert from an array of fd descriptors to
> several arrays of bits. They are just very different interfaces.

Technically, this kind of conversion is not as radical as thought(even
I think the performance pain can be ignored), the pros. is the
maintainer needs to care about only one piece of code. Actually the
unified implementation of the fd->poll(...) can be seen as obvious
evidence, essentially the core is the same but with different skin, at
least this is weak to justify current implementation.

>
> Inside the kernel, the low-level implementation as far as individual
> file descriptors is concerned is all unified already. Once you just
> deal with one single file descriptor, we internally use a "->poll()"
> thing. But to *get* to that individual file descriptor, select() and
> poll() walk very different data structures.
>
>                   Linus
