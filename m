Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46795726126
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbjFGNVk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjFGNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:21:36 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C691BFE;
        Wed,  7 Jun 2023 06:21:17 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5659d85876dso78350457b3.2;
        Wed, 07 Jun 2023 06:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144077; x=1688736077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rA2dk4Z+pOkq/jyOIvAGRXOvNoV7/kLeQDZUQrvL074=;
        b=Xuc2BluMHxHXQCCBTAwWQ5MsaVCeOWiBHHOYAlU26FZMSqxCMxLmXK0nbRs6fSon98
         9hZM5OqF2TjIuQOuEoyVKuZwveG/iqK9QLfnIP2nM7sxd97Bxup2x4MugUMVVUYMygcr
         LYE81/DLewtbBKnNzn8h93Hq9+DRokhScsEaI/s/u2h3w5xgYdqrEoMEoi1gGRKuc/5x
         ctQHmPNQ6h2KKIjGHzPW+wIDw2Sq1nDSbyhzzO/XSHhnHF1HuHtmlyQ2WU34XWnV+ZCi
         jsJfvMIY37FFr6/98xKGyYk3SN4uvS6dLh9uzPK0FLmLtW2y6sD1g5jJvZqSSikQIW26
         7eJA==
X-Gm-Message-State: AC+VfDySuFGgo5PWbMQlp0U0ARn7Q+glrr1LixYkIZmg4LzcG1IKAEek
        9I/yv6ZRjaQEF00R4ugqJ6IVNxp04d51yw==
X-Google-Smtp-Source: ACHHUZ7KTFcUC3FyJndrCGLRaGpbn15xpKBxl+uQ5BssG8+rZBxT/uZ9tke/NsGI02yy5SHACsocHA==
X-Received: by 2002:a0d:f343:0:b0:556:ceb2:c462 with SMTP id c64-20020a0df343000000b00556ceb2c462mr6457775ywf.2.1686144076634;
        Wed, 07 Jun 2023 06:21:16 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id k126-20020a816f84000000b00565cf40238csm4720947ywc.110.2023.06.07.06.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:21:16 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so8619116276.3;
        Wed, 07 Jun 2023 06:21:15 -0700 (PDT)
X-Received: by 2002:a25:4889:0:b0:bac:748a:5759 with SMTP id
 v131-20020a254889000000b00bac748a5759mr5257149yba.37.1686144075629; Wed, 07
 Jun 2023 06:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230530112050.5635-1-aford173@gmail.com> <20230530112050.5635-3-aford173@gmail.com>
In-Reply-To: <20230530112050.5635-3-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jun 2023 15:21:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJaZCSN18aB1yBvhuTk=DQoe4B6aVHgoZvyLsZcRfrDA@mail.gmail.com>
Message-ID: <CAMuHMdXJaZCSN18aB1yBvhuTk=DQoe4B6aVHgoZvyLsZcRfrDA@mail.gmail.com>
Subject: Re: [RFC 3/3] arm64: dts: renesas: r8a774a1: Add GPU Node
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
        marek.vasut+renesas@gmail.com, cstevens@beaconembedded.com,
        aford@beaconembedded.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Tue, May 30, 2023 at 1:21 PM Adam Ford <aford173@gmail.com> wrote:
> With the 3dge and ZG clocks now available, the generic GPU node can
> be added.  Until proper firmware is made, it is not usable.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> This is based on the assumption that the Rogue 6250 could use
> generic driver [1] and firmware [2] being implemebted by the Mesa group
> and others.  In practice, the firmware isn't really compatible since
> the 6250 in the RZ/G2M appears to be a different variant.
>
> [1] - https://gitlab.freedesktop.org/frankbinns/powervr/-/tree/powervr-next
> [2] - https://gitlab.freedesktop.org/frankbinns/linux-firmware/-/tree/powervr/powervr

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> @@ -226,6 +226,27 @@ extalr_clk: extalr {
>                 clock-frequency = <0>;
>         };
>
> +       gpu_opp_table: opp-table {
> +               compatible = "operating-points-v2";
> +
> +               opp-200000000 {
> +                       opp-hz = /bits/ 64 <200000000>;
> +                       opp-microvolt = <830000>;
> +               };
> +               opp-300000000 {
> +                       opp-hz = /bits/ 64 <300000000>;
> +                       opp-microvolt = <830000>;
> +               };
> +               opp-400000000 {
> +                       opp-hz = /bits/ 64 <400000000>;
> +                       opp-microvolt = <830000>;
> +               };
> +               opp-600000000 {
> +                       opp-hz = /bits/ 64 <600000000>;
> +                       opp-microvolt = <830000>;
> +               };
> +       };
> +
>         /* External PCIe clock - can be overridden by the board */
>         pcie_bus_clk: pcie_bus {
>                 compatible = "fixed-clock";
> @@ -2347,6 +2368,18 @@ gic: interrupt-controller@f1010000 {
>                         resets = <&cpg 408>;
>                 };
>
> +               gpu@fd000000 {
> +                       compatible = "img,powervr-series6xt";
> +                       reg = <0 0xfd000000 0 0x40000>;
> +                       interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 112>, <&cpg CPG_MOD 112>,<&cpg CPG_MOD 112>;
> +                       clock-names = "core", "mem", "sys";
> +                       interrupt-names = "gpu";
> +                       operating-points-v2 = <&gpu_opp_table>;
> +                       power-domains = <&sysc R8A774A1_PD_3DG_B>;
> +                       resets = <&cpg 112>;
> +               };
> +
>                 pciec0: pcie@fe000000 {
>                         compatible = "renesas,pcie-r8a774a1",
>                                      "renesas,pcie-rcar-gen3";

LGTM.  But obviously I cannot take this as-is, as there are no DT bindings
for this device, and it didn't work for you...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
