Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5E86A4CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjB0VIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0VH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:07:59 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370F09EEB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:07:57 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536b7ffdd34so213040007b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 13:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aiNe+f5/JwMtmtlBnTt/k8nUxC9woJyKi7hrIG44c/I=;
        b=BVSHd45cd8MM7yZ/6OsCO+E43pozyPR6LQwfodYAty9RD95WYi/W9M4p9HQIQcjA1I
         LtAjSgZN6mJjZMypgxUuY1iYwddQmaTSf5PVx/SxaXpokPlsD9+Q5/zf4xNpnn5v+FUy
         qwMQiedHyUleb/srXtEXXAsN6zguJSs4PQfvf1sHUZhVPAuASJw1/DxwWPj3CTRz9hfp
         c1vCxrG54GYlHNYkNcnEi14McH8QIv967HWc9M6HDbCiREmE5Gw/ecIIOAlTPWF+A7MB
         5QhmLLt7TGuPvQKYDyRWOMFbDp6p8QcfVARR+ahi1nRHhni9Uhc+h8HA1h+HmU+l36OJ
         GkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiNe+f5/JwMtmtlBnTt/k8nUxC9woJyKi7hrIG44c/I=;
        b=xllvw2JdaWu0zBaSnvTaC5pYwBafh6p8DHXnkfGhdtJL2LP28QLTicM3XoTT6/2UP3
         m6HXIHAFVoR8uQs5RjJs7OaLrXMmoovwmdirMI/NAvyukYkNm+DCoIQ8s+Gx7JLfJoPY
         BTT4DHO5BpKGZ5gyIm6lQM0aCNZcogycg0UcHCApenlyeVtbbqDzj/b3r/NXmKMPCKXJ
         4eELcL6tlzZWc+DRrXh7At6BwbtvwJIp7RHmXR+xUnAPpX+LfuPkZEXTdI8i8kzvFeOD
         wySQ6o3B35w7gpi+9vCCe/NcZvCOjvU5OvjSvmgLQVaf13U3F8uOksqeyuP87krCEaeY
         /Etg==
X-Gm-Message-State: AO0yUKVj6tVI2Jh8sDdiG+BYYUA8vTQQ/ujzZR9k9bPVVp+cnjVXudf0
        sshcUymJTOa2ZSWSDAb86xY9Vf7Kuss372DpowJftQ==
X-Google-Smtp-Source: AK7set/bmnLQ2gdckvIvNCPprSzIbIG+3P0OYf11xaScjmmvRAj5udKrfmGk3Sdvi/6YbbOW3ILpfkQ6dqTXkLEppgA=
X-Received: by 2002:a81:b664:0:b0:52e:cea7:f6e3 with SMTP id
 h36-20020a81b664000000b0052ecea7f6e3mr56417ywk.10.1677532076381; Mon, 27 Feb
 2023 13:07:56 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
 <CAGETcx-Ws4zZJ-KWoOLM6ELpyM6pWh7cfRWaYB1zrtTn5sov+w@mail.gmail.com> <CACRpkdaw9uJHgMVMdXcwu83fV83uo8r5vtYC8UmO6w=MaWaFdw@mail.gmail.com>
In-Reply-To: <CACRpkdaw9uJHgMVMdXcwu83fV83uo8r5vtYC8UmO6w=MaWaFdw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 27 Feb 2023 22:07:44 +0100
Message-ID: <CACRpkdbkM1ipwnerQBK86Azziz+reNhbkfXMWVmNOjc+-FMnzw@mail.gmail.com>
Subject: Re: Regression in probing some AMBA devices possibly devlink related
To:     Saravana Kannan <saravanak@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 10:55 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Feb 26, 2023 at 12:56 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Sat, Feb 25, 2023 at 6:29 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > Hi Saravana,
> > >
> > > I have a boot regression for Ux500 on mainline, but bisecting mainline
> > > isn't quite working for misc reasons :/
> > >
> > > I'm not sure about this regression, but it smells like devlink-related.
> > >
> > > Ux500 have a bunch of normal and some AMBA devices. After
> > > boot this happens and we hang waiting for rootfs (which is on eMMC):
> >
> > Hmmm... my recent changes were definitely tested on systems with AMBA
> > devices and it worked.
>
> Some of them work, such as the TWD, interrupt controller GIC
> and the CoreSight stuff.
>
> > > [   31.849586] amba 80126000.mmc: deferred probe pending
> > > [   31.854801] amba 80118000.mmc: deferred probe pending
> > > [   31.859895] amba 80005000.mmc: deferred probe pending
> > > [   31.870297] amba 80120000.uart: deferred probe pending
> > > [   31.875472] amba 80121000.uart: deferred probe pending
> > > [   31.880689] amba 80004000.i2c: deferred probe pending
> > > [   31.885799] amba 80128000.i2c: deferred probe pending
> > > [   31.890932] amba 80110000.i2c: deferred probe pending
> > > [   51.688361] vmem_3v3: disabling
> >
> > What does /debug/devices_deferred say about these? That should tell us
> > exactly what's blocking it.
>
> Can't get to check that sadly, because the root fs is on eMMC and
> that one is deferring indefinitely.
>
> I tried to compile in an initramfs but that became too big for this
> target. I'll check if I can use that on another target which I
> can boot directly from RAM.
>
> > Also if you convert all the pr_debug and dev_dbg in
> > drivers/base/core.c that should give us enough of an idea of what's
> > happening. Can you do that too and send it as an attachment (I logs
> > are hard to read when they get word wrapped)?
>
> This I could do!
>
> See attachment.
>
> It seems these devices are waiting for the PRCC reset-controller
> which is in
> drivers/clk/ux500/reset-prcc.c
>
> Very well! I went into
> arch/arm/boot/dts/ste-dbx5x0.dtsi
> and commented out all "resets = < &prcc....>; statements,
> and indeed then the system comes up fine! (The resets are
> not vital to boot the system.)
>
> But this is weird because the driver for the resets is spawn from
> the same device node that is spawning the clocks...
> All resources (clocks and resets) are spawn from here:
> drivers/clk/ux500/u8500_of_clk.c
>
> From these nodes in the DTS
> arch/arm/boot/dts/ste-dbx5x0.dtsi:
>
>                 clocks {
>                         compatible = "stericsson,u8500-clks";
>                         /*
>                          * Registers for the CLKRST block on peripheral
>                          * groups 1, 2, 3, 5, 6,
>                          */
>                         reg = <0x8012f000 0x1000>, <0x8011f000 0x1000>,
>                             <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
>                             <0xa03cf000 0x1000>;
>
>                         prcmu_clk: prcmu-clock {
>                                 #clock-cells = <1>;
>                         };
>
>                         prcc_pclk: prcc-periph-clock {
>                                 #clock-cells = <2>;
>                         };
>
>                         prcc_kclk: prcc-kernel-clock {
>                                 #clock-cells = <2>;
>                         };
>
>                         prcc_reset: prcc-reset-controller {
>                                 #reset-cells = <2>;
>                         };
>
>                         rtc_clk: rtc32k-clock {
>                                 #clock-cells = <0>;
>                         };
>
>                         smp_twd_clk: smp-twd-clock {
>                                 #clock-cells = <0>;
>                         };
>
>                         clkout_clk: clkout-clock {
>                                 /* Cell 1 id, cell 2 source, cell 3 div */
>                                 #clock-cells = <3>;
>                         };
>                 };
>
> So it seems like the device core things that the
> resets are never coming online. But they are! I put some
> debug prints into the PRCC reset driver to make sure.
>
> diff --git a/drivers/clk/ux500/reset-prcc.c b/drivers/clk/ux500/reset-prcc.c
> index f7e48941fbc7..b1ed9a48cdfb 100644
> --- a/drivers/clk/ux500/reset-prcc.c
> +++ b/drivers/clk/ux500/reset-prcc.c
> @@ -178,4 +178,6 @@ void u8500_prcc_reset_init(struct device_node *np,
> struct u8500_prcc_reset *ur)
>         ret = reset_controller_register(rcdev);
>         if (ret)
>                 pr_err("PRCC failed to register reset controller\n");
> +
> +       pr_info("PRCC reset controller registered\n");
>  }
>
> [    0.000000] PRCC reset controller registered
>
> It is registered as early as the clocks.
>
> So it seems something is fishy with the reset resource resolution?
>
> > > The last regulator (vmem_3v3) is something the eMMC that didn't
> > > probe was supposed to use.
> > >
> > > All the failing drivers are AMBA PrimeCell devices:
> > > drivers/mmc/host/mmci.c
> > > drivers/tty/serial/amba-pl011.c
> > > drivers/i2c/busses/i2c-nomadik.c
> > >
> > > This makes me suspect something was done for ordinary (platform)
> > > devices that didn't happen for AMBA devices?
> > >
> > > This is the main portion of the device tree containing these
> > > devices and their resources:
> > > arch/arm/boot/dts/ste-dbx5x0.dtsi
> >
> > I'll take a closer look on Monday. Btw, I always prefer the dts file
> > because there's always some property that adds a dependency and that
> > might be the clue to whatever is broken. But I'll take a look at this.
>
> The top level DTS for this system I'm testing on (source for the
> log) is
> arch/arm/boot/dts/ste-ux500-samsung-golden.dts
>
> > It's unlikely the patch attached might fix it, but can you give it a shot?
>
> Sadly does not help!

Did this mail go through with the attachment?

I have pastebin:ed it here as well:
https://pastebin.com/Fwc7E1Sm

Yours,
Linus Walleij
