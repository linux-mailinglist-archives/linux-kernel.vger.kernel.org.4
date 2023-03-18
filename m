Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C836BFA45
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCRNf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRNfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:35:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2FD337
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:35:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so11921483pjg.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679146553;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFodAt8hICojWsebZxoHRfdgjioP9zm42Y5GErUuaC4=;
        b=jh/KQLV+QmmTvXYai1/XdSMAj3OGj+IrxBl04pPMMYTSlZvPYJPXTbnpBPAObzga0a
         9592/qURjndvPZr75xZU7t/F6zs+KUMUlesTU3uJoBYCaz9/bIoNWrHvH9xi8m+48E03
         f/zAYEIY+0NmkpwoQSmuyrmbB44uSq/e/oDCCcrfvQEC13gzNCqUnTt/25e23GKipfRb
         4h9mcW243DaAQMqGC8zsWLRvnXctp2JMhEdexbOLJlhH0swl1Rqb0y/aXwVn9LbMYjb6
         3ZPSuXRq5yD3G8yi+iQiDIuEz7NpjgkbpwIwUuXKX5o0s3GsoT/bRezCJec51P0sSXJt
         1U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679146553;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFodAt8hICojWsebZxoHRfdgjioP9zm42Y5GErUuaC4=;
        b=Z28h7532UoE8MrpIIF86jnkZSuGLcKFd36oDuvLaHgwJytgcOaFKTzFhqZ8ztJij7T
         ieviAnknNPHo3vmJ0ismI9Yo/cI0EJSYpveFg11IITIY7BMwxEf3AMGGtH3a7DY7nRNy
         ILojQoUkGj4CFAGPYR8ghWqw7z/GwtUIAHQyAUJvLP0e1B5Q0Y0J8MpaujwL+qM5zIJI
         2FGDxOxRQ1cx1wJiPNEjuS4BhVrBxVNEQFBdc+k0TB/vyQde7mh1KTvkZ8Etp1Lm+/ND
         lsUjeume///5aO+vYVAB+j+I8uBO+b4VqtjRyQvhwI3XJFLhYMYEr066+7qgleIJgLga
         vqnw==
X-Gm-Message-State: AO0yUKUsK7GeU0FSyqQ+Fc85tuz/AZtfbK3sTJh9YTAsYQbv0pPeo3VP
        7/u6jVPKwukegM8fZz6oxso=
X-Google-Smtp-Source: AK7set+JQRi7cvADV/xUAu+/4x/73hxwJoQ8a73ZbdHjvkaMJJVV1alrtvK9WDbRFCmp/x0mpF6j1g==
X-Received: by 2002:a05:6a20:ba90:b0:cd:2aa6:94d6 with SMTP id fb16-20020a056a20ba9000b000cd2aa694d6mr7326440pzb.21.1679146553305;
        Sat, 18 Mar 2023 06:35:53 -0700 (PDT)
Received: from CloudiRingWorld ([60.188.201.163])
        by smtp.gmail.com with ESMTPSA id q27-20020a63505b000000b0050bebfe464dsm3163482pgl.53.2023.03.18.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 06:35:52 -0700 (PDT)
Date:   Sat, 18 Mar 2023 21:35:49 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     outreachy@lists.linux.dev, teddy.wang@siliconmotion.com,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        alison.schofield@intel.com
Subject: [PATCH v3] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <ZBW+NX4SLaCyEnJd@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sm750 driver has sm750_hw_cursor_* functions, which are named in
camelcase. Rename them to snake case to follow the function naming
convention.

Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>

---
Changes in v3:
- Add this changelog (Philipp)
- Move lkp tags and link to the correct location in commit log (Alison)
- Update the commit msg (Philip)
- Update the commit log (Bagas, Julia)

Changes in v2:
- Use new function names in call sites (LKP)

This v2 patch was prompted by an error reported by the Linux test
robot, which detected the compile error.
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
---
---
 drivers/staging/sm750fb/sm750.c        | 22 +++++++++++-----------
 drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
 drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index effc7fcc3..a1254f693 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -121,14 +121,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		sm750_hw_cursor_setSize(cursor,
-					fbcursor->image.width,
-					fbcursor->image.height);
+		sm750_hw_cursor_set_size(cursor,
+					 fbcursor->image.width,
+					 fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
-		sm750_hw_cursor_setPos(cursor,
-				       fbcursor->image.dx - info->var.xoffset,
-				       fbcursor->image.dy - info->var.yoffset);
+		sm750_hw_cursor_set_pos(cursor,
+				       	fbcursor->image.dx - info->var.xoffset,
+				       	fbcursor->image.dy - info->var.yoffset);
 
 	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
@@ -142,14 +142,14 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 		     ((info->cmap.green[fbcursor->image.bg_color] & 0xfc00) >> 5) |
 		     ((info->cmap.blue[fbcursor->image.bg_color] & 0xf800) >> 11);
 
-		sm750_hw_cursor_setColor(cursor, fg, bg);
+		sm750_hw_cursor_set_color(cursor, fg, bg);
 	}
 
 	if (fbcursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
-		sm750_hw_cursor_setData(cursor,
-					fbcursor->rop,
-					fbcursor->image.data,
-					fbcursor->mask);
+		sm750_hw_cursor_set_data(cursor,
+					 fbcursor->rop,
+					 fbcursor->image.data,
+					 fbcursor->mask);
 	}
 
 	if (fbcursor->enable)
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 43e6f52c2..ff643e33f 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -58,13 +58,13 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 	poke32(HWC_ADDRESS, 0);
 }
 
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
 }
 
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
 {
 	u32 reg;
 
@@ -73,7 +73,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
 	poke32(HWC_LOCATION, reg);
 }
 
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg)
 {
 	u32 reg = (fg << HWC_COLOR_12_2_RGB565_SHIFT) &
 		HWC_COLOR_12_2_RGB565_MASK;
@@ -82,8 +82,8 @@ void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg)
 	poke32(HWC_COLOR_3, 0xffe0);
 }
 
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-			     const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
+			      const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask, opr;
@@ -132,8 +132,8 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 	}
 }
 
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
-			      const u8 *pcol, const u8 *pmsk)
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
+			       const u8 *pcol, const u8 *pmsk)
 {
 	int i, j, count, pitch, offset;
 	u8 color, mask;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index b59643dd6..88fa02f63 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -5,11 +5,11 @@
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
-void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
-void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-			     const u8 *data, const u8 *mask);
-void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
+void sm750_hw_cursor_set_color(struct lynx_cursor *cursor, u32 fg, u32 bg);
+void sm750_hw_cursor_set_data(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *data, const u8 *mask);
+void sm750_hw_cursor_set_data2(struct lynx_cursor *cursor, u16 rop,
+			       const u8 *data, const u8 *mask);
 #endif
-- 
2.40.0

