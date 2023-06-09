Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636EC7295FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241875AbjFIJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjFIJyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:54:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB20768F;
        Fri,  9 Jun 2023 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686303947; x=1717839947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sdk4GfKmT+9A6cNv+r44G3DJaK2ahYk6wc3iwdcCzMY=;
  b=GBsYEuWPPQNpTOXZKnF6YbH0cCn0ac0ZL9tenRpjfMrwZO90TI1v+iZV
   5uZAo9HnpngZ3x3bDFmWxYPhLEOfSO1OUliSugbkx/ZtfHbW8t7e6s8z/
   rpDa5+vugiAvE7XPvfE9MOCBW3XM3z+Gvkgo3mvGRrYU5ghspXuYuVwaP
   +masI3Ww4FkIk71w9SGBrE3RBjhPMkQYxt0jzKZSLC7aVlAOa74vlrXsR
   PK7Whk6A6Lb2iEaMVCcMOvDEk0kAIzbajUuvHfm8Mn+Ejo9RlFzPYC92i
   R0+rvynLOaChiDhEaLE0dWWnIZoIm9r7NS/joh3/5YtGWLjVXgtCEB7dj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355052559"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="355052559"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="834581685"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="834581685"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:44:21 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id E125511F9D2;
        Fri,  9 Jun 2023 12:44:18 +0300 (EEST)
Date:   Fri, 9 Jun 2023 09:44:18 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIL0ctohCl5181gJ@kekkonen.localdomain>
References: <20230608083127.545750-1-tomm.merciai@gmail.com>
 <20230608083127.545750-3-tomm.merciai@gmail.com>
 <ZILkSEllSfSGD8XK@kekkonen.localdomain>
 <ZILzvMBCXfde3COF@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZILzvMBCXfde3COF@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Fri, Jun 09, 2023 at 11:41:16AM +0200, Tommaso Merciai wrote:
> Hi Sakari,
> Thanks for your feedback.
> 
> On Fri, Jun 09, 2023 at 08:35:20AM +0000, Sakari Ailus wrote:
> > Hi Tommaso,
> > 
> > On Thu, Jun 08, 2023 at 10:31:15AM +0200, Tommaso Merciai wrote:
> > > Add documentation of device tree in YAML schema for the ALVIUM
> > > Camera from Allied Vision Inc.
> > > 
> > > References:
> > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > 
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > Changes since v1:
> > >  - Fixed build error as suggested by RHerring bot
> > > 
> > > Changes since v2:
> > >  - Fixed License as suggested by KKozlowski/CDooley
> > >  - Removed rotation property as suggested by CDooley/LPinchart
> > >  - Fixed example node name as suggested by CDooley
> > >  - Fixed title as suggested by LPinchart
> > >  - Fixed compatible name as suggested by LPinchart
> > >  - Removed clock as suggested by LPinchart
> > >  - Removed gpios not as suggested by LPinchart
> > >  - Renamed property name streamon-delay into alliedvision,lp2hs-delay-us
> > >  - Fixed vendor prefix, unit append as suggested by KKozlowski
> > >  - Fixed data-lanes
> > >  - Fixed blank space + example indentation (from 6 -> 4 space) as suggested by KKozlowski
> > >  - Dropped status into example  as suggested by KKozlowski
> > >  - Added vcc-ext-in supply as suggested by LPinchart
> > >  - Dropped pinctrl into example as suggested by LPinchart
> > > 
> > > Changes since v3:
> > >  - Fixed vcc-ext-in-supply description as suggested by LPinchart
> > >  - Fixed alliedvision,lp2hs-delay-us description as suggested by LPinchart
> > >  - Added maximum to alliedvision,lp2hs-delay-us as suggested by LPinchart
> > >  - Collected Reviewed-by tag from LPinchart
> > > 
> > > Changes since v4:
> > >  - Fixed id as reported by RHerring bot and LPinchart
> > >  - Add minimum into alliedvision,lp2hs-delay-us as suggested by CDooley
> > >  - Tested using make dt_binding_check DT_SCHEMA_FILES=alliedvision,alvium-csi2.yaml
> > > 
> > >  .../media/i2c/alliedvision,alvium-csi2.yaml   | 97 +++++++++++++++++++
> > >  1 file changed, 97 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > > new file mode 100644
> > > index 000000000000..c771e5039641
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > > @@ -0,0 +1,97 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/i2c/alliedvision,alvium-csi2.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Allied Vision Alvium Camera
> > > +
> > > +maintainers:
> > > +  - Tommaso Merciai <tomm.merciai@gmail.com>
> > > +  - Martin Hecht <martin.hecht@avnet.eu>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: alliedvision,alvium-csi2
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vcc-ext-in-supply:
> > > +    description: |
> > > +      The regulator that supplies power to the VCC_EXT_IN pins.
> > > +
> > > +  alliedvision,lp2hs-delay-us:
> > > +    minimum: 1
> > > +    maximum: 150000
> > > +    description: |
> > > +      Low power to high speed delay time.
> > > +
> > > +      If the value is larger than 0, the camera forces a reset of all
> > > +      D-PHY lanes for the duration specified by this property. All lanes
> > > +      will transition to the low-power state and back to the high-speed
> > > +      state after the delay. Otherwise the lanes will transition to and
> > > +      remain in the high-speed state immediately after power on.
> > > +
> > > +      This is meant to help CSI-2 receivers synchronizing their D-PHY
> > > +      RX.
> > 
> > Why do you need this? D-PHY TX is obviously controlled by the driver.
> > Explicit control of PHY initialisation is of course best option when
> > combined with some receivers, done via driver's pre_streamon and s_stream
> > callbacks. Can't your hardware do that?
> 
> You mean calculate this time in some dynamical way and program this
> during pre_streamon or s_stream?
> 
> If yes, unfortunately hw can't do this.

This shouldn't be based on timing but rather progress of the bus
initialisation sequence. That's how it works on most sensors nowadays.

The description is also lacking details on what delay this exactly is. What
is the bus state during that delay?

-- 
Regards,

Sakari Ailus
