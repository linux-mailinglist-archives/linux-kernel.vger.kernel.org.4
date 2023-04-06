Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AB66D8E93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 06:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjDFEyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 00:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjDFEyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 00:54:54 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7227ED6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 21:54:53 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r14so22597054oiw.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 21:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680756892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGtoUwPGBpmlv9+vpAugLrWk/J13volzq8zGjx82L7M=;
        b=IvSF5SJ0sLhz9XIRVFre13nJxs00fqPfoxW0Uq8YnDx36fuW/B1N4w/jRg55qmMkMf
         WUVicic1WvdWmou340YTG9sF1pzp5U/ZdexGe5pqVjIIjRynYunThEwNn/v5yuHcBHoL
         OT3mWJWtJcBW7QZsTUWc7VjHrIqkxBhSfKr547BwZrP2k75ENDz46PbL3vGLO/I+Mkqw
         1WA+4OwjyuwUm3s1s7Ihm1XXV3sw9tt7FjJjQWb40ZT89h0dM+uJG9luDswuVp+Jo+zG
         uNydSHA1Yvps5ErrAbeG8TGZYdIfWPDS/i6dpBWz5lvEPRyPE+7793RIETTRb2fo5n4d
         V2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680756892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGtoUwPGBpmlv9+vpAugLrWk/J13volzq8zGjx82L7M=;
        b=cgS8uykLWSEr4+zqh4uK+hElazM6POHngs3OJA0uqwLdto77bQ4oYkATQgmWkmDjTr
         bfxCTRyUc5Mv7QUn/Ak7K/JyGZdE13Pk24FGBT/TgCKryWOeIOqJZA9pgm0x3eoBDcig
         ln21Ud0F982f722TSrfVmmMAAfqzREj3phEIfHfysEskWbtpzBb/bIvUyDbFA2AiES7a
         yzvUXiz1kYaKAFBbezdqZP1GLz13uk8cQXfdFcKQw5Bzdya2dU0xadcRhABnCeyJZhu9
         UZ9M8d2BFM4So/XQ7YrMjtOgpRxsA99VF+tz+Oml3bgv89MnKzUq8kZtRH8J05XDUNA5
         /X4Q==
X-Gm-Message-State: AAQBX9ferxT7LdtQhqULuQ5SogYSgJuCCvHSI43sxBYMEExdfpl6EIrw
        v3cAQ5Lymq8HbeayXZyH6K0=
X-Google-Smtp-Source: AKy350aVl1/hvYDjIZ77u5pcJIMU/voMJ34PTLXoAlwF/ALRM2+6QMBpzPo2Gw9Mub4b77YZFiXn7g==
X-Received: by 2002:aca:2112:0:b0:386:c4f0:4f78 with SMTP id 18-20020aca2112000000b00386c4f04f78mr4019628oiz.28.1680756892464;
        Wed, 05 Apr 2023 21:54:52 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p10-20020acad80a000000b003898bec0e01sm285775oig.17.2023.04.05.21.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 21:54:52 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH] driver core: update comments in device_rename()
Date:   Thu,  6 Apr 2023 01:54:35 -0300
Message-Id: <20230406045435.19452-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

Document that some subsystems are still going to use device_rename for
the time being, so it is not a good idea to assume it's not used. Also
remove mentions of a plan to stop renaming net devices.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 drivers/base/core.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6878dfcbf0d6..95d414074f92 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4383,9 +4383,12 @@ EXPORT_SYMBOL_GPL(device_destroy);
  * on the same device to ensure that new_name is valid and
  * won't conflict with other devices.
  *
- * Note: Don't call this function.  Currently, the networking layer calls this
- * function, but that will change.  The following text from Kay Sievers offers
- * some insight:
+ * Note: given that some subsystems (networking and infiniband) use this
+ * function, with no immediate plans for this to change, we cannot assume or
+ * require that this function not be called at all.
+ *
+ * However, if you're writing new code, do not call this function. The following
+ * text from Kay Sievers offers some insight:
  *
  * Renaming devices is racy at many levels, symlinks and other stuff are not
  * replaced atomically, and you get a "move" uevent, but it's not easy to
@@ -4399,13 +4402,6 @@ EXPORT_SYMBOL_GPL(device_destroy);
  * kernel device renaming. Besides that, it's not even implemented now for
  * other things than (driver-core wise very simple) network devices.
  *
- * We are currently about to change network renaming in udev to completely
- * disallow renaming of devices in the same namespace as the kernel uses,
- * because we can't solve the problems properly, that arise with swapping names
- * of multiple interfaces without races. Means, renaming of eth[0-9]* will only
- * be allowed to some other name than eth[0-9]*, for the aforementioned
- * reasons.
- *
  * Make up a "real" name in the driver before you register anything, or add
  * some other attributes for userspace to find the device, or use udev to add
  * symlinks -- but never rename kernel devices later, it's a complete mess. We
-- 
2.34.1

