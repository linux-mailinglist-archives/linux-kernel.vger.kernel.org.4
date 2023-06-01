Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D56719306
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFAGLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFAGL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:11:29 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B09D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:11:27 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6260a07bf3cso5582276d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685599887; x=1688191887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp5j/0n6KgQB/DLfuUgkx+FtkyxRaqHC9E6KILKWmEE=;
        b=NxaqRQbsEeoKOClbnltoLoxGtU5bMk75dkL11TINcGg+wsPLk1UijhS4w1Ne1pqjlz
         JFFUG6dUGrNX0rvMirnmja48ru25tgnyd5GaiVF+5VxdhwW0g3c0Dd45iKTroPsRx/Fz
         Bo+nhmMFtEiKsRaBFH+OoDxTY8nrORn/9hw/b1WJSoQp6RHyhjpuOF++7sgREZx5bjx9
         EO29fwuZ8+D9yO5QyUKXHrzggmCxm7Ehb/XQHoNpJURspY5gkIo5+SStb1EjMXknuPZB
         JeD2H3aC/Ms33JKMzaxz784KaC+19COtrD/uSy66pJzClF6dcHd7lDtQkgiPobV8Q0MO
         tXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685599887; x=1688191887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp5j/0n6KgQB/DLfuUgkx+FtkyxRaqHC9E6KILKWmEE=;
        b=kGwWZZ+/+3rVmM5KL9SOHUZ1MblJbOEwqFst5eL5d1o6UcdLJqtYtu4xkGoqySHGBs
         mgGxM97kV4zI1HgFulRsFBDv0SVkZoHnvHnTI6cPF6QgRTXo1V7Awrb7XX4dkpYesf0R
         6LA0XhrmWxPKcplHc0HiKGLawLijUB2kZUXIcoWnXvBfLjmTV5R0tAv7SsUyVsWiEzLo
         g9aE/jdpmq+8gufTBABJ7f2ReDC3Nlr49xyui4bEi1p/AMADoldIxM4vCKQqGA94zVRI
         HSjF/10bUSKX3ksjTej3qyM7uCEiA3Ickp1ZpQh9RGMryLkfjUQeabA5L4+I1Lngl8F6
         doSQ==
X-Gm-Message-State: AC+VfDwXi+FAs6W97e6CtOI2E5U+WmNLVcNgjjyltgajXiixAZNSj34J
        9P0WGnJAqNghkpEPEeTgnCJJNE8tYi7OP5ICcQaNXg==
X-Google-Smtp-Source: ACHHUZ6grZUG+l6wFp98O9QuJ+34LuRYy0x6QtUH/rlJ1yncqdXL9yyO/1KsY5XfUs2hi/Z1cRlozyZajYdIu5Ww1rc=
X-Received: by 2002:a05:6214:1309:b0:626:bfa:b240 with SMTP id
 pn9-20020a056214130900b006260bfab240mr10517136qvb.22.1685599886825; Wed, 31
 May 2023 23:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org> <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com> <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
In-Reply-To: <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 1 Jun 2023 11:40:50 +0530
Message-ID: <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 17 May 2023 at 02:54, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, May 16, 2023 at 11:12=E2=80=AFAM Amit Pundir <amit.pundir@linaro.=
org> wrote:
> >
> > On Mon, 15 May 2023 at 20:33, Doug Anderson <dianders@chromium.org> wro=
te:
> > >
> > > Hi,
> > >
> > > On Mon, May 15, 2023 at 7:42=E2=80=AFAM Amit Pundir <amit.pundir@lina=
ro.org> wrote:
> > > >
> > > > On Sun, 14 May 2023 at 18:11, Caleb Connolly <caleb.connolly@linaro=
.org> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 13/05/2023 18:08, Amit Pundir wrote:
> > > > > > On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@chromi=
um.org> wrote:
> > > > > >>
> > > > > >> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
> > > > > >> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems t=
hat
> > > > > >> prompted the us to switch to synchronous probe showed that the=
 root
> > > > > >> cause was a missing "rootwait" in the kernel command line
> > > > > >> arguments. Let's reinstate asynchronous probe.
> > > > > >
> > > > > > Hi, the asynchronous probe is broken on Dragonboard 845c (SDM84=
5)
> > > > > > running AOSP (Android Open Source Project) with v6.4-rc1
> > > > > > https://bugs.linaro.org/show_bug.cgi?id=3D5975.
> > > > > > Can we please go back to synchronous probe.
> > > > > >
> > > > > > AOSP do not make use of rootwait, IIRC, but it is added by the
> > > > > > bootloader anyway. And the device fails to boot AOSP regardless=
 of
> > > > > > "rootwait" bootarg being present or not.
> > > > >
> > > > > Could you try applying this diff to enable some log spam and let =
me know
> > > > > what you get? I'm keen to try and figure this one out. My mail cl=
ient
> > > > > might crunch this a bit so I have pasted it here too
> > > > > https://p.calebs.dev/ab74b7@raw
> > > >
> > > > These prints add just enough delay for the UFS probe to succeed tha=
t I
> > > > can't reproduce the failure anymore.
> > >
> > > I'd prefer doing at least a little debugging before jumping to a
> > > revert. From looking at your dmesg [1], it looks as if the async prob=
e
> > > is allowing RPMH to probe at the same time as "qcom-vadc-common".
> > > That's something that talks on the SPMI bus and is (potentially)
> > > talking to the same PMICs that RPMH-regulator is, right? I'm by no
> > > means an expert on how Qualcomm's PMICs work, but it seems plausible
> > > that the "qcom-vadc-common" is somehow causing problems and screwing
> > > up RPMH. Does that seem plausible to you?
> > >
> > > If so, one interesting way to track it down would be to move around
> > > delays. Put ~500ms sleep at the _end_ of vadc_probe(). Presumably tha=
t
> > > _won't_ fix the problem. Now put a ~500ms sleep at the beginning of
> > > vadc_probe(). Maybe that will fix the problem? If so, you can move th=
e
> > > delay around to narrow down the conflict. My wild guess would be that
> > > vadc_reset() could be throwing things for a loop?
> > >
> > > If the above doesn't work, maybe we could add more tracing / printout=
s
> > > to see what is probing at the same time as RPMH?
> >
> > Tried out a few changes today but none of them worked or were
> > effective enough to debug this crash further, other than setting
> > fw_devlink=3Dpermissive.
> >
> > Adding more tracing / prints (BOOTTIME_TRACING and
> > FUNCTION_GRAPH_TRACER) didn't work and didn't help in reproducing the
> > crash either. They added just enough delay to boot the device
> > successfully everytime.
> >
> > I tried to reason with the kernel modules which gets loaded before and
> > after the qcom-rpmh-regulator (QCOM_REBOOT_MODE, QCOM_PON, IIO/VADC,
> > SPMI_PMIC* etc) as suggested, but I run into the same crash even if I
> > disable those driver modules. So I don't think that the other driver
> > modules which gets loaded at around the same time as
> > qcom-rpmh-regulator by default have any impact on this failure.
>
> Ugh, Heisenbugs are no fun to debug. :( It sorta sounds as if pretty
> much anything you can do to change the timing fixes you. That does
> make reverting the async probe of the regulator less appealing. If, as
> you said, it's not just some other driver loading at the same time
> that's interfering then the revert "fixes" you in the same way that a
> "msleep" would fix you. That doesn't seem like enough of a
> justification for the revert to me.
>
> It still feels to me like _something_ is happening at the same time as
> the RPMH regulator driver is loading, though, I'm just not sure how to
> suggest debugging it. I guess other thoughts:
>
> * When RPMH complains, is it always with the same regulator (lvs1), or
> sometimes different ones? Any clue there?

It is always either lvs1 or lvs2.

>
> * How much can you control module loading order? If rpmh-regulator
> module loads first, does it "fix" things? If it does, maybe you could
> bisect to find the place where problems start cropping up. Does that
> give any clues?

Loading qcom-rpmh-regulator first does make it difficult to reproduce
the crash. I tried a few combinations to narrow down the issue further
and in one case, I managed to reproduce the crash (1 in 20+ reboots)
while loading the qcom-rpmh-regulator (and the dependent cmd-db,
qcom_rpmh) module alone
https://bugs.linaro.org/attachment.cgi?id=3D1140.

Regards,
Amit Pundir

>
>
> > The only way I can boot successfully everytime is if I boot with
> > fw_devlink=3Dpermissive bootarg. So I'll have to check if there is any
> > new dependency which got added recently in DT or somewhere else that
> > is causing this breakage.
>
> I guess I'll assume that `fw_devlink=3Dpermissive` only fixes you
> because it changes the timing...
