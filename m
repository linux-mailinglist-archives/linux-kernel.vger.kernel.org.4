Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E55B3E18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIIRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiIIRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:42:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5F898C86
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:42:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u22so2430563plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=i0TWXvsMdzImF9hLkcZNKk+2MjIILmGHGg2qkEi7CcA=;
        b=ZBI1LtnkLZ2w2b7p6oHqxdChxFGPWJXfmp5TlVlDmHeHCijJXtQfjz7IHI2IriPIMF
         f95h64zEmTxv1+DXoTxsj6cRwdC1+GnvPm0JrTms/AGZLOcHNFuEBk6AhT6kPYqfHFmE
         6bDNh1tlHqdpcSzTgOefQ9CgJD2IqhiECkFP9CSIYs1N1sGMsa2Ei8kNs6yZox26GAtZ
         iONIXHmphNPHtiCxrPavb7H6I0KJdDUDNNge9BQiMEJ4nTIuBKozvhWHK9CoL1uDc8Cf
         JL94MJojJBhXLy0AOoH6zfaglKh9jHeaGHRZV1XD/Bfy2L5PWc8m8Yjb06WaoaYOVFeJ
         M7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=i0TWXvsMdzImF9hLkcZNKk+2MjIILmGHGg2qkEi7CcA=;
        b=zEfZPAzeQvGynOrQrvcdp/OCw4eLNoXvnDNA+gXeOCk1TVSl6oQbFmXsRuu911NEry
         Xtn/VfJ4Qe06QmytrAZ0FTIjyWhdDJbREqyemYPnQlkXVuZLpOk/sqZQDddIqoVQqkk5
         2MOgai1EKtUz6lzaFTiFzwcJeqrfDc1S5KhZphEO0eNx7Hr73fYfH338yrJK2p0qEnoP
         d+w+gL8+mmEUytHZHqKFTK/dFKkjoeum0dKWsMhZi/y2U3vvytd31z0qMKX7OrOsJmll
         ziwgAQy266UVZmqttdQwosEs/K2/1Vxq2W1Q6csOT8GizjJRN+s/2ghQ+o08/D2lC5R+
         A0Fg==
X-Gm-Message-State: ACgBeo2hgZW+uD8pS10JsYtzZJoN/9Uo9ASn7r6pY7XEPonuiLh9TaF1
        AQZ3eWwT96EibhmsTmEHhZzNML4udIT1U0dkK0LLhg==
X-Google-Smtp-Source: AA6agR7PVoOHHD6bpgJ/hR/7PXLQu2R8LF81Vy2s6/XMli+cSHaT4YUyimg9nypVDN3AAMWlgQYuQwo3RVsQWwQxlFs=
X-Received: by 2002:a17:902:be02:b0:172:d409:e057 with SMTP id
 r2-20020a170902be0200b00172d409e057mr14704787pls.90.1662745334819; Fri, 09
 Sep 2022 10:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220908154903.4100386-1-tharvey@gateworks.com> <2530681.Lt9SDvczpP@steina-w>
In-Reply-To: <2530681.Lt9SDvczpP@steina-w>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 9 Sep 2022 10:42:03 -0700
Message-ID: <CAJ+vNU2sKkjv1q=oPD++1DE7uUiXJYi75-fpRRNboabUbUwCqA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add PCIe support
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 10:59 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Tim,
>
> Am Donnerstag, 8. September 2022, 17:49:03 CEST schrieb Tim Harvey:
> > Add PCIe support on the Gateworks GW74xx board. While at it,
> > fix the related gpio line names from the previous incorrect values.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  .../dts/freescale/imx8mp-venice-gw74xx.dts    | 40 +++++++++++++++++--
> >  1 file changed, 37 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts index
> > e0fe356b662d..7644db61d631 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > @@ -8,6 +8,7 @@
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/linux-event-codes.h>
> >  #include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> >
> >  #include "imx8mp.dtsi"
> >
> > @@ -100,6 +101,12 @@ led-1 {
> >               };
> >       };
> >
> > +     pcie0_refclk: pcie0-refclk {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <100000000>;
> > +     };
> > +
> >       pps {
> >               compatible = "pps-gpio";
> >               pinctrl-names = "default";
> > @@ -215,8 +222,8 @@ &gpio1 {
> >  &gpio2 {
> >       gpio-line-names =
> >               "", "", "", "", "", "", "", "",
> > -             "", "", "", "", "", "", "", "",
> > -             "pcie3_wdis#", "", "", "pcie1_wdis@", "pcie2_wdis#", "",
> "", "",
> > +             "", "", "", "", "", "", "pcie3_wdis#", "",
> > +             "", "", "pcie2_wdis#", "", "", "", "", "",
> >               "", "", "", "", "", "", "", "";
> >  };
> >
> > @@ -562,6 +569,28 @@ &i2c4 {
> >       status = "okay";
> >  };
> >
> > +&pcie_phy {
> > +     fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > +     fsl,clkreq-unsupported;
> > +     clocks = <&pcie0_refclk>;
> > +     clock-names = "ref";
> > +     status = "okay";
> > +};
> > +
> > +&pcie {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_pcie0>;
> > +     reset-gpio = <&gpio2 17 GPIO_ACTIVE_LOW>;
> > +     clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> > +              <&clk IMX8MP_CLK_PCIE_ROOT>,
> > +              <&clk IMX8MP_CLK_HSIO_AXI>;
> > +     clock-names = "pcie", "pcie_aux", "pcie_bus";
>
> With the still pending dt-binding patch at [1] the clock order shall be
> "pcie", "pcie_bus", "pcie_phy".
>
> Best regards,
> Alexander
>
> [1] https://lore.kernel.org/lkml/20220822184701.25246-2-Sergey.Semin@baikalelectronics.ru/
>

Alexander,

Interesting... the imx8pm-evk PCIe patch was accepted with the
bindings I used which are current. So I suppose if/when the patch you
pointed to gets accepted some existing bindings will need to change to
be compliant.

Best Regards,

Tim
