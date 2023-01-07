Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6DC660FB2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjAGPAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjAGPAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:00:03 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD23AB36;
        Sat,  7 Jan 2023 07:00:02 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id a64so4348636vsc.2;
        Sat, 07 Jan 2023 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUeYKFgvLPiNMDM/RYrWoAcPJilIX0tcsPxNUG3sYRI=;
        b=LcbTRcIK/JQfnMLnFYv5XRqS2M1x009CwjIGyBo0OAekQMPw1uFcM3z/RPHVFkEDE/
         1NxqDM037qsuOHNstiIgd6IJ961yP2Rm0Wy8ImjQ4wMolFKQvVYQiI7DodOaU1YZd9+1
         /YNCWT6wCwkTE9UEPbHrs6UTKKAAqgPdGB+/rUWs0DCZILbN/9mCOmQarHroRLUI+lhz
         HC39jrfN7SDWdVQTVZslDvD2tr9GcmcbKyW2KA9bheDISUSAjHmMGQvBmx5gG9bTUmHe
         0298bE92L49yIi+r6QBgBnqDnvzWVoI9xz+eDTPLIT6aML+AH3L1Ly9eA9wUUQrUiWlz
         OeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUeYKFgvLPiNMDM/RYrWoAcPJilIX0tcsPxNUG3sYRI=;
        b=MCij22L0GMMKjz5kOCyqfI4UbML4p3RDAceN1guxXR8SDUxDOWGtL4OVEnYe0Rhv/x
         JWd2xOch6wxvlCfH9p9b2kpmfxZ9/NvSUQKqx6hEUcS7tsGqYCAqgJWY9Ap8KfENRK2D
         PLDtWMwCpsWlTIkpaMW19l93tRWV1+V/fYH3/Z4oVyIlujseM/COjwr0Ge7CikMrSChG
         fv2UGWIA5m+carZhoqRIbLgfYxdaFJXcY5jFwJ7fzeKPb/iPSfBisV6R5MB1Ki93I0pa
         2sEXNotTQlWzsUpphBgV8em7rSrC94q1ixA1NsCkgKk9t+fC22Ed6v8tIHFDSmXqnoI/
         rt5A==
X-Gm-Message-State: AFqh2kpAb0hzQ3+xfmF8DAm7nXcePl4sSlidk5YQMjC75acjnYkrBbBF
        z5OWOLEGigDEFzL0JmT4bh796kVsDkij2pVwAUI=
X-Google-Smtp-Source: AMrXdXvIB1aVw+jb60rfsdRyjxZioez123SYKtkZI05xvV4D8KCmVLZVNWmYhdkBAsWD6SEIUzvHwqQ/I4KuvF9Qnmk=
X-Received: by 2002:a05:6102:dca:b0:3ce:af78:6ae6 with SMTP id
 e10-20020a0561020dca00b003ceaf786ae6mr2247789vst.2.1673103601868; Sat, 07 Jan
 2023 07:00:01 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-3-linux.amoon@gmail.com>
 <c5b0e7e3-7e74-308f-a64b-f472acd670eb@linaro.org>
In-Reply-To: <c5b0e7e3-7e74-308f-a64b-f472acd670eb@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Jan 2023 20:29:45 +0530
Message-ID: <CANAwSgTiJ9=oA6TWPF+YT2fZd4gDifmG-idW6LfHCh2VGYZoVQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] ARM: dts: amlogic: Used onboard usb hub reset to
 enable usb hub
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
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

Hi Krzysztof,

On Wed, 28 Dec 2022 at 20:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/12/2022 11:03, Anand Moon wrote:
> > On Odroid c1 previously use gpio-hog to reset the usb hub,
> > switch to used on board usb hub reset to enable the usb hub
> > and enable power to usb hub.
> >
> > Add usb hub regulator as per the schematic.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm/boot/dts/meson8b-odroidc1.dts | 40 +++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > index 04356bc639fa..3b29169aac43 100644
> > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > @@ -185,6 +185,33 @@ vdd_rtc: regulator-vdd-rtc {
> >
> >               vin-supply = <&vcc_3v3>;
> >       };
> > +
> > +     usb_otg_pwr: regulator-usb-pwrs {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "USB_OTG_PWR";
> > +
> > +             regulator-min-microvolt = <5000000>;
> > +             regulator-max-microvolt = <5000000>;
> > +
> > +             /* signal name from schematics: PWREN */
> > +             gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             vin-supply = <&p5v0>;
> > +     };
> > +
> > +     usb {
> > +             dr_mode = "host";
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             hub@1 {
> > +                     /* Genesys Logic GL852G-OHG usb hub */
> > +                     compatible = "genesys,usb5e3,610";
>
> Wrong compatible. Does not match pattern in usb-device.yaml.
>

ok, will fix this in the next version.

>
> Best regards,
> Krzysztof
>

Thanks


-Anand
