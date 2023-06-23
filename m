Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D0773C4B9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjFWXS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFWXS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:18:56 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393F1FCC;
        Fri, 23 Jun 2023 16:18:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bd5f59fb71dso1136022276.3;
        Fri, 23 Jun 2023 16:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687562334; x=1690154334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5h2Fku8APXH3iOdYKNWdhjGBKRm3o6/JPRIVNrW9qA=;
        b=QFfPEzgVXYAeQa/6a5IBaDl9QfzWAr6OxLdvn4H9sUUu1YPmlx9TYMKYcOkzf8Dri+
         I+EW41qX0D4ZLpiWpESkGo34UvdXh1t4YXWQjbcFDqWssJDjt7mcSlWmal0Io/ON+E4J
         QYEv3qDTt/TaPxDICboK4LH8hXpS/ZaV3vealWnFLolM7YMeOqg7dpU8bsTECkoLaCAe
         vdvmxkAQUYI0zrdjEpHv3RFRNQsZzBzcLy4T+Lo0cXVco+/1cQdBdoa9TMn4Az3qKXYR
         R/2Xy40EeDFEzF5J83APlgmNUsCx/Bt4V/JP3RTpBKSMDAA/ziEa/sGACVr25XR1AUJ8
         X54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687562334; x=1690154334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5h2Fku8APXH3iOdYKNWdhjGBKRm3o6/JPRIVNrW9qA=;
        b=JkxSxKdNcNey6TEw6A9tN86RTXM7XhAzn9qYm2+VFZVBHF8uRze+KeYKVhQoGTMCmb
         ok0voCJIYsf/VQe7TSaQeSmxhMotHe4ws7YpHAtGwOfJRq+V3KV9TGULDwvlCrsobz3t
         fvgw1nS7RC5RWoHWl+HDg8EGP2KNJckOVpGoLJBcnoeSbzhQTM7QjE5Yq691TNX2Stc4
         Ch5G5xUoDiHJG2E9BnFYRtJZliU3cc6+otF5pdA8+TLVk2Yn5AHTOm/sRQIoh9GOrmqR
         z80EQgntGlBt9q5Oog2Ma9zReB+8RUJwjAQ29jwYwTWUc6FKDch3MGTeZC0o0rIqrFLt
         Pk0Q==
X-Gm-Message-State: AC+VfDwy4Fh3MuB24B6QLJp7oyPGRrHr38OBTl7sAgJb8C+408crE5mU
        v0AW61W7B0Q53nkgmPXO53L//5UAebToHch1QMw=
X-Google-Smtp-Source: ACHHUZ64Ie2Q4TyVcEiEZZRvHCNcp3rrPGp7VLcfz4WgjiET7zv1uOAZWjP5DPConbdo8r3WXueFReyEKBSOKG0ki6g=
X-Received: by 2002:a25:4050:0:b0:bfe:9259:8f1a with SMTP id
 n77-20020a254050000000b00bfe92598f1amr10554353yba.50.1687562333975; Fri, 23
 Jun 2023 16:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net> <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com>
 <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com> <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
 <CABPqkBQVfQFJKCdHXEMGFcupzvy8zq14F52eLW5s9vr2Shmi6w@mail.gmail.com>
 <85822c3c-2254-52cc-e6b1-9c89adb63771@amd.com> <CAKwvOdkfEexsE07XXGW3FF+nMt-pR8uv2EA7QzsPbEZsSQBO-Q@mail.gmail.com>
 <85aabdc8-07cd-3285-1f3f-605f9ebbab18@amd.com> <b6a503b7-b421-a5c0-1cc8-4f1567b8d9de@amd.com>
 <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com>
In-Reply-To: <CAKwvOdmY7qoSG61f7UouWFz+gNN531FhpHbqawrAKCNKNDJHnw@mail.gmail.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 23 Jun 2023 16:18:42 -0700
Message-ID: <CAM9d7cg=HzWGgHvTUkkuRM+Y2tZgVACEV52a=vWqqa1mBMzuBw@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, Jun 23, 2023 at 9:23=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Oct 11, 2022 at 10:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd=
.com> wrote:
> >
> > On 12-Oct-22 9:36 AM, Ravi Bangoria wrote:
> > > On 12-Oct-22 3:02 AM, Nick Desaulniers wrote:
> > >> On Thu, Oct 6, 2022 at 8:56 PM Ravi Bangoria <ravi.bangoria@amd.com>=
 wrote:
> > >>>
> > >>> +cc: PeterZ
> > >>>
> > >>>>>>>> +Ravi who may be able to say if there are any issues with the =
precise
> > >>>>>>>> sampling on AMD.
> > >>>>>>>
> > >>>>>>> Afaik cvcles:pp will use IBS but it doesn't support per-task pr=
ofiling
> > >>>>>>> since it has no task context.  Ravi is working on it..
> > >>>>>>
> > >>>>>> Right.
> > >>>>>> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@=
amd.com
> > >>>>>
> > >>>>> Cool, thanks for working on this Ravi.
> > >>>>>
> > >>>>> I'm not sure yet whether I may replace the kernel on my corporate
> > >>>>> provided workstation, so I'm not sure yet I can help test that pa=
tch.
> > >>>>>
> > >>>>> Can you confirm that
> > >>>>> $ perf record -e cycles:pp --freq=3D128 --call-graph lbr -- <comm=
and to profile>
> > >>>>>
> > >>>>> works with just that patch applied? Or is there more work require=
d?
> > >>>>> What is the status of that patch?
> > >>>>>
> > >>>>> For context, we had difficulty upstreaming support for instrument=
ation
> > >>>>> based profile guided optimizations in the Linux kernel.
> > >>>>> https://lore.kernel.org/lkml/CAHk-=3DwhqCT0BeqBQhW8D-YoLLgp_eFY=
=3D8Y=3D9ieREM5xx0ef08w@mail.gmail.com/
> > >>>>> We'd like to be able to use either instrumentation or sampling to
> > >>>>> optimize our builds.  The major barrier to sample based approache=
s are
> > >>>>> architecture / micro architecture issues with sample based profil=
e
> > >>>>> data collection, and bitrot of data processing utilities.
> > >>>>> https://github.com/google/autofdo/issues/144
> > >>>>
> > >>>> On existing AMD Zen2, Zen3 the following cmdline:
> > >>>> $ perf record -e cycles:pp --freq=3D128 --call-graph lbr -- <comma=
nd to profile>
> > >>>>
> > >>>> does not work. I see two reasons:
> > >>>>
> > >>>> 1. cycles:pp is likely converted into IBS op in cycle mode.
> > >>>>     Current kernels do not support IBS in per-thread mode.
> > >>>>     This is purely a kernel limitation
> > >>>
> > >>> Right, it's purely a kernel limitation. And below simple patch on t=
op
> > >>> of event-context rewrite patch[1] should be sufficient to make cycl=
es:pp
> > >>> working in per-process mode on AMD Zen.
> > >>>
> > >>> ---
> > >>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> > >>> index c251bc44c088..de01b5d27e40 100644
> > >>> --- a/arch/x86/events/amd/ibs.c
> > >>> +++ b/arch/x86/events/amd/ibs.c
> > >>> @@ -665,7 +665,7 @@ static struct perf_ibs perf_ibs_fetch =3D {
> > >>>
> > >>>  static struct perf_ibs perf_ibs_op =3D {
> > >>>         .pmu =3D {
> > >>> -               .task_ctx_nr    =3D perf_invalid_context,
> > >>> +               .task_ctx_nr    =3D perf_hw_context,
> > >>>
> > >>>                 .event_init     =3D perf_ibs_init,
> > >>>                 .add            =3D perf_ibs_add,
> > >>> ---
> > >>>
> > >>> [1]: https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangori=
a@amd.com
> > >>
> > >> Hi Ravi,
> > >> I didn't see the above diff in
> > >> https://lore.kernel.org/lkml/20221008062424.313-1-ravi.bangoria@amd.=
com/
> > >> Was there another distinct patch you were going to send for the abov=
e?
> > >
> > > Yes Nick. I was planning to send it once the rewrite stuff goes in.
> >
> > Hi Nick,
> >
> > Since you have practical use case, would it be possible to run your wor=
kflow
> > with perf rewrite and IBS patches applied? It will help us in finding/f=
ixing
> > more bugs and upstreaming these changes.
>
> Hi Ravi,
> Sorry, I'm not able to load a custom kernel image on my employer
> provided workstation, and I never got approval to expense hardware for
> testing this otherwise.
>
> Was there ever any update on this? I'm on 6.1.25 now and still cant run
> $ perf record -e cycles:pp --call-graph lbr <any command to profile>
> $ cat /proc/cpuinfo
> ...
> model name      : AMD Ryzen Threadripper PRO 3995WX 64-Cores
> ...

The commit 30093056f7b2 ("perf/amd/ibs: Make IBS a core pmu") in v6.2.

  $ git name-rev --tags --refs=3Dv[2-6].* 30093056f7b2
  30093056f7b2 v6.2-rc1~176^2~16

https://git.kernel.org/torvalds/c/30093056f7b2

Thanks,
Namhyung
