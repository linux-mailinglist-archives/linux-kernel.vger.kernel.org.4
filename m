Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0806911A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjBITw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBITwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:52:25 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48829A247
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:52:23 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id l201so2750448ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 11:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gak+KHQrZHZhynVQqhTnxuXD1WeJ/HVw4s5OD1Q4rA0=;
        b=ecvGBiwF+i9RZ/cNcnKvKBaPYYMWqSEN94BTyPiLLaKx1ROr1Ed+Qp6E0bb5shUPik
         xCmOmFzs9f9+WPy6cq91ByV5C4EjT/hJaGStK4GEjCBdknjhay7IYsOQ85mfvcK5NWWA
         8MjDzScTQTDOawoRqQ5Dz4NleF0Zi9QlM1zuw3VWM9QsRe5VQB15JcnUZ0i50/dEjKhn
         DHcoOkwjW1mYOAbEA5qj6YvhK6yi4aaM+xhbveIDU46QrwOD6GTaSAsO3SiehiNHCqgS
         5kdOCGXhUo99/ccfUdCcFkETyaW5WhSFZVSsIc74ofUTzmb+WEjZtB/mWekuz6O3NMUq
         1MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gak+KHQrZHZhynVQqhTnxuXD1WeJ/HVw4s5OD1Q4rA0=;
        b=McwIIqLQxoIQbm+LJ8wM35l2dSTTIMyKzT5pAoafw50KtPMoF9yE3Ih81A1yXyriH/
         /LMPCVI172FMU5u3EfWP93KmHaVDincO60Y5UfdgW27r7XojKhooGFJFRIJ0W3zZrDQF
         x2Pez9QTmY2KdcMkXJtZeW8PZKKyom4igTfL8QaYdXQ2kn8d3daelMXN90wNSyov1uwr
         glYr8KM/XfLM1XyIIca7Sj4k7suauotYbohwCV2OfLZlLJo1FllvU6KrcSsj2AnYCQG1
         J0G0REEz24hcO5lOGKHVUTDrhtwSGJ0DLohsKcYn6/CxJRgLVxikbOO6xhvuKJMQj4s7
         7rmw==
X-Gm-Message-State: AO0yUKWepvnR04SCPl3FS8iVqXr+CYeFehBwH1GvXttgbxpWn5VN81N3
        nZ7LIauuG4jB9hfJAgYLo7wKjb1CLaH5eOFLf9DiSg==
X-Google-Smtp-Source: AK7set/dfA0H3z8dZoAmHffHfvJva21U88eArrk+ERDSZ+O6z+2PLNUV4RZPkxrXiyvz0odf7r8/ncU5nx9gtz/D3qI=
X-Received: by 2002:a25:5d02:0:b0:889:f225:d942 with SMTP id
 r2-20020a255d02000000b00889f225d942mr208578ybb.518.1675972342504; Thu, 09 Feb
 2023 11:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20230201152038.203387-1-brgl@bgdev.pl> <20230201152038.203387-6-brgl@bgdev.pl>
 <20230209180456.eahx5fbcd2kax2au@echanude>
In-Reply-To: <20230209180456.eahx5fbcd2kax2au@echanude>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Thu, 9 Feb 2023 20:52:11 +0100
Message-ID: <CACMJSevxZ0_40MwqVSm401=us6dwpKYcuOzFW+Ypks3Ri4eReg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: add initial support for qcom sa8775p-ride
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 19:05, Eric Chanudet <echanude@redhat.com> wrote:
>
> On Wed, Feb 01, 2023 at 04:20:38PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > This adds basic support for the Qualcomm sa8775p platform and the
> > reference board: sa8775p-ride. The dt files describe the basics of the
> > SoC and enable booting to shell.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---

[...]

> > +
> > +             watchdog@17c10000 {
> > +                     compatible = "qcom,apss-wdt-sa8775p", "qcom,kpss-wdt";
> > +                     reg = <0x0 0x17c10000 0x0 0x1000>;
> > +                     clocks = <&sleep_clk>;
> > +                     interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > +             };
>
> Trying this DTS on sa8775p-ride with next-20230209, I get this splat
> with the qcom_wdt:
>
> [    2.667479] Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
> [    2.675911] Modules linked in: qcom_wdt(+) crct10dif_ce socinfo fuse ipv6
> [    2.675931] CPU: 5 PID: 155 Comm: systemd-udevd Not tainted 6.2.0-rc7-next-20230209-00011-g897899f9de9e #80
> [    2.675936] Hardware name: Qualcomm SA8775P Ride (DT)
> [    2.675938] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.675942] pc : qcom_wdt_probe+0x20c/0x388 [qcom_wdt]
> [    2.675964] lr : qcom_wdt_probe+0x308/0x388 [qcom_wdt]
> [    2.675970] sp : ffff80000a4db8e0
> [    2.675971] x29: ffff80000a4db8e0 x28: 0000000000000000 x27: ffff80000a4dbd50
> [    2.675975] x26: 0000000000000000 x25: ffff80000a4dbcd0 x24: ffff060041723680
> [    2.675978] x23: ffff060040c2b400 x22: ffffdc111597c560 x21: ffff060040c2b410
> [    2.675981] x20: ffff060040959e80 x19: 0000000000000000 x18: ffffffffffffffff
> [    2.675984] x17: 0000000000000000 x16: ffffdc116777c59c x15: ffff80000a4db670
> [    2.675987] x14: ffff80008a4db7cd x13: 007473696c5f7974 x12: 0000000000000001
> [    2.675990] x11: 0000000000000040 x10: ffffdc1169893790 x9 : 0000000000000000
> [    2.675994] x8 : ffff0600414ffd80 x7 : 0000000000000000 x6 : 0000000000000000
> [    2.675997] x5 : ffff0600414ffc88 x4 : ffff060040c2b610 x3 : 0000000000007ffc
> [    2.676001] x2 : 0000000000000001 x1 : 000000000000000c x0 : ffff800008f5d00c
> [    2.676004] Call trace:
> [    2.676006]  qcom_wdt_probe+0x20c/0x388 [qcom_wdt]
> [    2.676013]  platform_probe+0x68/0xc4
> [    2.676026]  really_probe+0x148/0x2ac
> [    2.676038]  __driver_probe_device+0x78/0xe0
> [    2.676042]  driver_probe_device+0x3c/0x15c
> [    2.676045]  __driver_attach+0x94/0x19c
> [    2.676048]  bus_for_each_dev+0x74/0xcc
> [    2.676052]  driver_attach+0x24/0x30
> [    2.676055]  bus_add_driver+0x104/0x204
> [    2.676059]  driver_register+0x68/0x12c
> [    2.676063]  __platform_driver_register+0x28/0x34
> [    2.676065]  qcom_watchdog_driver_init+0x20/0x1000 [qcom_wdt]
> [    2.676072]  do_one_initcall+0x80/0x1c4
> [    2.676081]  do_init_module+0x58/0x1e8
> [    2.676088]  load_module+0x19d4/0x1a18
> [    2.676091]  __do_sys_finit_module+0xa8/0xfc
> [    2.676095]  __arm64_sys_finit_module+0x20/0x2c
> [    2.676098]  invoke_syscall+0x48/0x114
> [    2.676107]  el0_svc_common.constprop.0+0xcc/0xec
> [    2.676110]  do_el0_svc+0x38/0x98
> [    2.676113]  el0_svc+0x2c/0x84
> [    2.676121]  el0t_64_sync_handler+0xf4/0x120
> [    2.676123]  el0t_64_sync+0x190/0x194
> [    2.676129] Code: f94002c1 f9006a81 b9400821 8b010000 (b9400000)
> [    2.676135] ---[ end trace 0000000000000000 ]---
>
> I most likely did not see it before as I either had qcom_wdt configured
> out or disabled on the kernel cmdline.
>

On Bjorn's board I can probe the watchdog and even trigger it from
user-space (although it doesn't seem to reset the board, it just
freezes - not sure if that's not Bjorn's setup as rebooting the board
from console doesn't work either).

Can this be the hypervisor's doing?

Bart

[...]
