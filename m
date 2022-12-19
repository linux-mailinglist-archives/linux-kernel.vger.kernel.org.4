Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CBE6514A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiLSVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiLSVHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:07:54 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48593658E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:07:51 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x11so10469875ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvDFRM+cIsRIk+HqgujcIiOfyICxAxZ5sfBT0wH/F0w=;
        b=hpybuwdtfx5Ig/p4JwDOF5ggHdKpWlXU5aP/RV04mEmmy3DqzGUiI3+9gHNzeTDm9L
         GqypwiESMeD44/3G78iWvyJQPpDlCg08IMLmFAMyPuLs6FgDoDilntwlc4AEeI37Cszm
         bYKmGKEKFLlLBR7FTCbCI4Wch61JbEbrGgmXyGbK9MGObrhJLy6PR1kfHe2CrP5A6g1Q
         Rf1uCtE4q7Mfzwjnn2kqE6H2ny2GFTWenxke03HJ6pdHaCYEMRM5BI4l0m/b8hJ4rgup
         54awbrrDz8GYEYZoEH+ZX905D5jHFWzE6Nq3uz3zWINYUZYf5ZhoeNL81OO2mpav/37L
         83Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvDFRM+cIsRIk+HqgujcIiOfyICxAxZ5sfBT0wH/F0w=;
        b=yYk/sz1DCivdgjMZQMe4/q3uBlBzxLC/l2f3cfUipMzZtzx30sKbf7b7zgf9PmGqgu
         E4gDqK1TT8yk5qY5ur4gWbAEEbZ/A8m16YZa72VfHJwMVRNfoYzlqTU9e8ezJNcEuD5S
         /GXqTJRoLpFhQf1WKOw9O+x5N0JlMBNQ7w+iB4xM7svvXGjFOfyAcTNamZiXOWuVwNri
         /fn58uk6fnKfmU43f68OTVrB/OLUAadlbhOYz1VRHxEId5Rtgka1u9k/DbT2vUbfLgr8
         FRoQES6/r7k9tkxSGxj6rXC/5GXF/4CjhcBMviPp0Lsdbl18pg7K5d4x0CZCF+wJHGz1
         ueSg==
X-Gm-Message-State: ANoB5pnO/AS2BbF25JhGTkYXlId2RBDPt0ctfafcMHh3kfH0X4b6D/km
        PXpA9b22BxRBfrdQgSL3k7AjlMb0gfR9FVflyWvFiA==
X-Google-Smtp-Source: AA0mqf7yh+36itgm76QOQNXUPNSIh1XAiQ1h3fas3L7sHK0kevEvJn+HhC5t4DANokXbaBLR76Kk/IEFhKA2q7XG/jE=
X-Received: by 2002:a05:651c:c87:b0:27b:afc1:da9 with SMTP id
 bz7-20020a05651c0c8700b0027bafc10da9mr1862896ljb.218.1671484069613; Mon, 19
 Dec 2022 13:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 19 Dec 2022 18:07:38 -0300
Message-ID: <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
> This series implement AV1 stateless decoder for RK3588 SoC.
> The harware support 8 and 10 bits bitstreams up to 7680x4320.
> AV1 feature like film grain or scaling are done by the postprocessor.
> The driver can produce NV12_4L4 and NV12 pixel formats.
> A native 10bits NV12_4L4 format is possible but need more investigation
> to be completly documented and enabled.
>
> It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches and
> Sebastian's device-tree patches for RK3588.
>

I thought the AV1 decoder in RK3588 was really a separate hardware
from the Hantro G1/G2.

Shouldn't this need a new driver for this new hardware?

Thanks!
Ezequiel

> The full branch can be found here:
> https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_decoder_v1
>
> Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStreamer-AV1-V4L2SL-Gst1.0.
> The failing tests are:
> - 10bits bitstream because 10bits output formats aren't yet implemented.
> - the 2 tests with 2 spatial layers: few errors in luma/chroma values
> - tests with resolution < hardware limit (64x64)
>
> Benjamin
>
> Benjamin Gaignard (9):
>   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>   media: verisilicon: Add AV1 decoder mode and controls
>   media: verisilicon: Save bit depth for AV1 decoder
>   media: verisilicon: Check AV1 bitstreams bit depth
>   media: verisilicon: Compute motion vectors size for AV1 frames
>   media: verisilicon: Add AV1 entropy helpers
>   media: verisilicon: Add Rockchip AV1 decoder
>   media: verisilicon: Add film grain feature to AV1 driver
>   media: verisilicon: Enable AV1 decoder on rk3588
>
>  .../bindings/media/rockchip-vpu.yaml          |    1 +
>  drivers/media/platform/verisilicon/Makefile   |    3 +
>  drivers/media/platform/verisilicon/hantro.h   |    5 +
>  .../media/platform/verisilicon/hantro_drv.c   |   54 +
>  .../media/platform/verisilicon/hantro_hw.h    |  102 +
>  .../platform/verisilicon/hantro_postproc.c    |    3 +
>  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
>  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++++++++
>  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
>  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
>  14 files changed, 8291 insertions(+)
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropymode.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgrain.h
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_av1_dec.c
>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs.h
>
> --
> 2.34.1
>
