Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786F5E8F83
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiIXTdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 15:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIXTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 15:33:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75AA3D598
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 12:33:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u24so4199172edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=b3WEmj6gVYJFHvtqK6Sfi5cCnTdRgSOTWD5HlqEFhns=;
        b=OcBiWRl7Fca3gtIGC1OucZr+6e5jfV0zeXJN3yOXh1Ga4DOV4QHrc/L9ogpTEsJnlx
         8MHTTXkeCSThU+cAB94hB/8t5Zp7JBSTtVqP3htCZ3F53GUmb4jKQL3i39/erJH/xDwa
         vLk6h7cqvbOTUkoydRwfzVduLCvS+H7HA1g2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=b3WEmj6gVYJFHvtqK6Sfi5cCnTdRgSOTWD5HlqEFhns=;
        b=0r2y7vTjztXlXkaElqxaDcrwtEPjr/VhEOGHl+mDiAM+v4A7mNWWckJj8cmk5drSVe
         McYSL5jjXbI3ni87loeZRotW1vhAsaUT1ej0uC7Ec8qdVhnfCebWLjIDrlvMOvUOag2l
         uDWTxt+qiFHUKEZk9WdqX8Fk5hiXQKjlN7GC23yUaDjTanPrMfFkDSXPm41SIi7qu2/M
         P/g9cepFQlksqMnEQx277XY9NytQoTiz21UNx4tIf8j/+DFjVipm9fWtGBwAg9+FvS9X
         EQCtmYE7yzwOpCqzTGq3AyGwTZfa9wucuevFVJF/ArHwb2dpu9aKWNNj6iwLzpcCK29a
         3rKg==
X-Gm-Message-State: ACrzQf1v+h+AaL/4IEZT49AvH7ZedonFt0JqMU4BQsXBhruoJufSfzj6
        wQZAENvE5bFs5Sk/HdXsPSH/FPt9VgAaDdS5ymBXZb5Ngm0=
X-Google-Smtp-Source: AMsMyM6Om/0n8+Ox5r2SG614bDow4HXa7ui0IpvipRP26KKDpqbOU/XydAZjrHJ9DJ/horatku2uhAYpjSucKQ8KAl0=
X-Received: by 2002:a05:6402:1e8c:b0:44f:f70:e75e with SMTP id
 f12-20020a0564021e8c00b0044f0f70e75emr14452277edf.405.1664048009317; Sat, 24
 Sep 2022 12:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
 <CAOf5uwnfCCwHjSXTurMtyEpZc_tF8bH=fxfwBzOtHcfM_S4tYg@mail.gmail.com>
 <CAOf5uw=_+WQO7qH_Bxs5qEBn2_nemzuLiXdYe8+W_+OnFZNYkw@mail.gmail.com> <fb52982c-745e-ef9b-6258-0870d00a744b@linaro.org>
In-Reply-To: <fb52982c-745e-ef9b-6258-0870d00a744b@linaro.org>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sat, 24 Sep 2022 21:33:18 +0200
Message-ID: <CAOf5uwnVZxYGDfph6wKKpF413obt3786WPMn8mnSdizKe=XkzQ@mail.gmail.com>
Subject: Re: v6.0-rc6 - arm64 / rock960 : kernel panic
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Heiko St??bner" <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Sat, Sep 24, 2022 at 8:48 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 24/09/2022 20:01, Michael Nazzareno Trimarchi wrote:
> > On Sat, Sep 24, 2022 at 7:58 PM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> >>
> >> Hi Daniel
> >>
> >> On Sat, Sep 24, 2022 at 7:43 PM Daniel Lezcano
> >> <daniel.lezcano@linaro.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> there is a kernel panic on a rock960 board:
> >>>
> >>> After git bisecting, I have:
> >>>
> >>> commit 14facbc1871ae15404666747b5319c08e04b875a
> >>> Merge: f5c97da8037b 32346491ddf2
> >>> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Date:   Mon Jul 11 08:32:58 2022 +0200
> >>>
> >>>       Merge 5.19-rc6 into char-misc-next
> >>>
> >>>       We need the misc driver fixes in here as well.
> >>>
> >>>       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>
> >>> Any clue?
> >>
> >> That code receive 3-4 commits for one fix
> >>
> >> diff --git a/sound/soc/rockchip/rockchip_i2s.c
> >> b/sound/soc/rockchip/rockchip_i2s.c
> >> index f5f3540a9e18..a32a45b09b03 100644
> >> --- a/sound/soc/rockchip/rockchip_i2s.c
> >> +++ b/sound/soc/rockchip/rockchip_i2s.c
> >> @@ -803,7 +803,7 @@ static int rockchip_i2s_probe(struct platform_devi=
ce *pdev)
> >>
> >>          i2s->bclk_ratio =3D 64;
> >>          i2s->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> >> -       if (!IS_ERR(i2s->pinctrl)) {
> >> +       if (!IS_ERR_OR_NULL(i2s->pinctrl)) {
> >>                  i2s->bclk_on =3D pinctrl_lookup_state(i2s->pinctrl, "=
bclk_on");
> >>                  if (!IS_ERR_OR_NULL(i2s->bclk_on)) {
> >>                          i2s->bclk_off =3D
> >> pinctrl_lookup_state(i2s->pinctrl, "bclk_off");
> >
> > I don't sure if you can get null from there, but you have two
> > lookup_state on that function
>
>
> Hmm, actually, I think it is not the same kernel panic I'm observing on
> v6.0-rc6.
>
> I've been puzzled by different kernel panics from different issues when
> git bisecting.
>
> The one happening is:
>
> [    2.471037] rk808-rtc rk808-rtc: setting system clock to
> 2022-09-24T18:41:07 UTC (1664044867)
> [    2.485859] usbcore: registered new interface driver uvcvideo
> [    3.726846] Unable to handle kernel execute from non-executable
> memory at virtual address ffff80000a516530
> [    3.728032] Mem abort info:
> [    3.728308]   ESR =3D 0x000000008600000f
> [    3.728667]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> [    3.729169]   SET =3D 0, FnV =3D 0
> [    3.729466]   EA =3D 0, S1PTW =3D 0
> [    3.729770]   FSC =3D 0x0f: level 3 permission fault
> [    3.730223] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000005f4=
2000
> [    3.730846] [ffff80000a516530] pgd=3D10000000f7fff003,
> p4d=3D10000000f7fff003, pud=3D10000000f7ffe003, pmd=3D10000000f7ff9003,
> pte=3D0078000006516f03
> [    3.732063] Internal error: Oops: 8600000f [#1] PREEMPT SMP
> [    3.732588] Modules linked in:
> [    3.732918] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.0.0-rc1+ #730
> [    3.733532] Hardware name: 96boards Rock960 (DT)
> [    3.733971] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [    3.734635] pc : extcon_dev_list+0x0/0x10
> [    3.735056] lr : call_timer_fn.constprop.0+0x24/0x80
> [    3.735551] sp : ffff80000a733ab0
> [    3.735869] x29: ffff80000a733ab0 x28: 0000000000000005 x27:
> ffff80000a516530
> [    3.736574] x26: ffff80000a3779c0 x25: ffff0000f776dde8 x24:
> ffff80000a733b40
> [    3.737277] x23: 0000000000000000 x22: dead000000000122 x21:
> 0000000000000101
> [    3.737977] x20: ffff000000644600 x19: ffff80000a516530 x18:
> ffffffffffffffff
> [    3.738677] x17: ffff8000ed713000 x16: ffff80000800c000 x15:
> 0000000000004000
> [    3.739377] x14: 0000000000000000 x13: 0000000000000000 x12:
> 0000000000000000
> [    3.740073] x11: 00000000000000b7 x10: ffff8000ed713000 x9 :
> ffff0000f776de30
> [    3.740771] x8 : 0000000000000001 x7 : ffffffffffffffff x6 :
> 0000000000000000
> [    3.741469] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> 0000000000000200
> [    3.742164] x2 : 0000000000000200 x1 : ffff80000a516530 x0 :
> ffff0000007e7310
> [    3.742865] Call trace:
> [    3.743107]  extcon_dev_list+0x0/0x10
> [    3.743477]  __run_timers.part.0+0x1f0/0x234
> [    3.743908]  run_timer_softirq+0x3c/0x7c
> [    3.744306]  _stext+0x124/0x2a4
> [    3.744627]  __irq_exit_rcu+0xcc/0xfc
> [    3.745008]  irq_exit_rcu+0x10/0x20
> [    3.745372]  el1_interrupt+0x38/0x70
> [    3.745733]  el1h_64_irq_handler+0x18/0x24
> [    3.746140]  el1h_64_irq+0x64/0x68
> [    3.746484]  arch_cpu_idle+0x18/0x2c
> [    3.746843]  default_idle_call+0x34/0x70
> [    3.747243]  do_idle+0x240/0x2bc
> [    3.747576]  cpu_startup_entry+0x24/0x30
> [    3.747969]  secondary_start_kernel+0x12c/0x140
> [    3.748421]  __secondary_switched+0xb0/0xb4
> [    3.748879] Code: 0a516520 ffff8000 0a516520 ffff8000 (007e7320)
> [    3.749461] ---[ end trace 0000000000000000 ]---
> [    3.749911] Kernel panic - not syncing: Oops: Fatal exception in
> interrupt

Now it's totally different. Anyway, my last comment was wrong totally

Michael

> [    3.750548] SMP: stopping secondary CPUs
> [    3.751094] Kernel Offset: 0x80000 from 0xffff800008000000
> [    3.751609] PHYS_OFFSET: 0x0
> [    3.751889] CPU features: 0x2000,0824f021,00001082
> [    3.752354] Memory Limit: none
> [    3.752655] ---[ end Kernel panic - not syncing: Oops: Fatal
> exception in interrupt ]---
>
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
