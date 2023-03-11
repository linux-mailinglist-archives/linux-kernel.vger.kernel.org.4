Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5427F6B57C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 03:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCKCSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 21:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCKCSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 21:18:30 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B946171
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 18:18:28 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y2so7019953pjg.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678501108;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xF5ccHQndDVMafnc8PuwPSnqfThQIzwYoAQPJ5moTkU=;
        b=WlAVqipFrutqeQb1LajnOTIrmYIXwq9kFjOcmZD660P+1aV6/rbWQ9oIfAIh7iSk9x
         ZvyKWy03fszidlyY5yzJDBp5JQ6OpzfepjV+ux9JKRMY8mqu9lURxzKVW6J2uBWXV4+M
         K0//tsuzPDyNSzOgRnlllrhb40CqCJCMMhoX/nGBsnuZ2Lrh3pgLlt4ekA44vAsty6rS
         isvZ33P41ZMJgGYnT+tC6CMN57vUcizL6v3G+/fOzaTAvaXc6ZbQko8LMntYzLwLaELW
         ZVX4y/pxL8fRGOB03/SmZkVPDfc6Ag+qPhECodK8CcHth+bPCyouarUOwwlq4GP6jWJY
         ZsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678501108;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF5ccHQndDVMafnc8PuwPSnqfThQIzwYoAQPJ5moTkU=;
        b=w+KmpuuY9AcyrZx88/lbIDUiu7fCEL877WSZoP6H+35XGY82UBPVaV8x6TGXCGEcrQ
         EkDT8Uyajw4V+JLbKOZ2LUJ7vbPuPNM28cXMTJxWazQUwNrQijpNBxvYDZzy1lG0IpF8
         Zicbw/Pl8ORwJoa/bVKnhjOpWPm19zpN9Nfsw8YxQBnr5KgA9m9rjL+oTE0dyebqfHO0
         GBAAshP2pvRce96Rv3t3/ppamZP70YgMFXrwbfAV8jGL2VNjMV1ikxG8h9oizmowrnr0
         nJiV63Zm5y21o2ptUQm8r6UKJi4TPVYRuMv/Voxjop9xG6OkQPWYXWGA7JJJwJ5S3Wyz
         xJUg==
X-Gm-Message-State: AO0yUKUjircFmrhbPnADi2aseArh4oB6CsP9GRltjXYm2Ra+OoODj7e2
        K/yjPFmZVvY48VaFCIZVbYMWYLNI/qyMXrDU8ac=
X-Google-Smtp-Source: AK7set+0kYfrFMPUhKsT2aeyolXR9POz42C/YWqY7OiQeI+wo3MdeL5OZdDyCrgilNNF9t3SP/+j1w==
X-Received: by 2002:a17:90a:498b:b0:236:84a:8d9d with SMTP id d11-20020a17090a498b00b00236084a8d9dmr28551727pjh.39.1678501107874;
        Fri, 10 Mar 2023 18:18:27 -0800 (PST)
Received: from CloudiRingWorld ([122.231.69.163])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b0019c13d032d8sm553143ple.253.2023.03.10.18.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 18:18:27 -0800 (PST)
Date:   Sat, 11 Mar 2023 10:18:25 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750: Rename camel case functions
Message-ID: <ZAvk8SGjwdYlHEU6@CloudiRingWorld>
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

This patch fixes the "CHECK: Avoid CamelCase" reported by
checkpatch.pl by renaming camel case functions in
sm750_cursor.c and sm750_cursor.h.
Modified calls to functions declared in sm750_cursor.h in sm750.c.

Fixed issue in [PATCH] staging: sm750: Rename camel case functions in sm750_cursor.*
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/

Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 22 +++++++++++-----------
 drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
 drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index effc7fcc3..5d7249e82 100644
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
+					fbcursor->image.dx - info->var.xoffset,
+					fbcursor->image.dy - info->var.yoffset);
 
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
2.39.2

