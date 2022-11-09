Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75D622EAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiKIPFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiKIPFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:05:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E218366;
        Wed,  9 Nov 2022 07:05:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p16so11011441wmc.3;
        Wed, 09 Nov 2022 07:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhwrBDl/CTbKvy7A/51zRGVK4YyuwVKuNCU7SY9gZq8=;
        b=mTFflwQajR9tHK7tX87YcCe2Tf1beSD7HXqGu8rXCbB84cbE7eZiF1ytWqlzAr3PgL
         CGgAf5AA6dzPUOc3zcmcuWkO1m2Pq5tsAmlHXSG+gF9mIBePOP6kJo4ZNSk4LdGPXDKG
         l/fmjdKL/bRfvKHEpPxXZ892w/ZDYHjgoN7yjSWW09M666nYjN3RPcRRZ0XBjZ50UIUv
         z+JIf+/qsrlLaz0DrN4cnGD5HvXmBWuEKZYDw/+ulQaHVauwtIt22P1CfoLfcHSm68st
         t9NdQV0vo/2I5+O/qZlH+8Vzl5MvdHVcEADNP8YXz6AvAL/w2c1j5JmM/31doAZXHNRV
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhwrBDl/CTbKvy7A/51zRGVK4YyuwVKuNCU7SY9gZq8=;
        b=TvHW1Km2i6DlIIjat11NStWR1sp2UBkYDYAmV6bNvIfxwy208hoEpt84hJS5WHW2wA
         6PTbx9CbIlQg/JlZTWoXMlCn2xUOzIPi/BGOyBSd2Vwty+xkadLj2Qsa2wwEbXOG1pr9
         XLH3dgXGYOkwOBpwTwANE3REXdeNTk/4plnfCAYtS0aeQo7V3wrnoQP8agdUJzIO1JsX
         rJzrhx6C3ed2oC6V1KNxrAP07G7tUADLNmq0mnZRkc6dMeEOul7r4P/1d9Wx7R4noYkV
         FnY9XY5eFqk2gdEEPD+T3rkoY7sUMFi4Cq6KEzwoFqUWkkBkJPSYFat6UPv+JNmnu4HH
         MRHA==
X-Gm-Message-State: ACrzQf0t77znYMZOf9NCnlqPttImhoN7TJKuY+Oui23OikFKnlH/Z3uq
        M6H3IxK4J7YeWD2L51+jUAo=
X-Google-Smtp-Source: AMsMyM7jnmJIarouA2ZI9hO9Lkg+kKY7/4ZBHfmKmEAIPe/aaGTsvEeVv48Gv3Vb8606UmP340iHmg==
X-Received: by 2002:a05:600c:12ca:b0:3cf:88bb:3a88 with SMTP id v10-20020a05600c12ca00b003cf88bb3a88mr26739091wmd.170.1668006345662;
        Wed, 09 Nov 2022 07:05:45 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf75f56105sm2495109wmo.41.2022.11.09.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 07:05:45 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] media: i2c: st-vgxy61: Fix spelling mistake "substraction" -> "subtraction"
Date:   Wed,  9 Nov 2022 15:05:44 +0000
Message-Id: <20221109150544.274795-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are a couple of spelling mistakes in a literal string and in the
documentation. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 Documentation/userspace-api/media/drivers/st-vgxy61.rst | 2 +-
 drivers/media/i2c/st-vgxy61.c                           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/media/drivers/st-vgxy61.rst b/Documentation/userspace-api/media/drivers/st-vgxy61.rst
index 213b884dcfa6..7fb5b4f60db7 100644
--- a/Documentation/userspace-api/media/drivers/st-vgxy61.rst
+++ b/Documentation/userspace-api/media/drivers/st-vgxy61.rst
@@ -17,7 +17,7 @@ The ST VGXY61 driver implements the following controls:
 
     * - HDR linearize
       - The merger outputs a long exposure capture as long as it is not saturated.
-    * - HDR substraction
+    * - HDR subtraction
       - This involves subtracting the short exposure frame from the long exposure frame.
     * - "No HDR"
       - This mode is used for standard dynamic range (SDR) exposures.
diff --git a/drivers/media/i2c/st-vgxy61.c b/drivers/media/i2c/st-vgxy61.c
index dfbf25338160..e72fc3a8a54c 100644
--- a/drivers/media/i2c/st-vgxy61.c
+++ b/drivers/media/i2c/st-vgxy61.c
@@ -197,7 +197,7 @@ static const char * const vgxy61_test_pattern_menu[] = {
 
 static const char * const vgxy61_hdr_mode_menu[] = {
 	"HDR linearize",
-	"HDR substraction",
+	"HDR subtraction",
 	"No HDR",
 };
 
-- 
2.38.1

