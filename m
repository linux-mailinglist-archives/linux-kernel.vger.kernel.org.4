Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9306ABBD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCFKWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 05:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCFKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 05:22:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479BA3;
        Mon,  6 Mar 2023 02:22:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so36277871edy.8;
        Mon, 06 Mar 2023 02:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678098126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNrtJRsE6dABDiGSx7TOq0l2sTmEuXcCBgXcO3kg+/w=;
        b=ezBMnHU7JH5JcFgDBHtf0mxNurKzwBRsUBybb11stGQgX3lSqbWsCFXKg2tTP6LJ3F
         UDRS3i/R8NEnxKLFuij+qhSK8oL2k6lPZAzEb4NOa2CPjuhNgJaF6J3Zff+hbNRvVOo4
         kre+grebg40q5JqzhxZ+Wv+5lAukx1xzRS39xm8fNIZM/uJ2BCy5Ia/cojoJvanvaxCW
         rkuqiBaBCWwFyIBaCLTZr8mGqx5jeIq43mLo28v9D0mItwXl2LyF85+Sq23FS+m3whUl
         RBmErGq5/D+HCJGqu7sIlbhzDXSYT4IH5ZHxjukkIfzUXJIlpu9mGVlNf5zZEd+PqNZ8
         2PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNrtJRsE6dABDiGSx7TOq0l2sTmEuXcCBgXcO3kg+/w=;
        b=bb/tZYOr4Jamy+H8t/oqkkrvwmCTgPChu8M5zRnAcbtu9H0ZxTqoEsu3MMA1XD5CDk
         X8COz8AfuyRfRBuFrJrZOAZDWCmy2M48jgR23R8ZC4eRAd7w7HPpz6Nhgfucpx8NRMdB
         MeLboeoP1M1Ej61ca0LMYlLvJuI0dzBO2VS0n0naMdT4tYkQkuxhzOD9mWCBBYKXQO/6
         kndsGCKMmv610vnltPXQjkrSnNs65bbLaQmV7NMRWFrfejaKgf+Bp0WvZmo7qLwV/ODj
         JKTCrTVos9ZYfEgk9u2lMThLN1zgt4G4qFjtk4731J1CGrjNkJrtQwKGSZH9ZDECRBXU
         2L+Q==
X-Gm-Message-State: AO0yUKVYLJT8aIQn6noANvGeX8LbHC6wK+tCWQ8gI8cXD/yhiJ0QdsNa
        t1VswoXc3aqK+Fz3q20RANo=
X-Google-Smtp-Source: AK7set+wUbFY7M3phB1lHjhvXIcWTL9OvRGQa7H3Z9KE8O9kqk1OJeI8bwA6WpZZUNlsMFGzAfmjhQ==
X-Received: by 2002:aa7:c1c4:0:b0:4af:62af:460a with SMTP id d4-20020aa7c1c4000000b004af62af460amr11197692edp.8.1678098126517;
        Mon, 06 Mar 2023 02:22:06 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-172.cust.vodafonedsl.it. [188.217.49.172])
        by smtp.gmail.com with ESMTPSA id se18-20020a170906ce5200b008d6e551e1bcsm4366449ejb.2.2023.03.06.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 02:22:06 -0800 (PST)
Date:   Mon, 6 Mar 2023 11:22:03 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <ZAW+y1CLMV7cJT+p@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <ZAJFpKlXPM+riuSa@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ae6ddeeb-81d3-81e5-c6ab-5d728007817d@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6ddeeb-81d3-81e5-c6ab-5d728007817d@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hal,

On Mon, Mar 06, 2023 at 11:29:48AM +0800, Hal Feng wrote:
> On Fri, 3 Mar 2023 20:08:20 +0100, Tommaso Merciai wrote:
> > Hello Hal,
> > I start to play with jh7110-starfive-visionfive-2-v1.3b I have collect
> > your series [3]. Now I'm trying to boot the image with the following
> > cmds:
> > 
> > setenv bootfile vmlinuz;
> > setenv fileaddr a0000000;
> > setenv fdtcontroladdr 0xffffffffffffffff;
> > setenv ipaddr 10.0.0.100;
> > setenv serverip 10.0.0.1;
> > setenv kernel_comp_addr_r 0xb0000000;
> > setenv kernel_comp_size 0x10000000;
> > tftpboot ${fdt_addr_r} jh7110-starfive-visionfive-2-v1.3b.dtb;
> > tftpboot ${kernel_addr_r} Image.gz;
> > run chipa_set_linux;
> > booti ${kernel_addr_r} - ${fdt_addr_r}
> > 
> > 
> > This the result:
> > 
> > Bytes transferred = 109443584 (685fa00 hex)
> > StarFive # run chipa_set_linux;
> > StarFive # printenv file
> >   fileaddr filesize
> > StarFive # printenv filesize
> > filesize=685fa00
> > StarFive # booti ${kernel_addr_r} - ${fdt_addr_r}
> >    Uncompressing Kernel Image
> > ## Flattened Device Tree blob at 46000000
> >    Booting using the fdt blob at 0x46000000
> >    Using Device Tree in place at 0000000046000000, end 0000000046005c14
> > 
> > Starting kernel ...
> > 
> > clk u5_dw_i2c_clk_core already disabled
> > clk u5_dw_i2c_clk_apb already disabled
> > 
> > ---------------------------------------------
> > 
> > I'm missing something? Any hints?
> > Many thanks in advance! :)
> 
> You can try the instructions at the link [1]. The branch [1] is
> based on v2 of this series, so you need to change the dtb name
> to "jh7110-starfive-visionfive-2-v1.3b.dtb" when using tftpboot.
> I will send v5 and update it to [1] this week.
> 
> [1] https://github.com/starfive-tech/linux/tree/JH7110_VisionFive2_upstream

Thanks for your help!
Collecting your latest 26 patches from [1] I'm able to boot the board
using cmds suggested in your link [2].

In particular I pick the following patches from your repo:

11934a315b67 (HEAD -> visionfive2-minimal, tag: visionfive2-minimal-v4, origin/visionfive2-minimal) riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board device tree
c246291ed2d0 riscv: dts: starfive: Add StarFive JH7110 pin function definitions
53c360e87ee8 riscv: dts: starfive: Add initial StarFive JH7110 device tree
e769528b7cd8 dt-bindings: riscv: Add SiFive S7 compatible
1f4c7408d02a soc: sifive: ccache: Add StarFive JH7110 support
cd1a430b56db dt-bindings: sifive,ccache0: Support StarFive JH7110 SoC
96fcf2e390d3 dt-bindings: interrupt-controller: Add StarFive JH7110 plic
542c43452e08 dt-bindings: timer: Add StarFive JH7110 clint
2b1bb27b0cff dt-bindings: riscv: Add StarFive JH7110 SoC and VisionFive 2 board
328cac9205d2 pinctrl: starfive: Add StarFive JH7110 aon controller driver
dd082f89c4fb pinctrl: starfive: Add StarFive JH7110 sys controller driver
aabf6ba76b81 dt-bindings: pinctrl: Add StarFive JH7110 aon pinctrl
f2c5025c54f9 dt-bindings: pinctrl: Add StarFive JH7110 sys pinctrl
7601624bdde0 reset: starfive: Add StarFive JH7110 reset driver
b1a2db0b97f4 clk: starfive: Add StarFive JH7110 always-on clock driver
0b2aaa26d5c8 clk: starfive: Add StarFive JH7110 system clock driver
2959b29a7d80 dt-bindings: clock: Add StarFive JH7110 always-on clock and reset generator
cfb65ad0957a dt-bindings: clock: Add StarFive JH7110 system clock and reset generator
f9df80901f49 reset: starfive: jh71x0: Use 32bit I/O on 32bit registers
c9400fc69d3a reset: starfive: Rename "jh7100" to "jh71x0" for the common code
8f05fdea85cd reset: starfive: Extract the common JH71X0 reset code
28f5efaa3b06 reset: starfive: Factor out common JH71X0 reset code
aa82ce33f593 reset: Create subdirectory for StarFive drivers
fb87b93f6aa8 clk: starfive: Rename "jh7100" to "jh71x0" for the common code
d73e36277d5f clk: starfive: Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h
04611bf6db16 clk: starfive: Factor out common JH7100 and JH7110 code

Hope this can help other peoples that start to play with
jh7110-starfive-visionfive-2-v1.3b :)
Thanks for your work!

Regards,
Tommaso

[1] https://github.com/hal-feng/linux/commits/visionfive2-minimal
[2] https://github.com/starfive-tech/linux/tree/JH7110_VisionFive2_upstream

> 
> Best regards,
> Hal
