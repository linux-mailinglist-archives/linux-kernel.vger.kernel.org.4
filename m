Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544F17457B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGCIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGCIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:50:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5710D8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:49:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-4fb9fd28025so5595199e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688374192; x=1690966192;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kROqTS8zYsaLySu7JmTcNK/xxL79gYyzV7R7X4O/qGA=;
        b=qNI/iJBjoHLQodbwGukdp+YEWxyJu+FgtY4iReU/kjJdN/2hm2zSSbELu9ewUBd75+
         Dw6BLdlldBbmnXWFMMox6V6ZNAx6LnMG8YFCzEOSSZhPA6WxAzqXgnfrOmfHzlF7rzM4
         uiuWwI5EllMz2xKm+MBaGDACNL6cz+Fjkjk1xk+5IJGgBsNTexLPnawJIvC3UyMxxisR
         Zkb3BXre50yRsVdsFjjjYsuj5A6bS5JP981/r9fxMw3azP54R49xMqQb/RHmGUCeeW0l
         SqFN1ecW4v6338Gmvtoy0ph+sQzJ+3lNu27cNE9sl7DN9/mYIEOJUJiR3Z/WOT2Vc+iq
         dIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688374192; x=1690966192;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kROqTS8zYsaLySu7JmTcNK/xxL79gYyzV7R7X4O/qGA=;
        b=AZ0SJlzMliGHDNBmWUDm2h8dpMSFD1jV9ai3fqUVzfsHWXWljXjnAyvRkudhLaIY8T
         uaYISm/k+nP4+F/0UV4r8FvvzX9WF+Dz41+EQ+aiEs8kpaZQXFXvkbaWSeZSZtfMNo/t
         AKLXxcSe4Kwmo/eKHFnPinntNrYivBOpDFXDV/3xo7SyMMegDw5e3Meal6YRB3/TlQtx
         oL0QsSsxpkQXbM9DFAvhJRG+Mth8LcVjJtQkQTIwIV2EOKDCYCl3UzyY0UBw09LgAYMM
         VIZ6CT1r13Tb9Jmbh30mB2XzgLZvXvrm2xvgbNeS0g/Q/A45ykpfCipYhIVLBnofrC/c
         /eIg==
X-Gm-Message-State: ABy/qLYZigzf4haAsMdFUY3ntTsJM3sB6oMqoy+M8WWJFCz4xOoQqQTM
        arlmZXB30ZxhOLsJ42Us494=
X-Google-Smtp-Source: APBJJlGUF/6v05+URsfL22sCMh95xPIoDszyQLCQudZPR1JQrvxoM7qdhZKZS/23un8sGFumwgSXDA==
X-Received: by 2002:a05:6512:34cb:b0:4f8:d385:41bd with SMTP id w11-20020a05651234cb00b004f8d38541bdmr5657396lfr.8.1688374192115;
        Mon, 03 Jul 2023 01:49:52 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id u27-20020a056512041b00b004fbacee6028sm1221785lfk.110.2023.07.03.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 01:49:51 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:49:49 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc:     Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
        pierre-eric.pelloux-prayer@amd.com,
        Sebastian Wick <sebastian.wick@redhat.com>,
        amd-gfx@lists.freedesktop.org,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
        Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, christian.koenig@amd.com
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Message-ID: <20230703114949.796c7498@eldfell>
In-Reply-To: <7c1e6df5-1ad4-be3c-b95d-92dc62a8c537@mailbox.org>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
        <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com>
        <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
        <afab1f5a-e581-3416-e2c2-238ea120655b@mailbox.org>
        <CAAxE2A5C96k5ua+r938VA_+w7gHHNTdF3n8LwDb98W0Bf9wCVA@mail.gmail.com>
        <7c1e6df5-1ad4-be3c-b95d-92dc62a8c537@mailbox.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C4YI/5tzC5DMxCBTI_3NuKt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C4YI/5tzC5DMxCBTI_3NuKt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jul 2023 09:12:29 +0200
Michel D=C3=A4nzer <michel.daenzer@mailbox.org> wrote:

> On 6/30/23 22:32, Marek Ol=C5=A1=C3=A1k wrote:
> > On Fri, Jun 30, 2023 at 11:11=E2=80=AFAM Michel D=C3=A4nzer <michel.dae=
nzer@mailbox.org <mailto:michel.daenzer@mailbox.org>> wrote: =20
> >> On 6/30/23 16:59, Alex Deucher wrote: =20
> >>> On Fri, Jun 30, 2023 at 10:49=E2=80=AFAM Sebastian Wick
> >>> <sebastian.wick@redhat.com <mailto:sebastian.wick@redhat.com>> wrote:=
 =20
> >>>> On Tue, Jun 27, 2023 at 3:23=E2=80=AFPM Andr=C3=A9 Almeida <andrealm=
eid@igalia.com <mailto:andrealmeid@igalia.com>> wrote: =20
> >>>>>
> >>>>> +Robustness
> >>>>> +----------
> >>>>> +
> >>>>> +The only way to try to keep an application working after a reset i=
s if it
> >>>>> +complies with the robustness aspects of the graphical API that it =
is using.
> >>>>> +
> >>>>> +Graphical APIs provide ways to applications to deal with device re=
sets. However,
> >>>>> +there is no guarantee that the app will use such features correctl=
y, and the
> >>>>> +UMD can implement policies to close the app if it is a repeating o=
ffender,
> >>>>> +likely in a broken loop. This is done to ensure that it does not k=
eep blocking
> >>>>> +the user interface from being correctly displayed. This should be =
done even if
> >>>>> +the app is correct but happens to trigger some bug in the hardware=
/driver. =20
> >>>>
> >>>> I still don't think it's good to let the kernel arbitrarily kill
> >>>> processes that it thinks are not well-behaved based on some heuristi=
cs
> >>>> and policy.
> >>>>
> >>>> Can't this be outsourced to user space? Expose the information about
> >>>> processes causing a device and let e.g. systemd deal with coming up
> >>>> with a policy and with killing stuff. =20
> >>>
> >>> I don't think it's the kernel doing the killing, it would be the UMD.
> >>> E.g., if the app is guilty and doesn't support robustness the UMD can
> >>> just call exit(). =20
> >>
> >> It would be safer to just ignore API calls[0], similarly to what
> >> is done until the application destroys the context with
> >> robustness. Calling exit() likely results in losing any unsaved
> >> work, whereas at least some applications might otherwise allow
> >> saving the work by other means. =20
> >=20
> > That's a terrible idea. Ignoring API calls would be identical to a
> > freeze. You might as well disable GPU recovery because the result
> > would be the same. =20
>=20
> No GPU recovery would affect everything using the GPU, whereas this
> affects only non-robust applications.
>=20
>=20
> > - non-robust contexts: call exit(1) immediately, which is the best
> > way to recover =20
>=20
> That's not the UMD's call to make.
>=20
>=20
> >>     [0] Possibly accompanied by a one-time message to stderr along
> >> the lines of "GPU reset detected but robustness not enabled in
> >> context, ignoring OpenGL API calls". =20
>=20

Hi,

Michel does have a point. It's not just games and display servers that
use GPU, but productivity tools as well. They may have periodic
autosave in anticipation of crashes, but being able to do the final
save before quitting would be nice. UMD killing the process would be
new behaviour, right? Previously either application's GPU thread hangs
or various API calls return errors, but it didn't kill the process, did
it?

If an application freezes, that's "no problem"; the end user can just
continue using everything else. Alt-tab away etc. if the app was
fullscreen. I do that already with games on even Xorg.

If a display server freezes, that's a desktop-wide problem, but so is
killing it.

OTOH, if UMD really does need to terminate the process, then please do
it in a way that causes a crash report to be recorded. _exit() with an
error code is not it.


Thanks,
pq

--Sig_/C4YI/5tzC5DMxCBTI_3NuKt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSii60ACgkQI1/ltBGq
qqckqQ/7BrK4wgscUoPj6/oNTGTEMmR3qF02TonW2w2/6I3KEJbAMLEJK0m/k4yk
XjyAi66YlQNEWpyLl+pNKLKGmsVkiBmPf23Y/16X0WeEQcpFkZb07NJ+uh7TOLx5
LokNIV+wsQMv1udl+Z/f/iRsCR6UFyJwVa+BvX2eIGPfjfn4bgNuvEIbSyEWk0sd
aPQV2c7gAAk+tTcfO9utVNWM04tFWfrqjCqvfj5vjj5B6on74Fzz4+gAlLm8XKfP
zDtedNCPepl7s2phZwKf1OsHa7QTTtvZHqTh3pPYbtxNbSe9oVtGbog6rRo4JfRA
ZqibRvEGrybLMMSqapQTGkTtYMBgr5wdLL4ZbweslAawlnIpW85krFJZgCji6z3z
Y7X8ICSDNbFlIlPETgci4lADVrgMa+BmtvQE6ecY8IWuAbsvWNBYCmYloLiikjmG
XwK9ZGujrWjJOZ6LGYGEPxHNHxrDY5so4w6vfs62iP0OJgqoAeQhrbxBUXuYBUOS
ZhntMMtWXfdB2M8WsVuJuKixpDBol9IDPM+m83tfV20/iwzBpKhJ5eh+CEHN9THk
DA+0I4XPTDl45hzoOneDMP1BvJePXTKvTb6V3jwK7KGrUhaEV4N/C/33LaJXUwZp
KUQD3KOHMn6+P9rAG1UdqscSxfQpwl857PVqHg5EpMlkZ1sIzrw=
=n6NT
-----END PGP SIGNATURE-----

--Sig_/C4YI/5tzC5DMxCBTI_3NuKt--
