Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF76218D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiKHPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiKHPwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:52:11 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500D25282;
        Tue,  8 Nov 2022 07:52:10 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id h21so8886523qtu.2;
        Tue, 08 Nov 2022 07:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5KUR+OrhKv8Dk8eQjpB3hNK7Qj5y9AJxP2N44RuaHw=;
        b=qFdOMwqnR0XnsL9t4EIo3ym98kNuZPBZHvas4Nl4Yl1kdWC1Fbv+43IusIcVA9/Fi5
         43stopV+fNbKLZ+v+fRIqRrEVom09iKwFUE+bEVlBh6BlliIz7ydDPPtWZ5myj9XZrE/
         sbUJRvAQKNsumE60Snh3BkIV63bKLOUzwnuGrtYrOldXzI49FImVR4o0UroepG3Fpfb5
         1QwkrSECnqHGJ8XtkA3gft0b81otT/Lt/97pHi0v0qZYK/jG4KIhBq+939csTxGIUPGp
         TTwPcGd8BvTyukbh2JA5J0oC8zLolLTAxXNsdyUmGDD9wsCGqs0F7WvZulSIrYz8yhBn
         iVHQ==
X-Gm-Message-State: ACrzQf3w5bnReKeNjyVIubHw+MxTRg70AGf1snsZUOd7IBpxbYM7Z5la
        SM3RAaIQto1+vevrH+HZD9eeqfEdzl3HEiW6
X-Google-Smtp-Source: AMsMyM5oy2kjssfJJP5u15YPaPDHHpaauCVi5KmTa3avNZRhPEm0N7II3H4C/5QY85e9kvwhUpauzw==
X-Received: by 2002:ac8:4505:0:b0:3a5:310c:1cd8 with SMTP id q5-20020ac84505000000b003a5310c1cd8mr34186894qtn.540.1667922729511;
        Tue, 08 Nov 2022 07:52:09 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id bm32-20020a05620a19a000b006fa84082b6dsm9737441qkb.128.2022.11.08.07.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 07:52:08 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3691e040abaso137389417b3.9;
        Tue, 08 Nov 2022 07:52:08 -0800 (PST)
X-Received: by 2002:a81:b80f:0:b0:36b:56d3:71b8 with SMTP id
 v15-20020a81b80f000000b0036b56d371b8mr923825ywe.384.1667922727704; Tue, 08
 Nov 2022 07:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 16:51:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com>
Message-ID: <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> upstream kernel to boot on RZ/Five SMARC EVK board.
>
> Alongside enable SERIAL_SH_SCI config so that the serial driver used by
> RZ/Five SoC is built-in.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4 -> v5
> * No change
>
> v3 -> v4
> * Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
>   tags with this change)
> * Used riscv instead of RISC-V in subject line

Thanks for the update!

> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_STARFIVE=y
>  CONFIG_SOC_VIRT=y
> +CONFIG_ARCH_RENESAS=y
> +CONFIG_ARCH_R9A07G043=y

You forgot to refresh after moving ARCH_RENESAS in v5 of "riscv:
Kconfig.socs: Add ARCH_RENESAS kconfig option", and after relying on
ARCH_R9A07G043 in drivers/soc/renesas/Kconfig.

>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
>  CONFIG_PM=y

PM and GPIOLIB are auto-selected by ARCH_R9A07G043 (through ARCH_RZG2L)
resp. SOC_RENESAS, so they can be dropped.  But it's better to do this
after the release of v6.2-rc1, when all pieces have fallen together.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
