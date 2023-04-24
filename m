Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C9B6EC684
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjDXGsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjDXGsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:48:30 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82813A97
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 23:48:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id qpzipjLlVMX1TqpzipkQeM; Mon, 24 Apr 2023 08:48:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682318895;
        bh=gyBmJlBy0glVXFW89nzgTxh1+ZjN6Gif/sbRlhQAcyU=;
        h=From:To:Cc:Subject:Date;
        b=gbmDBljLWzQVCxTBr/GwXL2ntQ7y0nnD/8dvAJ+a5u8j8xMBY8tIYOlmkjdhB2cgo
         vxk81PJSfmfiXaxWFSqqxQFZR939QwdPIz5dNbERTUwOL5MFwu/ENlho1Aski92m8f
         roU5JFrKChWxJQqzWKhO48ToZCx9bZyncgqmz0KUr+t39O7JSEQjzIgGXnOnPNGSi6
         datd/hb+bg1OzlCArYaEl6+9BOPWhcwsmqvyiCdvU6em6hwUt17p4TEChvTf8XMu1Y
         l8qPrSlSr8MiRkJmj6ZQvIo+8s1Ef5yiBhI9VxmaMMySyUcm+YYOvxP4PdNWe1eSQN
         DfhQjsKUltKEQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Apr 2023 08:48:15 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mfd: dln2: Remove the unneeded include <linux/i2c.h>
Date:   Mon, 24 Apr 2023 08:48:12 +0200
Message-Id: <baf28e7f0fb57e918b76eaa92b94a2ae1a02cce0.1682318879.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver does not use i2c, so there is no point in including
<linux/i2c.h>

Remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mfd/dln2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index c3149729cec2..c7510434380a 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -14,7 +14,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
-#include <linux/i2c.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/core.h>
-- 
2.34.1

