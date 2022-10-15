Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4D5FFB4B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 18:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJOQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJOQxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 12:53:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D447F4CA08
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 09:53:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so16570977ejn.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IO03v7Eu4frTx8XORYprvbtJg3DfjQHE8pVEQpoJiQk=;
        b=cPDjmz8IVr/JT8UWgmvVty1YGgFPj0VMyeQPcVmM+T1lstD6OYtjE3fsC8Qf4E7t+Z
         bC1eJxixVqNSU2A8j8bxcZzu1XQtQ9ewuXfhhFjjPEjPi/J5J9heHPoOZZZTXrDzgyq9
         p+49EnfMtGwEGOKzl1sctt67urktS0qbuF/Ul/9VqFnUK9dcUkOqddxn2TjYlb4YaC+6
         R7LNb/WW9YmxP+Fh1AsTqmPc2ICUd0JtFEymstxPZ/w5V79/yL4PNCsaTuzQiBISIb/E
         Dcvb0DAlQtybbcZB+HuNcG45b1xrg4lEUCk7lNBzBOPJJcRYujT/Dp3gpq39l4CZ/Un1
         dlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IO03v7Eu4frTx8XORYprvbtJg3DfjQHE8pVEQpoJiQk=;
        b=D9KdnZsm7JAv74OA6aVOHGLzqKHA75IHkG+QGHD5NCovO6qE1OHdLBDfEl3+YgBR5t
         ShNgsqvCQHcYS5K427yiKqe3CVwDWWRR9BDXmNnFSq5TNruEbtk4gH6ZG7KlvOHSX2TM
         TbIb3G4Qp1Pf4lpvQZiFlTtvHsrwK62eD1ZTS2ewIQZ/dDvINdKacgSCAhW1N8zLm5sP
         xwP/H7vmQTFNhGNPHGrcttgRg6PrQ/Fr3Ei5q3h9rtqMkFP8JuetfYIvy7WBzmcjnKbE
         vowE+NYoloY5uXaEqtNmFMqY/+xxrdJBfBdWYHeaKiP9v82oeYMwdWdWk2+PAcX0mDHT
         hGqw==
X-Gm-Message-State: ACrzQf0NQ6vgQFDp5naalyTwxRhmL+Pms46J16P0Md3R3AxeRwTdUVUz
        atNBu6FJgIGdFmGm+fpItxyBkAyFo/9l3A==
X-Google-Smtp-Source: AMsMyM69v2BI1v3tk6VjMrS7brGMzwRfazQPa44EIZIMXrqdKjo6xkDk+JGIysnAT75IecWEx6aNqQ==
X-Received: by 2002:a17:906:9fc1:b0:761:9192:504f with SMTP id hj1-20020a1709069fc100b007619192504fmr2670030ejc.116.1665852783427;
        Sat, 15 Oct 2022 09:53:03 -0700 (PDT)
Received: from dkorent-GL753VD ([188.252.198.222])
        by smtp.gmail.com with ESMTPSA id g7-20020a170906348700b0074ae59d85a4sm3363189ejb.20.2022.10.15.09.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 09:53:03 -0700 (PDT)
From:   Danijel Korent <danijel.korent@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        philipp.g.hortmann@gmail.com,
        Danijel Korent <danijel.korent@gmail.com>
Subject: [PATCH] staging: rtl8192e: Added spaces around operators in rtl_cam.c/rtl_eeprom.c
Date:   Sat, 15 Oct 2022 18:50:23 +0200
Message-Id: <20221015165023.487200-1-danijel.korent@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Fixed "spaces preferred around operator" type of problems reported by
checkpatch

Signed-off-by: Danijel Korent <danijel.korent@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   | 23 +++++++++----------
 .../staging/rtl8192e/rtl8192e/rtl_eeprom.c    |  2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
index 41faeb4b9b9b..671a64b04a8b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
@@ -17,7 +17,7 @@ void rtl92e_cam_reset(struct net_device *dev)
 {
 	u32 ulcommand = 0;
 
-	ulcommand |= BIT31|BIT30;
+	ulcommand |= BIT31 | BIT30;
 	rtl92e_writel(dev, RWCAM, ulcommand);
 }
 
@@ -40,7 +40,6 @@ void rtl92e_enable_hw_security_config(struct net_device *dev)
 		SECR_value |= SCR_TxUseDK;
 	}
 
-
 	ieee->hwsec_active = 1;
 	if ((ieee->pHTInfo->iot_action & HT_IOT_ACT_PURE_N_MODE) || !hwwep) {
 		ieee->hwsec_active = 0;
@@ -100,33 +99,33 @@ void rtl92e_set_key(struct net_device *dev, u8 EntryNo, u8 KeyIndex,
 	}
 
 	if (DefaultKey)
-		usConfig |= BIT15 | (KeyType<<2);
+		usConfig |= BIT15 | (KeyType << 2);
 	else
-		usConfig |= BIT15 | (KeyType<<2) | KeyIndex;
+		usConfig |= BIT15 | (KeyType << 2) | KeyIndex;
 
 
 	for (i = 0; i < CAM_CONTENT_COUNT; i++) {
 		TargetCommand  = i + CAM_CONTENT_COUNT * EntryNo;
-		TargetCommand |= BIT31|BIT16;
+		TargetCommand |= BIT31 | BIT16;
 
 		if (i == 0) {
-			TargetContent = (u32)(*(MacAddr+0)) << 16 |
-				(u32)(*(MacAddr+1)) << 24 |
+			TargetContent = (u32)(*(MacAddr + 0)) << 16 |
+				(u32)(*(MacAddr + 1)) << 24 |
 				(u32)usConfig;
 
 			rtl92e_writel(dev, WCAMI, TargetContent);
 			rtl92e_writel(dev, RWCAM, TargetCommand);
 		} else if (i == 1) {
-			TargetContent = (u32)(*(MacAddr+2)) |
-				(u32)(*(MacAddr+3)) <<  8 |
-				(u32)(*(MacAddr+4)) << 16 |
-				(u32)(*(MacAddr+5)) << 24;
+			TargetContent = (u32)(*(MacAddr + 2)) |
+				(u32)(*(MacAddr + 3)) <<  8 |
+				(u32)(*(MacAddr + 4)) << 16 |
+				(u32)(*(MacAddr + 5)) << 24;
 			rtl92e_writel(dev, WCAMI, TargetContent);
 			rtl92e_writel(dev, RWCAM, TargetCommand);
 		} else {
 			if (KeyContent != NULL) {
 				rtl92e_writel(dev, WCAMI,
-					      (u32)(*(KeyContent+i-2)));
+					      (u32)(*(KeyContent + i - 2)));
 				rtl92e_writel(dev, RWCAM, TargetCommand);
 				udelay(100);
 			}
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c b/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
index 59532ed2156d..db57c655c695 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
@@ -79,6 +79,6 @@ u32 rtl92e_eeprom_read(struct net_device *dev, u32 addr)
 		ret = _rtl92e_eeprom_xfer(dev, (addr & 0x3F) | (0x6 << 6), 9);
 
 	rtl92e_writeb(dev, EPROM_CMD,
-		      (EPROM_CMD_NORMAL<<EPROM_CMD_OPERATING_MODE_SHIFT));
+		      (EPROM_CMD_NORMAL << EPROM_CMD_OPERATING_MODE_SHIFT));
 	return ret;
 }
-- 
2.34.1

