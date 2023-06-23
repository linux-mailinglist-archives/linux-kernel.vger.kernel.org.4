Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA66573B2D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjFWIlB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjFWIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:40:59 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6801B4;
        Fri, 23 Jun 2023 01:40:57 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-3ff274778feso4520591cf.1;
        Fri, 23 Jun 2023 01:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687509657; x=1690101657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3YbNGYLQjiL7Y5daSRoiDrXijuvl42Jh6Pko97orUI=;
        b=FZOT9MzloR5f0rp1HVmPr3Ug1nyKl8xD9dclFAlBq+J/SZXjgAQfVYV5mXiMTdOmIy
         Lmxn7QAmXzMnkNVhlDVUlF61o9at/3k8WwxvQgEmn/u/8chVt9sUCPK1g9Rf6n8mSggM
         Fc6Stq97z34jknN+ZwD+6E+dyw6OHhXnNLjEzVc6E5VPvqA2FbyHc6aZaSvC3qScgZ1l
         r1OsRbvtPlKZpr4Uqc9jJpjslh6YBeXhPneuiu59C6QSJTpKa8GkZ/V5p/vZ3KLO5C6f
         om5GBnGalJ4eGzP7ulWyWoUW2VBrL+Iv/j42TXWkbD6EibwDjI+hQZoOFKTNfM7Itm0y
         KVRQ==
X-Gm-Message-State: AC+VfDz6pQmVvMQ/wI9VMfb6lCe0PCoHlzpmErhEBkFTK6m8KpzYGR2c
        QBKGDjCTRQFFNfI7+xkkVrAreAmkrewJQg==
X-Google-Smtp-Source: ACHHUZ4Q76RfxRS8IlEllxF68HdYht9dYb31qqmp9NGHxi1qDkU8TOsy+tGIrrFLojzKkonwhXjDmw==
X-Received: by 2002:a05:622a:20f:b0:3f9:c539:c9d5 with SMTP id b15-20020a05622a020f00b003f9c539c9d5mr28207811qtx.68.1687509656750;
        Fri, 23 Jun 2023 01:40:56 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id v15-20020a2583cf000000b00bfee65aff13sm1382807ybm.40.2023.06.23.01.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 01:40:56 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bd77424c886so448269276.0;
        Fri, 23 Jun 2023 01:40:56 -0700 (PDT)
X-Received: by 2002:a25:c746:0:b0:b9e:889:420f with SMTP id
 w67-20020a25c746000000b00b9e0889420fmr20362043ybe.12.1687509655921; Fri, 23
 Jun 2023 01:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230623080135.15696-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230623080135.15696-1-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 10:40:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNG_LENbU_nu-W+x_snXxbz3vbs=Yb-__FF3DBR2JEUA@mail.gmail.com>
Message-ID: <CAMuHMdVNG_LENbU_nu-W+x_snXxbz3vbs=Yb-__FF3DBR2JEUA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzv2mevk2: Fix eMMC/SDHI pinctrl names
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

CC pinctrl

Thanks for your patch!

On Fri, Jun 23, 2023 at 10:01 AM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The original commit uses the same names ("data" and "ctrl")
> for the subnodes of pinctrl definitions for both eMMC and
> SDHI0 (emmc_pins, sdhi0_pins, and sdhi0_pins_uhs) leading to

That should be fine, as the parents of these subnodes do have different
names?

> the below issue:
>
> pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by 85000000.mmc; cannot claim for 85020000.mmc
> pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
> renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting, reverse things back

To me, that sounds like a bug in the pinctrl core.
Or am I missing something?

> This commit fixes the problem by making the names for the
> pinctrl subnodes of eMMC and SDHI0 unique.
>
> Fixes: b6c0be722b0c ("arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
> index 39fe3f94991e..11c5cffea5a5 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
> @@ -167,7 +167,7 @@ &i2c2 {
>
>  &pinctrl {
>         emmc_pins: emmc {
> -               data {
> +               emmc_data {
>                         pinmux = <RZV2M_PORT_PINMUX(0, 0, 2)>, /* MMDAT0 */
>                                  <RZV2M_PORT_PINMUX(0, 1, 2)>, /* MMDAT1 */
>                                  <RZV2M_PORT_PINMUX(0, 2, 2)>, /* MMDAT2 */
> @@ -179,7 +179,7 @@ data {
>                         power-source = <1800>;
>                 };
>
> -               ctrl {
> +               emmc_ctrl {
>                         pinmux = <RZV2M_PORT_PINMUX(0, 10, 2)>, /* MMCMD */
>                                  <RZV2M_PORT_PINMUX(0, 11, 2)>; /* MMCLK */
>                         power-source = <1800>;
> @@ -197,7 +197,7 @@ i2c2_pins: i2c2 {
>         };
>
>         sdhi0_pins: sd0 {
> -               data {
> +               sd0_data {
>                         pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
>                                  <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
>                                  <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
> @@ -205,20 +205,20 @@ data {
>                         power-source = <3300>;
>                 };
>
> -               ctrl {
> +               sd0_ctrl {
>                         pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
>                                  <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
>                         power-source = <3300>;
>                 };
>
> -               cd {
> +               sd0_cd {
>                         pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
>                         power-source = <3300>;
>                 };
>         };
>
>         sdhi0_pins_uhs: sd0-uhs {
> -               data {
> +               sd0_uhs_data {
>                         pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
>                                  <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
>                                  <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
> @@ -226,13 +226,13 @@ data {
>                         power-source = <1800>;
>                 };
>
> -               ctrl {
> +               sd0_uhs_ctrl {
>                         pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
>                                  <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
>                         power-source = <1800>;
>                 };
>
> -               cd {
> +               sd0_uhs_cd {
>                         pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
>                         power-source = <1800>;
>                 };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
