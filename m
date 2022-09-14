Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CBB5B8DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 19:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiINRKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiINRKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 13:10:06 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4321E1D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:10:03 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-12b542cb1d3so32992660fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L6YhEh0UYxe2tPeB9Bs5zIhc3gbVkQ/Hoe4Ilc/R8DI=;
        b=zapowfMLZG6nfuKhIaOEKqurE8nHf+m0lG9E4Hi9bjj0S0ZyKLFdodnrgeUZtOI0rb
         vTmX8K6g2kmX7rUtUMjnImvjBJMi22CluiHOAjhxG7L4H8xlKr+xbg1kZRoGZvSGJw8K
         HPRNo7jozmxDWJP68L5vaf5tLCfvQGqxodV4UV0D/3BVEn3M+YxepKAm7UlhCgfRpZNo
         UvTqcd1UP5IMAQo6z2XRKT1Yh9/gUuUq2ZgJCRRDOecB4oX+7Ai3EtR1zJ2xeqimnTK4
         yB5oIda938tiCaV6kurWJy0tuIHeeiwb41hkYaiYwkux2cCCQ9DBESndrpUaruy9AxQq
         MY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L6YhEh0UYxe2tPeB9Bs5zIhc3gbVkQ/Hoe4Ilc/R8DI=;
        b=T1TW6nn9CcbD97y9pMFNafdTUnWBYxDrCjhc81xHEUEmUWPctAUiKhyks1i6I7W/t9
         wj3OhonK/fZafatkNug73wCW9+wzo0szsf+jPxi8jyVjMf5HjpEWpCC2OMoG0/0NzcYP
         +ngtMnwms8yqNyNwPu51yC9N/uRi8HSgG8K4T/9wWtmWH3EQFCYe8cw+Jw/dsTzPqVMw
         aRpY14auzgVLFaw3BGm+wEiHHlzj66F0ZEFWMmCO8jhp3mWsI1l31VFV2PHeXdR2OU2k
         qhtBBajFFUwIOVB+cJJDgZY5KapgBwnznY48BV5NjH/KSQp9fk7CplxKqWUxY4+A24te
         9hTg==
X-Gm-Message-State: ACgBeo2YlnHWq3ED3ftAaCJ99vYiKMLXNjGebQOhwXzt4GOs9BeS72Dg
        PZ8TbpbT1Oxpj+BDJrz20qTOrQeH0VC+MAIjjwvHcg==
X-Google-Smtp-Source: AA6agR7ixBrehjh+uaYWhVhkcOhLhwy9Hd2Lp8tza6xcOsSAGXpYrRtPGVvl/Tu+9j1KD/zQEfu+HWFjxJM3KHklmeI=
X-Received: by 2002:a05:6808:1444:b0:344:f010:27d8 with SMTP id
 x4-20020a056808144400b00344f01027d8mr2273353oiv.33.1663175403154; Wed, 14 Sep
 2022 10:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220908154903.4100386-1-tharvey@gateworks.com>
 <2530681.Lt9SDvczpP@steina-w> <CAJ+vNU2sKkjv1q=oPD++1DE7uUiXJYi75-fpRRNboabUbUwCqA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2sKkjv1q=oPD++1DE7uUiXJYi75-fpRRNboabUbUwCqA@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 14 Sep 2022 10:09:51 -0700
Message-ID: <CAJ+vNU2fmsy2eT1tBOWx9D=cS1emgkCKxaOX+GCZF=v_JDc_1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw74xx: add PCIe support
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 10:42 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Thu, Sep 8, 2022 at 10:59 PM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> >
> > Hi Tim,
> >
> > Am Donnerstag, 8. September 2022, 17:49:03 CEST schrieb Tim Harvey:
> > > Add PCIe support on the Gateworks GW74xx board. While at it,
> > > fix the related gpio line names from the previous incorrect values.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  .../dts/freescale/imx8mp-venice-gw74xx.dts    | 40 +++++++++++++++++--
> > >  1 file changed, 37 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts index
> > > e0fe356b662d..7644db61d631 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
> > > @@ -8,6 +8,7 @@
> > >  #include <dt-bindings/gpio/gpio.h>
> > >  #include <dt-bindings/input/linux-event-codes.h>
> > >  #include <dt-bindings/leds/common.h>
> > > +#include <dt-bindings/phy/phy-imx8-pcie.h>
> > >
> > >  #include "imx8mp.dtsi"
> > >
> > > @@ -100,6 +101,12 @@ led-1 {
> > >               };
> > >       };
> > >
> > > +     pcie0_refclk: pcie0-refclk {
> > > +             compatible = "fixed-clock";
> > > +             #clock-cells = <0>;
> > > +             clock-frequency = <100000000>;
> > > +     };
> > > +
> > >       pps {
> > >               compatible = "pps-gpio";
> > >               pinctrl-names = "default";
> > > @@ -215,8 +222,8 @@ &gpio1 {
> > >  &gpio2 {
> > >       gpio-line-names =
> > >               "", "", "", "", "", "", "", "",
> > > -             "", "", "", "", "", "", "", "",
> > > -             "pcie3_wdis#", "", "", "pcie1_wdis@", "pcie2_wdis#", "",
> > "", "",
> > > +             "", "", "", "", "", "", "pcie3_wdis#", "",
> > > +             "", "", "pcie2_wdis#", "", "", "", "", "",
> > >               "", "", "", "", "", "", "", "";
> > >  };
> > >
> > > @@ -562,6 +569,28 @@ &i2c4 {
> > >       status = "okay";
> > >  };
> > >
> > > +&pcie_phy {
> > > +     fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
> > > +     fsl,clkreq-unsupported;
> > > +     clocks = <&pcie0_refclk>;
> > > +     clock-names = "ref";
> > > +     status = "okay";
> > > +};
> > > +
> > > +&pcie {
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&pinctrl_pcie0>;
> > > +     reset-gpio = <&gpio2 17 GPIO_ACTIVE_LOW>;
> > > +     clocks = <&clk IMX8MP_CLK_HSIO_ROOT>,
> > > +              <&clk IMX8MP_CLK_PCIE_ROOT>,
> > > +              <&clk IMX8MP_CLK_HSIO_AXI>;
> > > +     clock-names = "pcie", "pcie_aux", "pcie_bus";
> >
> > With the still pending dt-binding patch at [1] the clock order shall be
> > "pcie", "pcie_bus", "pcie_phy".
> >
> > Best regards,
> > Alexander
> >
> > [1] https://lore.kernel.org/lkml/20220822184701.25246-2-Sergey.Semin@baikalelectronics.ru/
> >
>
> Alexander,
>
> Interesting... the imx8pm-evk PCIe patch was accepted with the
> bindings I used which are current. So I suppose if/when the patch you
> pointed to gets accepted some existing bindings will need to change to
> be compliant.
>
> Best Regards,
>
> Tim

Shawn,

I'm unclear if this patch needs to change. I believe the patch adheres
to the current bindings and if the bindings change it would require
all the imx8m boards to have their bindings updated to agree with it.
I'm also unclear if the order of the clocks really makes any
difference here.

Best Regards,

Tim
