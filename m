Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87756B52E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjCJVdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjCJVdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:33:12 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B579A18A92
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:33:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id ce7so4482898pfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678483985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MoaC0QiQ/9QcOQ36YWPBiC9jUnAlg67n+4UaCtTxLVw=;
        b=bLxj6b7Qgt9s1e3O4FjFVTogIcSBM18UR17GYQs72arAv4JZHt5b46HYRzakpM7+1G
         MpBv3mpmwkLgfEKcv58MrYMXQz91SCemZqOoYDZjY4BMwbcTtF2XzDpN9oC/+mRqitOm
         6ma7gU7I41xeCJFjnnzfhhnl6Vj09TydFqoVE6S7yl3wAgWYloi4730Pk0WAv2q+I899
         Zatoa6VWRzgpSiGdFppU/9sjezH1NsKWnbo+FElccAuq59DnRdwPxyCbk+90eG0sKtes
         74RlW5wHsQFrjtO5r21o+mvVZxy23kRPW/Lx/wLszZAGS9UlDRPuqVsTx/8M38rDqDs0
         tSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678483985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MoaC0QiQ/9QcOQ36YWPBiC9jUnAlg67n+4UaCtTxLVw=;
        b=lZ35O0T1VO5fSqXfFr7PKcRmFaHim8pk5gMPG0bBjyEX3R1RZcsBUZNSNb+jrNKgEw
         IIhTcpEA5KBim0GGozb9Nynk6xIgI6XFlbc4PCmnpeE2+04VdP8f8Uq1DmiQv08hnTM3
         Al1Pzu0ud3ZG2XmNvAAbGeGuZOrMkQtMqmqc7zjDVn7EsOZp/JN8S7yMKhPVUDVsX4MR
         bJuf18DJblMVJcmANQgAzfpCO3CU8Lclk8SvzlN6EmF9Hsms4NnYrqdScekxVbTe9i7W
         m/fVLMTGfR5wVQCs2BrUhO/PZLPuNqdFfK3W1s8At+5xnxqxZiILfqtK7wbejCOem+rm
         +K6w==
X-Gm-Message-State: AO0yUKVWp47VXMERBQO9M2UyJYA2bI9VnsGdAcQwL0MVxsqVqdjKjg43
        o8HaTKrYEs7s+4ooGvqZGM/KW+pKakwXXO2LgTg=
X-Google-Smtp-Source: AK7set/seiXL46DulSZFllvj/Q29a2aaDl7sexo6g7bgSAEdGr+iYL92z7JkeIq2vEWkYuwGMQXZrA==
X-Received: by 2002:aa7:941d:0:b0:5ce:ef1b:a86 with SMTP id x29-20020aa7941d000000b005ceef1b0a86mr24480973pfo.2.1678483985579;
        Fri, 10 Mar 2023 13:33:05 -0800 (PST)
Received: from CloudiRingWorld ([122.231.69.163])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b005cc52ea452csm243525pfo.100.2023.03.10.13.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:33:05 -0800 (PST)
Date:   Sat, 11 Mar 2023 05:33:01 +0800
From:   Kloudifold <cloudifold.3125@gmail.com>
To:     teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750: Rename camel case functions in sm750_cursor.*
Message-ID: <ZAuiDTDT8dmBcRoH@CloudiRingWorld>
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
checkpatch.pl by renaming camel case functions.

Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 14 +++++++-------
 drivers/staging/sm750fb/sm750_cursor.h | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

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

