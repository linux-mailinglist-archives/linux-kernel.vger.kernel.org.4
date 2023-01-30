Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BD5681CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjA3VjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjA3VjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:39:13 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24354CA26;
        Mon, 30 Jan 2023 13:39:07 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id e21-20020a9d5615000000b006884e5dce99so4939332oti.5;
        Mon, 30 Jan 2023 13:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL/Sa/O/0qzbTgqvZA3y8OHGpThnTm0XwAphUFZl/lg=;
        b=TYz47oQL4XHMgwjXfDr2LkGzQ65Dayvkn+jrIkSUVwCT/SZKjj4f0SYkbpyNJmnkoC
         aqrL2FbcXpH3h98+WpSC4LWiFGrfz7Ry+SgCw37ZLBScbelL6INFdlke90uQhDxecMHx
         S0+0SYOI+klpaY80PV4Sx0kjeSF1huI23GjmlGtucpy0pxFjL/8RlfU0OvOEHW8mUGSF
         /RVR8hm99ff0soLQdGpL5FnnCbE+FQyJ5PooN6Jc0EnypOeBrrAPaYF9+ori68m1Mhs/
         tFksTTQ62qsDm1vJplY9ek17m1U62FiMvDF0xwybYMtd3jDTJH+Aa1AbsERLFCPXW69r
         tHtw==
X-Gm-Message-State: AO0yUKXZbtzvjWYu1f0Yfz79GMPMHFV8lB7XMOZn542wjwOpeRLp8bT9
        zlYjN3fVCsAJxVCNF0VWdw==
X-Google-Smtp-Source: AK7set/uccH7JTyE212LtTiDDrvQkFVU8TeUda5c03Xe15eIlmEojgcuEnr3VivOzcP4k0dxjP7f3g==
X-Received: by 2002:a05:6830:2091:b0:686:56c6:34bd with SMTP id y17-20020a056830209100b0068656c634bdmr4701652otq.14.1675114746291;
        Mon, 30 Jan 2023 13:39:06 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w8-20020a9d5388000000b0068bbb73006bsm3642958otg.47.2023.01.30.13.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:39:05 -0800 (PST)
Received: (nullmailer pid 3575008 invoked by uid 1000);
        Mon, 30 Jan 2023 21:39:04 -0000
Date:   Mon, 30 Jan 2023 15:39:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: Add NXP i.MX93
 parallel display format configuration
Message-ID: <20230130213904.GA3569183-robh@kernel.org>
References: <20230128034713.1530218-1-victor.liu@nxp.com>
 <20230128034713.1530218-2-victor.liu@nxp.com>
 <3c07b9bd-1981-2945-9efe-80afb0195de8@linaro.org>
 <87d6f54c4695330064eda295e258a0a5c3bc48f8.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d6f54c4695330064eda295e258a0a5c3bc48f8.camel@nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 04:39:05PM +0800, Liu Ying wrote:
> On Sun, 2023-01-29 at 12:46 +0100, Krzysztof Kozlowski wrote:
> > On 28/01/2023 04:47, Liu Ying wrote:
> > > NXP i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register
> > > which
> > > configures parallel display format by using the
> > > "PARALLEL_DISP_FORMAT"
> > > field. Add device tree bindings for the display format
> > > configuration.
> > > 
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > ---
> > >  .../display/bridge/nxp,imx93-pdfc.yaml        | 78
> > > +++++++++++++++++++
> > >  1 file changed, 78 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/display/bridge/nxp,imx93-
> > > pdfc.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/bridge/nxp,imx93-
> > > pdfc.yaml
> > > b/Documentation/devicetree/bindings/display/bridge/nxp,imx93-
> > > pdfc.yaml
> > > new file mode 100644
> > > index 000000000000..a84bfb46b01d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/nxp,imx93-
> > > pdfc.yaml
> > > @@ -0,0 +1,78 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: 
> > > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fdisplay%2Fbridge%2Fnxp%2Cimx93-pdfc.yaml%23&data=05%7C01%7Cvictor.liu%40nxp.com%7C7fb1b69849974435787008db01ee832c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638105896131701918%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=kkX5B45NTsmDKKzxjOiE6MaE4zkMVbMe4ILammVSwMc%3D&reserved=0
> > > +$schema: 
> > > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=05%7C01%7Cvictor.liu%40nxp.com%7C7fb1b69849974435787008db01ee832c%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638105896131701918%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=vIVpdEjIo6H3V8T7iTbDwz4Bmn0d%2BQB4BCJNJ0OzKJw%3D&reserved=0
> > > +
> > > +title: NXP i.MX93 Parallel Display Format Configuration
> > > +
> > > +maintainers:
> > > +  - Liu Ying <victor.liu@nxp.com>
> > > +
> > > +description: |
> > > +  The i.MX93 mediamix blk-ctrl contains one DISPLAY_MUX register
> > > which
> > > +  configures parallel display format by using the
> > > "PARALLEL_DISP_FORMAT"
> > > +  field.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: nxp,imx93-pdfc
> > 
> > 
> > Based on description, I have doubts this is a separate bridge device.
> > Why this is not part of display driver/bindings?
> 
> The relevant display controller in i.MX93 SoC is LCDIF. From hardware
> design PoV, the parallel display format configuration logic is not a
> part of LCDIF. Instead, it's a part of i.MX93 mediamix blk-ctrl. The
> blk-ctrl includes controls for miscellaneous devices with small logics,
> like this parallel display format configuration, LVDS Display
> Bridge(LDB, see fsl,ldb.yaml) and so on. The below pipeline describes
> data flow of a parallel display LCD panel:
> 
> DRAM -> LCDIF -> parallel display format configuration -> LCD panel
> 
> So, the parallel display format configuration appears to be a separate
> bridge.
> 
> > 
> > We do not create usually devices for single registers, because they
> > are
> > not a devices. Devices are a bit more complex - have some pin
> > inputs/outputs, not a register only. Of course there are exception,
> > but
> > this one does not look like one.
> 
> IMHO, this one is a standalone device although it is controlled by one
> single register. It's input pins connect to LCDIF and output pins
> connect to i.MX93 SoC's pins/pads.

Fair enough. It needs to be defined as part of the mediamix blkctrl 
schema though.

Rob
