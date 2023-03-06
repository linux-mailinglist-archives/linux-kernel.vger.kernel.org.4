Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75206AC74D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCFQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjCFQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:01:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D28D36696;
        Mon,  6 Mar 2023 08:01:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8DF771FF07;
        Mon,  6 Mar 2023 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXGv0fdp1SeaTBkcusJuAlPjwuf6QThoq9N0qSVQosw=;
        b=xEBvVtc7IHAwtr8aMdThOyNogMbo2jDUcd40NuQu+ZPz+tWqoZ3ZgZIb28m0Vth5qLdT1O
        TdfRrjPUmkmyFds2fInAA4eFuEns6jW/mtJ+uu3xLJkNAoPapFXbrluzXcaSVdl/qIEZDK
        Uky6A4KqcMOhZUQV4qDzWlWPWouO9PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MXGv0fdp1SeaTBkcusJuAlPjwuf6QThoq9N0qSVQosw=;
        b=N+XPBP7uH1ru2SSAXWo9HC/OdhcR8kP2omP1FXPZhhMsytvzeSYbJ6G0WttlIcnv7XJbHk
        HdhebkDvmKr83gAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 330F013513;
        Mon,  6 Mar 2023 16:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YFeSCzwOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:01:00 +0000
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
Subject: [PATCH 93/99] fbdev/vfb: Remove trailing whitespaces
Date:   Mon,  6 Mar 2023 17:00:10 +0100
Message-Id: <20230306160016.4459-94-tzimmermann@suse.de>
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
 drivers/video/fbdev/vfb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 95d3c59867d0..680c88267ef4 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -110,7 +110,7 @@ static u_long get_line_length(int xres_virtual, int bpp)
      *  First part, xxxfb_check_var, must not write anything
      *  to hardware, it should only verify and adjust var.
      *  This means it doesn't alter par but it does use hardware
-     *  data from it to check this var. 
+     *  data from it to check this var.
      */
 
 static int vfb_check_var(struct fb_var_screeninfo *var,
@@ -168,7 +168,7 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 
 	/*
 	 * Now that we checked it we alter var. The reason being is that the video
-	 * mode passed in might not work but slight changes to it might make it 
+	 * mode passed in might not work but slight changes to it might make it
 	 * work. This way we let the user know what is acceptable.
 	 */
 	switch (var->bits_per_pixel) {
@@ -234,8 +234,8 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
 }
 
 /* This routine actually sets the video mode. It's in here where we
- * the hardware state info->par and fix which can be affected by the 
- * change in par. For this driver it doesn't do much. 
+ * the hardware state info->par and fix which can be affected by the
+ * change in par. For this driver it doesn't do much.
  */
 static int vfb_set_par(struct fb_info *info)
 {
@@ -378,7 +378,7 @@ static int vfb_pan_display(struct fb_var_screeninfo *var,
 }
 
     /*
-     *  Most drivers don't need their own mmap function 
+     *  Most drivers don't need their own mmap function
      */
 
 static int vfb_mmap(struct fb_info *info,
-- 
2.39.2

