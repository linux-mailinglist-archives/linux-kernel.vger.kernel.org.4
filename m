Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD7671C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjARMer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjARMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:33:49 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0E360B5;
        Wed, 18 Jan 2023 03:55:20 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k4so35405345vsc.4;
        Wed, 18 Jan 2023 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvAQcqbx1FUcQCzp8KB4ljSTPL23uYmDYuGsf37mkgA=;
        b=pTSXekQ15kWo5bKf6kfCu1sC18y2qCRbwDyu1J7wYF9LvFg84utLUKpd/loqasNZ3c
         MmraiAIFg9QL9e0xvJD2iFEjdRcQmM8SZgRnujLwLmSD5ERgJ/2resMnQnHu8xwvGm07
         Vurn9QWcyuAFXq4smz8np4UfwpUtTvwgoSaU5Gtei7YCoRT4oj0YmtELNpu2ioL0Ubhb
         UEaqt4HLaKKYmu5nOCoxrGkXulyXNUCK9vYVQmxsOyU9eq70S2Jn8BgLCPYHPzx6P+iC
         73vXgKUFdixiZC++nP3Nha7el3A245yB60FNIT2bl46PwTPEBGJSCjCOkWRBosXk3j/Y
         QfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvAQcqbx1FUcQCzp8KB4ljSTPL23uYmDYuGsf37mkgA=;
        b=WoKWpedD8wjOb5ssKliOPbsLLnOp5sw9j8hPSjdectBbkG0tlTNYIELPn4NKJBzo2C
         Y4llfT4iXMKyZrDh+zCUPC7KXLRPyhDNsQlfSAftGsaUK9dNi5hNCbIXns6laCDCZRBO
         8fj8uo/doUjjexjTWHK9E6MTgMEQNGktY6yjrmwxLNzenNqo56L31nDF9rillaYfeQIj
         4xcLdc78Fd9ox5nvWnV40Js/6IVvQ4vwB4EUo91ozPhfkP4xr2rcfmNuEVfjZaY3U1m+
         zR9xqJJsxlWGvnFyzWKGCYMm9R6ShKyMPoQlYit0x1ld7IVmp1lJUtcVgXQ942VZ7DbJ
         H4Ag==
X-Gm-Message-State: AFqh2kpH5FswNbPDvPuzwOnE4QtPtaq8DMbpKAz2l4Jhr/EY8UKy+2XO
        xj5tx0ic7/ctknSeF6xhCtlgd0k/w9xygmE06gw=
X-Google-Smtp-Source: AMrXdXsTGDwIPrIyj0f0dEF05oYUgttHd+Fpx/8RVdDi1Au7CSkfdIfFULr149JhmOsY/woguSbfxOzkCsjaB9zm5Dg=
X-Received: by 2002:a67:f650:0:b0:3d3:db6b:e761 with SMTP id
 u16-20020a67f650000000b003d3db6be761mr941230vso.46.1674042919647; Wed, 18 Jan
 2023 03:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20230118044418.875-1-linux.amoon@gmail.com> <20230118044418.875-8-linux.amoon@gmail.com>
 <b112ee8e-93ab-2c30-ced3-82ff858884b4@linaro.org>
In-Reply-To: <b112ee8e-93ab-2c30-ced3-82ff858884b4@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jan 2023 17:25:04 +0530
Message-ID: <CANAwSgQ1b8vj+HCBS0ARnNqOwKHU8VzzsB7htL3L4Sr_v6Y=VQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] arm64: dts: amlogic: Used onboard usb hub reset on
 odroid c4
To:     neil.armstrong@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Neil,

Thanks for your review comments.

On Wed, 18 Jan 2023 at 13:59, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 18/01/2023 05:44, Anand Moon wrote:
> > On Odroid c4 previously use gpio-hog to reset the usb hub,
> > switch to used on-board usb hub reset to enable the usb hub
> > and enable power to hub.
> >
> > USB hub is combination of USB 2.0 and USB 3.0 root hub so
> > use peer-hub node to link then.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: - fix the compatible string.
> >      - Fix the hub node to use peer-hub to link the usb 2.0 and usb 3.0.
> > ---
> >   .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 36 ++++++++++++-------
> >   1 file changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> > index 8c30ce63686e..d04768a66bfe 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
> > @@ -26,20 +26,30 @@ led-blue {
> >       sound {
> >               model = "ODROID-C4";
> >       };
> > -};
> >
> > -&gpio {
> > -     /*
> > -      * WARNING: The USB Hub on the Odroid-C4 needs a reset signal
> > -      * to be turned high in order to be detected by the USB Controller
> > -      * This signal should be handled by a USB specific power sequence
> > -      * in order to reset the Hub when USB bus is powered down.
> > -      */
> > -     hog-0 {
> > -             gpio-hog;
> > -             gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
> > -             output-high;
> > -             line-name = "usb-hub-reset";
> > +     /* USB hub supports both USB 2.0 and USB 3.0 root hub */
> > +     usb-hub {
> > +             dr_mode = "host";
>
> Is this really needed ?
>
I got carried forward from the other device tree binding,
If not needed I will drop this.

> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             /* 2.0 hub on port 1 */
> > +             hub_2_0: hub@1 {
> > +                     compatible = "usb2109,2817";
> > +                     reg = <1>;
> > +                     peer-hub = <&hub_3_0>;
> > +                     reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> > +                     vdd-supply = <&vcc_5v>;
> > +             };
> > +
> > +             /* 3.1 hub on port 4 */
> > +             hub_3_0: hub@2 {
> > +                     compatible = "usb2109,817";
> > +                     reg = <2>;
> > +                     peer-hub = <&hub_2_0>;
> > +                     reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
> > +                     vdd-supply = <&vcc_5v>;
> > +             };
>
> The final discussion in v1 was to drop this /usb-hub node and move the
> hub_2_0 & hub_3_0 node under the dwc3 node.
>

Yes, but It did not work back then, since these are two different events
USB node will try to bring the PHY and dwc2 and dwc2 nodes up.
USB hub supports the reset of the USB hub and links the power supply
to the ports.
This works on this board.

> Neil
>
Thanks

-Anand
