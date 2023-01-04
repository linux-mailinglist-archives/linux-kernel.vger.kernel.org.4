Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2E65CE1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbjADINm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjADINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:13:39 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA4DEAC;
        Wed,  4 Jan 2023 00:13:38 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id b81so16407534vkf.1;
        Wed, 04 Jan 2023 00:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3I30bgfMY9WUrJgksaYM9KczmD0tI2Za+tq643ww4R8=;
        b=N6J087Fm7kluyC4fhNaJ87HE4sYhM9FEquXeCTQkm3b3v0GzHcRiiGKrVvXK8G52Gl
         LH9XiEVYn0jgy7SfFtUZOm5q4zr8P8fvUQoMSGV3r5sS7Lu3Gvgjkyd+XWXAJcDMA1MB
         m7ShwnQ7roaoNvw2jiMjACtJ0WC1n/J7JKlUj+j4RDPpSBE27ar+X51je4AboKlhKnar
         wlUlvMyaNTTglPNaXb3YwdbkqCF260DHwPVwMxJNj/g53HnykeYjGNUGPgL1LRJQU1P0
         AEioHXbWTkXPSxgwCJDJIYKmcyFlKpUZyUWeLy/m/w/7pBCuuSnXdR+lgEpq1Z7sMkye
         eRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3I30bgfMY9WUrJgksaYM9KczmD0tI2Za+tq643ww4R8=;
        b=Ecd3FOHYgk2fGB+qKe08G7M30WVrXIMpmCtES1ReLEdflRkdr/BOCDJSwXJRIOi3Y5
         0luamSBfgVao6zf35dsz0OBUngjm3yEBRFQO6gW716d/m3eZCrCsYZfQwvI7+K0TYE6n
         szomskyGmIrxk+je+AqrLMN/lTFh1ww8CLfsDK7WPGg+BcWRhZ8kXyejIsVUC6kRZXtw
         PJD//4Ej1tQgB6nvR+L/FpuxhPW9JUNOb/tONAPC2G1fBBxF0Pkoe5XeYFarihEGE+rK
         vU5EHgbHdQ+G9YATB0KCYNgToyKNVZYGogozYpjmItbaabgZjbKDuWQ6uQyj2WE5dqMj
         28Jg==
X-Gm-Message-State: AFqh2kpoXVbnYdjv4TLzUMZZ4s3mSKWbp6PAU9KGKhLcZ9Vf+Tuoa1qD
        Qn/z9isXAGIiyaCXfJoVhmHHSPv4rb99DCJRClI=
X-Google-Smtp-Source: AMrXdXubfkmk2rZfaNt3+6R7QotOTAbeXp9zG6pDl071rqB1KImQAd+e41xSjnzQgG1g+2zNhv1zW/xBORRaxw4AzcY=
X-Received: by 2002:a05:6122:b66:b0:3d5:d67e:e5a8 with SMTP id
 h6-20020a0561220b6600b003d5d67ee5a8mr811956vkf.33.1672820017377; Wed, 04 Jan
 2023 00:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-4-linux.amoon@gmail.com>
 <CAFBinCCtJbF6UjG3czQjVy_Zy_B4DO8BkcayOqDirn0OXw3PtQ@mail.gmail.com> <CANAwSgTS+j_oRrckwmi60afX6-D=OP0oy05m3eQga_gEZJJ_mg@mail.gmail.com>
In-Reply-To: <CANAwSgTS+j_oRrckwmi60afX6-D=OP0oy05m3eQga_gEZJJ_mg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 4 Jan 2023 13:43:21 +0530
Message-ID: <CANAwSgTc=uGyZ0H_-ZckYoKztMB--DRfx7apBtP9zAbAU1XTvA@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] arm64: dts: amlogic: Used onboard usb hub reset
 on odroid c2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
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

Hi Martin,

On Wed, 28 Dec 2022 at 20:14, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Wed, 28 Dec 2022 at 18:21, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> Thanks for your review comments.
>
> > thank you for working on this topic!
> >
> > On Wed, Dec 28, 2022 at 11:05 AM Anand Moon <linux.amoon@gmail.com> wrote:
> > [...]
> > > +       usb {
> > > +               dr_mode = "host";
> > > +               #address-cells = <1>;
> > > +               #size-cells = <0>;
> > > +
> > > +               hub@1 {
> > > +                       /* Genesys Logic GL852G-OHG usb hub */
> > > +                       compatible = "genesys,usb5e3,610";
> > > +                       reg = <1>;
> > > +                       vdd-supply = <&usb_otg_pwr>;
> > > +                       reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
> > > +               };
> > > +       };
> > My understanding is that the hub@1 node should be part of the
> > corresponding USB controller node, not a new node.
> > In this case hub@1 should go into the existing &usb1 node. That way we
> > describe the way the hardware is set up (meaning: hub@1 is connected
> > to &usb1).
> >
>
> Ok, I will move this code under &usb0 and &usb1 nodes.
>
> onboard_usb_hub module just assists in usb hub reset.
> so these changes are meant to replace the gpio-hog.
>
> $ dmesg | grep onboard
> [    5.405558] usbcore: registered new device driver onboard-usb-hub
> [    6.383428] onboard-usb-hub 1-1: reset high-speed USB device number
> 2 using dwc2
>
> Here is the boot log of the odroid c2 [0] https://pastebin.com/PFy5waPb
>

Moving the usb hub into usb subnode usb0 or usb1 does not work
on Odroid n2 and c4, we have a combo phys of usb 2.0 and usb 3.0
so the onboard usb hub reset does not get initialized until both the PHY
and USB nodes are brought up by the drivers.

# On Odroid n2 has a combo hub
alarm@odroid-n2:~$ lsusb -tv
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
        ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
        |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
            ID 174c:5106 ASMedia Technology Inc. ASM1051 SATA 3Gb/s bridge
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        ID 05e3:0610 Genesys Logic, Inc. Hub
        |__ Port 2: Dev 4, If 0, Class=Vendor Specific Class,
Driver=ax88179_178a, 480M
            ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet

# Odroid C4 also has a combo hub

alarm@odroid-c4:~$ lsusb -tv
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    ID 1d6b:0003 Linux Foundation 3.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
        ID 2109:0817 VIA Labs, Inc.
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
    ID 1d6b:0002 Linux Foundation 2.0 root hub
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        ID 2109:2817 VIA Labs, Inc.

So I will continue to work with this usb hub node to do a proper reset
of the USB hub.

> > In case hub@1 is not detected within &usb1 then you maym need something
> > like [0] (not tested for your use-case).
> > If that helps: feel free to include that patch in your series.
> >
>
> Thanks, will check if this is needed in this case. As of now it just
> reinitializes the hub.
>
> >
> > Best regards,
> > Martin
> >
> >
> > [0] https://github.com/xdarklight/linux/commit/d8b96e5bc9c20ab2585194e0e59580c3b062c431
>
> Thanks
> -Anand

Thanks
-Anand
