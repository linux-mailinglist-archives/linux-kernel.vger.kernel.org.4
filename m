Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3B621EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKHWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiKHWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:01:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD3B23381;
        Tue,  8 Nov 2022 14:01:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s12so14964931edd.5;
        Tue, 08 Nov 2022 14:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QrehMHGbF0ud3SfuTCD05+3RISeggbmWJ8iearVbVYs=;
        b=gsrbJ5nHm3fr1A7b1jq+aI4WEzTrPGiLQ0qrouoPTpPbEOFcicw0Js1ylm/R/PcaND
         +vR2OAmqZbUmTFydJxEecJBQ5Z04IR5hk3WrP+cV0f4ZF0tMEivWfOJRf/acYcWuDnLZ
         /vrDkGxNmQZJRqrFZKHTIT6mnZWmm1IevpJphkJcqWZSEYvrFcTFyqzZxq6hpIi6mZ9/
         Hz9K1MdUjQRAhAtIbloOfOiN7NLuVl68wUYNTLvmI3JwurSyfktMm4yKd43cZ5PEc6dx
         zKxfBOKOOwqL+7hYDakxsrBjtOh4xxiycPwGusgeiJ037y64SA1Mt69xzJiYLVoyHCeW
         WuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrehMHGbF0ud3SfuTCD05+3RISeggbmWJ8iearVbVYs=;
        b=G7HJdm8sbbJx3rTgaog6SwO3X3wIWF22kCPqtkQtMIAQw82WLmgqCi7zy9j/ro1WJ/
         aRobRqPqe0ESyA5lhX6TFSMtSkm76FGtQo2sLraVrF9o8ZCJbDZqSIsH5zQK1RKL44t+
         i52eGiVJk0jICn5kgTA0vEsS6y7rKsi0dcYKQMg8HCvfKy1rBUsbhxquSbB9we/UL3cL
         SDZryfF5qHqiPmOKRTBNqMFCrViW6tzPJ4bE+ZgYGT04xofXhcrg5rOen2Ff3PBZuKmA
         D9Catg+Wdg20QX5Ilczia4qT5C85RU4wIwkFv8lLv61Mch5x1d3JZ8fk97gy57vG6s+O
         tEpQ==
X-Gm-Message-State: ACrzQf0s/zF5/jzUMhgxiL+YHHv2DXYlCPWWDL403TTxJUxFh3Uv1H5i
        9jWzpSvLrsbzQ5FtcNex+QOEQ1ZtiRFwcjwYbRg=
X-Google-Smtp-Source: AMsMyM7q0YSthBd2yKawk4JYycYpO8FYQE3LgFvSLFT7wnepQgGjaSd/yLU9h6nUFm26UeaXQBzhAMuTAja+pZtiIQ0=
X-Received: by 2002:aa7:c389:0:b0:463:5926:7254 with SMTP id
 k9-20020aa7c389000000b0046359267254mr50251078edq.255.1667944913295; Tue, 08
 Nov 2022 14:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com>
 <CA+V-a8t5Qah3MNm2m__xnmgK-52=HC9QBPPudnB+1j4-FYJ_NA@mail.gmail.com>
 <CAMuHMdWTJf24XR+KR8yVJOnfpgs-PkUf9b8B=PX9Dd4mfawD5Q@mail.gmail.com>
 <CA+V-a8vCGDHL1SUTEnD-WvoUGKSVL=xzDeQxy77=1vFJdk+fYg@mail.gmail.com> <CAMuHMdU=K0o6KHVPUdfEu0tkH8kDMBg-WaRFcYS7r=azWEnfTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU=K0o6KHVPUdfEu0tkH8kDMBg-WaRFcYS7r=azWEnfTQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 8 Nov 2022 22:01:27 +0000
Message-ID: <CA+V-a8s6Amvb35wRE7pbwXHxwzk8znT8OWsbA9DRpX76E8Uh+w@mail.gmail.com>
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

On Tue, Nov 8, 2022 at 7:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Nov 8, 2022 at 6:23 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Nov 8, 2022 at 4:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Nov 8, 2022 at 5:07 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Tue, Nov 8, 2022 at 3:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> > > > > > upstream kernel to boot on RZ/Five SMARC EVK board.
> > > > > >
> > > > > > Alongside enable SERIAL_SH_SCI config so that the serial driver used by
> > > > > > RZ/Five SoC is built-in.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > ---
> > > > > > v4 -> v5
> > > > > > * No change
> > > > > >
> > > > > > v3 -> v4
> > > > > > * Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
> > > > > >   tags with this change)
> > > > > > * Used riscv instead of RISC-V in subject line
> > > > >
> > > > > Thanks for the update!
> > > > >
> > > > > > --- a/arch/riscv/configs/defconfig
> > > > > > +++ b/arch/riscv/configs/defconfig
> > > > > > @@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
> > > > > >  CONFIG_SOC_SIFIVE=y
> > > > > >  CONFIG_SOC_STARFIVE=y
> > > > > >  CONFIG_SOC_VIRT=y
> > > > > > +CONFIG_ARCH_RENESAS=y
> > > > > > +CONFIG_ARCH_R9A07G043=y
> > > > >
> > > > > You forgot to refresh after moving ARCH_RENESAS in v5 of "riscv:
> > > > > Kconfig.socs: Add ARCH_RENESAS kconfig option", and after relying on
> > > > > ARCH_R9A07G043 in drivers/soc/renesas/Kconfig.
> > > > >
> > > > Sorry I missed your point here, could you please elaborate.
> > >
> > > I mean that the options have moved, so you should update
> > > your patch like this:
> > >
> > Ouch got that.
> >
> > >     --- a/arch/riscv/configs/defconfig
> > >     +++ b/arch/riscv/configs/defconfig
> > >     @@ -26,11 +26,10 @@ CONFIG_EXPERT=y
> > >      # CONFIG_SYSFS_SYSCALL is not set
> > >      CONFIG_PROFILING=y
> > >      CONFIG_SOC_MICROCHIP_POLARFIRE=y
> > >     +CONFIG_ARCH_RENESAS=y
> > >      CONFIG_SOC_SIFIVE=y
> > >      CONFIG_SOC_STARFIVE=y
> > >      CONFIG_SOC_VIRT=y
> > >     -CONFIG_ARCH_RENESAS=y
> > >     -CONFIG_ARCH_R9A07G043=y
> > >      CONFIG_SMP=y
> > >      CONFIG_HOTPLUG_CPU=y
> > >      CONFIG_PM=y
> > >     @@ -163,6 +159,7 @@ CONFIG_MAILBOX=y
> > >      CONFIG_RPMSG_CHAR=y
> > >      CONFIG_RPMSG_CTRL=y
> > >      CONFIG_RPMSG_VIRTIO=y
> > >     +CONFIG_ARCH_R9A07G043=y
> > >      CONFIG_EXT4_FS=y
> > >      CONFIG_EXT4_FS_POSIX_ACL=y
> > >      CONFIG_EXT4_FS_SECURITY=y
> > >
> > > > > >  CONFIG_SMP=y
> > > > > >  CONFIG_HOTPLUG_CPU=y
> > > > > >  CONFIG_PM=y
> > > > >
> > > > > PM and GPIOLIB are auto-selected by ARCH_R9A07G043 (through ARCH_RZG2L)
> > > > > resp. SOC_RENESAS, so they can be dropped.  But it's better to do this
> > > > > after the release of v6.2-rc1, when all pieces have fallen together.
> > > > >
> > > > Are you suggesting dropping it from defconfig?
> > >
> > > Yes, but not right now, as that would make it depend on my
> > > renesas-drivers-for-v6.2 branch to keep them enabled.
> > >
^^^
> > I was wondering if that's required by other platforms though.
> > CONFIG_PM was added for VIRT machine and GPIOLIB for HiFive.
>
> Does that matter? They would still get it, as long as they use the
> defconfig.
>
Confused, didnt you say about dropping it from defconfig...

Cheers,
Prabhakar
