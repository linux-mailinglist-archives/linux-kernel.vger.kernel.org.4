Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFE865CF57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjADJR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjADJRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:17:55 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D4718E04;
        Wed,  4 Jan 2023 01:17:54 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id i84so9571982vke.7;
        Wed, 04 Jan 2023 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWfac0aQEJappowHl+xwXF9NDWJ8QlQ5XBo8UGwpyxo=;
        b=aHGIqXJVUzEVVBwFiVoh37pUXnb/eZT1qiq2eEoGXYZaCwKA51WizZm1PK7VCQ+5cE
         4RldFqpaytdMQzGkv/JIY+JmUR4NL9J7gAqnPTgSZFiEhigRNT1lTx4QmcYpz0dYb7VK
         Iqwjy9e72ygobOW9GLj33J7F0aUKTG3G9MDIR8UW9tc5NHEPHkAWjzfOBnIRpyV39z+p
         voEOlQUULjG9v6zSVdGezq77dMqcZlVSOtH+aDp5wCm386+Qs9jJfhSoETFt+R9TjpNF
         qfhv5wecBRX4MXBWW7VRMoFGlWv8MuTkEkxhT3ikeEXVJmSyeoGcpZgwSqwqqEoBffzX
         ffLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWfac0aQEJappowHl+xwXF9NDWJ8QlQ5XBo8UGwpyxo=;
        b=HOysdw7pB2znc+iE/yqO9nIIqb3fER1oe4QSDb6fgbc0cElbETsPSPTvBIYXSZl12j
         za9dyoybGwlqjgNqcE1qcDNeYV0xtHL1p4HyRngnQR0kZHad9BFZm6v/CTg+aQsiRrn9
         X1xEbPNZzh98j+woLUqOBy5J4nA6/WTkDgExBN2ZkmcmhCoFewjqbLFQGIOnplU3hFVB
         rOSebJ5IB+kw+j1C9u1ghojY01ZBciTmP81YosN1X2lpqBVHz0SPb878rna4FP6x/kLv
         69/DD4pT6XIzPkPOpWbh/N1avDJQwJOS+s47fcZmAeaMTF9f29fRFF3eMUovpBLjNtJL
         OLyA==
X-Gm-Message-State: AFqh2krKD2zkAYzbIOvM25hgdNUEpFWhAGPSH9QvDkPsb91bObGuAhEx
        HWt+OYX9YByFgxkYvlI2nrGY8U6fH+90kuwsNqA=
X-Google-Smtp-Source: AMrXdXueJ2O/V6xI9cs0KjLDr/43ol/vB+ey5HZomdeAQuT0cl+7SvEeUpSmSXHPTnEOPvSjRBLrRGZEo+g9KbsL5JM=
X-Received: by 2002:a05:6122:1689:b0:3c5:db35:9288 with SMTP id
 9-20020a056122168900b003c5db359288mr4946405vkl.32.1672823873536; Wed, 04 Jan
 2023 01:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-4-linux.amoon@gmail.com>
 <CAFBinCCtJbF6UjG3czQjVy_Zy_B4DO8BkcayOqDirn0OXw3PtQ@mail.gmail.com>
 <CANAwSgTS+j_oRrckwmi60afX6-D=OP0oy05m3eQga_gEZJJ_mg@mail.gmail.com>
 <CANAwSgTc=uGyZ0H_-ZckYoKztMB--DRfx7apBtP9zAbAU1XTvA@mail.gmail.com> <260b70ae-0758-592b-9c4d-90938e8a5b00@linaro.org>
In-Reply-To: <260b70ae-0758-592b-9c4d-90938e8a5b00@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 4 Jan 2023 14:47:36 +0530
Message-ID: <CANAwSgT4TXbz+dmMqiKP5JdbeaVHTh_oOtNQ_Tx-Ws+dBaWOCQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] arm64: dts: amlogic: Used onboard usb hub reset
 on odroid c2
To:     neil.armstrong@linaro.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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

Hi Niel,


On Wed, 4 Jan 2023 at 14:26, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 04/01/2023 09:13, Anand Moon wrote:
> > Hi Martin,
> >
> > On Wed, 28 Dec 2022 at 20:14, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> Hi Martin,
> >>
> >> On Wed, 28 Dec 2022 at 18:21, Martin Blumenstingl
> >> <martin.blumenstingl@googlemail.com> wrote:
> >>>
> >>> Hi Anand,
> >>>
> >> Thanks for your review comments.
> >>
> >>> thank you for working on this topic!
> >>>
> >>> On Wed, Dec 28, 2022 at 11:05 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >>> [...]
> >>>> +       usb {
> >>>> +               dr_mode = "host";
> >>>> +               #address-cells = <1>;
> >>>> +               #size-cells = <0>;
> >>>> +
> >>>> +               hub@1 {
> >>>> +                       /* Genesys Logic GL852G-OHG usb hub */
> >>>> +                       compatible = "genesys,usb5e3,610";
> >>>> +                       reg = <1>;
> >>>> +                       vdd-supply = <&usb_otg_pwr>;
> >>>> +                       reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
> >>>> +               };
> >>>> +       };
> >>> My understanding is that the hub@1 node should be part of the
> >>> corresponding USB controller node, not a new node.
> >>> In this case hub@1 should go into the existing &usb1 node. That way we
> >>> describe the way the hardware is set up (meaning: hub@1 is connected
> >>> to &usb1).
> >>>
> >>
> >> Ok, I will move this code under &usb0 and &usb1 nodes.
> >>
> >> onboard_usb_hub module just assists in usb hub reset.
> >> so these changes are meant to replace the gpio-hog.
> >>
> >> $ dmesg | grep onboard
> >> [    5.405558] usbcore: registered new device driver onboard-usb-hub
> >> [    6.383428] onboard-usb-hub 1-1: reset high-speed USB device number
> >> 2 using dwc2
> >>
> >> Here is the boot log of the odroid c2 [0] https://pastebin.com/PFy5waPb
> >>
> >
> > Moving the usb hub into usb subnode usb0 or usb1 does not work
> > on Odroid n2 and c4, we have a combo phys of usb 2.0 and usb 3.0
> > so the onboard usb hub reset does not get initialized until both the PHY
> > and USB nodes are brought up by the drivers.
>
> Fine, then add a comment before the usb node explaining that.
>

Sure, thanks.

> Thanks,
> Neil
>
Thanks
-Anand
