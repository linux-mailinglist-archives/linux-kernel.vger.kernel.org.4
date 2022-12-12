Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F9649DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiLLLdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiLLLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:31:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2D59FC4;
        Mon, 12 Dec 2022 03:31:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v8so12417989edi.3;
        Mon, 12 Dec 2022 03:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaUp9wpaHX4T197Lz/YFuxi7l7MWe8RjmPVNiLiDGvU=;
        b=cyG9Hj9qZPMRgNPRhE2mTWEuM+HUr031mF7Bz1hggNfN7eDtybfPw5+EPAV1O8i2P2
         Aj2VeNDE4JHLz1awWsSMbGXA6HlblORSfhpWEWtb1tHjIZd1U0t1iHGTFfljzkxPbhqb
         DrQYKVNWuaFqp1R9rNTdFPhJijPmnQgzhH1inMyPOXIcG483YL9dUla52dkIYHsPSbOc
         0Ubb0lKyDU5RdX6f3NX4+HXsdc3wglGOrDIUOxq2PBBDvFf2sFaDatWkRBpw7usbCnru
         sTEhZw1YTSTOWxquFdcANGoAc6/EPs1luKgNE1p5P+09UVqL7UjZqPPRsrZ2prQsje0W
         vRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaUp9wpaHX4T197Lz/YFuxi7l7MWe8RjmPVNiLiDGvU=;
        b=7vkfCa1zA1/CFDJIwIlVj/ZzmteQnMntaRJW5fMw+3wGRbbARjBT0rIzl661gqQnCa
         ihqiO4pDUbzkJjRcOgDbGm1P8XydM4AkiAaZr4Se/iHmDgBmZZQD9f1AKhtxuDjBX7V/
         kCsjcp2jinuETKgzXxn6x8D1+dwqtz6MXzV5z4RldismjajgA50phqGavAI5VC+I9EO/
         YZ6NggFb6tScIBJ5D/2G++LtdNb2bOpwcNkzYnaW2B1AZ5TqZw9Yweenqzi4EjmTdA9T
         kWpCkPZMoH5QDTIN5EYOsukww8yVojwuBSLvV2hkbYtdIB/HBhYztJKHsY7n2zeTOaOw
         SxCg==
X-Gm-Message-State: ANoB5pnGDqpWKrVJU5CG0nny44ErT9NvgcrK5QfhapDOfEk15w08k5WT
        IoSYxPlvy8LusYtc6EOVK7n/MUfchRnsSbGaVpE=
X-Google-Smtp-Source: AA0mqf4szr6Bqoo+l9xbuEKcH6JR4c6Eku3BjVxrW+RtU1cBELBFqTXigvaBCM4inOcxM6o7/mQaBktcx2OK8rAXZio=
X-Received: by 2002:a05:6402:24a2:b0:470:14c7:5bf5 with SMTP id
 q34-20020a05640224a200b0047014c75bf5mr23369eda.399.1670844694484; Mon, 12 Dec
 2022 03:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20221205051937.3897001-1-shravan.chippa@microchip.com>
In-Reply-To: <20221205051937.3897001-1-shravan.chippa@microchip.com>
From:   shravan kumar <shravanmicrochip@gmail.com>
Date:   Mon, 12 Dec 2022 17:01:23 +0530
Message-ID: <CAOPdzVbvW_MP02ZUw=uyLuLFCjmq4WZO+GLo9b0SPX5+3f4j4w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] media: i2c: imx334: support lower bandwidth mode
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping!
In the meanwhile the kernel test robot also reported a warning.
"drivers/media/i2c/imx334.c:767:15: warning: unused variable 'i' ", I
will fix this warning.


On Mon, Dec 5, 2022 at 10:53 AM shravan kumar
<shravan.chippa@microchip.com> wrote:
>
> From: Shravan Chippa <shravan.chippa@microchip.com>
>
> Hi
>
> This patch series is for imx334 sensor driver support for lower bandwidth
>
> Some platforms may not be capable of supporting the bandwidth
> required for 12 bit or 3840x2160@60 resolutions.
>
> Add support for dynamically selecting 10 bit and 1920x1080@30
> resolutions while leaving the existing configuration as default
>
> V5 -> V6
> -Drop the dt-binding patch
> -Optimize the code to avoid duplicating the lines
> -Added proper mutex while imx334_mbus_codes array
> -Modified Function __v4l2_ctrl_modify_range arguments as per the review commants
> -Added hblank dummy set ctrl
> -Removed Redundant comment
> -corrected code alignment
> -All commit msgs are re-written
>
> V4 -> V5
> -Added 5 more patchs as per the review comments witch has below updates
> -Updated 1782000000Mbps link frequency for 3840x2160@60 as per the mode
> values
> -Updated 1782000000Mbps link frequency in dt-bindings also
> -Updated 3840x2160@60 mode array with default(reset) values
>
> -Updated hblank __v4l2_ctrl_s_ctrl() to __v4l2_ctrl_modify_range()
> Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
>
> -Current mode update only when we try to set V4L2_SUBDEV_FORMAT_ACTIVE
> -Added link frequency (891000000Mbps) and pixel rate (74250000) to
> 1920x1080@30 mode
> Suggested-by: Sakari Ailus <sakari.ailus@iki.fi>
>
> -Updated commit message
>
> V3 -> V4
> - Make the 12 bit and 3840x2160 as default
> - Set bus code SRGGB12 if set format fails
>
> V2 -> V3
> - Fixed the warning reported by kernel test robot
>
> V1 -> V2
> - Addressed the review comment given by Jacopo Mondi,
>   Which has bug in imx334_enum_frame_size() loop function,
> - Renamed array codes[] to imx334_mbus_codes[]
>
>
> Shravan Chippa (5):
>   media: i2c: imx334: modify link frequency as for the configureation
>   media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to
>     __v4l2_ctrl_modify_range
>   media: i2c: imx334: add missing reset values for mode 3840x2160_regs[]
>   media: i2c: imx334: support lower bandwidth mode
>   media: i2c: imx334: update pixel and link frequency
>
>  drivers/media/i2c/imx334.c | 338 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 310 insertions(+), 28 deletions(-)
>
> --
> 2.34.1
>
