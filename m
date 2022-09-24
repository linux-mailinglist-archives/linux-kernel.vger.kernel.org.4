Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663C45E8F1A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIXR6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiIXR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:58:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2186B1D326
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 10:58:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b35so4122388edf.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ppdXRhrZX6YkbGx8ABHdZLmPxNthtMxII17ACdrNAnA=;
        b=g3hJpPpPMRB+LgwkVu6Dv0moAzILn5Sau5vUoG102hDkU7QqWnr3Q/OuJ3G55LaHaQ
         K1SafKYWjsEYWVcZZfWCdR0jd8+Io/JBHd2/jJuUgUPcp3SDPYKgvVbLzJRIquvTbW88
         mhdXK/upUVR3LngqZKtUrcnljuPk3T5WbRkvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ppdXRhrZX6YkbGx8ABHdZLmPxNthtMxII17ACdrNAnA=;
        b=OFBBwdMn6qQqfZPmfolgqBn7jAVfvhyiyt6vM/ptNGV4oraiC5bAhV0PnU4DHDsYO/
         AXFCyNbDxnrUwvIfob4Oxqn4gBytwphdQwM8QXQ0DKJAPkEu0o8VU3rgqqSlVq8NuQYz
         bLTSZX+AJqBcYBDWCmcIUMiDM7OOJrA+WkCuEEHWm9vZFJ/4dCFi3S+PugNYdCwPMsln
         58QMHuCFYG+ixS3MOvGDHqR73JKLAXQxnGE6hiY9Od74Pjx9TVpHXSXpA0YYkGnGLfUB
         NkaKVJQkQBJehY26bkwoWZGk0SZRyM6U0e+lmAipc3OONlH7PcZqed5oKh9pCQqP9gZG
         SDbg==
X-Gm-Message-State: ACrzQf3h4y3jtpM/s1nPKh68U3tTLIHKCpMMv5bujNvm8ra4U5r59QL9
        XYiqsSBwkvsJomlB3TgNVHVYeGZdS7MvbmbsNlS+Cw==
X-Google-Smtp-Source: AMsMyM5ROxQEmdZJXnyUgb3ZwykC86BjJSpx51yOkCqjy0OJmuOBQtgGUaL+g0mEx1jGQ2cTQRwKwzKyNeJxNuhnkSk=
X-Received: by 2002:aa7:cad5:0:b0:454:88dc:2c22 with SMTP id
 l21-20020aa7cad5000000b0045488dc2c22mr14507528edt.352.1664042317593; Sat, 24
 Sep 2022 10:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
In-Reply-To: <4f398e4c-973b-7843-2f75-27324d109277@linaro.org>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Sat, 24 Sep 2022 19:58:26 +0200
Message-ID: <CAOf5uwnfCCwHjSXTurMtyEpZc_tF8bH=fxfwBzOtHcfM_S4tYg@mail.gmail.com>
Subject: Re: v6.0-rc6 - arm64 / rock960 : kernel panic
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Heiko St??bner" <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
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

Hi Daniel

On Sat, Sep 24, 2022 at 7:43 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi,
>
> there is a kernel panic on a rock960 board:
>
> After git bisecting, I have:
>
> commit 14facbc1871ae15404666747b5319c08e04b875a
> Merge: f5c97da8037b 32346491ddf2
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Mon Jul 11 08:32:58 2022 +0200
>
>      Merge 5.19-rc6 into char-misc-next
>
>      We need the misc driver fixes in here as well.
>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Any clue?

That code receive 3-4 commits for one fix

diff --git a/sound/soc/rockchip/rockchip_i2s.c
b/sound/soc/rockchip/rockchip_i2s.c
index f5f3540a9e18..a32a45b09b03 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -803,7 +803,7 @@ static int rockchip_i2s_probe(struct platform_device *p=
dev)

        i2s->bclk_ratio =3D 64;
        i2s->pinctrl =3D devm_pinctrl_get(&pdev->dev);
-       if (!IS_ERR(i2s->pinctrl)) {
+       if (!IS_ERR_OR_NULL(i2s->pinctrl)) {
                i2s->bclk_on =3D pinctrl_lookup_state(i2s->pinctrl, "bclk_o=
n");
                if (!IS_ERR_OR_NULL(i2s->bclk_on)) {
                        i2s->bclk_off =3D
pinctrl_lookup_state(i2s->pinctrl, "bclk_off");

Michael

>
>
> [    2.377386] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000005
> [    2.377390] Mem abort info:
> [    2.377392]   ESR =3D 0x0000000096000004
> [    2.379529]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    2.379994]   SET =3D 0, FnV =3D 0
> [    2.380263]   EA =3D 0, S1PTW =3D 0
> [    2.380538]   FSC =3D 0x04: level 0 translation fault
> [    2.380964] Data abort info:
> [    2.381217]   ISV =3D 0, ISS =3D 0x00000004
> [    2.381343] mmc2: SDHCI controller on fe330000.mmc [fe330000.mmc]
> using ADMA
> [    2.381558]   CM =3D 0, WnR =3D 0
> [    2.382426] [0000000000000005] user address but active_mm is swapper
> [    2.382981] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    2.383468] Modules linked in:
> [    2.383740] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc6+ #728
> [    2.384311] Hardware name: 96boards Rock960 (DT)
> [    2.384715] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> [    2.385323] pc : pinctrl_lookup_state+0x20/0xc0
> [    2.385729] lr : rockchip_i2s_probe+0x1a8/0x54c
> [    2.386130] sp : ffff80000804bb30
> [    2.386420] x29: ffff80000804bb30 x28: 0000000000000000 x27:
> ffff800009f204c8
> [    2.387048] x26: ffff800009fc1060 x25: ffff800009fc1078 x24:
> ffff000002691b68
> [    2.387673] x23: ffff800009967938 x22: ffffffffffffffed x21:
> ffff800009e1e0e8
> [    2.388299] x20: ffffffffffffffed x19: ffff000002597480 x18:
> ffffffffffffffff
> [    2.388924] x17: 000000040044ffff x16: 00400034b5503510 x15:
> ffff80008804b787
> [    2.389550] x14: 0000000000000000 x13: 6c7274636e697020 x12:
> 73326920646e6966
> [    2.390176] x11: 206f742064656c69 x10: 6166203a7332692e x9 :
> 656c696166203a73
> [    2.390801] x8 : 32692e3030303061 x7 : 205d363238363733 x6 :
> ffff000001657880
> [    2.391425] x5 : 0000000000000000 x4 : 0000000000000000 x3 :
> 0000000000000000
> [    2.392051] x2 : 0000000000000000 x1 : ffff800009e1e0e8 x0 :
> ffffffffffffffed
> [    2.392677] Call trace:
> [    2.392892]  pinctrl_lookup_state+0x20/0xc0
> [    2.393261]  rockchip_i2s_probe+0x1a8/0x54c
> [    2.393629]  platform_probe+0x68/0xe0
> [    2.393954]  really_probe.part.0+0x9c/0x2ac
> [    2.394321]  __driver_probe_device+0x98/0x144
> [    2.394703]  driver_probe_device+0xac/0x140
> [    2.395070]  __driver_attach+0xf8/0x1a0
> [    2.395407]  bus_for_each_dev+0x70/0xd0
> [    2.395746]  driver_attach+0x24/0x30
> [    2.396063]  bus_add_driver+0x150/0x200
> [    2.396401]  driver_register+0x78/0x130
> [    2.396737]  __platform_driver_register+0x28/0x34
> [    2.397150]  rockchip_i2s_driver_init+0x1c/0x28
> [    2.397550]  do_one_initcall+0x50/0x1c0
> [    2.397890]  kernel_init_freeable+0x208/0x28c
> [    2.398274]  kernel_init+0x28/0x13c
> [    2.398583]  ret_from_fork+0x10/0x20
> [    2.398901] Code: aa0003f4 a9025bf5 aa0003f6 aa0103f5 (f8418e93)
> [    2.399435] ---[ end trace 0000000000000000 ]---
> [    2.399887] Kernel panic - not syncing: Attempted to kill init!
> exitcode=3D0x0000000b
> [    2.400555] SMP: stopping secondary CPUs
> [    2.400984] Kernel Offset: 0x80000 from 0xffff800008000000
> [    2.401463] PHYS_OFFSET: 0x0
> [    2.401716] CPU features: 0x800,00127811,00001082
> [    2.402128] Memory Limit: none
> [    2.402406] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=3D0x0000000b ]---
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip



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
