Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50B6726772
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjFGRc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjFGRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:32:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8528919AA;
        Wed,  7 Jun 2023 10:32:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126233170111.36.openmobile.ne.jp [126.233.170.111])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B44C74C;
        Wed,  7 Jun 2023 19:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686159102;
        bh=bKJBUt1V1z4ZiUZcJCmBWG432dDim4B4cyEsgkbFg9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXLE+2srcbYFVgxCt2pvRSMmU8bz/ouAC4OwnU3TClYoq5jEDIlbo0G47YZwpVJaV
         hj20HknX8xc5Y4KSN0essBg82NlOk3ymuAO7etMyiWr969BsKtcctA0/LxxbZ7ro9q
         XE3zzSOv6OdPGGkKRM+j+U1rdrscXF09VcmTE9xA=
Date:   Wed, 7 Jun 2023 20:32:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: drop Shawn Tu due to mail bounces
Message-ID: <20230607173204.GG5058@pendragon.ideasonboard.com>
References: <20230607-unfounded-blandness-93cf1e44f127@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607-unfounded-blandness-93cf1e44f127@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thank you for the patch.

On Wed, Jun 07, 2023 at 06:26:07PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Emails to Shawn Tu bounce & I could not easily see a non-intel email
> for them on lore. Drop them and orphan their drivers.
> 
> CC: Shawn Tu <shawnx.tu@intel.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Unless someonw from Intel wants to volunteer and take over maintenance
of the drivers below,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> A conversation starter as much as anything else.
> 
> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> CC: Sakari Ailus <sakari.ailus@linux.intel.com>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> CC: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> CC: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> CC: linux-media@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bbf6c035000..3d2a1314cb26 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9614,9 +9614,8 @@ S:	Maintained
>  F:	arch/x86/kernel/cpu/hygon.c
>  
>  HYNIX HI556 SENSOR DRIVER
> -M:	Shawn Tu <shawnx.tu@intel.com>
>  L:	linux-media@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/i2c/hi556.c
>  
> @@ -9627,9 +9626,8 @@ S:	Maintained
>  F:	drivers/media/i2c/hi846.c
>  
>  HYNIX HI847 SENSOR DRIVER
> -M:	Shawn Tu <shawnx.tu@intel.com>
>  L:	linux-media@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/media/i2c/hi847.c
>  
>  Hyper-V/Azure CORE AND DRIVERS
> @@ -15519,9 +15517,8 @@ F:	Documentation/filesystems/omfs.rst
>  F:	fs/omfs/
>  
>  OMNIVISION OG01A1B SENSOR DRIVER
> -M:	Shawn Tu <shawnx.tu@intel.com>
>  L:	linux-media@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  F:	drivers/media/i2c/og01a1b.c
>  
>  OMNIVISION OV01A10 SENSOR DRIVER
> @@ -15585,7 +15582,6 @@ F:	drivers/media/i2c/ov2685.c
>  
>  OMNIVISION OV2740 SENSOR DRIVER
>  M:	Tianshu Qiu <tian.shu.qiu@intel.com>
> -R:	Shawn Tu <shawnx.tu@intel.com>
>  R:	Bingbu Cao <bingbu.cao@intel.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> @@ -15625,9 +15621,8 @@ F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5670.yaml
>  F:	drivers/media/i2c/ov5670.c
>  
>  OMNIVISION OV5675 SENSOR DRIVER
> -M:	Shawn Tu <shawnx.tu@intel.com>
>  L:	linux-media@vger.kernel.org
> -S:	Maintained
> +S:	Orphan
>  T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/i2c/ovti,ov5675.yaml
>  F:	drivers/media/i2c/ov5675.c

-- 
Regards,

Laurent Pinchart
