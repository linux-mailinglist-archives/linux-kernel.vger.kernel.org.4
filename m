Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7E6F1E33
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbjD1StE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjD1StC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:49:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F4270A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:49:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so71994045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1682707739; x=1685299739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkqGBL9jgd8E/TkAa9LJeO4lnz2EPzONl08rXXkheFk=;
        b=nus2tgnYFSaySymTyJH36pgJDYFCB8VyMuNqLrFRFaVeQTk+TMRA1zjb4CUodtUm01
         oD4XHDVDT/vJV2YulXStXc+LB/GoOvM3Xt3X/F7PT1TKJqBejgHY5JmWm27RTPNUL+zN
         Al729RSPwWHeL2vsSG+rmcPEPD+uXhDdxgpyuOO6n8Y+7dyRmmixM6XkaYXznyQVnvvs
         y3glnJjyX9zrzH8NyZoIYyTK20crqfzVtb2Fkl2BPRT+VK9F66aNGjLWerNq+g3rD/bf
         nKh87Phd4uLG9R/AeNX1lPHfKKAB9gHzC6gyxKwDwtyEJ8frYZKV+8m38ZkpHmQlWhgj
         xbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707739; x=1685299739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkqGBL9jgd8E/TkAa9LJeO4lnz2EPzONl08rXXkheFk=;
        b=Jr4bMcUpS0VX0UsGSFSvaHcGPnRuFUGq7z1+6zvro0Ndb0v9TNpDTboIZ4WAz8HCfb
         HDB6Yramu3la4leCYC1WZIoak/+Cu6SH8hEvG2e20BE8i9lszi+g2dTj0zX8ihNHXQsQ
         /Yeaxh5RrsemU0LgcG9Em9IwxbnVbYDVLe28rhLp53KuZg51RN6BSnMoyWDyhL21qYyo
         ZpMlqP8xYlZYYaHXyyTbn1AAr2r+xFvyiA2+A7hCzFo573fe50gRDzXQUr8cb6goXheA
         nMN1oZpRuNMH95FM9H3W6iUK1m6vpPLQbpTmlbPbtchd9BZSigdZ08gxGdixhsZfzcad
         SrTQ==
X-Gm-Message-State: AC+VfDwGXkCNRBEhlhC2IzR2TKwi3G3cPobyn73nwU2mEg8xDwCkv0LC
        yDjWWRwu5FYfARFQYpPy8UjnHedd/o4RrA82UTmxGw==
X-Google-Smtp-Source: ACHHUZ7Nvml7F2mo+RBRVyQW+3kneqpwZy/z0s9aQcMbsehXYxnmP23hDWVu/NuhQ4ueNETx/8yomx5Iwq7ZRbD1/fw=
X-Received: by 2002:a05:600c:474e:b0:3f1:7510:62e8 with SMTP id
 w14-20020a05600c474e00b003f1751062e8mr7756611wmo.3.1682707738817; Fri, 28 Apr
 2023 11:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu> <mhng-51ee6a97-de3e-4b25-a506-5ffe245cde99@palmer-ri-x1c9>
In-Reply-To: <mhng-51ee6a97-de3e-4b25-a506-5ffe245cde99@palmer-ri-x1c9>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date:   Fri, 28 Apr 2023 20:48:47 +0200
Message-ID: <CAEg0e7gg5UuR6v8=S+UCJc5QCt=yTm7Gxgiwhv4A2hdezDJfsg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     heiko@sntech.de, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, jrtc27@jrtc27.com,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        philipp.tomsich@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        heiko.stuebner@vrull.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 4:57=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Mon, 24 Apr 2023 12:49:07 PDT (-0700), heiko@sntech.de wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> > The hwprobing infrastructure was merged recently [0] and contains a
> > mechanism to probe both extensions but also microarchitecural features
> > on a per-core level of detail.
> >
> > While discussing the solution internally we identified some possible is=
sues,
> > tried to understand the underlying issue and come up with a solution fo=
r it.
> > All these deliberations overlapped with hwprobing being merged, but tha=
t
> > shouldn't really be an issue, as both have their usability - see below.
> >
> > Also please see the "Things to consider" at the bottom!
> >
> >
> > Possible issues:
> > - very much limited to Linux
> > - schedulers run processes on all cores by default, so will need
> >   the common set of extensions in most cases
> > - each new extensions requires an uapi change, requiring at least
> >   two pieces of software to be changed
> > - adding another extension requires a review process (only known
> >   extensions can be exposed to user-space)
> > - vendor extensions have special needs and therefore possibly
> >   don=E2=80=99t fit well
> >
> >
> > Limited to Linux:
> > -----------------
> >
> > The syscall and its uapi is Linux-specific and other OSes probably
> > will not defer to our review process and requirements just to get
> > new bits in. Instead most likely they'll build their own systems,
> > leading to fragmentation.
> >
> >
> > Feature on all cores:
> > ---------------------
> >
> > Arnd previously ([1]) commented in the discussion, that there
> > should not be a need for optimization towards hardware with an
> > asymmetric set of features. We believe so as well, especially
> > when talking about an interface that helps processes to identify
> > the optimized routines they can execute.
> >
> > Of course seeing it with this finality might not take into account
> > the somewhat special nature of RISC-V, but nevertheless it describes
> > the common case for programs very well.
> >
> > For starters the scheduler in its default behaviour, will try to use an=
y
> > available core, so the standard program behaviour will always need the
> > intersection of available extensions over all cores.
> >
> >
> > Limiting program execution to specific cores will likely always be a
> > special use case and already requires Linux-specific syscalls to
> > select the set of cores.
> >
> > So while it can come in handy to get per-core information down the road
> > via the hwprobing interface, most programs will just want to know if
> > they can use a extension on just any core.
> >
> >
> > Review process:
> > ---------------
> >
> > There are so many (multi-letter-)extensions already with even more in
> > the pipeline. To expose all of them, each will require a review process
> > and uapi change that will make defining all of them slow as the
> > kernel needs patching after which userspace needs to sync in the new
> > api header.
>
> The whole reason we're doing hwprobe with bitmaps is beacuse the ISA
> strings are not a stable interface, and thus are not suitable for
> building uABI around.

The ISA string is the main description of the RISC-V ISA that a
system/core/hart implements. It is suitable and stable enough for all toolc=
hain
components (-march string, ELF header, etc.).
It is also used in the DTB that the kernel uses to identify available
extensions.
So it is reasonable to argue that it is good enough for all runtime compone=
nts.
Also, I don't see any evidence that users are affected by any stability iss=
ues
of the ISA strings in the interfaces where it is used at the moment.
Quite the opposite, users are expecting ISA string interfaces everywhere
because of existing interfaces.

Besides that, also the kernel stable ABI documentation allows changes:
  "Userspace programs are free to use these
  interfaces with no restrictions, and backward compatibility for
  them will be guaranteed for at least 2 years." [1]
I did not come across any issues in the RISC-V ISA string that would violat=
e
these requirements. Did you? Further, the vDSO is covered by the stable ABI
requirements, but not the auxiliary vector. This does not imply that an ISA
string interface in the aux vector does not have to be stable at all, but t=
here
is certainly enough room for any ISA extension errata that may pop up in th=
e
future. Other architectures can live with that risk as well.

BR
Christoph

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/ABI/README

>
> >
> >
> > Vendor-extensions:
> > ------------------
> >
> > Vendor extensions are special in their own right.
> > Userspace probably will want to know about them, but we as the kernel
> > don't want to care about them too much (except as errata), as they're
> > not part of the official RISC-V ISA spec.
> >
> > Getting vendor extensions from the dt to userspace via hwprobe would
> > require coordination efforts and as vendors have the tendency to invent
> > things during their development process before trying to submit changes
> > upstream this likely would result in conflicts with assigned ids down
> > the road. Which in turn then may create compatibility-issues with
> > userspace builds built on top of the mainline kernel or a pre-
> > existing vendor kernel.
> >
> > The special case also is that vendor A could in theory implement an
> > extension from vendor B. So this would require to actually assign
> > separate hwprobe keys to vendors (key for xthead extensions, key for
> > xventana extensions, etc). This in turn would require vendors to
> > come to the mainline kernel to get assigned a key (which in reality
> > probably won't happen), which would then make the kernel community
> > sort of an id authority.
> >
> >
> >
> >
> > To address these, the attached patch series adds a second interface
> > for the common case and "just" exposes the isa-string via the
> > AT_BASE_PLATFORM aux vector.
> >
> > In the total cost of program start, parsing the string does not create
> > too much overhead. The extension list in the kernel already contains
> > the extensions list limited to the ones available on all harts and
> > the string form allows us to just pipe through additional stuff too, as
> > can be seen in the example for T-Head extensions [2] .
> >
> > This of course does not handle the microarchitecture things that
> > the hwprobe syscall provides but allows a more generalized view
> > onto the available ISA extensions, so is not intended to replace
> > hwprobe, but to supplement it.
> >
> > AT_BASE_PLATFORM itself is somewhat well established, with PPC already
> > using it to also expose a platform-specific string that identifies
> > the platform in finer grain so this aux-vector field could in theory
> > be used by other OSes as well.
> >
> >
> > A random riscv64-qemu could for example provide:
> >     rv64imafdcvh_zicbom_zihintpause_zbb_sscofpmf_sstc_svpbmt
> >
> > where a d1-nezha provides:
> >     rv64imafdc_xtheadba_xtheadbb_xtheadbs_xtheadcmo_xtheadcondmov_xthea=
dfmemidx_xtheadint_xtheadmac_xtheadmemidx_xtheadmempair_xtheadsync
> >
> >
> > Things to still consider:
> > -------------------------
> >
> > Right now both hwprobe and this approach will only pass through
> > extensions the kernel actually knows about itself. This should not
> > necessarily be needed (but could be an optional feature for e.g. virtua=
lization).
> >
> > Most extensions don=E2=80=99t introduce new user-mode state that the ke=
rnel needs to manage (e.g. new registers). Extension that do introduce new =
user-mode state are usually disabled by default and have to be enabled by S=
 mode or M mode (e.g. FS[1:0] for the floating-point extension). So there s=
hould not be a reason to filter any extensions that are unknown.
> >
> > So it might make more sense to just pass through a curated list (common
> > set) created from the core's isa strings and remove state-handling
> > extensions when they are not enabled in the kernel-side (sort of
> > blacklisting extensions that need actual kernel support).
> >
> > However, this is a very related, but still independent discussion.
> >
> >
> > [0] https://lore.kernel.org/lkml/168191462224.22791.2281450562691381145=
.git-patchwork-notify@kernel.org/
> > [1] https://lore.kernel.org/all/605fb2fd-bda2-4922-92bf-e3e416d54398@ap=
p.fastmail.com/
> > [2] These are the T-Head extensions available in _upstream_ toolchains
> >
> > Heiko Stuebner (4):
> >   RISC-V: create ISA string separately - not as part of cpuinfo
> >   RISC-V: don't parse dt isa string to get rv32/rv64
> >   RISC-V: export the ISA string of the running machine in the aux vecto=
r
> >   RISC-V: add support for vendor-extensions via AT_BASE_PLATFORM and
> >     xthead
> >
> >  arch/riscv/errata/thead/errata.c     | 43 ++++++++++++
> >  arch/riscv/include/asm/alternative.h |  4 ++
> >  arch/riscv/include/asm/elf.h         | 10 +++
> >  arch/riscv/kernel/alternative.c      | 21 ++++++
> >  arch/riscv/kernel/cpu.c              | 98 +++++++++++++++++++++++++---
> >  5 files changed, 168 insertions(+), 8 deletions(-)
