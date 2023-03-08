Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B036AFDC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCHENi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCHENe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:13:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA54D2BD;
        Tue,  7 Mar 2023 20:13:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E43CB81BA3;
        Wed,  8 Mar 2023 04:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF59AC433D2;
        Wed,  8 Mar 2023 04:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678248808;
        bh=KZvivIcdP43nYQjxQV2iwy3EY21Hd7biSu6JBWcNfhA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FY3fSwVznCdLYf12nQOi9w6m5JC9HIX1lu0oTTGwzhae4vR1xHUFne0K9vM3k3gx/
         WK26UtVGMZbRKFpErJt2X4Q7NypRWu/59n0HDZooOBq/VXz3mP/AsN8KGsNAztJKAW
         RwGjAvM/6WwK9M+Jb8/qOPKoGDdAZEGT3MQkmDNO12dk6s15lVhr578O2Lf1wp1BtY
         AILSFO5FOHQMdPpZFCrvk06w/anJ5hFe7RW7k2iMKW9QGNAiovFll/9CgKr10qGLl/
         BtRGBgah4wK0dZenNkWN7Ow40Sx7B4Q/sZ7gHrOt8x+nbAvjXQ6rgR4LOEV3D6rK9m
         WGglQ6e3QwO3A==
Received: by mail-ed1-f48.google.com with SMTP id da10so60871535edb.3;
        Tue, 07 Mar 2023 20:13:28 -0800 (PST)
X-Gm-Message-State: AO0yUKUPaJVWp2rFYUSp06Z7U/EHExAoGJ6+AkY7JrIi9LUlF4iMSTv9
        dgzgvQWfMw/VnbNwOjz6IkPfEEDskkhtOFGnpcM=
X-Google-Smtp-Source: AK7set/OXHamMd30xa9MOxiTaztHdq2/uUI5fxgIghiVMrlHV5++je5CqfJuFdwe8KixFa9DHTv2yqkrJAn+QxpPD+o=
X-Received: by 2002:a50:9b53:0:b0:4ae:f648:950b with SMTP id
 a19-20020a509b53000000b004aef648950bmr9192549edj.7.1678248807011; Tue, 07 Mar
 2023 20:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20221231235541.13568-1-samuel@sholland.org>
In-Reply-To: <20221231235541.13568-1-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 8 Mar 2023 12:13:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTgV=xTq-vqf4KHcpcRndp1=o74NebvAVfpC8CMRv8qWA@mail.gmail.com>
Message-ID: <CAJF2gTTgV=xTq-vqf4KHcpcRndp1=o74NebvAVfpC8CMRv8qWA@mail.gmail.com>
Subject: Re: [RESEND PATCH v7 0/5] leds: Allwinner A100 LED controller support
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Samuel,

On Sun, Jan 1, 2023 at 7:55=E2=80=AFAM Samuel Holland <samuel@sholland.org>=
 wrote:
>
> [Resending because it has been a couple of months since v7 with no LED
> maintainer feedback, and LEDs now have an additional maintainer.]
>
> This series adds bindings and a driver for the RGB LED controller found
> in some Allwinner SoCs, starting with A100. The hardware in the R329 and
> D1 SoCs appears to be identical.
>
> Patches 4-5 depend on the D1 devicetree series[1], but the rest of this
> series can/should be merged without them.
>
> This driver was tested on the D1 Nezha board.
>
> [1]: https://lore.kernel.org/lkml/20221231233851.24923-1-samuel@sholland.=
org/
>
> Changes in v7:
>  - Use DEFINE_SIMPLE_DEV_PM_OPS
>
> Changes in v6:
>  - Drop the A100 DMA controller DT node patch, which was merged via a
>    different series
>
> Changes in v5:
>  - A100 contains the original implementation, so use that as the base
>    compatible string, and rename the binding to match
>  - Add "unevaluatedProperties: false" to the child multi-led binding
>  - Rename the driver R329 -> A100, since that is the actual original
>    implementation
>
> Changes in v4:
>  - Use "default" instead of "maxItems" for timing properties
>  - Depend on LEDS_CLASS_MULTICOLOR
>
> Changes in v3:
>  - Removed quotes from enumeration values
>  - Added vendor prefix to timing/format properties
>  - Renamed "format" property to "pixel-format" for clarity
>  - Dropped "vled-supply" as it is unrelated to the controller hardware
>  - Added vendor prefix to timing/format properties
>  - Renamed "format" property to "pixel-format" for clarity
>  - Dropped "vled-supply" as it is unrelated to the controller hardware
>  - Changed "writesl" to "iowrite32_rep" so the driver builds on hppa
>
> Changes in v2:
>  - Fixed typo leading to duplicate t1h-ns property
>  - Removed "items" layer in definition of dmas/dma-names
>  - Replaced uint32 type reference with maxItems in timing properties
>  - Renamed from sunxi-ledc to sun50i-r329-ledc
>  - Added missing "static" to functions/globals as reported by 0day bot
>
> Samuel Holland (5):
>   dt-bindings: leds: Add Allwinner A100 LED controller
>   leds: sun50i-a100: New driver for the A100 LED controller
>   arm64: dts: allwinner: a100: Add LED controller node
>   riscv: dts: allwinner: d1: Add LED controller node
>   riscv: dts: allwinner: d1: Add RGB LEDs to boards
>
>  .../leds/allwinner,sun50i-a100-ledc.yaml      | 139 +++++
>  .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  14 +
>  .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  12 +
>  .../boot/dts/allwinner/sun20i-d1-nezha.dts    |  13 +
>  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  |   6 +
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  15 +
>  drivers/leds/Kconfig                          |   9 +
>  drivers/leds/Makefile                         |   1 +
>  drivers/leds/leds-sun50i-a100.c               | 555 ++++++++++++++++++
>  9 files changed, 764 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun5=
0i-a100-ledc.yaml
>  create mode 100644 drivers/leds/leds-sun50i-a100.c
Acked-by: Guo Ren <guoren@kernel.org>

>
> --
> 2.37.4
>


--=20
Best Regards
 Guo Ren
