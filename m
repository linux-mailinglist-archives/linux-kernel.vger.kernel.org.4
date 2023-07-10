Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141EA74D8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjGJOVj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 10:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjGJOVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:21:37 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61F90;
        Mon, 10 Jul 2023 07:21:36 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5774098f16eso57933067b3.0;
        Mon, 10 Jul 2023 07:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688998895; x=1691590895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBgv4VDyK5Qpjwf08U4WRFtQUEIQXzacdhbznuzNbE4=;
        b=FL9+OqsqQuIawmPMrDdaCTSvRlqcU8SRD/pgvQlLHY1EzXvXqTOwpaugUDWU15umSD
         6ErMJAYmYNdAyLXPJbnToKRCGW089tWnDUtkw6U2vfvv11L2B3OhkIGesP628UAPJ6AF
         dIQ7q9U4+93xR5ErIwrCngWz6eIp0+A9FoE/Z8rVYRNjcqpGW4rr+ZpH2X/34b2IcMdg
         X/TkXrkhR9DrLtjxo1IXHxPQK9j+wG7W8j28MEtdKHrH6vRHUDC4odHwMmw54XE3Ch2P
         qgNbqWzmATrYuMQ0LJsJf+8r16mGir0J2XpkRGxO21HQKarLlTBzaHri6uYqc/2vpQ+O
         cG1g==
X-Gm-Message-State: ABy/qLbdB0d4HIAOypj7HgLjN31RTL2M5e8Pf6bTpc0zgjOhdKoIM6I6
        tKIhmgy+JWjTt3+VrFbBQmSlw1gU0cJUlA==
X-Google-Smtp-Source: APBJJlGHjs7T6f9otWBMkM5Vzps9n4ydIalN/l/KB25NTraZMCfROwDMFgvZnof1jjwXNT4XYa4Oww==
X-Received: by 2002:a81:5c46:0:b0:57a:50af:b760 with SMTP id q67-20020a815c46000000b0057a50afb760mr12540822ywb.16.1688998895425;
        Mon, 10 Jul 2023 07:21:35 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id k1-20020a0dfa01000000b0057a165e6ee1sm3111252ywf.35.2023.07.10.07.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:21:35 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5774098f16eso57932787b3.0;
        Mon, 10 Jul 2023 07:21:35 -0700 (PDT)
X-Received: by 2002:a5b:d02:0:b0:c13:aca0:b713 with SMTP id
 y2-20020a5b0d02000000b00c13aca0b713mr11344591ybp.1.1688998894843; Mon, 10 Jul
 2023 07:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230630120433.49529-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230630120433.49529-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 16:21:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWEYfBS8018BsVnYRj0+2VMY2QWnZnBB+ATfKPuAuJmMA@mail.gmail.com>
Message-ID: <CAMuHMdWEYfBS8018BsVnYRj0+2VMY2QWnZnBB+ATfKPuAuJmMA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] riscv: dts: renesas: r9a07g043f: Update
 gpio-ranges property
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jun 30, 2023 at 2:05 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On RZ/Five we have additional pins compared to the RZ/G2UL SoC so update
> the gpio-ranges property in RZ/Five SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -42,6 +42,10 @@ cpu0_intc: interrupt-controller {
>         };
>  };
>
> +&pinctrl {
> +       gpio-ranges = <&pinctrl 0 0 232>;

Is that correct? You only have 32 more pins than on r9a07g043u,
which uses:

                        gpio-ranges = <&pinctrl 0 0 152>;

> +};
> +
>  &soc {
>         dma-noncoherent;
>         interrupt-parent = <&plic>;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
