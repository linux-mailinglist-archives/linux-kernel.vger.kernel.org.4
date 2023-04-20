Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0916E8655
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjDTAVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjDTAVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:21:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B11FE5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:21:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so372376a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681950099; x=1684542099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wybtRKPcJmVuscHZAYELDwAaOfVG2kij6jVrPwURR7M=;
        b=VkRX0TofNKzKzIA204B9DjE7BnoRqddxRhg8Vz5V7mgX1p+y8GtAYAoeoKTSv5ptaI
         iVja2Oj6C/l6t4FDVGK9jI0h4b2lP98HKTlVSf6DVQPpE4DqIs994aSBEJFoqzSZEovg
         e2B2PFi0WTliyco36ZYZ1HIlcN1RpB+IvOt8K3qGwIVm6xrJLqIyBgnmz9A/SyZmpnxZ
         y8PGroc8eniOXynMKGQkpIohQkIN86jlzmt+WV6dt38bN2svtiLGjVDYxKB4zIXp9O1e
         9x1t989swOU4qKiJ5WFaP8KKFUiSyD3D9VSGCZG1xmM3sA3RXA7YryCcXlf9fC2kV+q+
         AONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950099; x=1684542099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wybtRKPcJmVuscHZAYELDwAaOfVG2kij6jVrPwURR7M=;
        b=IXgKGTM8ik39Bc/JDEQzivtw0WMeAiR3ecsKJmvYAB6WemlayDnZCjWZPgDaTSSXgv
         Lmgv4Y7k/132Cn41bBdOnvrU/jpB7nOHgO7lOGjduAJ46V+eJ8nx0k/piJOp0xBsbzLA
         hAV0GUF/ZbbhQEJNlXKEraHGhcHgphsZ6P1heoDp1zxVchdn9rIFNEbE0wYX1TBvUFlG
         9/O0I0FtbFqdJf3TVjImhqr59+qReB2d2gFoqLEwS+IxbIvCdZgarQUDn01nHM0P31sK
         QSSQtTZRJ+nb0wtzutKjG58CsIWeUd6lNnSDILyz4m2d/3tu9PUcEJXHc8X/VdUQaA5U
         cotw==
X-Gm-Message-State: AAQBX9cLnM0w9VjZ+OsNCRGY+rbaTBxc1aKDggQmL8Cwp8Ri8BA8TJrD
        W6GfRwDkEjvz/fk6u6CexR7n3zwxqpgtZ7ok
X-Google-Smtp-Source: AKy350ZkK/uOOSxzGnu8momDb1sVd3UOzRfq2E9JSvNRo2J4RXlZU1ATWqwsRjJyhxdZFAUEq8nstw==
X-Received: by 2002:a17:90a:1688:b0:247:55a4:e777 with SMTP id o8-20020a17090a168800b0024755a4e777mr3967591pja.49.1681950098910;
        Wed, 19 Apr 2023 17:21:38 -0700 (PDT)
Received: from yoga ([2400:1f00:13:25e2:f79e:e26f:7d33:1cbc])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090ae59200b00246a7401d23sm76328pjz.41.2023.04.19.17.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 17:21:38 -0700 (PDT)
Date:   Thu, 20 Apr 2023 05:51:33 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     zbr@ioremap.net
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: w1: slaves: Drop unnecessary explicit casting
Message-ID: <ZECFjQMLwnoYPMeL@yoga>
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

Provide correct specifiers while printing error logs to discard the use
of unnecessary explicit casting.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/w1/slaves/w1_ds2433.c  | 6 +++---
 drivers/w1/slaves/w1_ds28e04.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 0f72df15a024..ba441d42b0b0 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -213,15 +213,15 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 #ifdef CONFIG_W1_SLAVE_DS2433_CRC
 	/* can only write full blocks in cached mode */
 	if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
-		dev_err(&sl->dev, "invalid offset/count off=%d cnt=%zd\n",
-			(int)off, count);
+		dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
+			off, count);
 		return -EINVAL;
 	}
 
 	/* make sure the block CRCs are valid */
 	for (idx = 0; idx < count; idx += W1_PAGE_SIZE) {
 		if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE) != CRC16_VALID) {
-			dev_err(&sl->dev, "bad CRC at offset %d\n", (int)off);
+			dev_err(&sl->dev, "bad CRC at offset %pe\n", off);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index 6cef6e2edb89..6edfe6a4600a 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -234,8 +234,8 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 	if (w1_enable_crccheck) {
 		/* can only write full blocks in cached mode */
 		if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
-			dev_err(&sl->dev, "invalid offset/count off=%d cnt=%zd\n",
-				(int)off, count);
+			dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
+				off, count);
 			return -EINVAL;
 		}
 
@@ -243,8 +243,8 @@ static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
 		for (idx = 0; idx < count; idx += W1_PAGE_SIZE) {
 			if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE)
 				!= CRC16_VALID) {
-				dev_err(&sl->dev, "bad CRC at offset %d\n",
-					(int)off);
+				dev_err(&sl->dev, "bad CRC at offset %pe\n",
+					off);
 				return -EINVAL;
 			}
 		}
-- 
2.34.1

