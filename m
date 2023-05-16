Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834387055BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjEPSMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEPSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:12:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5288886AB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:12:36 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-623836551f5so1638566d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684260755; x=1686852755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/51qZoBKoWvqhRdHDJ3zf60Mtxm0FPSvObeb2MuphQg=;
        b=utKO6x8hMlRvPLUDZNlGIPqWTHo4SRh0ysOIx5RAtDZIS9Z3pfTRPZ1oNemrpfDfQ1
         hhv0HwHYM5laKMIFeJUR0JZKsn7HCcKVluoGazwjjqxohAQlVUaLQd+rz3qolUfjCyar
         QV2hHK9VX5Fji8y08JA/iE8T5E2K2WOubl9A0QlZUS8EkgeA/KV1jJa/MMNssZ+kBFuL
         TZp62dXnDgMuNnqh3kqsqnaLYRLFjInIzA95HXVD9UC6MOQ65704C02iG/ROD6gMKiFw
         Z/rVfxY3JeynBtxRfWc3WidF39q1vUtWak7tRO0gF8raoCgsqBDq888baVdtRMjrqNAm
         ohyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260755; x=1686852755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/51qZoBKoWvqhRdHDJ3zf60Mtxm0FPSvObeb2MuphQg=;
        b=WcqmJGnT3ifFoDsmHGCoYHoqPe4nWzs3VaRdv8mDxTkGgIxiwkIjMVUEncb2DYqvoi
         Xed1mYHEj9cmxGeb9czsy+XRWf7+UuqL9hNCa2j/7jVRE2BIvmVMaBZ1Ru5vxV3/RH1M
         8yiYguf5fwz99JWAJCkzn993blsIqOp8J89anSEmGZ74xB60KQqjjmZpp0dfjazlG9tE
         MiTy+UTGME1DpThgkqM4nhYaplDWiiOrCapObzsaSSB35fN2VRcKZss12oGp+VDs3EKV
         RsrsSNCCar2wUibzuePMCzuxoGxZAKAPZifRpU0C4f45VjISvZtTBXuucktP3l+/W+t/
         gjxg==
X-Gm-Message-State: AC+VfDw4++sdGHHq8eifvXDmDx28zxMQFAUFn3HAxORaAOIaLhX4hWgJ
        7qGspQ302LTsNRidWEBDLZXEMWjhuYQtK8ZP7vmasQ==
X-Google-Smtp-Source: ACHHUZ6+0z2An4TnM+LfxQolPm6bsi9QmwTbeQmiWnzdzuUz8m92/LFdYSupeJkqCo1YfXgfheStW1NDZM+A3OoMHhw=
X-Received: by 2002:a05:6214:caa:b0:61b:6c88:4bd3 with SMTP id
 s10-20020a0562140caa00b0061b6c884bd3mr70597809qvs.47.1684260755334; Tue, 16
 May 2023 11:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
 <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org> <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
In-Reply-To: <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 16 May 2023 23:41:58 +0530
Message-ID: <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
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

On Mon, 15 May 2023 at 20:33, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, May 15, 2023 at 7:42=E2=80=AFAM Amit Pundir <amit.pundir@linaro.o=
rg> wrote:
> >
> > On Sun, 14 May 2023 at 18:11, Caleb Connolly <caleb.connolly@linaro.org=
> wrote:
> > >
> > >
> > >
> > > On 13/05/2023 18:08, Amit Pundir wrote:
> > > > On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@chromium.o=
rg> wrote:
> > > >>
> > > >> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
> > > >> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems that
> > > >> prompted the us to switch to synchronous probe showed that the roo=
t
> > > >> cause was a missing "rootwait" in the kernel command line
> > > >> arguments. Let's reinstate asynchronous probe.
> > > >
> > > > Hi, the asynchronous probe is broken on Dragonboard 845c (SDM845)
> > > > running AOSP (Android Open Source Project) with v6.4-rc1
> > > > https://bugs.linaro.org/show_bug.cgi?id=3D5975.
> > > > Can we please go back to synchronous probe.
> > > >
> > > > AOSP do not make use of rootwait, IIRC, but it is added by the
> > > > bootloader anyway. And the device fails to boot AOSP regardless of
> > > > "rootwait" bootarg being present or not.
> > >
> > > Could you try applying this diff to enable some log spam and let me k=
now
> > > what you get? I'm keen to try and figure this one out. My mail client
> > > might crunch this a bit so I have pasted it here too
> > > https://p.calebs.dev/ab74b7@raw
> >
> > These prints add just enough delay for the UFS probe to succeed that I
> > can't reproduce the failure anymore.
>
> I'd prefer doing at least a little debugging before jumping to a
> revert. From looking at your dmesg [1], it looks as if the async probe
> is allowing RPMH to probe at the same time as "qcom-vadc-common".
> That's something that talks on the SPMI bus and is (potentially)
> talking to the same PMICs that RPMH-regulator is, right? I'm by no
> means an expert on how Qualcomm's PMICs work, but it seems plausible
> that the "qcom-vadc-common" is somehow causing problems and screwing
> up RPMH. Does that seem plausible to you?
>
> If so, one interesting way to track it down would be to move around
> delays. Put ~500ms sleep at the _end_ of vadc_probe(). Presumably that
> _won't_ fix the problem. Now put a ~500ms sleep at the beginning of
> vadc_probe(). Maybe that will fix the problem? If so, you can move the
> delay around to narrow down the conflict. My wild guess would be that
> vadc_reset() could be throwing things for a loop?
>
> If the above doesn't work, maybe we could add more tracing / printouts
> to see what is probing at the same time as RPMH?

Tried out a few changes today but none of them worked or were
effective enough to debug this crash further, other than setting
fw_devlink=3Dpermissive.

Adding more tracing / prints (BOOTTIME_TRACING and
FUNCTION_GRAPH_TRACER) didn't work and didn't help in reproducing the
crash either. They added just enough delay to boot the device
successfully everytime.

I tried to reason with the kernel modules which gets loaded before and
after the qcom-rpmh-regulator (QCOM_REBOOT_MODE, QCOM_PON, IIO/VADC,
SPMI_PMIC* etc) as suggested, but I run into the same crash even if I
disable those driver modules. So I don't think that the other driver
modules which gets loaded at around the same time as
qcom-rpmh-regulator by default have any impact on this failure.

The only way I can boot successfully everytime is if I boot with
fw_devlink=3Dpermissive bootarg. So I'll have to check if there is any
new dependency which got added recently in DT or somewhere else that
is causing this breakage.

Regards,
Amit Pundir

>
>
> [1] https://bugs.linaro.org/attachment.cgi?id=3D1135
