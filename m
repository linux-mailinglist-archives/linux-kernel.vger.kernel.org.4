Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019276C2023
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCTSk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCTSji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:39:38 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE2B758
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:31:26 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id c10so4172242vsh.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1679337080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8NUhFi8oXVF/qnUu7VGuWdFAEzRgJeUjsSw2QycpwDg=;
        b=Wuip40872JJqIizd5zEJFNll336M1aeiMEQHs24WbLaGf+5Yk2u77RmJdv2JmmM2pD
         UoGKYUUXOh4XAhdy5QNkFqJH1aqy6l7LvU4QdV5Tm/6lWAZMzHj2I2qcBVD3f5fTLHJc
         fALHjNhCRud3uGMM75p1JfJQqbIJrbNPuTj3L1BH0gC3JlLvsv61EPExnpkO8x4UML59
         TBZpKty0CwHsKVQcpGhq4B8qJ1F2xw/lPZ0OZxS7Q9ySANvvnfj6UDuUyLGtLbs+uFZw
         mu/cFFoPo/TgjFy2vn4v1x8drrWEL04w6lGroTMvKoTlmYpdDlncIqC2L8w/idKY/vdx
         4Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679337080;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NUhFi8oXVF/qnUu7VGuWdFAEzRgJeUjsSw2QycpwDg=;
        b=UG4Qy5tVvbRcqLLr5+K0lxBTS9GV1wxHIrfGhccaCp+ONPlm/2C8acyrpm22yxy60F
         y3e2NZ0Nx3mP3O3MScMFe8G0DX04lYeztIT3WKgsHQzlRZ0nZJwbqlKBXbkBBlcCpRRG
         X6iy/Fe7I+BUQ733rFh5FvxKpt0GzGVgxppQtDBG4VpZdyj4kYoiH4XoWjpcBGSGu51k
         u+rx/eS9Z7lzgICbol3nx0xp88rJF/lZTxmgOz+fSOnS/e9u9GlzMSornGBG2I4RfFHW
         RGAwTJ7VwXdvGA3Y3gGpzol8GQd87iLU5OzDAXKgLZo6Qoz+naz/Ar6cJjkHF/R/9hQw
         dWNg==
X-Gm-Message-State: AO0yUKVQpf7UjeLpjZrdKLwPumHOvShYRgowOIoeq6YovWkiI7KHyY/b
        FoLU1e4BQB8ddKWULiGv4SbpPzxeEEQzuPP8kBVl6g==
X-Google-Smtp-Source: AK7set8QDN4JpK48l8vyrE3uVC4kf0s1ISeE3k4SMb6KZlzFXeEauV8iuprYA8CtSVg7T+jFeKhCvPeHg2MCeuON88M=
X-Received: by 2002:a05:6102:571b:b0:426:6d5:a55a with SMTP id
 dg27-20020a056102571b00b0042606d5a55amr5400175vsb.1.1679337080074; Mon, 20
 Mar 2023 11:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZBBpUAhis8L5Dtuz@francesco-nb.int.toradex.com>
 <ZBBsgW75Gc2FmuQ0@valkosipuli.retiisi.eu> <ZBBvmjUZIn/g0/Nv@francesco-nb.int.toradex.com>
 <20230320084844.tdjiv6kaxcosiwm2@uno.localdomain> <ZBggtBU1TjlvVNCS@kekkonen.localdomain>
 <20230320092602.GE20234@pendragon.ideasonboard.com> <ZBgpXRtXcxg14OGv@kekkonen.localdomain>
 <20230320095514.GF20234@pendragon.ideasonboard.com> <ZBgyOPS23BC2wAfg@kekkonen.localdomain>
 <727949a9c3d9e639b046bcd86635796452b10300.camel@pengutronix.de> <20230320140012.GB9535@pendragon.ideasonboard.com>
In-Reply-To: <20230320140012.GB9535@pendragon.ideasonboard.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 20 Mar 2023 18:31:04 +0000
Message-ID: <CAPY8ntCnX9uFbyfKnJCH6+8yLWwX1ZieYqzZq6qs9uvAPh9Eyw@mail.gmail.com>
Subject: Re: [PATCH v2] media: i2c: ov5640: Implement get_mbus_config
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-media@vger.kernel.org, kernel@pengutronix.de,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Marco Felsch <m.felsch@pengutronix.de>
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

On Mon, 20 Mar 2023 at 14:00, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Mar 20, 2023 at 02:32:25PM +0100, Philipp Zabel wrote:
> > On Mo, 2023-03-20 at 12:15 +0200, Sakari Ailus wrote:
> > > On Mon, Mar 20, 2023 at 11:55:14AM +0200, Laurent Pinchart wrote:
> > > > On Mon, Mar 20, 2023 at 11:37:33AM +0200, Sakari Ailus wrote:
> > > > > On Mon, Mar 20, 2023 at 11:26:02AM +0200, Laurent Pinchart wrote:
> > > > > > In a (simplified) nutshell,
> > > > > >
> > > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > > > > Camera | --> | CSI-2 RX | --> | CSI2IPU | --> | Mux | --> | IPU |
> > > > > > > Sensor |     |          |     | Gasket  |     |     |     |     |
> > > > > > ---------+     +----------+     +---------+     +-----+     +-----+
> > > > >
> > > > > Thank you, this is helpful.
> > > > >
> > > > > I suppose the mux here at least won't actively do anything to the data. So
> > > > > presumably its endpoint won't contain the active configuration, but its
> > > > > superset.
> > > > >
> > > > > >
> > > > > > All those blocks, except for the gasket, have a node in DT.
> > > > > >
> > > > > > The IPU driver needs to know the number of CSI-2 data lanes, which is
> > > > > > encoded in the data-lanes DT property present in both the sensor output
> > > > > > endpoint and the CSI-2 RX input endpoint, but not the other endpoints in
> > > > > > the pipeline.
> > > > >
> > > > > This doesn't yet explain why the sensor would need to implement
> > > > > get_mbus_config if its bus configuration remains constant.
> > > >
> > > > If I recall correctly, the IPU driver calls .g_mbus_config() on the
> > > > camera sensor to get the number of lanes, as it can't get it from its
> > > > own endpoint. That's a hack, and as Jacopo proposed, calling
> > > > .g_mbus_config() on the CSI-2 RX would be better, as the CSI-2 RX driver
> > > > can then get the value from its own endpoint, without requiring all
> > > > sensor drivers to implement .g_mbus_config().
> > >
> > > The g_mbus_config op could be implemented by the CSI2IPU and mux, by simply
> > > requesting the information from the upstream sub-device. No hacks would be
> > > needed.
> >
> > I think implementing get_mbus_config on the mux might be enough. The
> > IPU driver already recognizes the CSI-2 RX by its grp_id and could
> > infer that it has to use MIPI CSI-2 mode from that.
> >
> > The video-mux would have to forward get_mbus_config to its active
> > upstream port and if the upstream sensor does not implement it read bus
> > width from the active upstream endpoint.
>
> I'm fine with implementing it in the mux as well, but I think we can
> take a shortcut here and call it on the CSI-2 RX from the IPU driver, as
> the IPU driver knows about the architecture of the whole pipeline.

FWIW I have made use of video-mux and implementing g_mbus_config on it
for D-PHY switch chips[1] where the different input ports may have
different configurations. I'll admit that I've made the easy
assumption that it's CSI-2 D-PHY in and out, when it could quite
legitimately be working with any of the other bus types.

I had been intending to send this[2] upstream when I get a chance, but
am I reading imx6q.dtsi[3] correctly in that the mux is accepting
parallel on some ports and CSI-2 on others? The mux hardware is
therefore far more than just a simple switch between inputs? Although
as this is after the CSI2 rx block, this is effectively parallel data
within the SoC, therefore is the configuration and get_mbus_config
really relevant?
I'd like to understand how this is being used on imx6 before trying to
rework my patch into a generic solution.

Thanks
  Dave

[1] eg Arducam's 2 and 4 port muxes -
https://www.arducam.com/product-category/camera-multiplexers/, which
IIRC use OnSemi's FSA644
https://www.onsemi.com/products/interfaces/analog-switches/fsa644
[2] https://github.com/raspberrypi/linux/commit/bf653318475cf4db0ec59e92139f477f7cc0a544
[3] https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/imx6q.dtsi#L349
