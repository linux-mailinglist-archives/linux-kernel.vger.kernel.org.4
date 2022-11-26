Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D996392B1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKZAYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKZAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:24:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1840850D68;
        Fri, 25 Nov 2022 16:24:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A146061184;
        Sat, 26 Nov 2022 00:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CABC4347C;
        Sat, 26 Nov 2022 00:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669422242;
        bh=5toZeTHuclM1Oqu4FwGv8OsMLJIOueWsu96ihEcja7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s2TYdjTszuownAOhegyo/pU6TQOAJCrRDzZYjdYBb+Y4QmuaPc0NJk4r9pIiKNw3k
         6C8wv/Je/Sh+ZYVIa0Mnfn5c4f7OtgOFNCPwhP+yeaFsg28xB84lp6wXkGU/pvn/Vj
         M3CNu6DssogyBrW1f9L6uO+ILtKQSXr1gQt/0qvSrlKfSpXIOsqeSiEOV3K3IDRRIf
         +vVrb5acH6IF8hmStcADAe3Wb/fEPfSDJnjaek4Wn0AKE5+HExVxYb1odz6lwCFGpI
         +X9rRpJld6AJ41I0KoGYPn+9QRetV7QT/MzzpSaLglOCMX67PVdTH9AhZvs/d5YGPx
         YG970q1j7aLRQ==
Received: by mail-ej1-f49.google.com with SMTP id ho10so13454018ejc.1;
        Fri, 25 Nov 2022 16:24:01 -0800 (PST)
X-Gm-Message-State: ANoB5pk6WzE9KQu5qtPbA5GPlQ+PyQqC5HvwcKZB2Zbfmam5TUWsFpRf
        gx8jwIiBklk3m0P1DnnXDK5mnSipNKXeiEaFXi8=
X-Google-Smtp-Source: AA0mqf7nv6JvQ1A4iW6CP2Z7MJJBm62EJXKH9WZSwSn3QhacjGtAnhbnoBdcey9BL56bbf/Z6HFmN8R3m+bM1y13L00=
X-Received: by 2002:a17:907:9856:b0:780:8144:a41f with SMTP id
 jj22-20020a170907985600b007808144a41fmr35405801ejc.189.1669422240081; Fri, 25
 Nov 2022 16:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-12-samuel@sholland.org>
In-Reply-To: <20221125234656.47306-12-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 26 Nov 2022 08:23:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRbBcTOxMa2+WA2tkKYjxQ7iqNa+_xK_SNdjdN6Fu4V-g@mail.gmail.com>
Message-ID: <CAJF2gTRbBcTOxMa2+WA2tkKYjxQ7iqNa+_xK_SNdjdN6Fu4V-g@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] riscv: Add the Allwinner SoC family Kconfig option
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sat, Nov 26, 2022 at 7:47 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Allwinner manufactures the sunxi family of application processors. This
> includes the "sun8i" series of ARMv7 SoCs, the "sun50i" series of ARMv8
> SoCs, and now the "sun20i" series of 64-bit RISC-V SoCs.
>
> The first SoC in the sun20i series is D1, containing a single T-HEAD
> C906 core. D1s is a low-pin-count variant of D1 with co-packaged DRAM.
>
> Most peripherals are shared across the entire chip family. In fact, the
> ARMv7 T113 SoC is pin-compatible and almost entirely register-compatible
> with the D1s.
>
> This means many existing device drivers can be reused. To facilitate
> this reuse, name the symbol ARCH_SUNXI, since that is what the existing
> drivers have as their dependency.
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v2:
>  - Sort Kconfig as if we had done s/SOC_/ARCH_/ for future-proofing
>
>  arch/riscv/Kconfig.socs | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..4c1dc2ca11f9 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -26,6 +26,15 @@ config SOC_STARFIVE
>         help
>           This enables support for StarFive SoC platform hardware.
>
> +config ARCH_SUNXI
> +       bool "Allwinner sun20i SoCs"
> +       select ERRATA_THEAD if MMU && !XIP_KERNEL
> +       select SIFIVE_PLIC
> +       select SUN4I_TIMER
> +       help
> +         This enables support for Allwinner sun20i platform hardware,
> +         including boards based on the D1 and D1s SoCs.
> +
>  config SOC_VIRT
>         bool "QEMU Virt Machine"
>         select CLINT_TIMER if RISCV_M_MODE
> --
> 2.37.4
>


-- 
Best Regards
 Guo Ren
