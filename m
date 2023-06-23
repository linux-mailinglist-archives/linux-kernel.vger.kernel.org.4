Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3016773BAE3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjFWO5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjFWO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:56:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE62136;
        Fri, 23 Jun 2023 07:56:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDB8DD5F;
        Fri, 23 Jun 2023 16:56:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687532161;
        bh=qlSeLA7AwsNcc+6RnyaobyYnL725JuzygrXuObFz9hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z34FGxc7qciJD0E/UZeHg8UHHtzVNzTeQlVRfaNKxIMJ+JTb6kLAPiRuG/4ZVek83
         3hBBcwoKZahlBaKNwloSONRo4fj48lTVq6eXu+R6CqRGbqg8vyNdowssKBjCDS3AOg
         tQ6p4XRYlGMgAEX47gw2bpB4nWVf/fo1kaOI0DXM=
Date:   Fri, 23 Jun 2023 17:56:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 02/39] media: uapi: Add MEDIA_BUS_FMT_RGB666_2X9 variants
Message-ID: <20230623145637.GF2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <97fc74f2eaee860d1ed215c43193a0e36d014d42.1687423204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97fc74f2eaee860d1ed215c43193a0e36d014d42.1687423204.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thu, Jun 22, 2023 at 11:21:14AM +0200, Geert Uytterhoeven wrote:
> Add the RGB666 9:9 formats MEDIA_BUS_FMT_RGB666_2X9_BE and
> MEDIA_BUS_FMT_RGB666_2X9_LE.  The former is supported by the SH-Mobile
> LCD Controller.

If MEDIA_BUS_FMT_RGB666_2X9_LE isn't supported, I'd leave it out for
now. It can be added later once a driver needs it.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> ---
>  .../media/v4l/subdev-formats.rst              | 144 ++++++++++++++++++
>  include/uapi/linux/media-bus-format.h         |   4 +-
>  2 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> index a3a35eeed70846ba..4bbcdec101384cb1 100644
> --- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
> @@ -949,6 +949,150 @@ The following tables list existing packed RGB formats.
>        - b\ :sub:`2`
>        - b\ :sub:`1`
>        - b\ :sub:`0`
> +    * .. _MEDIA-BUS-FMT-RGB666-2X9-BE:
> +
> +      - MEDIA_BUS_FMT_RGB666_2X9_BE
> +      - 0x1025
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      - r\ :sub:`5`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
> +    * -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - b\ :sub:`5`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +    * .. _MEDIA-BUS-FMT-RGB666-2X9-LE:
> +
> +      - MEDIA_BUS_FMT_RGB666_2X9_LE
> +      - 0x1026
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      - g\ :sub:`2`
> +      - g\ :sub:`1`
> +      - g\ :sub:`0`
> +      - b\ :sub:`5`
> +      - b\ :sub:`4`
> +      - b\ :sub:`3`
> +      - b\ :sub:`2`
> +      - b\ :sub:`1`
> +      - b\ :sub:`0`
> +    * -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      -
> +      - r\ :sub:`5`
> +      - r\ :sub:`4`
> +      - r\ :sub:`3`
> +      - r\ :sub:`2`
> +      - r\ :sub:`1`
> +      - r\ :sub:`0`
> +      - g\ :sub:`5`
> +      - g\ :sub:`4`
> +      - g\ :sub:`3`
>      * .. _MEDIA-BUS-FMT-BGR666-1X18:
>  
>        - MEDIA_BUS_FMT_BGR666_1X18
> diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
> index a03c543cb072de30..07105f530400511e 100644
> --- a/include/uapi/linux/media-bus-format.h
> +++ b/include/uapi/linux/media-bus-format.h
> @@ -34,7 +34,7 @@
>  
>  #define MEDIA_BUS_FMT_FIXED			0x0001
>  
> -/* RGB - next is	0x1025 */
> +/* RGB - next is	0x1027 */
>  #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
>  #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
> @@ -46,6 +46,8 @@
>  #define MEDIA_BUS_FMT_RGB565_2X8_BE		0x1007
>  #define MEDIA_BUS_FMT_RGB565_2X8_LE		0x1008
>  #define MEDIA_BUS_FMT_RGB666_1X18		0x1009
> +#define MEDIA_BUS_FMT_RGB666_2X9_BE		0x1025
> +#define MEDIA_BUS_FMT_RGB666_2X9_LE		0x1026
>  #define MEDIA_BUS_FMT_BGR666_1X18		0x1023
>  #define MEDIA_BUS_FMT_RBG888_1X24		0x100e
>  #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015

-- 
Regards,

Laurent Pinchart
