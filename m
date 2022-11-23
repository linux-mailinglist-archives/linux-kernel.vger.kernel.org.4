Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E6635F40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbiKWNWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiKWNV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:21:56 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1029803;
        Wed, 23 Nov 2022 05:00:58 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so11168854otb.1;
        Wed, 23 Nov 2022 05:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uszX2YXhRo8OdMXZRubKyG6XQTLJS1i6JFk/Tk+AzJE=;
        b=m9MCSmpbqdRH7+4KQyPsB99jGimXLvL7T8+W9hpeQ4oh8sBgsasHUj4lQBUv23vkaO
         z593kbo6lONHYoUM0keJSXJKoNPld2g0MUMCWNtEmrduHeKQVT0qwQVZRidiGAmkySuJ
         YByc//Bz9M+VuH8+BuojV5mAMc/yM2bBIFPk/RogKUdhcJH6MUPcFM+DH7Vu8GwEPhbY
         Wsr8/XLzVIJvWs7w7x34FhncgBiSn15ih0ZUD3QOFPS7bs1LQAu7VgQMhUYFE11ffTdt
         SubCzz6GYCEnp21hpbM+YZIh/LdYMpqfPAT7UgdF6c/wtBNVGeLCdKF5O8wOT9i69j6X
         EdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uszX2YXhRo8OdMXZRubKyG6XQTLJS1i6JFk/Tk+AzJE=;
        b=o5Q0yceBw2Cm0K6O0Gin4kZsrSB5dQ/e2cLj0hR7SzDd/r1Orhpkzil0rukc1oAYqQ
         SkkATUYmk9Yrq1AOST5DpLfY2JwFdLXcZaXncU4lAIOCCVaVF00iI5aJHfbtPPnBUwTF
         EfqL6xu9/Q8Zof410vE1GFxHzKaYUklm8f/VSvz1Sk+n+8m00piK1AF7UN0Ck9BoBWI4
         ObGRYYMR0e9M323F3ERayjKpu8DYgCp5lx6ur6oszqah/MP8mZq8DudywGdziDpx3Y8G
         7pLN7KL9F/0ZUqbs8YHWudPk4v3w96dC6PszgTjJbeA0I2UbnrdHn4tHw0755dZTpBXY
         1j+A==
X-Gm-Message-State: ANoB5pmnqspdqckNRFFnh8TR320p6IqMbCajarY1CC4DmzHm8DrCDHs8
        CXo5t6Xb6KTozoabCcTBQUHiNj9nQXNnoInIBPzgkH04
X-Google-Smtp-Source: AA0mqf7avOQ6ZK8U0u3gEKBiDn/0RxoSiJmw1vU8Ce22fs45vbIEnoivj5POkfo2QWMtctbK4jmNIv+38GUoGZfVeNk=
X-Received: by 2002:a9d:4f07:0:b0:662:c31:161c with SMTP id
 d7-20020a9d4f07000000b006620c31161cmr7801332otl.301.1669208457897; Wed, 23
 Nov 2022 05:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-5-linux.amoon@gmail.com>
 <19f1a4fb-42b2-580d-3736-e0e1d0cfe7fb@wolfvision.net>
In-Reply-To: <19f1a4fb-42b2-580d-3736-e0e1d0cfe7fb@wolfvision.net>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 23 Nov 2022 18:30:36 +0530
Message-ID: <CANAwSgT-M0sizZz1b-549HoG7Yj4ubfiG19ecvUi=AWD1mZQ3Q@mail.gmail.com>
Subject: Re: [linux-next-v2 4/5] arm64: dts: rockchip: Add support of
 interrupt to ethernet node on Rock 3A SBC
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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

Hi Michael,

Thanks for your review comments.

On Tue, 22 Nov 2022 at 21:40, Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Anand,
>
> On 11/16/22 21:01, Anand Moon wrote:
> > As per the shematic gmac1 support gpio interrupt controller
>
> Typo "shematic" -> "schematic"
Ok,
>
> > GMAC1_INT/PMEB_GPIO3_A7 add the support for this.
>
> Maybe split the commit message into two proper sentences.

Ok this Interrupt is used for Power Management Event (supports 3.3V pull up).
Set low if received a magic packet or wake up frame; active low.
so this interrupt is used for suspend / resume.

> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: new patch added
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > index 5378254c57ca..9f84a23a8789 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
> > @@ -588,10 +588,14 @@ rgmii_phy1: ethernet-phy@0 {
> >               compatible = "ethernet-phy-ieee802.3-c22";
> >               reg = <0x0>;
> >               pinctrl-names = "default";
> > -             pinctrl-0 = <&eth_phy_rst>;
> > +             pinctrl-0 = <&eth_phy_rst>, <&eth_phy_int>;
> >               reset-assert-us = <20000>;
> >               reset-deassert-us = <100000>;
> >               reset-gpios = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> > +             interrupt-parent = <&gpio3>;
> > +             /* GMAC1_INT/PMEB_GPIO3_A7 */
>
> This comment is pretty superfluous.

Ok will drop this.

>
> > +             interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
> > +             #interrupt-cells = <1>;
>
> I am not an expert here, but I believe #interrupt-cells = <1>; means
> that the phy provides an array of interrupts. Are you sure this is
> correct? I find it strange that the phy driver consumes one interrupt
> and provides N interrupts?!
>
Ok will drop this.

> >       };
> >  };
> >
> > @@ -630,6 +634,10 @@ vcc_mipi_en: vcc_mipi_en {
> >       };
> >
> >       ethernet {
> > +             eth_phy_int: eth-phy-int {
> > +                     rockchip,pins = <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
>
> Interrupt is active low and you pull down the line here? There is a pull
> up resistor on sheet 11 of the schematic, so this does not seem right at
> all.
>
Actually this GPIO3_A7_d hence pull_down, this pin level triggered
So I will set this as &pcfg_pull_none.

I don't have PoE set up to verify these changes as of now.

> Best regards,
> Michael

Thanks

-Anand
