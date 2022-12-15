Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6873B64D9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLOKqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLOKqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:46:01 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5BF1A23B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:46:00 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g4so2987176ybg.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4OANl98v7AsQNyM9MzFGjzQDPVC11SlfN97nYRM26M=;
        b=HATD9ebn1O4Qe9c48sjUXAUACDR2u0tYEcJ04UcaOb0gqbvdOEQy2WjU0t1s3K2D+d
         hTGexmJ2/+rL6tOQkJQ/3tejDSjhAmBG8VRo4cm155V0nitfr4/bQmeoNi077uwsxJry
         Oj18WXHOfkY2k34B49RLNqdRYMEAXcdsm7S9ovabE7u89CgLSVoIfpPVrg4GKeHMdxv8
         uU44PZhK8mLJGaxZYdUaW+31l66+FxLUC2QYr2xBEzGB1JRWXSNPhoqSXNyG+xjwEsM+
         FFkfBnC5jXmnkDy9HxV6UXMDhr0atuXFz4P1NmkeU4G2NVrRMhOq6k7HLMF2ix5C2L4e
         mY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4OANl98v7AsQNyM9MzFGjzQDPVC11SlfN97nYRM26M=;
        b=xk4TUMTiCncTW5mCdxVqqUQKI9d9xskTeMsdnB+x1OTBw5JQODT6sGQM536dQrPRYw
         pjAo5NlDUHZBJkBXi0WebCg/wYQw26pEad5nmhb7y4VcLqcr1sPVnQNuVRoyQfSgO9cO
         jHzCwki8vUSnXHOOsI3OJZVBIiuJDHMBLwKrntPJxQcXn384pjLKF1b022u5Ae4/BEMU
         KEshOAVl/VjBpWd8x5rf3ybRiMOEWsAzqWJgXGeV1tErpE+Ab5IhhCtgGnal3ZQQRWgM
         BVFy8xE4Cdwx6Bg0RPBsHlH4Us4pP1DHQLyEOLu8IX5CJMqTEFGxCn+mnYvzEteb1l1b
         PbYQ==
X-Gm-Message-State: ANoB5pleyuqXJC6PtNaNbgSSEGy2Lg5L/T4Oxpy2PR1JcfQY2Hvodf59
        Zx621pQrUMcQkgdZgtrtCMAIh2Y+Y0hvX/JAVUpndA==
X-Google-Smtp-Source: AA0mqf7Z4XI6vc3xWXyspQ0xcWrrGQnaStwZknIY6SMWJ6WCjrysAtVnuDCBX1G9UHn5YWlcNtdhi44B/vwv4QrYGIY=
X-Received: by 2002:a25:8084:0:b0:700:331d:69b4 with SMTP id
 n4-20020a258084000000b00700331d69b4mr19031068ybk.101.1671101159112; Thu, 15
 Dec 2022 02:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20221214182247.79824-1-sebastian.reichel@collabora.com> <20221214182247.79824-4-sebastian.reichel@collabora.com>
In-Reply-To: <20221214182247.79824-4-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Thu, 15 Dec 2022 16:15:47 +0530
Message-ID: <CA+VMnFzMgOC7sgcpQ7nZx2gaJfqqvRu8RxETguaBHN1Lg_nG_w@mail.gmail.com>
Subject: Re: [PATCHv6 3/7] arm64: dts: rockchip: Add base DT for rk3588 SoC
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kever Yang <kever.yang@rock-chips.com>, kernel@collabora.com,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 23:53, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> From: Kever Yang <kever.yang@rock-chips.com>
>
> This initial version supports (single core) CPU, dma, interrupts, timers,
> UART and SDHCI. In short - everything necessary to boot Linux on this
> system on chip.
>
> The DT is split into rk3588 and rk3588s, which is a reduced version
> (i.e. with less peripherals) of the former.
>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, squash and reword commit message]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi  |   58 +
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 1703 +++++++++++++++++++++
>  2 files changed, 1761 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> new file mode 100644
> index 000000000000..d085e57fbc4c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.

< snip>

> +       qos_vop_m0: qos@fdf82000 {
> +               compatible = "rockchip,rk3588-qos", "syscon";
> +               reg = <0x0 0xfdf82000 0x0 0x20>;
> +       };
> +
> +       qos_vop_m1: qos@fdf82200 {
> +               compatible = "rockchip,rk3588-qos", "syscon";
> +               reg = <0x0 0xfdf82200 0x0 0x20>;
> +       };
> +
> +       gmac1: ethernet@fe1c0000 {
> +               compatible = "rockchip,rk3588-gmac", "snps,dwmac-4.20a";
> +               reg = <0x0 0xfe1c0000 0x0 0x10000>;
> +               interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH 0>,
> +                            <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH 0>;
> +               interrupt-names = "macirq", "eth_wake_irq";
> +               clocks = <&cru CLK_GMAC_125M>, <&cru CLK_GMAC_50M>,
> +                        <&cru PCLK_GMAC1>, <&cru ACLK_GMAC1>,
> +                        <&cru CLK_GMAC1_PTP_REF>;
> +               clock-names = "stmmaceth", "clk_mac_ref",
> +                             "pclk_mac", "aclk_mac",
> +                             "ptp_ref";
> +               power-domains = <&power RK3588_PD_GMAC>;
> +               resets = <&cru SRST_A_GMAC1>;
> +               reset-names = "stmmaceth";
> +               rockchip,grf = <&sys_grf>;
> +               rockchip,php-grf = <&php_grf>;
> +               snps,axi-config = <&gmac1_stmmac_axi_setup>;
> +               snps,mixed-burst;
> +               snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
> +               snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
> +               snps,tso;
> +               status = "disabled";
> +
> +               mdio1: mdio {
> +                       compatible = "snps,dwmac-mdio";
> +                       #address-cells = <0x1>;
> +                       #size-cells = <0x0>;
> +               };

One nick with dtbs_check,
ethernet@fe1c0000: Unevaluated properties are not allowed ('reg',
'interrupts', 'interrupt-names', 'power-domains', 'resets',
'reset-names', 'snps,axi-config', 'snps,mixed-burst',
'snps,mtl-rx-config', 'snps,mtl-tx-config', 'snps,tso', 'mdio',
'stmmac-axi-config', 'rx-queues-config', 'tx-queues-config' were
unexpected)

Jagan.
