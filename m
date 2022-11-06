Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4440761DFDF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 02:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKFBMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 21:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKFBL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 21:11:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56572B7D2
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 18:11:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z26so7678391pff.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 18:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnBAG5nSkYnNoSht4YTz5XeCkVWk1xhgWCiV2ObcvEs=;
        b=lW7v+vxutC9KnziINrPnozsp2OexsfiArX3ciL3rtIPuwmcRtMPqUoI33uM2hPFBcU
         41m0Yt97lOioui8b6CMl4t/NZ3nJDWn9A5nUW3navTpKK1zHTfeCjTcLxrPPrrrKtAHU
         MeOtNpYpfVXLS596L0awmAPAV+K2XWdl53DgrTUyVZGRgto1qu57IfbTa5tWyXKCAYsT
         R6gLk4EAKhMMH1jajEvk617PmprY3Z+4OEfRyHLi7w6by0u7nM5+5x/8yNaBosyv0c10
         tA+x9coWlUp6OHBXWcF+axhBGOmz47nnVZkBnuUluA47rCbXRKuLPFxsiFfSGlWZ10NX
         1XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnBAG5nSkYnNoSht4YTz5XeCkVWk1xhgWCiV2ObcvEs=;
        b=AaHySi4YDLxBb17ZtT87+Jfz7h9cnQGtyCQ0ppRWkVAVpUggwwiHXJWUZ5TgevxYPn
         C67FmEJDIa15wUDh3hTMPr1qeV/tJvR/vfHhORQFzi5hY9i7WPiZo3dp/VgOFsLzfXgC
         +3/OAbH1rBV0ZeTsPi+hD9d15DmSsPdCFi1kvDXjcaCIAeMn49dKkJ1UL679c+usI7tv
         o6vgV2ArGG7sR1r8O+vWpek8mDuSG9c38wWKWaqh6SEJT2QVTz29oTNSqVTXqZeSjxZL
         xzIueTDOmFTMT/xikd2groRQ9tyvZVr70zEcvt0kr2bBscHsjf1sflXNtzY+aU7m+6On
         VOkA==
X-Gm-Message-State: ACrzQf0JTpy9XTDXpUeBVl3k6bgV/YVMdsRkU1GeR0Q/lswwjyu64lTy
        L+27MjnQDKP7pkCeq229P6XROsmHYB8fM6NE
X-Google-Smtp-Source: AMsMyM5sP2XDMQv6rZwnCdwEOzRoXLcDRR6MJty+e/Lw0zZrZ4j+5uwR7BKsbzp0Jyb3Uv81i7EvdQ==
X-Received: by 2002:aa7:83c8:0:b0:56d:8e07:4618 with SMTP id j8-20020aa783c8000000b0056d8e074618mr31473453pfn.33.1667697117807;
        Sat, 05 Nov 2022 18:11:57 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902714d00b00186b9196cbesm2222806plm.249.2022.11.05.18.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 18:11:57 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jacob Bai <jacob.bai.au@gmail.com>
Subject: [PATCH v2 2/3] staging: rtl8192e: rename r8192E_hwimg.c/h to table.c/h
Date:   Sun,  6 Nov 2022 12:11:44 +1100
Message-Id: <9bb563727915e3f3edd863837608336b99564462.1667694826.git.jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667694826.git.jacob.bai.au@gmail.com>
References: <cover.1667694826.git.jacob.bai.au@gmail.com>
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

Same as other rtlwifi drivers, use table.c/h.

Signed-off-by: Jacob Bai <jacob.bai.au@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/Makefile                    | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c           | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c                | 2 +-
 drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c} | 2 +-
 drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.h => table.h} | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c} (99%)
 rename drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.h => table.h} (94%)

diff --git a/drivers/staging/rtl8192e/rtl8192e/Makefile b/drivers/staging/rtl8192e/rtl8192e/Makefile
index 75e6ec510555..334d92efd4ba 100644
--- a/drivers/staging/rtl8192e/rtl8192e/Makefile
+++ b/drivers/staging/rtl8192e/rtl8192e/Makefile
@@ -4,7 +4,7 @@ r8192e_pci-objs :=		\
 	r8192E_phy.o		\
 	r8192E_firmware.o	\
 	r8192E_cmdpkt.o		\
-	r8192E_hwimg.o		\
+	table.o		\
 	r8190P_rtl8256.o	\
 	rtl_cam.o		\
 	rtl_core.o		\
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
index 789d288d7503..45819f2f2a37 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
@@ -6,7 +6,7 @@
  */
 #include "rtl_core.h"
 #include "r8192E_hw.h"
-#include "r8192E_hwimg.h"
+#include "table.h"
 #include "r8192E_firmware.h"
 #include "r8192E_cmdpkt.h"
 #include <linux/firmware.h>
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 58da2dab55bd..eabb4187d907 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -12,7 +12,7 @@
 #include "r8192E_phy.h"
 #include "rtl_dm.h"
 
-#include "r8192E_hwimg.h"
+#include "table.h"
 
 static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
 	0,
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c b/drivers/staging/rtl8192e/rtl8192e/table.c
similarity index 99%
rename from drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
rename to drivers/staging/rtl8192e/rtl8192e/table.c
index 8920283f340e..2e75f40db874 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.c
+++ b/drivers/staging/rtl8192e/rtl8192e/table.c
@@ -4,7 +4,7 @@
  *
  * Contact Information: wlanfae <wlanfae@realtek.com>
  */
-#include "r8192E_hwimg.h"
+#include "table.h"
 
 u32 RTL8192E_PHY_REG_ARRAY[RTL8192E_PHY_REG_ARRAY_LEN] = {0x0,};
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h b/drivers/staging/rtl8192e/rtl8192e/table.h
similarity index 94%
rename from drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
rename to drivers/staging/rtl8192e/rtl8192e/table.h
index a436c089a779..a80176c47127 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -4,8 +4,8 @@
  *
  * Contact Information: wlanfae <wlanfae@realtek.com>
  */
-#ifndef __INC_HAL8192PciE_FW_IMG_H
-#define __INC_HAL8192PciE_FW_IMG_H
+#ifndef __RTL8192E_TABLE__H_
+#define __RTL8192E_TABLE__H_
 
 /*Created on  2008/11/18,  3: 7*/
 
-- 
2.34.1

