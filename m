Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA76CBD42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjC1LRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC1LRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:17:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6976E3AB8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:16:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so12113019pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680002218;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=InxFLatEqRcEzuJM4ZUoYOwLaBSxMoRwmUMsvneXWo0=;
        b=RVbsHkk4KiXAXciWng702tzBSbQlB3D5RaKwuqWtTZGzJmic1fBVktXlOtGjQ8tenC
         l52fI56Y6XqVxuu/npnzdoTEqJW+S9D4yEJmuU1sDl/KmoTb3wdOqaX0RyEsOD5VW2ks
         7vl7GpOHCwA9Ni41/LJSRUK70H6vCapDnwi/R1UT8jk6VAyat2ymaQR1CUC716NBN+lF
         0J501tCryIUKhbE9HBr7bTK7y4UoKn1XWO1qvJPVtOvDzidphYVHQWlnOJAR20sKJUX/
         bXVgXpYN0q4JCUH2/ppAU9SvSF9di3oy1eQz7ntHJK6fFNvZfc2u+cmWvn+TmBN25TGG
         2tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002218;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InxFLatEqRcEzuJM4ZUoYOwLaBSxMoRwmUMsvneXWo0=;
        b=OgcFTjQrv9RV6yBcMA9QgYn7O9F1/ybDNYgKZUZ8aMKhYByK5tFjOYqbtticfxQdhp
         1lXvsn5hsArLEy9Sx5N49LxKFI+rUan8iLu+CA4tlwWWMFlp8EK6ptCGoVD+qCQ6msBw
         3h9shK0o5O0GT/Jh5JJOzj48rVahXgTdWSnPhQe3YV0qFZGfT88eDjphus08iXGgzvos
         k0kZmVTfkY3LxN87dPT3WJhoDMGLGNxSmMUxP3c1qsOXBhQcnkC7YOlQKqFLqY1AD89l
         /bL/zoErzhxBWw0QCvrWT6YzHL1Dkz/RzNwG8+fnbUizp5VKwBxoWsXu1gL+tNU/htzv
         sdZA==
X-Gm-Message-State: AO0yUKWc+YQZoeSoUS0sRqUAVBfoHeC5OHVCGKEwcQghQtOOAvuR6Qhd
        Lh3iJ3FvN03wIQL4mQMpZBc=
X-Google-Smtp-Source: AK7set+89/QqTrp5C2rUFZQAgr9cbO5Tm4U1jxZrYS99x5jno8l6J0vCFPg5xqm/tyJRH6oDkSWPlQ==
X-Received: by 2002:a05:6a20:1221:b0:db:443b:58d0 with SMTP id v33-20020a056a20122100b000db443b58d0mr12493214pzf.12.1680002217745;
        Tue, 28 Mar 2023 04:16:57 -0700 (PDT)
Received: from CloudiRingWorld ([60.186.165.89])
        by smtp.gmail.com with ESMTPSA id e17-20020a62ee11000000b0062ce765b7afsm6065299pfi.162.2023.03.28.04.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:16:57 -0700 (PDT)
Date:   Tue, 28 Mar 2023 19:16:54 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     outreachy@lists.linux.dev, teddy.wang@siliconmotion.com,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        alison.schofield@intel.com
Subject: [PATCH v5] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <ZCLMAJ5APrFRMCWu@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=4.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sm750 driver has sm750_hw_cursor_* functions, which are named in
camelcase. Rename them to snake case to follow the function naming
convention.

- sm750_hw_cursor_setSize  => sm750_hw_cursor_set_size
- sm750_hw_cursor_setPos   => sm750_hw_cursor_set_pos
- sm750_hw_cursor_setColor => sm750_hw_cursor_set_color
- sm750_hw_cursor_setData  => sm750_hw_cursor_set_data
- sm750_hw_cursor_setData2 => sm750_hw_cursor_set_data2

Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>

---
Changes in v5:
- Include missed recipients in v4, no functional change to the code

Changes in v4:
- Update the commit msg (Deepak)
- Use tabs replace 8 spaces

This v4 patch was prompted by 2 errors, 2 warnings and 1 checks reported
by the scripts/checkpatch.pl, which detected the style problem.

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
2.40.0

