Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBFE660FA8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjAGO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:56:27 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B23AB36;
        Sat,  7 Jan 2023 06:56:27 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id l184so4367689vsc.0;
        Sat, 07 Jan 2023 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFyLUIx8VXvv71DzGWZEEjL5hj6rPhYAH4n7XJ6OnbU=;
        b=ooXLw1zSzyjR8WV8a1SL5uV4hNdB567FCOLxUPAvYIu0IbfF79B+FPKP+QNnAKaeCE
         /xJuOTC+4evgPpENIFNGaFn3ZnfBToFYoUZwF+5kabwSTs0c4mr1czfBj0fmtdxBthPX
         LXwXbsYVB1oqJ0sBOxV+GVQkosHX+xogHXy+RJaKx8lQyVrr795FbJmRVfr6a22wt40C
         0XGkyuWl+O0kXoLzPAQZuxWnZTjjH51h640x0m0fUSnPhDti0efpZChBfAsSt0TUb9CX
         KGbATst2J89nrnZP45Jj/0BmcRvYhY3vZRIP9/5Ixc+97q8qgMPjkrTMoXLY/RWUTRu3
         ht9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFyLUIx8VXvv71DzGWZEEjL5hj6rPhYAH4n7XJ6OnbU=;
        b=Uyts/zx+X/f22xsyJe1X5N3xtFDa8jl0sehMm/S1Me4YrsSiRseaHp7itTauNPdh+v
         WcWltWeaUTNWqW13AIOx2FRrCQf3EePtsa+VEWFTqrBA76okUI7pQXw9C9oMxibhXS4r
         ES/wAZKsOkWzuTOYKwPjcZ9WhPOGBw+AqF1knffrDDkONKEFHsvTeFC+OS8iDLw70Qww
         VY75O0LaY09z7h5eIyD2rjQFs7HAB7G7FggYucv2UYtWerhgKYOIk2tjDzhwhDknrO1G
         2siAvhMU5miEulD3f7++CWQ2Z3LGFXdGKJ6GybCUHIZeZVVxDo6JzpXpFmPsF2hwRvPW
         8p4w==
X-Gm-Message-State: AFqh2kpOFKmgIM3tDfPZSDdSbVi60960zP6X/5FAvdmuSX7HPl0jfXzp
        1X5kIBcTTzGBkXk7q+dWnRsk7sczm8xncbhvkWA=
X-Google-Smtp-Source: AMrXdXtwgQnBccAmp5deA8Qb6NaBwtu2mLi/Xeu599Y9cfSvJcQOgMPGlzs0i9INqGyGNOHhdAp7Q/uoH2RT3ShqOaU=
X-Received: by 2002:a67:5c03:0:b0:3ce:a7c5:3757 with SMTP id
 q3-20020a675c03000000b003cea7c53757mr2460727vsb.63.1673103386173; Sat, 07 Jan
 2023 06:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <CANAwSgTS+j_oRrckwmi60afX6-D=OP0oy05m3eQga_gEZJJ_mg@mail.gmail.com>
 <CANAwSgTc=uGyZ0H_-ZckYoKztMB--DRfx7apBtP9zAbAU1XTvA@mail.gmail.com> <2188024.ZfL8zNpBrT@steina-w>
In-Reply-To: <2188024.ZfL8zNpBrT@steina-w>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 7 Jan 2023 20:26:09 +0530
Message-ID: <CANAwSgT1xo1Nt84p2ruXBQ+Aq+aAr62VL8Gf8iRU8u_09y8BaA@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] arm64: dts: amlogic: Used onboard usb hub reset
 on odroid c2
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Alexander,

Thanks for your review comments.

On Wed, 4 Jan 2023 at 15:06, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Am Mittwoch, 4. Januar 2023, 09:13:21 CET schrieb Anand Moon:
> > Hi Martin,
> >
> > On Wed, 28 Dec 2022 at 20:14, Anand Moon <linux.amoon@gmail.com> wrote:
> > > Hi Martin,
> > >
> > > On Wed, 28 Dec 2022 at 18:21, Martin Blumenstingl
> > >
> > > <martin.blumenstingl@googlemail.com> wrote:
> > > > Hi Anand,
> > >
> > > Thanks for your review comments.
> > >
> > > > thank you for working on this topic!
> > > >
> > > > On Wed, Dec 28, 2022 at 11:05 AM Anand Moon <linux.amoon@gmail.com>
> > > > wrote:
> > > > [...]
> > > >
> > > > > +       usb {
> > > > > +               dr_mode = "host";
> > > > > +               #address-cells = <1>;
> > > > > +               #size-cells = <0>;
> > > > > +
> > > > > +               hub@1 {
> > > > > +                       /* Genesys Logic GL852G-OHG usb hub */
> > > > > +                       compatible = "genesys,usb5e3,610";
> > > > > +                       reg = <1>;
> > > > > +                       vdd-supply = <&usb_otg_pwr>;
> > > > > +                       reset-gpio = <&gpio_ao GPIOAO_4
> > > > > GPIO_ACTIVE_LOW>;
> > > > > +               };
> > > > > +       };
> > > >
> > > > My understanding is that the hub@1 node should be part of the
> > > > corresponding USB controller node, not a new node.
> > > > In this case hub@1 should go into the existing &usb1 node. That way we
> > > > describe the way the hardware is set up (meaning: hub@1 is connected
> > > > to &usb1).
> > >
> > > Ok, I will move this code under &usb0 and &usb1 nodes.
> > >
> > > onboard_usb_hub module just assists in usb hub reset.
> > > so these changes are meant to replace the gpio-hog.
> > >
> > > $ dmesg | grep onboard
> > > [    5.405558] usbcore: registered new device driver onboard-usb-hub
> > > [    6.383428] onboard-usb-hub 1-1: reset high-speed USB device number
> > > 2 using dwc2
> > >
> > > Here is the boot log of the odroid c2 [0] https://pastebin.com/PFy5waPb
> >
> > Moving the usb hub into usb subnode usb0 or usb1 does not work
> > on Odroid n2 and c4, we have a combo phys of usb 2.0 and usb 3.0
> > so the onboard usb hub reset does not get initialized until both the PHY
> > and USB nodes are brought up by the drivers.
> >
> > # On Odroid n2 has a combo hub
> > alarm@odroid-n2:~$ lsusb -tv
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> >     ID 1d6b:0003 Linux Foundation 3.0 root hub
> >
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
> >
> >         ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
> >
> >         |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage,
> >         |5000M
> >
> >             ID 174c:5106 ASMedia Technology Inc. ASM1051 SATA 3Gb/s bridge
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
> >     ID 1d6b:0002 Linux Foundation 2.0 root hub
> >
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> >
> >         ID 05e3:0610 Genesys Logic, Inc. Hub
> >
> >         |__ Port 2: Dev 4, If 0, Class=Vendor Specific Class,
> >
> > Driver=ax88179_178a, 480M
> >             ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet
> >
> > # Odroid C4 also has a combo hub
> >
> > alarm@odroid-c4:~$ lsusb -tv
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
> >     ID 1d6b:0003 Linux Foundation 3.0 root hub
> >
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
> >
> >         ID 2109:0817 VIA Labs, Inc.
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
> >     ID 1d6b:0002 Linux Foundation 2.0 root hub
> >
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> >
> >         ID 2109:2817 VIA Labs, Inc.
> >
> > So I will continue to work with this usb hub node to do a proper reset
> > of the USB hub.
>
> If your USB hub does both USB2.0 and USB3.0 you need to add both devices in DT
> and reference them using 'peer-hub'property. See ca69b6c78d5d ("arm64: dts:
> tqma8mpql: add support for 2nd USB (host) interface") for a reference.
>

Yes, I have updated the DTS example for using peer-hub for both devices.

> Best regards,
> Alexander
>
Thanks



-Anand
