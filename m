Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AA63BFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiK2MXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK2MXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:23:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699E303FA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:23:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 700F84E6;
        Tue, 29 Nov 2022 13:23:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669724598;
        bh=ztG42iIhYdUHImwuvJ2KShcJ26uhez7o9Otsn3LbX7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlGrRJncTvoHhfJ9dcOWC9D+acIqO7bNP8T61ccEw28NWEqjN7oZOj9a38DGpidkO
         1Ws/Ds6+kIr78TwPqgxqMtwVfIxKm9EdjaPWn/IvnROk3mioaCHQx60lou3uxNIMJ4
         SQrjB15SK4kGwiRfTH78Wd/W0y+4/66LFQpYqjg8=
Date:   Tue, 29 Nov 2022 14:22:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 1/7] media: uapi: add MEDIA_BUS_FMT_RGB565_1X24_CPADHI
Message-ID: <Y4X5o8tcQHbfa/cV@pendragon.ideasonboard.com>
References: <20221013-rpi-dpi-improvements-v2-0-7691903fb9c8@cerno.tech>
 <20221013-rpi-dpi-improvements-v2-1-7691903fb9c8@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013-rpi-dpi-improvements-v2-1-7691903fb9c8@cerno.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime and Chris,

Thank you for the patch.

On Thu, Oct 20, 2022 at 10:30:45AM +0200, Maxime Ripard wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the MEDIA_BUS_FMT_RGB565_1X24_CPADHI format used by the Geekworm
> MZP280 panel for the Raspberry Pi.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../userspace-api/media/v4l/subdev-formats.rst     | 37 ++++++++++++++++++++++
>  include/uapi/linux/media-bus-format.h              |  3 +-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> index d21d532eee15..1e61c02aa788 100644
> --- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> @@ -986,6 +986,43 @@ The following tables list existing packed RGB formats.
>        - g\ :sub:`2`
>        - g\ :sub:`1`
>        - g\ :sub:`0`
> +    * .. _MEDIA-BUS-FMT-RGB565-1X24_CPADHI:
> +
> +      - MEDIA_BUS_FMT_RGB565_1X24_CPADHI
> +      - 0x1022
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      - 0
> +      - 0
> +      - 0
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - 0
> +      - 0
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - 0
> +      - 0
> +      - 0
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
>      * .. _MEDIA-BUS-FMT-RGB666-1X24_CPADHI:
>  
>        - MEDIA_BUS_FMT_RGB666_1X24_CPADHI
> diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
> index ec3323dbb927..b0a945eb7040 100644
> --- a/include/uapi/linux/media-bus-format.h
> +++ b/include/uapi/linux/media-bus-format.h
> @@ -34,13 +34,14 @@
>  
>  #define MEDIA_BUS_FMT_FIXED			0x0001
>  
> -/* RGB - next is	0x1022 */
> +/* RGB - next is	0x1023 */
>  #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
>  #define MEDIA_BUS_FMT_RGB555_2X8_PADHI_BE	0x1003
>  #define MEDIA_BUS_FMT_RGB555_2X8_PADHI_LE	0x1004
>  #define MEDIA_BUS_FMT_RGB565_1X16		0x1017
> +#define MEDIA_BUS_FMT_RGB565_1X24_CPADHI	0x1022
>  #define MEDIA_BUS_FMT_BGR565_2X8_BE		0x1005
>  #define MEDIA_BUS_FMT_BGR565_2X8_LE		0x1006
>  #define MEDIA_BUS_FMT_RGB565_2X8_BE		0x1007
> 

-- 
Regards,

Laurent Pinchart
