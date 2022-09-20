Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98945BE5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiITMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiITMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:32:43 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC032753B2;
        Tue, 20 Sep 2022 05:32:39 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id m9so1861750qvv.7;
        Tue, 20 Sep 2022 05:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Wf+OpOOgKm2MQUZNT6fzDTc2lerh5dFGABEYb4COJ4Y=;
        b=oPJtUACPa+yeG10enZMgNzR4vA9vJARWIAbZcucDDNSzYHQ6QJKvomdVKAlYREF9kr
         ZVWOo+2VQ90xxvW7Gcj3OjQ5XGWiD/wZosqBLN+QkeX1Ikp0fwwvIo0QJX3Ymd9fgOVb
         W9mUT5E9wLPMRdWlpWXa1bUDqeN2omfHc4S75y8SoxmDxCzrpMQbWdefmve39sIzXUE8
         C8zdqlc9QHSSDgd2RtNUxcZ/BjZ9pGu9vFg9I2KhyztXP0SOBIM1smIviKkdjZ+mb/p8
         0KhoggbQmEiggnug9OVJ/ogbGsP1lwoBoVGqWIpBu+6XRb3GFfU02K4yuel82XjT78VS
         /kWA==
X-Gm-Message-State: ACrzQf2XHcxdD2/CYITzUYk47xfCR9pTQpfagQf9HO+cMxKK/vQOQg+s
        PvplZV6hwVgB6tKfn3Eq2sTKIPadcJgTFA==
X-Google-Smtp-Source: AMsMyM7Yo9TjkGZ98y/4LtdivMQ4NpD3iJ0oBbqoQctlUyO0brSTKE1Lzd4ZUWQRvbPTL6R9S7upig==
X-Received: by 2002:a05:6214:27ed:b0:4ac:7fd7:7d8b with SMTP id jt13-20020a05621427ed00b004ac7fd77d8bmr18620641qvb.129.1663677158499;
        Tue, 20 Sep 2022 05:32:38 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id bn35-20020a05620a2ae300b006cbc00db595sm53521qkb.23.2022.09.20.05.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 05:32:37 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-333a4a5d495so24781107b3.10;
        Tue, 20 Sep 2022 05:32:37 -0700 (PDT)
X-Received: by 2002:a81:6756:0:b0:345:525e:38 with SMTP id b83-20020a816756000000b00345525e0038mr19491451ywc.47.1663677157058;
 Tue, 20 Sep 2022 05:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220915181558.354737-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 14:32:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW99EutciosPtOTU9AztfvfMdKTaS+YRmpmS4VnhZ9KAA@mail.gmail.com>
Message-ID: <CAMuHMdW99EutciosPtOTU9AztfvfMdKTaS+YRmpmS4VnhZ9KAA@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] riscv: dts: renesas: Add minimal DTS for Renesas
 RZ/Five SMARC EVK
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Sep 15, 2022 at 8:17 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the minimal blocks required for booting the Renesas RZ/Five
> SMARC EVK with initramfs.
>
> Below are the blocks enabled:
> - CPG
> - CPU0
> - DDR (memory regions)
> - PINCTRL
> - PLIC
> - SCIF0
>
> Note we have deleted the nodes from the DT for which support needs to be
> added for RZ/Five SoC and are enabled by RZ/G2UL SMARC EVK SoM/carrier
> board DTS/I.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> * Dropped RB tags from Conor and Geert
> * Now re-using the SoM and carrier board DTS/I from RZ/G2UL

Thanks for the update!

> --- /dev/null
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/Five SMARC EVK
> + *
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +/dts-v1/;
> +
> +/*
> + * DIP-Switch SW1 setting
> + * 1 : High; 0: Low
> + * SW1-2 : SW_SD0_DEV_SEL      (0: uSD; 1: eMMC)
> + * SW1-3 : SW_ET0_EN_N         (0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
> + * Please change below macros according to SW1 setting on SoM

"on the SoM" (like in r9a07g043u11-smarc.dts)?

> --- /dev/null
> +++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ/Five SMARC EVK SOM
> + *
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#include <arm64/renesas/rzg2ul-smarc-som.dtsi>
> +
> +/ {
> +       aliases {
> +               /delete-property/ ethernet0;
> +               /delete-property/ ethernet1;

OK

> +       };
> +
> +       chosen {
> +               bootargs = "ignore_loglevel";
> +       };
> +};
> +
> +#if (SW_SW0_DEV_SEL)
> +/delete-node/ &adc;
> +#endif
> +
> +#if (!SW_ET0_EN_N)
> +/delete-node/ &eth0;
> +#endif
> +/delete-node/ &eth1;
> +
> +/delete-node/ &ostm1;
> +/delete-node/ &ostm2;

Given they are all placeholders, do you really need to delete them?
(more below)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
