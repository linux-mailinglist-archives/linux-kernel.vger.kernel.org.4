Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5263ED18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiLAJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiLAJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:57:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6598940
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:57:14 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 873426D0;
        Thu,  1 Dec 2022 10:57:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669888632;
        bh=YqqM7z0zZtdmPAvqBbQaujfpmAqlD5uXx35Y9TeeeLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzPYgkpp7Y5FPkUkZM47AsyqJjS1bPzlXkM8l+WTDFHUyYwmpe8kbfEd73otnlPGQ
         x5kRtSc3K/bmCLhVir7HFP25CA7bCetHAxpGO4nZdrJZt50lUbIRPQtdLaPYzevKOn
         8j5HAfgal9g38MwkR9wkkfi32umiE6NFWEH/rj/Y=
Date:   Thu, 1 Dec 2022 11:56:55 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        David Airlie <airlied@linux.ie>, Emma Anholt <emma@anholt.net>,
        Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org,
        Chris Morgan <macromorgan@hotmail.com>,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] media: uapi: add MEDIA_BUS_FMT_BGR666_1X24_CPADHI
Message-ID: <Y4h6Z2duUx4j2tHw@pendragon.ideasonboard.com>
References: <20221013-rpi-dpi-improvements-v3-0-eb76e26a772d@cerno.tech>
 <20221013-rpi-dpi-improvements-v3-3-eb76e26a772d@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013-rpi-dpi-improvements-v3-3-eb76e26a772d@cerno.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you for the patch.

On Thu, Dec 01, 2022 at 09:42:48AM +0100, Maxime Ripard wrote:
> From: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> 
> Add the BGR666 format MEDIA_BUS_FMT_BGR666_1X24_CPADHI supported by the
> RaspberryPi.
> 
> Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../userspace-api/media/v4l/subdev-formats.rst     | 37 ++++++++++++++++++++++
>  include/uapi/linux/media-bus-format.h              |  3 +-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> index 6605c056cc7c..5f2ce6eada71 100644
> --- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> @@ -1060,6 +1060,43 @@ The following tables list existing packed RGB formats.
>        - b\ :sub:`2`
>        - b\ :sub:`1`
>        - b\ :sub:`0`
> +    * .. _MEDIA-BUS-FMT-BGR666-1X24_CPADHI:
> +
> +      - MEDIA_BUS_FMT_BGR666_1X24_CPADHI
> +      - 0x1024
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
> +      - b\ :sub:`5`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
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
> +      - r\ :sub:`5`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
>      * .. _MEDIA-BUS-FMT-RGB565-1X24_CPADHI:
>  
>        - MEDIA_BUS_FMT_RGB565_1X24_CPADHI
> diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
> index 6ce56a984112..f3b0b8091a2c 100644
> --- a/include/uapi/linux/media-bus-format.h
> +++ b/include/uapi/linux/media-bus-format.h
> @@ -34,7 +34,7 @@
>  
>  #define MEDIA_BUS_FMT_FIXED			0x0001
>  
> -/* RGB - next is	0x1024 */
> +/* RGB - next is	0x1025 */
>  #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
> @@ -49,6 +49,7 @@
>  #define MEDIA_BUS_FMT_BGR666_1X18		0x1023
>  #define MEDIA_BUS_FMT_RBG888_1X24		0x100e
>  #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015
> +#define MEDIA_BUS_FMT_BGR666_1X24_CPADHI	0x1024
>  #define MEDIA_BUS_FMT_RGB565_1X24_CPADHI	0x1022
>  #define MEDIA_BUS_FMT_RGB666_1X7X3_SPWG		0x1010
>  #define MEDIA_BUS_FMT_BGR888_1X24		0x1013
> 

-- 
Regards,

Laurent Pinchart
