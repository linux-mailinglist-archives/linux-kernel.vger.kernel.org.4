Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6F06748DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjATBcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjATBcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:32:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502386EE6;
        Thu, 19 Jan 2023 17:32:04 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EEF9514;
        Fri, 20 Jan 2023 02:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674178322;
        bh=SjQRrqIa+SgjNKwnY8mzZtkRapHgMrhshCu+Y2mVyQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZ3/7vtyMid+aFisGXGudSkwrnBOMjrlZNhPeBgOb4v9lq08Yj1Nw+YCQf7MuITTe
         ug1Fj/wPhTI/EO/NB+iSHoTqS4HrkkQlccD5cQgR4vjjYUZAS1QboMx4LfDUMaC2e1
         MkSm3JMkMtH8GDXAdivwVLIryhIZP5c7nAnmmKqI=
Date:   Fri, 20 Jan 2023 03:32:00 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v5 3/6] staging: vc04_services: bcm2835-camera: Drop
 include Makefile directive
Message-ID: <Y8nvEC9EVdHfCuNq@pendragon.ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
 <20230119115503.268693-4-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119115503.268693-4-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Thank you for the patch.

On Thu, Jan 19, 2023 at 05:25:00PM +0530, Umang Jain wrote:
> Drop the include directive they can break the build one only wants to
> build a subdirectory. Replace with "../" for the includes, in the
> bcm2835-camera files instead.

Same comment as in 2/6. I expect it applies to other patches in the
series too.

> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/Makefile  |  4 ----
>  .../vc04_services/bcm2835-camera/bcm2835-camera.c      | 10 +++++-----
>  .../staging/vc04_services/bcm2835-camera/controls.c    |  6 +++---
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/Makefile b/drivers/staging/vc04_services/bcm2835-camera/Makefile
> index 3494c82b271a..203b93899b20 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/Makefile
> +++ b/drivers/staging/vc04_services/bcm2835-camera/Makefile
> @@ -4,7 +4,3 @@ bcm2835-v4l2-$(CONFIG_VIDEO_BCM2835) := \
>  	controls.o
>  
>  obj-$(CONFIG_VIDEO_BCM2835) += bcm2835-v4l2.o
> -
> -ccflags-y += \
> -	-I $(srctree)/$(src)/.. \
> -	-I $(srctree)/$(src)/../vchiq-mmal/
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index 797ebe2a973a..4f81765912ea 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -26,11 +26,11 @@
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
>  
> -#include "mmal-common.h"
> -#include "mmal-encodings.h"
> -#include "mmal-vchiq.h"
> -#include "mmal-msg.h"
> -#include "mmal-parameters.h"
> +#include "../vchiq-mmal/mmal-common.h"
> +#include "../vchiq-mmal/mmal-encodings.h"
> +#include "../vchiq-mmal/mmal-vchiq.h"
> +#include "../vchiq-mmal/mmal-msg.h"
> +#include "../vchiq-mmal/mmal-parameters.h"

Unlike the change in 2/6 that we may want to reconsider, this looks good
to me, even though it will be interesting to see what happens if we move
the vchiq core out of staging first. I expect in that case that the
headers will go to a directory under include/ (likely in
include/linux/soc/ ?), and this will be modified accordingly.

In the meantime, with the commit message updated,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  #include "bcm2835-camera.h"
>  
>  #define MIN_WIDTH 32
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index 5644d1d457b9..6bce45925bf1 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -23,9 +23,9 @@
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-common.h>
>  
> -#include "mmal-common.h"
> -#include "mmal-vchiq.h"
> -#include "mmal-parameters.h"
> +#include "../vchiq-mmal/mmal-common.h"
> +#include "../vchiq-mmal/mmal-vchiq.h"
> +#include "../vchiq-mmal/mmal-parameters.h"
>  #include "bcm2835-camera.h"
>  
>  /* The supported V4L2_CID_AUTO_EXPOSURE_BIAS values are from -4.0 to +4.0.

-- 
Regards,

Laurent Pinchart
