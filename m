Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D063C743
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiK2ShX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiK2ShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:37:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729A25C0D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:37:20 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 675F34E6;
        Tue, 29 Nov 2022 19:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669747038;
        bh=3C282rs/M6cufMmFfreJo8WgpZ1XT79xEF6JkXEVIyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FgWj6JiSG3T7+Ibw4+2mMAFWesaGtmwnKq2dIILWeB9WCJ6AYhqSpVt/6DsE/STvp
         Mfwm38iXFg51VJhaL5cjRsQoK/YxUDhoZKlpxUm1AqaUhwsM4WWw7LsG2I5udQ4sw3
         TUeo+XK20rcY+u9QRKqC0ChbV+lhvdosB5WUxkIo=
Date:   Tue, 29 Nov 2022 20:37:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     =?utf-8?B?SsO2cmc=?= Quinten <abugsworstnightmare@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 3/7] media: uapi: add MEDIA_BUS_FMT_BGR666_1X24_CPADHI
Message-ID: <Y4ZRTjeoMbKnDP3u@pendragon.ideasonboard.com>
References: <20221013-rpi-dpi-improvements-v2-0-7691903fb9c8@cerno.tech>
 <20221013-rpi-dpi-improvements-v2-3-7691903fb9c8@cerno.tech>
 <Y4X9KY5ZqRUOGnJE@pendragon.ideasonboard.com>
 <CACfkkaMX8jVU1OJNCwYKWWHRuXpAXNauZ8OvZs6d1ty24K+8kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACfkkaMX8jVU1OJNCwYKWWHRuXpAXNauZ8OvZs6d1ty24K+8kA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,

On Tue, Nov 29, 2022 at 03:52:45PM +0100, Jörg Quinten wrote:
> Hi Laurent,
> 
> looks like linux/Documentation/userspace-api/media/v4l/subdev-formats.rst
> doesn't correlate at all to the arrangement and numbering in
> linux/include/uapi/linux/media-bus-format.h .

Looking at the RGB group in include/uapi/linux/media-bus-format.h in the
mainline kernel, if you exclude the LVDS formats that are documented
separately, and the MEDIA_BUS_FMT_RGB888_3X8_DELTA format that appears
to be undocumented, the formats are ordered in the same way as in
subdev-formats.rst (see
https://linuxtv.org/downloads/v4l-dvb-apis/userspace-api/v4l/subdev-formats.html#v4l2-mbus-pixelcode for an HTML version).

> Which sources do you want me to check?
> 
> Looking at https://github.com/raspberrypi/linux/tree/rpi-6.1.y btw.
> 
> Rgds
> Joerg
> 
> 
> 
> 
> Am Di., 29. Nov. 2022 um 13:38 Uhr schrieb Laurent Pinchart <
> laurent.pinchart@ideasonboard.com>:
> 
> > Hi Maxime and Joerg,
> >
> > Thank you for the patch.
> >
> > On Thu, Oct 20, 2022 at 10:30:47AM +0200, Maxime Ripard wrote:
> > > From: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> > >
> > > Add the BGR666 format MEDIA_BUS_FMT_BGR666_1X24_CPADHI supported by the
> > > RaspberryPi.
> > >
> > > Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > ---
> > >  .../userspace-api/media/v4l/subdev-formats.rst     | 37
> > ++++++++++++++++++++++
> > >  include/uapi/linux/media-bus-format.h              |  3 +-
> > >  2 files changed, 39 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst
> > b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> > > index 68f8d7d37984..604a30e2f890 100644
> > > --- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
> > > +++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> > > @@ -1023,6 +1023,43 @@ The following tables list existing packed RGB
> > formats.
> > >        - g\ :sub:`2`
> > >        - g\ :sub:`1`
> > >        - g\ :sub:`0`
> > > +    * .. _MEDIA-BUS-FMT-BGR666-1X24_CPADHI:
> >
> > I would move this just below MEDIA_BUS_FMT_RGB565_1X24_CPADHI. Actually,
> > could you check 1/7 and 2/7 to make sure the formats are sorted in the
> > documentation in the same order as in the header ?
> >
> > > +
> > > +      - MEDIA_BUS_FMT_BGR666_1X24_CPADHI
> > > +      - 0x1024
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      -
> > > +      - 0
> > > +      - 0
> > > +      - b\ :sub:`5`
> > > +      - b\ :sub:`4`
> > > +      - b\ :sub:`3`
> > > +      - b\ :sub:`2`
> > > +      - b\ :sub:`1`
> > > +      - b\ :sub:`0`
> > > +      - 0
> > > +      - 0
> > > +      - g\ :sub:`5`
> > > +      - g\ :sub:`4`
> > > +      - g\ :sub:`3`
> > > +      - g\ :sub:`2`
> > > +      - g\ :sub:`1`
> > > +      - g\ :sub:`0`
> > > +      - 0
> > > +      - 0
> > > +      - r\ :sub:`5`
> > > +      - r\ :sub:`4`
> > > +      - r\ :sub:`3`
> > > +      - r\ :sub:`2`
> > > +      - r\ :sub:`1`
> > > +      - r\ :sub:`0`
> > >      * .. _MEDIA-BUS-FMT-RGB565-1X24_CPADHI:
> > >
> > >        - MEDIA_BUS_FMT_RGB565_1X24_CPADHI
> > > diff --git a/include/uapi/linux/media-bus-format.h
> > b/include/uapi/linux/media-bus-format.h
> > > index 2ee0b38c0a71..d4228d038b54 100644
> > > --- a/include/uapi/linux/media-bus-format.h
> > > +++ b/include/uapi/linux/media-bus-format.h
> > > @@ -34,7 +34,7 @@
> > >
> > >  #define MEDIA_BUS_FMT_FIXED                  0x0001
> > >
> > > -/* RGB - next is     0x1024 */
> > > +/* RGB - next is     0x1025 */
> > >  #define MEDIA_BUS_FMT_RGB444_1X12            0x1016
> > >  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE    0x1001
> > >  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE    0x1002
> > > @@ -49,6 +49,7 @@
> > >  #define MEDIA_BUS_FMT_BGR666_1X18            0x1023
> > >  #define MEDIA_BUS_FMT_RGB666_1X18            0x1009
> > >  #define MEDIA_BUS_FMT_RBG888_1X24            0x100e
> > > +#define MEDIA_BUS_FMT_BGR666_1X24_CPADHI     0x1024
> > >  #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI     0x1015
> > >  #define MEDIA_BUS_FMT_RGB666_1X7X3_SPWG              0x1010
> > >  #define MEDIA_BUS_FMT_BGR888_1X24            0x1013
> > >

-- 
Regards,

Laurent Pinchart
