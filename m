Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F1C639705
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKZQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKZQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:05:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6211AF39;
        Sat, 26 Nov 2022 08:05:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso10201333pjt.0;
        Sat, 26 Nov 2022 08:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68GAubzH81JmBn8GaHYOWuHCK/z6l7YaDbt7HaREjmk=;
        b=GJSWUUIEnIbR0HsFDAx6v+Ie16yQl2Ut5hLPW9hVFvTe5JW7c4nhEkUxaLiYYghcMl
         MNIJ8toxN7t0FWN9FmWdOemlukQUyHSP0V2ruwCCTi66ywJZcu03AlTJ+F3kAexAljbN
         /UkSAvrIg+2FCuMbGrwXInZxAkSzC0ZcHMXdsVn2Ynkun1aqmqqwvDBjdfBNZK3LlNg0
         QSsPlqbAdoIiraCINAEIsqiJAU7ZsbMxxFwbV1OrM8t63kHTE5daD+Dp2VgxS62DYMY3
         viV52FPZHgsIKN0Fq6o67pGhiHinLgKd6xJYsL1SODjL1j1dC/TVNZVSXHVe+Szs7pYK
         pasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68GAubzH81JmBn8GaHYOWuHCK/z6l7YaDbt7HaREjmk=;
        b=M96aZiumstNXtK20UFxQB4Qz1vbwDlPyrqxRGB8LW042QFGI5HPhaH3TZl1oyM1sdx
         ltMRpjQ6RkzmNJBhzDKALAALDEGAVU9bNj89DlZP4JmhEc3jEe/mF5JZFvez5Q1BhRHL
         8+fK7+juPJLYiBJgbc8eFSZfea0yPjej78tcTMa0O311i9O6OkoIy1tmqVUvszhqCLO1
         djdeGHR+zgKLCKP2VbVvVrVB6F55R+0wNHGzgEmM9fayUETNCdeiyOu0PQsuNoJBMLC/
         TgaA9gywqj4zA6rdqrUheqRhUqvZEHXLYLdx8wPjOk/1K8mG25ZdqMZexDcZtfCYumfI
         Q29w==
X-Gm-Message-State: ANoB5pnZ2byzVcxiUwXneISJULEe+1YFle9xbUZTxbnczse6AkIGF9wN
        KQQX+mLW5AllrXSrOFmH2gHx5SiOQLI=
X-Google-Smtp-Source: AA0mqf7LiCtXzJUEsFOl0prmm0Dz+g+4XjpcrsWgsKgZGQRZnmBsgS8i1dNznydI63k7ZQCNgPwTKg==
X-Received: by 2002:a17:903:452:b0:189:65c5:4508 with SMTP id iw18-20020a170903045200b0018965c54508mr9312734plb.66.1669478734972;
        Sat, 26 Nov 2022 08:05:34 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id w64-20020a626243000000b0056c0d129edfsm4868044pfb.121.2022.11.26.08.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 08:05:34 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3] can: etas_es58x: sort the includes by alphabetic order
Date:   Sun, 27 Nov 2022 01:05:25 +0900
Message-Id: <20221126160525.87036-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221106100120.849735-1-mailhol.vincent@wanadoo.fr>
References: <20221106100120.849735-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the best practices, reorder the includes.

While doing so, bump up copyright year of each modified files.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---

Changelog:

v2 -> v3:

  * also reoder the includes of es58x_core.h

v1 -> v2:

  * rebase on linux-can-next/testing. v1 was based on a local branch
    and did not apply (sorry for the noise).

  * add the copyright bump. That was initially from this patch:
    https://lore.kernel.org/linux-can/20221104073659.414147-1-mailhol.vincent@wanadoo.fr/raw
    but figured out that it is better to put this next to the
    modifications of the includes.
---
 drivers/net/can/usb/etas_es58x/es581_4.c    | 4 ++--
 drivers/net/can/usb/etas_es58x/es58x_core.c | 6 +++---
 drivers/net/can/usb/etas_es58x/es58x_core.h | 8 ++++----
 drivers/net/can/usb/etas_es58x/es58x_fd.c   | 4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 1bcdcece5ec7..4151b18fd045 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -6,12 +6,12 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
 #include <linux/kernel.h>
 #include <linux/units.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 #include "es581_4.h"
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 25f863b4f5f0..4c97102202bf 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,15 +7,15 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
+#include <linux/crc16.h>
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/usb.h>
-#include <linux/crc16.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 640fe0a1df63..4a082fd69e6f 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -6,17 +6,17 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef __ES58X_COMMON_H__
 #define __ES58X_COMMON_H__
 
-#include <linux/types.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/usb.h>
 
 #include "es581_4.h"
 #include "es58x_fd.h"
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index c97ffa71fd75..fa87b0b78e3e 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -8,12 +8,12 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
+#include <asm/unaligned.h>
 #include <linux/kernel.h>
 #include <linux/units.h>
-#include <asm/unaligned.h>
 
 #include "es58x_core.h"
 #include "es58x_fd.h"
-- 
2.37.4

