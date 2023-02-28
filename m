Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124856A6015
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjB1UBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjB1UBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:01:14 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6702ED69
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:01:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z11so6545089pfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677614472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UfcMv5b3nEqDwC1e7v3pq9dQo0t54UUGukhaiaf8Ow=;
        b=B9lAkxeFd4CxKKgbYrJR+T1C9ooo155l5GksgZi3LV9GZm26Ku/MQz44ODBx+okIWY
         N+HXaHnXUX0uZ/wfZYHax/u1VDz5QywDsnB+u2v2JtVjATLqDAOkhTQ3Q5bEr7Ics1QG
         TJYX7TDAqByynpj/s5PZT95jAWZ7cCJ+S4sGJlSdi8Iep8No3LZGdsykMRSANdan2OG6
         d958/VRNQWXJkdYHO7HHop3hO7aq7yyS3Lr8lLzF8xW8jsqf5c82mykgcZIki8TSeD1x
         v8l9RTiW3bVNZ4HPCrEXUKweHefipWqwqHF3iPgeK7VbRgbxjGDdPEXAdBAgUbwdW2mx
         sTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677614472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UfcMv5b3nEqDwC1e7v3pq9dQo0t54UUGukhaiaf8Ow=;
        b=Nqjb83VHKLbDbcfsxhxAJhixR2tFeMerJzM6fTA8G5JSjTddj7veb68Km+ZeJIe2Ni
         tY3UR5Nh/qq0tXwpmp7Ow16CIRxur8hWhg2k7ZJ1dOk5/AHHJuDQFfql7bE7Ktx7QjaB
         AL3gdUg4XodGog6z+dptfd6ssfJAhwWH7h5D9nZ1lU0h+ZmI2Zo6xia43lTvhS9qPW4B
         LzAw37ge+GKD9ByUA5qbb0DZ+EMQ98KTwt9qjMcHi/MBLtMiSBofQInr7A2+O/hH6Q0P
         xhZ7QAEKeDGrMXKqesT0vibWMFiY+FDxZSndoDEQDRuoyQIGSDSo1MgRWA43Dj6c0fuo
         pm2Q==
X-Gm-Message-State: AO0yUKWzU3vUIQNXnPKqN/ACA5hYTUyi2u70G+4N0NrIZ2k76r/kwaCd
        JDK32Nysk9444c2HXeXT3cyXUXNK6l1A/gKDMbo=
X-Google-Smtp-Source: AK7set8PU++T+7UrwTYBPXu19mPdTFORsfANJhNq2+6hEF8s8fvoUU46LhZlt65lrr+yVRyrmxzFVOKKiaQRm1go4n8=
X-Received: by 2002:a62:824c:0:b0:606:a48f:c211 with SMTP id
 w73-20020a62824c000000b00606a48fc211mr348879pfd.1.1677614472313; Tue, 28 Feb
 2023 12:01:12 -0800 (PST)
MIME-Version: 1.0
References: <0b5efd70e31bba7912cf9a6c951f0e76a8df27df.1677517724.git.andreyknvl@google.com>
 <CACT4Y+Z4GvK-XCbrLp8cuH-xHYsCdh1f0948ZgkU2D0apfGG5w@mail.gmail.com>
In-Reply-To: <CACT4Y+Z4GvK-XCbrLp8cuH-xHYsCdh1f0948ZgkU2D0apfGG5w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 28 Feb 2023 21:01:01 +0100
Message-ID: <CA+fCnZdn+3LuzDP0f=kc9Pgt6i63cQbXieP1gJRYOS8WnVJKQA@mail.gmail.com>
Subject: Re: [PATCH] kcov: improve documentation
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:37=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> On Mon, 27 Feb 2023 at 18:17, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Improve KCOV documentation:
> >
> > - Use KCOV instead of kcov, as the former is more widely-used.
> >
> > - Mention Clang in compiler requirements.
> >
> > - Use ``annotations`` for inline code.
> >
> > - Rework remote coverage collection documentation for better clarity.
> >
> > - Various smaller changes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  Documentation/dev-tools/kcov.rst | 169 +++++++++++++++++++------------
> >  1 file changed, 102 insertions(+), 67 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools=
/kcov.rst
> > index d83c9ab49427..a113a03a475f 100644
> > --- a/Documentation/dev-tools/kcov.rst
> > +++ b/Documentation/dev-tools/kcov.rst
> > @@ -1,42 +1,50 @@
> > -kcov: code coverage for fuzzing
> > +KCOV: code coverage for fuzzing
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -kcov exposes kernel code coverage information in a form suitable for c=
overage-
> > -guided fuzzing (randomized testing). Coverage data of a running kernel=
 is
> > -exported via the "kcov" debugfs file. Coverage collection is enabled o=
n a task
> > -basis, and thus it can capture precise coverage of a single system cal=
l.
> > +KCOV collects and exposes kernel code coverage information in a form s=
uitable
> > +for coverage-guided fuzzing. Coverage data of a running kernel is expo=
rted via
> > +the ``kcov`` debugfs file. Coverage collection is enabled on a task ba=
sis, and
> > +thus KCOV can capture precise coverage of a single system call.
> >
> > -Note that kcov does not aim to collect as much coverage as possible. I=
t aims
> > -to collect more or less stable coverage that is function of syscall in=
puts.
> > -To achieve this goal it does not collect coverage in soft/hard interru=
pts
> > -and instrumentation of some inherently non-deterministic parts of kern=
el is
> > -disabled (e.g. scheduler, locking).
> > +Note that KCOV does not aim to collect as much coverage as possible. I=
t aims
> > +to collect more or less stable coverage that is a function of syscall =
inputs.
> > +To achieve this goal, it does not collect coverage in soft/hard interr=
upts
> > +(unless remove coverage collection is enabled, see below) and from som=
e
> > +inherently non-deterministic parts of the kernel (e.g. scheduler, lock=
ing).
> >
> > -kcov is also able to collect comparison operands from the instrumented=
 code
> > -(this feature currently requires that the kernel is compiled with clan=
g).
> > +Besides collecting code coverage, KCOV can also collect comparison ope=
rands.
> > +See the "Comparison operands collection" section for details.
> > +
> > +Besides collecting coverage data from syscall handlers, KCOV can also =
collect
> > +coverage for annotated parts of the kernel executing in background ker=
nel
> > +tasks or soft interrupts. See the "Remote coverage collection" section=
 for
> > +details.
> >
> >  Prerequisites
> >  -------------
> >
> > -Configure the kernel with::
> > +KCOV relies on compiler instrumentation and requires GCC 6.1.0 or late=
r
> > +or any Clang version supported by the kernel.
> >
> > -        CONFIG_KCOV=3Dy
> > +Collecting comparison operands is only supported with Clang.
>
> Are you sure?
> I see -fsanitize-coverage=3Dtrace-cmp in gcc sources and man page.

Right, supported too starting with version 8.

Will fix in v2.

> Otherwise looks good to me.

I'll add your Reviewed-by to v2 then.

Thank you!
