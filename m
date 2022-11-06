Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA4761E01D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 04:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiKFDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 23:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKFDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 23:13:55 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4626361
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 20:13:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b11so7721588pjp.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnBAG5nSkYnNoSht4YTz5XeCkVWk1xhgWCiV2ObcvEs=;
        b=MDnjiNv4Dn8uGBhi8DssUBjGvoLCw3Al/b15KB1bJ2iv88AEJpeUlVpEdRLqDxg3Pf
         z7nvAXUZSXTxR2EvI3B0QBO9Syl1KGKKsTgbvpcpzQ7fB9BoG4nFJnZ5S1/LEhifmtRQ
         HjZaKPYuh723l9p+RTArEwKS5mfKpc/l4LJKlEgD6N16f9AZZtMS/iQQOfuM+Thd1BSR
         o4SkWj0pWzYhDTrJLLFZSiqf9kUA6nTYewyJ2vhixtOfhK8tVdgC8nW82NZqvi0Dkjvo
         PtcLg1LjuDTjs9XP727qFpDXkZBlFu7iXwlmfXoMc5d43d3f6i1pEJiv7VXg7+J+YpIn
         wUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnBAG5nSkYnNoSht4YTz5XeCkVWk1xhgWCiV2ObcvEs=;
        b=2STf6RLc+oBdTcqBu3rUO71l3t7Mpc1emkz7d1ru6HtyYJ648F2f4BDZsIk2pZosBw
         5LdqUbSJR+4BHYdkOsjhlzLfJxUNK6OLtB77eJ4Ybiel2eAwV+3eKBaUgDOTH9QGzkqt
         As62eaRlN4iU7bI+qbtXhalRHm/UbXdZ9DUE0OezyOQtWnn/7pxTZGGrx+/w4eW1ey3B
         M3rNZsYohwYlSNb7MfY1KnW5+T7yw5f/UXXgYy3VeP7RmMcPyVP3JvQ0aXTlH4Z1QVyz
         gAud40hhGdmYpt5lpaT85EFAI5OJuAqrJk9F6vHmEbGgCIi3YSEZaRl/bOW7uNxQLKwb
         pHjA==
X-Gm-Message-State: ACrzQf1J8PUtGfT0EzyjfuMpLW0rdGzaWygXDLf9cRvDoUfeTw86ovVR
        zOanvRd0OX1uckrSj1ADZJAP8OD40HJhWfp7
X-Google-Smtp-Source: AMsMyM58P16sJYcLNz0N5Iqu1zh132kXc3ByRj/DjtHGDhcPvYgxL9lv4IM46fntarWuEDZzep1bFg==
X-Received: by 2002:a17:902:e811:b0:186:8a61:ea76 with SMTP id u17-20020a170902e81100b001868a61ea76mr44127253plg.10.1667704434136;
        Sat, 05 Nov 2022 20:13:54 -0700 (PDT)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id c195-20020a621ccc000000b00550724f8ea0sm1885242pfc.128.2022.11.05.20.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 20:13:53 -0700 (PDT)
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     joe@perches.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8192e: rename r8192E_hwimg.c/h to table.c/h
Date:   Sun,  6 Nov 2022 14:13:39 +1100
Message-Id: <9bb563727915e3f3edd863837608336b99564462.1667704057.git.jacob.bai.au@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667704057.git.jacob.bai.au@gmail.com>
References: <cover.1667704057.git.jacob.bai.au@gmail.com>
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

