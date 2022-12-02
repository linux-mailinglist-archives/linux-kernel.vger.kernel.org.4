Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CBF640CA3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbiLBRz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiLBRz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:55:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D15E1192
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:55:54 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w129so5579434pfb.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIVCJI4jD1lIjbiWMRsp91OMq2mxFp6avInoFAKoGjM=;
        b=cSgWXMsX1RoL+5udQvWDt9Mzvb/GUkxb7lr4QjFRjq0oQ59uO6vge7FL7/XlwOvtm1
         KugaNQO3/UuThGRpVOYcUYoIXI6Q7h8VmvxxPyMsbJBwnMn8czIub5EC28QJ8sEzTnKy
         dpAHLr6UKIm6MPlD26SKrgxRG8F3IPA0RrQ032XDPKYEOVleaIwxrWV5LxEF1QpbaHZV
         HJyFvVF7u+x8Xd26T2lpr8S5EICPJbooGXlNggHXyBxCQVQbBSSrCfOLFlbsm71EJ/SV
         j5L39oEFJlvJ238eIdswWataHaHR+WZcY25yeumHaQTMj/G4FoMUIXnRkZ6W5nIy7VKn
         mhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIVCJI4jD1lIjbiWMRsp91OMq2mxFp6avInoFAKoGjM=;
        b=jjI+m1KDw4kZx0TAD1KUi2oataWHSqeUsnqzq4xu5i0jkLHuRDTH8wTaFfoGmHnPK8
         Rv3r+UVqVPpwRBpuTV3et8I8oB225tzulPLCUo64f8Bep3CAQbBJtotSdj+BXhQwsd7q
         Nf/7mNjRIpzKcCptz0KUlxQgv5arfufGBGmVy4I6CUK0VKgrzloqfgUjrO35I3SymmWk
         hA/lD5ezf7Em1uUfeFnDvSCqlD5fuJcZjiqkUxlAxhEI3H0tf3bB68TqMLsUXjLlMrux
         9mbQM+s4LxbwzsVTQYs/+rTE6V90OZgrG8px7cC1CM5EMAwXdvu+96cSV3rnbKN1slJb
         lkDw==
X-Gm-Message-State: ANoB5pn1vsgFQ9qW8WTC49qBUvr5jXvDyvB31nQI5wlyJXV2K4NCSM/t
        JWyK8LPfJwHzd1a4bEya9p7blA==
X-Google-Smtp-Source: AA0mqf6AN+4E7ElGbSgBrSB9mToe2z3WVKE97IxqU5sJzaCssDYU0m+RqxwGgAjeYvlEoEAlPHgq6A==
X-Received: by 2002:aa7:8685:0:b0:574:b4a2:bc5d with SMTP id d5-20020aa78685000000b00574b4a2bc5dmr39035823pfo.2.1670003754271;
        Fri, 02 Dec 2022 09:55:54 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z186-20020a6265c3000000b0056bc5ad4862sm5361617pfb.28.2022.12.02.09.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:55:53 -0800 (PST)
Date:   Fri, 02 Dec 2022 09:55:53 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 09:55:35 PST (-0800)
Subject:     Re: [PATCH v2 00/12] riscv: Allwinner D1/D1s platform support
In-Reply-To: <20221125234656.47306-1-samuel@sholland.org>
CC:     wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        heiko@sntech.de, jszhang@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andre.przywara@arm.com, samuel@sholland.org, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        christianshewitt@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        heinrich.schuchardt@canonical.com, linus.walleij@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        stano.jakubek@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     samuel@sholland.org
Message-ID: <mhng-1d8384a6-0b34-45e5-aef6-00865a2b840b@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 15:46:44 PST (-0800), samuel@sholland.org wrote:
> This series adds the Kconfig/defconfig plumbing and devicetrees for a
> range of Allwinner D1 and D1s-based boards. Many features are already
> enabled, including USB, Ethernet, and WiFi.
>
> The devicetrees use bindings from the following series which have not
> yet been merged:
>  - In-package LDO regulators:
>    https://lore.kernel.org/lkml/20221125040112.18160-1-samuel@sholland.org/
>  - Ethernet MAC binding fixes (not a new issue with D1):
>    https://lore.kernel.org/lkml/20221125202008.64595-1-samuel@sholland.org/
>  - RTL8723DS Bluetooth (has driver support, missing documentation):
>    https://lore.kernel.org/lkml/20221125040956.18648-1-samuel@sholland.org/
>  - TI ADC101C ADC (has driver support, missing documentation):
>    https://lore.kernel.org/lkml/20221125220903.8632-1-samuel@sholland.org/
>
> The only remaining DT validation issue is that gpio-fan is missing a
> YAML conversion, although one is on the list here:
> https://lore.kernel.org/lkml/20220126200350.3633576-1-clabbe@baylibre.com/
>
> $ make ARCH=riscv CROSS_COMPILE=riscv64-linux-musl- dtbs_check
>   SYNC    include/config/auto.conf.cmd
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dtb
>   DTC_CHK arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dtb
> arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dtb:0:0: /fan: failed to match any schema with compatible: ['gpio-fan']
>
> I tested this series (DMIC, Ethernet, LEDs, MMC, PMIC, touch, and USB,
> all where available) on the following boards:
>  - sun20i-d1-devterm-v3.14
>  - sun20i-d1-dongshan-nezha-stu
>  - sun20i-d1-lichee-rv-86-panel-480p
>  - sun20i-d1-mangopi-mq-pro
>  - sun20i-d1-nezha
>  - sun20i-d1s-mangopi-mq
>
> Changes in v2:
>  - Add MangoPi MQ (non-Pro) board
>  - Split into separate files for sharing with D1s/R528/T113
>  - Use SOC_PERIPHERAL_IRQ macro for interrupts
>  - Rename osc24M to dcxo and move the frequency to the board DTs
>  - Drop analog LDOs due to the missing binding
>  - Correct tcon_top DSI clock reference
>  - Add DMIC, DSI controller, and DPHY (bindings are in linux-next)
>  - Add CPU OPP table
>  - Common regulators moved to MangoPi MQ patch, removed analog LDOs
>  - Removed LRADC (depends on analog LDOs)
>  - Added XR829 host-wake interrupt
>  - Added DMIC sound card to Lichee RV dock and Lichee RV 86 Panel
>  - Removed LRADC (depends on analog LDOs)
>  - Added LED (GPIO shared between onboard LED and backlight regulator)
>  - Added PMIC GPIO controller node (binding merged for 6.2)
>  - Sort Kconfig as if we had done s/SOC_/ARCH_/ for future-proofing
>
> Samuel Holland (12):
>   MAINTAINERS: Match the sun20i family of Allwinner SoCs
>   dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
>   dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
>   riscv: dts: allwinner: Add the D1/D1s SoC devicetree
>   riscv: dts: allwinner: Add MangoPi MQ devicetree
>   riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
>   riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
>   riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
>   riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
>   riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
>   riscv: Add the Allwinner SoC family Kconfig option
>   riscv: defconfig: Enable the Allwinner D1 platform and drivers
>
>  .../devicetree/bindings/riscv/sunxi.yaml      |  69 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
>  MAINTAINERS                                   |   2 +-
>  arch/riscv/Kconfig.socs                       |   9 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/allwinner/Makefile        |  11 +
>  .../allwinner/sun20i-common-regulators.dtsi   |  35 +
>  .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 253 ++++++
>  .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  36 +
>  .../sun20i-d1-dongshan-nezha-stu.dts          | 118 +++
>  .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +
>  .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 +
>  .../sun20i-d1-lichee-rv-86-panel.dtsi         | 118 +++
>  .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  96 ++
>  .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  88 ++
>  .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 143 +++
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 167 ++++
>  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |  66 ++
>  .../dts/allwinner/sun20i-d1s-mangopi-mq.dts   | 135 +++
>  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi |  76 ++
>  .../boot/dts/allwinner/sunxi-d1-t113.dtsi     |  15 +
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 844 ++++++++++++++++++
>  arch/riscv/configs/defconfig                  |  23 +-
>  23 files changed, 2346 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
>  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-common-regulators.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s-mangopi-mq.dts
>  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1-t113.dtsi
>  create mode 100644 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
