Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830116F3E14
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjEBHEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjEBHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:04:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60213170A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:04:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so6251229a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1683011051; x=1685603051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7CQXDkwoowND2m6nRMECIol5dyfAR/h73O7TZ21l3M=;
        b=VgG/P5FAAd+6svo7p4jPDlu7DiQ/k645BvLb7KRJ57zT/pCp00CEw0iaDHJ1zgcK5s
         Gbr6jCqPl8cwuI3BNFj72n+njSXmYRho5GLil2z0WpXlS/vspmCnlbjVmZv4ngE5gM3p
         PokkSAN52ERJD1tcIJ/1h3moLbDZOpHwcU9ZzjR5LxitMKg+9VF3vUcFBZe6PibSVHMX
         o1CD3Q4DNyNLOiJv8heIcyb8ta2PoqNIyAFCr0uY/WNfy1R4+KbgcsPgFY7JiOaPHvaS
         0AlYnE13LaadDmBJ/LwbKlG2RKXDuvn4F4s5oGft3ez2LMT90Ol4ZtzaPkJj+6bt5S/6
         xlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683011051; x=1685603051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7CQXDkwoowND2m6nRMECIol5dyfAR/h73O7TZ21l3M=;
        b=DymYibQg1i2Mwf6HNFtC9wOwV7C1ldlSIztMT9mcwrsZ8f4Tw/wPPef25Be/dIxyT8
         qulZq7v5aX6CWLrcdeKNY+cLCPp22LPy1AG+tzNjxkJWogu78Ddy67VmgonPFhZKRKpn
         E3GIYof7YK5r17gbD0CbCKa9ZgQ54QwF9Lxm8FuPzvbV/yExzSb6ZwOvaseQAnmDqmXh
         hhMT3CpnZB8H9G+Udyea6MNHFtF9HKFhxxd0BIA/thuaYpB384pLZ8KU5IqVUnte1fPC
         x/1rHdNSJk0IfjybLU8QKEUPgVM4PLex3FgkmLEvW9cuquyvEfG28WeEGblpZw9xy1FO
         rFYQ==
X-Gm-Message-State: AC+VfDzuNqesZ5QpaC4iuF4Cztms8/OvNnVxh36376FPHO6cS4bJOSTg
        ZFWFoGJpfBFVS/iDCg9lMs2KoI+xGLoc2k097FvGjQ==
X-Google-Smtp-Source: ACHHUZ6PxvhOwj3+3FqLOiM5HUopTbzkpm1TAKW7GrRJaC/1TpbK6FubQ4i1c96XJiFhAT/BERbrI3bFo0VsqNcupzA=
X-Received: by 2002:aa7:c51a:0:b0:506:9ece:60cb with SMTP id
 o26-20020aa7c51a000000b005069ece60cbmr7180092edq.38.1683011050658; Tue, 02
 May 2023 00:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <87ednz7roh.fsf@all.your.base.are.belong.to.us> <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
In-Reply-To: <7DD2C38C-CBB3-41EE-A195-50E4C2451B7E@jrtc27.com>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Tue, 2 May 2023 09:03:59 +0200
Message-ID: <CAAeLtUADqnwrgBjhDd+iNfwhMU6YBiMUZzeopVMAh0Jq19W9JA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kito Cheng <kito.cheng@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Greentime Hu <greentime.hu@sifive.com>, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2023 at 22:08, Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 1 May 2023, at 20:55, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrote:
> >
> > Heiko Stuebner <heiko@sntech.de> writes:
> >
> >> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >>
> >> The hwprobing infrastructure was merged recently [0] and contains a
> >> mechanism to probe both extensions but also microarchitecural features
> >> on a per-core level of detail.
> >>
> >> While discussing the solution internally we identified some possible i=
ssues,
> >> tried to understand the underlying issue and come up with a solution f=
or it.
> >> All these deliberations overlapped with hwprobing being merged, but th=
at
> >> shouldn't really be an issue, as both have their usability - see below=
.
> >> Also please see the "Things to consider" at the bottom!
> >>
> >>
> >> Possible issues:
> >> - very much limited to Linux
> >> - schedulers run processes on all cores by default, so will need
> >>  the common set of extensions in most cases
> >
> > ...which hwprobe has support for via the CPU mask. no?
> >
> >> - each new extensions requires an uapi change, requiring at least
> >>  two pieces of software to be changed
> >> - adding another extension requires a review process (only known
> >>  extensions can be exposed to user-space)
> >> - vendor extensions have special needs and therefore possibly
> >>  don=E2=80=99t fit well
> >>
> >>
> >> Limited to Linux:
> >> -----------------
> >>
> >> The syscall and its uapi is Linux-specific and other OSes probably
> >> will not defer to our review process and requirements just to get
> >> new bits in. Instead most likely they'll build their own systems,
> >> leading to fragmentation.
> >
> > There are a number of examples where multiple OSs have followed what
> > Linux does, and vice versa. I'd say the opposite -- today system
> > builders do not do their own solution, but review what's out there and
> > mimics existing ones.
>
> Where they can. But if the interface is =E2=80=9Cmake architecture-depend=
ent
> syscall X=E2=80=9D that=E2=80=99s not going to fly on other OSes where sy=
scalls are not
> architecture-dependent. Similarly if it=E2=80=99s =E2=80=9Cgo read auxarg=
 Y=E2=80=9D where Y is
> architecture-dependent and the OS in question has
> architecture-independent auxargs. Or the system doesn=E2=80=99t even have
> auxargs. Now, at the end of the day, I couldn=E2=80=99t care less what Li=
nux
> does to communicate the information to userspace, what matters is what
> the userspace interface is that random IFUNCs are going to make use of.
> Something which seems to be woefully lacking from this discussion. Is
> the interface going to just be syscall(2)? Or is there going to be some
> higher-level interface that other OSes *do* have a hope of being able
> to implement?
>
> > Personally I think this argument is moot, and will not matter much for
> > fragmentation.
> >
> >> Feature on all cores:
> >> ---------------------
> >>
> >> Arnd previously ([1]) commented in the discussion, that there
> >> should not be a need for optimization towards hardware with an
> >> asymmetric set of features. We believe so as well, especially
> >> when talking about an interface that helps processes to identify
> >> the optimized routines they can execute.
> >>
> >> Of course seeing it with this finality might not take into account
> >> the somewhat special nature of RISC-V, but nevertheless it describes
> >> the common case for programs very well.
> >>
> >> For starters the scheduler in its default behaviour, will try to use a=
ny
> >> available core, so the standard program behaviour will always need the
> >> intersection of available extensions over all cores.
> >>
> >>
> >> Limiting program execution to specific cores will likely always be a
> >> special use case and already requires Linux-specific syscalls to
> >> select the set of cores.
> >>
> >> So while it can come in handy to get per-core information down the roa=
d
> >> via the hwprobing interface, most programs will just want to know if
> >> they can use a extension on just any core.
> >>
> >>
> >> Review process:
> >> ---------------
> >>
> >> There are so many (multi-letter-)extensions already with even more in
> >> the pipeline. To expose all of them, each will require a review proces=
s
> >> and uapi change that will make defining all of them slow as the
> >> kernel needs patching after which userspace needs to sync in the new
> >> api header.
> >>
> >>
> >> Vendor-extensions:
> >> ------------------
> >>
> >> Vendor extensions are special in their own right.
> >> Userspace probably will want to know about them, but we as the kernel
> >> don't want to care about them too much (except as errata), as they're
> >> not part of the official RISC-V ISA spec.
> >>
> >> Getting vendor extensions from the dt to userspace via hwprobe would
> >> require coordination efforts and as vendors have the tendency to inven=
t
> >> things during their development process before trying to submit change=
s
> >> upstream this likely would result in conflicts with assigned ids down
> >> the road. Which in turn then may create compatibility-issues with
> >> userspace builds built on top of the mainline kernel or a pre-
> >> existing vendor kernel.
> >>
> >> The special case also is that vendor A could in theory implement an
> >> extension from vendor B. So this would require to actually assign
> >> separate hwprobe keys to vendors (key for xthead extensions, key for
> >> xventana extensions, etc). This in turn would require vendors to
> >> come to the mainline kernel to get assigned a key (which in reality
> >> probably won't happen), which would then make the kernel community
> >> sort of an id authority.
> >>
> >>
> >>
> >>
> >> To address these, the attached patch series adds a second interface
> >> for the common case and "just" exposes the isa-string via the
> >> AT_BASE_PLATFORM aux vector.
> >
> > *A second interface* introduced the second hwprobe landed. Really?
> > Start a discussion on how to extend hwprobe instead.
>
> I=E2=80=99ve been trying to push for something other than this for months=
, but
> RVI took no interest in dealing with it until it got closer to these
> landing, at which point finally some action was taken. But even then,
> heels were dragged, and it took hwprobe being landed to force them to
> finally publish things. But of course too late, so now the ecosystem is
> forever screwed thanks to their inaction.

I am similarly frustrated as I had been asking for a universally
acceptable solution since August 2021 (and Kito gave a presentation on
the issue at LPC21) that was meant to avoid system calls; however, the
design of hwprobe has happened outside of RVI and without getting RVI
involved to drive coordination between members.

The bottleneck (in cases like this one) at RVI is that it is
volunteer-driven and dependent on the buy-in of its membership: there
are no technical resources except for us company delegates.  If
members decide to work a gap without involving RVI, then the chances
of fragmentation are high.  Nothing we can do about that, as RVI is
not a traffic cop.

> All I wanted was some simple extension string -> version number function
> as a standardised userspace interface... because at the end of the day
> people just want to know =E2=80=9Ccan I use extension Y?=E2=80=9D, possib=
ly with a
> minimum version. But maybe there=E2=80=99s some hope that Linux libcs wil=
l
> translate such queries into poking at this hwprobe thing. Though god
> knows what they=E2=80=99re going to do about vendor extensions, especiall=
y if
> those vendor extensions only get supported in vendor forks of the
> kernel (who=E2=80=99s allocating their encodings? Xvendorfoo exists to
> namespace them and give vendors control...).

The support for vendor extensions without a central registry remains
the strongest reason for a different interface, as RISC-V has the
flexibility to add vendor extensions as one of its strongest selling
points.

It is a pity that the current interface was designed without involving
RVI (and that I had to ask my team to put together a patch set for
further discussion, given that none of the other major vendors in RVI
stepped forward).  I guarantee that plenty of reviewers would have
highlighted that a central registry (even if it is just a kernel
header) should be avoided.

So what is the best way to support vendor-defined/vendor-specific
extensions without a central registry?

Philipp.
