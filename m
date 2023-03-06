Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DED6AC728
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjCFQEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCFQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:00:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50742ED53;
        Mon,  6 Mar 2023 08:00:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8406022401;
        Mon,  6 Mar 2023 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5AyqMEb/dcQWrJZGyOdvA+a4qQMQbwFfZc6UsGJ8JQ=;
        b=dVFyUP2baBGf9dvkncsVlo9MYCWDNFG8nv4glDhW5tyv5c1l0SjKbjM+FjMOKBGjKzvXDy
        jweZm0u6aG5G07WS9UYXGJSNRBXgBZoVYPSOfyGiYMO4fYhrHEkjh/frYiRznSvOJtYBhj
        zUGTakJjpUYEdzuqiLmyi/so6lgsLBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5AyqMEb/dcQWrJZGyOdvA+a4qQMQbwFfZc6UsGJ8JQ=;
        b=GlZsmHoIHEMsPv5KnPss40JCrUMMeKcNWxpjxNgeEhiq6g7kiJkUvutwGy962jW7c/A738
        +EuUu6pvHsU/agBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27D0513513;
        Mon,  6 Mar 2023 16:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wH6GCC0OBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:45 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@HansenPartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 55/99] fbdev/platinumfb: Remove trailing whitespaces
Date:   Mon,  6 Mar 2023 16:59:32 +0100
Message-Id: <20230306160016.4459-56-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306160016.4459-1-tzimmermann@suse.de>
References: <20230306160016.4459-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/platinumfb.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index 5b9e26ea6449..c7172174c1b7 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -52,17 +52,17 @@ struct fb_info_platinum {
 		__u8 red, green, blue;
 	}				palette[256];
 	u32				pseudo_palette[16];
-	
+
 	volatile struct cmap_regs	__iomem *cmap_regs;
 	unsigned long			cmap_regs_phys;
-	
+
 	volatile struct platinum_regs	__iomem *platinum_regs;
 	unsigned long			platinum_regs_phys;
-	
+
 	__u8				__iomem *frame_buffer;
 	volatile __u8			__iomem *base_frame_buffer;
 	unsigned long			frame_buffer_phys;
-	
+
 	unsigned long			total_vram;
 	int				clktype;
 	int				dactype;
@@ -133,7 +133,7 @@ static int platinumfb_set_par (struct fb_info *info)
 	platinum_set_hardware(pinfo);
 
 	init = platinum_reg_init[pinfo->vmode-1];
-	
+
  	if ((pinfo->vmode == VMODE_832_624_75) && (pinfo->cmode > CMODE_8))
   		offset = 0x10;
 
@@ -214,7 +214,7 @@ static int platinumfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			break;
 		}
 	}
-	
+
 	return 0;
 }
 
@@ -269,7 +269,7 @@ static void platinum_set_hardware(struct fb_info_platinum *pinfo)
 	struct platinum_regvals		*init;
 	int				i;
 	int				vmode, cmode;
-	
+
 	vmode = pinfo->vmode;
 	cmode = pinfo->cmode;
 
@@ -436,7 +436,7 @@ static int read_platinum_sense(struct fb_info_platinum *info)
  * This routine takes a user-supplied var, and picks the best vmode/cmode from it.
  * It also updates the var structure to the actual mode data obtained
  */
-static int platinum_var_to_par(struct fb_var_screeninfo *var, 
+static int platinum_var_to_par(struct fb_var_screeninfo *var,
 			       struct fb_info_platinum *pinfo,
 			       int check_only)
 {
@@ -478,12 +478,12 @@ static int platinum_var_to_par(struct fb_var_screeninfo *var,
 	pinfo->yoffset = 0;
 	pinfo->vxres = pinfo->xres;
 	pinfo->vyres = pinfo->yres;
-	
+
 	return 0;
 }
 
 
-/* 
+/*
  * Parse user specified options (`video=platinumfb:')
  */
 static int __init platinumfb_setup(char *options)
@@ -624,7 +624,7 @@ static int platinumfb_probe(struct platform_device* odev)
 		break;
 	}
 	dev_set_drvdata(&odev->dev, info);
-	
+
 	rc = platinum_init_fb(info);
 	if (rc != 0) {
 		iounmap(pinfo->frame_buffer);
@@ -640,9 +640,9 @@ static int platinumfb_remove(struct platform_device* odev)
 {
 	struct fb_info		*info = dev_get_drvdata(&odev->dev);
 	struct fb_info_platinum	*pinfo = info->par;
-	
+
         unregister_framebuffer (info);
-	
+
 	/* Unmap frame buffer and registers */
 	iounmap(pinfo->frame_buffer);
 	iounmap(pinfo->platinum_regs);
@@ -658,7 +658,7 @@ static int platinumfb_remove(struct platform_device* odev)
 	return 0;
 }
 
-static struct of_device_id platinumfb_match[] = 
+static struct of_device_id platinumfb_match[] =
 {
 	{
 	.name 		= "platinum",
@@ -666,7 +666,7 @@ static struct of_device_id platinumfb_match[] =
 	{},
 };
 
-static struct platform_driver platinum_driver = 
+static struct platform_driver platinum_driver =
 {
 	.driver = {
 		.name = "platinumfb",
-- 
2.39.2

