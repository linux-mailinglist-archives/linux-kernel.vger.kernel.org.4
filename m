Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A15B85C3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiINJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiINJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:59:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92F30553
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:59:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z97so21408765ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V4RrDQnfr6xSnGZ3KzxlQ6mHzQiczZDyhIA9gD9qjUI=;
        b=nQZMRHPg2UTgOxDP7JSRo8akFJA5IkWIkvKU/1DUSeRzAJwMhp+z8o9Y8Di6Ye0CzC
         0gDfbJhHCN+MCF2W5gB0gH3NFXe+V/QJtSzi7Nb1pvvUQ0tHDBPVfO99kDYUKnJK+hTF
         dOI4eUohJ2YyQeCL6z9m0hRCLbUVfgHFnq0u1/+jSxKebBLrsrzSxkLng3Qn3gV7kh0k
         zdfM0BgYLbh3NbMh5OKtLut2ZMpUYztGpTzd/RciYzGPSIb+yL/F2Kh7qJ1TOORs0WPG
         Dg1/CW2NLDCjLdpIsEBoIsfrjOOnrgoSJ+0Z3hMo9K9xsQipdaXZXfX5hTJbCQsGOj4t
         WaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V4RrDQnfr6xSnGZ3KzxlQ6mHzQiczZDyhIA9gD9qjUI=;
        b=G3DZKco7GCuDh0aLj/a44roZo0rL0PFrtPoPM+UZWlcrHYtmKGaw+1M944TyaEyhkt
         khJsXIDjCMymhazxyIAJHFK5NgP4Be8E5usOo2VTqby19vGlF2NkdcVH5/kusSxziogK
         N0Oq77G/cTM86KPP6diKrwcdTb/H59Xr7JplEk67y3lP8BHL7qBtPIkU0y5dNE+3YEjv
         KeT65phmeOs/75I8wb65Dp3hx8ZCaUvnkTPP80an/btC165NjRCbKjTGhk8O1YNZqsXH
         E5wZWfo9poLMUTNctn5I8DjyF/MTGo31QnxZNOKF2QqFOkrqrhs0oEgVlsnOATCvkV2a
         6fKw==
X-Gm-Message-State: ACgBeo2FhL4Z6fL+8rw0yPWf7DsiT470jGR8DKo38JQpKf6LJX5N/ccQ
        1wkeKvsuiIf3JhhWHpahPwM4i9FJJuPyU/T+SbWJY/9KdlPYffBZ
X-Google-Smtp-Source: AA6agR5k1IWUTu/5qFMdsnP1uc+73La/xSsDFRk24vZ/WeRm4VC6W66Q8nrVvaW0tIVvF+1KB77wGcU5FxxBabIHWMk=
X-Received: by 2002:a05:6402:43cc:b0:451:129e:1b1e with SMTP id
 p12-20020a05640243cc00b00451129e1b1emr20773700edc.258.1663149548597; Wed, 14
 Sep 2022 02:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
In-Reply-To: <20220911200147.375198-1-mike.rudenko@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 14 Sep 2022 10:58:52 +0100
Message-ID: <CAPY8ntCA3jbpBOiNfoft58sHPeTFSLoLop0VUmkOCWP3cX_rdw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail

On Sun, 11 Sept 2022 at 21:02, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
>
> Hello,
>
> this series implements support for Omnivision OV4689 image
> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
> megapixel image sensor. Ihis chip supports high frame rate speeds up
> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> connection.
>
> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.
>
> While porting the driver, I stumbled upon two issues:
>
> (1) In the original driver, horizontal total size (HTS) was set to a
> value (2584) lower then the frame width (2688), resulting in negative
> hblank. In this driver, I increased HTS to 2688, but fps dropped from
> 29.88 to 28.73. What is the preferred way to handle this?

This is one of the joys of sensors - they don't all work in the same way.

I don't have an official datasheet for OV4689 from Omnivision, but
found one on the internet [1]. That should allow you to reverse the
PLL configuration to confirm that the pixel rate is the value you've
computed based on link frequency (they aren't necessarily related). Do
the frame rate calculations work using width + HBLANK, height +
VBLANK, and pixel rate?
The datasheet claims the sensor supports 2688x1520 @ 90 fps, so
something doesn't hold true between 4 data lanes at 500MHz/1Gbit/s per
lane when your default hts/vts is 2688x1554 and it only gives
28.73fps.

I have seen modes in sensors where the HTS register is in units of 2
pixels, so what range of HTS (and VTS) values actually works on this
sensor? (I don't see it documented, but I'm not surprised).

[1] https://cdn.hackaday.io/files/19354828041536/OV4689-OmniVision.pdf

> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
> gain is not linear across that range. Instead, it is piecewise linear
> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
> with more linear segments in between. Rockchip's camera engine code
> chooses one of the above segments depenging on the desired gain
> value. The question is, how should we proceed keeping in mind
> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
> libcamera will do the mapping, or the driver will do the mapping
> itself and expose some logical gain units not tied to the actual gain
> register value? Meanwhile, this driver conservatively exposes only
> 0x0-0xf8 gain register range.

The datasheet linked above says "for the gain formula, please contact
your local OmniVision FAE" :-(
I would assume that the range is from 1x rather than 0x - people
rarely want a totally black image that 0x would give. Or is it ranges
of 1x - 2x, 2x - 4x, 4x - 8x, and 8x - 16x?

Other sensors expose the full range of the register via
V4L2_CID_ANALOGUE_GAIN, and require userspace (mainly libcamera now)
to know how to convert a gain into the register value. If the gain
range goes up to x16, then exposing that would be useful. I'd advocate
just exposing the full range of 0x000 - 0x7ff, as then you can have
the accuracy of 256 values between x1 to x2, but also the full range.

I might see if I can pick up one of these sensors and see if I can get
it running on a Raspberry Pi. Thanks for trying to upstream this -
it's nice to have such a range of sensor drivers to choose from.

  Dave

> [1] https://github.com/rockchip-linux/kernel/blob/develop-4.19/drivers/media/i2c/ov4689.c
>
> changes in v2:
> - bindings: reword descriptions
> - bindings: move clock description to clocks property
> - bindings: add data-lanes and link-frequencies properties to port
> - driver: validate media bus configuration when probing
>
> Mikhail Rudenko (2):
>   media: dt-bindings: media: i2c: document OV4689 DT bindings
>   media: i2c: add support for ov4689
>
>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 +++
>  MAINTAINERS                                   |   8 +
>  drivers/media/i2c/Kconfig                     |  14 +
>  drivers/media/i2c/Makefile                    |   1 +
>  drivers/media/i2c/ov4689.c                    | 951 ++++++++++++++++++
>  5 files changed, 1115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>  create mode 100644 drivers/media/i2c/ov4689.c
>
> --
> 2.37.3
