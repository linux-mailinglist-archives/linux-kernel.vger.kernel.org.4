Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6B611FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJ2EUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2EUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44861B3F;
        Fri, 28 Oct 2022 21:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B84FE6068B;
        Sat, 29 Oct 2022 04:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D659C43149;
        Sat, 29 Oct 2022 04:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017237;
        bh=U1L2nG/BurOlnYwrzwbS8Rl/892HKSG0C1mj+wpdIpA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MkJbyj7GXqH6kBYgZSWN8rLnNX9ZHeCEF5QaLqWj1z47hc2EkDo4IQLzow7RIF8v5
         Yrmsc98T1Jzb0u/pfcM0IR5AFGTyciGI3LSYAh3INWa4ui2CtuzHvHG9Oxw7hAibiA
         iliJa1qpgmWgR1F7dC4qgaF50MG1wauMK4rLISja+5EzQFwKQq+mYM2muyNwJ8cvE4
         DULGxy3QAa3/x8cOIKJy7l8d1RQS2eLGN7O+y1ieqklIB/nftA5Jsa6oTWqtHQAG1x
         9+B4XlqsnngmNAvGLP0BsI8mThceYS8Zo2wUFTM+eAS2aMNV2e4wOfIMyqlIkXhPLi
         lQOEWAEvU09WQ==
Received: by mail-oi1-f175.google.com with SMTP id r187so8121643oia.8;
        Fri, 28 Oct 2022 21:20:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf0K8q5vvWJ27a1yqySWuKBqmC9s+85EZGFgJrHY8/iq/cqFM6/9
        QZM/FZvJRp61MAjY4INlucP207sDxA7qY8WoTlg=
X-Google-Smtp-Source: AMsMyM4a5nUdYCi1/1Tu0LtcsNnTV/tRNEApjoCgKc97PZVomGEhOVoiQ9nNukXf8dxzjzo1Rj1GnEImpNTu908x64w=
X-Received: by 2002:a05:6808:2222:b0:354:9c65:79ed with SMTP id
 bd34-20020a056808222200b003549c6579edmr9039277oib.19.1667017236125; Fri, 28
 Oct 2022 21:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Oct 2022 12:20:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRDTXN9ad4ZRq8qhxNCrMRcKhb5EaPRgzFshAFdyh09Lw@mail.gmail.com>
Message-ID: <CAJF2gTRDTXN9ad4ZRq8qhxNCrMRcKhb5EaPRgzFshAFdyh09Lw@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: riscv: Sort the CPU core list alphabetically
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
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
> Sort the CPU cores list alphabetically for maintenance.
Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4 -> v5
> * Included RB tag from Conor
>
> v3 -> v4
> * Included RB tag from Heiko
>
> v2 -> v3
> * Included RB tag from Geert
>
> v1 -> v2
> * Included RB tag from Krzysztof
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index 90a7cabf58fe..ae7963e99225 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -28,17 +28,17 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - sifive,rocket0
> +              - canaan,k210
>                - sifive,bullet0
>                - sifive,e5
>                - sifive,e7
>                - sifive,e71
> -              - sifive,u74-mc
> -              - sifive,u54
> -              - sifive,u74
> +              - sifive,rocket0
>                - sifive,u5
> +              - sifive,u54
>                - sifive,u7
> -              - canaan,k210
> +              - sifive,u74
> +              - sifive,u74-mc
>            - const: riscv
>        - items:
>            - enum:
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
