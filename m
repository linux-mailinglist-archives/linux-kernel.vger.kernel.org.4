Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D5F69696F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjBNQ0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Feb 2023 11:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBNQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:26:12 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09041CF43;
        Tue, 14 Feb 2023 08:25:46 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id nd22so8205617qvb.1;
        Tue, 14 Feb 2023 08:25:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjQ0CpBgeW3VIFOUjvZsQvtKtZR2pIvObv825jLtQY0=;
        b=lN0z/Qf1RCvUzxlQFpx0+DOhslR+UZZqV3IO7aP6c4H5YCs5BaxcvD9X9UH/ZbYm4F
         4scw91dKJOeCzkwRi2CL6yERHQm3i8MUDzsiw2EajWraksaa3eVur7VxxmM1EWkjSMcA
         v+GBrnMOajBk88WBwC2wCZgFNsv2UJJ5r/zDnrbdu5B+zKiizdEZz17CAxLRneye5f+f
         FU+F7H+mQLsdQHPRtmB8wS9k8NWPbCGNU6OPff+R9+Mey0MLpOH8miV6iAZkbATDgoCz
         Vmd7pWtIOFCX7qRBY/a4HzA2raZgFI1k/WRC1z3liA5Ds5mNySvG4oPhI0P6VjsvEJeL
         iW2Q==
X-Gm-Message-State: AO0yUKU5cwnwli8j1xikx1fKyrS2bUh/3FyOib/94gJxZkADGRzKJauj
        KVlW5PrtiHtQyw39x91ErOcYPHIOcPZFOGyd
X-Google-Smtp-Source: AK7set/fxB011dHVaFsoTZdaiVdF//J9WTRdVGTfxRXQ6LMGD1B+sZ6sZB5bqRUXmVKCXC/P5A8DkA==
X-Received: by 2002:a05:6214:21ea:b0:56e:a6bb:47ae with SMTP id p10-20020a05621421ea00b0056ea6bb47aemr4878289qvj.12.1676391927049;
        Tue, 14 Feb 2023 08:25:27 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id x133-20020a37638b000000b006e07228ed53sm12227587qkb.18.2023.02.14.08.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 08:25:26 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-52f1b1d08c2so88946317b3.5;
        Tue, 14 Feb 2023 08:25:26 -0800 (PST)
X-Received: by 2002:a05:690c:ea2:b0:4fc:962d:7dc1 with SMTP id
 cr2-20020a05690c0ea200b004fc962d7dc1mr262523ywb.301.1676391925902; Tue, 14
 Feb 2023 08:25:25 -0800 (PST)
MIME-Version: 1.0
References: <20230209133507.150571-1-clement.leger@bootlin.com> <20230209133507.150571-3-clement.leger@bootlin.com>
In-Reply-To: <20230209133507.150571-3-clement.leger@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Feb 2023 17:25:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUorkDYXZvsd-9rjwEkeJYC_FMfexZHaGYHDry=9Yjdg@mail.gmail.com>
Message-ID: <CAMuHMdWUorkDYXZvsd-9rjwEkeJYC_FMfexZHaGYHDry=9Yjdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: r9a06g032: add r9a06g032-rzn1d400-eb
 board device-tree
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

CC Gareth

On Thu, Feb 9, 2023 at 2:32 PM Clément Léger <clement.leger@bootlin.com> wrote:
> The EB board (Expansion board) supports both RZ/N1D and RZ-N1S. Since this
> configuration targets only the RZ/N1D, it is named r9a06g032-rzn1d400-eb.
> It adds support for the 2 additional switch ports (port C and D) that are
> available on that board.
>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the RZN1D-EB Board
> + *
> + * Copyright (C) 2023 Schneider-Electric
> + *
> + */
> +
> +#include "r9a06g032-rzn1d400-db.dts"
> +
> +/ {
> +       model = "RZN1D-EB Board";
> +       compatible = "renesas,rzn1d400-eb", "renesas,rzn1d400-db",
> +                    "renesas,r9a06g032";
> +};
> +
> +&mii_conv2 {
> +       renesas,miic-input = <MIIC_SWITCH_PORTD>;
> +       status = "okay";
> +};
> +
> +&mii_conv3 {
> +       renesas,miic-input = <MIIC_SWITCH_PORTC>;
> +       status = "okay";
> +};
> +
> +&pinctrl{
> +       pins_eth1: pins-eth1 {
> +               pinmux = <RZN1_PINMUX(12, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(13, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(14, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(15, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(16, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(17, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(18, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(19, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(20, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(21, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(22, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(23, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>;
> +               drive-strength = <6>;
> +               bias-disable;
> +       };
> +
> +       pins_eth2: pins-eth2 {
> +               pinmux = <RZN1_PINMUX(24, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(25, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(26, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(27, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(28, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(29, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(30, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(31, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(32, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(33, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(34, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>,
> +                        <RZN1_PINMUX(35, RZN1_FUNC_CLK_ETH_MII_RGMII_RMII)>;
> +               drive-strength = <6>;
> +               bias-disable;
> +       };
> +};
> +
> +&switch {
> +       pinctrl-names = "default";

No need to specify pinctrl-names, as it is inherited from
r9a06g032-rzn1d400-db.dts.

> +       pinctrl-0 = <&pins_eth1>, <&pins_eth2>, <&pins_eth3>, <&pins_eth4>,
> +                   <&pins_mdio1>;
> +
> +       mdio {
> +               /* CN15 and CN16 switches must be configured in MDIO2 mode */
> +               switch0phy1: ethernet-phy@1 {
> +                       reg = <1>;
> +                       marvell,reg-init = <3 16 0 0x1010>;

marvell,reg-init is not documented in any DT bindings document?

> +               };
> +
> +               switch0phy10: ethernet-phy@10 {
> +                       reg = <10>;
> +                       marvell,reg-init = <3 16 0 0x1010>;
> +               };
> +       };
> +};
> +
> +&switch_port2 {
> +       label = "lan2";
> +       phy-mode = "rgmii-id";
> +       phy-handle = <&switch0phy10>;
> +       status = "okay";
> +};
> +
> +&switch_port3 {
> +       label = "lan3";
> +       phy-mode = "rgmii-id";
> +       phy-handle = <&switch0phy1>;
> +       status = "okay";
> +};

The rest LGTM (as far as I can understand ;-)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
