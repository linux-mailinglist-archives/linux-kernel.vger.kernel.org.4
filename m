Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD58611FF9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ2ESq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2ESn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0076A16D89A;
        Fri, 28 Oct 2022 21:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B4C600BE;
        Sat, 29 Oct 2022 04:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06666C433D6;
        Sat, 29 Oct 2022 04:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017121;
        bh=tGuK0t80zkZtAo5Nex2KKRFbSxKUDdhcBhWx7hEFvuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RtJVoTaiv6EMCogDfUCGceorfx6aaNUEll7Q8rg5fLr4HKY1itrLCISTS66FC9/ou
         AqMIT41osUEC2q49MQnPmnraOkPUzAlNo9WvaRfZiYZbDasUQjpTYFjJ2Fwki1nIIh
         mEDao7xBQ/2A+LLlPqKlV3rJG3JD6ALZJIy9rfXz2RoAllGP/eKfRqV4X8Rue3VXPm
         9jL+GLbvXY/yXvS+RWVJrFou+hGiwvcu0hcYmg6jc/v1tbSAwq0nzkkMBhMSqOzSSj
         d0InLC5Oell6Uj4hUF11zfJ8oydSQddODUY90kMN1YBhV0Klv/O10as6l2gSjMCrEw
         suM1eiENECX5w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13bd19c3b68so8416606fac.7;
        Fri, 28 Oct 2022 21:18:40 -0700 (PDT)
X-Gm-Message-State: ACrzQf1wPL5D0iAC8Ow+6uwj5pDy+1iIjerfeBZCeMhzZtPBhV8rdRfC
        k/Xe4+cWyzUnfhAGk7GDcejUELThX24cA2h4UlE=
X-Google-Smtp-Source: AMsMyM7e6IHCx9azxcE286jAdW0V+KhXxyaPIe0xY+vKOQn5w6MOSy85TfhuXUeFW6s9kqA39gLLKuYmyas/W8K7zG4=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr10197639oap.19.1667017120186; Fri, 28
 Oct 2022 21:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Oct 2022 12:18:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTxzV3M0b4UbPpyUtNTKtT6ViU1i=hihcnneM2M-2jR3A@mail.gmail.com>
Message-ID: <CAJF2gTTxzV3M0b4UbPpyUtNTKtT6ViU1i=hihcnneM2M-2jR3A@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
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
> Add ARCH_RENESAS config option to allow selecting the Renesas RISC-V SoCs.
> We currently have the newly added RZ/Five (R9A07G043) RISC-V based SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4 -> v5
> * Sorted as per SoC name
> * Included RB tag from Conor
>
> v3 -> v4
> * Dropped SOC_RENESAS_RZFIVE config option
> * Dropped explicitly selecting SOC_BUS/GPIOLIB/PINCTRL configs
>   under ARCH_RENESAS
> * Updated commit message
> * Dropped RB tag
> * Used riscv instead of RISC-V in subject line
>
> v2 -> v3
> * Included RB tag from Geert
>
> v1 -> v2
> * No Change
> ---
>  arch/riscv/Kconfig.socs | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 69774bb362d6..75fb0390d6bd 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -7,6 +7,11 @@ config SOC_MICROCHIP_POLARFIRE
>         help
>           This enables support for Microchip PolarFire SoC platforms.
>
> +config ARCH_RENESAS
> +       bool "Renesas RISC-V SoCs"
> +       help
> +         This enables support for the RISC-V based Renesas SoCs.
> +
Looks good.

Reviewed-by: Guo Ren <guoren@kernel.org>

>  config SOC_SIFIVE
>         bool "SiFive SoCs"
>         select SERIAL_SIFIVE if TTY
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
