Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8F6E6D81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjDRUaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDRUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:30:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57771A275
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:30:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517bfdf55c3so1158707a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1681849831; x=1684441831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=758KJFnubLFSsZj7NLSbl2wQ+MQOeQGEXb82zXsrHA8=;
        b=JKWc07Hsa1AIwKVKIMzXI4sw331w8kX1TDKqtQB//KSPOSUQN+tk39Ofo87lgk87cs
         A++4AkL4VO7Zo172B6EmKiVr7FrbMePdElPSloCsouI2E/r/+XOY/fDC60aCptlCrI9z
         Pj+V02e4O7mTkISl5wP8rj3Y1EWU2fzkx9GVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681849831; x=1684441831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=758KJFnubLFSsZj7NLSbl2wQ+MQOeQGEXb82zXsrHA8=;
        b=PERDbCODNC9FPzQF0J/apfVXmyx5YMFjumlXgnbiyDK4EfwIzm2PODFFeFyoh0Wzbn
         LyUxdYHXHx/C8ryhT3BA3snduiJ32bctDYNEbAFgXcBlon5Z7UgujDUZFSj9/j3jfhXq
         RaartYQCHd7vhgga+IwYAJtZUwWLuvvkOyElckHo5LbxUC0T2yVO0abso9d9tkxfY64a
         XezSexBM0IveEuiDbf6e7pGLal9OAiObseXi0oipDw1RzyDzjcYy+DWC5oGUq4d+82oP
         gnSWOPsCWBJXKdxFNTphrOYOUiKCa6ajAYEqB78uk6w+wZ5hdyEoLDz/b0TDr0gutNa4
         7pEQ==
X-Gm-Message-State: AAQBX9evMGTlNmSBweJ4t9cRA9V58KwcsKrCS53RUDNdSVcLMWnCOB0R
        i+wBO8q/rVxRJ2PudbqYKqYn1puwGz8eIRuhE78G
X-Google-Smtp-Source: AKy350ZIg+M7FnY7uohsy0MLIS1rdUP3e5Y8mF0C/rJh0Ab5JDC3yj3RoFOx5gy5nC7akfL3LOBt0QioDaAyr1DFD3g=
X-Received: by 2002:a17:90a:4706:b0:23d:1121:f211 with SMTP id
 h6-20020a17090a470600b0023d1121f211mr293761pjg.5.1681849830738; Tue, 18 Apr
 2023 13:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
 <CAOnJCU+72PV1=o1c_TpogkmBT36278BneVWEMr1=tqX0CZi+ag@mail.gmail.com>
 <aadca595b4a24e36932ba41e61f4e263@AcuMS.aculab.com> <CAOnJCUJ7mY+fh9VqE4dRntnVAEAc26=NnOCPUqkXk6ky__cUZQ@mail.gmail.com>
 <CAP-5=fUYJEecmhQVuvbM4ZoDP_Hj=2RKOgR4cKepU072Uy3xyw@mail.gmail.com>
In-Reply-To: <CAP-5=fUYJEecmhQVuvbM4ZoDP_Hj=2RKOgR4cKepU072Uy3xyw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 19 Apr 2023 02:00:18 +0530
Message-ID: <CAOnJCULJfSN79MzAwhCrbVzG1rYyrPB3OraFmoZFBxuRCwq01w@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: Allow userspace to directly access perf counters
To:     Ian Rogers <irogers@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        paranlee <p4ranlee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:46=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Apr 18, 2023 at 9:43=E2=80=AFAM Atish Patra <atishp@atishpatra.or=
g> wrote:
> >
> > On Fri, Apr 14, 2023 at 2:40=E2=80=AFAM David Laight <David.Laight@acul=
ab.com> wrote:
> > >
> > > From: Atish Patra
> > > > Sent: 13 April 2023 20:18
> > > >
> > > > On Thu, Apr 13, 2023 at 9:47=E2=80=AFPM Alexandre Ghiti <alexghiti@=
rivosinc.com> wrote:
> > > > >
> > > > > riscv used to allow direct access to cycle/time/instret counters,
> > > > > bypassing the perf framework, this patchset intends to allow the =
user to
> > > > > mmap any counter when accessed through perf. But we can't break t=
he
> > > > > existing behaviour so we introduce a sysctl perf_user_access like=
 arm64
> > > > > does, which defaults to the legacy mode described above.
> > > > >
> > > >
> > > > It would be good provide additional direction for user space packag=
es:
> > > >
> > > > The legacy behavior is supported for now in order to avoid breaking
> > > > existing software.
> > > > However, reading counters directly without perf interaction may
> > > > provide incorrect values which
> > > > the userspace software must avoid. We are hoping that the user spac=
e
> > > > packages which
> > > > read the cycle/instret directly, will move to the proper interface
> > > > eventually if they actually need it.
> > > > Most of the users are supposed to read "time" instead of "cycle" if
> > > > they intend to read timestamps.
> > >
> > > If you are trying to measure the performance of short code
> > > fragments then you need pretty much raw access directly to
> > > the cycle/clock count register.
> > >
> > > I've done this on x86 to compare the actual cycle times
> > > of different implementations of the IP checksum loop
> > > (and compare them to the theoretical limit).
> > > The perf framework just added far too much latency,
> > > only directly reading the cpu registers gave anything
> > > like reliable (and consistent) answers.
> > >
> >
> > This series allows direct access to the counters once configured
> > through the perf.
> > Earlier the cycle/instret counters are directly exposed to the
> > userspace without kernel/perf frameworking knowing
> > when/which user space application is reading it. That has security impl=
ications.
> >
> > With this series applied, the user space application just needs to
> > configure the event (cycle/instret) through perf syscall.
> > Once configured, the userspace application can find out the counter
> > information from the mmap & directly
> > read the counter. There is no latency while reading the counters.
> >
> > This mechanism allows stop/clear the counters when the requesting task
> > is not running. It also takes care of context switching
> > which may result in invalid values as you mentioned below. This is
> > nothing new and all other arch (x86, ARM64) allow user space
> > counter read through the same mechanism.
> >
> > Here is the relevant upstream discussion:
> > https://lore.kernel.org/lkml/Y7wLa7I2hlz3rKw%2F@hirez.programming.kicks=
-ass.net/T/
> >
> > ARM64:
> > https://docs.kernel.org/arm64/perf.html?highlight=3Dperf_user_access#pe=
rf-userspace-pmu-hardware-counter-access
> >
> > example usage in x86:
> > https://github.com/andikleen/pmu-tools/blob/master/jevents/rdpmc.c
>
> The canonical implementation of this should be:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/lib/perf/mmap.c#n400

Thanks for sharing the libperf implementation.

> which is updated in these patches but the tests are not:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/t=
ools/perf/tests/mmap-basic.c#n287
> Which appears to be an oversight. The tests display some differences

Yes. It's an oversight. We should make sure that perf mmap tests pass
for RISC-V as well.


> between x86 and aarch64 that have assumed userspace hardware counter
> access, and everything else that it is assumed don't.
>
> Thanks,
> Ian
>
> > > Clearly process switches (especially cpu migrations) cause
> > > problems, but they are obviously invalid values and can
> > > be ignored.
> > >
> > > So while a lot of uses may be 'happy' with the values the
> > > perf framework gives, sometimes you do need to directly
> > > read the relevant registers.
> > >
> > >         David
> > >
> > > -
> > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,=
 MK1 1PT, UK
> > > Registration No: 1397386 (Wales)
> >
> >
> >
> > --
> > Regards,
> > Atish



--
Regards,
Atish
