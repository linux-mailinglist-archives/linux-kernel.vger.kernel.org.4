Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F562721770
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjFDNaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFDNaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:30:03 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BBCD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 06:30:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126166129043.28.openmobile.ne.jp [126.166.129.43])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C8302CF;
        Sun,  4 Jun 2023 15:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685885376;
        bh=5IMZwnE0fr+/3IOAAjQBKuiQU9Gi7L3Wp+xMB7mcWzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iv5+EmBWCAJxeF/pQvQefzgBjo1jk9vTRoUaZbMA8kRGCQjOYsHDwUFxroGwTNhpv
         PECa5fH4KQEeOQSI0a3ww+MaWKpxpr+2+7RTURg62LtbSRV+j5KnNfaCAUDlpV8Jgb
         TAU1HFyPVWazJU30zCAe4Z8X+1ULz0YsEjFccvbQ=
Date:   Sun, 4 Jun 2023 16:29:57 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] drm/bridge: imx: turn imx8{qm,qxp}-ldb into
 single-object modules
Message-ID: <20230604132957.GC7754@pendragon.ideasonboard.com>
References: <20230604075713.1027261-1-masahiroy@kernel.org>
 <20230604075713.1027261-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604075713.1027261-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

Thank you for the patch.

On Sun, Jun 04, 2023 at 04:57:13PM +0900, Masahiro Yamada wrote:
> With the previous fix, these modules are built from a single C file.
> 
> Rename the source files so they match the module names.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/bridge/imx/Makefile                           | 4 ----
>  drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c => imx8qm-ldb.c} | 0
>  .../gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c => imx8qxp-ldb.c}   | 0
>  3 files changed, 4 deletions(-)
>  rename drivers/gpu/drm/bridge/imx/{imx8qm-ldb-drv.c => imx8qm-ldb.c} (100%)
>  rename drivers/gpu/drm/bridge/imx/{imx8qxp-ldb-drv.c => imx8qxp-ldb.c} (100%)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
> index 5fc821278693..8e2ebf3399a1 100644
> --- a/drivers/gpu/drm/bridge/imx/Makefile
> +++ b/drivers/gpu/drm/bridge/imx/Makefile
> @@ -1,10 +1,6 @@
>  obj-$(CONFIG_DRM_IMX_LDB_HELPER) += imx-ldb-helper.o
> -imx8qm-ldb-objs := imx8qm-ldb-drv.o
>  obj-$(CONFIG_DRM_IMX8QM_LDB) += imx8qm-ldb.o
> -
> -imx8qxp-ldb-objs := imx8qxp-ldb-drv.o
>  obj-$(CONFIG_DRM_IMX8QXP_LDB) += imx8qxp-ldb.o
> -
>  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_COMBINER) += imx8qxp-pixel-combiner.o
>  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK) += imx8qxp-pixel-link.o
>  obj-$(CONFIG_DRM_IMX8QXP_PIXEL_LINK_TO_DPI) += imx8qxp-pxl2dpi.o
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qm-ldb-drv.c b/drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
> similarity index 100%
> rename from drivers/gpu/drm/bridge/imx/imx8qm-ldb-drv.c
> rename to drivers/gpu/drm/bridge/imx/imx8qm-ldb.c
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb-drv.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> similarity index 100%
> rename from drivers/gpu/drm/bridge/imx/imx8qxp-ldb-drv.c
> rename to drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c

-- 
Regards,

Laurent Pinchart
