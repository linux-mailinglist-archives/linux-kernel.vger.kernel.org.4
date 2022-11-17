Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B316F62D30C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiKQF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiKQF5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:57:42 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28560369;
        Wed, 16 Nov 2022 21:57:41 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k2so2579971ejr.2;
        Wed, 16 Nov 2022 21:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+LEz/hhHmtonDvUYcXa4li5SbcFrrLjSa8WP527O9c=;
        b=dFwXEMB9YYQ8RIwJ2m1X7CQoM5RJAgmlkQEpuOlk8zwYKmYG0sqQgQ0p/ppFwB+myw
         l6ZT1S2LOivdX59YdXu8I11iqLKbant+h5Q2kmYLg6LxTjeT5MpRf8CrIA7BOU4eL09R
         TweuELmj+wOg2wRI50gKOvVoCfF0jWtCaJXUIW3sTQ7o36CBBiEuaTHZyYAJvkDPEDmZ
         vodw1CyUxgua0gaXVse24oi4s+/GpwhxP0lNYoGTuWBBBwIGN9NllwtsVbX4C+6eR4hE
         uVCgrRuf2hFZ8XMc3RLoQsF/A+NYldHISaKYm3E/6CW9lZc7Zvj+yT10JGi0r90Y1fvy
         oGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+LEz/hhHmtonDvUYcXa4li5SbcFrrLjSa8WP527O9c=;
        b=hIkHa3zEiCkC2HPYN7XumpqnWf5cto6YF625gvuyjwW1GMbVSAgjtuqAfjDV+qyTnA
         2/IUKOeSBj3l/wBInICL6rAkElCS/pwSl1ywz3osEsd0ftJ6WCjUKPmE4ZW9CL5P6FbE
         iZZiMC/bPXODGjXppscgaRtGFqrr2iPmrfcjVoiG0I4PJnwQKbu5I8MrF8m0ldhr8TCX
         D0w6tOkjtyk4KYiXyJurBc6KpxuGHGJdhD7hXXsCFYjsmpJxNr+447kENIbZp+4qCZ82
         a9wZbm61xn/h1OT5seUpIXmFsFAsAgEPERTS1S4Y2B46v8Kvf14a4cENeyor0eyKPiZ0
         E3eg==
X-Gm-Message-State: ANoB5pnme+PGtQzz7Gi9PWSwrzZN3/bZhdABtUH0uaw332dmn0mYKCVG
        EfmkclF1UkyPn74XXq69EjwSWrHTJCno6V6b2nUrcytapis=
X-Google-Smtp-Source: AA0mqf7Jp1N8yqZLiuCXwIWZ4YxY8cPZbqyyMKnYDB9cjGBcZuvarbx6PmspF0ONfUAc3MpnDxzem3xaoTkWoalBSRk=
X-Received: by 2002:a17:906:b08e:b0:7ad:b9a0:8a9b with SMTP id
 x14-20020a170906b08e00b007adb9a08a9bmr905174ejy.509.1668664659883; Wed, 16
 Nov 2022 21:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-7-linux.amoon@gmail.com>
 <CAMdYzYo_DGiO0UxJEb3xues7Um=X9AgPvz+Xp_YWb9pp9HaScg@mail.gmail.com>
In-Reply-To: <CAMdYzYo_DGiO0UxJEb3xues7Um=X9AgPvz+Xp_YWb9pp9HaScg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 17 Nov 2022 11:27:24 +0530
Message-ID: <CANAwSgQJGH-+aXyUF18kGks4YKfBYvQ4-B7S2m8eaAr=yNS7vQ@mail.gmail.com>
Subject: Re: [linux-next-v2 5/5] arm64: dts: rockchip: Add missing of
 ethernet-phy-id to reset the phy on Rock 3A SBC
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

Hi Peter,

On Thu, 17 Nov 2022 at 02:16, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Wed, Nov 16, 2022 at 3:02 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Add MDIO description with ethernet-phy-id compatible string
> > which enable calling reset of the phy. The PHY will then be probed,
> > independent of if it can be found on the bus or not,
> > and that probing will enable the GPIO.
> >
> > ethernet-phy-id is read from ethenet register dump reg2 and reg3.
> >
> > Fix following warning.
> > [   12.323417] rk_gmac-dwmac fe010000.ethernet eth0: Register MEM_TYPE_PAGE_POOL RxQ-0
> > [   12.324078] rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1
> > [   12.324099] rk_gmac-dwmac fe010000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -19)
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V2: new to the patch series.
> >
> > alarm@rock-3a:~$ sudo ethtool -d eth0
> > [sudo] password for alarm:
> > ST GMAC Registers
> > GMAC Registers
> > Reg0  0x08072203
> > Reg1  0x00000000
> > Reg2  0x00000404
> > Reg3  0x00000000
> > Reg4  0x00000002
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > index 9f84a23a8789..fe36156a5017 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > @@ -585,7 +585,7 @@ &i2s2_2ch {
> >
> >  &mdio1 {
> >         rgmii_phy1: ethernet-phy@0 {
> > -               compatible = "ethernet-phy-ieee802.3-c22";
> > +               compatible = "ethernet-phy-id0000.0404", "ethernet-phy-ieee802.3-c22";
> >                 reg = <0x0>;
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
>
> Have you tried instead moving the reset to the mdio bus? I've had
> success with this, though you'll need to change the reset assert and
> deassert timing handles, they are different for the bus.
>
No can you share some examples?
If you got a better way to solve this issue please let me know.
I will give this a try.

Thanks
-Anand
> > --
> > 2.38.1
> >
