Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6D720ED1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 10:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjFCIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjFCIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 04:52:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453B1A6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 01:52:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso46084766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685782375; x=1688374375;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4hgS0z3Yb2ht0d9NIqGTFCpoZ1x1i+4zbGIDoMkc6Y=;
        b=NGlf2px41l0Jptg/BEuTtXeFKZSOTbzOb7uIMg0+F9zRMkAeS5c8harZLvyPrigwLj
         cBWyQLYM9oW80MW+ylYl7Re6NI7A0zOWqGKEc9HLrl+tdsAttpDgnCZc27CqhbA9OKGX
         MGjcSoyespZgg17K0ioFU74P6qz4wbD30R2HL0t/kP+I0YOmtWgmmkSt6qzXvrN+uUSZ
         QAOCWdvCWkS0eFsym7jWY4ceszKZQyDgOc+wlJc7bdwMcNqikdAxu31fHQ984XYSkl75
         xmpfKbYqG975vJV6Mr0N8FXOCt1Iuhz+IQ8mz025VB/pRQThTG9l7ym7D4LE1HZwcOzL
         NY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685782375; x=1688374375;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4hgS0z3Yb2ht0d9NIqGTFCpoZ1x1i+4zbGIDoMkc6Y=;
        b=k2ayQopAqB+3Je6M6fsps4Mz+yoBPOhq/pOkMH6UN4ukleTbKK8+HD8U0nBGYSWhnT
         mRSFICNrFXiNSg+YUlwZ0n2Yor0sbxpbkiRMx+ehBInGAuxSK8DxKDx9/zGZ/ozrFCYh
         dvLLF+nLKal1LWrI5n8YD665zlAvhPoFYzhY9ZbZ4X3ihDz4gZ1pCcSatL9nPGogteEU
         YngXZu6TIweuhEDxbI+fSIrImmbdcPbEjP+gkFKYkVyHcXluuKe2QOxVtuJKt4Hjf2OL
         uCDe1iYacvHAsD767dLlds08RF6TSVik0Sf90x2LOawFJBRqihkrf6cdUMJ5QqdhoVqv
         tzKg==
X-Gm-Message-State: AC+VfDzvPYeWe6qpxx/X87deC055w1Sy6J82nCrKaMcESzu4nyuf44gf
        qT/cAgsOyOlzgic8kjFom6M=
X-Google-Smtp-Source: ACHHUZ7Qpe56vScU/lUgvpUydKDfzUVjExfLo3Q+4U2pASUlgYYwZUzBWSkCgyxRI51V+NpwsirmjQ==
X-Received: by 2002:a05:6402:5203:b0:502:1f7b:f069 with SMTP id s3-20020a056402520300b005021f7bf069mr9789976edd.2.1685782374597;
        Sat, 03 Jun 2023 01:52:54 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id bm11-20020a0564020b0b00b00514b2717ec6sm1562599edb.28.2023.06.03.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 01:52:53 -0700 (PDT)
Date:   Sat, 3 Jun 2023 10:52:51 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Add cfg80211.h and remove defined
 variables
Message-ID: <20230603085251.GA20230@matrix-ESPRIMO-P710>
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

Add cfg80211 and remove defined variables rfc1042_header and
bridge_tunnel_header as they are then already defined. Usage of cfg80211
is required to merge driver into wireless subsystem.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e
---
 drivers/staging/rtl8192e/rtllib.h    |  1 +
 drivers/staging/rtl8192e/rtllib_rx.c | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index f2903b14b793..cdd7fdc5befe 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -38,6 +38,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/if_arp.h> /* ARPHRD_ETHER */
+#include <net/cfg80211.h>
 #include <net/lib80211.h>
 
 #define MAX_PRECMD_CNT 16
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index d44bf261de54..46c77ed335ab 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -225,18 +225,6 @@ rtllib_rx_frame_mgmt(struct rtllib_device *ieee, struct sk_buff *skb,
 	return 0;
 }
 
-/* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation
- * Ethernet-II snap header (RFC1042 for most EtherTypes)
- */
-static unsigned char rfc1042_header[] = {
-	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
-};
-
-/* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
-static unsigned char bridge_tunnel_header[] = {
-	0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8
-};
-
 /* No encapsulation header if EtherType < 0x600 (=length) */
 
 /* Called by rtllib_rx_frame_decrypt */
-- 
2.40.1

