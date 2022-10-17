Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441B56006BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJQGbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJQGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:31:10 -0400
X-Greylist: delayed 664 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Oct 2022 23:31:06 PDT
Received: from forward103p.mail.yandex.net (forward103p.mail.yandex.net [77.88.28.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2273F520AF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:31:05 -0700 (PDT)
Received: from forward502p.mail.yandex.net (forward502p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:121])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 32AE45A3021;
        Mon, 17 Oct 2022 09:19:57 +0300 (MSK)
Received: from sas1-384d3eaa6677.qloud-c.yandex.net (sas1-384d3eaa6677.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3a29:0:640:384d:3eaa])
        by forward502p.mail.yandex.net (Yandex) with ESMTP id BC2B7B8139E;
        Mon, 17 Oct 2022 09:19:52 +0300 (MSK)
Received: by sas1-384d3eaa6677.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id l9nt5C04sF-JnjOhNs4;
        Mon, 17 Oct 2022 09:19:51 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1665987591;
        bh=ZlVETtAdMTCrWUZ9/ku01uEirmMFNR/BEDj83BCtnQA=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=ABoFTlejDyTprn0uGW1gdDPaiV+QrUfa+XBioAwb5QRHIVsbyno9+AKrc7cdSxCtJ
         Ua2lpFfkl+++N+7nfWu5AntK1DaK64LiVjtYCl7CRHd5NdsTHnwbtHkQWl6nzN5n2C
         WyK5KflsRayUPFC8lQqQOeVTiJv5hIjBhyOkMtaY=
Authentication-Results: sas1-384d3eaa6677.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Mon, 17 Oct 2022 09:19:48 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, linux@yadro.com, anup@brainfault.org,
        n.shubin@yadro.com, aou@eecs.berkeley.edu,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, namhyung@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, peterz@infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v6 0/3] RISC-V: Create unique identification for SoC PMU
Message-ID: <20221017091948.1961294e@redslave.neermore.group>
In-Reply-To: <mhng-a8eaa55b-16b0-4b17-b202-881e75a65eaf@palmer-ri-x1c9>
References: <20220815132251.25702-1-nikita.shubin@maquefel.me>
        <mhng-a8eaa55b-16b0-4b17-b202-881e75a65eaf@palmer-ri-x1c9>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo!

On Mon, 03 Oct 2022 19:54:40 -0700 (PDT)
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> On Mon, 15 Aug 2022 06:22:37 PDT (-0700), nikita.shubin@maquefel.me
> wrote:
> > From: Nikita Shubin <n.shubin@yadro.com>
> >
> > This series aims to provide matching vendor SoC with corresponded
> > JSON bindings.
> >
> > The ID string is proposed to be in form of
> > MVENDORID-MARCHID-MIMPID, for example for Sifive Unmatched the
> > corresponding string will be:
> >
> > 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> >
> > Where MIMPID can vary as all impl supported the same number of
> > events, this might not be true for all future SoC however.
> >
> > Also added SBI firmware events pretty names, as any firmware that
> > supports SBI PMU should also support firmare events [1].
> >
> > Series depends on patch by Anup Patel, exposing mvendor, marchid
> > and mimpid to "/proc/cpuinfo" [2].
> >
> > [1]
> > https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.ad=
oc
> > [2] https://lkml.org/lkml/2022/7/27/23
> >
> > Link to previous version:
> > https://patchwork.kernel.org/project/linux-riscv/list/?series=3D653649
> >
> > See original cover letter by Jo=C3=A3o M=C3=A1rio Domingos:
> > https://patchwork.kernel.org/project/linux-riscv/cover/20211116154812.1=
7008-1-joao.mario@tecnico.ulisboa.pt/
> >
> > Tested with the following OpenSBI device tree bindings:
> >
> > ```
> > pmu {
> >         compatible =3D "riscv,pmu";
> >         riscv,event-to-mhpmcounters =3D
> >                 <0x03 0x06 0x18
> >                 0x10001 0x10002 0x18
> >                 0x10009 0x10009 0x18
> >                 0x10011 0x10011 0x18
> >                 0x10019 0x10019 0x18
> >                 0x10021 0x10021 0x18>;
> >         riscv,event-to-mhpmevent =3D
> >                 <0x03 0x00000000 0x1801
> >                 0x04 0x00000000 0x0302
> >                 0x05 0x00000000 0x4000
> >                 0x06 0x00000000 0x6001
> >                 0x10001 0x00000000 0x0202
> >                 0x10002 0x00000000 0x0402
> >                 0x10009 0x00000000 0x0102
> >                 0x10011 0x00000000 0x2002
> >                 0x10019 0x00000000 0x1002
> >                 0x10021 0x00000000 0x0802>;
> >         riscv,raw-event-to-mhpmcounters =3D
> >                 <0x00000000 0x03ffff00 0x0 0x0 0x18
> >                 0x00000000 0x0007ff01 0x0 0x1 0x18
> >                 0x00000000 0x00003f02 0x0 0x2 0x18>;
> > };
> > ```
> > ---
> > v5->v6:
> > Will Deacon:
> > 	- dropped first patch from v5 series it has been merged
> > into master Mayuresh Chitale:
> > 	- fixed FW_SFENCE_VMA_SENT event code
> >
> > - added Tested-by tags
> > ---
> >
> > Nikita Shubin (3):
> >   perf arch events: riscv sbi firmware std event files
> >   perf vendor events riscv: add Sifive U74 JSON file
> >   RISC-V: Added Syntacore SCR7 PMU events
> >
> >  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  18 +++
> >  .../arch/riscv/riscv-sbi-firmware.json        | 134
> > ++++++++++++++++++ .../arch/riscv/sifive/u74/firmware.json       |
> > 68 +++++++++ .../arch/riscv/sifive/u74/instructions.json   |  92
> > ++++++++++++ .../arch/riscv/sifive/u74/memory.json         |  32
> > +++++ .../arch/riscv/sifive/u74/microarch.json      |  57 ++++++++
> >  .../arch/riscv/syntacore/scr7/L1D_cache.json  | 102 +++++++++++++
> >  .../arch/riscv/syntacore/scr7/L1I_cache.json  |  67 +++++++++
> >  .../arch/riscv/syntacore/scr7/exceptions.json |  67 +++++++++
> >  .../arch/riscv/syntacore/scr7/execution.json  |  97 +++++++++++++
> >  .../arch/riscv/syntacore/scr7/firmware.json   |  68 +++++++++
> >  .../arch/riscv/syntacore/scr7/general.json    |  47 ++++++
> >  .../arch/riscv/syntacore/scr7/interrupts.json |  32 +++++
> >  .../arch/riscv/syntacore/scr7/prediction.json |  52 +++++++
> >  14 files changed, 933 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
> >  create mode 100644
> > tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json create
> > mode 100644
> > tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json create
> > mode 100644
> > tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json create mode
> > 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/L1D_cache.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/L1I_cache.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/exceptions.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/execution.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/firmware.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/general.json create
> > mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/interrupts.json
> > create mode 100644
> > tools/perf/pmu-events/arch/riscv/syntacore/scr7/prediction.json =20
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> not sure if you're looking for this via the RISC-V tree, it looks
> like usually these get merged via a perf tree?  That's OK with me,
> but I'm also OK taking them through the RISC-V tree.  Note that
> cpuinfo dependency seems to be triggering kasan failures, so we'll at
> least need to sort that out.

As i remember correctly you were willing to take these patches into 6.0
=3D).

Well they are acked by Palmer and [2] series, which my series depends
on, also have been accepted.

I can resend if it helps you.

Yours,=20
Nikita Shubin.

