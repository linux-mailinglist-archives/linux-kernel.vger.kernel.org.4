Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385B267112E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjARCbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjARCbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:31:08 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048384FAF3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:31:05 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 20so17439064ybl.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnaUf3QSVN2saLT2ffyfJ60ASojbZ1sd/IBl8PiiSXs=;
        b=SJwcydLYElPFNUtH9vShrHDvyVLBsxBJ4Tbx9UF+Cj+Fka+ZodXAQccK+rD6Tvrvre
         WBwvq2CvH2p44bHs9kM3p6pxcQ3iQ9OL0FtCP/YoVSxgii4oj3OKcTe5YF3a0uqjR28c
         dgRPdqgDrkYZqvylRNmUupYXs4J0OG64qJPelFwR+94bRwlFhIRu8EXO5aDcfduMQlJj
         eIvNjQcMDqQe9/tPwjzPiueUi0aTKjMhdTN91iq9hIW7HL6pepDiH+OiK9fWdoQTBmC/
         Pp9+qLpaHZoQt52AdthBDx8+wjR3l0E+zPA9DvvP0EUDa/QXOOa7L50GhQxsRXXDL3Bt
         N/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnaUf3QSVN2saLT2ffyfJ60ASojbZ1sd/IBl8PiiSXs=;
        b=phF5WE3vOZGo6B7v+59SRi9jrjokSaKYfKX6wAz40JXbG8a2BqngTWLe/ka2PAjYUW
         n/J784OwrSSAY2T/xxmup8OMJtUvLiWiuTU+/TyaaFHvWC19AwPKP7Sf5H8JTZIqXzcz
         +0ICaHhkCX+few3i01vhqC74GjdEoVBezSDrRjTXPF5VnegH782oUjfMQ7mqBKALKorO
         kd0EGvLlD5kRtPFbT+t1RCERRejJdDeJlvWwXWDzLbDD9xZ5oWo75hnux94VxK4tACsx
         DQKAtXUpZBpqP4molw36NAZvI7HnB4DJmlz6+chePlpt8slYOPujIxDEz8MFZHuAEa9F
         hdaw==
X-Gm-Message-State: AFqh2krlxo99p+CILfoTWL0dMNYWZ6MDP4EiifD3oez/P3L5tZCWKcQC
        Rzht9EVTJgBU/m/YeEjaszYuJxTKp0O5z4NpnhnFrg==
X-Google-Smtp-Source: AMrXdXs1lNfCBcr7LYUIuPyvtZB23DXwSuKFBjAl9Hh1uvQ+oOlwxrTdcHGJ40bPv+te+6cIe/6LJ2EFM5yG+OQHSS4=
X-Received: by 2002:a5b:f11:0:b0:7f3:de9b:de11 with SMTP id
 x17-20020a5b0f11000000b007f3de9bde11mr315627ybr.544.1674009064182; Tue, 17
 Jan 2023 18:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20230113083115.2590-1-nylon.chen@sifive.com> <Y8GjySjm9OjoZvCF@spud>
 <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
In-Reply-To: <95F1EAA0-D8D6-4F8A-8049-5E7BFDE4C06C@jrtc27.com>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Wed, 18 Jan 2023 10:30:52 +0800
Message-ID: <CAHh=Yk8=-LvJ3ygC8aK6y7FBFaOyiZ1UQY9PSXWwNwJAWYJW8w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Change PWM-controlled LED pin active mode and algorithm
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jess,

as you said, I use LED directly connected to PWM logic to modify it.

As I stated in my previous article, the key is that the lower the PWM
output is, the brighter the LED light is(active-low), the higher the
PWM output is, the brighter the LED light is(active-high).

Therefore, I would point out the waveform diagram below, the output
result remains the same for the circuit, but when you use
active-low/active-high to look at it, you will get two completely
different results of brightness.

e.g. duty=3D30s, period=3D100s, actvie-high =3D 30%, active-low =3D 70%

V
^
|
| ----------|
|             |
|             |
|______ |__________ > t

Jessica Clarke <jrtc27@jrtc27.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=8814=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 13 Jan 2023, at 18:32, Conor Dooley <conor@kernel.org> wrote:
> >
> > +CC Uwe, Thierry, linux-pwm
> >
> > Hey Nylon,
> >
> > Please run scripts/get_maintainer.pl before sending patches, you missed
> > both me & the PWM maintainers unfortunately!
> > AFAIK, the PWM maintainers use patchwork, so you will probably have to
> > resend this patchset so that it is on their radar.
> > I've marked the series as "Changes Requested" on the RISC-V one.
> >
> > On Fri, Jan 13, 2023 at 04:31:13PM +0800, Nylon Chen wrote:
> >
> >> According to the circuit diagram of User LEDs - RGB described in the
> >> manual hifive-unmatched-schematics-v3.pdf[0].
> >> The behavior of PWM is acitve-high.
> >>
> >> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
> >> Manual[1].
> >> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) period=
[2].
> >> The `frac` variable is pulse "inactive" time so we need to invert it.
> >>
> >> So this patchset removes active-low in DTS and adds reverse logic to
> >> the driver.
> >>
> >> [0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unma=
tched/hifive-unmatched-schematics-v3.pdf
> >> [1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unma=
tched/fu740-c000-manual-v1p2.pdf
> >> [2]:https://en.wikipedia.org/wiki/Duty_cycle
> >
> > Please delete link 2, convert the other two to standard Link: tags and
> > put this information in the dts patch. Possibly into the PWM patch too,
> > depending on what the PWM maintainers think.
> > This info should be in the commit history IMO and the commit message fo=
r
> > the dts patch says what's obvious from the diff without any explanation
> > as to why.
> >
> > I did a bit of looking around on lore, to see if I could figure out
> > why it was done like this in the first place, and I found:
> > https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX=
70=3DUaSbGCMMF_g@mail.gmail.com/
>
> That DTS documentation makes no sense to me, why does what the LED is
> wired to matter? Whether you have your transistor next to ground or
> next to Vdd doesn=E2=80=99t matter, what matters is whether the transisto=
r is
> on or off. Maybe what they mean is whether the *PWM's output* / *the
> transistor's input* is pulled to ground or Vdd? In which case the
> property would indeed not apply here.
>
> Unless that=E2=80=99s written assuming the LED is wired directly to the P=
WM, in
> which case it would make sense, but that=E2=80=99s a very narrow-minded v=
iew of
> what the PWM output is (directly) driving.
>
> Jess
>
> > That doesn't explain the driver, but it does explain the dts being that
> > way. Perhaps a Fixes tag is also in order? But only if both patches get
> > one, otherwise backporting would lead to breakage.
> >
> > The min() construct appears to have been there since the RFC driver was
> > first posted.
> >
> > Thanks,
> > Conor.
> >
> >>
> >> Nylon Chen (2):
> >>  riscv: dts: sifive unmatched: Remove PWM controlled LED's active-low
> >
> > nit: s/sifive unmatched:/sifive: unmatched:/
> >
> >>    properties
> >>  pwm: sifive: change the PWM controlled LED algorithm
> >>
> >> arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
> >> drivers/pwm/pwm-sifive.c                            | 1 +
> >> 2 files changed, 1 insertion(+), 4 deletions(-)
> >>
> >> --
> >> 2.36.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
