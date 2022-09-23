Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D685E82AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiIWTrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIWTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:47:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1151B12E431;
        Fri, 23 Sep 2022 12:47:45 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso1140278pjd.4;
        Fri, 23 Sep 2022 12:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ffTYnVeFbIPqAewxfNP3TKdgr0vC1abBfdtqXdSTqAc=;
        b=TYLJshbXSSqCaOHn3+Yo+a4P+5A8iKv5Qk+6cjDcttyEr85pQLjfPgnJ9yVVeXrYo6
         xH7CTkAvSUf4fLqnxEKrWV8RZYlWQjZGIdFvCWM2Ej/WEa/wdfoBzYxr0T5N6jvip28t
         qNs1VgkluI45oCvMXbrATLR47rAwgP5Dl3DkGP/eVAoZwOzxHKZYg+Hc1smIZmY0j8/i
         Pp0dxiZH+/+4KIB49gHPBeRnA14BAT/Q9moeTFCnyrqCUnte9LG/pneVZd6mKrfZMUAA
         DcRwUvPrXvnZieSQyUu3HgN0pFl6s/IN5dydMGKYKknhJOY098QBYzZ/T6hLqmXFwcmZ
         Afmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ffTYnVeFbIPqAewxfNP3TKdgr0vC1abBfdtqXdSTqAc=;
        b=haOtaP09vfVDRM+5hfvx/1foj4NPXrSiiUU2+YS4kzeDG5tMwn+Cc4FmnlN8h48yhA
         Q2iPhKYzH/RA0ZDIF3giuq2BRFHkuBkfMgiBAUHLB3CwJvo1e2gKA2f6F5J/P6GABY5J
         O28r7lbypECpDgt4Xo+Kv3DTZNlQeGrzY+Rvr6rzGqtHrgaykSDTtawJxbhuAZPKlHWS
         kFRFOYk+MTvXz0bHUukOdaQGhdUpRZLjktIiNxd8Iuqx/rCDPW1h1ctn3oxl/xqPDjDe
         8tZq6zxZmfPV9CQ5+ia5hJYdaVDJGrUedB2JyOIo2NiKjPqsk3ysV7wJOX+uB6JBlGdB
         WilQ==
X-Gm-Message-State: ACrzQf14RVy3/mzx3L2G0SJqliaeuh5XBWqEEhfT2XQ0yQAWVsGDT/Gj
        +nCERN0/OaayfL/+3Seg+fI=
X-Google-Smtp-Source: AMsMyM4F2JactmG/aq5OYlpGOLQOdVSFq6PAqY4ZJQ5x9G57Za3RduFn/1Njk1soRdG3EZFYOxh72A==
X-Received: by 2002:a17:903:244e:b0:178:4f50:1ca0 with SMTP id l14-20020a170903244e00b001784f501ca0mr10059622pls.104.1663962464450;
        Fri, 23 Sep 2022 12:47:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001753cb9893csm6405187pln.187.2022.09.23.12.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:47:44 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Input: st-keyscan - add missing linux/input.h and linux/of.h includes
Date:   Fri, 23 Sep 2022 12:47:35 -0700
Message-Id: <20220923194738.927408-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
References: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to clean up matrix_keymap.h from unnecessary includes,
so the driver needs to include API that it uses directly.

Also let's sort includes alphabetically.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/st-keyscan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index a045d61165ac..a62bb8fff88c 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -8,12 +8,14 @@
  * Based on sh_keysc.c, copyright 2008 Magnus Damm
  */
 
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/io.h>
+#include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #define ST_KEYSCAN_MAXKEYS 16
 
-- 
2.37.3.998.g577e59143f-goog

