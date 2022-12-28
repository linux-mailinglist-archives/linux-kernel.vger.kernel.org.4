Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67E6577FE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiL1OpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiL1OpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:45:11 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4FA11A18;
        Wed, 28 Dec 2022 06:44:42 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id f24so7481997vkl.9;
        Wed, 28 Dec 2022 06:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nWly6CS117lh6W/pWnUHNuJLnc15iy3WKMaFGfN+hgI=;
        b=bC2m3zrfa87ubxBUOud/XnpoJ6JRQtIp5AvFP+Dg/RAfR3vLc3p3BbBnNuHMaFMkei
         wBdlTKZYONWbZWmgtF80/Od4Gw2vptTCDBS2qOKfrjzlwz4nObQZXJIu/K/woxvOyUHL
         gwAKm/jeYk5ljndDFPSMualoMn2J6ZmAu66QNS4n6mzyGS6hlJq0hF/UIm4R9Uk4Twq2
         DsLXuCnICp2OMF48mttlcnLUy0LSASlzfARftklE8BhyNiGwVDmFwd9jK1OzACUUCm3s
         olYwbfI1R9iaZEIYOL+Au9daFjixBBJSwM47bm1z45J4NFutuytYsdawrsRBhigy6MJO
         3ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWly6CS117lh6W/pWnUHNuJLnc15iy3WKMaFGfN+hgI=;
        b=Xio1cw8k8Q+sUcjUwP6+u7bnQ6rk+w3jSplqiKGbigohKf1UFWRDzvTQ9pY1FEJDbL
         ieOf2YWuUY8SK43+F1RJ2Gi7ypvWOtC5TU4fbRqwGvf23Ldo98U9nuBzYAxyT2KkAeA3
         DFqW6HwTtHnRTD+X8jThcs01KKUZE113cYt7ioLuwT7RQ9B4avGE7/EwgYL92vTgcUfi
         8zsaqG5uvogVFTV99k9nJfUM30o+8vbv3WK9iQXtGmdIzpB1po6Jk5WU/Nh3cqyNjPry
         a78yEWZ2+IjfSRLBvC+ENhhCH+/Oj6IS1+h9KP7LJkHSGC67r4mwNfFKwTiy4v9+4r7h
         uscQ==
X-Gm-Message-State: AFqh2kpVWoxIqqPRmLoDfiBU1I7AdKUNnUlc4ULK8fnL29GqV288bXyp
        LibAw93q/a8tQdKHbijcudKmLAFDI4CxGKxHlmIFJaRShx2DvA==
X-Google-Smtp-Source: AMrXdXvufFe8mF9LmkJ38VB3Th1R8eAghiEZYOYmoZ632g02xmiJBzLZcs2CNmlAkxfTxs9jvjt4E0bKNvbqBXn1tGc=
X-Received: by 2002:a1f:2189:0:b0:3d5:8603:a96f with SMTP id
 h131-20020a1f2189000000b003d58603a96fmr191769vkh.22.1672238681977; Wed, 28
 Dec 2022 06:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20221228100321.15949-1-linux.amoon@gmail.com> <20221228100321.15949-4-linux.amoon@gmail.com>
 <CAFBinCCtJbF6UjG3czQjVy_Zy_B4DO8BkcayOqDirn0OXw3PtQ@mail.gmail.com>
In-Reply-To: <CAFBinCCtJbF6UjG3czQjVy_Zy_B4DO8BkcayOqDirn0OXw3PtQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 28 Dec 2022 20:14:26 +0530
Message-ID: <CANAwSgTS+j_oRrckwmi60afX6-D=OP0oy05m3eQga_gEZJJ_mg@mail.gmail.com>
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

On Wed, 28 Dec 2022 at 18:21, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
Thanks for your review comments.

> thank you for working on this topic!
>
> On Wed, Dec 28, 2022 at 11:05 AM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > +       usb {
> > +               dr_mode = "host";
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               hub@1 {
> > +                       /* Genesys Logic GL852G-OHG usb hub */
> > +                       compatible = "genesys,usb5e3,610";
> > +                       reg = <1>;
> > +                       vdd-supply = <&usb_otg_pwr>;
> > +                       reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
> > +               };
> > +       };
> My understanding is that the hub@1 node should be part of the
> corresponding USB controller node, not a new node.
> In this case hub@1 should go into the existing &usb1 node. That way we
> describe the way the hardware is set up (meaning: hub@1 is connected
> to &usb1).
>

Ok, I will move this code under &usb0 and &usb1 nodes.

onboard_usb_hub module just assists in usb hub reset.
so these changes are meant to replace the gpio-hog.

$ dmesg | grep onboard
[    5.405558] usbcore: registered new device driver onboard-usb-hub
[    6.383428] onboard-usb-hub 1-1: reset high-speed USB device number
2 using dwc2

Here is the boot log of the odroid c2 [0] https://pastebin.com/PFy5waPb

> In case hub@1 is not detected within &usb1 then you may need something
> like [0] (not tested for your use-case).
> If that helps: feel free to include that patch in your series.
>

Thanks, will check if this is needed in this case. As of now it just
reinitializes the hub.

>
> Best regards,
> Martin
>
>
> [0] https://github.com/xdarklight/linux/commit/d8b96e5bc9c20ab2585194e0e59580c3b062c431

Thanks
-Anand
