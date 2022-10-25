Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D40F60C2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJYFCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJYFCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:02:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1C383061;
        Mon, 24 Oct 2022 22:02:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ud5so6166841ejc.4;
        Mon, 24 Oct 2022 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdxBLNzeJXsLg4JPPQOp9WmP0XzX3jm+VBFzQsBEwu8=;
        b=ZH1Av+781KKvjoXRQNesJgXbfiJS3TrOv3jGtMkFEom3W58VHecGcVB82utVr409/K
         3jN78yr6nFMc7gCvPflM89MvTG03mCJPQvy38XW6ry1t1fjxX8QFqWRCxgFD6/KdvCvA
         gIdHl9u8m+Ja6iZs5xFhDq1UOynBX9P9TwfZzqHZpbit/sRiBHTrpLqntfsWF3QC3Cnz
         p9JPbB///VEgS7w0JmXWhdpx23fBgx5IPNSVvG3kadBIO7+FOCJ+9Gr1O2k/xd4qvj0d
         y2Zjqx2EXBm2uIFk9vQ12kDs8PH/Up0X5ljKYqsACb/huPMz6N1ByKKemdqJGtvooo3J
         X7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdxBLNzeJXsLg4JPPQOp9WmP0XzX3jm+VBFzQsBEwu8=;
        b=5j0N5BwBKZXVvczgQ6ro+MIBXVW8AS9O0DV8rCUdWXutcUaYnl4poL6cqEjYs5oIon
         44I0oiWr59LXfvLx2nf7Y9R7tu79TAneX2xKHKOtMuCAM+FeU5dMkAMlbIPeYBXpvMO8
         VJVgN1/XZJ4dVPFSfvEl+4F58aLYi81A5EfuuD9K5yYCVS9Ic3vMwl0Jw9dAbH39Rvz/
         SUDLgZ+3txBxwFkk1ISL/E1ZCIuPf4TbZer4WJ8byLEzQ0rc62gte7JUGWmRjMixGkcK
         uHYvDl/2iAFwDHDRHlUl9+n+4qRYhAp1QixpYrklA4mgmyr8MGkC1hZd+K0I+llrTNNs
         yMwg==
X-Gm-Message-State: ACrzQf1yiCG9ul+00WbW1/7vwjcGDyZNFm3mi0dGKj45WgobjLJGnNlV
        BUwtTrP0O0yYkeFaLX1VK4nY04twDcx/jg==
X-Google-Smtp-Source: AMsMyM6f6O6P2agNUV8uPOTJvBphd3OgsKm+lyd13PR+wFtgsQ4fr6n5UbtP65RuOg0fjWCZI3PLsA==
X-Received: by 2002:a17:907:ea7:b0:78f:4ae:965c with SMTP id ho39-20020a1709070ea700b0078f04ae965cmr30535593ejc.127.1666674121468;
        Mon, 24 Oct 2022 22:02:01 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id l19-20020a056402345300b00458898fe90asm919332edc.5.2022.10.24.22.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:02:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 0/6] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / ISP Driver
Date:   Tue, 25 Oct 2022 07:01:59 +0200
Message-ID: <4776447.31r3eYUQgx@jernej-laptop>
In-Reply-To: <Y1KpQl5Nlhd0kKId@aptenodytes>
References: <20220924153304.77598-1-paul.kocialkowski@bootlin.com> <Y1KpQl5Nlhd0kKId@aptenodytes>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Dne petek, 21. oktober 2022 ob 16:14:26 CEST je Paul Kocialkowski napisal(a):
> Hi,
> 
> On Sat 24 Sep 22, 17:32, Paul Kocialkowski wrote:
> > This part only concerns the introduction of the new ISP driver and related
> > adaptation of the CSI driver.
> 
> I don't think there is any significant issue preventing this series from
> being merged in Linux 6.2 at this point.
> 
> Could we move forward on it? It's been around for quite some time now.

While I'm no expert in ISP drivers, I can take a look (for other series too) 
this week.

Could you attach output of v4l2-complience output (for both)?

Best regards,
Jernej

> 
> Thanks!
> 
> Paul
> 
> > Most non-dt patches still need reviewing but should be pretty
> > straightforward. Since this multi-part series has been going on for a
> > while, it would be great to see it merged soon!
> > 
> > Changes since v6:
> > - Added a per-compatible check for the required port in dt binding;
> > - Reworded ISP output port description in dt binding;
> > - Reversed ISP detection order to have fwnode first;
> > - Removed info print when ISP link is detected;
> > - Added warn print when ISP is linked but not enabled in config;
> > - Fixed sun6i_csi_isp_detect return type;
> > - Removed useless initialization in sun6i_csi_isp_detect;
> > - Fixed typo in sun6i_csi_isp_detect;
> > - Added collected tags;
> > 
> > Changes since v5:
> > - Rebased on latest media tree;
> > - Added collected tag;
> > - Switched to using media_pad_remote_pad_first;
> > - Switched to using media_pad_remote_pad_unique.
> > 
> > Changes since v4:
> > - Fixed device-tree binding indent-align;
> > - Added collected tag;
> > - Rebased on latest media tree;
> > 
> > Changes since v3:
> > - Removed the v4l2 controls handler from the driver;
> > - Added variant structure for table sizes;
> > - Removed the info message about video device registration;
> > - Removed comments in uAPI header;
> > - Used '/schemas/graph.yaml#/properties/port' whenever possible in
> > bindings; - Added CSI patches dependent on the ISP driver;
> > - Rebased on the latest media tree;
> > 
> > Changes since all-in-one v2:
> > - Updated Kconfig to follow the latest media-wide changes;
> > - Reworked async subdev handling with a dedicated structure holding the
> > 
> >   corresponding source to avoid matching in the driver;
> > 
> > - Switched to clock-managed regmap mmio;
> > - Used helper to get a single enabled link for an entity's pad, to replace
> > 
> >   source selection at link_validate time and select the remote source at
> >   stream on time instead;
> > 
> > - Added mutex for mbus format serialization;
> > - Used endpoint-base instead of video-interface for "internal" endpoints
> > 
> >   in device-tree schema;
> > 
> > - Added TODO with unstaging requirements;
> > - Various cosmetic cleanups;
> > - Updated copyright years;
> > 
> > Paul Kocialkowski (6):
> >   dt-bindings: media: Add Allwinner A31 ISP bindings documentation
> >   dt-bindings: media: sun6i-a31-csi: Add internal output port to the ISP
> >   staging: media: Add support for the Allwinner A31 ISP
> >   MAINTAINERS: Add entry for the Allwinner A31 ISP driver
> >   media: sun6i-csi: Detect the availability of the ISP
> >   media: sun6i-csi: Add support for hooking to the isp devices
> >  
> >  .../media/allwinner,sun6i-a31-csi.yaml        |   4 +
> >  .../media/allwinner,sun6i-a31-isp.yaml        | 101 +++
> >  MAINTAINERS                                   |   9 +
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  75 +-
> >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  10 +
> >  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  32 +-
> >  .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  19 +-
> >  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   1 +
> >  drivers/staging/media/sunxi/Kconfig           |   1 +
> >  drivers/staging/media/sunxi/Makefile          |   1 +
> >  drivers/staging/media/sunxi/sun6i-isp/Kconfig |  15 +
> >  .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
> >  .../staging/media/sunxi/sun6i-isp/TODO.txt    |   6 +
> >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 555 +++++++++++++
> >  .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  90 +++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 742 ++++++++++++++++++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 566 +++++++++++++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 577 ++++++++++++++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  66 ++
> >  .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
> >  .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
> >  23 files changed, 3309 insertions(+), 13 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/media/allwinner,sun6i-a31-isp.yaml
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/TODO.txt
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
> >  create mode 100644
> >  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c create mode
> >  100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.h create
> >  mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
> >  create mode 100644
> >  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h create mode
> >  100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c create
> >  mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
> >  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
> >  create mode 100644
> >  drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h




