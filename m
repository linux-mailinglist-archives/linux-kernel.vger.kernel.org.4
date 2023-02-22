Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E069F342
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjBVLMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBVLMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:12:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264351EBC6;
        Wed, 22 Feb 2023 03:12:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id pt11so9099709pjb.1;
        Wed, 22 Feb 2023 03:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu2paKVrVIoD9107RPYWka25sQcplKWr4Bown4/f63Y=;
        b=dJ5ZevpxvZ7Q46EC37jjEBMbS6QFAtcmqi4mrXN+WD6XdIDrNepOqlZ9mu5IIM2xsn
         taSY19aizrOjW+rDHzYi6yY+rujfP47rBjW+XG3pXPczjSIJdbYBRc3EdUEJgEZtT6Fa
         uo4gjnp2HNYQx91iZ7hVoYUH4Xqe6ZcKjgWCQ+JbjFs4gYhDbeXuUIWK8GItbjZ7fN5j
         j8lai8Jp1SjG6+YyyPnmgL+BLVybr5/QXwI8cOMrGswLX3oEcpZil2db879oepuKM7Fh
         wvQJTIocj/HeKcLBgo301oAivXlZYboAMfX5etaTBI9iNnbMXxlCi4gfTii/FDO1BQTU
         6gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bu2paKVrVIoD9107RPYWka25sQcplKWr4Bown4/f63Y=;
        b=47idL44LXxvv1XnQfJ/D96y5L7nUEeJ5KKAF+0q48zZPUTtFxMtpoYKiolFdL/BCXT
         iIwSYcVKVP2wESYtPkQI4a18Pm4bOlODVRex17VCeosoDHCnpJgfq45dnzIl/VJk5MJH
         1y+AoUYtIlp4tTvl4aKDEIueHWgrav35eBSTVOIRQSGtNdp7DFc39VCFiCWE953U3kF4
         2K6TC+FFzhgJEkcIAoRWgDlZlDu4KGjAjDOZHA8tJY3Y2fg3gR6Ij2WvM85qgOCHUwqv
         VqM1POh8ZAvhKTKiK/lfpVFiCOxToiKxlv4G7b+2HRFJGoOELcgkNFK9DvgzXRtYIeNp
         lAnA==
X-Gm-Message-State: AO0yUKXHeWLACKvzvxDntSxpWTEiHoRcsZdL7x8gag1jdY8CYAU05rCn
        WI9QyI5iU/HDGde62waIUxOObAvc8rWPFg==
X-Google-Smtp-Source: AK7set8CW9Ao3dsPSM68IxsiRJ2aesJAXkri5+EVCi0lTv55Bs/Vs7YcseHjHPbAnfN5CyAge+Koiw==
X-Received: by 2002:a17:90b:1647:b0:237:44c3:df0b with SMTP id il7-20020a17090b164700b0023744c3df0bmr1192934pjb.32.1677064348304;
        Wed, 22 Feb 2023 03:12:28 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a294700b00234899c65e7sm4763228pjf.28.2023.02.22.03.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 03:12:27 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/4] gpio: loongson1: Update copyright
Date:   Wed, 22 Feb 2023 19:12:10 +0800
Message-Id: <20230222111213.2241633-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222111213.2241633-1-keguang.zhang@gmail.com>
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates copyright and author information.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/gpio/gpio-loongson1.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 5d90b3bc5a25..7ecbc43f8b38 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * GPIO Driver for Loongson 1 SoC
  *
- * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
+ * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
  */
 
 #include <linux/module.h>
@@ -90,6 +87,6 @@ static struct platform_driver ls1x_gpio_driver = {
 
 module_platform_driver(ls1x_gpio_driver);
 
-MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
 MODULE_DESCRIPTION("Loongson1 GPIO driver");
 MODULE_LICENSE("GPL");
-- 
2.34.1

