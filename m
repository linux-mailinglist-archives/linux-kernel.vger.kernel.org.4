Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36E266119E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjAGUhD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Jan 2023 15:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGUg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:36:59 -0500
X-Greylist: delayed 86859 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Jan 2023 12:36:57 PST
Received: from 3.mo583.mail-out.ovh.net (3.mo583.mail-out.ovh.net [46.105.40.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481156324
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 12:36:57 -0800 (PST)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.108.16.31])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4149D20A90
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 20:36:55 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-lxtls (unknown [10.110.115.90])
        by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id BD8F71FE98;
        Sat,  7 Jan 2023 20:36:50 +0000 (UTC)
Received: from sk2.org ([37.59.142.105])
        by ghost-submission-6684bf9d7b-lxtls with ESMTPSA
        id eSsCKuLXuWPI3wUAubRvvA
        (envelope-from <steve@sk2.org>); Sat, 07 Jan 2023 20:36:50 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-105G0067839b063-0764-4415-809e-52a6ec1d72ef,
                    DAE31E0ADBCC733EDB52157E78EF0D9B49FF90DC) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 37.167.110.121
Date:   Sat, 07 Jan 2023 21:36:47 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     sam@ravnborg.org,
        Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Sam Ravnborg <sam@ravnborg.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_01/15=5D_video=3A_fbdev=3A_atm?= =?US-ASCII?Q?el=5Flcdfb=3A_Rework_backlight_handling?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org> <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
Message-ID: <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 15557403441115072134
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkedvgddufeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeekvddvteekgedtkefgueefheetheefffdtfeeuveettdejjeeutdetkefggeegleenucffohhmrghinheplhhkmhhlrdhorhhgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 January 2023 19:26:15 CET, Sam Ravnborg via B4 Submission Endpoint <devnull+sam.ravnborg.org@kernel.org> wrote:
>From: Sam Ravnborg <sam@ravnborg.org>
>
>The atmel_lcdfb had code to save/restore power state.
>This is not needed so drop it.
>
>Introduce backlight_is_brightness() to make logic simpler.
>
>Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>Cc: linux-fbdev@vger.kernel.org
>Cc: linux-arm-kernel@lists.infradead.org
>---
> drivers/video/fbdev/atmel_lcdfb.c | 24 +++---------------------
> 1 file changed, 3 insertions(+), 21 deletions(-)
>
>diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
>index 1fc8de4ecbeb..d297b3892637 100644
>--- a/drivers/video/fbdev/atmel_lcdfb.c
>+++ b/drivers/video/fbdev/atmel_lcdfb.c
>@@ -49,7 +49,6 @@ struct atmel_lcdfb_info {
> 	struct clk		*lcdc_clk;
> 
> 	struct backlight_device	*backlight;
>-	u8			bl_power;
> 	u8			saved_lcdcon;
> 
> 	u32			pseudo_palette[16];
>@@ -109,32 +108,18 @@ static u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
> static int atmel_bl_update_status(struct backlight_device *bl)
> {
> 	struct atmel_lcdfb_info *sinfo = bl_get_data(bl);
>-	int			power = sinfo->bl_power;
>-	int			brightness = bl->props.brightness;
>+	int brightness;
> 
>-	/* REVISIT there may be a meaningful difference between
>-	 * fb_blank and power ... there seem to be some cases
>-	 * this doesn't handle correctly.
>-	 */
>-	if (bl->props.fb_blank != sinfo->bl_power)
>-		power = bl->props.fb_blank;
>-	else if (bl->props.power != sinfo->bl_power)
>-		power = bl->props.power;
>-
>-	if (brightness < 0 && power == FB_BLANK_UNBLANK)
>-		brightness = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
>-	else if (power != FB_BLANK_UNBLANK)
>-		brightness = 0;
>+	brightness = backlight_get_brightness(bl);
> 
> 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, brightness);
>+
> 	if (contrast_ctr & ATMEL_LCDC_POL_POSITIVE)
> 		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR,
> 			brightness ? contrast_ctr : 0);
> 	else
> 		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
> 
>-	bl->props.fb_blank = bl->props.power = sinfo->bl_power = power;
>-
> 	return 0;
> }
> 
>@@ -155,8 +140,6 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
> 	struct backlight_properties props;
> 	struct backlight_device	*bl;
> 
>-	sinfo->bl_power = FB_BLANK_UNBLANK;
>-
> 	if (sinfo->backlight)
> 		return;
> 
>@@ -173,7 +156,6 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
> 	sinfo->backlight = bl;
> 
> 	bl->props.power = FB_BLANK_UNBLANK;
>-	bl->props.fb_blank = FB_BLANK_UNBLANK;
> 	bl->props.brightness = atmel_bl_get_brightness(bl);
> }
> 
>

Hi Sam,

I’d submitted quite a few more of these previously (and you’d reviewed them), see e.g. the thread starting at https://lkml.org/lkml/2022/6/7/4365, and yesterday, https://lkml.org/lkml/2023/1/6/520, https://lkml.org/lkml/2023/1/6/656, https://lkml.org/lkml/2023/1/6/970, https://lkml.org/lkml/2023/1/6/643, and https://lkml.org/lkml/2023/1/6/680. There are a few more, I can find them if it’s any use.

Regards,

Stephen
