Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322BA62C74F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiKPSMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiKPSMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:12:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592535F866;
        Wed, 16 Nov 2022 10:12:07 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m22so46059285eji.10;
        Wed, 16 Nov 2022 10:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AD20eKHS2F7b47L1iqXnzg2RFxJr+L65BkbTitr0Fkw=;
        b=KsQmzCIEK8MWYSZTbZxubjO5yaIJHrJBkyWJjXX+NzrcA/Cxe6PbrIFt700NTGZPnd
         ZcX/fvjGZNEkYHOPgCGgmnKhw087XVIwjXczacKiEC9vpWlwWoSJcrEwZMLUDbY0gl+e
         N7jBKQhds/7lnbpqN546ppBSdhoIWLM3YqLRiwRvAHb/wbUEYUsBHhqhsNFs9ABBCYSx
         ECfajeHvXWRkccS3Y8WdZ47uottVZTqZIX+PmkObmGWY4nQv2mo5sR480CWpTwMks47q
         dEhkHIoHGbTF9/cwmheQLmDZsP2oyeh8E5Wc0N9yrEXJyRbehxvlEng9mmSrk09OcJXN
         3pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AD20eKHS2F7b47L1iqXnzg2RFxJr+L65BkbTitr0Fkw=;
        b=mywPLUCwSyWXLKL1C6AQ+MB6DBaNAXj0j0LGXqTVZIyboMD39S1afj1pW8BCZBRDJH
         K/BIck3DGlhKOL/hrizezAtskmHYR/sjc0cfvHNvOTZVZIqCgtJ6EYrgFEhLQvfuJQzi
         TFjL/jGJgfHN66cTS6LWB4tSFBISFqtNgeoMEo8Lo8fnrVM/O5354KP3D5/YOGqxgdQU
         p93hjbGbbvNBBM8+Q+5MGLyU0JYJpa0VJf0lN4yPiyY4xbUDAXdAC37EeRbYZDncGjDd
         N1hczKTj674XBZWEFTmxP/2ymafkfdNNZeZPWlRcK8mbZ7YY7McX002rac24X4Yb+7ha
         G1hw==
X-Gm-Message-State: ANoB5pm2MSpzcBsjXj+8hqaD97Z6JnZyeXawV5D8dhkByHuV9RI1Mqu9
        iJwG4AM/oS4oc1cP/EOsofXwa2BHdo+xYsnsh8U=
X-Google-Smtp-Source: AA0mqf7xRmPEMMaPmpKbzCGRPL4nDRnA2ZfpeekiSduf4ALKGptYu95T17tjXAAokH5Mg3QTUZscKxkoR4f4wGYXqAE=
X-Received: by 2002:a17:906:b103:b0:7ad:c3b6:fe89 with SMTP id
 u3-20020a170906b10300b007adc3b6fe89mr17520031ejy.697.1668622325824; Wed, 16
 Nov 2022 10:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20221111094238.1640-1-linux.amoon@gmail.com> <20221111094238.1640-3-linux.amoon@gmail.com>
 <CAMdYzYpi_9B+riQSMk+cjRLd-b_TTi2rQUD7P5PUg_Fd5dGeMA@mail.gmail.com>
In-Reply-To: <CAMdYzYpi_9B+riQSMk+cjRLd-b_TTi2rQUD7P5PUg_Fd5dGeMA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 16 Nov 2022 23:41:49 +0530
Message-ID: <CANAwSgT-sr9uknyuwd2f_ODmr_9WAqLXyp5x7AN4w9p=TAVyhg@mail.gmail.com>
Subject: Re: [linux-next-v1 3/3] arm64: dts: rockchip: Fix ethernet reset node
 Rock 3A sbc
To:     Peter Geis <pgwipeout@gmail.com>
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

Hi Peter / Michael

On Fri, 11 Nov 2022 at 18:32, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Fri, Nov 11, 2022 at 4:44 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add support for snps,reset-gpio reset ethernet gpio pins and
> > drop the mdio reset code.
>
> Nack, the snps,reset-gpio is depreciated in favor of the mdio-reset
> code. See [0].
>

Ok coming to the ethernet reset controller with gpio-reset with MDIO.
I got this working by adding ethernet-phy-id to MDIO.

> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3568-rock-3a.dts      | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > index 16fff1ada195..9172cf60b867 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > @@ -258,6 +258,11 @@ &gmac1 {
> >         assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
> >         assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
> >         clock_in_out = "input";
> > +       snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> > +       snps,reset-active-low;
> > +       /* Reset time is 20ms, 100ms for rtl8211f */
> > +       snps,reset-delays-us = <0 20000 100000>;
> > +       phy-supply = <&vcc_3v3>;
>
> The phy supply shouldn't be part of this patch.
>

Ok will add this in a separate patch.

> >         phy-handle = <&rgmii_phy1>;
> >         phy-mode = "rgmii";
> >         pinctrl-names = "default";
> > @@ -267,6 +272,9 @@ &gmac1m1_rx_bus2
> >                      &gmac1m1_rgmii_clk
> >                      &gmac1m1_clkinout
> >                      &gmac1m1_rgmii_bus>;
> > +
> > +       tx_delay = <0x4f>;
> > +       rx_delay = <0x26>;
>
> Delays should move to your rgmii patch. Have you tested these to
> ensure they are in the middle of the functional range for this board?

Ok but this delay is different from the actual requirements see below.
rx-internal-delay-ps and tx-internal-delay-ps
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/ethernet-controller.yaml?h=v6.1-rc5#n222

tx_delay and rx_dealy are used by rockchip binding.

>
> >         status = "okay";
> >  };
> >
> > @@ -583,11 +591,6 @@ &mdio1 {
> >         rgmii_phy1: ethernet-phy@0 {
> >                 compatible = "ethernet-phy-ieee802.3-c22";
> >                 reg = <0x0>;
> > -               pinctrl-names = "default";
> > -               pinctrl-0 = <&eth_phy_rst>;
> > -               reset-assert-us = <20000>;
> > -               reset-deassert-us = <100000>;
> > -               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> >         };
> >  };
> >
> > @@ -625,12 +628,6 @@ vcc_mipi_en: vcc_mipi_en {
> >                 };
> >         };
> >
> > -       ethernet {
> > -               eth_phy_rst: eth_phy_rst {
> > -                       rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
> > -               };
> > -       };
> > -
> >         hym8563 {
> >                 hym8563_int: hym8563-int {
> >                         rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_up>;
> > --
> > 2.38.1
> >
> [0] https://elixir.bootlin.com/linux/v6.1-rc4/source/Documentation/devicetree/bindings/net/snps,dwmac.yaml#L222
> >
Thanks





-Anand
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
