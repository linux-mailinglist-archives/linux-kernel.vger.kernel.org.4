Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11C77245BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjFFOXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjFFOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:23:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A2C12D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:23:28 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126253223039.31.openmobile.ne.jp [126.253.223.39])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9D474AB;
        Tue,  6 Jun 2023 16:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686061381;
        bh=YbDeXSKvlYrPDuVjoEXfSOcgxqvkuTEKb+shnMCLRcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdzSXeOcf/AwXD3bdRm2zumc5KLQd9EWT0jRnwyCUy04sFkOi7izmLbgzZRwUt5gO
         SquS0ij0b03+U5J7Aa3fgSTzkx8oXd1sgW94d6QjhelnhOR1RyZ6NXHoLx7A1g1ppv
         IrvK0TGKCrl38eEzmpEZuZTddd47u4ZHOlVOPWog=
Date:   Tue, 6 Jun 2023 17:23:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v9 3/8] drm: Remove usage of deprecated DRM_INFO
Message-ID: <20230606142322.GB5197@pendragon.ideasonboard.com>
References: <cover.1686047727.git.code@siddh.me>
 <52c8eb0f241a9d67ce5b7e6fc64dc397e735ccd8.1686047727.git.code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52c8eb0f241a9d67ce5b7e6fc64dc397e735ccd8.1686047727.git.code@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddh,

Thank you for the patch.

On Tue, Jun 06, 2023 at 04:15:17PM +0530, Siddh Raman Pant wrote:
> drm_print.h says DRM_INFO is deprecated in favor of drm_info().
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 2 +-
>  drivers/gpu/drm/drm_connector.c      | 7 ++++---
>  drivers/gpu/drm/drm_drv.c            | 2 +-
>  drivers/gpu/drm/drm_pci.c            | 2 +-

Any plan to remove it from drivers as well ? If not you should mention
in the commit message (probably in the subject line itself) that you're
only addressing the DRM core.

Same comment for further patches in this series.

>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 1b12a3c201a3..ae19734974b5 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -331,7 +331,7 @@ static bool drm_client_target_cloned(struct drm_device *dev,
>  		DRM_DEBUG_KMS("can clone using 1024x768\n");
>  		return true;
>  	}
> -	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
> +	drm_info(dev, "kms: can't enable cloning when we probably wanted to.\n");
>  	return false;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 48df7a5ea503..dca8dd4ab93f 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -168,13 +168,14 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
>  		return;
>  
>  	if (mode->force) {
> -		DRM_INFO("forcing %s connector %s\n", connector->name,
> -			 drm_get_connector_force_name(mode->force));
> +		drm_info(connector->dev, "forcing %s connector %s\n",
> +			 connector->name, drm_get_connector_force_name(mode->force));
>  		connector->force = mode->force;
>  	}
>  
>  	if (mode->panel_orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN) {
> -		DRM_INFO("cmdline forces connector %s panel_orientation to %d\n",
> +		drm_info(connector->dev,
> +			 "cmdline forces connector %s panel_orientation to %d\n",
>  			 connector->name, mode->panel_orientation);
>  		drm_connector_set_panel_orientation(connector,
>  						    mode->panel_orientation);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 12687dd9e1ac..02eaa4c9344d 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -943,7 +943,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  	if (drm_core_check_feature(dev, DRIVER_MODESET))
>  		drm_modeset_register_all(dev);
>  
> -	DRM_INFO("Initialized %s %d.%d.%d %s for %s on minor %d\n",
> +	drm_info(dev, "Initialized %s %d.%d.%d %s for %s on minor %d\n",
>  		 driver->name, driver->major, driver->minor,
>  		 driver->patchlevel, driver->date,
>  		 dev->dev ? dev_name(dev->dev) : "virtual device",
> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
> index 39d35fc3a43b..7dfb837d1325 100644
> --- a/drivers/gpu/drm/drm_pci.c
> +++ b/drivers/gpu/drm/drm_pci.c
> @@ -262,7 +262,7 @@ void drm_legacy_pci_exit(const struct drm_driver *driver,
>  		}
>  		mutex_unlock(&legacy_dev_list_lock);
>  	}
> -	DRM_INFO("Module unloaded\n");
> +	drm_info(NULL, "Module unloaded\n");
>  }
>  EXPORT_SYMBOL(drm_legacy_pci_exit);
>  

-- 
Regards,

Laurent Pinchart
