Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC355F21C0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 09:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJBHs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJBHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:48:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F102AE0B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 00:48:49 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y8so10866253edc.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=w+EWhQ/spGU7Ku7CRdrNSboZT6E/J8iiRvKE32O8saI=;
        b=B4KhHBB0VlRi4Wqe3ZxycoZkgdRkGgdABoqeX87nPUnLh5kfybH1xYSqKJDenZ7U5v
         tlUccxpIaExWL7joyMlrZj0WxmDXo1KFZ8FEpUKRZwLJpoFw73qy9O/phAFSFJU2KSCa
         OuTLqBKjn+MD/cpscCn33HdqZnXiug6Exq37sQvi1LNl9wsYwuQeCRh+RBefTL+OIlBM
         YlzleyygGEyDF1hovX6sFF6pZMgN2cU1KX9n17T1Yuuqcj+vref2ONK9P0cYgtckzWt6
         qzikF3k02A9UKOTrRGWmcXP+574gDN0eqhx7z+9S2iWm1aVZXIlSRIvx1o6/bAc+T6o9
         Delw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w+EWhQ/spGU7Ku7CRdrNSboZT6E/J8iiRvKE32O8saI=;
        b=yGHWiuuEozRxP8PJGuCIuwty9X8Qd4bt9ouLymxcvvFKR1OeqNG+BasL6r9H4lIHWC
         amCO8BqYUtYkqWniE6cUuwKWWMUBrrPH89Xzxm89rf2mjbDiPHHrzkrk3ZP9rNmZxNCB
         K653gbn+x3d5g0EMSqLc9HPGupkPfzAHXBgCTaQUyUqKvTJ+EEoE/zKMDe2e2iyO4PUm
         UIX0u1ujjRzf6ZNLbN7JVj6I+XL7lnPqMr1zryPM6I9mPaA/x7LuQyHgHzbTHEOTf5sX
         eORxEAto7dn8XGAifXkojbSFbnCM+txF4nxBDhnrZo4AxM/xOB3iMAOfKQcnHixfHiyi
         5ALA==
X-Gm-Message-State: ACrzQf1Z7BaocXgNWvh4AAd3OeVehANSz0/FX6m51ySQXBQLAnPV3sBj
        nB4At3sj1pQ+LckuVEs33dg=
X-Google-Smtp-Source: AMsMyM6unR/8rXfKlWjqDnUQZhBl+DfICMc7oVL+kzOWeow7f43gxUO3rz73V4jXfEs6UK8M0JTtqw==
X-Received: by 2002:a05:6402:34d5:b0:451:335c:2f1e with SMTP id w21-20020a05640234d500b00451335c2f1emr13944586edc.160.1664696927700;
        Sun, 02 Oct 2022 00:48:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb59.dynamic.kabel-deutschland.de. [95.90.187.89])
        by smtp.gmail.com with ESMTPSA id q26-20020a17090676da00b0077ce503bd77sm3608536ejn.129.2022.10.02.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 00:48:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: merge odm_types.h into other headers
Date:   Sun,  2 Oct 2022 09:48:23 +0200
Message-Id: <20221002074827.8566-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221002074827.8566-1-straube.linux@gmail.com>
References: <20221002074827.8566-1-straube.linux@gmail.com>
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

The macros SET_TX_DESC_ANTSEL_{A,B,C}_88E are used in odm_RTL8188E.c.
Move them from odm_types.h to odm_RTL8188E.h.

ODM_CE is used in places where also ODM_ITRF_USB is used in the code.
Move the ODM_CE define to the header that defines ODM_ITRF_USB. While
at it remove an extra space between '#' and 'define ODM_ITRF_USB'.

The haeder odm_types.h is now empty and we can remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h          |  3 ++-
 drivers/staging/r8188eu/include/odm_RTL8188E.h |  7 +++++++
 drivers/staging/r8188eu/include/odm_types.h    | 16 ----------------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  1 -
 4 files changed, 9 insertions(+), 18 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_types.h

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index f131e17167bf..89b01dd614ba 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -119,7 +119,8 @@ enum odm_ability_def {
 	ODM_BB_PWR_TRA			= BIT(8),
 };
 
-# define ODM_ITRF_USB 0x2
+#define ODM_ITRF_USB	0x2
+#define ODM_CE		0x04
 
 /*  ODM_CMNINFO_WM_MODE */
 enum odm_wireless_mode {
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
index 3c6471f1a893..4f16af248591 100644
--- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
@@ -11,6 +11,13 @@
 #define	MAIN_ANT_CGCS_RX	0
 #define	AUX_ANT_CGCS_RX	1
 
+#define SET_TX_DESC_ANTSEL_A_88E(__ptxdesc, __value)			\
+	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(24))
+#define SET_TX_DESC_ANTSEL_B_88E(__ptxdesc, __value)			\
+	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(25))
+#define SET_TX_DESC_ANTSEL_C_88E(__ptxdesc, __value)			\
+	le32p_replace_bits((__le32 *)(__ptxdesc + 28), __value, BIT(29))
+
 void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *pDM_Odm);
 
 void ODM_AntennaDiversity_88E(struct odm_dm_struct *pDM_Odm);
diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
deleted file mode 100644
index 76302df4b330..000000000000
--- a/drivers/staging/r8188eu/include/odm_types.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __ODM_TYPES_H__
-#define __ODM_TYPES_H__
-
-#define	ODM_CE			0x04	/* BIT(2) */
-
-#define SET_TX_DESC_ANTSEL_A_88E(__ptxdesc, __value)			\
-	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(24))
-#define SET_TX_DESC_ANTSEL_B_88E(__ptxdesc, __value)			\
-	le32p_replace_bits((__le32 *)(__ptxdesc + 8), __value, BIT(25))
-#define SET_TX_DESC_ANTSEL_C_88E(__ptxdesc, __value)			\
-	le32p_replace_bits((__le32 *)(__ptxdesc + 28), __value, BIT(29))
-
-#endif /*  __ODM_TYPES_H__ */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index ed4091e7cc7e..a1e88e6d5c0c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -14,7 +14,6 @@
 #include "rtl8188e_xmit.h"
 #include "rtl8188e_cmd.h"
 #include "rtw_efuse.h"
-#include "odm_types.h"
 #include "odm.h"
 #include "odm_HWConfig.h"
 #include "odm_RegDefine11N.h"
-- 
2.37.3

