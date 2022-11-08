Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FDD621914
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiKHQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiKHQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:07:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44945C77B;
        Tue,  8 Nov 2022 08:07:12 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f7so23188784edc.6;
        Tue, 08 Nov 2022 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HeqeWmFL1Z0YyXQkc6bAsrYfc1kxzO18e0BuN70nwS0=;
        b=BYSjtEhYQvz8W18ioR+5oUc5WcfvJqkhcFwf0Bi0xYQjaGN4yQq66dRX839UXAe0Wb
         L0pr7etlHmJAcRe5g2vjDiRF1teXr21LJGMSQMJEaHKjSDeOfmdyaWNbQFwE5AI1lLCb
         s4ZMxVpCZpwY8zelV5ujdk51OI+FGqPM9mcbWLOuk7RW76Frieg6rPqlGEPKhfEa4MkA
         /Ul1AnBBgrDGF610joipV2Jwgy+0U2k+surnHRAIdcQKKC6Z7b4N2PPIkrrKs5yn8euQ
         cKdYdIiNPvpOjBsvid9mc9xak6BbTgDgGCXjbEkTa4+eP2w6BA9lUkS+BrL69g4Wexf8
         CZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HeqeWmFL1Z0YyXQkc6bAsrYfc1kxzO18e0BuN70nwS0=;
        b=CRzOaUsJcSXs3zwsiyTzPo543xOJH2CsuPzBIpR4Wj8QfhoNIV0pSrYFcOqKFOhWMN
         AxfI/iPLOeAOx1uc74XshH8QjHxvl5Pno9MO62nrQ+8AIseMlmhCWrIcN/afiwv0VQr4
         qToT/1Z10evWpwR9CqXteB/3lefgmzevymJlPsDOfdxl+5O1MQD4modCtf5iwJVzGSLx
         TjcNwuuUwmYsJD/ftYY08/JWA949XX3aukoS/mujkkphNplHp0GOovGgyKzmxAXA3ZvQ
         xbyl/N4rHThHIXuAoQRHOwBoOoKD/Y4XMnqrdnhc5JsA0NYjPgd1bC5jTRQoHz1qVBdC
         7mWQ==
X-Gm-Message-State: ACrzQf3u5cWH8S9cM2BMaTMNBJfZ/P3pto36do6Kulg2GvVTn0H/XDYw
        8I0TnIsFfAEb7t/OH022Bm6H2lHK4Z0fvimKJ/4=
X-Google-Smtp-Source: AMsMyM5NzRSSLqSZ7oDkKz/XS4UKz2Nax3sDL4blJ/Li1UlnSK9ag8+QiFSjollPQ2mvGUHtrlY60V5citWqe87J1jw=
X-Received: by 2002:a05:6402:3217:b0:461:d6d7:7f19 with SMTP id
 g23-20020a056402321700b00461d6d77f19mr35135661eda.109.1667923631350; Tue, 08
 Nov 2022 08:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 8 Nov 2022 16:06:44 +0000
Message-ID: <CA+V-a8t5Qah3MNm2m__xnmgK-52=HC9QBPPudnB+1j4-FYJ_NA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Tue, Nov 8, 2022 at 3:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> > upstream kernel to boot on RZ/Five SMARC EVK board.
> >
> > Alongside enable SERIAL_SH_SCI config so that the serial driver used by
> > RZ/Five SoC is built-in.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v4 -> v5
> > * No change
> >
> > v3 -> v4
> > * Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
> >   tags with this change)
> > * Used riscv instead of RISC-V in subject line
>
> Thanks for the update!
>
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
> >  CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_STARFIVE=y
> >  CONFIG_SOC_VIRT=y
> > +CONFIG_ARCH_RENESAS=y
> > +CONFIG_ARCH_R9A07G043=y
>
> You forgot to refresh after moving ARCH_RENESAS in v5 of "riscv:
> Kconfig.socs: Add ARCH_RENESAS kconfig option", and after relying on
> ARCH_R9A07G043 in drivers/soc/renesas/Kconfig.
>
Sorry I missed your point here, could you please elaborate.

> >  CONFIG_SMP=y
> >  CONFIG_HOTPLUG_CPU=y
> >  CONFIG_PM=y
>
> PM and GPIOLIB are auto-selected by ARCH_R9A07G043 (through ARCH_RZG2L)
> resp. SOC_RENESAS, so they can be dropped.  But it's better to do this
> after the release of v6.2-rc1, when all pieces have fallen together.
>
Are you suggesting dropping it from defconfig?

Cheers,
Prabhakar
