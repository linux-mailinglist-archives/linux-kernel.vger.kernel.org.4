Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0826D58CD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjDDGfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDGfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742D1987;
        Mon,  3 Apr 2023 23:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3052262167;
        Tue,  4 Apr 2023 06:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D54C433AA;
        Tue,  4 Apr 2023 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680590134;
        bh=hQhK5X+FMKBgkJ1ZUpllN4QGFJfhK9B1pyMS9yscrY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rznEyMsz7HQcxNydcsNElmyjXY1YR+EX1OSCvdyQ2u/hwVUUoQI80Usj5EYmUpM0T
         KNhknkAfwderWUOD3szSLC5mkfN8AmWGsfqfHr4c5RkH2qFA3K6tVLXpG2o2+EVvhp
         Z+a1cTbOJePt4CDJduXkN0UNiVX1zrQ4ieh0A0TQXqGkHH1+ZFloMaqz0lBo9py1bd
         MlgvuPApj1DKLkJq4U/hdgdc8N59czLGvy/xCwCJCs0WDQzztpWCjwMMdwLkKOl0RH
         x97q25j/Y2z7ppWZ+dsuAX0A5OfEhhO4uAkFjFLtby03kQk7u+IXzayuQpdaQVXxBs
         TycYOncjg/RbQ==
Received: by mail-ed1-f42.google.com with SMTP id cn12so126321869edb.4;
        Mon, 03 Apr 2023 23:35:34 -0700 (PDT)
X-Gm-Message-State: AAQBX9cmCVWWJDfpOPcUUqEE920e+BLERMTk6Z0dLwpzJVK1NkoKCiOo
        oHLVnp+bua9l90eR2RaL71YREgt64lx9OWY9/2U=
X-Google-Smtp-Source: AKy350am7H/VQB4ZztsVmAqwJ6AuMYVKqkRGpW+k9TnAd7Y30s0+1JnJzKxMdbYUMePr1qS//qqrlzDzDdM171oTRug=
X-Received: by 2002:a50:aad2:0:b0:501:d3a2:b4ae with SMTP id
 r18-20020a50aad2000000b00501d3a2b4aemr788287edc.7.1680590132765; Mon, 03 Apr
 2023 23:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <16007014-c5f2-4b07-baec-e19952236aa5@spud> <ZAbGSA6F0kfv9YYw@sunil-laptop>
 <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org> <a9823561-2e32-49e8-b6c9-73e4b8f8cf8d@spud>
 <ZAfeaO52pnYhiyLN@sunil-laptop>
In-Reply-To: <ZAfeaO52pnYhiyLN@sunil-laptop>
From:   Ley Foon Tan <lftan@kernel.org>
Date:   Tue, 4 Apr 2023 14:35:19 +0800
X-Gmail-Original-Message-ID: <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
Message-ID: <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Conor Dooley <conor@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 9:08=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Tue, Mar 07, 2023 at 06:44:35PM +0000, Conor Dooley wrote:
> > On Tue, Mar 07, 2023 at 06:13:22AM +0000, Conor Dooley wrote:
> > >
> > >
> > > On 7 March 2023 05:06:16 GMT, Sunil V L <sunilvl@ventanamicro.com> wr=
ote:
> > > >On Mon, Mar 06, 2023 at 09:51:09PM +0000, Conor Dooley wrote:
> > > >> Hey Sunil,
> > > >>
> > > >> On Fri, Mar 03, 2023 at 07:06:27PM +0530, Sunil V L wrote:
> > > >> > This patch series enables the basic ACPI infrastructure for RISC=
-V.
> > > >> > Supporting external interrupt controllers is in progress and hen=
ce it is
> > > >> > tested using poll based HVC SBI console and RAM disk.
> > > >> >
> > > >> > The first patch in this series is one of the patch from Jisheng'=
s
> > > >> > series [1] which is not merged yet. This patch is required to su=
pport
> > > >> > ACPI since efi_init() which gets called before sbi_init() can en=
able
> > > >> > static branches and hits a panic.
> > > >> >
> > > >> > Patch 2 and 3 are ACPICA patches which are not merged into acpic=
a yet
> > > >> > but a PR is raised already.
> > > >> >
> > > >> > Below are two ECRs approved by ASWG.
> > > >> > RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5n=
X6xSEqK2l/view
> > > >> > RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123D=
CZKR-tia/view
> > > >> >
> > > >> > The series depends on Anup's IPI improvement series [2].
> > > >> >
> > > >> > [1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@ke=
rnel.org/
> > > >> > [2] https://lore.kernel.org/lkml/20230103141221.772261-7-apatel@=
ventanamicro.com/T/
> > > >>
> > > >> Building a clang-15 allmodconfig (I didn't try gcc) with this seri=
es, and
> > > >> Anup's IPI bits, results in a broken build, due to failings in cmp=
xchg:
> > > >>
> > > >> /stuff/linux/drivers/platform/surface/aggregator/controller.c:61:2=
5: error: call to __compiletime_assert_335 declared with 'error' attribute:=
 BUILD_BUG failed
> > > >>         while (unlikely((ret =3D cmpxchg(&c->value, old, new)) !=
=3D old)) {
> > > >>                                ^
> >
> > > > I am able to build without any of these issues using clang-15. I am
> > > > wondering whether the base is proper. I had rebased on top of the m=
aster
> > > > and couple of patches from IPI series were already merged in the ma=
ster.
> > > >
> > > > Do you mind verifying with my branch
> > > > https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V3=
?
> > >
> > > I can check that later I suppose.
> >
> > That's broken too.
> >
> > > > Or if you could provide me your branch details, I can look further.
> > >
> > > 6.3-rc1, with both series applied, sans Anups applied patches.
> >
> > I've pushed my stuff here, but unlikely that it makes any odds since
> > your branch experiences the same build issue.
> > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ borked=
-acpi-surface
> >
> > My build commands are wrapped in a script, but it's an LLVM=3D1
> > allmodconfig run w/ clang-15(.0.7) etc.
> >
> Ahh allmodconfig. Thank you very much!. I can reproduce the failure. Let
> me look further and fix in next revision.
>
> Thanks!
> Sunil

Hi Sunil

One question regarding PMU in ACPI flow.

We use DT to decode the supported HPM counters/events for the
different platforms now.
How do we enable PMU (drivers/perf/riscv_pmu_sbi.c) when using ACPI method?
Note, this might be in separate patch series.

Regards
Ley Foon
