Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A7463928F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKZAPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiKZAPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:15:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124894FFB6;
        Fri, 25 Nov 2022 16:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC58CB82BA7;
        Sat, 26 Nov 2022 00:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F66C4314A;
        Sat, 26 Nov 2022 00:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669421742;
        bh=lFtP2LOwrV6bxmrfqxfzotbmkP1fGcdCPgwDp5svyKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JoiDy5jc/zdc57sYw8om4FYvl3U/pjPO9lypX/pFb0ALNkBPMDZhCK9uDdP89HDxJ
         m3LRLrkh57auX8HzSnAHZbjgCA68selNUwvv29fCh1y8bR8povVwUA6whtWNOoSX7j
         5aFm0fERfpP9Xn3vQuyzPjyaQYFKiqhTRllB0sCaJxBDvG50Q9zelq7f+h5mxQNZPr
         trQUVXtrtLwmHf1hiZ1AesI62dPJGcCAjlVka6PqLvSuC6Q5xsZ7BKwFG8LJLx3eq1
         OwJv9F8YmBSMS/VxDqT/1549LRvmM/KYFvOYN9WpRzT9T3fPEmvLCucc8vqtv0Wpr+
         jpU8BRNC3Lyhw==
Received: by mail-ed1-f51.google.com with SMTP id z63so8277898ede.1;
        Fri, 25 Nov 2022 16:15:42 -0800 (PST)
X-Gm-Message-State: ANoB5pnSTnhTBhjRjPLLzl8DfDH1pGZ2iU4QaaVXEsh6FerGcqLojd4F
        8ubZcLthL0YP+55MUwroeSSkTNiRJ82qf1Rua/o=
X-Google-Smtp-Source: AA0mqf7YYjk0V23n7BvrpBbERlxbL8dgX1iEs1NxHrZwahi2xFz9J0jdWgOmtESE0wc8/Qq6tEttn1t3d+SV0Iy02s0=
X-Received: by 2002:a05:6402:3808:b0:468:c911:d843 with SMTP id
 es8-20020a056402380800b00468c911d843mr37766266edb.422.1669421740753; Fri, 25
 Nov 2022 16:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-4-samuel@sholland.org>
In-Reply-To: <20221125234656.47306-4-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 26 Nov 2022 08:15:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQqPYw61QrfMmWtgAYQSXXABtwftNbruVxxEDUxF=t3=w@mail.gmail.com>
Message-ID: <CAJF2gTQqPYw61QrfMmWtgAYQSXXABtwftNbruVxxEDUxF=t3=w@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
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
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh@kernel.org>
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
> Several SoMs and boards are available that feature the Allwinner D1 or
> D1s SoC. Document their compatible strings.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes in v2:
>  - Add MangoPi MQ (non-Pro) board
>
>  .../devicetree/bindings/riscv/sunxi.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
>
> diff --git a/Documentation/devicetree/bindings/riscv/sunxi.yaml b/Documentation/devicetree/bindings/riscv/sunxi.yaml
> new file mode 100644
> index 000000000000..9edb5e5992b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/sunxi.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/sunxi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner RISC-V SoC-based boards
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Jernej Skrabec <jernej.skrabec@gmail.com>
> +  - Samuel Holland <samuel@sholland.org>
> +
> +description:
> +  Allwinner RISC-V SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Dongshan Nezha STU SoM
> +        items:
> +          - const: 100ask,dongshan-nezha-stu
> +          - const: allwinner,sun20i-d1
> +
> +      - description: D1 Nezha board
> +        items:
> +          - const: allwinner,d1-nezha
> +          - const: allwinner,sun20i-d1
> +
> +      - description: ClockworkPi R-01 SoM and v3.14 board
> +        items:
> +          - const: clockwork,r-01-clockworkpi-v3.14
> +          - const: allwinner,sun20i-d1
> +
> +      - description: ClockworkPi R-01 SoM, v3.14 board, and DevTerm expansion
> +        items:
> +          - const: clockwork,r-01-devterm-v3.14
> +          - const: clockwork,r-01-clockworkpi-v3.14
> +          - const: allwinner,sun20i-d1
> +
> +      - description: Lichee RV SoM
> +        items:
> +          - const: sipeed,lichee-rv
> +          - const: allwinner,sun20i-d1
> +
> +      - description: Carrier boards for the Lichee RV SoM
> +        items:
> +          - enum:
> +              - sipeed,lichee-rv-86-panel-480p
> +              - sipeed,lichee-rv-86-panel-720p
> +              - sipeed,lichee-rv-dock
> +          - const: sipeed,lichee-rv
> +          - const: allwinner,sun20i-d1
> +
> +      - description: MangoPi MQ board
> +        items:
> +          - const: widora,mangopi-mq
> +          - const: allwinner,sun20i-d1s
> +
> +      - description: MangoPi MQ Pro board
> +        items:
> +          - const: widora,mangopi-mq-pro
> +          - const: allwinner,sun20i-d1
> +
> +additionalProperties: true
> +
> +...
> --
> 2.37.4
>


-- 
Best Regards
 Guo Ren
