Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510865F5BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJEV4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJEV4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:56:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B47F09A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:56:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v186so192380pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=8Pm7ryG24AwEz26lUQ3ZeFC6zq7cw9NWM/gooLAfALU=;
        b=AeGTAH1qBklqxpEo2vkcmEcRdYKPcxJMLw1EDD69Voxgucq1qWXkuWtpw0hbFOksBD
         T2x3k5SN/zcyEoWATrm8D40aJyi6q8dQX7OZiAGgR0C09ypu0qh3/LufYyj8XS2QT6dS
         kExPzR5TV/VT/yZy+yntCBO4FeNxGBpLoyX9H4AWXJM4fia6VUTK20B8CVFVNtgZ4jUx
         Byc8ttTJFq4HTvTdNsdeAOqZ3tRaC8Md3meGvUL9dL7ICZUASUVgoW/vaZh9q3zriNdV
         PytRMfPfXNBNQPkS5cz3jjk7OBBN1JRpG7UcALq+uTnGDrF91HEhorMi+aewRQujzdWc
         40Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8Pm7ryG24AwEz26lUQ3ZeFC6zq7cw9NWM/gooLAfALU=;
        b=ff2rtil0ZbBiYLpWxYhPGuSARSWUYhX96uFbHxEN6jgmMJvoAjXBnXDaFuO4k7uav/
         juv6D+caKhil7rkBBssE3mFu4Oxfv+dc0ZLOKBpnwZyd3nZq416yTWllUrUJzC6UUroH
         PQkU4eqdJVAmiiiLwcCH+X0TP5p+CT/EKAC80VdsYilBiZecUJXPwDYLFOWihUIAHB3L
         8MISxMV8k/dDOV3nkmRTT+KTxCOD9/wYDtrJAZmNlJarHzXZqhHND+SyL3MDQTDP5JRg
         9Ns0PIv/H5BtCmUsMxfuEMGOz8vLCQRZ5We+f7qDG0Ruc338NQbwEPwqqSCOWiLN8INt
         I+0g==
X-Gm-Message-State: ACrzQf0wEdwvT5riTXlrlfvzoFmXY1wvyHeJEtG7xnnQLsleh2AizvTv
        LNv+cYEYz7yy/3uMhMB5lxS5hNapow1zJ+WnpJ36Qg==
X-Google-Smtp-Source: AMsMyM72KOFuFLd05ekvHqkC8iQgjYBslmgWI6FetqXQFawTd561WeWnr2R3S8hjrJtx04dmecSswFY8Hu90TDRE2aY=
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id
 a145-20020a621a97000000b00562558712d6mr1824718pfa.37.1665006965827; Wed, 05
 Oct 2022 14:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnrHErOK+w878izVauHUKaX3eD-HXgigq2Ogm3iSj-fHA@mail.gmail.com>
 <76CB17D0-5A66-4D49-A389-8F40EC830DC0@sladewatkins.net> <CAP-5=fXVgwMO_CpS-EHN6PFhLB-J5Ft7qHz7oQd-WOMnTj72Cw@mail.gmail.com>
 <CAM9d7chvZjZ4YVc6j3w7OkdHteyJ0GUZboieu9G7jAWBevoZqA@mail.gmail.com> <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
In-Reply-To: <e553c4f8-ed3d-0755-cc8a-b5ffe43b2c2f@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Oct 2022 14:55:54 -0700
Message-ID: <CAKwvOdk6TTNhu_+FdONTXPo9Z8u5D4-5kf-rMN8oK4+6fMyc-w@mail.gmail.com>
Subject: Re: Invalid event (cycles:pp) in per-thread mode, enable system wide
 with '-a'.
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Slade Watkins <srw@sladewatkins.net>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@gmail.com>,
        Stephane Eranian <eranian@google.com>,
        Kees Cook <keescook@chromium.org>, sandipan.das@amd.com,
        Bill Wendling <morbo@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Yonghong Song <yhs@fb.com>
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

+ Stephane, Kees, Sandipan, Bill, ClangBuiltLinux mailing list, Yonghong
https://www.spinics.net/lists/linux-perf-users/msg23103.html
starts the thread, for context.

On Thu, Sep 29, 2022 at 9:32 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote=
:
>
> On 30-Sep-22 9:56 AM, Namhyung Kim wrote:
> > Hello,
> >
> > On Thu, Sep 29, 2022 at 8:49 PM Ian Rogers <irogers@google.com> wrote:
> >>
> >> On Thu, Sep 29, 2022 at 3:10 PM Slade Watkins <srw@sladewatkins.net> w=
rote:
> >>>
> >>> Hey Nick,
> >>>
> >>>> On Sep 29, 2022, at 5:54 PM, Nick Desaulniers <ndesaulniers@google.c=
om> wrote:
> >>>>
> >>>> I remember hearing rumblings about issues with zen 2, LBR, vs zen 3.
> >>>> Is this a known issue, or am I holding it wrong?
> >>>
> >>> Hm=E2=80=A6 I also remember this. I have a Zen 2 based system that I =
can do testing on, so I will do so when I=E2=80=99m able.
> >>>
> >>> If I discover something of note, I=E2=80=99ll get back to you.
> >>>
> >>> Cheers,
> >>> -srw
> >>>
> >>
> >> LBR isn't yet supported for Zen but is coming:
> >> https://lore.kernel.org/lkml/166155216401.401.5809694678609694438.tip-=
bot2@tip-bot2/
> >> I'd recommend frame-pointers.

Having to recompile is less than ideal for my workflow.  I have added a not=
e to
https://github.com/ClangBuiltLinux/profiling/tree/main/perf#errors
Please let me know how I might improve the documentation.

> >>
> >> +Ravi who may be able to say if there are any issues with the precise
> >> sampling on AMD.
> >
> > Afaik cvcles:pp will use IBS but it doesn't support per-task profiling
> > since it has no task context.  Ravi is working on it..
>
> Right.
> https://lore.kernel.org/lkml/20220829113347.295-1-ravi.bangoria@amd.com

Cool, thanks for working on this Ravi.

I'm not sure yet whether I may replace the kernel on my corporate
provided workstation, so I'm not sure yet I can help test that patch.

Can you confirm that
$ perf record -e cycles:pp --freq=3D128 --call-graph lbr -- <command to pro=
file>

works with just that patch applied? Or is there more work required?
What is the status of that patch?

For context, we had difficulty upstreaming support for instrumentation
based profile guided optimizations in the Linux kernel.
https://lore.kernel.org/lkml/CAHk-=3DwhqCT0BeqBQhW8D-YoLLgp_eFY=3D8Y=3D9ieR=
EM5xx0ef08w@mail.gmail.com/
We'd like to be able to use either instrumentation or sampling to
optimize our builds.  The major barrier to sample based approaches are
architecture / micro architecture issues with sample based profile
data collection, and bitrot of data processing utilities.
https://github.com/google/autofdo/issues/144
--=20
Thanks,
~Nick Desaulniers
