Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5428D5FFB5C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJORH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJORH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:07:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCF04B0F8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 10:07:56 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4B190480;
        Sat, 15 Oct 2022 19:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665853674;
        bh=WHis60322mvb0p4MR7bCAHwRlHfbwfjXfTZFUbN4JQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8iuPZfw69ncGxTx5nLxNY/j3Rq+Ztn4SjAKFXW/V1+Bz02gy16jc3gr9h6GFCk63
         yiSuIqK7FCiBOb7Pcm8FI5DvMRig4lrm0g0j+STEe3OS8X6yGZJ5aS82UjB7uLoJGv
         GRjTws/7M5HPyt8SdabcX+FKmtfTBiKC6XqCzt6Q=
Date:   Sat, 15 Oct 2022 20:07:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>, dri-devel@lists.freedesktop.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] media: uapi: add MEDIA_BUS_FMT_BGR666_1X18
Message-ID: <Y0ro08TTmavkf0Ca@pendragon.ideasonboard.com>
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
 <20221013-rpi-dpi-improvements-v1-2-8a7a96949cb0@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013-rpi-dpi-improvements-v1-2-8a7a96949cb0@cerno.tech>
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

On Thu, Oct 13, 2022 at 11:56:46AM +0200, Maxime Ripard wrote:
> From: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> 
> Add the BGR666 format MEDIA_BUS_FMT_BGR666_1X18 supported by the
> RaspberryPi.
> 
> Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  include/uapi/linux/media-bus-format.h | 3 ++-

New formats need documentation in
Documentation/userspace-api/media/v4l/subdev-formats.rst. Same for 
patches 1/7 and 3/7.

Apart from that, the patch looks good to me.

>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
> index b0a945eb7040..2ee0b38c0a71 100644
> --- a/include/uapi/linux/media-bus-format.h
> +++ b/include/uapi/linux/media-bus-format.h
> @@ -34,7 +34,7 @@
>  
>  #define MEDIA_BUS_FMT_FIXED			0x0001
>  
> -/* RGB - next is	0x1023 */
> +/* RGB - next is	0x1024 */
>  #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
> @@ -46,6 +46,7 @@
>  #define MEDIA_BUS_FMT_BGR565_2X8_LE		0x1006
>  #define MEDIA_BUS_FMT_RGB565_2X8_BE		0x1007
>  #define MEDIA_BUS_FMT_RGB565_2X8_LE		0x1008
> +#define MEDIA_BUS_FMT_BGR666_1X18		0x1023
>  #define MEDIA_BUS_FMT_RGB666_1X18		0x1009
>  #define MEDIA_BUS_FMT_RBG888_1X24		0x100e
>  #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015
> 

-- 
Regards,

Laurent Pinchart
