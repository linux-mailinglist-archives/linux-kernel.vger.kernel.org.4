Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684CC5EE822
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiI1VQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiI1VPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:15:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF6ECCCE;
        Wed, 28 Sep 2022 14:10:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n10so21581718wrw.12;
        Wed, 28 Sep 2022 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aqILboMdnZtLPM1qTiwzF4Objpc5L4N5ZHrXfIEsftM=;
        b=oAyo7krAjSF7ZLstZ0OikgtNA3qlrKqV+dowv98DL7jk/YILbVvywOc7echSrgzYS1
         FLSbny/g21Tx1HS2wCHpk+/Ev2FthfUOUML6N220tD8Jv/kYxpWVTn3glKjWqN/Yn9gu
         yys6Zp0cAazlzees/YJ3X3I7CSk3Wbf31JzLoODOIDt89tbtm/elonbNWMIP8WUErzCc
         F1wvvZatSjRoXnilcYOnfIrE2ROXCZG3eog+GeTc1ykkUH1Bo/lRv47kn+XTGitQSKPr
         r3LUKU1dh4SYF6lIji4jHAwtZ2q9mIz7zyIzhU31txm4s7uR2FAlGwFXNJqj6AVzhtvh
         +amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aqILboMdnZtLPM1qTiwzF4Objpc5L4N5ZHrXfIEsftM=;
        b=cJEKPeSnlMgVZW4IRSWpcTiDy9cSv+L5M26+epRwg+FXN0av4YFZSs3mXcb5rRv6ma
         5dqXf90ZbaTUO5potZYYddK5IGCtu4aLDYFtIwNkSNi8aybM1wQBxSwUMcI6VgdW1IXY
         vU7ht4Mc4UcDMidduSlY2kapAwUGmXwm95L8aii4hofTDgAfkLb7qKKLqN8MqM3JcrNy
         o/3g36+FpE1y4aRDEPoYiAxt1sWnsfnq9bb4hlop4+1h4AgTgXMFosHdtfpEYOSgjpz0
         x8fdu6lhuMni8pJw4gN5G0EAGz9k0MDzLq37rMigFB9HvMszPfDexWakhELdHzHJpoIg
         nvcQ==
X-Gm-Message-State: ACrzQf2DlGtLbD+A1/XW44tOoHflxMv18mrfmekkaehhpAzzRiBu9oZm
        HDhkGlX68/jL/0ml5zVt0ApX1Yb59q8OKw==
X-Google-Smtp-Source: AMsMyM7EwOozklAGUbrwlmFG7rE/fXeq9SQVTUp+7iWGt7OYVHD5cTjCsBIpCBF2t5yd4/DeyKK9Gg==
X-Received: by 2002:adf:bc13:0:b0:228:6d28:d489 with SMTP id s19-20020adfbc13000000b002286d28d489mr20881942wrg.668.1664399405634;
        Wed, 28 Sep 2022 14:10:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c230300b003b4727d199asm2668946wmo.15.2022.09.28.14.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:10:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ims-pcu: Fix spelling mistake "BOOLTLOADER" -> "BOOTLOADER"
Date:   Wed, 28 Sep 2022 22:10:03 +0100
Message-Id: <20220928211003.61872-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
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

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6f38aa23a1ff..b2f1292e27ef 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -744,7 +744,7 @@ static int ims_pcu_switch_to_bootloader(struct ims_pcu *pcu)
 	error = ims_pcu_execute_command(pcu, JUMP_TO_BTLDR, NULL, 0);
 	if (error) {
 		dev_err(pcu->dev,
-			"Failure when sending JUMP TO BOOLTLOADER command, error: %d\n",
+			"Failure when sending JUMP TO BOOTLOADER command, error: %d\n",
 			error);
 		return error;
 	}
-- 
2.37.1

