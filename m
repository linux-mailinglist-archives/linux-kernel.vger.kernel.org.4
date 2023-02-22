Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18769FFAA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjBVXjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBVXjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:39:44 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91455FEA;
        Wed, 22 Feb 2023 15:39:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i10so1910881plr.9;
        Wed, 22 Feb 2023 15:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OTEdY8D3K+c7NVOVJW3QT3u26pZNUIP6ACrNCbW69s=;
        b=pVe/fkikWvouVy1IOchUQ0cUTjGsBGBlzLS6fZ7/aq7eSzmvdDtwnevpuvi+/CG/OU
         fY6D0pNuS1iHU2Jv4VKm5A9NLWYWTpqrKGcy+EGeMdXh4/IowmGl/OwHlyP3qeMOQqAm
         A5bAazhehCMOjUDegumobdOq3bMyC7bcH8LfvTLKqh1Ca78zHEF77TuRRW8KICS17HFE
         u+0H7RTe83eLK3Yi1Xh6CaS/5+8wIJLqlrMAoA0igyY8pqG7+yjFopqejqHfJQVNk9Tp
         LHe27SNwB7jgtzT8XY2a1bRoOaTEi8LfcKoUksq+WCatgLjUnMpveq8rO69mJ2WRZxrH
         h5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OTEdY8D3K+c7NVOVJW3QT3u26pZNUIP6ACrNCbW69s=;
        b=6B/sYxPVHtzj8wvtXrJ6sedKEB28yOaPO1jhbJhq3VgGOn1ipph/yXC8X7h9K0pp4i
         7/7V8PRWr8OL5N+kqToAgHQ8MF8Z8mzJlSZ53DOc16J7yz0asSJp935qJBE9K/EimdLe
         m5JqfYdMRQHRP6O2IiCQW7B3Bp32HVyNlNqfTJJPwF32TocRsIBKoVe7rdLPaPTeeIEN
         BaJ5+kAvvelGwbYrtyuKgtsPrBd0sHyGMfPNsT/teh0D01QVgU9HPGHJBv54Xg5+wI8W
         Dk49Xa+RuoiXwj9/wlUfNVm5xbQLnE03avmCF2XA3W/JFeENJUVOFXPwmGr/dK8PDOjH
         qwzQ==
X-Gm-Message-State: AO0yUKVpNySeArGJLtRS4Xr8FGhGERvysc66mQM03tO3A90/il3FuBa5
        y0E8iR6avqGfLAxV1eBf77tfAfbaA0MQHlCQ/U4=
X-Google-Smtp-Source: AK7set+s7zMICQMRVeWypsMN+kqFJG2xOdsEjmeAU8sA6FB9C6Be47XBki+H/ZTs9MXv9ydDIk10YDOkbV/Jyqcez5g=
X-Received: by 2002:a17:902:eb8c:b0:19a:7f9c:66e3 with SMTP id
 q12-20020a170902eb8c00b0019a7f9c66e3mr1965518plg.5.1677109182000; Wed, 22 Feb
 2023 15:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
In-Reply-To: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 22 Feb 2023 17:39:30 -0600
Message-ID: <CAHCN7xKbL+g5ZaPe3a50fUEe4AU3a6asCqWFSE8d7DCzWZO=qg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
To:     Paul Elder <paul.elder@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:44 AM Paul Elder <paul.elder@ideasonboard.com> wrote:
>
> This series depends on v3 of "dt-bindings: media: Add macros for video
> interface bus types" [1].
>
> This series extends the rkisp1 driver to support the ISP found in the
> NXP i.MX8MP SoC.
>
> The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip ISP1")
> and in the NXP i.MX8MP have the same origin, and have slightly diverged
> over time as they are now independently developed (afaik) by Rockchip
> and VeriSilicon. The latter is marketed under the name "ISP8000Nano",
> and is close enough to the RK3399 ISP that it can easily be supported by
> the same driver.
>
> The last two patches add support for UYVY output format, which can be
> implemented on the ISP version in the i.MX8MP but not in the one in the
> RK3399.
>
> This version of the series specifically has been tested on a Polyhex
> Debix model A with an imx219 (Raspberry Pi cam v2).
>
> [1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laurent.pinchart@ideasonboard.com/
>
> Laurent Pinchart (3):
>   dt-bindings: media: rkisp1: Add i.MX8MP ISP example
>   media: rkisp1: Add and use rkisp1_has_feature() macro
>   media: rkisp1: Configure gasket on i.MX8MP
>
> Paul Elder (11):
>   dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
>   media: rkisp1: Add match data for i.MX8MP ISP
>   media: rkisp1: Add and set registers for crop for i.MX8MP
>   media: rkisp1: Add and set registers for output size config on i.MX8MP
>   media: rkisp1: Add i.MX8MP-specific registers for MI and resizer
>   media: rkisp1: Shift DMA buffer addresses on i.MX8MP
>   media: rkisp1: Add register definitions for the test pattern generator
>   media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
>   media: rkisp1: Support devices without self path
>   media: rkisp1: Add YC swap capability
>   media: rkisp1: Add UYVY as an output format
>

Paul / Laurent,

I noticed an unexpected behaviour on the imx8mp.

If I setup my pipeline for 640x480, it works just fine using an imx219
camera configured for SRGGB10_1X10.

However, when I try to configure the pipeline to use the same camera
at 1920x1080 (no resizing), the ISP source keeps defaulting to 640x480

Media device information
------------------------
driver          rkisp1
model           rkisp1
serial
bus info        platform:rkisp1
hw revision     0xe
driver version  6.2.0

Device topology
- entity 1: rkisp1_isp (4 pads, 4 links)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev0
pad0: Sink
[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:raw xfer:none
ycbcr:601 quantization:full-range
crop.bounds:(0,0)/1920x1080
crop:(0,0)/640x480]
<- "csis-32e40000.csi":1 [ENABLED]
pad1: Sink
[fmt:unknown/0x0 field:none]
<- "rkisp1_params":0 [ENABLED,IMMUTABLE]
pad2: Source
[fmt:YUYV8_2X8/640x480 field:none colorspace:raw xfer:none ycbcr:601
quantization:lim-range
crop.bounds:(0,0)/640x480
crop:(0,0)/640x480]
-> "rkisp1_resizer_mainpath":0 [ENABLED]
pad3: Source
[fmt:unknown/0x0 field:none]
-> "rkisp1_stats":0 [ENABLED,IMMUTABLE]

- entity 6: rkisp1_resizer_mainpath (2 pads, 2 links)
            type V4L2 subdev subtype Unknown flags 0
            device node name /dev/v4l-subdev1
pad0: Sink
[fmt:YUYV8_2X8/1920x1080 field:none colorspace:srgb xfer:srgb
ycbcr:601 quantization:lim-range
crop.bounds:(0,0)/1920x1080
crop:(0,0)/640x480]
<- "rkisp1_isp":2 [ENABLED]
pad1: Source
[fmt:YUYV8_2X8/1920x1080 field:none colorspace:srgb xfer:srgb
ycbcr:601 quantization:lim-range]
-> "rkisp1_mainpath":0 [ENABLED,IMMUTABLE]

- entity 9: rkisp1_mainpath (1 pad, 1 link)
            type Node subtype V4L flags 0
            device node name /dev/video0
pad0: Sink
<- "rkisp1_resizer_mainpath":1 [ENABLED,IMMUTABLE]

- entity 13: rkisp1_stats (1 pad, 1 link)
             type Node subtype V4L flags 0
             device node name /dev/video1
pad0: Sink
<- "rkisp1_isp":3 [ENABLED,IMMUTABLE]

- entity 17: rkisp1_params (1 pad, 1 link)
             type Node subtype V4L flags 0
             device node name /dev/video2
pad0: Source
-> "rkisp1_isp":1 [ENABLED,IMMUTABLE]

- entity 29: csis-32e40000.csi (2 pads, 2 links)
             type V4L2 subdev subtype Unknown flags 0
             device node name /dev/v4l-subdev2
pad0: Sink
[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb xfer:srgb
ycbcr:601 quantization:full-range]
<- "imx219 1-0010":0 [ENABLED]
pad1: Source
[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb xfer:srgb
ycbcr:601 quantization:full-range]
-> "rkisp1_isp":0 [ENABLED]

- entity 34: imx219 1-0010 (1 pad, 1 link)
             type V4L2 subdev subtype Sensor flags 0
             device node name /dev/v4l-subdev3
pad0: Source
[fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb xfer:srgb
ycbcr:601 quantization:full-range
crop.bounds:(8,8)/3280x2464
crop:(688,700)/1920x1080]
-> "csis-32e40000.csi":0 [ENABLED]

It's at this point that everything except the ISP source is 1920x1080.

When I try to set the ISP sink to 1080, it ends up being 640x480 and
the resizer sink is also changed to 640x480

root@beacon-imx8mp-kit:~# media-ctl -v -V "'rkisp1_isp':2
[fmt:YUYV8_2X8/1920x1080 field:none]"
Opening media device /dev/media0
Enumerating entities
looking up device: 81:3
looking up device: 81:4
looking up device: 81:0
looking up device: 81:1
looking up device: 81:2
looking up device: 81:5
looking up device: 81:6
Found 7 entities
Enumerating pads and links
Setting up format YUYV8_2X8 1920x1080 on pad rkisp1_isp/2
Format set: YUYV8_2X8 640x480
Setting up format YUYV8_2X8 640x480 on pad rkisp1_resizer_mainpath/0
Format set: YUYV8_2X8 640x480


It's my understanding that the ISP should be able to handle 1920x1080,
and the resizer sink should match the ISP source.

With the pipeline improperly setup, the capture fails.

adam


>  .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
>  .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++---
>  .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
>  .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
>  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
>  .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 +++++++++++++++++-
>  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
>  .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
>  include/uapi/linux/rkisp1-config.h            |   2 +
>  9 files changed, 509 insertions(+), 40 deletions(-)
>
> --
> 2.35.1
>
