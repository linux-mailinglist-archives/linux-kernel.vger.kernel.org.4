Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306D66BA7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCOGZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjCOGZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:25:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3B5DEE8;
        Tue, 14 Mar 2023 23:25:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so853378pjb.0;
        Tue, 14 Mar 2023 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678861522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqg9UOvMn1L0rQXxvk61iocEZu2DUFx0FwMOPUnewaI=;
        b=ME/iO5Y6VMo3RqPjqRofvfqz9Uy81WnFOHMAINqqpFFuSV6wiy0466QZecudnp0UCm
         f8yPjsMKvgGyEJcGYQhMAUibAm8HQZoS0ZlLZPkU9FMRLiqZfCWSrbvdDvf6D2yV2Yh6
         F5w7nHEBnX4QT30vLks0/xIruVIO9bBBN/zau8KoYNpbGkHpptZp6VLIwqrXA0CfjZKy
         2OCl51h9gJeSXPKvcD8srMnJyYS/AwoHskb5vSi4vAyq/Gm4yT1apxq6j+RZWVVTZRMk
         L42vp2pw4FfWRGULU1CRJTONebK/qjTDQ7KhpPyQbMX9PPLqU4BJW8J2r4ET1mLn3cgy
         k9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678861522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yqg9UOvMn1L0rQXxvk61iocEZu2DUFx0FwMOPUnewaI=;
        b=VIoj7+uOomiOsyXomn7gUpdOilwlAKson51Od5QcejZCApnegSzHgZgmDhaFCp1xkA
         EC8G4ZiLD5w3pmbu+Cuk04FHWB94TT2oYznzbePRzpUshds67z4NaVHVphd6t/H9z6Zv
         pOaX0SX/tlbdhvXogGgYJ1hInXZu9mfdrBcntwXZ65+7d3B8FEDy2A9KCMu2H9ltZ/tI
         TWOc6KcE4KDXZyW1olY1XmM/m7oHCu+t3ontt66rq9Z0U9uZw2RthUTgfwfSH6TFcUy4
         m8ID9mRIFPulqWpFcgArW4ZWKMgby8oA5JlZrmYhqNIDdl4RMoWzDAL9Oqv/j/NyMrof
         wvcg==
X-Gm-Message-State: AO0yUKXQzXJoTfllKJpDs2E82P/e6J+eqKtbkFoS9q3+UiKjiYmNQ4+O
        vKrf9KkcaFmR8Jtjj6bImMM=
X-Google-Smtp-Source: AK7set/7DhDummJvy+aE+ltOWhLaVwiKkrOW71Ob1kKcOqCgVorjo6PI6m93ZBONsN5aEw8M6hWoqw==
X-Received: by 2002:a17:902:c641:b0:19a:8636:9e2c with SMTP id s1-20020a170902c64100b0019a86369e2cmr1218704pls.57.1678861522403;
        Tue, 14 Mar 2023 23:25:22 -0700 (PDT)
Received: from Tiny (076-050-196-152.res.spectrum.com. [76.50.196.152])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902b60f00b00198b01b412csm2722822pls.303.2023.03.14.23.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:25:22 -0700 (PDT)
Received: by Tiny (sSMTP sendmail emulation); Tue, 14 Mar 2023 23:25:19 -0700
From:   Michael Harris <michaelharriscode@gmail.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Harris <michaelharriscode@gmail.com>
Subject: [PATCH] sbus: bbc_i2c.c: fixed various coding style issues
Date:   Tue, 14 Mar 2023 23:25:18 -0700
Message-Id: <20230315062518.256368-1-michaelharriscode@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed various issues given from checkpatch.pl

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/sbus/char/bbc_i2c.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 537e55cd038d..c0df890f1aec 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <asm/bbc.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "bbc_i2c.h"
 
@@ -32,7 +32,7 @@
 
 #define I2C_PCF_START    (I2C_PCF_PIN | I2C_PCF_ESO | I2C_PCF_ENI | I2C_PCF_STA | I2C_PCF_ACK)
 #define I2C_PCF_STOP     (I2C_PCF_PIN | I2C_PCF_ESO | I2C_PCF_STO | I2C_PCF_ACK)
-#define I2C_PCF_REPSTART (              I2C_PCF_ESO | I2C_PCF_STA | I2C_PCF_ACK)
+#define I2C_PCF_REPSTART (I2C_PCF_ESO | I2C_PCF_STA | I2C_PCF_ACK)
 #define I2C_PCF_IDLE     (I2C_PCF_PIN | I2C_PCF_ESO               | I2C_PCF_ACK)
 
 #define I2C_PCF_INI 0x40   /* 1 if not initialized */
@@ -63,8 +63,8 @@ static void set_device_claimage(struct bbc_i2c_bus *bp, struct platform_device *
 	}
 }
 
-#define claim_device(BP,ECHILD)		set_device_claimage(BP,ECHILD,1)
-#define release_device(BP,ECHILD)	set_device_claimage(BP,ECHILD,0)
+#define claim_device(BP, ECHILD)		set_device_claimage(BP, ECHILD, 1)
+#define release_device(BP, ECHILD)	set_device_claimage(BP, ECHILD, 0)
 
 struct platform_device *bbc_i2c_getdev(struct bbc_i2c_bus *bp, int index)
 {
@@ -72,8 +72,10 @@ struct platform_device *bbc_i2c_getdev(struct bbc_i2c_bus *bp, int index)
 	int curidx = 0, i;
 
 	for (i = 0; i < NUM_CHILDREN; i++) {
-		if (!(op = bp->devs[i].device))
+		if (!bp->devs[i].device) {
+			op = bp->devs[i].device;
 			break;
+		}
 		if (curidx == index)
 			goto out;
 		op = NULL;
@@ -85,6 +87,7 @@ struct platform_device *bbc_i2c_getdev(struct bbc_i2c_bus *bp, int index)
 		return op;
 	return NULL;
 }
+EXPORT_SYMBOL(bbc_i2c_getdev);
 
 struct bbc_i2c_client *bbc_i2c_attach(struct bbc_i2c_bus *bp, struct platform_device *op)
 {
@@ -110,6 +113,7 @@ struct bbc_i2c_client *bbc_i2c_attach(struct bbc_i2c_bus *bp, struct platform_de
 
 	return client;
 }
+EXPORT_SYMBOL(bbc_i2c_attach);
 
 void bbc_i2c_detach(struct bbc_i2c_client *client)
 {
@@ -119,6 +123,7 @@ void bbc_i2c_detach(struct bbc_i2c_client *client)
 	release_device(bp, op);
 	kfree(client);
 }
+EXPORT_SYMBOL(bbc_i2c_detach);
 
 static int wait_for_pin(struct bbc_i2c_bus *bp, u8 *status)
 {
@@ -177,6 +182,7 @@ int bbc_i2c_writeb(struct bbc_i2c_client *client, unsigned char val, int off)
 	writeb(I2C_PCF_STOP, bp->i2c_control_regs + 0x0);
 	return ret;
 }
+EXPORT_SYMBOL(bbc_i2c_writeb);
 
 int bbc_i2c_readb(struct bbc_i2c_client *client, unsigned char *byte, int off)
 {
@@ -226,6 +232,7 @@ int bbc_i2c_readb(struct bbc_i2c_client *client, unsigned char *byte, int off)
 
 	return ret;
 }
+EXPORT_SYMBOL(bbc_i2c_readb);
 
 int bbc_i2c_write_buf(struct bbc_i2c_client *client,
 		      char *buf, int len, int off)
@@ -242,6 +249,7 @@ int bbc_i2c_write_buf(struct bbc_i2c_client *client,
 	}
 	return ret;
 }
+EXPORT_SYMBOL(bbc_i2c_write_buf);
 
 int bbc_i2c_read_buf(struct bbc_i2c_client *client,
 		     char *buf, int len, int off)
@@ -259,13 +267,6 @@ int bbc_i2c_read_buf(struct bbc_i2c_client *client,
 
 	return ret;
 }
-
-EXPORT_SYMBOL(bbc_i2c_getdev);
-EXPORT_SYMBOL(bbc_i2c_attach);
-EXPORT_SYMBOL(bbc_i2c_detach);
-EXPORT_SYMBOL(bbc_i2c_writeb);
-EXPORT_SYMBOL(bbc_i2c_readb);
-EXPORT_SYMBOL(bbc_i2c_write_buf);
 EXPORT_SYMBOL(bbc_i2c_read_buf);
 
 static irqreturn_t bbc_i2c_interrupt(int irq, void *dev_id)
@@ -291,7 +292,7 @@ static void reset_one_i2c(struct bbc_i2c_bus *bp)
 	writeb(I2C_PCF_IDLE, bp->i2c_control_regs + 0x0);
 }
 
-static struct bbc_i2c_bus * attach_one_i2c(struct platform_device *op, int index)
+static struct bbc_i2c_bus *attach_one_i2c(struct platform_device *op, int index)
 {
 	struct bbc_i2c_bus *bp;
 	struct device_node *dp;
@@ -341,7 +342,7 @@ static struct bbc_i2c_bus * attach_one_i2c(struct platform_device *op, int index
 	writeb(I2C_PCF_PIN | I2C_PCF_ES1, bp->i2c_control_regs + 0x0);
 	bp->clock = readb(bp->i2c_control_regs + 0x01);
 
-	printk(KERN_INFO "i2c-%d: Regs at %p, %d devices, own %02x, clock %02x.\n",
+	pr_info("i2c-%d: Regs at %p, %d devices, own %02x, clock %02x.\n",
 	       bp->index, bp->i2c_control_regs, entry, bp->own, bp->clock);
 
 	reset_one_i2c(bp);
-- 
2.34.1

