Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296E16B66BC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCLNeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCLNeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:34:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D040C30293;
        Sun, 12 Mar 2023 06:33:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l1so8984940wry.12;
        Sun, 12 Mar 2023 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678628038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiPifvN1XyvobUmqZyfiK5INxKhDqGlZtgkMioL3vMo=;
        b=GD6j0vNGy5Lk6teLi7snFXICeRLvcvAeHQgKz0wMKKq51ZXiBSetiG1myusJCpWqVe
         MCbUrIEUent2OpbRaxrwkbESipcSRMf0O54/mi2vOxROjfEbdnMdZhOiWn3RvMY7H1s8
         RmkgPL6SsjyEdNMajkghtLSIz5+I1ObSj5m/cfnSaLwlT3Lvqej8N0secVKSpfU1Ei4V
         /jJM9HTgGarrtGxNwo1RWQgHcnB+qkeJXQhQ6z6h+MxUtyVICwYD9VTZPrw5SoNFt+Js
         zIjJ0qTAykb4W5c0GPQS/MKs17RVVFfND2owpMimAUJMdQdNFmhVZ9PXrEwBX9hLn2eq
         zpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678628038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiPifvN1XyvobUmqZyfiK5INxKhDqGlZtgkMioL3vMo=;
        b=JfWQfOL88hvo9zf+NYeCpErrwVPfybhk4isvf4oYZnObh4UidEj2ptPxVA49w/BOGD
         26xYpGSQbSwV3FPDwy7QTDlZ5bHPktOSm8kemYug1D02gdY6ZP3jt7uwgac2pBqEPfg4
         t+VbT38WHUDXXwmb3v1Oc1JekIfsMCY4kjtT5Mim8hzLEK8qNYcbnCW+RPo+GSVcojXA
         HayTHbnXZfwpjc4s6KTWewOyxVO78cIiND/qF3l+6rmQIaG9BvgJ1WP1W10BnfRoSmeT
         Kl2sqEk7ztmt3R8YOvsZOlvRAHTZjUI2wFWLNhf8IkQYwI5jZ+LHWY75fCLS1upEWv0E
         CEGw==
X-Gm-Message-State: AO0yUKUbD8DZGN7aWAWoHJsBm5QhhG7afe1osHIqukm/ZcwtrhZwxy54
        Zz2O6hRK0CdyU7hHpWculJN6I6ewZ58=
X-Google-Smtp-Source: AK7set/puNB5iYM3sVYz/qm/8L3NnuFuYKU862+lC/uC5s4YoS4lGRh4xVvFdbe9kTag0BdON6cycA==
X-Received: by 2002:adf:df8f:0:b0:2ce:a758:d6fb with SMTP id z15-20020adfdf8f000000b002cea758d6fbmr3149122wrl.1.1678628038167;
        Sun, 12 Mar 2023 06:33:58 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6503000000b002c55306f6edsm5144594wru.54.2023.03.12.06.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:33:57 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: iio: meter: enclose Macros with complex values in parentheses
Date:   Sun, 12 Mar 2023 15:33:47 +0200
Message-Id: <20230312133347.120944-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

enclose Macros with complex values in parentheses is especially useful
in making macro definitions “safe” (so that they
evaluate each operand exactly once).

this error reported by chechpatch.pl

"ERROR: Macros with complex values should be enclosed in parentheses"

for ADE7854_SPI_SLOW, ADE7854_SPI_BURST and ADE7854_SPI_FAST
macros and this error fixed by enclose these macros in parentheses.

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/iio/meter/ade7854.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 7a49f8f1016f..41eeedef569b 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -139,9 +139,9 @@
 #define ADE7854_MAX_RX    7
 #define ADE7854_STARTUP_DELAY 1000
 
-#define ADE7854_SPI_SLOW	(u32)(300 * 1000)
-#define ADE7854_SPI_BURST	(u32)(1000 * 1000)
-#define ADE7854_SPI_FAST	(u32)(2000 * 1000)
+#define ADE7854_SPI_SLOW	((u32)(300 * 1000))
+#define ADE7854_SPI_BURST	((u32)(1000 * 1000))
+#define ADE7854_SPI_FAST	((u32)(2000 * 1000))
 
 /**
  * struct ade7854_state - device instance specific data
-- 
2.34.1

