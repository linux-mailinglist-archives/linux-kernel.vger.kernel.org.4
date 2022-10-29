Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF59C61200D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiJ2E2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2E2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11567796BC;
        Fri, 28 Oct 2022 21:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9396560A50;
        Sat, 29 Oct 2022 04:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F115EC43145;
        Sat, 29 Oct 2022 04:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017692;
        bh=l3gTHpSgHNXx654qe9ChihbsrZyGKjLLonsuLZ91Shc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VreITvgrAng8RK/2/3eW0U6l8vfXPB3rYYtlTDtZ/Yh0OufW0qX7nHUOPgyxoE7wo
         cd1pJViTBE+TzGElUxJk/kN235MWlDydvrjfLKZKWv3o+S50MIAhOoHz8TObcBildH
         Rt2OHz55/zr3Qw1SldexHpWY/9HP2CKqqJqL0kA1vOSJwLgSsJkIh8vHFc434dbWGc
         9PGEdLLPoKaCNgpnXjUbK9FQY+aX7Ji3Lqa+XTg5K6OwkNPprBCW+HJURXHewvinRM
         /vasdphnq2SyKZmoFLOsVFJG+gekpklyhldCTpREZKuaWXFGEdzn6cCr0vn69kmNHh
         ZIJYtS6GaOfpQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13c569e5ff5so8065202fac.6;
        Fri, 28 Oct 2022 21:28:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf2FVwrzRpC+bmcuIoq16RgLJeHDHlzKmvufy/QmzEW5lsTwnd0B
        M3qaZfLl9OjpNmpBQsJY5mVyecSc1OzULWwQmL8=
X-Google-Smtp-Source: AMsMyM7D0WVKxMG8lGL27vGBxZiQxWd/LF+z4X/5eJ9XrOaf52xEFlmhom7cKtUmBn7oO/eOl5+OgclQkUpbt9HX9f0=
X-Received: by 2002:a05:6871:b0d:b0:13b:b91:dc94 with SMTP id
 fq13-20020a0568710b0d00b0013b0b91dc94mr11309668oab.112.1667017691168; Fri, 28
 Oct 2022 21:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Oct 2022 12:27:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS999PrC+uNntH4NF=ppLY0hbNCs=607=z3+LKWBWV3KQ@mail.gmail.com>
Message-ID: <CAJF2gTS999PrC+uNntH4NF=ppLY0hbNCs=607=z3+LKWBWV3KQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] MAINTAINERS: Add entry for Renesas RISC-V
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
> Add RISC-V architecture as part of ARM/Renesas architecture, as they have
> the same maintainers, use the same development collaboration
> infrastructure, and share many files.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4 -> v5
> * Rebased on -next
> * Included RB tag from Conor
>
> v3 -> v4
> * Included RB tag from Geert
>
> v2 -> v3
> * Merged as part of ARM
>
> v1 -> v2
> * New patch
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6cdc2a74c7a2..0204f106d8c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2691,7 +2691,7 @@ F:        arch/arm/boot/dts/rtd*
>  F:     arch/arm/mach-realtek/
>  F:     arch/arm64/boot/dts/realtek/
>
> -ARM/RENESAS ARCHITECTURE
> +ARM/RISC-V/RENESAS ARCHITECTURE
Great! Good luck RISC-V RENESAS ARCHITECTURE.

Reviewed-by: Guo Ren <guoren@kernel.org>

>  M:     Geert Uytterhoeven <geert+renesas@glider.be>
>  M:     Magnus Damm <magnus.damm@gmail.com>
>  L:     linux-renesas-soc@vger.kernel.org
> @@ -2713,6 +2713,7 @@ F:        arch/arm/include/debug/renesas-scif.S
>  F:     arch/arm/mach-shmobile/
>  F:     arch/arm64/boot/dts/renesas/
>  F:     arch/arm64/configs/renesas_defconfig
> +F:     arch/riscv/boot/dts/renesas/
>  F:     drivers/soc/renesas/
>  F:     include/linux/soc/renesas/
>
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
