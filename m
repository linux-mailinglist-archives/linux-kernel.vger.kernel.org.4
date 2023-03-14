Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A126B9D82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCNRvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCNRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:51:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A3B421C;
        Tue, 14 Mar 2023 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678816230; i=deller@gmx.de;
        bh=hiRcwa3Bj6JP6LNEczfBcFHjplGK9+ZvNc9H7ZoMwPs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EAc0R3bNgjecoU592ZKL/GAsi5xFKouguRxsWXdi9FOTSlJvlOCPoA4Q23IdXE42A
         xsiaiiL1wfbvpesw6kr8h/UnPPqh039w4tNxK3+8EV7pxYJr+uf6lzeXcWQD0mt0eP
         j0jywFFss1HHvJQ/s6dzVYQIPpRrNtn3qPfwUuMo5iQ5MYDGF6rm/klDzI9flXwJGi
         IYHtBxrdg7N7Ncew7vx4dmFNriSK+RkdKooVbYTYGJenNPIEIerryR/5xwi20HOQbz
         mgzxSgOD3pVMK96unXtrUMm74jb0PNDDCP5j0wh7Je6ggA2UGNCft+t2ObL6E3mXIh
         NJdLinM/NYmVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.156.222]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1q8i3d2t7P-00fm7k; Tue, 14
 Mar 2023 18:50:30 +0100
Message-ID: <8ace3dfb-a254-849f-614c-e3ab262a326a@gmx.de>
Date:   Tue, 14 Mar 2023 18:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] fbdev: omapfb: remove omap1 osk driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230314162720.759220-1-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230314162720.759220-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o5cuRxTMJaH64czFiaSigYfCyUGemdhcMG6VLO5HIGBBl4kjnH/
 jO3Goz+1UkP4NilMknd10y/vj8jA7YC2U22HiffnPxeI9/Um6NRhuT6NV8c0CsXjHOdz/nG
 Ar9dSmXfcaKfCAX5ktHGI6tf1d7gR8khgJKTr112LE5GTggAnzPjDOaD9j8RSLtksrX09vg
 WeiJL0hLJdh9R0SBC29Lg==
UI-OutboundReport: notjunk:1;M01:P0:3lGrawyPYt8=;U5APRKzheTzr2fYF/kshZ2MTMaP
 vx0a9gSExdrK6Rd8uLOYibFPOTe41iHW9NyBw39JP2J/y88TZwIGe0IA7en6SLhhsAlqQeept
 ZhKUS/vyZMzqCU7LsAR1kFynDVZyI2iXxX2CUYjGP3NKeli1cNmCZ7gY1ujEh2kYwkku80OtA
 3wOMC9ndpnzTM92ROQQbCsfV1Zv5NfbjShml4iiZGlqOeOs+1M3moXYZK8KaTvHrebJgSSIkA
 j3ZGfVzjtl7XI8EU0tBf5GmiB25vhulTrf0eQZPVB0dj/9HUM1YX6+cCGmzMKbjEthLlNBfDD
 +ApLnNiPl+VWuR46gq3IddRVCVpPHHFlJSsQc4duTUfUNesTfSMfZQJFZFmOrsxV5L8io9W8D
 0ZfZoLVqf4MTTpt+aeXaUUMW31kWtiXcZ+1ViY7U1hwbjinxGTU9YpcA7cnjBO4J1aQzF4ar7
 n5FbUKSKfHhl0D3pt1tjSZOl8g4/IV5oi2Bx8ctL3R0TJ2JgyHN0hw7sUtD1cGKhOHQteZgO9
 gnKgN93UHFqCHOz68afvW8vLXArrIv/6cYFjVrOPZq17qhMledwq/aF5AF3aeRzPAEdOTuldY
 pTvSSuOwQclFE5aXolr0k5HrEMn3mS7VOYKep8JuZ+9yo9J6Ev703aeJIrXmQDDZEckmPAMzo
 rZ2eoSpGW6gCBWLBOD7Xbffoa3A6WeBEhigeLukjf4/IJd8zRKdC2N4dLCUVQs9WWqj4wpLT6
 q+MN+we+rbv8Sz3KExE4pwVYYZDsyW7FHiGcfX5j7kbszc+Mq29m0eDhA6m3xy8Ko07jgruTI
 v7cN0KuSrNFyKIB8yfFvYiFnCS69rNCBKtLJu4wb+fL6b4+yf2ZAy7UW+q+WEzymCWhNkA10X
 5KC94F6HQA6vU6iv6XEyL6JAu7dw1U20LrPkTcQP6ItSbMAO8UrI96oZOe4nGTJ7gNCADwKyt
 sf2Wfg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 17:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Commit 21a3e6eed423 ("ARM: omap1: remove osk-mistral add-on board
> support") removed the platform_device definition for the "lcd_osk"
> device, so this driver is now unused and can be removed as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/omap/Makefile  |  1 -
>   drivers/video/fbdev/omap/lcd_osk.c | 86 ------------------------------
>   2 files changed, 87 deletions(-)
>   delete mode 100644 drivers/video/fbdev/omap/lcd_osk.c
>
> diff --git a/drivers/video/fbdev/omap/Makefile b/drivers/video/fbdev/oma=
p/Makefile
> index 504edb9c09dd..6d5082c76919 100644
> --- a/drivers/video/fbdev/omap/Makefile
> +++ b/drivers/video/fbdev/omap/Makefile
> @@ -18,7 +18,6 @@ objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) +=3D hwa742.o
>
>   lcds-y$(CONFIG_MACH_AMS_DELTA) +=3D lcd_ams_delta.o
>   lcds-y$(CONFIG_MACH_OMAP_PALMTE) +=3D lcd_palmte.o
> -lcds-y$(CONFIG_MACH_OMAP_OSK) +=3D lcd_osk.o
>
>   lcds-y$(CONFIG_FB_OMAP_LCD_MIPID) +=3D lcd_mipid.o
>
> diff --git a/drivers/video/fbdev/omap/lcd_osk.c b/drivers/video/fbdev/om=
ap/lcd_osk.c
> deleted file mode 100644
> index 8168ba0d47fd..000000000000
> --- a/drivers/video/fbdev/omap/lcd_osk.c
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * LCD panel support for the TI OMAP OSK board
> - *
> - * Copyright (C) 2004 Nokia Corporation
> - * Author: Imre Deak <imre.deak@nokia.com>
> - * Adapted for OSK by <dirk.behme@de.bosch.com>
> - */
> -
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/gpio.h>
> -
> -#include <linux/soc/ti/omap1-io.h>
> -#include <linux/soc/ti/omap1-mux.h>
> -
> -#include "omapfb.h"
> -
> -static int osk_panel_enable(struct lcd_panel *panel)
> -{
> -	/* configure PWL pin */
> -	omap_cfg_reg(PWL);
> -
> -	/* Enable PWL unit */
> -	omap_writeb(0x01, OMAP_PWL_CLK_ENABLE);
> -
> -	/* Set PWL level */
> -	omap_writeb(0xFF, OMAP_PWL_ENABLE);
> -
> -	/* set GPIO2 high (lcd power enabled) */
> -	gpio_set_value(2, 1);
> -
> -	return 0;
> -}
> -
> -static void osk_panel_disable(struct lcd_panel *panel)
> -{
> -	/* Set PWL level to zero */
> -	omap_writeb(0x00, OMAP_PWL_ENABLE);
> -
> -	/* Disable PWL unit */
> -	omap_writeb(0x00, OMAP_PWL_CLK_ENABLE);
> -
> -	/* set GPIO2 low */
> -	gpio_set_value(2, 0);
> -}
> -
> -static struct lcd_panel osk_panel =3D {
> -	.name		=3D "osk",
> -	.config		=3D OMAP_LCDC_PANEL_TFT,
> -
> -	.bpp		=3D 16,
> -	.data_lines	=3D 16,
> -	.x_res		=3D 240,
> -	.y_res		=3D 320,
> -	.pixel_clock	=3D 12500,
> -	.hsw		=3D 40,
> -	.hfp		=3D 40,
> -	.hbp		=3D 72,
> -	.vsw		=3D 1,
> -	.vfp		=3D 1,
> -	.vbp		=3D 0,
> -	.pcd		=3D 12,
> -
> -	.enable		=3D osk_panel_enable,
> -	.disable	=3D osk_panel_disable,
> -};
> -
> -static int osk_panel_probe(struct platform_device *pdev)
> -{
> -	omapfb_register_panel(&osk_panel);
> -	return 0;
> -}
> -
> -static struct platform_driver osk_panel_driver =3D {
> -	.probe		=3D osk_panel_probe,
> -	.driver		=3D {
> -		.name	=3D "lcd_osk",
> -	},
> -};
> -
> -module_platform_driver(osk_panel_driver);
> -
> -MODULE_AUTHOR("Imre Deak");
> -MODULE_DESCRIPTION("LCD panel support for the TI OMAP OSK board");
> -MODULE_LICENSE("GPL");

