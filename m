Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B2269DC67
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjBUIvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:50:58 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DCA23865
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:50:56 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v78so4068363ybe.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfZpBOcdqAbzbxHBd6LiBv8ii3j9LcGGAhSaJGfbJ7Q=;
        b=Vjb6Xh6OggDBHsVL/uL4F/6qyLR9gdJ6QLjal5yZkans2a9UzTgqtuy9UgUCFo5zfn
         YA5z3TiX+14UwhLFlQG/kkvQqUbiwsaGgdZITVTi8pg0gKTIEFM6jCGzc+GAvw3z/pVG
         LgOfDisAyp6iGDqZLnd5Mv9TevEy6M7WlaptTPMS+Tlic6bLvk/hRSwMopgIYS5tciJa
         wSNwFtEM477sb3n8lBfOKth+/YUmd9jDm47kt4Q8OGjcQYpCTE6r/5CEOTbE3CUpw+YZ
         AFB2fLUaZgEXXSX55aZZb8ynNpxM/fNy1HAO+eIlKSC9k1Ns+Oozi0FlCj1FSOucU8A3
         UCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfZpBOcdqAbzbxHBd6LiBv8ii3j9LcGGAhSaJGfbJ7Q=;
        b=1RyCmPst4M3PCBILWcclGLbD/DokCRDd2jlZ3//Lexz9/xLiz7RyoZyCj7cpslSsYx
         44ONRotOnBefP2ptw2XGFi/rZg6Fu36czYf+hxf5uZHBimsgA0IRnITq9BWqXioKIeKD
         zJE8kpEFwxUsCiO7j/xaKL0kf21iVz90uO/hTWl3HAuxIaCSXgL472732HUquyM45mN7
         vCJbyvGXuHzRgs/uXEvoDvTeXD3NrVKpqgUfHjXb2x2IkD0tRVibQq54O+ae9H3yCb+p
         K1N7L2bv4XVeMAqht55OQdjw7vQfGqtBKtYCNms6mkW7Mp1/GYYXki9hvhKQzzGh2Xlt
         anpA==
X-Gm-Message-State: AO0yUKUZFEINUr9p1XzQU2sIGA/pqBHmgonl6Ft9Zxc+eeTqe5isr/hw
        O1o9Bq8Ik0kk1O1zWG5LUi5UiIaf9X/2MVkJlByPHg==
X-Google-Smtp-Source: AK7set+N8m3TIwSK9bSBsbq3+rCCUhSS7OojbUg6kFVqOjoAtMkeLsnpbvPJztH1rnILbRvPxuAbsfrF9ptmPxsIzbY=
X-Received: by 2002:a05:6902:50:b0:8dd:52a3:b3a5 with SMTP id
 m16-20020a056902005000b008dd52a3b3a5mr293304ybh.5.1676969455868; Tue, 21 Feb
 2023 00:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20230217161354.129442-1-wyes.karny@amd.com> <Y/NdUjLiQu+D0q7b@hirez.programming.kicks-ass.net>
 <CABPqkBTU_gnTr9ayvg220T4pO5NAguvu_UJAkZO2RUATWuMJ3A@mail.gmail.com> <Y/ROTsCSCFtrwwTK@beas>
In-Reply-To: <Y/ROTsCSCFtrwwTK@beas>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 21 Feb 2023 00:50:44 -0800
Message-ID: <CABPqkBQ_bSTC-OEe_LrgUrpj2VsseX1ThvO-yLcEtF8vb4+AAw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Testing Wyes' patch for energy-cores on Zen3 server loaded with triad
bench on socket0:

$ perf stat --per-core -a -C0-63 -I 1000 -e
power/energy-cores/,power/energy-pkg/
#           time core               cpus             counts   unit events
     1.001019203 S0-D0-C0              1               1.28 Joules
power/energy-cores/
     1.001019203 S0-D0-C0              1             231.38 Joules
power/energy-pkg/
     1.001019203 S0-D0-C1              1   4,294,967,130.96 Joules
power/energy-cores/
     1.001019203 S0-D0-C1              1             231.38 Joules
power/energy-pkg/
     1.001019203 S0-D0-C2              1   4,294,967,126.23 Joules
power/energy-cores/
     1.001019203 S0-D0-C2              1             231.38 Joules
power/energy-pkg/
     1.001019203 S0-D0-C3              1   4,294,967,122.50 Joules
power/energy-cores/
     1.001019203 S0-D0-C3              1             231.38 Joules
power/energy-pkg/
     1.001019203 S0-D0-C4              1   4,294,967,129.92 Joules
power/energy-cores/
     1.001019203 S0-D0-C4              1             231.38 Joules
power/energy-pkg/
     1.001019203 S0-D0-C5              1   4,294,967,121.49 Joules
power/energy-cores/
     1.001019203 S0-D0-C5              1             231.39 Joules
power/energy-pkg/

I think the result of energy-cores is not reliable and I think that is
why I did not
include it in the patch.

Could also be a problem with the kernel code, but I don't know why it would=
 only
impact energy-cores given energy-pkg looks reasonable here.


On Mon, Feb 20, 2023 at 8:53=E2=80=AFPM Wyes Karny <wyes.karny@amd.com> wro=
te:
>
> On 20 Feb 13:29, Stephane Eranian wrote:
> > On Mon, Feb 20, 2023 at 3:45=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Fri, Feb 17, 2023 at 04:13:54PM +0000, Wyes Karny wrote:
> > > > AMD processors support per-package and per-core energy monitoring
> > > > through RAPL counters which can be accessed by users running in
> > > > supervisor mode.
> > > >
> > > > Core RAPL counters gives power consumption information per core.  F=
or
> > > > AMD processors the package level RAPL counter are already exposed t=
o
> > > > perf. Expose the core level RAPL counters also.
> > > >
> > > > sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/
> > > >
> > > > Output:
> > > > S0-D0-C0           2               8.73 Joules power/energy-cores/
> > > > S0-D0-C1           2               8.73 Joules power/energy-cores/
> > > > S0-D0-C2           2               8.73 Joules power/energy-cores/
> > > > S0-D0-C3           2               8.73 Joules power/energy-cores/
> > > > S0-D0-C4           2               8.73 Joules power/energy-cores/
> > > >
> > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > > ---
> > > >  arch/x86/events/rapl.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> > > > index 52e6e7ed4f78..d301bbbc3b93 100644
> > > > --- a/arch/x86/events/rapl.c
> > > > +++ b/arch/x86/events/rapl.c
> > > > @@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] =
=3D {
> > > >   * - want to use same event codes across both architectures
> > > >   */
> > > >  static struct perf_msr amd_rapl_msrs[] =3D {
> > > > -     [PERF_RAPL_PP0]  =3D { 0, &rapl_events_cores_group, 0, false,=
 0 },
> > > > +     [PERF_RAPL_PP0]  =3D { MSR_AMD_CORE_ENERGY_STATUS, &rapl_even=
ts_cores_group, test_msr, false, RAPL_MSR_MASK },
> > >
> > > Stephane, this was an oversight?
> > >
> > I think it may depend on the CPU model. I remember it returning either
> > 0 or bogus values on my systems. They may have improved that.
> > The commit msg does not show which CPU model this is run on.
>
> I've tested this on Zen 2, 3 and 4 server systems.
>
> Thanks,
> Wyes
> >
> > >
> > > >       [PERF_RAPL_PKG]  =3D { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_even=
ts_pkg_group,   test_msr, false, RAPL_MSR_MASK },
> > > >       [PERF_RAPL_RAM]  =3D { 0, &rapl_events_ram_group,   0, false,=
 0 },
> > > >       [PERF_RAPL_PP1]  =3D { 0, &rapl_events_gpu_group,   0, false,=
 0 },
> > > > @@ -764,7 +764,8 @@ static struct rapl_model model_spr =3D {
> > > >  };
> > > >
> > > >  static struct rapl_model model_amd_hygon =3D {
> > > > -     .events         =3D BIT(PERF_RAPL_PKG),
> > > > +     .events         =3D BIT(PERF_RAPL_PP0) |
> > > > +                       BIT(PERF_RAPL_PKG),
> > > >       .msr_power_unit =3D MSR_AMD_RAPL_POWER_UNIT,
> > > >       .rapl_msrs      =3D amd_rapl_msrs,
> > > >  };
> > > > --
> > > > 2.34.1
> > > >
