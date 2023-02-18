Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0069BAE5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBRQOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 11:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:14:22 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB07EB6D;
        Sat, 18 Feb 2023 08:14:20 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id jw12so2499263plb.1;
        Sat, 18 Feb 2023 08:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+1RwVolEpaDkvNoagfkc0oFWENbNx6IlcBTkm+2uWfY=;
        b=DPnuDm2UK6aZM1/DmpD+maEi01nKgko6B02vlUDfdt0AZp7HLRfbnP8L67GYXgKpc9
         VaVmnasTwDer1TBtAhHdHXqzIEnGl2kTFZ7zuRdW91S9TOEMGJReydwxTXX5CNkmiZ5I
         gE5SNvTE5lMbDpPGkPjfAjpt1up0YPxlT31EmAKTMOCdy4rEwoWrq7blWFV3mDqpTaJJ
         LSOiHSldo9dGt5REqMYfNnCRwq/dD9L3+oPPj4h480Z6VsK/QgqMaI0sbUywRO2FcGpJ
         wqIXHBxPWM83l9wdFgzU23Fchslb+JMAvZ8CmvTz2sVjrrz2Ox/7WvddLLPYoaWFt1+S
         i25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1RwVolEpaDkvNoagfkc0oFWENbNx6IlcBTkm+2uWfY=;
        b=M6aHJbcNqNvZqdS3x0A0JK1Mx8NTQ3TaoiFzJgha8S+xzKA5RUcw9nmzA1T7NIxWso
         KlcQ5M61QQdUJ/TN3HHq/V54KpYPoNcZZE0Fl+y51+oToORDdLQZwj/rrE+VuQBMVA3O
         3woZy1Buhkv3hQS0R8SV26JL1BuXTKvP8L7YjB7zHUzo1F1YQWe0IJiBHFr6uv3gLgDN
         xiJFSUvaCyHwCAwuLaxq070s3rI1z3i/ANKWmJrlY75EpIa6GrIST2wEazogdZLlRx+u
         9AwevMLmY4SWIbenbUwfRBmhBmWkpfNZSxLhqb9/Q/aFGRRBfcmaBcyhHptHghc0Ntli
         p5mQ==
X-Gm-Message-State: AO0yUKXQv2fg0NGu3mGftWK1eCFTFvQy/TkTKVEzjtvspoo2H4hNY+Nk
        DvFBjPZ1qy0o1NMVsHaOKPZZPHsn1Ek30UK37IA=
X-Google-Smtp-Source: AK7set/7kB91p6zj3k8CerVbUkRXus7sNNR4mBKq+X867A/glRayHeGyGOD8EezF3GafB7rDRV3mk8XuCZtLLyyetC4=
X-Received: by 2002:a17:90b:1644:b0:234:acbe:e3a3 with SMTP id
 il4-20020a17090b164400b00234acbee3a3mr133489pjb.32.1676736859799; Sat, 18 Feb
 2023 08:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
 <CAHCN7x+9E8qcBVOQZKTKagDkvkKVnqDtjvpNX-iNFYwCLRoYug@mail.gmail.com> <Y+1xCtdxIoPtnOws@pendragon.ideasonboard.com>
In-Reply-To: <Y+1xCtdxIoPtnOws@pendragon.ideasonboard.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 18 Feb 2023 10:14:08 -0600
Message-ID: <CAHCN7xLQ2+EuwByr_S9LJjPOtNJncDEHJmBkiLqfEdG4P7gTkw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] media: rkisp1: Add support for i.MX8MP
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e9654a05f4fbb877"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DC_PNG_UNO_LARGO,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e9654a05f4fbb877
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 15, 2023 at 5:55 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Adam,
>
> On Wed, Feb 15, 2023 at 07:57:53AM -0600, Adam Ford wrote:
> > On Fri, Nov 18, 2022 at 3:44 AM Paul Elder wrote:
> >
> > > This series depends on v3 of "dt-bindings: media: Add macros for video
> > > interface bus types" [1].
> > >
> > > This series extends the rkisp1 driver to support the ISP found in the
> > > NXP i.MX8MP SoC.
> >
> > I'm going to spend some time testing this over the weekend.  Is there a V4
> > pending, or should I just test whatever is in Laurent's repo?
>
> I've updated all the v6.2-based branches on
> https://gitlab.com/ideasonboard/nxp/linux.git (and renamed them to
> v6.2/*). Beside a rebase, the v6.2/isp branch contains (at the bottom) 6
> additional patches that I've previously posted to the linux-media
> mailing list (feel free to review them ;-)).

I grabbed your v6.2 series, and applied some updates to enable an
imx219 camera and routed it through the ISP and configured the camera
to SRGGB10_1X10/640x480 and had the ISP convert to YUYV8_2X8/640x480
and it captured just fine.

With that, I think you can add

Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon

I haven't experimented with the resizer yet,but  I did have some
questions on the AWB.  The AWB appears to be available on the 8MP per
the TRM, and  I see reference to AWB in the driver, but when I query
the subdev via yavta, I didn't see anything obvious on how to enable
it.  My pipeline (attached) shows klisp1_params as video2 and
rkisp1_stats as video1.  I attempted to query both without much
success.

root@beacon-imx8mp-kit:~# yavta -l /dev/video2
Device /dev/video2 opened.
Device `rkisp1_params' on `platform:rkisp1' (driver 'rkisp1') supports
meta-data, output, without mplanes.
unable to query control 0xc0000000: Inappropriate ioctl for device (25).
Meta-data format: RK1P (50314b52) buffer size 3048
root@beacon-imx8mp-kit:~# yavta -l /dev/video1
Device /dev/video1 opened.
Device `rkisp1_stats' on `platform:rkisp1' (driver 'rkisp1') supports
meta-data, capture, without mplanes.
unable to query control 0xc0000000: Inappropriate ioctl for device (25).
Meta-data format: RK1S (53314b52) buffer size 260
root@beacon-imx8mp-kit:~#

Is there documentation somewhere on where to test the AWB?  This is of
particular interest to me, because the RGGB format of the camera comes
across with a green tint.  I am able to remove this green-ness on a
different platform using some AWB on the ARM, but I'd rather do it in
hardware if possible.

Thanks

adam


>
> My only concern with this series is with patch "media: rkisp1: Add match
> data for i.MX8MP ISP", and in particular with the following hunk:
>
>  enum rkisp1_cif_isp_version {
>         RKISP1_V10 = 10,
>         RKISP1_V11,
>         RKISP1_V12,
>         RKISP1_V13,
> +       IMX8MP_V10,
>  };
>
> It's not a very nice versioning scheme :-S I'll see if I can find
> something better, but regardless of that, I'll post v4 with the goal of
> merging it in v6.4.
>
> > I have an IMX219 camera with 4-lane support and an i.MX8M Plus kit from
> > Beacon, and I want to test the RGGB bayer conversion to see how well it
> > works.
> >
> > > The ISP IP cores in the Rockchip RK3399 (known as the "Rockchip ISP1")
> > > and in the NXP i.MX8MP have the same origin, and have slightly diverged
> > > over time as they are now independently developed (afaik) by Rockchip
> > > and VeriSilicon. The latter is marketed under the name "ISP8000Nano",
> > > and is close enough to the RK3399 ISP that it can easily be supported by
> > > the same driver.
> >
> > Is there a reason the driver cannot be renamed to a more generic name than
> > rkisp1 if the Rockchip and VeriSilicon had similar origins?  Having the
> > name Rockchip referenced from an NXP i.MX8M Plus seems odd to me.
>
> The common roots of the IP core predate both Rockchip and VeriSilicon.
> Those two implementations have now diverged (as with all forks), so
> either name would be wrong in some cases :-S
>
> > > The last two patches add support for UYVY output format, which can be
> > > implemented on the ISP version in the i.MX8MP but not in the one in the
> > > RK3399.
> > >
> > > This version of the series specifically has been tested on a Polyhex
> > > Debix model A with an imx219 (Raspberry Pi cam v2).
> > >
> > > [1] https://lore.kernel.org/linux-media/20220615221410.27459-2-laurent.pinchart@ideasonboard.com/
> > >
> > > Laurent Pinchart (3):
> > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP example
> > >   media: rkisp1: Add and use rkisp1_has_feature() macro
> > >   media: rkisp1: Configure gasket on i.MX8MP
> > >
> > > Paul Elder (11):
> > >   dt-bindings: media: rkisp1: Add i.MX8MP ISP to compatible
> > >   media: rkisp1: Add match data for i.MX8MP ISP
> > >   media: rkisp1: Add and set registers for crop for i.MX8MP
> > >   media: rkisp1: Add and set registers for output size config on i.MX8MP
> > >   media: rkisp1: Add i.MX8MP-specific registers for MI and resizer
> > >   media: rkisp1: Shift DMA buffer addresses on i.MX8MP
> > >   media: rkisp1: Add register definitions for the test pattern generator
> > >   media: rkisp1: Fix RSZ_CTRL bits for i.MX8MP
> > >   media: rkisp1: Support devices without self path
> > >   media: rkisp1: Add YC swap capability
> > >   media: rkisp1: Add UYVY as an output format
> > >
> > >  .../bindings/media/rockchip-isp1.yaml         |  79 ++++++++++-
> > >  .../platform/rockchip/rkisp1/rkisp1-capture.c | 102 +++++++++++---
> > >  .../platform/rockchip/rkisp1/rkisp1-common.h  |  32 +++++
> > >  .../platform/rockchip/rkisp1/rkisp1-debug.c   |  14 +-
> > >  .../platform/rockchip/rkisp1/rkisp1-dev.c     |  67 +++++++--
> > >  .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 +++++++++++++++++-
> > >  .../platform/rockchip/rkisp1/rkisp1-regs.h    |  90 ++++++++++++
> > >  .../platform/rockchip/rkisp1/rkisp1-resizer.c |  35 ++++-
> > >  include/uapi/linux/rkisp1-config.h            |   2 +
> > >  9 files changed, 509 insertions(+), 40 deletions(-)
>
> --
> Regards,
>
> Laurent Pinchart

--000000000000e9654a05f4fbb877
Content-Type: image/png; name="imx8mp-beacon.png"
Content-Disposition: attachment; filename="imx8mp-beacon.png"
Content-Transfer-Encoding: base64
Content-ID: <f_lea5oqdx0>
X-Attachment-Id: f_lea5oqdx0

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
LsyqvwPu1/QA4+q5X/cHGCfVTw9Ia5l24j5RpaWljBw50uGW6V/vAAAgAElEQVSgBGDDhg0n3rdr
p0YIECB57du3j60bt9qWZlKzGfer/ompMX684EeyG2QDcN5556mVYZzwTl7a87L8ktd//vMf++bs
WIcijsh2vx4JMO6ITxmp/s6GQ0cO6ZBhnPEcNkxNTdU5Lze/5hj79u2zb3RdV83gOQKxPcC4He7X
tjGKRZzXCA7tP0T//v35xS9+4XQ0NY4xhry8PPLy8ujQoQPt27ene/fuJ5LXWWedpWbybn7Jq6jI
fVFPzb7PWc1xAfAwsBq42mfcavdr/5hGJE6qBcVFxTzzzDNqZegAl8tFvXr1mDt3LnPnzq0wHKC4
uJg333yTLl26kJeXR3JyslOhOi6sW6JINXQ+0B6YARz3Gl4KvA3kYruNkhqlffv2TodQYwU6p2WM
PQG9efNmxo4dS4cOHcjMzKRnz54899xzsQ4xLih51XRJwKvAD8D/ALuAfcBNwCbgZWxP5CISE23b
hnac/ujRo3z88cd07tw5yhHFJyUvgfOA5cBBIA9754BNwBJgoGNRidRIoSYvgNGjR9O3b98oRhO/
1H+GWF2B+U4HISJt2oR2l986derw+OOPRzma+KU9LxGROBLqdVz33HMPLVq0iHI08UvJS0QkjmRl
ZZGTk1NpmdzcXCZOnBijiOKTkpeISJypau/rqaeeom7dujGKJj4peYmIxJnKGm307t2bUaNGxTCa
+KTkJSISZ4I12khKSuKPf/zjiYuWazIlLxGROBPssOG4cePo3r17jKOJT0peIiJxJtBhw8zMTB56
6CEHoolPSl4iInHmrLPO8uu38KGHHqJx48YORRR/lLxEROJMWlpahWu42rVrx0033eRgRPEneA8b
Oh8oIhE2bdo0xowZ43QYCWf9+vWkpaU5HUbM5efnM3369IDjgievqdEKR0Ti1grgmehPZqq2L1X6
29/g3XehWze4+26no4m9yZMrHx88eY2OcCQikhhikLxGa/tSpT17YNEieOstCKOv3mojyA7XCTrn
JSISh9q2hVtvrZmJKxTqVV5EJA516QLnnut0FPFLyUtEJA41auR0BPFNhw1FRCThxCZ5PYVteu8C
msdkiidvPtAW7ZNKfHuH8t+UCzjubDhOeuopcLnss3mcb1/mz7fnsFK0fTllsUleEwEDdA6x/GGg
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
AABJRU5ErkJggg==
--000000000000e9654a05f4fbb877--
