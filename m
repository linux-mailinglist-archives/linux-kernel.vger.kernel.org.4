Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D5B614BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKANlv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Nov 2022 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKANlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:41:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA1D8B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:41:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oprWS-0007ZC-EL; Tue, 01 Nov 2022 14:41:44 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oprWS-001geW-5m; Tue, 01 Nov 2022 14:41:43 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oprWQ-0009cc-BU; Tue, 01 Nov 2022 14:41:42 +0100
Message-ID: <f8f5479739acd3bded9f06f8678ca42b77a0a0ef.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: Kconfig: Remove duplicated 'select
 DRM_KMS_HELPER' line
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, tzimmermann@suse.de
Date:   Tue, 01 Nov 2022 14:41:42 +0100
In-Reply-To: <20221009023527.3669647-1-victor.liu@nxp.com>
References: <20221009023527.3669647-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On So, 2022-10-09 at 10:35 +0800, Liu Ying wrote:
> A duplicated line 'select DRM_KMS_HELPER' was introduced in Kconfig file
> by commit 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option"),
> so remove it.
> 
> Fixes: 09717af7d13d ("drm: Remove CONFIG_DRM_KMS_CMA_HELPER option")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/imx/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> index 975de4ff7313..fd5b2471fdf0 100644
> --- a/drivers/gpu/drm/imx/Kconfig
> +++ b/drivers/gpu/drm/imx/Kconfig
> @@ -4,7 +4,6 @@ config DRM_IMX
>  	select DRM_KMS_HELPER
>  	select VIDEOMODE_HELPERS
>  	select DRM_GEM_DMA_HELPER
> -	select DRM_KMS_HELPER
>  	depends on DRM && (ARCH_MXC || ARCH_MULTIPLATFORM || COMPILE_TEST)
>  	depends on IMX_IPUV3_CORE
>  	help

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

and pushed to drm-misc-fixes.

regards
Philipp
