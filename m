Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C7647CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 05:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLIDeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIDem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:34:42 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21651D304
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:34:33 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g7so2767623qts.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 19:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AX6+KQueG/0V+PW0SCatE3qkqdMoa6EoSb0hMoNBlmw=;
        b=kwDDxicYDe7Aib24SuhHlX9g+etY8Io9ReoN25F7cOKE5v3yESqyOru4Y6Uo4XO7J8
         LVM/PWfiazNVm3RG4pSfHQrlS0aC/JIueRDqKSbDeCdSSaUtnjobMfVDnD9ja2dsbTE5
         HKjv2OZWpe5jUyfwAVwHS2n+eBMo1fCyVGHH60lEJFpSZt2Pf8WhPvHqwnaTu2T6Kw7S
         lJY7qV9unnm+M+JL3vQ1FPDEjhrYqoiMKdZDM95MUB+XkAUWOZyfmMIef4/3nhXdQm+n
         uq+Pcpx92QXNdykT9uYObaNAU6ZHluU7WysRViHqI5O8qQ65+Gg5LcdCYmvwWZ/c7OJP
         /vMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AX6+KQueG/0V+PW0SCatE3qkqdMoa6EoSb0hMoNBlmw=;
        b=EIfaK9Cp7E7RZ3e6tTAXu9zrRmsNE7d3u1Kx9Nf2ClO0rgbq4R69xFQR7nMZInWRtz
         K8LamMRe+D75iKWGoEtn/ZRzdQPx1TkCYtRdO/lDBAApqdqUiTw4oxaJcuZcDZ/hEaPx
         J9WuNcyeSNi/s2nZr5PcJG7cMhakBt/fLjquS7pfmLzba/q+xJ0nJ+ZgRdK/t0+XDgXo
         yIvz/mE2Y0ImfkINA9STiSZn90sjm4PPOlOXl3A471cPmz/LeOh6VL5uaWwJRAtS5OnU
         xHgbHB41IaryUlVIAYbwUR9vgvQZ8N81rQVbItkj15qoIx5nOdgIX+Y6vCWcZeIwMP6V
         QbIA==
X-Gm-Message-State: ANoB5pkXTbILbVy7bfZKcMdUV7wYpa7RGMwsoAt46fo9BLezxRV+lmLW
        xyaEcZVsNlgEqjT9Yo6yT+eBHtA0Lq7uT0Arx5Y=
X-Google-Smtp-Source: AA0mqf6+QKZR5iv5fkYEz5uVZuFEmmMbiRkt9MUzlOgf0zVCpJLokrqzH0S0GWU1Th+FgsmJe0d1Tr6l5ZPR9Cx21eA=
X-Received: by 2002:ac8:6c8:0:b0:3a6:9ac9:6800 with SMTP id
 j8-20020ac806c8000000b003a69ac96800mr22388706qth.410.1670556873017; Thu, 08
 Dec 2022 19:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20221207135223.3938-1-jundongsong1@gmail.com> <86a63zkzru.wl-maz@kernel.org>
 <CAJqh2T+h2oHZoxc5-zbjPWEGFUVnTs9JB04Dh-sR4WeUMYrj2A@mail.gmail.com> <20221208165820.5maej4we3mfdeprm@mercury.elektranox.org>
In-Reply-To: <20221208165820.5maej4we3mfdeprm@mercury.elektranox.org>
From:   Harry Song <jundongsong1@gmail.com>
Date:   Fri, 9 Dec 2022 11:34:21 +0800
Message-ID: <CAJqh2TJvkk5o+MkET8UED-8AUhsDdehvsnR2+7bfeRoY7AmPdQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: remove the shareability of ITS
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply. I know these two links.
My email is to ask about the root cause of this bug.

I would like to know whether the driver design of ITS requires that
the CPU and ITS
must be in a shared domain. Such as using CCI in chips;

From marc's reply, I think so. In addition to CCI, other methods can
also be used to
ensure consistency, which is a requirement for IC design.

Thanks,
Harry

On Fri, Dec 9, 2022 at 12:58 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, Dec 08, 2022 at 10:28:29AM +0800, Harry Song wrote:
> > On Wed, Dec 7, 2022 at 11:19 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Wed, 07 Dec 2022 13:52:23 +0000,
> > > Harry Song <jundongsong1@gmail.com> wrote:
> > > >
> > > > I know this is a very wrong patch, but my platform
> > > > has an abnormal ITS problem caused by data consistency:
> > > > My chip does not support Cache Coherent Interconnect (CCI).
> > >
> > > That doesn't mean much. Nothing mandates to have a CCI, and plenty of
> > > systems have other ways to maintain coherency.
> > >
> > > > By default, ITS driver is the inner memory attribute.
> > > > gits_write_cbaser() is used to write the inner memory
> > > > attribute. But hw doesn't return the hardware's non-shareable
> > > > property,so I don't think reading GITS_CBASER and GICR_PROPBASER
> > > > here will get the real property of the current hardware: inner
> > > > or outer shareable is not supported, so I would like to know
> > > > whether ITS driver cannot be used on chips without CCI, or
> > > > what method can be used to use ITS driver on chips without CCI?
> > >
> > > It's not about CCI or not CCI. It is about which shareability domain
> > > your ITS is in.
> > >
> > > And it doesn't only affect the ITS. It also affects the
> > > redistributors, and anything that accesses memory.
> > >
> >
> > Yes, my current chip is Rockchip platform (rk3588), so is it because the chip
> > is not designed as a proper shared domain for ITS, so the exception of
> > ITS is caused?
> >
> > > >
> > > > The current patch is designed to make ITS think that the current
> > > > chip has no inner or outer memory properties, and then use
> > > > its by flushing dcache.
> > > >
> > > > This is the log for bug reports without patches:
> > > >
> > > > [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x0000000003460000
> > > > [    0.000000] ITS [mem 0x03440000-0x0345ffff]
> > > > [    0.000000] ITS@0x0000000003440000: allocated 8192 Devices @41850000 (indirect, esz 8, psz 64K, shr 0)
> > > > [    0.000000] ITS@0x0000000003440000: allocated 32768 Interrupt Collections @41860000 (flat, esz 2, psz 64K, shr 0)
> > > > [    0.000000] GICv3: using LPI property table @0x0000000041870000
> > > > [    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000041880000
> > > > [    0.000000] ITS queue timeout (64 1)
> > > > [    0.000000] ITS cmd its_build_mapc_cmd failed
> > > > [    0.000000] ITS queue timeout (128 1)
> > > > [    0.000000] ITS cmd its_build_invall_cmd failed
> > >
> > > Ah, this suspiciously looks like a Rockchip machine...
> > >
> > > >
> > > > Signed-off-by: Harry Song <jundongsong1@gmail.com>
> > > > ---
> > > >
> > > > I am very sorry to bother you. This problem has been bothering me
> > > > for several weeks.  I am looking forward to your reply.
> > >
> > > If you have such issue, this needs to be handled as per-platform
> > > quirk. I'm not putting such generic hacks in the driver.
> > >
> > >         M.
> > >
> > > --
> > > Without deviation from the norm, progress is not possible.
> >
> > Are there currently other chip platforms that have this problem, and then ITS
> > is already compatible with the problem? Please tell me how to submit
> > hacks patch for rk3588 platform?
> >
> > If the hacks patch cannot be submitted, please tell me whether it
> > requires the next generation
> > chip to have any design requirements for ITS?
> >
> > Design ITS and CPU to be the same inner memory property?
>
> Previous rockchip generation has the same bug and it got discussed
> here:
>
> https://lore.kernel.org/lkml/871rbdt4tu.wl-maz@kernel.org/T/#m5dbc70ff308d81e98dd0d797e23d3fbf9c353245
>
> You can use this DT as base with mainline to avoid ITS:
>
> https://lore.kernel.org/all/20221205172350.75234-1-sebastian.reichel@collabora.com/
>
> -- Sebastian
