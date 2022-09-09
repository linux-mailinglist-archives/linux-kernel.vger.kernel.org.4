Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25325B37C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIIM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiIIM2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:28:44 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D512D189;
        Fri,  9 Sep 2022 05:28:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z8so2264460edb.6;
        Fri, 09 Sep 2022 05:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date;
        bh=DZugOTI9KxAAOxuZDWfK5HFNxfJINOMz8DoYNPEVrxE=;
        b=lP6IXIosqw1mX3RUVPRs96rv8hOGgFuRGED7qFb42YRjSWI+CeLsmTvzWjajwO5BSB
         +f6ubmLcdB3LEqhpZp4TSWAY/VZrcKtUa4qie7UUihIxnLNtb6kmCIfVfQYcdRbMpqO5
         Y6KtvYWJCCOVdzelCUIVkry7ACt3ikyTuwJFA03MZUKmDA7fwvUgSw4onBsGuyMu+eS0
         E7/aPdvEJxov6gphSzPzat9KHTW7tdp5B0NFqXSDxA2LP2GkqtIpfSnWMMwZ5YstpZUe
         dlkmdzba+8iG2mBsW0ddcU/gLGsui/3sW/91JZ/T0cslCFYkFv+JkQFhLejomqP8JJLv
         klxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DZugOTI9KxAAOxuZDWfK5HFNxfJINOMz8DoYNPEVrxE=;
        b=TNdcak3EV3pYZydcUwSXSOqcVWsSHzOBUrTz4Y0Q4AKYLlw1u4+L5aNyGualWNwnUY
         /KFS5DqoAEIyuM7FuRlzdh1ieuZuBUaZexGuDcfqldfgxaCAekEsaXnTzHpn/+GsueqW
         ABjPWv6279cO+KHaC+cMwgm4erR6pqwZJZQnF1PqoZETQnfYLHqoQrm0fcnyVk4dAupJ
         L0lG+xk1yMqMlhytIqf98GaPmKJZSKhiaf4VQe8LTibOAndihk7DnEZI3GaTacAgkhKS
         YGHUd+PpnWTsgDXemewjWIcCO7ZkobBswo0LRey9JOGsXM2caIehe2pfarOvuAfLuXuh
         xLDQ==
X-Gm-Message-State: ACgBeo1PaU3EMT9IWMG4zfrtE5I/zGUTDakKb1By0S0v1wZBjJYf2fqX
        oMpplZ5Pz1EwPwOcUIIeO4Q=
X-Google-Smtp-Source: AA6agR5YgTVZARMKttFGjA8k6Eywr7Ql/1DY+N58DFl5dP75S5ttL6Mvi+AoeeBe2d660jgf1MJOcA==
X-Received: by 2002:a05:6402:520d:b0:450:d599:52c with SMTP id s13-20020a056402520d00b00450d599052cmr5530085edd.119.1662726519788;
        Fri, 09 Sep 2022 05:28:39 -0700 (PDT)
Received: from localhost ([89.40.126.93])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906194c00b007753477db05sm207271eje.115.2022.09.09.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 05:28:39 -0700 (PDT)
Message-ID: <631b3177.170a0220.ccacb.0862@mx.google.com>
X-Google-Original-Message-ID: <Yxtbm3mXtEu+rzuF@<DarkDistro>>
Date:   Fri, 9 Sep 2022 15:28:27 +0000
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

From: Burak OZDEMIR <bozdemir@gmail.com>

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

