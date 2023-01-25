Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CFA67B466
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjAYO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAYO1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:27:47 -0500
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5973A8E;
        Wed, 25 Jan 2023 06:27:45 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id v81so9268938vkv.5;
        Wed, 25 Jan 2023 06:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9V62n1SuuxaJ7pP7jmtkw9+HT1Wzz3MzU0APh/E8WXE=;
        b=eNraYPJQnd0N24D2N5MkbkWrISsfVbSCZG9hVlrIgaoX5v7vsEUqVGUOou3zp+KTpm
         wX6n4AD8oet+M8I4864IUJZ6aojBSDvnFb6lodO8fqSxYZALqIDTHI98oN3xUVcVOr+X
         GuTiHYDKkspqyPSN17kNtg94d2nAN+EcgR8V7Ubl2j6Z8or7jGsZXX5ntX3HtWURfcAD
         bbA17aNQkifkc6NnzpUdl1qnB3+WMFGnbVDJt/3jmK0YU+7oGinBs7VdBBIjFmdvb7F0
         a9iYkoAKWTaimmNkvYXnpvzULK/CUD83WpgLNqXKrVUuPvw1nxx0/p6ZqZegxjDYWLOc
         JSdQ==
X-Gm-Message-State: AFqh2kotDkeDY+JM4HkCNJZ3ISpG1bMQjbQnjDDEYMmjleYBQLjLVleG
        Dn37YudAWvLY7aTwrTfNf8QvL6kzuXvZSg==
X-Google-Smtp-Source: AMrXdXt0MrA59pQWUIuLv9FgWb0v1Hdf6tbygx1FX7OU50nxkeJPw1plX31dAbA6f4o+z7xSXSI9VA==
X-Received: by 2002:a05:6122:2211:b0:3e1:79a5:74d7 with SMTP id bb17-20020a056122221100b003e179a574d7mr20566532vkb.10.1674656864500;
        Wed, 25 Jan 2023 06:27:44 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id y21-20020a376415000000b006e07228ed53sm3606019qkb.18.2023.01.25.06.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:27:44 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-4fd37a1551cso240801647b3.13;
        Wed, 25 Jan 2023 06:27:43 -0800 (PST)
X-Received: by 2002:a81:bd6:0:b0:48d:1334:6e38 with SMTP id
 205-20020a810bd6000000b0048d13346e38mr3764419ywl.316.1674656863782; Wed, 25
 Jan 2023 06:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20230118144747.24968-1-fabrizio.castro.jz@renesas.com> <20230118144747.24968-4-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230118144747.24968-4-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 15:27:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXGDETQfOZ4S6_0AZa6QCJ3Kv=hMVHHS7j7tcNJ76GaTg@mail.gmail.com>
Message-ID: <CAMuHMdXGDETQfOZ4S6_0AZa6QCJ3Kv=hMVHHS7j7tcNJ76GaTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: renesas: v2mevk2: Add uSD card and eMMC support
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Wed, Jan 18, 2023 at 3:48 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The RZ/V2M EVK comes with a slot for a uSD card, and an eMMC.
> Add support for the both of them.
>
> Please note that the pinctrl driver for RZ/V2M doesn't support
> interrupts yet, therefore the card detect pin has been connected
> to the SDHI IP directly in this patch.
> We'll connect the card detect pin to its corresponding GPIO when
> we'll have driver support for interrupts in the RZ/V2M pinctrl
> driver.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts

> @@ -50,6 +81,22 @@ phy0: ethernet-phy@0 {
>         };
>  };
>
> +&emmc {
> +       pinctrl-0 = <&emmc_pins>;
> +       pinctrl-1 = <&emmc_pins>;
> +       pinctrl-names = "default", "state_uhs";
> +
> +       vmmc-supply = <&reg_3v3>;
> +       vqmmc-supply = <&reg_1v8>;
> +       bus-width = <8>;
> +       mmc-hs200-1_8v;
> +       non-removable;

Does this need "no-sd" and "no-sdio"?

> +       fixed-emmc-driver-type = <1>;
> +       max-frequency = <200000000>;
> +       status = "okay";
> +};
> +
> +
>  &extal_clk {
>         clock-frequency = <48000000>;
>  };
> @@ -78,6 +125,68 @@ i2c2_pins: i2c2 {
>                 pinmux = <RZV2M_PORT_PINMUX(3, 8, 2)>, /* SDA */
>                          <RZV2M_PORT_PINMUX(3, 9, 2)>; /* SCL */
>         };
> +
> +       sdhi0_pins: sd0 {

[...]

> +       };
> +
> +       sdhi0_pins_uhs: sd0_uhs {

[...]

> +       };
> +
> +       emmc_pins: emmc {

Please move up to preserve sort order.

The rest LGTM, so with the above clarified/fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
