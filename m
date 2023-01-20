Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615746748BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjATBWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjATBWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:22:51 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B65A839;
        Thu, 19 Jan 2023 17:22:50 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DFDEA514;
        Fri, 20 Jan 2023 02:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674177768;
        bh=P3g7PLH+TMhfwNmclwBZopRXpaF2Op0NgpDNHxm3mf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nU1lyUP58A9qJE0zvADIge75BzjUzVlwwkvbf2XuhFeSCUaHSuYLFQxfCfVwQeQwq
         8f9q8oP3luhr6SaU6JBqSjszhD0r3obo1n5m161OdSAjz5iEsGnnNBgJn84y3lIjMm
         y45Yk2rs9kkKKIjcm616cmvV8Ah88VjAhQgt9BZw=
Date:   Fri, 20 Jan 2023 03:22:45 +0200
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
Subject: Re: [PATCH v5 1/6] staging: vc04_services: Drop __VCCOREVER__
 remnants
Message-ID: <Y8ns5fYiL9ef7r1F@pendragon.ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
 <20230119115503.268693-2-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119115503.268693-2-umang.jain@ideasonboard.com>
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

On Thu, Jan 19, 2023 at 05:24:58PM +0530, Umang Jain wrote:
> Commit 8ba5f91bab63("staging: vc04_services: remove __VCCOREVER__")

With a space before '(',

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> was meant to remove all of __VCCOREVER__ definitions but missed to
> remove a few. Hence, drop them now.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/Makefile  | 2 +-
>  drivers/staging/vc04_services/bcm2835-camera/Makefile | 3 +--
>  drivers/staging/vc04_services/vchiq-mmal/Makefile     | 3 +--
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> index d59fe4dde615..fc7ac6112a3e 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
> +++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
> @@ -2,4 +2,4 @@
>  obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
>  snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
>  
> -ccflags-y += -I $(srctree)/$(src)/../include -D__VCCOREVER__=0x04000000
> +ccflags-y += -I $(srctree)/$(src)/../include
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/Makefile b/drivers/staging/vc04_services/bcm2835-camera/Makefile
> index 3a76d6ade428..3494c82b271a 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/Makefile
> +++ b/drivers/staging/vc04_services/bcm2835-camera/Makefile
> @@ -7,5 +7,4 @@ obj-$(CONFIG_VIDEO_BCM2835) += bcm2835-v4l2.o
>  
>  ccflags-y += \
>  	-I $(srctree)/$(src)/.. \
> -	-I $(srctree)/$(src)/../vchiq-mmal/ \
> -	-D__VCCOREVER__=0x04000000
> +	-I $(srctree)/$(src)/../vchiq-mmal/
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers/staging/vc04_services/vchiq-mmal/Makefile
> index b2a830f48acc..c7d3b06e17ce 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/Makefile
> +++ b/drivers/staging/vc04_services/vchiq-mmal/Makefile
> @@ -5,5 +5,4 @@ obj-$(CONFIG_BCM2835_VCHIQ_MMAL) += bcm2835-mmal-vchiq.o
>  
>  ccflags-y += \
>  	-I$(srctree)/$(src)/.. \
> -	-I$(srctree)/$(src)/../include \
> -	-D__VCCOREVER__=0x04000000
> +	-I$(srctree)/$(src)/../include

-- 
Regards,

Laurent Pinchart
