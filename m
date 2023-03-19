Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8F96BFF9C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 07:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCSGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCSGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 02:45:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B8E1A966
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 23:45:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg48so35221357edb.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679208329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgfIFgmkdg+6Ea9oqVXh/uKwgp5Rng4TUjK6rxHPpa8=;
        b=enzXeTx/gaZdwLXTT80MQMYrm7WZiFOUK4+MGEx7kHQhgVYddbUhv1+rumlPpDRY31
         6cSDv2fbkjYH6QDzPDI7K+bBqIPVpkT/TE5wS60VqDSAXx/1qpG7PxWKO2W0A3mB0Idw
         kzLE9coSIhZYiyBAU11jw+TOh6wKqxlGllzj59q6g4SrzqugjW2WUDw2hKKATNxY9WRz
         Sxtl6fnbNLwF0Ul/yd6kSWbPWay08w2lZxFTnyncVkmAmkImrRuSC5LAzV7q4aNl1DQv
         8wRcRtMMB6q3xCnoFK3NFYvvI5tfBXwyZ3YWC44H4jKBJ94yI+1Q+sJe2Hf8XMuuKmj9
         N1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679208329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgfIFgmkdg+6Ea9oqVXh/uKwgp5Rng4TUjK6rxHPpa8=;
        b=JolbMocAVp1dY7Ol79SfXckKObsjYoOsR+Tk4peeiTzjJhiNf8Aez8sEQYiIoNgiRz
         oCVaF6au8vQMmLf77BXCcI/9DUbwajikPdMhCNmW1BwpfgLKMhqP5ArV4kZfDUlq7l5d
         /kJXGsOuk2YP43ayT8Ak77xGvYE3eqpWAQKcOknXnKCfml1pPsl5s7GRN2xTuaZGWvrt
         qfr3fOHWM7fBkBwpyl+yYM62ZQJT1xgW8bI8apMsdV6fBdxTc/+oZsGuTfLKh2vR130A
         NdDidxcrvlIkmXt2+ArUSanUTJoJqER3S6Bnd3qjRYfxzGKXg3+LryeqWuDhsUOSGmIy
         jgwQ==
X-Gm-Message-State: AO0yUKVxfcD9Ilip/mU6htZEazh5u2xO3rkPcRGW5Zn8Hv4OUpZWUSHm
        hRUCmiczj8fe7vi5ryXcCVF2Q0t88cPmqricsEUfBesMltFpz2XF
X-Google-Smtp-Source: AK7set+msSL5DdAu73TXVQo/flGB6JHshcrq4aO/ycWaetClq0imYjfYeNss9rjuH7J8jMR5Jhwh4pShPBTM+T3bsbk=
X-Received: by 2002:a50:bb49:0:b0:4af:70a5:5609 with SMTP id
 y67-20020a50bb49000000b004af70a55609mr4317111ede.1.1679208328991; Sat, 18 Mar
 2023 23:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
 <20230312200731.599706-1-masahiroy@kernel.org> <20230319011217.147183-1-steev@kali.org>
 <CAK7LNATrzAWiu36=-JXXjSt48O12OAQG4ZAtLABd_PyiE2f_VQ@mail.gmail.com> <CAKXuJqjWORL0GmyOg9_NFUCjUH3Jd7yrNbTYpnQiTk7AptMZMw@mail.gmail.com>
In-Reply-To: <CAKXuJqjWORL0GmyOg9_NFUCjUH3Jd7yrNbTYpnQiTk7AptMZMw@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Sun, 19 Mar 2023 01:45:17 -0500
Message-ID: <CAKXuJqgJKgMLgRJTxQhhYNdNUb1PC2mbe1-gQcn4SD=2Ah_few@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, Mar 18, 2023 at 10:21=E2=80=AFPM Steev Klimaszewski <steev@kali.org=
> wrote:
>
> Hi Masahiro,
>
> On Sat, Mar 18, 2023 at 9:19=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Sun, Mar 19, 2023 at 10:12=E2=80=AFAM Steev Klimaszewski <steev@kali=
.org> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Sun, Mar 12, 2023 at 1:07=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > This series fixes some bugs, then switch to 'git archive'
> > > > for source package creation as suggested by Linus.
> > >
> > > I apologize if this is a stupid question, but it's not immediately ap=
parent to
> > > me...
> > >
> > > Previously, I was overriding the deb file output name by the setting =
of
> > > LOCALVERSION_AUTO; but with this series applied, that seems to be ign=
ored?
> > >
> > > Now if I pass LOCALVERSION=3D"" I end up with e.g. linux-image-6.3.0-=
rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
> > > whereas previously, I would end up with linux-image-6.3.0-rc2_6.3.0-r=
c2-100_arm64.deb
> > >
> > > How would I restore the old naming behaviour?
> > >
> > > -- steev
> >
> > The same string "6.3.0-rc2" is repeated in the file name.
> > The first one is what Debian calls the ABI version, and the
> > second one is the version of the package.
> > They are usually different on real Debian kernels.
> >
> > LOCALVERSION affects the former, and KDEB_PKGVERSION
> > the second.
> >
> >
> > My recommendation is "just let it be"
> > because "linux-upstream_6.3.0-rc2.orig.tar.gz"
> > you would generate is not the real 6.3.0-rc2.
> >
> >
> > If you want to restore what you previously did,
> >
> >  make deb-pkg KDEB_PKGVERSION=3D6.3.0-rc2-100
> >
> > will create such a file name.
> >
> My apologies, my text editor seemed to swallow up half of my previous
> email as what I was trying to say wasn't all in there...
> What I meant to say is that, prior to this patchset, if
> LOCALVERSION_AUTO=3Dy we would end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
>
> where
> LOCALVERSION_AUTO=3D"00575-g46c71cad996d"
> NUMBEROFBUILDS=3D"100" (i'm not sure where this number was stored previou=
sly)
>
> Assuming the above 2 are what the current settings are...
>
> And if you turned LOCALVERSION_AUTO off, and had changes on top of the
> git repo, you would end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2+-100_arm64.deb
>
> Then if you would pass LOCALVERSION=3D"", on top of LOCALVERSION_AUTO
> being unset, you would end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2-100_arm64.deb
>
> Now with your patchset applied, with LOCALVERSION_AUTO being unset,
> you end up with
>
> linux-image-6.3.0-rc2_6.3.0-rc2-00575-g46c71cad996d-100_arm64.deb
>
> Which means that LOCALVERSION_AUTO goes away?  I'm not sure why the
> package version overrides what I'm trying to set in the first place in
> the kernel config?
>
> Your workaround is mostly fine, but that "-100" on the end means I
> have to now personally track how many builds I've done?
>
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada

I've been trying for a while now to reproduce the previous behaviour
of version numbers and with this change in, it just does not seem
possible at all.  If I try to put any variables into KDEB_PKGVERSION,
it simply ignores then and sets it to what LOCALVERSION_AUTO would be.

-- steev
