Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE136A453D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjB0Oxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjB0Oxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:53:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43202D68
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB21560E93
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E837C433EF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677509614;
        bh=0lN5EsFS4Z43QWCOm8PH0Gme3FklyxWrPvTiom0uooY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e18/amcKy3OgJM0Meg0xDs2caSpLopqOWH+g3aaDd0GjYu53VGXYypHpwl48KhsNP
         S2u69ttVMqZF8DrD1rPAVWlo77/lqsE0B0WkhIIQoR985Xi/saiViUUcpGN12ul6u7
         HYOUfa0nOU4TLnJC/lRWOrvPGNh9usVmC3GxPx7SQZkR4sjaK0iPAvPqEFUUpIehoV
         g1OFPBBhPmNzpEH+wvrOAw2GaDE32+jrtenlGv1De3qxTCmUOmfsdwSrLbjqSYV2JI
         cBc/sEEgjdjhyYmWAbnThWwgZLp9tcbmSojAQp4zJs7ki8hzbpIruUSaGCE15ZLgvn
         bDBQ56fVQHe4Q==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-17264e9b575so7595153fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:53:34 -0800 (PST)
X-Gm-Message-State: AO0yUKVIa91Gv8oAAtwVh1r+pooyCNcI0RTI4RR8J++3kIhXykIs/z/p
        N9YJzWTMW4LRSfYNncoECEUcd7y9DcOCcyoVZw8=
X-Google-Smtp-Source: AK7set/NVjV8VhNgmRpsrBUvYw9qLM/PZeyY0U/xCGpQga47xbQ0EpxcFRu4UYzfMupW0aqHoPBN0jhZGYl1W6E434E=
X-Received: by 2002:a05:6870:c7ab:b0:172:3d66:734b with SMTP id
 dy43-20020a056870c7ab00b001723d66734bmr3634638oab.8.1677509613546; Mon, 27
 Feb 2023 06:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
 <Y/twXr2IOM4Dua8J@bill-the-cat> <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
 <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com>
 <CAK7LNAQpyjAVVES8dggiqcZNep1C0xkMob7HsBP4eS1jkOQbig@mail.gmail.com> <CAPnjgZ2aWXjKVJdx+vCX9=rROsSoXqQzxF25+DVv97bdR3zA9w@mail.gmail.com>
In-Reply-To: <CAPnjgZ2aWXjKVJdx+vCX9=rROsSoXqQzxF25+DVv97bdR3zA9w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Feb 2023 23:52:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR9JkUquhNLHygOn=kAjQZerL3iTz7jRawSJd6R9WCtUA@mail.gmail.com>
Message-ID: <CAK7LNAR9JkUquhNLHygOn=kAjQZerL3iTz7jRawSJd6R9WCtUA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     Simon Glass <sjg@chromium.org>
Cc:     Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
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

Hi Simon,

On Mon, Feb 27, 2023 at 1:00=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Masahiro,
>
> On Sun, 26 Feb 2023 at 20:36, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > Hi Simon,
> >
> > On Mon, Feb 27, 2023 at 4:23=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Sun, 26 Feb 2023 at 10:36, Masahiro Yamada <masahiroy@kernel.org> =
wrote:
> > > >
> > > > On Sun, Feb 26, 2023 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> > > > > > On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > >
> > > > > > > Hi Masahiro,
> > > > > > >
> > > > > > > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > > > > > > >
> > > > > > > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@c=
hromium.org> wrote:
> > > > > > > > >
> > > > > > > > > +Masahiro Yamada
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > I do not know.
> > > > > > > > This seems a shorthand in Kconfig level.
> > > > > > > >
> > > > > > > >
> > > > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | w=
c
> > > > > > > >     540    1080   24872
> > > > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | w=
c
> > > > > > > >     163     326    7462
> > > > > > > >
> > > > > > > > If hundreds of duplications are not manageable,
> > > > > > > > go for it, but kconfig will be out-of-sync from the
> > > > > > > > upstream Kconfig.
> > > > > > >
> > > > > > > Yes that's right, it is a shorthand in Kconfig.
> > > > > > >
> > > > > > > The counts above understand the problem a little since quite =
a few
> > > > > > > CONFIG options without an SPL prefix are used in SPL. We don'=
t have
> > > > > > > tools to estimate how many, and we sometimes add a new symbol=
 to 'gain
> > > > > > > control' of a particular feature in a phase.
> > > > > > >
> > > > > > > My intent in sending this patch was to check whether this sup=
port for
> > > > > > > configuring multiple related builds (or something like it) co=
uld go
> > > > > > > upstream, which for Kconfig is Linux, I believe. What do you =
think?
> > > > > >
> > > > > >
> > > > > > This complexity is absolutely unneeded for Linux.
> > > > > >
> > > > > > So, the answer is no.
> > > > >
> > > > > Well, I think Simon summarized himself a bit shorter here than he=
 did in
> > > > > the patch itself.  So, to what extent does the kernel want to con=
sider
> > > > > all of the other projects using the Kconfig language and their ne=
eds /
> > > > > use cases?
> > > > >
> > > > > --
> > > > > Tom
> > > >
> > > >
> > > >
> > > > In principle, only features that are useful for Linux.
> > >
> > > I'm disappointed in this attitude. It is the same thing that we saw
> > > from the DT bindings until recently.
> >
> >
> > Sorry, but this is the maintainer's job.
> > Saying no is one of the most important jobs as a maintainer.
> >
> > I must avoid Kconfig getting Frankenstein mechanisms.
>
> Can you suggest a better approach?


No, I can't.

Kconfig is a configuration system of the Linux kernel, which is monolithic.
It was not designed with multi-phase images in mind.


Presumably, Kconfig is good for U-Boot proper, but not for SPL/TPL given
the limited memory. There is little room for user's configuration anyway.

U-Boot extended SPL too much.
On-chip RAM is not supposed to run DT, DM, FIT.
With SPL kept simple and ad-hoc, none of
CONFIG_SPL_OF_CONTROL, SPL_DM, SPL_FIT was unneeded.
"bootph-*" properties were unneeded either.

This is a U-Boot-specific problem.
Please solve it in U-Boot.


Masahiro Yamada






>
> > > >
> > > > Kconfig has small piece of code that is useful for other projects,
> > > > for example,
> > > >
> > > >     #ifndef CONFIG_
> > > >     #define CONFIG_ "CONFIG_"
> > > >     #endif
> > > >
> > > > which might be useful for Buildroot, but this is exceptionally smal=
l.
> > >
> > > How about refactoring patches that would make a possible
> > > implementation easier to maintain, like [1] ? Would they be
> > > acceptable?
> >
> >
> > Code refactoring is welcome, but [1] is not applicable.
> > U-Boot kconfig is synced with Linux 4.20, way behind the mainline Linux=
.
>
> Sure, I wasn't suggesting that exact patch. It should be easy enough
> to move to the latest version. It sounds like it may be possible to
> make the Frankenstein patches easier to maintain out of tree, if we go
> that way.
>
> > > >
> > > >
> > > > The multi-phase is too cluttered, and that is not what Linux wants =
to have.
> > >
> > > Clearly it is not useful to Linux, which only has one build.
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.1=
134219-61-sjg@chromium.org/
>
> Regards,
> Simon


--
Best Regards
Masahiro Yamada
