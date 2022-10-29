Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED679612006
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJ2EZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJ2EZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:25:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A443A15E;
        Fri, 28 Oct 2022 21:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44375B82E03;
        Sat, 29 Oct 2022 04:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4ABC43141;
        Sat, 29 Oct 2022 04:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017514;
        bh=/TyNm8r7XciBoT6CJYf4aBiDuqANUFlLnmCMI+cx/ew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HnoYnTOpZc3Yq/ztVzHXSckxmNqNv5qimaVo/uBCSnbFFCt/VnvlAUE6rz96Pjkwi
         0ch98vAeMzEsVNgIThK0sPeLb6vt8aYQSTq6xo84peZJ2Mr4dbtZ+lFBjI5nGDfWXk
         prUR6UhEVtt05IA4Wtrj7z1yqPBTuDpmprSFntyUjEF5Ol4My7z0msWaQkYdTIaXYX
         dc3QUJZw34ZTBVF49MNu3eU4s1oIhK1ecVVk/7eVxTyjiYE/yWkkG7oz/nYP71VTSF
         0YTkniohiRhEy8W2WwH6ID/9+LxFeGq1Ztkk+JhZoIpqMDgz1wgayg9ifwyWpVQB5O
         SZUkmqB5W3JAg==
Received: by mail-oo1-f50.google.com with SMTP id v7-20020a4aa507000000b00496e843fdfeso864844ook.7;
        Fri, 28 Oct 2022 21:25:14 -0700 (PDT)
X-Gm-Message-State: ACrzQf1DyXT3ZHg9BElTMnf4fIAAKoLlxzFlAxhs9oCuRdKWv6hWw2j2
        ibDSl+zI/7EgqgN2yJanrZI2YS6+BBmqUs0ejW8=
X-Google-Smtp-Source: AMsMyM4U+XLGWneF25rSvG0PdhbqMRiauzCcUyYwLQozxUxetPJGDoBdTR7JO/wJ2kk58GWp0y2oWsZihOLcyTvwVg4=
X-Received: by 2002:a4a:2144:0:b0:481:a4:d2b0 with SMTP id u65-20020a4a2144000000b0048100a4d2b0mr1153471oou.48.1667017514013;
 Fri, 28 Oct 2022 21:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Oct 2022 12:25:01 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
Message-ID: <CAJF2gTQPU0FGmeVt9jrNfOAQSA=04Vcm4U_wcC_dGMc5X2Bo7w@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
 Renesas RZ/Five SoC
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

On Sat, Oct 29, 2022 at 12:59 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
> Single).
>
> RZ/Five SoC is almost identical to RZ/G2UL Type-1 SoC (ARM64) hence we
> will be reusing r9a07g043.dtsi [0] as a base DTSI for both the SoC's.
> r9a07g043f.dtsi includes RZ/Five SoC specific blocks.
>
> Below are the RZ/Five SoC specific blocks added in the initial DTSI which
> can be used to boot via initramfs on RZ/Five SMARC EVK:
> - AX45MP CPU
> - PLIC
>
> [0] arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4 -> v5
> * Fixed riscv,ndev value (should be 511)
> * Reworked completely (sort of new patch)
>
> v3 -> v4
> * No change
>
> v2 -> v3
> * Fixed clock entry for CPU core
> * Fixed timebase frequency to 12MHz
> * Fixed sorting of the nodes
> * Included RB tags
>
> v1 -> v2
> * Dropped including makefile change
> * Updated ndev count
> ---
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 57 +++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
>
> diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> new file mode 100644
> index 000000000000..50134be548f5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/Five SoC
> + *
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +#define SOC_PERIPHERAL_IRQ(nr) (nr + 32)
> +
> +#include <arm64/renesas/r9a07g043.dtsi>
The initial patch shouldn't be broken. Combine them together with the
minimal components and add others late. Don't separate the DTS files.

> +
> +/ {
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               timebase-frequency = <12000000>;
> +
> +               cpu0: cpu@0 {
> +                       compatible = "andestech,ax45mp", "riscv";
> +                       device_type = "cpu";
> +                       reg = <0x0>;
> +                       status = "okay";
> +                       riscv,isa = "rv64imafdc";
> +                       mmu-type = "riscv,sv39";
> +                       i-cache-size = <0x8000>;
> +                       i-cache-line-size = <0x40>;
> +                       d-cache-size = <0x8000>;
> +                       d-cache-line-size = <0x40>;
> +                       clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
> +
> +                       cpu0_intc: interrupt-controller {
> +                               #interrupt-cells = <1>;
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                       };
> +               };
> +       };
> +};
> +
> +&soc {
> +       interrupt-parent = <&plic>;
> +
> +       plic: interrupt-controller@12c00000 {
> +               compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
> +               #interrupt-cells = <2>;
> +               #address-cells = <0>;
> +               riscv,ndev = <511>;
> +               interrupt-controller;
> +               reg = <0x0 0x12c00000 0 0x400000>;
> +               clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
> +               power-domains = <&cpg>;
> +               resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
Ditto, Where is cpg? in r9a07g043.dtsi?

> +               interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
> +       };
> +};
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
