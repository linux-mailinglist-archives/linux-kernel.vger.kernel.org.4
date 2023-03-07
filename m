Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC826ADD14
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCGLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCGLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:14:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231129752;
        Tue,  7 Mar 2023 03:13:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4088FB816E6;
        Tue,  7 Mar 2023 11:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DDBC433A0;
        Tue,  7 Mar 2023 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678187566;
        bh=rbH08/UUbzVSBYs19ucvRbJ7Qgbnl+5ddRv+Wb6XVGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FKsw9na9G0eDVPJNv3f78W4UwXmkI/9CDIhPy+QOfpQNdY44yQmOW2DBAD/f9LQxb
         XDh20nMOXC7yw/v6UN0Y23gPux75pscrnS6vp2jABkg0VN4IjgLUytQu0ZXi4IQXSl
         DXaZmFmxV7SBW1cFievYPe/pOUGjDbZqyYyLZlvETY5bow0TOb1CvVvaudUr3nww9b
         AexRZsjuzzExycHgTZxDCvzpWXnbcX4/jy7SIBsNcBjp1CO1Fx54TuQcFJysAjEfvn
         DbKIysw8QMUBXoSRzzFzEYqtYyr1m89JxJHyYWVY2PFPJNvMSrk+ycSfxDd2MiXXxO
         1bxiw79YF4WRw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-176261d7f45so14633798fac.11;
        Tue, 07 Mar 2023 03:12:45 -0800 (PST)
X-Gm-Message-State: AO0yUKVpApjYoB891W+xexhcVnKeZlatz+PD9bCeLFuMFeUp607gTCcm
        Iw510Q/1z7VYD6Ei5378owQSsXP6NQ9e7+MldN4=
X-Google-Smtp-Source: AK7set/6JSfK7GwFuJjUV25EpjB4TkkNYQxeH5ahN3O1e3HghtChRt5g7GX2i238uCdPDBqVzwblwu2ucQU/s8OvNCQ=
X-Received: by 2002:a05:6870:5b01:b0:176:4416:eeff with SMTP id
 ds1-20020a0568705b0100b001764416eeffmr3922582oab.8.1678187565187; Tue, 07 Mar
 2023 03:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20230305232536.19528-1-bage@linutronix.de> <20230305232536.19528-2-bage@linutronix.de>
 <CAK7LNARnkOyusNFZsE9Hj9cg=TWJtv1By8e4UPCso92Wn=jgEQ@mail.gmail.com> <a92721ac-4b8a-10a8-fc12-1618dbf69653@linutronix.de>
In-Reply-To: <a92721ac-4b8a-10a8-fc12-1618dbf69653@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 7 Mar 2023 20:12:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjiAB93mu0igQsiwgu=zrgu3gArMJZ+6CXHuJ+kG_ELg@mail.gmail.com>
Message-ID: <CAK7LNASjiAB93mu0igQsiwgu=zrgu3gArMJZ+6CXHuJ+kG_ELg@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: default dpkg-buildpackage --build
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:44=E2=80=AFPM Bastian Germann <bage@linutronix.de>=
 wrote:
>
> Am 07.03.23 um 04:21 schrieb Masahiro Yamada:
> > On Mon, Mar 6, 2023 at 8:25=E2=80=AFAM Bastian Germann <bage@linutronix=
.de> wrote:
> >>
> >> deb-pkg's dpkg-buildpackage invocation was added --build=3Dsource,bina=
ry
> >> recently. Before, it relied on the default, which is
> >> --build=3Dsource,binary,all and makes no difference for the built pack=
ages
> >> as there is no "Arch: all" package.
> >
> >
> > Is this paragraph true?
> >
> > --build=3Dsource,binary,all sounds strange because
> > 'all' is contained in 'binary'.
> >
> >
> >
> > According to dpkb-buildpackage(1),
> >
> >   binary =3D any,all
> >
> >   full =3D source,binary =3D source,any,all  (default)
> >
> >
> > --build=3Dsource,binary would build everything
> > even if there were 'Arch: all'.
>
> You are right. The point was that it does not change the output.
>


How do you want to rephrase this?




--=20
Best Regards
Masahiro Yamada
