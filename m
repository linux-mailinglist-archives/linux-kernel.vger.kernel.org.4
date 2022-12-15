Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375AC64DBEA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 14:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLONH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 08:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLONHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 08:07:23 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA22A947
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:07:21 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y135so3341342yby.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 05:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZEQhEp/AEuTAFQupk8n6ZQMLUUFNJMPI1X7g+sUNN8=;
        b=Bgi/fzBz6YgpewnB0UsUqG/JJ5Xdp6Qm9eQWTxS26F7S9/XWzQiZOlx1jLukFbwafd
         QIQrbCxBmQaQsknEfK7Jbl6hC6hC7vndDnRXkX/NYHQZr/irKw/1y/w+0ODPZ9ehC9G4
         MhVC1b/eZlH5FB1EpOdCGYWI/bEQ+y5tcKSj896piHLgw3EnRZNjuea4Pui8PkqCWsC6
         P7nIKllpX7quI2b52ZOHYZiRqzuEZg4hkUDQ4WfjO2EuGF/ohA7pKV5ItgCKY0+w/rtf
         JP+xvBR56/wmaw3C5oejdFTdBqIIvRwo0sEcOfVKIQPrlIDii6hAhJoyr75JN8xLTrJz
         bYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZEQhEp/AEuTAFQupk8n6ZQMLUUFNJMPI1X7g+sUNN8=;
        b=0SbnLBhk19HzJr2s+QevzOYaSPL/GLMJeup+nIERDyA2c2zTZVMvuoSOpszMcuWQZI
         ObAgs/iWrBj0ngCtzODQh/PLrsp6AmDtY19Zpqqv4MTxZjkhJDewRM3XbA1BwBV/KtqL
         1GifDXzFG64PGPGmN6vqIlWdi/g46AmPq0g6AbznSezFBEG5lY/RYxtX9eyHcRfKd+i+
         zVc0h4dTSLs3FTMPZTe0YObKpEvPmYb3M3I8KGEJuNunghq92KpvJcz4LyEUPwhiYjHQ
         ZenAp6mFGvnqi3JRVhH63VztxwuDcIN8RTUmjHe0fliqpW1uof6cNE/Eqcyl/ekmx6kS
         DicA==
X-Gm-Message-State: ANoB5plML84yzfkPVTKpU5AO3pl9ehmNVO0TM7KAuoB6sWJSXtgTqHiR
        +5EWXCecXjGavLjarGv3qjDYEoQHpnMahq1M66HSvg==
X-Google-Smtp-Source: AA0mqf5RTMR/uAoOZK8ttO+7WO6orxQFr8A06Sf2JOydK+GaNZM+quva/yUjmIIulxU998U4yRh6DaFe7SdmomMzfcg=
X-Received: by 2002:a25:abee:0:b0:70c:4fa3:2cce with SMTP id
 v101-20020a25abee000000b0070c4fa32ccemr7845895ybi.539.1671109640972; Thu, 15
 Dec 2022 05:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20221214182247.79824-1-sebastian.reichel@collabora.com> <20221214182247.79824-6-sebastian.reichel@collabora.com>
In-Reply-To: <20221214182247.79824-6-sebastian.reichel@collabora.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Thu, 15 Dec 2022 18:37:10 +0530
Message-ID: <CA+VMnFwT+Gi1nFBG2NDyMYx8wv+FrwzR8tb_8RrFh6QMGK8Q6g@mail.gmail.com>
Subject: Re: [PATCHv6 5/7] arm64: dts: rockchip: Add rk3588-evb1 board
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
        Michael Riesch <michael.riesch@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
> Add board file for the RK3588 evaluation board. While the hardware
> offers plenty of peripherals and connectivity this basic implementation
> just handles things required to successfully boot Linux from eMMC,
> connect via UART or Ethernet.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> [rebase, update commit message, use EVB1 for SoC bringup]
> Reviewed-by: Michael Riesch <michael.riesch@wolfvision.net>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588-evb1-v10.dts     | 165 ++++++++++++++++++
>  2 files changed, 166 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 8c15593c0ca4..12ed53de11eb 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -72,3 +72,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> new file mode 100644
> index 000000000000..46ea2daf5d6e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3588.dtsi"
> +
> +/ {
> +       model = "Rockchip RK3588 EVB1 V10 Board";
> +       compatible = "rockchip,rk3588-evb1-v10", "rockchip,rk3588";
> +
> +       aliases {
> +               mmc0 = &sdhci;
> +               serial2 = &uart2;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial2:1500000n8";
> +       };
> +
> +       backlight: backlight {
> +               compatible = "pwm-backlight";
> +               brightness-levels = <
> +                         0  20  20  21  21  22  22  23
> +                        23  24  24  25  25  26  26  27
> +                        27  28  28  29  29  30  30  31
> +                        31  32  32  33  33  34  34  35
> +                        35  36  36  37  37  38  38  39
> +                        40  41  42  43  44  45  46  47
> +                        48  49  50  51  52  53  54  55
> +                        56  57  58  59  60  61  62  63
> +                        64  65  66  67  68  69  70  71
> +                        72  73  74  75  76  77  78  79
> +                        80  81  82  83  84  85  86  87
> +                        88  89  90  91  92  93  94  95
> +                        96  97  98  99 100 101 102 103
> +                       104 105 106 107 108 109 110 111
> +                       112 113 114 115 116 117 118 119
> +                       120 121 122 123 124 125 126 127
> +                       128 129 130 131 132 133 134 135
> +                       136 137 138 139 140 141 142 143
> +                       144 145 146 147 148 149 150 151
> +                       152 153 154 155 156 157 158 159
> +                       160 161 162 163 164 165 166 167
> +                       168 169 170 171 172 173 174 175
> +                       176 177 178 179 180 181 182 183
> +                       184 185 186 187 188 189 190 191
> +                       192 193 194 195 196 197 198 199
> +                       200 201 202 203 204 205 206 207
> +                       208 209 210 211 212 213 214 215
> +                       216 217 218 219 220 221 222 223
> +                       224 225 226 227 228 229 230 231
> +                       232 233 234 235 236 237 238 239
> +                       240 241 242 243 244 245 246 247
> +                       248 249 250 251 252 253 254 255
> +               >;
> +               default-brightness-level = <200>;
> +
> +               pwms = <&pwm2 0 25000 0>;
> +               power-supply = <&vcc12v_dcin>;
> +       };

Do we really need this now? and brightness-levels need not be required
to mention all.

Jagan.
