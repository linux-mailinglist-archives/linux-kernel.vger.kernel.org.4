Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DC6335CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKVHTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiKVHS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:18:59 -0500
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5CA3123B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=Irzd9p8+2HaCNO0Vn7tqqCeUCmTdBbt/zWJHz9qjP1c=;
        b=lJrIorXCx0ilwJuwWQE/gouCXs9jdvjGu2hOJkQ4Ozi495WYG+B4K2lUOcPD9V78Zmd7aL2nqx+m5
         137Wx+2DAej8WLMp6457IMwMuDJP2u1Ap8bqEZhUXqcOSAFXkialwQAsIPl46fyAGeWrr2HOZICnYZ
         7YtkjKhHbW8B3kr4bFX7MtA30XHMPuI/eWCYK0ebioDU1Fx+dpe9pjK97O8EgY6pFXAybWQGLass3C
         ivcNX99Zo+ifr1rHGo2Xb3ykEb9W5FjAtoCEKZjw8/IixQRLODygQ4r26xKxORp+j11TG3mRAo5gJj
         FS+4hRfSJpSeIvCpBkvR+mtWSyfXVjQ==
X-MSG-ID: ea7fdbdd-6a35-11ed-b61c-0050569d3a82
Date:   Tue, 22 Nov 2022 08:18:51 +0100
From:   David Jander <david@protonic.nl>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v2 5/7] arm64: dts: imx: fix touchscreen reset GPIO
 polarity
Message-ID: <20221122081851.6cb762d8@erd992>
In-Reply-To: <CAOMZO5BzWsHAy7KjZe+KEiXVq-Mfpggqjk0vswuzx7nkups3gA@mail.gmail.com>
References: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
        <20221103-upstream-goodix-reset-v2-5-2c38fb03a300@theobroma-systems.com>
        <CAOMZO5BzWsHAy7KjZe+KEiXVq-Mfpggqjk0vswuzx7nkups3gA@mail.gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 15:18:32 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> [Adding Angus and David]

Thanks. This was apparently necessary ;-)

> On Mon, Nov 21, 2022 at 3:12 PM Quentin Schulz <foss+kernel@0leil.net> wrote:
> >
> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> >
> > The reset line is active low for the Goodix touchscreen controller so
> > let's fix the polarity in the Device Tree node.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts         | 2 +-
> >  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> > index 9fbbbb556c0b3..df7e5ae9698e1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
> > @@ -107,7 +107,7 @@ touchscreeen@5d {
> >                 interrupt-parent = <&gpio1>;
> >                 interrupts = <8 IRQ_TYPE_NONE>;
> >                 irq-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
> > -               reset-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> > +               reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;

NACK!

The PRT8MM has an inverter in the reset line. The reason for that is that the
reset line needs to be inactive when the driving side is unpowered.
The DT was correct, this change will break it.

> >         };
> >
> >         temp-sense@70 {
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > index 6445c6b90b5bb..b038300812b1e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > @@ -542,7 +542,7 @@ touchscreen@5d {
> >                 pinctrl-0 = <&pinctrl_ts>;
> >                 interrupt-parent = <&gpio3>;
> >                 interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > -               reset-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> > +               reset-gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> >                 irq-gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
> >                 touchscreen-size-x = <720>;
> >                 touchscreen-size-y = <1440>;
> >
> > --
> > b4 0.10.1  

Best regards,

-- 
David Jander
Protonic Holland.
