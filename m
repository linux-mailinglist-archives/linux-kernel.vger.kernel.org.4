Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DAA626046
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiKKRST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiKKRSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:18:17 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E203A532DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:18:14 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id h10so3730533qvq.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFoaqRu0NcN7M7Cgm6Ty0tTFif5Bn8rwUhcb5FvfYLA=;
        b=EFeIcZURS2AEXZmxmnHl2mP66G+FTnJw+vQlWa/2TF8aOsZUIl3YAPmVS+ZbvpRUv6
         HLWmpJ3OB7avnNkbeMW9w323JVpUIsNSB5sPGjDuhptxIFlO2x8pqcJL5zTMXBG0mya7
         F+WvCxR5MZqi6nOXnJTNeeeETLeHyh3f05BzPFghbOqV5pQXw7DIMkfmmCoV5xtab7VN
         415r/hFpxZ8ar3z5kxU0TUAjZTL/PeZs15dRhuI3G8cH+76PAroJleAgjJb/xlU+wxEn
         K72kLf1BY1fglTGgO9FNHtFOwAXJSiZI2abCVAuV4T7xHNk7XeeNn8PNRL1jSRyjuLKR
         /45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFoaqRu0NcN7M7Cgm6Ty0tTFif5Bn8rwUhcb5FvfYLA=;
        b=c1wx57nJfjhg87eUPRNkbgdyQFTeEHnriXngH2JZou9slefsKqOtSjKDon2CB1lGEt
         z+hSXDQRBCWbxw4jDAE3Iq8rmEcY+ek1yXJlcV/NVlf0x5EiZV+7J8QZH5SMVBuZCvSQ
         aWCHgz8FSlN9G7nCwf6TVAE3S3qT1/Mp4+YJTA0tm+R4RzMZaFoDNLAYnqt7XbLUjmBG
         Hc5h3Tv2c3ks2R+KlQ7JG9xiukcTLsv3uAiIY9yKMBvamjVt5iwnmbWalV2UTtjcDH49
         1zVeADiHp3FlvURofQHOatvIhHyaTGQC5Xug1gnaEMk98flxT5XmZpCjZSaCt64vM1qw
         f8rA==
X-Gm-Message-State: ANoB5pnz0MXOqgAdW0LtPYJkjeGxflEA4ultRl+OQ0y7KZadiln9ryyA
        uHzgc2kwp1cFUy6jKiIJqe6PJmMrfNR8Kw==
X-Google-Smtp-Source: AA0mqf6YMGzoNmLCmDE5OwahMwsNihO+8X6NjbcjP1wedicsJOUCucArx98BcVuNMGaDbcY++6btWg==
X-Received: by 2002:a0c:e841:0:b0:4bb:de25:e988 with SMTP id l1-20020a0ce841000000b004bbde25e988mr2773308qvo.131.1668187094013;
        Fri, 11 Nov 2022 09:18:14 -0800 (PST)
Received: from localhost (200.234.86.34.bc.googleusercontent.com. [34.86.234.200])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006ec62032d3dsm1793485qkp.30.2022.11.11.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:18:13 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:18:12 +0000
From:   Sean Paul <sean@poorly.run>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/2] drm_bridge: register content protect property
Message-ID: <Y26D1Of8FserYa2L@art_vandelay>
References: <20221102111148.1810314-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102111148.1810314-1-hsinyi@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 07:11:46PM +0800, Hsin-Yi Wang wrote:
> Some bridges are able to update HDCP status from userspace request if
> they support HDCP.
> 
> HDCP property is the same as other connector properties that needs to be
> created after the connecter is initialized and before the connector is
> registered.
> 
> If there exists a bridge that supports HDCP, add the property to the
> bridge connector.
> 

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2->v3:
> Only register the property when there exists any bridge that supports
> hdcp.
> ---
>  drivers/gpu/drm/drm_bridge_connector.c | 8 ++++++++
>  include/drm/drm_bridge.h               | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> index 1c7d936523df5..b4fb5da0b963f 100644
> --- a/drivers/gpu/drm/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/drm_bridge_connector.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  
> +#include <drm/display/drm_hdcp_helper.h>
>  #include <drm/drm_atomic_state_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_bridge_connector.h>
> @@ -333,6 +334,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  	struct i2c_adapter *ddc = NULL;
>  	struct drm_bridge *bridge, *panel_bridge = NULL;
>  	int connector_type;
> +	bool support_hdcp = false;
>  
>  	bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
>  	if (!bridge_connector)
> @@ -376,6 +378,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  
>  		if (drm_bridge_is_panel(bridge))
>  			panel_bridge = bridge;
> +
> +		if (bridge->support_hdcp)
> +			support_hdcp = true;
>  	}
>  
>  	if (connector_type == DRM_MODE_CONNECTOR_Unknown) {
> @@ -398,6 +403,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  	if (panel_bridge)
>  		drm_panel_bridge_set_orientation(connector, panel_bridge);
>  
> +	if (support_hdcp && IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
> +		drm_connector_attach_content_protection_property(connector, true);
> +
>  	return connector;
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 6b65b0dfb4fb4..1d2ab70f3436a 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -768,6 +768,10 @@ struct drm_bridge {
>  	 * modes.
>  	 */
>  	bool interlace_allowed;
> +	/**
> +	 * @support_hdcp: Indicate that the bridge supports HDCP.
> +	 */
> +	bool support_hdcp;
>  	/**
>  	 * @ddc: Associated I2C adapter for DDC access, if any.
>  	 */
> -- 
> 2.38.0.135.g90850a2211-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
