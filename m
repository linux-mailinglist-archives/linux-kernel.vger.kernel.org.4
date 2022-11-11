Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E015625AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiKKNCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiKKNCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:02:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563EA7F556;
        Fri, 11 Nov 2022 05:02:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so6390994wrs.10;
        Fri, 11 Nov 2022 05:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3S2DscFDKOisfe/7QhwL8EOoAAX7HJSuLBDke3HfeGI=;
        b=fhD2KG3fyrR/elnNcqdC1pKXS0NJAuHip0HJD2eKYXzSE1Hjug6LodObkiKrZB+HJp
         23IQYKiGuv5CPsn8djSbiMFXcT1SVF40QmTYbZxCeMwGVA6vIRpiHZ5xNT/o1cW5Anc0
         hSTEFLtVTyYJeXb3A5yqkQa3DSxdOg1f4ZX0MztvcamVPiPe8X8y7V/P7v4+VoVqJ5k9
         4DMkS6E52wkHxew6H32PaH1TFuFzFl+MJ9keRABz/pK4y690Rs0XA651Ngl7C5RtD8CD
         QhLuNGjAzjxf6PY/0/mGxq14CNFAo1Bp16v/2sFWby80ZtL06IiFDmUXFWD9+5znzJqp
         T7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3S2DscFDKOisfe/7QhwL8EOoAAX7HJSuLBDke3HfeGI=;
        b=bJ+FpX9XXqMkaDJYPesPxysKkmsP0XwB2tlXpLwzaJJGMewpsu80IbbhlIts6qqgrE
         0m2Zh2L8Utjc4pZnHNjdWHMAJAX5zfV++Xqj8kesop7xSF3F3DVQXHadvEMLd4KhSfUT
         8DVm5VdC8BA0t/R6HXrAdh4VCWRe2+WZcPotNzXcFPwVXEN4w8rbdCSFA8JA+thrpJvf
         sPHVTZIH261shunIH4tIMiWrqL2i2lhVnUs5qEBQm3bMqgYBwkovNKfhPGVvfUwvpKAZ
         W7eAaFATizmctg8SyRqzEf5XhzIwsqM7H8c5ZTHFgl/sI9j6KaOIe0FzV7Zj7Ovhe1bj
         tm2g==
X-Gm-Message-State: ANoB5pk8bElvYTKBa30xoug7L/nvqSkyP3cjroHiO399Qe495jkjs2Bd
        LiAfvZh9GcETyRNNFcEzpdOO6cwyWdpwkieK1RE=
X-Google-Smtp-Source: AA0mqf6Ew0qTtY1BpiYUfphPuFQMrP1NABbOdgxC2939enujZC2E1CwJ0kG7bAOdgjb6ijpKQ1/G7I2V/SNaLy9zX/w=
X-Received: by 2002:adf:fec8:0:b0:228:d897:228 with SMTP id
 q8-20020adffec8000000b00228d8970228mr1176189wrs.539.1668171763729; Fri, 11
 Nov 2022 05:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20221111094238.1640-1-linux.amoon@gmail.com> <20221111094238.1640-3-linux.amoon@gmail.com>
In-Reply-To: <20221111094238.1640-3-linux.amoon@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 11 Nov 2022 08:02:31 -0500
Message-ID: <CAMdYzYpi_9B+riQSMk+cjRLd-b_TTi2rQUD7P5PUg_Fd5dGeMA@mail.gmail.com>
Subject: Re: [linux-next-v1 3/3] arm64: dts: rockchip: Fix ethernet reset node
 Rock 3A sbc
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 4:44 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add support for snps,reset-gpio reset ethernet gpio pins and
> drop the mdio reset code.

Nack, the snps,reset-gpio is depreciated in favor of the mdio-reset
code. See [0].

>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3568-rock-3a.dts      | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> index 16fff1ada195..9172cf60b867 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> @@ -258,6 +258,11 @@ &gmac1 {
>         assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
>         assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
>         clock_in_out = "input";
> +       snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +       snps,reset-active-low;
> +       /* Reset time is 20ms, 100ms for rtl8211f */
> +       snps,reset-delays-us = <0 20000 100000>;
> +       phy-supply = <&vcc_3v3>;

The phy supply shouldn't be part of this patch.

>         phy-handle = <&rgmii_phy1>;
>         phy-mode = "rgmii";
>         pinctrl-names = "default";
> @@ -267,6 +272,9 @@ &gmac1m1_rx_bus2
>                      &gmac1m1_rgmii_clk
>                      &gmac1m1_clkinout
>                      &gmac1m1_rgmii_bus>;
> +
> +       tx_delay = <0x4f>;
> +       rx_delay = <0x26>;

Delays should move to your rgmii patch. Have you tested these to
ensure they are in the middle of the functional range for this board?

>         status = "okay";
>  };
>
> @@ -583,11 +591,6 @@ &mdio1 {
>         rgmii_phy1: ethernet-phy@0 {
>                 compatible = "ethernet-phy-ieee802.3-c22";
>                 reg = <0x0>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&eth_phy_rst>;
> -               reset-assert-us = <20000>;
> -               reset-deassert-us = <100000>;
> -               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
>         };
>  };
>
> @@ -625,12 +628,6 @@ vcc_mipi_en: vcc_mipi_en {
>                 };
>         };
>
> -       ethernet {
> -               eth_phy_rst: eth_phy_rst {
> -                       rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> -               };
> -       };
> -
>         hym8563 {
>                 hym8563_int: hym8563-int {
>                         rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> --
> 2.38.1
>
[0] https://elixir.bootlin.com/linux/v6.1-rc4/source/Documentation/devicetree/bindings/net/snps,dwmac.yaml#L222
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
