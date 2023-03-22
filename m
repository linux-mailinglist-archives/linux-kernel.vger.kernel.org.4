Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D606C4FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCVPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjCVPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:55:27 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F45B43B;
        Wed, 22 Mar 2023 08:55:24 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id x33so12947481uaf.12;
        Wed, 22 Mar 2023 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkiGC3KrWLcdVvbKtOD6EuMic290UkYWO3dGkV1DW6M=;
        b=SfYNzRieiSacBnZzinpD3JwNvgMRa+NXUxjMEV+g91rUok2QRQtIoLw4xVo/WYsRMe
         g9D7vI8WY2XtxVxbWCXxkv9y91H5aTaAgLBl7lA44o4HynNGSNnfjLs9kwxgQGafnfXs
         EOGDdaA/9oNYcn55W+6VHiMEfJJ3OEpqjRGYfyjRSfcIecHGyyLm1s0eVFeuc0UYGdZ+
         h7i2Nms/wr60H9KLZ9k9+Sw/InLSKLEpIz6134u8BLrFbrNf7I28ahX9J40vJNRkcm0R
         unbVv7pNOkaPV17HMxfiKWTnHLX1tSDw61aG+cGxz1Q52Y05F2ILaQgyhvWS2KNutcsI
         yQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkiGC3KrWLcdVvbKtOD6EuMic290UkYWO3dGkV1DW6M=;
        b=1zT0+5B26WncEPXGrvqmo93FjmCseEjqA6vRV4/bINN6is7Ti14zg1z5REGo73DhpL
         s84OOO12X9EMLP1pYaGpPWOXAg72yD/I9edJsPDc4nZO81k4PFHblUTyw9Y1hRROlUtk
         AZoQ81JV0gvbNoQBSnn548GVEbLZ/OZHlQIStYGgMAm5/09oSxLQ6OID1SDBCI5V5Wt0
         7g4Al7GfrlzbIKvYdlbv/VqIWo8+zBwXN6ktlXdUOZjqMOs+RjZcex1BL9n0F0ElbmpG
         5jZYaM8vX65S1zDl1MNCUYEuL/qcTVkGYlF+UQV9vhjCNTXiVZl9zYAKIneA57rT/lmf
         6r4Q==
X-Gm-Message-State: AAQBX9dcRTX9RgmpegjJ5ktf1ZlBlHNogswxV4zsufLxVvwYLHfsazCV
        s8WaKd1Dxr2AnxOLTjbo/tuzMoOra2wVvLt47xE=
X-Google-Smtp-Source: AKy350b8QTB1s5WselluQQaw7LPVVPPE9gv4ky3yMgOg/05AlNjluBezpFi0dGocghRlqqIGotLucpqmeScJqEgIDMY=
X-Received: by 2002:a05:6130:424:b0:68b:8665:a73b with SMTP id
 ba36-20020a056130042400b0068b8665a73bmr3867185uab.1.1679500523106; Wed, 22
 Mar 2023 08:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
 <20221223-dyndbg-filename-v1-3-cbf8543009a1@weissschuh.net>
 <04311d93-7cb4-bf0b-dfa7-162a38b42583@akamai.com> <c0b009e8-0b12-4605-83fa-ceb3cb27922f@weissschuh.net>
In-Reply-To: <c0b009e8-0b12-4605-83fa-ceb3cb27922f@weissschuh.net>
From:   jim.cromie@gmail.com
Date:   Wed, 22 Mar 2023 09:54:56 -0600
Message-ID: <CAJfuBxxkTKKyxKgbk4iv0qDi7-fz=ThtZ8FhUag_GMtjmPHoOA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dyndbg: add source filename to prefix
To:     linux@weissschuh.net
Cc:     Jason Baron <jbaron@akamai.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 4, 2023 at 7:49=E2=80=AFAM <linux@weissschuh.net> wrote:
>
> Hi Jason,
>
>
> Feb 3, 2023 10:45:49 Jason Baron <jbaron@akamai.com>:
>
> > Hi Thomas,
> >
> > Thanks for this series, this series is fine with me:
> > Acked-by: Jason Baron <jbaron@akamai.com>
>
> Thanks!
>
> > Your comment about making the output more relatable to the control file=
 made me think if we should try and make the logged output look more like t=
he control file:
> >
> > # cat /proc/dynamic_debug/control
> > # filename:lineno [module]function flags format
> >
> > So for your example, I think that would look like:
> >
> > [   71.802212] lib/test_dynamic_debug.c:103 do_cats: test_dd: doing cat=
egories
> > [   71.802227] lib/test_dynamic_debug.c:123 do_levels: doing levels
> >
> > But even if we think it looks better, there maybe too many dependencies=
 on the current output format...
>
> I agree on both points.
>
> An alternative could be a new flag that prints the
> full format from the control file.
> The control file even has a format header that
> tools could use to parse out the fields, making it
> extensible.
>
> Not sure it's worth it though.
> And it should be in addition to this series in my
> opinion.

Boy howdy, I was hoping you were gonna do it. :-)

I think we need the 's' flag.
it displays properly as "$src:$line"

I agree that shuffling the "$src:$line" part before the "$mod:$func"
part would be ideal
(reluctantly) its a separate patch

Acked-by: Jim Cromie <jim.cromie@gmail.com>

(resisting the urge to hijack this thread for "designing")

>
> Thomas
>
> > Thanks,
> >
> > -Jason
> >
> > On 1/29/23 9:01 PM, Thomas Wei=C3=9Fschuh wrote:
> >> Printing the line number without the file is of limited usefulness.
> >> Knowing the filename also makes it also easier to relate the logged
> >> information to the controlfile.
> >> Example:
> >>      # modprobe test_dynamic_debug
> >>      # echo 'file test_dynamic_debug.c =3Dpfsl' > /proc/dynamic_debug/=
control
> >>      # echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
> >>      # dmesg | tail -2
> >>      [   71.802212] do_cats:lib/test_dynamic_debug.c:103: test_dd: doi=
ng categories
> >>      [   71.802227] do_levels:lib/test_dynamic_debug.c:123: test_dd: d=
oing levels
> >> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >> ---
> >>   Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
> >>   include/linux/dynamic_debug.h                     | 4 +++-
> >>   lib/dynamic_debug.c                               | 4 ++++
> >>   3 files changed, 10 insertions(+), 3 deletions(-)
> >> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docum=
entation/admin-guide/dynamic-debug-howto.rst
> >> index faa22f77847a..f9fa8163fba6 100644
> >> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> >> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> >> @@ -216,13 +216,14 @@ The flags are::
> >>     t    Include thread ID, or <intr>
> >>     m    Include module name
> >>     f    Include the function name
> >> +  s    Include the source file name
> >>     l    Include line number
> >>     For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, onl=
y
> >>   the ``p`` flag has meaning, other flags are ignored.
> >>   -Note the regexp ``^[-+=3D][flmpt_]+$`` matches a flags specificatio=
n.
> >> -To clear all flags at once, use ``=3D_`` or ``-flmpt``.
> >> +Note the regexp ``^[-+=3D][fslmpt_]+$`` matches a flags specification=
.
> >> +To clear all flags at once, use ``=3D_`` or ``-fslmpt``.
> >>       Debug messages during Boot Process
> >> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_deb=
ug.h
> >> index 41682278d2e8..0c77105d583c 100644
> >> --- a/include/linux/dynamic_debug.h
> >> +++ b/include/linux/dynamic_debug.h
> >> @@ -37,10 +37,12 @@ struct _ddebug {
> >>   #define _DPRINTK_FLAGS_INCL_FUNCNAME  (1<<2)
> >>   #define _DPRINTK_FLAGS_INCL_LINENO    (1<<3)
> >>   #define _DPRINTK_FLAGS_INCL_TID       (1<<4)
> >> +#define _DPRINTK_FLAGS_INCL_SOURCENAME (1<<5)
> >>     #define _DPRINTK_FLAGS_INCL_ANY     \
> >>     (_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
> >> -    _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
> >> +    _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
> >> +    _DPRINTK_FLAGS_INCL_SOURCENAME)
> >>     #if defined DEBUG
> >>   #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
> >> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> >> index e96ea427d8af..fa7418e35197 100644
> >> --- a/lib/dynamic_debug.c
> >> +++ b/lib/dynamic_debug.c
> >> @@ -92,6 +92,7 @@ static const struct { unsigned flag:8; char opt_char=
; } opt_array[] =3D {
> >>     { _DPRINTK_FLAGS_PRINT, 'p' },
> >>     { _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
> >>     { _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
> >> +   { _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
> >>     { _DPRINTK_FLAGS_INCL_LINENO, 'l' },
> >>     { _DPRINTK_FLAGS_INCL_TID, 't' },
> >>     { _DPRINTK_FLAGS_NONE, '_' },
> >> @@ -836,6 +837,9 @@ static char *__dynamic_emit_prefix(const struct _d=
debug *desc, char *buf)
> >>     if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
> >>         pos +=3D snprintf(buf + pos, remaining(pos), "%s:",
> >>                 desc->function);
> >> +   if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
> >> +       pos +=3D snprintf(buf + pos, remaining(pos), "%s:",
> >> +               trim_prefix(desc->filename));
> >>     if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
> >>         pos +=3D snprintf(buf + pos, remaining(pos), "%d:",
> >>                 desc->lineno);
> >>
>
