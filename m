Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA260DAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiJZGDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiJZGDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:03:04 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C69ABD7A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=nSeHqT0MAV/eN4BopDYHbyZl2GURD98RXLRWbEJUu74=; b=eeTTlpU7ry70GXhL+ZkEwOqS3/
        0kPVIk+djI3lpSQ+/mDA5ZGrhD5C0rROMCDYq+jujunqkCn7Jve77fe/VWwk1zuSz+Y+Xynpc5ZIA
        YYQj+UBp1t/VDTnd0XW7uiiFfA56Au8a0tk2icDkaN+9KbC2h947BVovRNWvQuZJPSU+3+tEQ4tIX
        7PPFDsgSVOMe2gopDM/7893+YARWyooC7AH/KXmq0ZB/8plur7j/FqTA4WH/K8TaYsL0ZU59x5CZE
        uokIDcCPlzkXrpyNUPIJceiJXAtF9I6Gl022j+btzJW5hjhpnjfG6uPvFTRt8k1d+f4j1zkzjxTqo
        tfIGPKnw==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1onZVA-00F5kA-1q; Wed, 26 Oct 2022 08:02:56 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1onZV9-001wlC-1U;
        Wed, 26 Oct 2022 08:02:55 +0200
Date:   Wed, 26 Oct 2022 08:02:55 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:DRM DRIVERS FOR ROCKCHIP" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] drm/rockchip: dw_hdmi: filter regulator -EPROBE_DEFER
 error messages
Message-ID: <Y1jNj1U04AkKEJBm@aurel32.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:DRM DRIVERS FOR ROCKCHIP" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>
References: <20220926203752.5430-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926203752.5430-1-aurelien@aurel32.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On 2022-09-26 22:37, Aurelien Jarno wrote:
> When the avdd-0v9 or avdd-1v8 supply are not yet available, EPROBE_DEFER
> is returned by rockchip_hdmi_parse_dt(). This causes the following error
> message to be printed multiple times:
> 
>     dwhdmi-rockchip fe0a0000.hdmi: [drm:dw_hdmi_rockchip_bind [rockchipdrm]] *ERROR* Unable to parse OF data
> 
> Fix that by not printing the message when rockchip_hdmi_parse_dt()
> returns -EPROBE_DEFER.
> 
> Fixes: ca80c4eb4b01 ("drm/rockchip: dw_hdmi: add regulator support")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index c14f88893868..2f4b8f64cbad 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -565,7 +565,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  
>  	ret = rockchip_hdmi_parse_dt(hdmi);
>  	if (ret) {
> -		DRM_DEV_ERROR(hdmi->dev, "Unable to parse OF data\n");
> +		if (ret != -EPROBE_DEFER)
> +			DRM_DEV_ERROR(hdmi->dev, "Unable to parse OF data\n");
>  		return ret;
>  	}
>  
> -- 
> 2.35.1
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
