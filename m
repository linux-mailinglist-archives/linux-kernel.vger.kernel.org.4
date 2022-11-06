Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846C761E239
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKFM4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKFM4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:56:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDF9FC7;
        Sun,  6 Nov 2022 04:56:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso12133731pjg.5;
        Sun, 06 Nov 2022 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qLVkF95Yr85XA87YmEY6ixJ3k75lrmtHRc5sPCzq7s=;
        b=OTqDaB8E7YcyHthm4GzoOnqOR2PBnfHR0z8UWvSaF7NSP9QvCHVTJoxeLrAC7KS21Y
         qmvKhkMstD+upl7mXbgphNEAcWd98oqkj/fAmd/0exQ4RtzDeVXxUHDCNIRKGgLgaULZ
         pdxaTCDqqenA551UrR21Knw/OLQttGWxmry3Sj/2OwJgb5UQQPB515Ihmafo1Le/w60W
         TUuLFWksQwzZnmcem3pacM5dsW0sawOBV2ttRW78sS/V1Lf15Gq2aROsMnA6MsKuGgPj
         +4lZ+IE0nUWObc3O6PjL6Pt5E9QhTsSGEis6EOcNY/tgWB9mrgTeFGiv7fA3jqAK588v
         irXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9qLVkF95Yr85XA87YmEY6ixJ3k75lrmtHRc5sPCzq7s=;
        b=nzz6+s6y1w2zF8zGOKnp8sJHnIsjpwYc2aQCeWzuU/hyDOrtHMyh+CcfckjFzznIgG
         YNYd/G40LPbpMVLlaI87DoyNnj9W2V7UZIW/Tocj7SCj0wd5Lcp5mfpxm4sTdHb26Vuj
         tiED6Yw5Vt5zKam5o0SXmgedBqELb90IHKA4NJLhT1+GF5KpmcnM9lcswyEOvv4XHXba
         j3rOaMo8rSc3CTD3TcgvxiWbUsHW4cgE4YP/TMTB2RC4RevpmeCvo3AeFCevkfUwAv76
         VZJ07QP6h3UCwdEnGsF0WICnxpHISBQc60XvTJOoI98pEvIPrbfCL8Wq+HOKUCecuBq2
         CTGA==
X-Gm-Message-State: ACrzQf00VkY77G9iFkaDjCQHEnl75nz4fUw7hy/oyL4WZ1GCGBFF38iB
        K9/wQta8HMM0d+scLXZAzU3jHFm/WLrdQg==
X-Google-Smtp-Source: AMsMyM6I25TBb+oxR1enuHBNvIF0mmxpqCGe59Ycg+78EdgxEATyQCu3NtJalkSsrhBiIDds0PNaPg==
X-Received: by 2002:a17:902:ec92:b0:186:de89:7f67 with SMTP id x18-20020a170902ec9200b00186de897f67mr46557957plg.166.1667739362025;
        Sun, 06 Nov 2022 04:56:02 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b0018099c9618esm3106032plc.231.2022.11.06.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 04:56:01 -0800 (PST)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2] can: etas_es58x: sort the includes by alphabetic order
Date:   Sun,  6 Nov 2022 21:55:46 +0900
Message-Id: <20221106125546.855266-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221106100120.849735-1-mailhol.vincent@wanadoo.fr>
References: <20221106100120.849735-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

v1 -> v2:

  * rebase on linux-can-next/testing. v1 was based on a local branch
    and did not apply (sorry for the noise).

  * add the copyright bump. That was initially of this patch:
    https://lore.kernel.org/linux-can/20221104073659.414147-1-mailhol.vincent@wanadoo.fr/raw
    but figured out that it is better to put this next to the
    modifications of the includes.
---
 drivers/net/can/usb/etas_es58x/es581_4.c    | 4 ++--
 drivers/net/can/usb/etas_es58x/es58x_core.c | 6 +++---
 drivers/net/can/usb/etas_es58x/es58x_fd.c   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 51294b717040..7d6e688f2b46 100644
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

