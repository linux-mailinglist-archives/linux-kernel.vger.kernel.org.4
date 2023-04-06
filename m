Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554306D8DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjDFCry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjDFCqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:46:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50FA9EC8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 19:45:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so39315015pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 19:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680749128; x=1683341128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdNJO4mfN64m2Db82GYHXGm3NSR4lZ1G8dlNVBocSIQ=;
        b=ll2bMfcK89gAizgPPSIn5T8e949Q/JnqEcpbsQeH1VY1J/1iiYgC9aALL2CEf2+ES4
         ZEfM5usiEug7lR0+bioA+yXiHLk0FoNBuiyQPCe6cp18ck+MXIAA4O6uAZP7vSNm18fI
         6XQu02i5KwSFYotIxb6lE9G70vRd285inqAelYvMppyeO4qHqhrDZnvLg4p3Z/StW5ry
         sZ1TjWivLeTE7tQ1e5vH6hFsdArzA7VVTxqGGiztJjaGJ0qw2i24+Kd+nnRCEkjj/vTb
         Jem7EpjPp+9NRxyKrKOVITzJ3bMS+uYgyJ6VqhKZhh5SwSEbk4Ct3Lo7TzFbAznDeiQk
         OEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680749128; x=1683341128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdNJO4mfN64m2Db82GYHXGm3NSR4lZ1G8dlNVBocSIQ=;
        b=o+c8/DGAO7TrZrxgJfCkx+3N8OcrSbc8KeSNblzzXCvy65LWlZ9+XjeFSeyfT4vebO
         58sxhIy86cO8pqUR8cO3KDVT0ZTHd8gqKtBE5444h4OAbguHOJPpnu4ebFgmdVBYQJq9
         EmBMgUEtxqzCT4HcW7U7Vg8ejFKlC3NdCVCh5x6UHUR2jR6R07ZXkwsArAXIM0hnDdy8
         cO5rAGv6I4WvdQrZnKKuu1mbdC+en24+Ch4ODLHZGmmMc4YckSg5IozyOYddNRFTdGvu
         rWzUw6xTXRmpiDRUPSQxI4fLue/1vHfkj8mo+pMc90ONRSHsFbtU8rrluNkxGc6m8geH
         LyXw==
X-Gm-Message-State: AAQBX9e9wgp3SakY2dh2rCr6sgngDzkwUQLbZk8zLr0XPGMJ5R/4vpzL
        uqwlxbs8Z2t1FzGI53PWR2+eBoM2VWDYMOFeScIg2Q==
X-Google-Smtp-Source: AKy350YjCKHwdcmt1MAwwhk34guKHZvpB05RdPBqo7FPZRGnCR0kw248IBXLZjoyZJA7B5VFYot4iQ1xdvgYwcXR1cE=
X-Received: by 2002:a17:903:248:b0:19f:3b0f:4d8d with SMTP id
 j8-20020a170903024800b0019f3b0f4d8dmr3546362plh.7.1680749127966; Wed, 05 Apr
 2023 19:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <16007014-c5f2-4b07-baec-e19952236aa5@spud> <ZAbGSA6F0kfv9YYw@sunil-laptop>
 <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org> <a9823561-2e32-49e8-b6c9-73e4b8f8cf8d@spud>
 <ZAfeaO52pnYhiyLN@sunil-laptop> <CAFiDJ58bRo6R1qOFaSSNgAdbQJZ3xDY6Wth-t8M8XKRFbig2hA@mail.gmail.com>
 <ZCvJpnNZYzrIcfPe@sunil-laptop>
In-Reply-To: <ZCvJpnNZYzrIcfPe@sunil-laptop>
From:   Atish Kumar Patra <atishp@rivosinc.com>
Date:   Thu, 6 Apr 2023 08:15:16 +0530
Message-ID: <CAHBxVyHA8ZouSUnqHaZTa=uMQxx61RqZuSBHx15Hg8+AVYLXZg@mail.gmail.com>
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Ley Foon Tan <lftan@kernel.org>, Conor Dooley <conor@kernel.org>,
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
        Conor Dooley <conor.dooley@microchip.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 12:24=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Tue, Apr 04, 2023 at 02:35:19PM +0800, Ley Foon Tan wrote:
> > On Wed, Mar 8, 2023 at 9:08=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.=
com> wrote:
> > >
> > > On Tue, Mar 07, 2023 at 06:44:35PM +0000, Conor Dooley wrote:
> > > > On Tue, Mar 07, 2023 at 06:13:22AM +0000, Conor Dooley wrote:
> > > > >
> > > > >
> > > > > On 7 March 2023 05:06:16 GMT, Sunil V L <sunilvl@ventanamicro.com=
> wrote:
> > > > > >On Mon, Mar 06, 2023 at 09:51:09PM +0000, Conor Dooley wrote:
> > > > > >> Hey Sunil,
> > > > > >>
> > > > > >> On Fri, Mar 03, 2023 at 07:06:27PM +0530, Sunil V L wrote:
> > > > > >> > This patch series enables the basic ACPI infrastructure for =
RISC-V.
> > > > > >> > Supporting external interrupt controllers is in progress and=
 hence it is
> > > > > >> > tested using poll based HVC SBI console and RAM disk.
> > > > > >> >
> > > > > >> > The first patch in this series is one of the patch from Jish=
eng's
> > > > > >> > series [1] which is not merged yet. This patch is required t=
o support
> > > > > >> > ACPI since efi_init() which gets called before sbi_init() ca=
n enable
> > > > > >> > static branches and hits a panic.
> > > > > >> >
> > > > > >> > Patch 2 and 3 are ACPICA patches which are not merged into a=
cpica yet
> > > > > >> > but a PR is raised already.
> > > > > >> >
> > > > > >> > Below are two ECRs approved by ASWG.
> > > > > >> > RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAq=
uu5nX6xSEqK2l/view
> > > > > >> > RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6=
123DCZKR-tia/view
> > > > > >> >
> > > > > >> > The series depends on Anup's IPI improvement series [2].
> > > > > >> >
> > > > > >> > [1] https://lore.kernel.org/all/20220821140918.3613-1-jszhan=
g@kernel.org/
> > > > > >> > [2] https://lore.kernel.org/lkml/20230103141221.772261-7-apa=
tel@ventanamicro.com/T/
> > > > > >>
> > > > > >> Building a clang-15 allmodconfig (I didn't try gcc) with this =
series, and
> > > > > >> Anup's IPI bits, results in a broken build, due to failings in=
 cmpxchg:
> > > > > >>
> > > > > >> /stuff/linux/drivers/platform/surface/aggregator/controller.c:=
61:25: error: call to __compiletime_assert_335 declared with 'error' attrib=
ute: BUILD_BUG failed
> > > > > >>         while (unlikely((ret =3D cmpxchg(&c->value, old, new))=
 !=3D old)) {
> > > > > >>                                ^
> > > >
> > > > > > I am able to build without any of these issues using clang-15. =
I am
> > > > > > wondering whether the base is proper. I had rebased on top of t=
he master
> > > > > > and couple of patches from IPI series were already merged in th=
e master.
> > > > > >
> > > > > > Do you mind verifying with my branch
> > > > > > https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi1=
7_V3?
> > > > >
> > > > > I can check that later I suppose.
> > > >
> > > > That's broken too.
> > > >
> > > > > > Or if you could provide me your branch details, I can look furt=
her.
> > > > >
> > > > > 6.3-rc1, with both series applied, sans Anups applied patches.
> > > >
> > > > I've pushed my stuff here, but unlikely that it makes any odds sinc=
e
> > > > your branch experiences the same build issue.
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ bo=
rked-acpi-surface
> > > >
> > > > My build commands are wrapped in a script, but it's an LLVM=3D1
> > > > allmodconfig run w/ clang-15(.0.7) etc.
> > > >
> > > Ahh allmodconfig. Thank you very much!. I can reproduce the failure. =
Let
> > > me look further and fix in next revision.
> > >
> > > Thanks!
> > > Sunil
> >
> > Hi Sunil
> >
> > One question regarding PMU in ACPI flow.
> >
> > We use DT to decode the supported HPM counters/events for the
> > different platforms now.
> > How do we enable PMU (drivers/perf/riscv_pmu_sbi.c) when using ACPI met=
hod?
> > Note, this might be in separate patch series.
> >
> Hi Lay Foon,
>
> This driver uses SBI calls and hence should work in case of ACPI also.
>
> There is one minor change required in this driver for overflow
> interrupt. I have a patch for that in future series.

Just to add further clarification: OpenSBI will continue to use the
device tree so that
the firmware will have access to all the PMU details.

>
> Thanks,
> Sunil
