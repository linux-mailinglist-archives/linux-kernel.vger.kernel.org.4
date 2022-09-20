Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6115BE529
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiITMCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiITMCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:02:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD3B300
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:02:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l14so5554174eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MkcK4zK+tjbZZvzTepuJ6OrH+0JrK/IcroIHFcHOeiA=;
        b=TXzYpl61qpkkKwlh/oMApLrqEMNnGSWfkSHv0+InNoji1gpsl0gMOiAyhcKF0wFNmZ
         RBgSEUTAByWFS9T4kYxCgIkEukPXPM9XZOobBUKmUZtZX8EdT/e7sTHvpNZfoZhvxAvt
         Y55cPndWrEIw3sMeT5WGZi6Br2k4G4Lc0UwJ5PpND1kKQX5JLWCxUEDuIUsTnUhKMEzw
         EJgejT77D02sRv/iH5WrOd0ua/D/eyzjD3Qt0Q/xNxo6cB+hTVrAixJNRP7HwS0I08bm
         kU7+yRdQ67KXMx4iGioTpuIFMMjSZmKWEDz0DsMqM7ci10aCD3M1pmRahuFKVCPCc0sY
         1f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MkcK4zK+tjbZZvzTepuJ6OrH+0JrK/IcroIHFcHOeiA=;
        b=mtfNtl614MYjb9z0lIcKGIJNuRU2+Pa2ZB7HiBLjejRLJhizW4JDw6F9KlFLujyE/f
         GpqkTQPnuljPBXFlUKvMh30ZTyZRWtKbRIVB8ewxugFonsNNIDRI6nF05v6sLR34+Tj0
         A7WugE6GagZ0sDNeIpRHo/Gq9z4zaq3mNrHTju83aY3v09KpZ3dASOXcmWMbN5GEBJ76
         ykF0OoD1XQxJWt1UAdhpia9q7dnUHNfGqyGO1sHR/51bnhpUXakh5jFM/9o4BZHtdXlG
         Q76VtrcT5MAjnmZ3gMPHsxACLgBQRvNycYJx/Aj9dHhHs9TkAUPqccmAHnMMsAIMNdbo
         uHPg==
X-Gm-Message-State: ACrzQf0R5Km98qlCk6d1GAxrB/OsQ16w5DHWg9/OnTfJC4R+ceMr7q7J
        F6IgP2QCzqeRDkL/nMK7Cm1YXJs92/txjyje7svwSA==
X-Google-Smtp-Source: AMsMyM59qNJxAT+EW6Bax/KhZRBtSKiJwgOGBu9PBMmRtuF4aEP0GfsoYN425U/jmViNSEzZcZy6XkYdfSesv/S4VBY=
X-Received: by 2002:a17:907:3da3:b0:780:3d46:cbe3 with SMTP id
 he35-20020a1709073da300b007803d46cbe3mr17063761ejc.175.1663675364874; Tue, 20
 Sep 2022 05:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-5-m.felsch@pengutronix.de> <YyhktzmcgXKnrMFU@pendragon.ideasonboard.com>
 <20220919171142.6av6ap5gwweldado@pengutronix.de> <Yyio06jhK13BiNiP@pendragon.ideasonboard.com>
 <20220920104854.2wugqxffkf4qeib6@pengutronix.de> <Yymgr3pdbNWq6hn0@pendragon.ideasonboard.com>
In-Reply-To: <Yymgr3pdbNWq6hn0@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 20 Sep 2022 13:02:30 +0100
Message-ID: <CAPY8ntCde+0ib_T2XNfyZ4EG0-wAc_16HLEMmdCj=-M=hLVTaw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] media: tc358746: add Toshiba TC358746 Parallel to
 CSI-2 bridge driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, sakari.ailus@linux.intel.com,
        hverkuil@xs4all.nl, jacopo@jmondi.org,
        kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent & Marco

On Tue, 20 Sept 2022 at 12:15, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Marco,
>
> On Tue, Sep 20, 2022 at 12:48:54PM +0200, Marco Felsch wrote:
> > On 22-09-19, Laurent Pinchart wrote:
> > > On Mon, Sep 19, 2022 at 07:11:42PM +0200, Marco Felsch wrote:
> > > > On 22-09-19, Laurent Pinchart wrote:
> > > > > On Fri, Sep 16, 2022 at 03:45:35PM +0200, Marco Felsch wrote:
> > > > > > Adding support for the TC358746 parallel <-> MIPI CSI bridge. This chip
> > > > > > supports two operating modes:
> > > > > >   1st) parallel-in -> mipi-csi out
> > > > > >   2nd) mipi-csi in -> parallel out
> > > > > >
> > > > > > This patch only adds the support for the 1st mode.
> > > > > >
> > > > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > > > ---
> > > > > > Changelog:
> > > > > >
> > > > > > v2:
> > > > > > - use the correct CID_LINK_FREQ control to query the sensor_pclk_rate
> > > > > > - remove now not needed tc358746_link_setup() and
> > > > > >   struct v4l2_ctrl sensor_pclk_ctrl
> > > > > > - call v4l2_subdev_link_validate_default() during link validation
> > > > > > - remove MEDIA_BUS_FMT_GBR888_1X24/YUV444 format support
> > > > > > - use subdev active_state API
> > > > > > - replace own .get_fmt with v4l2_subdev_get_fmt
> > > > > > - remove unnecessary pad checks
> > > > > > - restructure tc358746_get_format_by_code() if-case
> > > > > > - move apply_dphy_config|apply_misc_config from resume intos s_stream
> > > > > > - use goto in s_stream enable case
> > > > > > - fix error handling in suspend/resume
> > > > > > - split probe() into more sub-functions
> > > > > > - use dev_dbg() for printing successful probe
> > > > > >
> > > > > >  drivers/media/i2c/Kconfig    |   17 +
> > > > > >  drivers/media/i2c/Makefile   |    1 +
> > > > > >  drivers/media/i2c/tc358746.c | 1682 ++++++++++++++++++++++++++++++++++
<snip>
> > > > > > +
> > > > > > +     sensor = media_entity_to_v4l2_subdev(link->source->entity);
> > > > > > +     sensor_pclk_rate = v4l2_get_link_freq(sensor->ctrl_handler, 0, 0);
> > > > >
> > > > > Shouldn't you set the last two arguments to non-zero values, to support
> > > > > sources that only implement the V4L2_CID_PIXEL_RATE control ?
> > > >
> > > > Nope, I don't wanna support PIXEL_RATE right now. This can be changed
> > > > later I think.
> > >
> > > Would it be hard to support it already, given that the
> > > v4l2_get_link_freq() should make it easier ? That would avoid having to
> > > come back to this code later.
> >
> > I had the pixel-rate first, then Jacobo mentioned (correctly) that my
> > usage of pixel-rate was wrong. Supporting PIXEL_RATE as well would add
> > more complexity because we need to take core of the mbus format to get
> > the correct mul/div settings.
>
> That's right, but the required information could be stored in the
> tc358746_format structure, can't it ?
>
> > Also I think that only a few drivers
> > implementing the PIXEL_RATE correctly in case of parallel sensors _and_
> > this is just a fallback which will print a warning if triggered. All I
> > want to do here is: "give me the link frequence" :) If there are drivers
> > not supporting this but support PIXEL_RATE it shouldn't be that hard for
> > those driver to add the LINK_FREQ ctrl. This would also improve the
> > kernel quality since there are now heuristics and no warnings printed.
> >
> > Is it okay, to keep it simple and just go with LINK_FREQ. for now?
>
> OK, I won't insist much.
>
> > > > > I'd also name the variable source_link_freq, as it may not be a sensor,
> > > > > and it's a link frequency, not a pixel clock rate.
> > > >
> > > > In parallel case (which is the only supported right now) the pclk is the
> > > > link_freq. but I can change it of course.
> > >
> > > I read "pclk" as "pixel clock". That makes me think of
> > > V4L2_CID_PIXEL_RATE, which indicates the number of pixels per second.
> > > With YUV 4:2:2 2X8 media bus formats, the link frequency will be twice
> > > the pixel rate.
> >
> > Hm.. the link frequency is the frequency on the physical parallel bus,
> > as far as I understood the ctrl. In parallel use-case this is pixelclk.
> >
> > Also according PIXEL_RATE documentation, it is defined as
> > pixel-per-second. For YUV 4:2:2 those this mean mean:
> >  - y1 == 1st pixel,
> >  - u1 == 2nd pixel,
> >  - y2 == 3rd pixel,
> >  - ...
>
> YUYV8_2X8 transfers Y0, U0, Y1, V0, Y2, U2, Y3, V2, ... You need two
> cycles per pixel. That's why sensor_pclk_rate can be misleading, as it
> may refer to the sensor pixel sampling clock, or the parallel bus clock,
> and those two are different. It's just a variable naming issue to avoid
> confusion.
>
> > All I want is to get the rate/frequency of the physical bus from the
> > input device :) According my above explanation, could we please go with
> > "the LINK_FREQ ctrl only" since this would avoid possible kernel
> > warnings and is the most accurate one.

This is a bridge, so surely PIXEL_RATE is a property and control on
the source to the bridge, not on the bridge itself.
PIXEL_RATE isn't going to tell you much without HBLANK and VBLANK as
well, and those also belong to the source.

LINK_FREQ is a property that is only relevant for the output of the
bridge, and therefore it makes sense to be a control on the bridge (it
can't be represented elsewhere).

Just my 2p.
  Dave
