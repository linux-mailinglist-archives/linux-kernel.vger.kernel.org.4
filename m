Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8062B5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiKPJEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiKPJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:04:07 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B2A2181;
        Wed, 16 Nov 2022 01:04:06 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id x21so11233589qkj.0;
        Wed, 16 Nov 2022 01:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmIeQZARSPuMEBQfP7VelxzQDQAJgpM+Uez3QuwZD1U=;
        b=WvJfIbqzh1VzKKrxFqDvjpkA1xx1Xa7q6Hx3P0/VH86bLEZHGIZVih9ffPhpFYmKq4
         iA6OjnFxRolg6ekR867TiBQAfv6okrMcljziquHjOwKunPWPdhWAc4Gt7a+IaaiOZV7j
         5N5/ghhNTgszURwtzL5hZA1PEZk4DVTgvZkN7lNMBR+PYsk+9R8ovb6Kn2FbXxVROvoX
         YrVpqQwbzYjl2upVxA7FJmhsVxgWqXtWCsX+Qw6mcREZAoCulofP8gDNBC9QWA0ieejP
         cMPXo7/ErHcK7mZBzyPs3hr7CIZTevBeeVddd1KZvuFoewkVagnjBFIAdjfNJ9H0mV21
         ch3w==
X-Gm-Message-State: ANoB5pl1IGpktcENemFWi9+diORfL6Bs1GOStGBJkPa8vCxQDJQiOvL5
        xx4CdpV5Y8FgGMGzDCyy9peVxk/vPuCIAQ==
X-Google-Smtp-Source: AA0mqf6Gz6PqC8rtjnxkEwCYYASm0cLGmBoPL/sU4BTw/PjY4T4xXaQHzhEFSxfDoF6eLcUrrBUyYQ==
X-Received: by 2002:a05:620a:9c6:b0:6fa:59b4:f37b with SMTP id y6-20020a05620a09c600b006fa59b4f37bmr17928140qky.349.1668589445371;
        Wed, 16 Nov 2022 01:04:05 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id ay42-20020a05622a22aa00b0039a08c0a594sm8399285qtb.82.2022.11.16.01.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:04:04 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id e68so17362527ybh.2;
        Wed, 16 Nov 2022 01:04:04 -0800 (PST)
X-Received: by 2002:a25:258d:0:b0:6ca:3b11:8d76 with SMTP id
 l135-20020a25258d000000b006ca3b118d76mr20609898ybl.202.1668589444351; Wed, 16
 Nov 2022 01:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221115105135.1180490-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221115105135.1180490-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Nov 2022 10:03:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWEnd1A3s6iPAqB_+78Q_Sx73XQBW5wU9Mtouw4EiOmJQ@mail.gmail.com>
Message-ID: <CAMuHMdWEnd1A3s6iPAqB_+78Q_Sx73XQBW5wU9Mtouw4EiOmJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: dts: renesas: r9a07g043f/rzfive-smarc-som:
 Enable ADC/OPP/Thermal Zones/TSU
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Nov 15, 2022 at 11:51 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable support for below blocks found on RZ/Five SMARC EVK SoC/SoM:
> - ADC
> - OPP
> - Thermal Zones
> - TSU
>
> Note, these blocks are enabled in RZ/G2UL SMARC SoM DTSI [0] hence
> deleting these disabled nodes from RZ/Five SMARC SoM DTSI enables them
> here too as we include [0] in RZ/Five SMARC SoM DTSI.
>
> [0] arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> @@ -16,13 +16,6 @@ aliases {
>         chosen {
>                 bootargs = "ignore_loglevel";
>         };
> -
> -       /delete-node/opp-table-0;
> -       /delete-node/thermal-zones;
> -};
> -
> -&adc {
> -       status = "disabled";

I believe this is not sufficient to enable the ADC, as it is disabled
by default?
So this needs to set the status to "okay" and configure pin
control, depending on SW_SW0_DEV_SEL, just like in
arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi?

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
