Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38F6314B2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 15:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKTO5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 09:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKTO5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 09:57:45 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D83162F6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:57:37 -0800 (PST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E60F63F4B3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668956255;
        bh=EAN+jo73jsNjm6NxFzDUZqmJuYIU7qlxt8bnncU4Mvs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EweKhtbH0S4qHM3v9TJZWO4zW5LGRlwI3e55xlQOmYfJBZPVcIwG43FJah3h9/Loo
         VUaMHTXJQodT2fa7ASDA+f2Cnn0kyGB8seZ0KGs0dPC/V0Xx1+Lyp+6gaXrL5Ma8V1
         fjPf35TYhk+BVklKXQulT2RPxAAFQ8ZbBfbjSqKKJ6CKkaeaZ+oU3oLTCD+bX2+2Hq
         vzjGc8C1azmt4LubMx3RyAaWd4Wbw/NUSKnj9K5tw4zgM4uXn6TElTwCIaWqLSYwtD
         U5+xOW/shvAzj21CB1VmDChL76vMreGSMBOyyhB2wGccZ9x9Ct23rh3cclEpXu902F
         Oa6dm4htjpYfw==
Received: by mail-yb1-f199.google.com with SMTP id c188-20020a25c0c5000000b006d8eba07513so9126422ybf.17
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAN+jo73jsNjm6NxFzDUZqmJuYIU7qlxt8bnncU4Mvs=;
        b=0Nuo3aim9+eishKcILrqnAU8UG1NKu8Fmcy8s+jid7F48mJJd7SQkLHSQX3q+HAqCm
         +kkU1tP5TxbnahxHBFx/ds/cjna3PcrZp0DwrrrydBelEL9e4Op2t05knTByo6gCVka2
         RwVWfGRcuDWMyLHXi4dlR3BWsGBHFlIoHU39JCq5fZriehAL/BDGlfrtqEy1YIIQ1sZW
         13w3jOUFpD8SFOvF7jFH95nhUVpVzziJSigl86/XxcaWQ227ORS/r3LizkTDA1+vfW2/
         /SiUwhpQynXyfFHWV6O2sTtHVyp/BJtYhakIc1bTJl+sZd7W4DPPzY8qYs67iCriJLFo
         ggYQ==
X-Gm-Message-State: ANoB5pmtvZZPspYwMSq52chG2IREAABfIfXWukP0cXFG/khG+I2YPkj1
        u+0uRIohLaCFIZevFMZxCoU53GnuPpw4nCXrKfQiLvRkTXUKVpt6+kt30oF1kTPUXkorIFcBK+k
        tciTW2/9t3JYYrsT2Zte9zODQxA/ToQb0gUtRb8D+U4pU/sp4FVMyzy1GOA==
X-Received: by 2002:a25:ce45:0:b0:6de:39c1:9cb3 with SMTP id x66-20020a25ce45000000b006de39c19cb3mr3991251ybe.469.1668956254626;
        Sun, 20 Nov 2022 06:57:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6QE5DtMEWnYNqTxZPXyHbUY3mIe3kVEW/kzSrOH//tkMR00zlzUTh2qwSJqJcuQ+yytC0Ib4Ivku6ASbIQfe0=
X-Received: by 2002:a25:ce45:0:b0:6de:39c1:9cb3 with SMTP id
 x66-20020a25ce45000000b006de39c19cb3mr3991228ybe.469.1668956254419; Sun, 20
 Nov 2022 06:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20221120082114.3030-1-jszhang@kernel.org> <20221120082114.3030-6-jszhang@kernel.org>
In-Reply-To: <20221120082114.3030-6-jszhang@kernel.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sun, 20 Nov 2022 15:57:17 +0100
Message-ID: <CAJM55Z_f=zp3Z=wno_yr7csAUMQ472RiZXD19CrDTTxmGAmU4w@mail.gmail.com>
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022 at 09:32, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Add a baisc dtsi for the bouffalolab bl808 SoC.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/Makefile               |  1 +
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ff174996cdfd..b525467152b2 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +subdir-y += bouffalolab
>  subdir-y += sifive
>  subdir-y += starfive
>  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> new file mode 100644
> index 000000000000..c98ebb14ee10
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +       compatible = "bouffalolab,bl808";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       cpus {
> +               timebase-frequency = <1000000>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {
> +                       compatible = "thead,c906", "riscv";
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-block-size = <64>;
> +                       d-cache-sets = <256>;
> +                       d-cache-size = <32768>;
> +                       i-cache-block-size = <64>;
> +                       i-cache-sets = <128>;
> +                       i-cache-size = <32768>;
> +                       mmu-type = "riscv,sv39";
> +                       riscv,isa = "rv64imafdc";
> +
> +                       cpu0_intc: interrupt-controller {
> +                               compatible = "riscv,cpu-intc";
> +                               interrupt-controller;
> +                               #address-cells = <0>;
> +                               #interrupt-cells = <1>;
> +                       };
> +               };
> +       };
> +
> +       xtal: xtal-clk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <40000000>;

This was discussed many times before, but I think the conclusion was
that the frequency is a property of the crystal on the board, so this
should be 0 in the SoC dtsi, and then overwritten in the board device
tree.

> +               clock-output-names = "xtal";
> +               #clock-cells = <0>;
> +       };
> +
> +       soc {
> +               compatible = "simple-bus";
> +               ranges;
> +               interrupt-parent = <&plic>;
> +               dma-noncoherent;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               uart0: serial@30002000 {
> +                       compatible = "bouffalolab,uart";
> +                       reg = <0x30002000 0x1000>;
> +                       interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&xtal>;
> +                       status = "disabled";
> +               };
> +
> +               plic: interrupt-controller@e0000000 {
> +                       compatible = "thead,c900-plic";
> +                       reg = <0xe0000000 0x4000000>;
> +                       interrupts-extended = <&cpu0_intc 0xffffffff>,
> +                                             <&cpu0_intc 9>;
> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       riscv,ndev = <64>;
> +               };
> +       };
> +};
> --
> 2.37.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
