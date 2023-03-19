Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA45E6C02CF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCSPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjCSPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:32:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57F1DBB1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:32:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so13970889pjt.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679239960;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPrWJir7lxNPo+Fx2Bwr880Bubqv8L6flAF9k6fJd4s=;
        b=JR5EXuUCKQItR1YgBAGzSG/l/jQh7mhlZN0DRz/nCgUpJyvZS6AAe69X9yTdatrVsF
         RKvroR6zbRbAaaP8OzUZfzhfiJAgvPo9ru/zIXJ1XBbzbTl9ma1rJqCdW41kf+UrVTCi
         /yltmugG82mSiJTUm2J233weQ8N4107zDCdIP+XZYUa6Kc8xGwVC/lL79ch7Q+IGAcRK
         y0884sVEy2bXZgnO9AMK8lJqx6LUPFnG+wEQGa9uwyEUpKMgXiw5niNP1eYqUNnJH4Vm
         CASRZC8qEO/Y/LBTEQdWWa1zxxXVE1G1NbyFSI6yeoMB8yj7s7CVpcO8UdFTQhLdwTe+
         LTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679239960;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPrWJir7lxNPo+Fx2Bwr880Bubqv8L6flAF9k6fJd4s=;
        b=uCojzZL0/KXpG2n9VBqbtKB6WuGZYWf721aBCvMn2hqjhKacgcM+WqNwHyaPy1hbq5
         1Yz/h+LkXy0du+zAvp2QD0fn8KSypc7g7NVswQdh3wbmd6D7eRfwcmFWJmQ3hsr0f+gp
         AtJJL3vsMdT7qCVOGKpRFVhL+iUuKNoxbv8uIppnPqSaWisEq4iz51T2gYJvk+2HQMDQ
         Aj9/jFqqLWtiY+FwWjQ1ADd2QKFbGNQLunHlE/hTqqn5QlaWR96zY3grR6WekP0cig9d
         m8JRM2JYAI/4d/ZgYZktNoZwpBIOrMJplM1Gz5q4+CfT5SdMxQl4sBcavOvrn2lWc7kQ
         HsQA==
X-Gm-Message-State: AO0yUKUuMad4f0DhptLJNW4X6SXqezn68QFnojC+hgamhUwuW9oWlW28
        Uu/KrXk/2E6bydCE6Fu1HBs=
X-Google-Smtp-Source: AK7set/Oun619ZWobZxKdLezyu401eeSrUW0DdyE5832Z2L+3Rm2VJuPD2k38QY/ub73P5BABVDh7A==
X-Received: by 2002:a17:903:245:b0:199:2b9f:f369 with SMTP id j5-20020a170903024500b001992b9ff369mr18309309plh.32.1679239959976;
        Sun, 19 Mar 2023 08:32:39 -0700 (PDT)
Received: from CloudiRingWorld ([125.121.39.5])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902700300b0019908d2c85dsm4878009plk.52.2023.03.19.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 08:32:39 -0700 (PDT)
Date:   Sun, 19 Mar 2023 23:32:34 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     outreachy@lists.linux.dev, teddy.wang@siliconmotion.com,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
        linuxstaging@lists.linux.dev, linux-kernel@vger.kernel.org,
        alison.schofield@intel.com
Subject: [PATCH v4] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <ZBcrEp+VssZDxAnC@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303110849.X24WnHnM-lkp@intel.com/
Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>

---
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

