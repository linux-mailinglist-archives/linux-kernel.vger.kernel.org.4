Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD162DE89
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiKQOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiKQOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:44:49 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912851338;
        Thu, 17 Nov 2022 06:44:33 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ft34so5490671ejc.12;
        Thu, 17 Nov 2022 06:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=riDO6qHjkXJO4FMqmQwEaErq/K8CVkbFub7re4pItDY=;
        b=DBPmY9VxDmx8RgOYEwV0YLA7Jp25y31ofjo3bMYX9sqNFWGs6XWlG3dy3pC3DEE4KY
         OY+t9dvDa5aNDhoH1/A6FXkzdPxkHQrGMSAudIM9vzg2UD2GfZzOE0UOS56dXKeKClmI
         oHO8dP7I2chYnOSlTCbak2/sQERaqDYp4JD5gGW/h0oOJ4k0t+OHd4X9U3yNAT9iISaA
         2w6Cus5wH/+ZdOgyVzgT/82NwdHKeP8d4pOa1W9Njy0kS32W1v2dWFRdT8GVsAuqrv+V
         M1p7BpU6myxNxE3aDuDsvB/BZNYUaqRyXlpTezLtCjfPedgLY2DtNZ0yst4hKGBNA0zU
         TEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riDO6qHjkXJO4FMqmQwEaErq/K8CVkbFub7re4pItDY=;
        b=P8o2g+2oOLwecUmHt115xfwpBoMvaWrE0xl9QsufDNoWFnm/rqe4OpseZxrd1HECTD
         v7hc0APJSa8U/Q8kH3fBFDanmG//Fiau+x1CX59sUgpxniMmWS6ltunoqETZWW6fEgJm
         c2SStULiupI4c1ysaGJ9TntGW21FVV2lF+PQ9OGe5Zll4mAtnS9Q81sLihep8MbYFxU9
         Sg+m0IyjNbJjnkMFdz3eo00NOkbvlbL7Ohl64HyS2toByzL0UtUA8QHUxmGPeXDRt5zf
         Sgq4EnbzZnBNBfBuuZl+wVsrVXVJhsgJDEBzSxYrrA2r1Epd5LJYsFIVIcCZzudxyhcL
         P2TQ==
X-Gm-Message-State: ANoB5plk2SdERxIBt5tMfAeTn+U3nEAykWJOwbA4n4JLnHUiRX8Lk80Z
        d4tOdkWt4y7MUsExrD9wJGBe+7mPAgLBWos/Iw8BqIggWLkgdQ==
X-Google-Smtp-Source: AA0mqf6fQirskAJB9bpfHRTGUo+Bl9P6znKCc2Geu4nkxD3mey5czfblEP7G/5waChZSVOk+GS2kakesxO697wGlAds=
X-Received: by 2002:a17:906:c18c:b0:7b2:8a6e:c569 with SMTP id
 g12-20020a170906c18c00b007b28a6ec569mr2428029ejz.582.1668696272081; Thu, 17
 Nov 2022 06:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-2-linux.amoon@gmail.com>
 <CAMdYzYrgtzeP2OL2Vw0pDHQuJDhRbUy3X4xq9+XchgTGB9dqpg@mail.gmail.com>
In-Reply-To: <CAMdYzYrgtzeP2OL2Vw0pDHQuJDhRbUy3X4xq9+XchgTGB9dqpg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 17 Nov 2022 20:14:16 +0530
Message-ID: <CANAwSgQZ17j_B2T3+Ompkdb2Fjo9dpddKehZXxUo4GTeC6fvZA@mail.gmail.com>
Subject: Re: [linux-next-v2 1/5] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A SBC.
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

Hi Peter

On Thu, 17 Nov 2022 at 02:06, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Wed, Nov 16, 2022 at 3:02 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > On rk356x ethernet phy support reduced media independent interface (RMII)
> > and reduced gigabit media independent interface (RGMII).
> > So set the phy mode to rgmii to support clock delay, also
> > add TX and RX delay for phy-mode.
>
> Controller based clock delay, the various rgmii-id modes (rgmii-txid
> and rgmii-rxid are also valid) apply the delays in the phy. They are
> usually at a fixed amount, but some phys support variable delays.
>
> You want your commit message to accurately describe the problem, such
> as "In rgmii-id mode, the phy on the rock-3a is unreliable due to
> incorrect delays. Switch to rgmii mode in order to handle the delays
> in the controller."
>
> >
> > Fix following warning
> >
> > [    7.365215] rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
> > [    7.365219] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
> > [    7.365224] rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
> > [    7.365228] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10
>
> I've been meaning to make this a dev_debug message, because in the
> various rgmii-id modes it is feasible for these to be non-existent in
> the device-tree. In rgmii-id mode these are disabled, no matter what
> they are set to in the dt.

As per the public datasheet share by Radxa below
[0] https://dl.radxa.com/rock3/docs/hw/datasheet/RTL8211F-CG-Datasheet.pdf

This Ethernet controller supports RGMII mode.

>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V2: Fix commit message and added the RX and TX clock delay.
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > index ea74ba32fbbd..e1c75532dcee 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > @@ -253,13 +253,16 @@ &gmac1 {
> >         assigned-clock-rates = <0>, <125000000>;
> >         clock_in_out = "output";
> >         phy-handle = <&rgmii_phy1>;
> > -       phy-mode = "rgmii-id";
> > +       phy-mode = "rgmii";
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&gmac1m1_miim
> >                      &gmac1m1_tx_bus2
> >                      &gmac1m1_rx_bus2
> >                      &gmac1m1_rgmii_clk
> >                      &gmac1m1_rgmii_bus>;
> > +
> > +       tx_delay = <0x4f>;
> > +       rx_delay = <0x26>;
>
> These are pretty far off from the default, have you verified the upper
> and lower bounds for the rock-3a? These should be roughly in the
> middle of that range.
>
No I have not tested this way but as per the datasheet, it supports

TXDLY   Add 2ns delay to RXC for RXD latching (via 4.7k-ohm to DVDD_RG)
RXDLY   Add 2ns delay to RXC for RXD latching (via 4.7k-ohm to DVDD_RG)

I feel I should ignore the above warning and add it below.

rx-internal-delay-ps = <2000>;
tx-internal-delay-ps = <2000>;

Thanks
-Anand
> >         status = "okay";
> >  };
> >
> > --
> > 2.38.1
> >
