Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A2E71FAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjFBHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjFBHbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:31:31 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64B132
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 00:31:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-62613b2c8b7so18476606d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685691089; x=1688283089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57kliT/w0kNdaW2+YyD6phw/D+om5H8pc/ZbSB/b7Kg=;
        b=ySAJ/WQNYXuyXXo/1RDuL1+ijOtKpdFZEYOC20f4XlCXFuSxQL9MCglTeZl3vqi7/C
         7DN48Hd/EygJgVPh4BOg/N/Vrdpkn+I2PZz/naWExQrD47Z+64348n+QH8h+jCf6FRIY
         cx8dH8OVp5AJ++tkqUyxS1DwjEc03ZGV06jG2XbXWKQ+z6e3Tr8o1FV7XcD3Evtr5j+9
         8ZSWidhQuYwNAHyAEwWcuLNJoRcYsvtxBCsV1Bxz08Ta1YUiSxWcGSafWi/b+5DJ6OoI
         kFkE/nwtniQbH6v7Eul0pnbSHBb2W8K4DyCt8E7Fhxgv+4tPmONinn2uLAl6FRlJwzI9
         6Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685691089; x=1688283089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57kliT/w0kNdaW2+YyD6phw/D+om5H8pc/ZbSB/b7Kg=;
        b=Ptq/aBraa0vbxjVI3L4VjIFwgcVlyIohKiiKbEBsfntneA7WAOKP4g3c6CEm1QEDyp
         8zsBmv9evr9XcUxF0UUQGNbU5Y/Cjf83xHryG1Ds7Z2DRP4865pfizNMB987PNKlEn4I
         kcBA9C3JWZKrwSsP0bBcUFlkdkLy9GwiaD6331++RpLFTTA/xcLU5eN92d9l4NYGpoAC
         RkbNYGa894DmfKbYOsGpl2OnEMw0lkjtTPpX/GdCRfnRLQnTTprSQ0MSMLtB3FMtLYkB
         vvl9qF5/R8QWDnY7V98/hiCk8NqN3yD/urXDsxEgPT2FZtqZ8LDbQi10TD15uROtftCR
         U59w==
X-Gm-Message-State: AC+VfDxWuyoja8lbpSnmhG8cwln9ytI9zFJjtWcMmNfGxB8hUjTjNw26
        B5qrDY4pqgjuz9Dgno27pclAkqrq3t5FREt96ZpiAA==
X-Google-Smtp-Source: ACHHUZ5zi8qblqX5GIT+hO66kxfsnox4scvDsds8+fQYUi77faxrMT5XXeU1Ca/ruc1pBT+bzpbgwDStrMS97vsvLnc=
X-Received: by 2002:a05:6214:20ed:b0:621:253d:f340 with SMTP id
 13-20020a05621420ed00b00621253df340mr16819390qvk.25.1685691089059; Fri, 02
 Jun 2023 00:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org> <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com> <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
In-Reply-To: <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 2 Jun 2023 13:00:52 +0530
Message-ID: <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 19:35, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, May 31, 2023 at 11:11=E2=80=AFPM Amit Pundir <amit.pundir@linaro.=
org> wrote:
> >
> > On Wed, 17 May 2023 at 02:54, Doug Anderson <dianders@chromium.org> wro=
te:
> > >
> > > Hi,
> > >
> > > On Tue, May 16, 2023 at 11:12=E2=80=AFAM Amit Pundir <amit.pundir@lin=
aro.org> wrote:
> > > >
> > > > On Mon, 15 May 2023 at 20:33, Doug Anderson <dianders@chromium.org>=
 wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Mon, May 15, 2023 at 7:42=E2=80=AFAM Amit Pundir <amit.pundir@=
linaro.org> wrote:
> > > > > >
> > > > > > On Sun, 14 May 2023 at 18:11, Caleb Connolly <caleb.connolly@li=
naro.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 13/05/2023 18:08, Amit Pundir wrote:
> > > > > > > > On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > > > > > >>
> > > > > > > >> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: U=
se
> > > > > > > >> PROBE_FORCE_SYNCHRONOUS"). Further digging into the proble=
ms that
> > > > > > > >> prompted the us to switch to synchronous probe showed that=
 the root
> > > > > > > >> cause was a missing "rootwait" in the kernel command line
> > > > > > > >> arguments. Let's reinstate asynchronous probe.
> > > > > > > >
> > > > > > > > Hi, the asynchronous probe is broken on Dragonboard 845c (S=
DM845)
> > > > > > > > running AOSP (Android Open Source Project) with v6.4-rc1
> > > > > > > > https://bugs.linaro.org/show_bug.cgi?id=3D5975.
> > > > > > > > Can we please go back to synchronous probe.
> > > > > > > >
> > > > > > > > AOSP do not make use of rootwait, IIRC, but it is added by =
the
> > > > > > > > bootloader anyway. And the device fails to boot AOSP regard=
less of
> > > > > > > > "rootwait" bootarg being present or not.
> > > > > > >
> > > > > > > Could you try applying this diff to enable some log spam and =
let me know
> > > > > > > what you get? I'm keen to try and figure this one out. My mai=
l client
> > > > > > > might crunch this a bit so I have pasted it here too
> > > > > > > https://p.calebs.dev/ab74b7@raw
> > > > > >
> > > > > > These prints add just enough delay for the UFS probe to succeed=
 that I
> > > > > > can't reproduce the failure anymore.
> > > > >
> > > > > I'd prefer doing at least a little debugging before jumping to a
> > > > > revert. From looking at your dmesg [1], it looks as if the async =
probe
> > > > > is allowing RPMH to probe at the same time as "qcom-vadc-common".
> > > > > That's something that talks on the SPMI bus and is (potentially)
> > > > > talking to the same PMICs that RPMH-regulator is, right? I'm by n=
o
> > > > > means an expert on how Qualcomm's PMICs work, but it seems plausi=
ble
> > > > > that the "qcom-vadc-common" is somehow causing problems and screw=
ing
> > > > > up RPMH. Does that seem plausible to you?
> > > > >
> > > > > If so, one interesting way to track it down would be to move arou=
nd
> > > > > delays. Put ~500ms sleep at the _end_ of vadc_probe(). Presumably=
 that
> > > > > _won't_ fix the problem. Now put a ~500ms sleep at the beginning =
of
> > > > > vadc_probe(). Maybe that will fix the problem? If so, you can mov=
e the
> > > > > delay around to narrow down the conflict. My wild guess would be =
that
> > > > > vadc_reset() could be throwing things for a loop?
> > > > >
> > > > > If the above doesn't work, maybe we could add more tracing / prin=
touts
> > > > > to see what is probing at the same time as RPMH?
> > > >
> > > > Tried out a few changes today but none of them worked or were
> > > > effective enough to debug this crash further, other than setting
> > > > fw_devlink=3Dpermissive.
> > > >
> > > > Adding more tracing / prints (BOOTTIME_TRACING and
> > > > FUNCTION_GRAPH_TRACER) didn't work and didn't help in reproducing t=
he
> > > > crash either. They added just enough delay to boot the device
> > > > successfully everytime.
> > > >
> > > > I tried to reason with the kernel modules which gets loaded before =
and
> > > > after the qcom-rpmh-regulator (QCOM_REBOOT_MODE, QCOM_PON, IIO/VADC=
,
> > > > SPMI_PMIC* etc) as suggested, but I run into the same crash even if=
 I
> > > > disable those driver modules. So I don't think that the other drive=
r
> > > > modules which gets loaded at around the same time as
> > > > qcom-rpmh-regulator by default have any impact on this failure.
> > >
> > > Ugh, Heisenbugs are no fun to debug. :( It sorta sounds as if pretty
> > > much anything you can do to change the timing fixes you. That does
> > > make reverting the async probe of the regulator less appealing. If, a=
s
> > > you said, it's not just some other driver loading at the same time
> > > that's interfering then the revert "fixes" you in the same way that a
> > > "msleep" would fix you. That doesn't seem like enough of a
> > > justification for the revert to me.
> > >
> > > It still feels to me like _something_ is happening at the same time a=
s
> > > the RPMH regulator driver is loading, though, I'm just not sure how t=
o
> > > suggest debugging it. I guess other thoughts:
> > >
> > > * When RPMH complains, is it always with the same regulator (lvs1), o=
r
> > > sometimes different ones? Any clue there?
> >
> > It is always either lvs1 or lvs2.
>
> If you reorder the nodes in the device tree, I think it'll change the
> probe order. Does that affect anything? I'm wondering if there's some
> sort of delayed reaction from a previous regulator.

Hi, Bumping lvs1 and lvs2 regulators up to the top of the list in the
DTS https://bugs.linaro.org/show_bug.cgi?id=3D5975#c4 does seem to work.
I can't reproduce the crash in 125 reboots so far, while I'm still
testing with only qcom-rpmh-regulator kernel module. I'll do some more
testing with full system running and send this re-ordering fix I can't
reproduce the crash further.

>
>
> > > * How much can you control module loading order? If rpmh-regulator
> > > module loads first, does it "fix" things? If it does, maybe you could
> > > bisect to find the place where problems start cropping up. Does that
> > > give any clues?
> >
> > Loading qcom-rpmh-regulator first does make it difficult to reproduce
> > the crash. I tried a few combinations to narrow down the issue further
> > and in one case, I managed to reproduce the crash (1 in 20+ reboots)
> > while loading the qcom-rpmh-regulator (and the dependent cmd-db,
> > qcom_rpmh) module alone
> > https://bugs.linaro.org/attachment.cgi?id=3D1140.
> >
> > Regards,
> > Amit Pundir
>
> OK, now that's even weirder. If loading the module alone reproduces
> the problem, I can't imagine why this would be different without
> "async" probe. In other words, If it reproduces 5% of the time when
> loading the module alone with async probe, I'd expect it to reproduce
> 5% of the time when loading the module alone _without_ async probe
> too.

I don't know the internal workings of forcing an asynchronous or
synchronous probe, but loading this module alone crashed 60 times in
350 reboots with this async patch, while it didn't crash at all in
about 250 reboots if I do PROBE_FORCE_SYNCHRONOUS.

Regards,
Amit Pundir

>
> Note: make sure you're careful to collect more than one reproduction
> before asserting odds. If it reproduced once in 20 reboots, it might
> be 5%, it might be 20%, or it might be .01%. Ideally you could script
> this and let it run for a few hours to get a good reproduction rate?
>
> -Doug
