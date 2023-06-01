Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB471F048
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjFARHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjFARHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:07:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EAE2;
        Thu,  1 Jun 2023 10:07:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5162d2373cdso1492265a12.3;
        Thu, 01 Jun 2023 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685639266; x=1688231266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/Hv5zLm4y7cGqfEv37ODwcsKis46929s6CtwGx4OQs=;
        b=hTk7to+1XPfOqcKothqd8L8WDan8VGX9Rih9txBgkxPaRkPDO0NkNJgsjf0PU7GZ3S
         FLRjB6Dpgpa1cQ4epcci6Vic4VgchufqKfsB8FOMq2ZhDkPI2ZeEkI1mvLAr8t+qIL2W
         H61flMBMUXzTs8XJcf0KemyR7CdoVQOLPghBYnmWFLyRrw4NQOUL2qHFnux9KkOGED4p
         xl/XTkQVxLa7SIZ5LZG2xEhpCXthNFaFaCoke0HvJc9kzj697Z1pELnYUBF3by7wktBU
         04ruqdboHDt+T3lHC/ABPvvpb5ph0bm0SE699W4Xx0y5L+3ka1LAbNgC3n6wFBIlAmrG
         lXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639266; x=1688231266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/Hv5zLm4y7cGqfEv37ODwcsKis46929s6CtwGx4OQs=;
        b=WENN38a/r+rzXLc6BvZlA5oO7UPXuBamWMZ5VGhblKbCz412F/HyVtVOnsCrunRBhA
         SXkmnKScty0Ll5XDePql+fih3cElY0cz5bQLlz5YT71PFqjNZlniA+9zU7KbFSC+08Tm
         mClhRCIgGm7zaQ1g03Jg8YY/oGlD3zN9ZFfYX7LojQEEjkXJ+9F7biAvATTlpD8aArYA
         FmyQond29+yeQdULO4/U8z93ovkG0J4Lo7wNfi0hu5mqPj5sAJx4PY7Nd0lH20PMT025
         PU84N8Lcy6HaeiRBa9iMy+72FKS+xigkVxIoFbNYQQHvQHBSqtB33fRmLtN8EhXgCCXR
         XTcw==
X-Gm-Message-State: AC+VfDwO+HBy5Q1f1vYipQHBw17D52G/ykQA/qpcTM5SOuuU92IsKjxY
        c8XyMEWJ1g64o9/zQ78I+AG69BSy6wJRA4k5tTM=
X-Google-Smtp-Source: ACHHUZ68Rt03Gh6Dmxmgiz1l+/QKs7LcN4MxdBJGRGImfKiPJcB5HOnJuRIUXUriuMHzWfVGPfnrvaSZfV1C0eOfLZM=
X-Received: by 2002:a50:ee96:0:b0:510:e790:48fe with SMTP id
 f22-20020a50ee96000000b00510e79048femr373949edr.6.1685639265566; Thu, 01 Jun
 2023 10:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230531143533.196835-1-paniii94@gmail.com> <CAM9d7cgsP9cBq_Ui9-53zO0nLzBUK67goO1UcnqZ93Z4E7QcFQ@mail.gmail.com>
 <CAOh+m7w8uE-2HKi=+gXL6sFbsPRGBfKA4eNT+kJTVhHhJmMSLw@mail.gmail.com> <CAM9d7cho4-JOWTex0GkScQA2kmg3ZU5bqbRbUb_mG3vsoQ9vng@mail.gmail.com>
In-Reply-To: <CAM9d7cho4-JOWTex0GkScQA2kmg3ZU5bqbRbUb_mG3vsoQ9vng@mail.gmail.com>
From:   Elisabeth Panholzer <paniii94@gmail.com>
Date:   Thu, 1 Jun 2023 19:07:34 +0200
Message-ID: <CAOh+m7xjH+q5pMV67+60sK59pH+HZg9=XkF5qBDtyUbK1jOxUg@mail.gmail.com>
Subject: Re: [PATCH] Subject: perf jit: Fix incorrect file name in DWARF line table
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 18:29, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Jun 1, 2023 at 5:01=E2=80=AFAM Elisabeth Panholzer <paniii94@gmai=
l.com> wrote:
> >
> > Hello again,
> >
> > On Wed, 31 May 2023 at 22:50, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, May 31, 2023 at 7:35=E2=80=AFAM elisabeth <paniii94@gmail.com=
> wrote:
> > > >
> > > > Fix an issue where an incorrect file name was added in the DWARF li=
ne table
> > > > due to not checking the filename against the repeated name marker (=
/xff/0).
> > > > This can be seen with `objdump --dwarf=3Dline` on the ELF file afte=
r perf inject.
> > >
> > > I'm not aware of the marker.  Could you please provide a link or some=
thing?
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> >
> > The marker is mentioned in the tools/perf/util/jitdump.h header, this
> > file describes the jitdump binary format. According to a comment in
> > the =E2=80=98debug_entry=E2=80=99 struct in the =E2=80=98jitdump.h=E2=
=80=99 file, a filename set to
> > =E2=80=98\xff\0=E2=80=99 indicates that the name is the same as the one=
 from the
> > previous entry. When profiling applications in the browser together
> > with v8, I noticed =E2=80=98perf inject --jit=E2=80=99 inserts a bogus =
file name in
> > the DWARF line table. This happens because in the perf source code in
> > the file tools/perf/util/genelf-debug.c, in the function
> > emit_lineno_info(), the debug entry file gets compared to the previous
> > debug entry file. If they are not the same, a new filename is added to
> > the DWARF line table. However, there is no check for =E2=80=98\xff\0=E2=
=80=99, which
> > indicates that it's the same file. As a result, =E2=80=98\xff\0=E2=80=
=99 is inserted
> > as the filename into the DWARF section. This not only makes =E2=80=98ob=
jdump
> > --dwarf=3Dline=E2=80=99 print bogus as the filename, but it also makes =
no source
> > code information show up in perf annotate.
>
> Thanks for your detailed answer.  It would be great if you could send it
> to the mailing list so that others can see it as well.
>

I added the mailing lists to the cc again.

> So it's from the jitdump format.  I thought it was a part of DWARF or
> some other specification.

It is part of the jitdump format, yes.
The data from the jitdump, generated by for example v8, is just used
to generate the ELF images and the DWARF data with 'perf inject
--jit'.

>
> >
> > Hope this makes it more clear,
> > Elisabeth
>
> Sure, it really helped, thanks.
> Namhyung
>

You're welcome.

>
> >
> > > >
> > > > Signed-off-by: Elisabeth Panholzer <elisabeth@leaningtech.com>


On Thu, 1 Jun 2023 at 18:29, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Jun 1, 2023 at 5:01=E2=80=AFAM Elisabeth Panholzer <paniii94@gmai=
l.com> wrote:
> >
> > Hello again,
> >
> > On Wed, 31 May 2023 at 22:50, Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, May 31, 2023 at 7:35=E2=80=AFAM elisabeth <paniii94@gmail.com=
> wrote:
> > > >
> > > > Fix an issue where an incorrect file name was added in the DWARF li=
ne table
> > > > due to not checking the filename against the repeated name marker (=
/xff/0).
> > > > This can be seen with `objdump --dwarf=3Dline` on the ELF file afte=
r perf inject.
> > >
> > > I'm not aware of the marker.  Could you please provide a link or some=
thing?
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> >
> > The marker is mentioned in the tools/perf/util/jitdump.h header, this
> > file describes the jitdump binary format. According to a comment in
> > the =E2=80=98debug_entry=E2=80=99 struct in the =E2=80=98jitdump.h=E2=
=80=99 file, a filename set to
> > =E2=80=98\xff\0=E2=80=99 indicates that the name is the same as the one=
 from the
> > previous entry. When profiling applications in the browser together
> > with v8, I noticed =E2=80=98perf inject --jit=E2=80=99 inserts a bogus =
file name in
> > the DWARF line table. This happens because in the perf source code in
> > the file tools/perf/util/genelf-debug.c, in the function
> > emit_lineno_info(), the debug entry file gets compared to the previous
> > debug entry file. If they are not the same, a new filename is added to
> > the DWARF line table. However, there is no check for =E2=80=98\xff\0=E2=
=80=99, which
> > indicates that it's the same file. As a result, =E2=80=98\xff\0=E2=80=
=99 is inserted
> > as the filename into the DWARF section. This not only makes =E2=80=98ob=
jdump
> > --dwarf=3Dline=E2=80=99 print bogus as the filename, but it also makes =
no source
> > code information show up in perf annotate.
>
> Thanks for your detailed answer.  It would be great if you could send it
> to the mailing list so that others can see it as well.
>
> So it's from the jitdump format.  I thought it was a part of DWARF or
> some other specification.
>
> >
> > Hope this makes it more clear,
> > Elisabeth
>
> Sure, it really helped, thanks.
> Namhyung
>
>
> >
> > > >
> > > > Signed-off-by: elisabeth <paniii94@gmail.com>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/genelf_debug.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/genelf_debug.c b/tools/perf/util/genel=
f_debug.c
> > > > index aa5dcc56b2ac..2928b59bb9a5 100644
> > > > --- a/tools/perf/util/genelf_debug.c
> > > > +++ b/tools/perf/util/genelf_debug.c
> > > > @@ -349,6 +349,7 @@ static void emit_lineno_info(struct buffer_ext =
*be,
> > > >          */
> > > >
> > > >         /* start state of the state machine we take care of */
> > > > +       char const repeated_name_marker[] =3D {'\xff', '\0'};
> > > >         unsigned long last_vma =3D 0;
> > > >         char const  *cur_filename =3D NULL;
> > > >         unsigned long cur_file_idx =3D 0;
> > > > @@ -363,7 +364,8 @@ static void emit_lineno_info(struct buffer_ext =
*be,
> > > >                 /*
> > > >                  * check if filename changed, if so add it
> > > >                  */
> > > > -               if (!cur_filename || strcmp(cur_filename, ent->name=
)) {
> > > > +               if ((!cur_filename || strcmp(cur_filename, ent->nam=
e)) &&
> > > > +                       memcmp(repeated_name_marker, ent->name, siz=
eof(repeated_name_marker)) !=3D 0) {
> > > >                         emit_lne_define_filename(be, ent->name);
> > > >                         cur_filename =3D ent->name;
> > > >                         emit_set_file(be, ++cur_file_idx);
> > > > --
> > > > 2.34.1
> > > >
