Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59164FF5F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiLRP6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLRP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:58:17 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA75B1E8;
        Sun, 18 Dec 2022 07:58:16 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h6so3585615iof.9;
        Sun, 18 Dec 2022 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kuATr87CzTV1qlHuhve5U4eQzL5g/KrogSBqfE4e6bY=;
        b=ZXThl7icRZA1j0FnxM1OKJa74blMj1G+6zvxBPyT3KDtsmaORX56LDU97fmJxRNL3/
         w99GA+xiW+xwEHiQQ/H1d/Ss3hg+RASNxAQhmSCz76Xod+cwvFIEfbswuSJAsPOPYoX6
         NkT6q0OEYlMqcowm53AE2AN5i8yarISkVgCG5/K5j5TO/kEWBMf6V+H60eyAO1wEW6PZ
         CFRU1IwERb/zeEnjQbIUO9ZKj8Patjeo1YQ71Yxeb5LK49t9GpxJ7v8GeBHguPn5JsyM
         WMPOvTX8b9Sxx0tDdvdqRgYrGxQZgFDKXovdzHuBddldTi7hciGK0RD2QDooYn1kuWne
         kiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuATr87CzTV1qlHuhve5U4eQzL5g/KrogSBqfE4e6bY=;
        b=vrhktCHP/LBWkQXZunMzRwhTYg1y9Pev/LsbrLMkLzKGluuNAx6n5SL4l6sXbfVqbT
         MbGAxRztKHX2h4IBdVZs5LuzXS52uBYOHEZzs8Nnbnr+ofIcll4oLoAOkolLZJX0PIRt
         gWhWx8e9K+aTIwEQYiuQdTOkK0t9e2CDMwhe3GaAB8XvYwr9vQQ7dmfJqOTgHVx95+u4
         6Z8I3cYHsz5hGfs4esFxWkuA3Z/9uyvasBC18FvRodVhzE5RVSDxoprEEoaAYqj3hJ7g
         eIQKb2XmcOIzR0TQk4rVAtFOwRX/T2skcP9ciEF+5+C6jb0sU+pfr1NcRszhSL2BaRx4
         noSA==
X-Gm-Message-State: ANoB5pk7SGNTZd18EyuHMe8Xo8gdkceNE5vtAas6WtXaMB4gUisx8u0E
        +jedrtvTFjsVtw7g6XlDBD0iLXKvfxlitFLYuLw=
X-Google-Smtp-Source: AA0mqf5+oecIz9tdAMmlHWeDLUh6Wy1MYszFbhbgmgfRcMCT4v6fGEjvqwbbzXSMBPvApo5rfnp5YnsxywtiiCSSGKs=
X-Received: by 2002:a05:6602:2498:b0:6de:3990:de0e with SMTP id
 g24-20020a056602249800b006de3990de0emr37096741ioe.203.1671379095856; Sun, 18
 Dec 2022 07:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20221217180849.775718-1-aford173@gmail.com> <Y58rDppqQEI+vZ5U@pendragon.ideasonboard.com>
In-Reply-To: <Y58rDppqQEI+vZ5U@pendragon.ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 18 Dec 2022 09:58:04 -0600
Message-ID: <CAHCN7x+Zh28xwz6PDVAnepy4qE97TTCAwcTuUS+L3G7dkT7WRQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Fix missing GPC Interrupt
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 9:00 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Adam,
>
> Thank you for the patch.
>
> On Sat, Dec 17, 2022 at 12:08:48PM -0600, Adam Ford wrote:
> > The GPC node references an interrupt parent, but it doesn't
> > state the interrupt itself.  According to the TRM, this IRQ
> > is 87. This also eliminate an error detected from dt_binding_check
>
> The interrupt isn't used by the driver as far as I can see, so I can't
> test this, but the patch matches the reference manual, so

I don't think it changes functionality, but the other imx8m boards
have it, and 'make dtbs_check' showed it as missing.
Thanks for the review.

>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > Fixes: fc0f05124621 ("arm64: dts: imx8mp: add GPC node with GPU power domains")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 7a6e6221f421..7a8ca56e48b6 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -524,6 +524,7 @@ gpc: gpc@303a0000 {
> >                               compatible = "fsl,imx8mp-gpc";
> >                               reg = <0x303a0000 0x1000>;
> >                               interrupt-parent = <&gic>;
> > +                             interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> >                               interrupt-controller;
> >                               #interrupt-cells = <3>;
> >
>
> --
> Regards,
>
> Laurent Pinchart
