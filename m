Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5E60D08B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiJYP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbiJYP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:27:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953BFC6F8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:27:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y14so13429571ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAIASaoPwKOd2K2UD51GdY0bUKSPTzt/tEd6ugp5PFI=;
        b=AMVvZtX+f9Gp3mF8gWPcs1OWIdb3qUdoAF9P2Ra6I22RysdOgamZzLdDHSjhoxA3Ev
         9AeqLkvyL5UPnsFtNc96XZooiaLDQtqyBjyZf8CDxKEHrtko2lcvo+HfdGTsdrwi1TlP
         d1rU8u7s2GepDkCtgT41qvBQSuSzbKdtTVhX3CrHuP7MBaMvol5kcUGKehAGkx/d4c7n
         uoFg+6aMukegi4NNYFvzFYLtzjbWFPH4BZ9NT4A2Sn2qKTOB+WaQeHGDXzmgHapxmYpe
         2zLtofq4LefGql5O1DubVb4gfyLHdImnSoDe+4s4oOLfTPhywf07VnjK3vvwiqlRzzT9
         TGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAIASaoPwKOd2K2UD51GdY0bUKSPTzt/tEd6ugp5PFI=;
        b=VFvVpiTAPBooH08NUC61i2GgCo15uaUFEIL0OWb+Ra6csEaXG3plt8f4pMf8ze8Ayt
         +/uLzeg8MSIqRSia3DguhdmraFBAScrZUQnoWVAhkomoRSWzjct9ZzfEQmp0AQxahfbt
         CP3J3M7LxY7xJ1LM3UUv3BZfnOQ9w1TPxI222vSYcvR11OaYnM6q9MaX7SvH3qswJ0+F
         xAhrrhDB5sSm3bCjuoGNz4aaiAnlXDv0DVNLH8ZbwHUIgVn7WiiCljuXrLr3oAtuefjQ
         m1y2P6gq1q3CkRuZy9g24FV/ax1glS6/5Q029Ot6y6IloOumGDN3qjYXgh1oUUA26L0I
         W11g==
X-Gm-Message-State: ACrzQf0NMdp8nej56GzHJCy0qGu62BXseP9QWGmB4eCzyk8EJgJ8CpD4
        oSyr/QhAHc/UA5E9752sM3iNVMwrPqQ=
X-Google-Smtp-Source: AMsMyM72baFdmcAttN7eThpBmU9kv8HCx3wPwc6HUuq4zlCQg6eLRTYbbZGvllUyVoh8vq+bbEwjWA==
X-Received: by 2002:a17:907:6e03:b0:78e:1c82:1f2a with SMTP id sd3-20020a1709076e0300b0078e1c821f2amr31966702ejc.611.1666711665780;
        Tue, 25 Oct 2022 08:27:45 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb7f.dynamic.kabel-deutschland.de. [95.90.187.127])
        by smtp.gmail.com with ESMTPSA id b19-20020a50ccd3000000b00459cf672a65sm1820560edj.71.2022.10.25.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:27:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused macros from wifi.h
Date:   Tue, 25 Oct 2022 17:27:22 +0200
Message-Id: <20221025152722.14926-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
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

There are some unused macros in wifi.h. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/wifi.h | 27 --------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 381385a7e118..05f8b7e3ecb0 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -140,7 +140,6 @@ enum WIFI_REG_DOMAIN {
 #define _PWRMGT_	BIT(12)
 #define _MORE_DATA_	BIT(13)
 #define _PRIVACY_	BIT(14)
-#define _ORDER_		BIT(15)
 
 #define SetToDs(pbuf)	\
 	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_)
@@ -187,17 +186,6 @@ enum WIFI_REG_DOMAIN {
 		*(__le16 *)(pbuf) |= cpu_to_le16(type); \
 	} while (0)
 
-#define GetTupleCache(pbuf)			\
-	(cpu_to_le16(*(unsigned short *)((size_t)(pbuf) + 22)))
-
-#define SetFragNum(pbuf, num) \
-	do {    \
-		*(unsigned short *)((size_t)(pbuf) + 22) = \
-			((*(unsigned short *)((size_t)(pbuf) + 22)) &	\
-			le16_to_cpu(~(0x000f))) | \
-			cpu_to_le16(0x0f & (num));     \
-	} while (0)
-
 #define SetSeqNum(pbuf, num) \
 	do {    \
 		*(__le16 *)((size_t)(pbuf) + 22) = \
@@ -221,13 +209,6 @@ enum WIFI_REG_DOMAIN {
 
 #define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
 
-#define SetAMsdu(pbuf, amsdu)	\
-	*(__le16 *)(pbuf) |= cpu_to_le16((amsdu & 1) << 7)
-
-#define GetTid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) +	\
-			(((GetToDs(pbuf)<<1) | GetFrDs(pbuf)) == 3 ?	\
-			30 : 24))) & 0x000f)
-
 #define GetAddr1Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 4))
 
 #define GetAddr2Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 10))
@@ -415,14 +396,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 				Below is the definition for 802.11n
 ------------------------------------------------------------------------------*/
 
-#define SetOrderBit(pbuf)	\
-	do	{	\
-		*(unsigned short *)(pbuf) |= cpu_to_le16(_ORDER_); \
-	} while (0)
-
-#define GetOrderBit(pbuf)			\
-	(((*(unsigned short *)(pbuf)) & le16_to_cpu(_ORDER_)) != 0)
-
 /**
  * struct rtw_ieee80211_bar - HT Block Ack Request
  *
-- 
2.38.0

