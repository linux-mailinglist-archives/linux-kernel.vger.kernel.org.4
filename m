Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE204612011
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJ2E3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2E27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9BCAC4A1;
        Fri, 28 Oct 2022 21:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AB2D6097D;
        Sat, 29 Oct 2022 04:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C278C433B5;
        Sat, 29 Oct 2022 04:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017737;
        bh=aTygU2PRy7lfkCjg6NARWEJFi56C6SOOGo8ciffs0M4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kC2UVQISZ4nPYgwr4pAfEbOBLInAwPZ7BrO0UqU77CO3g/1OthskPiQ56m4beDNuo
         kirUfT3Yx90wgKypNS+4vJq45qniwWZUc61/bK/BpC/gURWj1Nrz+9NX2M9R8k6QG1
         JVdJ2764RFk/m7zvOiE5C6G0+diBCReXzgYnEmWeTT79aQqxt/Q0xE0GTJlZAgQkQ+
         o05mujJ+CZu7Sj9aiS4aEm70LUW60rqBZVnpJa9ILh9PC6R6K5OhZ6IOgrL0GuWS8I
         ayIRuIXNfHl/AlNCL8ZzAEKdDVQYeKE8CeQo6WEcorRvAhqZDpo2cCwIauEQDlxiZU
         gwXMZ1oaJI3hg==
Received: by mail-oi1-f182.google.com with SMTP id r187so8131587oia.8;
        Fri, 28 Oct 2022 21:28:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Y7EH1maZ7DcN4qqklAArydKnonl4f41IrNu15dXPojMMnN+Tl
        57h75/hT6TdH9eazF7RPxwaxoNGYLSPSF36cVi8=
X-Google-Smtp-Source: AMsMyM7qr9dXGyzxd/3829olJulGF7SulN3N+dRbu+X5QyTSvh7ZfeE/P62C1xUQsuyr9RgMVhxxfngZ/+bX0pJujPk=
X-Received: by 2002:a05:6808:f0e:b0:359:b055:32ea with SMTP id
 m14-20020a0568080f0e00b00359b05532eamr9050147oiw.112.1667017736773; Fri, 28
 Oct 2022 21:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Oct 2022 12:28:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSJML1buw3mO-2Oy8SAsHFk0hqKabiKhAQLfyuOcnas-g@mail.gmail.com>
Message-ID: <CAJF2gTSJML1buw3mO-2Oy8SAsHFk0hqKabiKhAQLfyuOcnas-g@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sat, Oct 29, 2022 at 12:59 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
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
>
> v2 -> v3
> * Included RB tags
> * Updated commit description
>
> v1 -> v2
> * New patch
> ---
>  arch/riscv/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 05fd5fcf24f9..97fba7884d7a 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_STARFIVE=y
>  CONFIG_SOC_VIRT=y
> +CONFIG_ARCH_RENESAS=y
> +CONFIG_ARCH_R9A07G043=y
>  CONFIG_SMP=y
>  CONFIG_HOTPLUG_CPU=y
>  CONFIG_PM=y
> @@ -123,6 +125,7 @@ CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_SH_SCI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
