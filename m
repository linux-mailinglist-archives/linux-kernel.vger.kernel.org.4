Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526E06A4DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjB0WBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjB0WBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:01:30 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4F2448F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:01:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id bh1so8308329plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mynabXo4cpyA3e0b0Y0qXprTLx8CBBWuxgvZGBpHlv0=;
        b=g5o20xX4qD4BcV7V9E+4dphcfJoi/SET3KNDf8b/Ao1Wv9qwrz7hMN6524iRMV7i7J
         Ny2hgl31MS170Rdsw4kcYuCSv4e8epzFXu1MEiJbAKbzBaI0q2tTPrBwXwjPtEJgSahU
         NrMuRVsaz4fAqcwW/Y3rTSLRUpHrvSHFF9qtlKeyIn67x35gi5NGXE2mEGAsRcRXPhHA
         p91nvwTCatxx96uC1O1Q/ArDoKPx2mo29yIUrh4/YDPQH3YyZ5dh6AUFdZNIekotONbL
         kDala6xwGJlZY36cMbGAI4hoaiKqOVLjQ0VwfLbUbAOhW9YxT2L+OMI1Rq5+I4cZ4rgG
         uD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mynabXo4cpyA3e0b0Y0qXprTLx8CBBWuxgvZGBpHlv0=;
        b=RDdmnRyUFZbCq/dke3qo+yn8czb1m2XdMMhorTjrtJgDJcD13TlGM8DsofHLzZ0k1/
         96JbMfvuSuU3HWWy7ZSUqxp+Kv472l6rG+k4mjXZKg668AkcZYlcToBFpQcjqg7/wkLk
         bemSSspcNPgfu3r2yGVjGtWbH5Rd/SG3j4oGdnU0jKz9hlAFtIckJFTUNjUQQpR4P1u6
         2RrbZXS6ThUvL6fRzaJxp75vBPHMAvFyc/zdpbNuyaRSul6BlAaKzfBGrn+lvSbicGVc
         8hdSlfMcbVBPw/NGuOgqTzYd9MSiqZhiT7QMLLSd9EAfct1IQLqxDet0BQwO55nbMewA
         zKtA==
X-Gm-Message-State: AO0yUKUwTJtdkELPuEK9dXq9l6ihV5OaGLmQQlgoBxiyrhnI34kXiKBJ
        Ryi9SwHLgXCuc8VcciBeR6S6Bx2DR0ATcnQgrwVa6A==
X-Google-Smtp-Source: AK7set8B4JODEvBJt9o1jV56Rx0zqj4tv+AWBoGDp1haH+rYM7QCS7sx0FEir1G4JjWgCMZSFVNmAYAeRHSYXKKQTjE=
X-Received: by 2002:a17:903:130b:b0:19a:f3f8:c31a with SMTP id
 iy11-20020a170903130b00b0019af3f8c31amr147983plb.10.1677535287540; Mon, 27
 Feb 2023 14:01:27 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdamxDX6EBVjKX5=D3rkHp17f5pwGdBVhzFU90-0MHY6dQ@mail.gmail.com>
 <CAGETcx-Ws4zZJ-KWoOLM6ELpyM6pWh7cfRWaYB1zrtTn5sov+w@mail.gmail.com>
 <CACRpkdaw9uJHgMVMdXcwu83fV83uo8r5vtYC8UmO6w=MaWaFdw@mail.gmail.com> <CACRpkdbkM1ipwnerQBK86Azziz+reNhbkfXMWVmNOjc+-FMnzw@mail.gmail.com>
In-Reply-To: <CACRpkdbkM1ipwnerQBK86Azziz+reNhbkfXMWVmNOjc+-FMnzw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Feb 2023 14:00:51 -0800
Message-ID: <CAGETcx8cb4JSNMqRXfq2zAMjky_033wu1Ygrb1YqAL=a8voyRA@mail.gmail.com>
Subject: Re: Regression in probing some AMBA devices possibly devlink related
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
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

On Mon, Feb 27, 2023 at 1:07=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Sun, Feb 26, 2023 at 10:55 PM Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> > On Sun, Feb 26, 2023 at 12:56 AM Saravana Kannan <saravanak@google.com>=
 wrote:
> > > On Sat, Feb 25, 2023 at 6:29 AM Linus Walleij <linus.walleij@linaro.o=
rg> wrote:
> > > >
> > > > Hi Saravana,
> > > >
> > > > I have a boot regression for Ux500 on mainline, but bisecting mainl=
ine
> > > > isn't quite working for misc reasons :/
> > > >
> > > > I'm not sure about this regression, but it smells like devlink-rela=
ted.
> > > >
> > > > Ux500 have a bunch of normal and some AMBA devices. After
> > > > boot this happens and we hang waiting for rootfs (which is on eMMC)=
:
> > >
> > > Hmmm... my recent changes were definitely tested on systems with AMBA
> > > devices and it worked.
> >
> > Some of them work, such as the TWD, interrupt controller GIC
> > and the CoreSight stuff.
> >
> > > > [   31.849586] amba 80126000.mmc: deferred probe pending
> > > > [   31.854801] amba 80118000.mmc: deferred probe pending
> > > > [   31.859895] amba 80005000.mmc: deferred probe pending
> > > > [   31.870297] amba 80120000.uart: deferred probe pending
> > > > [   31.875472] amba 80121000.uart: deferred probe pending
> > > > [   31.880689] amba 80004000.i2c: deferred probe pending
> > > > [   31.885799] amba 80128000.i2c: deferred probe pending
> > > > [   31.890932] amba 80110000.i2c: deferred probe pending
> > > > [   51.688361] vmem_3v3: disabling
> > >
> > > What does /debug/devices_deferred say about these? That should tell u=
s
> > > exactly what's blocking it.
> >
> > Can't get to check that sadly, because the root fs is on eMMC and
> > that one is deferring indefinitely.
> >
> > I tried to compile in an initramfs but that became too big for this
> > target. I'll check if I can use that on another target which I
> > can boot directly from RAM.
> >
> > > Also if you convert all the pr_debug and dev_dbg in
> > > drivers/base/core.c that should give us enough of an idea of what's
> > > happening. Can you do that too and send it as an attachment (I logs
> > > are hard to read when they get word wrapped)?
> >
> > This I could do!
> >
> > See attachment.
> >
> > It seems these devices are waiting for the PRCC reset-controller
> > which is in
> > drivers/clk/ux500/reset-prcc.c
> >
> > Very well! I went into
> > arch/arm/boot/dts/ste-dbx5x0.dtsi
> > and commented out all "resets =3D < &prcc....>; statements,
> > and indeed then the system comes up fine! (The resets are
> > not vital to boot the system.)
> >
> > But this is weird because the driver for the resets is spawn from
> > the same device node that is spawning the clocks...
> > All resources (clocks and resets) are spawn from here:
> > drivers/clk/ux500/u8500_of_clk.c
> >
> > From these nodes in the DTS
> > arch/arm/boot/dts/ste-dbx5x0.dtsi:
> >
> >                 clocks {
> >                         compatible =3D "stericsson,u8500-clks";
> >                         /*
> >                          * Registers for the CLKRST block on peripheral
> >                          * groups 1, 2, 3, 5, 6,
> >                          */
> >                         reg =3D <0x8012f000 0x1000>, <0x8011f000 0x1000=
>,
> >                             <0x8000f000 0x1000>, <0xa03ff000 0x1000>,
> >                             <0xa03cf000 0x1000>;
> >
> >                         prcmu_clk: prcmu-clock {
> >                                 #clock-cells =3D <1>;
> >                         };
> >
> >                         prcc_pclk: prcc-periph-clock {
> >                                 #clock-cells =3D <2>;
> >                         };
> >
> >                         prcc_kclk: prcc-kernel-clock {
> >                                 #clock-cells =3D <2>;
> >                         };
> >
> >                         prcc_reset: prcc-reset-controller {
> >                                 #reset-cells =3D <2>;
> >                         };
> >
> >                         rtc_clk: rtc32k-clock {
> >                                 #clock-cells =3D <0>;
> >                         };
> >
> >                         smp_twd_clk: smp-twd-clock {
> >                                 #clock-cells =3D <0>;
> >                         };
> >
> >                         clkout_clk: clkout-clock {
> >                                 /* Cell 1 id, cell 2 source, cell 3 div=
 */
> >                                 #clock-cells =3D <3>;
> >                         };
> >                 };
> >
> > So it seems like the device core things that the
> > resets are never coming online. But they are! I put some
> > debug prints into the PRCC reset driver to make sure.
> >
> > diff --git a/drivers/clk/ux500/reset-prcc.c b/drivers/clk/ux500/reset-p=
rcc.c
> > index f7e48941fbc7..b1ed9a48cdfb 100644
> > --- a/drivers/clk/ux500/reset-prcc.c
> > +++ b/drivers/clk/ux500/reset-prcc.c
> > @@ -178,4 +178,6 @@ void u8500_prcc_reset_init(struct device_node *np,
> > struct u8500_prcc_reset *ur)
> >         ret =3D reset_controller_register(rcdev);
> >         if (ret)
> >                 pr_err("PRCC failed to register reset controller\n");
> > +
> > +       pr_info("PRCC reset controller registered\n");
> >  }
> >
> > [    0.000000] PRCC reset controller registered
> >
> > It is registered as early as the clocks.
> >
> > So it seems something is fishy with the reset resource resolution?
> >
> > > > The last regulator (vmem_3v3) is something the eMMC that didn't
> > > > probe was supposed to use.
> > > >
> > > > All the failing drivers are AMBA PrimeCell devices:
> > > > drivers/mmc/host/mmci.c
> > > > drivers/tty/serial/amba-pl011.c
> > > > drivers/i2c/busses/i2c-nomadik.c
> > > >
> > > > This makes me suspect something was done for ordinary (platform)
> > > > devices that didn't happen for AMBA devices?
> > > >
> > > > This is the main portion of the device tree containing these
> > > > devices and their resources:
> > > > arch/arm/boot/dts/ste-dbx5x0.dtsi
> > >
> > > I'll take a closer look on Monday. Btw, I always prefer the dts file
> > > because there's always some property that adds a dependency and that
> > > might be the clue to whatever is broken. But I'll take a look at this=
.
> >
> > The top level DTS for this system I'm testing on (source for the
> > log) is
> > arch/arm/boot/dts/ste-ux500-samsung-golden.dts
> >
> > > It's unlikely the patch attached might fix it, but can you give it a =
shot?
> >
> > Sadly does not help!
>
> Did this mail go through with the attachment?

Attachment came through for me. I should be able to give you a test
patch this week. My guess on what the issue is: I have to walk up to
the parents and check for FWNODE_FLAG_DEV_INITIALIZED or set it
recursively for all the child nodes (termination condition being when
the fwnode has a device).

-Saravana

>
> I have pastebin:ed it here as well:
> https://pastebin.com/Fwc7E1Sm
>
> Yours,
> Linus Walleij
