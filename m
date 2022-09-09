Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787D25B365C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiIIL3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiIIL3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:29:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF1139ACD;
        Fri,  9 Sep 2022 04:29:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lc7so3365715ejb.0;
        Fri, 09 Sep 2022 04:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date;
        bh=dl2woc6VxZxBG9PRHSyadBOfV8W4AihZHiXdGtwtKZk=;
        b=qyhZ3Lqk9YmDSbdq46SeszDEhNnUJGy1kd/Eii8q/jkN8+HHZKX7+TfYfrk+Fwsm3l
         3BCY+AraYvu9CQt1MpnbxXxBfZCqYkMCJ21WYviN8UvEgd2nJyL8MiqHxpa7JN7bPuU5
         9VDSorxTY96vvzFepULa15xSpzi5p6igLh3beppYZV/70zJFHYnLlBQcWfMU6UZQ/Rtu
         +vx9Mck6CXhcaZtgXHRWQv4d1PYrBAK4ihh1QCWSE91HrgsT8cEN/nCDKFCnWSorlzPL
         B/am96bP9BKbNHy+A36SsF59ulpapavktHz5kxkbzb6pcDEjyOB4wkPmUAjCLT+X5VKj
         lEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dl2woc6VxZxBG9PRHSyadBOfV8W4AihZHiXdGtwtKZk=;
        b=R6iDqhA4kf+Mn1vYuZ5h2Us7saw4FDzzq0crBTI5UBsxjzNG/X9kYI5hKM4iCkNOCK
         LuaYvNYD1li5f+nyj2txlb77cnf2yqrv5PYQ9WtSol0scOAjXJkvYY+yIMlEJn4oWb/S
         BGyDx6n6TyxhjdSo+2flsWe4kPOTleBsxKCgRYcRUswokH6gnAYQ8BhIfusUtKOg+uPn
         Oc4MSNnePk8PsxVcHJTbTdYpHLT6ulgS9n52waTv0Eaeqq/HWhdkXQy70gFyde9LY0Uu
         MVwIs3EN7pAOgVSLY4IRkyfW0PVGeNlPSDy639GmUb561jadH504Sl8iiZ8MzfR5bedA
         4YNQ==
X-Gm-Message-State: ACgBeo25/0vsZsP/QavkcJGdVmxXc67i+ae+VXAED0JY9xqZ/cAXh2KF
        Sl7oRecmD1D52XkL+uUSAiQ=
X-Google-Smtp-Source: AA6agR7txTvJieNQLG2Ek1WmWlvmgJNiEqXiWKf4wl5I9uI/ARQ//cqOjuc+E+gk6Ex8WDZniTl6JA==
X-Received: by 2002:a17:907:1c1e:b0:741:8abe:320e with SMTP id nc30-20020a1709071c1e00b007418abe320emr9838802ejc.123.1662722940989;
        Fri, 09 Sep 2022 04:29:00 -0700 (PDT)
Received: from localhost ([89.40.126.93])
        by smtp.gmail.com with ESMTPSA id os23-20020a170906af7700b00730860b6c43sm130758ejb.173.2022.09.09.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 04:29:00 -0700 (PDT)
Message-ID: <631b237c.170a0220.aed56.04f5@mx.google.com>
X-Google-Original-Message-ID: <YxtNoWt74SjNbrsF@<DarkDistro>>
Date:   Fri, 9 Sep 2022 14:28:49 +0000
From:   Burak Ozdemir <bozdemir@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Coding style clean up
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to coding style and fix camel casing in function name.

Signed-off-by: Burak Ozdemir <bozdemir@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3e09e56d3930..a86222cdcb68 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -120,7 +120,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 
 	sm750_hw_cursor_disable(cursor);
 	if (fbcursor->set & FB_CUR_SETSIZE)
-		sm750_hw_cursor_setSize(cursor,
+		sm750_hw_cursor_set_size(cursor,
 					fbcursor->image.width,
 					fbcursor->image.height);
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 43e6f52c2551..d5ef40b8bc8e 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -58,7 +58,7 @@ void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 	poke32(HWC_ADDRESS, 0);
 }
 
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h)
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
 {
 	cursor->w = w;
 	cursor->h = h;
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index b59643dd61ed..edeed2ea4b04 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -5,7 +5,7 @@
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
-void sm750_hw_cursor_setSize(struct lynx_cursor *cursor, int w, int h);
+void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
 void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
-- 
2.35.1

