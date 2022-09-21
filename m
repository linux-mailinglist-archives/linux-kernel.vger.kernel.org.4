Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCA5BFEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIUNQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiIUNQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:16:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906A88A1DD;
        Wed, 21 Sep 2022 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663766180; x=1695302180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w4D1hy6/ConbgVe3GY3+9RnenGbVC1tZcfM3biXtUBA=;
  b=LpXFeHgiyUjelKkCr2kJ2FfYkf+pu+NiexwTIKFd7EGazITVa9+LmOpn
   zUCxVEY+gkjmr2UVgBwDIweCu+TCNZ9xQ0FkjGSbXE94VoJAKkX//vW5l
   cLpjKKoiKX/JShzlLhus951wx2zi/JjoK5LjCrtI7wggzHp/wK7dlZfk7
   ZJejKX1DJR/60PsG+Dw1T4jHpa6oPpOQYtzSXgkV399cYdaXU3/hwsTlr
   jnM1VVOOEnEABlABnehPbgGRYd3oCLBL2ryBz2y2V3hr6Eg3eLEu7JppK
   /tOv4pG8XJC4YkdOG+grqme/7BcySTWwH1uMbplAGqbtHmeAXnxRvGgtY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300835484"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300835484"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 06:16:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="687865725"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 06:16:15 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id B42B22055A;
        Wed, 21 Sep 2022 16:16:13 +0300 (EEST)
Date:   Wed, 21 Sep 2022 13:16:13 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
Message-ID: <YysOnZt+yRGNw2CN@paasikivi.fi.intel.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <CAPY8ntCA3jbpBOiNfoft58sHPeTFSLoLop0VUmkOCWP3cX_rdw@mail.gmail.com>
 <87czbwp9xx.fsf@gmail.com>
 <YygOzWAHyoP+KwTv@paasikivi.fi.intel.com>
 <87wn9zreic.fsf@gmail.com>
 <YyhE5voxRz7gEYHY@paasikivi.fi.intel.com>
 <YyhzUvu0Ky8+VohC@pendragon.ideasonboard.com>
 <87leqdkcbm.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leqdkcbm.fsf@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Tue, Sep 20, 2022 at 11:31:01PM +0300, Mikhail Rudenko wrote:
> 
> Hi Laurent, Sakari,
> 
> On 2022-09-19 at 16:49 +03, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> 
> > Hello,
> >
> > On Mon, Sep 19, 2022 at 10:31:02AM +0000, Sakari Ailus wrote:
> >> On Mon, Sep 19, 2022 at 10:01:06AM +0300, Mikhail Rudenko wrote:
> >> > On 2022-09-19 at 06:40 GMT, Sakari Ailus wrote:
> >> > > On Fri, Sep 16, 2022 at 12:27:42AM +0300, Mikhail Rudenko wrote:
> >> > >> On 2022-09-14 at 10:58 +01, Dave Stevenson wrote:
> >> > >> > On Sun, 11 Sept 2022 at 21:02, Mikhail Rudenko wrote:
> >> > >> >>
> >> > >> >> Hello,
> >> > >> >>
> >> > >> >> this series implements support for Omnivision OV4689 image
> >> > >> >> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
> >> > >> >> megapixel image sensor. Ihis chip supports high frame rate speeds up
> >> > >> >> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
> >> > >> >> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> >> > >> >> connection.
> >> > >> >>
> >> > >> >> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
> >> > >> >> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
> >> > >> >> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera
> >> > >> >> module.
> >> > >> >> While porting the driver, I stumbled upon two issues:
> >> >
> >> > [snip]
> >> >
> >> > >> >> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
> >> > >> >> gain is not linear across that range. Instead, it is piecewise linear
> >> > >> >> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
> >> > >> >> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
> >> > >> >> with more linear segments in between. Rockchip's camera engine code
> >> > >> >> chooses one of the above segments depenging on the desired gain
> >> > >> >> value. The question is, how should we proceed keeping in mind
> >> > >> >> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
> >> > >> >> libcamera will do the mapping, or the driver will do the mapping
> >> > >> >> itself and expose some logical gain units not tied to the actual gain
> >> > >> >> register value? Meanwhile, this driver conservatively exposes only
> >> > >> >> 0x0-0xf8 gain register range.
> >> > >> >
> >> > >> > The datasheet linked above says "for the gain formula, please contact
> >> > >> > your local OmniVision FAE" :-(
> >> > >> > I would assume that the range is from 1x rather than 0x - people
> >> > >> > rarely want a totally black image that 0x would give. Or is it ranges
> >> > >> > of 1x - 2x, 2x - 4x, 4x - 8x, and 8x - 16x?
> >> > >>
> >> > >> A picture is worth a thousand words, so I've attached the results of my
> >> > >> experimentation with the gain register. They were obtained with Rockchip
> >> > >> 3399, with AEC, AGC and black level subtraction disabled. The image was
> >> > >> converted from 10-bit RGGB to 8-bit YUV 4:2:0 by the Rockchip ISP.
> >
> > Is that full or limited range YUV ?
> >
> >> > > Based on that it looks like their medication may have been a little too
> >> > > strong.
> >> > >
> >> > > Could this be implemented so that the control value would be linear linear
> >> > > but its range would correspond 1x--16x values?
> >> > >
> >> > > libcamera will be able to cope with that.
> >> >
> >> > According to the following fragment of the Rockchip camera engine sensor
> >> > configuration file for ov4689 [1]
> >> >
> >> >     <Linear index="1" type="double" size="[4 7]">
> >> >        [1 2 128 0 1 128 255
> >> >         2 4 64 -248 1 376 504
> >> >         4 8 32 -756 1 884 1012
> >> >         8 16 16 -1784 1 1912 2040]
> >> >     </Linear>,
> >> >
> >> > it uses gain register value range 128-255 for gain 1x-2x, 376-504 for
> >> > gain 2x-4x, 884-1024 for 4x-8x, and 1912-2040 for 8x-16x. Do you suggest
> >
> > That looks *really* weird. I would have understood [384, 511], [896,
> > 1023] and [1920, 2047], but not those intervals.
> >
> > The driver hardcodes bit 0x3503[2] to 1, which means "sensor gain
> > format". Maybe setting it to 0 ("real gain format") would produce saner
> > results ?
> >
> >> > to implement this calculation in the sensor driver and expose some
> >> > linear "logical" gain to userspace (ranging, e.g., 128-2048 for gains
> >> > 1x-16x)?
> >>
> >> Yes. This way the user space can somehow work without knowing this special
> >> implementation, even though the granularity changes over the range. I guess
> >> the granularity would need to be known in libcamera but that's a separate
> >> issue.
> >
> > I can live with that.
> 
> I got some fresh data regarding gain setting, with gain register value
> ranging from 0 to 4096, please check the attached plot. What is the best
> way to expose this to userspace in your opinion?

I know I requested this to be changed to be as linear as possible, but it
would seem that the gain values do not seem to match exactly what is
documented. So you'd need to experimentally find where you'd need to switch
the range and you might arrive at better values after the initial
implementation. There might be differences between units, too, and if there
were tuning values, you'd find this in sensor EEPROM.

Therefore I think this appears to fit less well for driver implementation.
I'm fine with exposing this to the user space as-is although it doesn't
make a great user space inteface. It's just a poor hardware implementation
but there's nothing we can do about it.

-- 
Kind regards,

Sakari Ailus
